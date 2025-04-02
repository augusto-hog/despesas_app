// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:despesas_app/common/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

import '../../common/features/transaction/transaction.dart';

import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/extensions/date_formatter.dart';
import '../../common/extensions/sizes.dart';
import '../../common/models/transaction_model.dart';
import '../../common/utils/money_mask_controller.dart';
import '../../common/widgets/app_header.dart';
import '../../common/widgets/custom_circular_progress_indicator.dart';
import '../../common/widgets/custom_text_form_field.dart';
import '../../common/widgets/primary_button.dart';
import '../../locator.dart';

class TransactionPage extends StatefulWidget {
  final TransactionModel? transaction;
  const TransactionPage({
    super.key,
    this.transaction,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> with SingleTickerProviderStateMixin, CustomSnackBar {
  final _transactionController = locator.get<TransactionController>();

  final _formKey = GlobalKey<FormState>();

  final _incomes = ['Serviços', 'Investimento', 'Outros'];
  final _outcomes = ['Casa', 'Mercado', 'Outros'];

  DateTime? _newDate;
  bool value = false;

  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _dateController = TextEditingController();
  final _amountController = MoneyMaskedTextController(prefix: 'R\$');

  late final TabController _tabController;

  int get _initialIndex {
    if (widget.transaction != null && widget.transaction!.value.isNegative) {
      return 1;
    }

    return 0;
  }

  String get _date {
    if (widget.transaction?.date != null) {
      return DateTime.fromMillisecondsSinceEpoch(widget.transaction!.date).toText;
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    _amountController.updateValue(widget.transaction?.value ?? 0);

    value = widget.transaction?.status ?? false;

    _descriptionController.text = widget.transaction?.description ?? '';
    _categoryController.text = widget.transaction?.category ?? '';
    _newDate = DateTime.fromMillisecondsSinceEpoch(widget.transaction?.date ?? 0);
    _dateController.text =
        widget.transaction?.date != null ? DateTime.fromMillisecondsSinceEpoch(widget.transaction!.date).toText : '';

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: _initialIndex,
    );

    _transactionController.addListener(() {
      if (_transactionController.state is TransactionStateLoading) {
        if (!mounted) return;

        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
      }
      if (_transactionController.state is TransactionStateSuccess) {
        if (!mounted) return;

        Navigator.of(context).pop();
      }
      if (_transactionController.state is TransactionStateError) {
        if (!mounted) return;

        final error = _transactionController.state as TransactionStateError;
        showCustomSnackBar(
          context: context,
          text: error.message,
          type: SnackBarType.error,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppHeader(
            title: widget.transaction != null ? 'Editar Transação' : 'Nova Transação',
          ),
          Positioned(
            top: 164.h,
            left: 28.w,
            right: 28.w,
            bottom: 16.h,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      StatefulBuilder(
                        builder: (context, setState) {
                          return TabBar(
                            labelPadding: EdgeInsets.zero,
                            controller: _tabController,
                            onTap: (_) {
                              if (_tabController.indexIsChanging) {
                                setState(() {});
                              }
                              if (_tabController.indexIsChanging && _categoryController.text.isNotEmpty) {
                                _categoryController.clear();
                              }
                            },
                            tabs: [
                              Tab(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _tabController.index == 0 ? AppColors.darkWhite : AppColors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Receita',
                                    style: AppTextStyles.mediumText16w500.apply(color: AppColors.darkGrey),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _tabController.index == 1 ? AppColors.darkWhite : AppColors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Gasto',
                                    style: AppTextStyles.mediumText16w500.apply(color: AppColors.darkGrey),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextFormField(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        labelText: "Valor",
                        hintText: "Digite o valor",
                        suffixIcon: StatefulBuilder(
                          builder: (context, setState) {
                            return IconButton(
                              onPressed: () {
                                setState(() {
                                  value = !value;
                                });
                              },
                              icon: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                transitionBuilder: (child, animation) {
                                  return RotationTransition(
                                    turns: Tween(begin: 0.5, end: 1.0).animate(animation), // Faz o giro suave
                                    child: child,
                                  );
                                },
                                child: Icon(
                                  value
                                      ? Icons.thumb_up_alt_rounded
                                      : Icons.thumb_up_off_alt_rounded, // Alterna entre os ícones
                                  key: ValueKey<bool>(value), // Necessário para o AnimatedSwitcher
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      CustomTextFormField(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _descriptionController,
                        labelText: 'Descrição',
                        hintText: 'Insira a Descrição',
                        validator: (value) {
                          if (_descriptionController.text.isEmpty) {
                            return 'Esse campo não pode ser vazio.';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _categoryController,
                        readOnly: true,
                        labelText: "Categoria",
                        hintText: "Selecione uma categoria",
                        validator: (value) {
                          if (_categoryController.text.isEmpty) {
                            return 'Esse campo não pode ser vazio.';
                          }
                          return null;
                        },
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: (_tabController.index == 0 ? _incomes : _outcomes)
                                .map(
                                  (e) => TextButton(
                                    onPressed: () {
                                      _categoryController.text = e;
                                      Navigator.pop(context);
                                    },
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        controller: _dateController,
                        readOnly: true,
                        suffixIcon: const Icon(Icons.calendar_month_outlined),
                        labelText: "Data",
                        hintText: "Selecione uma data",
                        validator: (value) {
                          if (_dateController.text.isEmpty) {
                            return 'Esse campo não pode ser vazio.';
                          }
                          return null;
                        },
                        onTap: () async {
                          _newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1970),
                            lastDate: DateTime(2030),
                          );

                          _newDate = _newDate != null
                              ? DateTime.now().copyWith(
                                  day: _newDate?.day,
                                  month: _newDate?.month,
                                  year: _newDate?.year,
                                )
                              : null;

                          _dateController.text = _newDate != null ? _newDate!.toText : _date;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: PrimaryButton(
                          text: widget.transaction != null ? 'Salvar' : 'Adicionar',
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              final newValue = double.parse(
                                  _amountController.text.replaceAll('\$', '').replaceAll('.', '').replaceAll(',', '.'));

                              final now = DateTime.now().millisecondsSinceEpoch;

                              final newTransaction = TransactionModel(
                                category: _categoryController.text,
                                description: _descriptionController.text,
                                value: _tabController.index == 1 ? newValue * -1 : newValue,
                                date: _newDate != null ? _newDate!.millisecondsSinceEpoch : now,
                                createdAt: widget.transaction?.createdAt ?? now,
                                status: value,
                                id: widget.transaction?.id,
                              );
                              if (widget.transaction == newTransaction) {
                                Navigator.pop(context);
                                return;
                              }
                              if (widget.transaction != null) {
                                await _transactionController.updateTransaction(newTransaction);
                                if (mounted) {
                                  Navigator.of(context).pop(true);
                                }
                              } else {
                                await _transactionController.addTransaction(newTransaction);
                                if (mounted) {
                                  Navigator.of(context).pop(true);
                                }
                              }
                            } else {
                              log('invalido');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
