import 'package:despesas_app/common/constants/app_colors.dart';
import 'package:despesas_app/common/constants/app_text_styles.dart';
import 'package:despesas_app/common/widgets/primary_button.dart';
import 'package:flutter/material.dart';

Future<void> customModalBottomSheet({
  required BuildContext context,
  required String content,    // Parâmetro para o texto de erro
  required String buttonText, // Parâmetro para o texto do botão
}) {
  return showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(38),
        topRight: Radius.circular(38),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(38),
            topRight: Radius.circular(38),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16), // Ajuste de padding
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ajusta o tamanho da coluna ao conteúdo
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              content, // Exibe o conteúdo da mensagem de erro
              style: AppTextStyles.mediumText20.copyWith(
                color: AppColors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16), // Espaçamento entre o texto e o botão
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                color: Colors.transparent, // Faz o fundo do Material ser transparente
                child: PrimaryButton(
                  text: buttonText, // Usa o texto fornecido como label do botão
                  onPressed: () => Navigator.pop(context), // Ação do botão
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
