CREATE TABLE `batch` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`start_date` text NOT NULL,
	`end_date` text,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`deleted_at` integer,
	`updated_by` text,
	`deleted_by` text,
	FOREIGN KEY (`updated_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`deleted_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `batch_name_unique` ON `batch` (`name`);--> statement-breakpoint
CREATE TABLE `chairman` (
	`id` text PRIMARY KEY NOT NULL,
	`teacher_id` text NOT NULL,
	`department_id` text NOT NULL,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`deleted_at` integer,
	`updated_by` text,
	`deleted_by` text,
	FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`department_id`) REFERENCES `department`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`updated_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`deleted_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `chairman_teacher_id_unique` ON `chairman` (`teacher_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `chairman_department_id_unique` ON `chairman` (`department_id`);--> statement-breakpoint
CREATE TABLE `class_schedule` (
	`id` text PRIMARY KEY NOT NULL,
	`section_id` text NOT NULL,
	`course_id` text NOT NULL,
	`instructor_id` text NOT NULL,
	`room_id` text NOT NULL,
	`slot_id` text NOT NULL,
	`date` text NOT NULL,
	`status` text NOT NULL,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`deleted_at` integer,
	`updated_by` text,
	`deleted_by` text,
	FOREIGN KEY (`section_id`) REFERENCES `section`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`course_id`) REFERENCES `course`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`instructor_id`) REFERENCES `teacher`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`room_id`) REFERENCES `room`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`slot_id`) REFERENCES `slot`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`updated_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`deleted_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE INDEX `idx_class_section_id` ON `class_schedule` (`section_id`);--> statement-breakpoint
CREATE INDEX `idx_class_course_id` ON `class_schedule` (`course_id`);--> statement-breakpoint
CREATE INDEX `idx_class_instructor_id` ON `class_schedule` (`instructor_id`);--> statement-breakpoint
CREATE INDEX `idx_class_room_id` ON `class_schedule` (`room_id`);--> statement-breakpoint
CREATE INDEX `idx_class_slot_id` ON `class_schedule` (`slot_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `uq_class_schedule_section_slot_date` ON `class_schedule` (`section_id`,`slot_id`,`date`);--> statement-breakpoint
CREATE TABLE `course` (
	`id` text PRIMARY KEY NOT NULL,
	`code` text NOT NULL,
	`title` text NOT NULL,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`deleted_at` integer,
	`updated_by` text,
	`deleted_by` text,
	FOREIGN KEY (`updated_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`deleted_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `course_code_unique` ON `course` (`code`);--> statement-breakpoint
CREATE UNIQUE INDEX `course_title_unique` ON `course` (`title`);--> statement-breakpoint
CREATE TABLE `department` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`deleted_at` integer,
	`updated_by` text,
	`deleted_by` text,
	FOREIGN KEY (`updated_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`deleted_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `department_name_unique` ON `department` (`name`);--> statement-breakpoint
CREATE TABLE `designation` (
	`id` text PRIMARY KEY NOT NULL,
	`title` text NOT NULL,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`deleted_at` integer,
	`updated_by` text,
	`deleted_by` text,
	FOREIGN KEY (`updated_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`deleted_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `designation_title_unique` ON `designation` (`title`);--> statement-breakpoint
CREATE TABLE `enrollment` (
	`id` text PRIMARY KEY NOT NULL,
	`user_id` text NOT NULL,
	`section_id` text NOT NULL,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`deleted_at` integer,
	`updated_by` text,
	`deleted_by` text,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`section_id`) REFERENCES `section`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`updated_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`deleted_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE INDEX `idx_enroll_user_id` ON `enrollment` (`user_id`);--> statement-breakpoint
CREATE INDEX `idx_enroll_section_id` ON `enrollment` (`section_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `uq_enroll_user_section` ON `enrollment` (`user_id`,`section_id`);--> statement-breakpoint
CREATE TABLE `room` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`capacity` integer NOT NULL,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`deleted_at` integer,
	`updated_by` text,
	`deleted_by` text,
	FOREIGN KEY (`updated_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`deleted_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `section` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`cr_id` text NOT NULL,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`deleted_at` integer,
	`updated_by` text,
	`deleted_by` text,
	FOREIGN KEY (`cr_id`) REFERENCES `student`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`updated_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`deleted_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `section_cr_id_unique` ON `section` (`cr_id`);--> statement-breakpoint
CREATE TABLE `slot` (
	`id` text PRIMARY KEY NOT NULL,
	`start_time` text NOT NULL,
	`end_time` text NOT NULL,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`deleted_at` integer,
	`updated_by` text,
	`deleted_by` text,
	FOREIGN KEY (`updated_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`deleted_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE TABLE `student` (
	`id` text PRIMARY KEY NOT NULL,
	`user_id` text NOT NULL,
	`metric_id` text NOT NULL,
	`batch_id` text NOT NULL,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`deleted_at` integer,
	`updated_by` text,
	`deleted_by` text,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`batch_id`) REFERENCES `batch`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`updated_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`deleted_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `student_user_id_unique` ON `student` (`user_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `student_metric_id_unique` ON `student` (`metric_id`);--> statement-breakpoint
CREATE INDEX `idx_student_batch_id` ON `student` (`batch_id`);--> statement-breakpoint
CREATE TABLE `teacher` (
	`id` text PRIMARY KEY NOT NULL,
	`user_id` text NOT NULL,
	`metric_id` text NOT NULL,
	`department_id` text,
	`designation_id` text,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	`deleted_at` integer,
	`updated_by` text,
	`deleted_by` text,
	FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`department_id`) REFERENCES `department`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`designation_id`) REFERENCES `designation`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`updated_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`deleted_by`) REFERENCES `user`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `teacher_user_id_unique` ON `teacher` (`user_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `teacher_metric_id_unique` ON `teacher` (`metric_id`);--> statement-breakpoint
CREATE INDEX `idx_teacher_department_id` ON `teacher` (`department_id`);--> statement-breakpoint
CREATE INDEX `idx_teacher_designation_id` ON `teacher` (`designation_id`);