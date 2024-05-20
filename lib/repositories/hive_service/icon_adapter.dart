import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class IconDataAdapter extends TypeAdapter<IconData> {
  @override
  final int typeId = 100; // Уникальный идентификатор типа

  @override
  IconData read(BinaryReader reader) {
    // Чтение значений из бинарного потока
    return IconData(
      reader.readInt(),
      fontFamily: reader.readString(),
      fontPackage: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, IconData obj) {
    // Запись значений в бинарный поток
    writer.writeInt(obj.codePoint);
    writer.writeString(obj.fontFamily ?? '');
    writer.writeString(obj.fontPackage ?? '');
  }
}
