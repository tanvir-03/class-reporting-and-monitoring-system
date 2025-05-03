import { auditColumns } from "./audit_columns";
import { user } from "./auth";
import { ulid } from "ulid";
import {
	sqliteTable,
	text,
	integer,
	index,
	unique,
} from "drizzle-orm/sqlite-core";

export const batch = sqliteTable("batch", {
	id: text("id")
		.primaryKey()
		.$defaultFn(() => ulid()),
	name: text("name").notNull().unique(),
	startDate: text("start_date").notNull(),
	endDate: text("end_date"),
	...auditColumns,
});

export const department = sqliteTable("department", {
	id: text("id")
		.primaryKey()
		.$defaultFn(() => ulid()),
	name: text("name").notNull().unique(),
	...auditColumns,
});

export const designation = sqliteTable("designation", {
	id: text("id")
		.primaryKey()
		.$defaultFn(() => ulid()),
	title: text("title").notNull().unique(),
	...auditColumns,
});

export const teacher = sqliteTable(
	"teacher",
	{
		id: text("id")
			.primaryKey()
			.$defaultFn(() => ulid()),
		userId: text("user_id")
			.notNull()
			.unique()
			.references(() => user.id),
		metricId: text("metric_id").notNull().unique(),
		departmentId: text("department_id").references(() => department.id),
		designationId: text("designation_id").references(() => designation.id),
		...auditColumns,
	},
	(table) => ({
		departmentIdx: index("idx_teacher_department_id").on(table.departmentId),
		designationIdx: index("idx_teacher_designation_id").on(table.designationId),
	})
);

export const chairman = sqliteTable("chairman", {
	id: text("id")
		.primaryKey()
		.$defaultFn(() => ulid()),
	teacherId: text("teacher_id")
		.notNull()
		.unique()
		.references(() => teacher.id),
	departmentId: text("department_id")
		.notNull()
		.unique()
		.references(() => department.id),
	...auditColumns,
});

export const student = sqliteTable(
	"student",
	{
		id: text("id")
			.primaryKey()
			.$defaultFn(() => ulid()),
		userId: text("user_id")
			.notNull()
			.unique()
			.references(() => user.id),
		metricId: text("metric_id").notNull().unique(),
		batchId: text("batch_id")
			.notNull()
			.references(() => batch.id),
		...auditColumns,
	},
	(table) => ({
		batchIdx: index("idx_student_batch_id").on(table.batchId),
	})
);

export const course = sqliteTable("course", {
	id: text("id")
		.primaryKey()
		.$defaultFn(() => ulid()),
	code: text("code").notNull().unique(),
	title: text("title").notNull().unique(),
	...auditColumns,
});

export const section = sqliteTable("section", {
	id: text("id")
		.primaryKey()
		.$defaultFn(() => ulid()),
	name: text("name").notNull(),
	crId: text("cr_id")
		.notNull()
		.unique()
		.references(() => student.id),
	...auditColumns,
});

export const room = sqliteTable("room", {
	id: text("id")
		.primaryKey()
		.$defaultFn(() => ulid()),
	name: text("name").notNull(),
	capacity: integer("capacity").notNull(),
	...auditColumns,
});

export const slot = sqliteTable("slot", {
	id: text("id")
		.primaryKey()
		.$defaultFn(() => ulid()),
	startTime: text("start_time").notNull(),
	endTime: text("end_time").notNull(),
	...auditColumns,
});

export const classSchedule = sqliteTable(
	"class_schedule",
	{
		id: text("id")
			.primaryKey()
			.$defaultFn(() => ulid()),
		sectionId: text("section_id")
			.notNull()
			.references(() => section.id),
		courseId: text("course_id")
			.notNull()
			.references(() => course.id),
		instructorId: text("instructor_id")
			.notNull()
			.references(() => teacher.id),
		roomId: text("room_id")
			.notNull()
			.references(() => room.id),
		slotId: text("slot_id")
			.notNull()
			.references(() => slot.id),
		date: text("date").notNull(),
		status: text("status").notNull(),
		...auditColumns,
	},
	(table) => ({
		sectionIdx: index("idx_class_section_id").on(table.sectionId),
		courseIdx: index("idx_class_course_id").on(table.courseId),
		instructorIdx: index("idx_class_instructor_id").on(table.instructorId),
		roomIdx: index("idx_class_room_id").on(table.roomId),
		slotIdx: index("idx_class_slot_id").on(table.slotId),
		uniqueSchedule: unique("uq_class_schedule_section_slot_date").on(
			table.sectionId,
			table.slotId,
			table.date
		),
	})
);

export const enrollment = sqliteTable(
	"enrollment",
	{
		id: text("id")
			.primaryKey()
			.$defaultFn(() => ulid()),
		userId: text("user_id")
			.notNull()
			.references(() => user.id),
		sectionId: text("section_id")
			.notNull()
			.references(() => section.id),
		...auditColumns,
	},
	(table) => ({
		userIdx: index("idx_enroll_user_id").on(table.userId),
		sectionIdx: index("idx_enroll_section_id").on(table.sectionId),
		uniqueEnroll: unique("uq_enroll_user_section").on(
			table.userId,
			table.sectionId
		),
	})
);
