import { sqliteTable, text } from "drizzle-orm/sqlite-core";
import { auditColumns } from "./audit_columns";
import { user } from "./auth";
import { ulid } from "ulid";

export const role = sqliteTable("role", {
	id: text("id")
		.primaryKey()
		.$defaultFn(() => ulid()),
	name: text("name").notNull().unique(),
	...auditColumns,
});

export const permission = sqliteTable("permission", {
	id: text("id")
		.primaryKey()
		.$defaultFn(() => ulid()),
	name: text("name").notNull().unique(),
	...auditColumns,
});

export const rolePermission = sqliteTable("role_permission", {
	id: text("id")
		.primaryKey()
		.$defaultFn(() => ulid()),
	roleId: text("role_id")
		.notNull()
		.references(() => role.id),
	permissionId: text("permission_id")
		.notNull()
		.references(() => permission.id),
	...auditColumns,
});

export const userRole = sqliteTable("user_role", {
	id: text("id")
		.primaryKey()
		.$defaultFn(() => ulid()),
	userId: text("user_id")
		.notNull()
		.references(() => user.id),
	roleId: text("role_id")
		.notNull()
		.references(() => role.id),
	...auditColumns,
});
