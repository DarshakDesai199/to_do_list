// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_add.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAddAdapter extends TypeAdapter<TaskAdd> {
  @override
  final int typeId = 0;

  @override
  TaskAdd read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskAdd()
      ..deadline = fields[0] as DateTime?
      ..time = fields[1] as DateTime?
      ..description = fields[2] as String?
      ..title = fields[3] as String?
      ..isDeadline = fields[4] as bool?
      ..index = fields[5] as int?;
  }

  @override
  void write(BinaryWriter writer, TaskAdd obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.deadline)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.isDeadline)
      ..writeByte(5)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAddAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
