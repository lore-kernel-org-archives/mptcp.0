Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745EC13AC4
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 13:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eima+7wUr1AH/aFW76SPXvU3m5Rs55u/aejFATPGsuvlDCKOjd3Y1bWOcycqM44ZEVi1V7ZPPAolqwpeyWyewDFhHgcliJzcTnK8XZ8z6ZiShlHsShBtPTfPjTOL3K1yM59QRiqQYw0uttVKV1y/CjFikICGgS+sZg/Fulbcj/4SwmZQPV2T3ad2JQTrFhhCgcWU5/nYvGiKbQxsYP0u11zscubquboIqIKNzelSPSjBrx964h4zS7gG7MTsfZqmCeugMJDUk2V2Nprf3cAi4X4jZyGmFVf5RU9L3vICjFFeC+0SiQnhbBHMMMwmJg1ULZFpBBY/GYlYsJvnSwmdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/HIBMSMYVjJoE6abaXONyU2fPy9naw0sf/o05OqpMc=;
 b=lIXp60ocBkREV5FZsR0KaqYQhPk37A7NGsSl+PYhaVBLkRGiLBMhktt6MJ83w3UXPouhe3y+PISB931U52kKnTAgWGHYFQ7vMqvVaewsfoks7jxL+9sMpiuQo9hgAkG5trlcppQMTPc0D08gXEiNEiehhMK3vt5ijFKbf/5+l2ygFA/UMaHJ3+mKCoYGxWf/CdwaIlFhBSgf8qYZEU0piZNuuUmD260ohd0889w+3EocwjAx9U9sasJEb8qwOX5lQirTkjskqryAkR7Rr0XQOBAVWf+bDXIj4ubFfaC+OTgFAnEFYcHj0tmxHCU0UQUMjzdNTXnuX1i4JIIaQJv++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/HIBMSMYVjJoE6abaXONyU2fPy9naw0sf/o05OqpMc=;
 b=sHjcogLQk6ODl8QGA/TjWpkbgRa1+alRWWrudMqztDAH3XxL5ekt4FWB+6OShv1umwQuQCTe263dQQTWqjdNomsVxXAjrId6O1VBnsY0g9B7sLIcF/fvCy2f3TWS+JXTwOU/T3z1SLmtqQZpLyRYtzZgtzKpPpQiTKt3vtUCgqRCPFkThrVXE3118Zg/SgOD+i3GKmTOqSOJ14edjy4OFiAoI/84N+ufQY2/vJ4rAruCSz9GhWRiNaT4mBftSPBuJKdJihvI7GMTHEB+2W4YgPgoFLNwFbJefQMLEZr5fxuE0KBwjBLWDUtCxHE4GUZbNCTCCMTKnlH5JQL8CKgsHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:12:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6411.019; Mon, 22 May 2023
 13:12:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 4/5] mptcp: add address into userspace pm list
Date: Mon, 22 May 2023 21:12:01 +0800
Message-Id: <eb878bc64faa6755849881acd361ae6682112e04.1684760588.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684760588.git.geliang.tang@suse.com>
References: <cover.1684760588.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa232fc-00d5-4846-3946-08db5ac6420c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6Asjc6dlb5waqjZBsxkP9DLx/rfmIT9ZGej43OSKDKyUhwpYEZyrtSyi7YV4EnnfViOYuUMOApslrb9y4bFaQWjV7y0DtP2Aq7G3qfIInVUWBDL77efGMkx4ntoJCAIyyLVXl8aF17NBNhbxzg1sO7pXnY/bTbs9N5KytSPIk82b5ONE9Yv40VmaAniv3xVKCnHMMRcw7orUDkVMioxpjmKNAyHhXJhj3BQ8a+zyJWGe9Wp6qQVu+qXebY0AJd6xB7n19tJ0r4obV+O/UNb8gRt4hMjya26xYpG1TG9ucYiWbZBXRbqBbcTiqATBEmAu3Df+4kyEr5Z5zNxI1LX2FB3sXxhkNOk6ItQJIiAzkq+wtEhJ+WIzS4FMq7j73i8q1jnkWIMr6e8LqpU72D5b2JtUgTE5D8zEpasYOt+QLqHJylC2aEPoOvwOJeOE5pfrUSZWYpSbGRFkt/46I5uUUoSc9OcXHfzGUQvDy93FNoG1U4LMwCgSFWYS7SqNT7HopLGAe/JyWvLmpibaBbI3R7pryn21lqjWnaaAie7eDtQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(2906002)(5660300002)(83380400001)(44832011)(8676002)(8936002)(41300700001)(66946007)(66476007)(4326008)(66556008)(6916009)(316002)(36756003)(6666004)(6486002)(478600001)(966005)(2616005)(6512007)(6506007)(26005)(86362001)(186003)(107886003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SJyPixJ0CgdZ2PPw/GxTBGf/D08FXwRiNRdmXevmPJtCGX9q8XiDZmXMx+UD?=
 =?us-ascii?Q?Hp4SA1eGVEKZYgFDrF+6KBaShJNs28k2dKm514VEnn8ojvL0PiTD3M5qUFLm?=
 =?us-ascii?Q?EFjSNWXe4B6HFYAEy/EdHlencmM9dRp1+84aJ9shD3Bn/mpJ+uxnZs0Ozi7+?=
 =?us-ascii?Q?0K9IBWqhZhW1n1l9KKwlghQdSQF7NV6hfrZfPH7v6jO6sQJ8I6pEL34erO0e?=
 =?us-ascii?Q?NKGQcWRfjr0ZroBKAGDDG7ridPbzSbiSFAx3FTQwrCuRDJckbdsYJupfIzxK?=
 =?us-ascii?Q?t/otAevuOBeRiCpp0pesZqMmSJp24pNpG6RCQOH2TCJFBmRmfhacwP7RqIvc?=
 =?us-ascii?Q?L+FvU3y2NMvBJjvHQ9H/YQbJnQwLfu+0tvnlQ58qgq4YXeJoNQdqx8VTwTG2?=
 =?us-ascii?Q?ma4grx3PGDQC8HW2WkbyHC3NJFnvB3elj+wOT0jQXrULhBh8MTv4skLi6+Gu?=
 =?us-ascii?Q?7MX4w2zDT37djquxMuUSpq+wj/jazL0HeBFGXKz2YBkHBWSQ2sJ8QmtLd5Sz?=
 =?us-ascii?Q?ZoPx5BV6zfb+bNNs/AHP2HkXJhr7DN2sEjcKfzzCJilvkR+y3YsxWkKICxjI?=
 =?us-ascii?Q?n+ryMljJisY9hmPzI8WtX1hZl5w06hhnS/kdBgNxuUwddUfrjx3UVErsDE6q?=
 =?us-ascii?Q?iugZ04ATO2j9zREPZ5kO4rMAPG0ryUO//4t5YJihhBeGAmVjAgfROttrXI+N?=
 =?us-ascii?Q?ddvIhLVklF8IcwYqadcKH5rfMh42kwOvTP1KsN6+64W/Kv5P0tAjJcY3Yxa5?=
 =?us-ascii?Q?a/uxTAXwM1Xh/BumhS8Cfog2DYGWxEVgaod9wQRzEpxghO5kqMkPOnXSAaf/?=
 =?us-ascii?Q?pogZDxVtVDpqIcrAOxRjYymHr1PXPt1sQj5y25SL63j4YMNMEdWJ2OVIAeT1?=
 =?us-ascii?Q?BoxmFQiFWumfu1Q52Yz91JcNJ61LziZGZYzvjzXBcZPivYWzyVtW1UYvv09b?=
 =?us-ascii?Q?ilZlzhA8OeM1AZA0Gs6buIrVFua3/dcZ/VxPZ2nqJ9Kta5dHQD20FzqcPJPG?=
 =?us-ascii?Q?Rjnedbc5kmRCynhJouk9fQrOFu6IdwV69o7P4DmiGm8NuwYs67dE62Es3BKB?=
 =?us-ascii?Q?cNgkoRh5akjAKVqkQ5z+qjuItniT6PBjrjSIsmgEwqRyHG2dnFsaYUKoqEvz?=
 =?us-ascii?Q?N+ikxs1br0p8fILtYG3PwK7abtBFXNRP55p4iArONbC7Ae95ApTw/ydjYmQU?=
 =?us-ascii?Q?e1RF1xpWefB4AG1DuVvbM3owFizjlLttxXGLZ+ZJWsqIFrA6zcHLhk3Dcl/Q?=
 =?us-ascii?Q?T4GJjvhKC92KeTUZYtahV0eYz8dmnh5EAeD5HK0aaUMCvTWlYgMEebxI6Cax?=
 =?us-ascii?Q?S4FnwHAAYeWG6tOSd0aO033fme8g6beYiNW1A6UsGTR3TGeL7B7S3U01C94p?=
 =?us-ascii?Q?CMS5OmVv5SE5M8onxNp4KzyLPk7hcSNEk09BxqFRO2R3wF8Bt2C2m/Pj76UX?=
 =?us-ascii?Q?nx7ep8MnY1uSFg106mw30BPJZMlQ7bdhm8lDt8UsckJRtX0+Rj8+hMFPcku9?=
 =?us-ascii?Q?DaXzlMhQNuBtuc4d1/dDksOeWduzmpTN6aqfO8DUV7WsZDLkSVrT4U+bWAyA?=
 =?us-ascii?Q?WlVmkIy0+HMJG6+wCQ8hO7aiPHBVKUwzFuOmi2sp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa232fc-00d5-4846-3946-08db5ac6420c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:12:56.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPuwpzV/JwGyZQHvzzQbqUzfoPHV55GjZc099nPJj9OtIBmjYZlpX1XCLUmCGNH4hs3t7Gqc6wba1iBi5qoxSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845

Add the address into userspace_pm_local_addr_list when the subflow is
created. Make sure it can be found in mptcp_nl_cmd_remove(). And delete
it in the new helper mptcp_userspace_pm_delete_local_addr().

Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
it when connecting fails.

By doing this, the "REMOVE" command also works with subflows that have
been created via the "SUB_CREATE" command instead of restricting to
the addresses that have been announced via the "ANNOUNCE" command.

Add two new removing flags for userspace PM: MPTCP_USER_PM_FLAG_RM_SIGNAL
and MPTCP_USER_PM_FLAG_RM_SUBFLOW. They'll be set in mptcp_nl_cmd_remove()
and mptcp_nl_cmd_sf_destroy(). The address entry'll be removed from
userspace_pm_local_addr_list only when both flags are set.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h |  2 ++
 net/mptcp/pm_userspace.c   | 72 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 32af2d278cb4..75737e4165f7 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -86,6 +86,8 @@ enum {
 #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
 #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
 #define MPTCP_PM_ADDR_FLAG_IMPLICIT			(1 << 4)
+#define MPTCP_USER_PM_FLAG_RM_SIGNAL			(1 << 5)
+#define MPTCP_USER_PM_FLAG_RM_SUBFLOW			(1 << 6)
 
 enum {
 	MPTCP_PM_CMD_UNSPEC,
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 622698fa36f7..5f0bdb5c8033 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -79,6 +79,30 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
+						struct mptcp_pm_addr_entry *addr)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
+			if (entry->flags & MPTCP_USER_PM_FLAG_RM_SUBFLOW)
+				break;
+			entry->flags |= MPTCP_USER_PM_FLAG_RM_SUBFLOW;
+			if (entry->flags & MPTCP_USER_PM_FLAG_RM_SIGNAL) {
+				/* TODO: a refcount is needed because the entry can
+				 * be used multiple times (e.g. fullmesh mode).
+				 */
+				list_del_rcu(&entry->list);
+				kfree(entry);
+			}
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
@@ -231,6 +255,12 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (match->flags & MPTCP_USER_PM_FLAG_RM_SIGNAL) {
+		GENL_SET_ERR_MSG(info, "no need to remove this address");
+		release_sock((struct sock *)msk);
+		goto remove_err;
+	}
+
 	rm_list.ids[rm_list.nr++] = match->addr.id;
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_remove_addr(msk, &rm_list);
@@ -238,9 +268,12 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	release_sock((struct sock *)msk);
 
-	list_move(&match->list, &free_list);
-	list_for_each_entry_safe(match, entry, &free_list, list) {
-		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
+	match->flags |= MPTCP_USER_PM_FLAG_RM_SIGNAL;
+	if (match->flags & MPTCP_USER_PM_FLAG_RM_SUBFLOW) {
+		list_move(&match->list, &free_list);
+		list_for_each_entry_safe(match, entry, &free_list, list) {
+			sock_kfree_s((struct sock *)msk, match, sizeof(*match));
+		}
 	}
 
 	err = 0;
@@ -254,6 +287,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_pm_addr_entry local = { 0 };
 	struct mptcp_addr_info addr_r;
 	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
@@ -305,12 +339,35 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	local.addr = addr_l;
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	if (err < 0) {
+		GENL_SET_ERR_MSG(info, "did not match address and id");
+		goto create_err;
+	}
+
+	spin_lock_bh(&msk->pm.lock);
+	if (!mptcp_pm_alloc_anno_list(msk, &local)) {
+		GENL_SET_ERR_MSG(info, "cannot alloc address list");
+		err = -EINVAL;
+		goto anno_list_err;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
 
 	release_sock(sk);
 
+	if (err) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_anno_list_by_saddr(msk, &addr_l);
+anno_list_err:
+		mptcp_userspace_pm_delete_local_addr(msk, &local);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+
  create_err:
 	sock_put((struct sock *)msk);
 	return err;
@@ -364,6 +421,11 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 	return NULL;
 }
 
+/* If the subflow is closed from the other peer (not via a
+ * subflow destroy command then), we want to keep the entry
+ * not to assign the same ID to another address and to be
+ * able to send RM_ADDR after the removal of the subflow.
+ */
 int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
@@ -423,7 +485,11 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
 
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_userspace_pm_delete_local_addr(msk, &entry);
+		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
-- 
2.35.3

