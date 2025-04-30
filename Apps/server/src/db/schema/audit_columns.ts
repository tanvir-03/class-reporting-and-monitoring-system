import { integer, text } from "drizzle-orm/sqlite-core";
import { user } from "./auth";

export const auditColumns = {
	createdAt: integer("created_at", { mode: "timestamp" }).notNull(),
	updatedAt: integer("updated_at", { mode: "timestamp" }).notNull(),
	deletedAt: integer("deleted_at", { mode: "timestamp" }),
	updatedBy: text("updated_by").references(() => user.id),
	deletedBy: text("deleted_by").references(() => user.id),
};
