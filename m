Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76798125DE
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="uSYTnVfz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKWuLVzr31vobh+19omeqZC37udWpTOEIxQ6QlZs6aBTfy65mU5W6HUddiQH4NyhKMjlYY3lwFas83IGtxWMH55fX8lmjThM/fo/VaKq2eneKAUjh/2a1Xld4EFxx2r/9SOODqRN7h/Mv7Bv39vkEQmvR4NngGJg5IeISKrZTYmlKe/HD/ACJ7E4L67eknlByhtFEgdceXEOyekhe4S4TWvyW8waRhkp2t6ZWn90vr4m09FT+HpxfNok1R5FTG8RTmIMxQhHIGjc5X1Sd5+ErPQNcbL1YnafC+jliquKdlzbEoTjbDovWLGAJbuAMQNY46RK2llY9uwMMNPlieMdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YigxDzkf4OsJ2k73sLOsneNel8mJsqAUzbvYMdU2tpg=;
 b=cQoO5vxWPEM1OhopF8+TF73ZBhxzzzKEue1ZhNoR7JqZ5m/5T6EeD+bxpJPW1BmBggmMVxzJcOaDWNNuLU576hGUhYw9FkQL8AcsGYXkHBEVvT0dmPIOraIpPsfdGTeKmg3TRoGv5oUylllnQKu/S8ZCxCMjNADTLQxsnLqS268oddQMQP6DnXy6oVyKurweY5+1Yk6z90DC4esToRIA8aeX+69UNXwSgyWE24LAaj927mRIYINmvB3NwsHNjBvCthTUjv+lYTEymYXNz3amjjhoLc5wTkP7baNJk3nvHFqmyX8HHvvbeKRoDHUA+m1bTYv+NMriRT0L6vYe06Rm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YigxDzkf4OsJ2k73sLOsneNel8mJsqAUzbvYMdU2tpg=;
 b=uSYTnVfz60n8CXX4WEK36BBMeCkvaNfyaoIx1CVIX3pRaTGIbysnpUswR8LZ7le7WqKpBej3970Kb7J+gqKqdZ9p0C96yiIypJDUDDKE6xos8+E5MYAib0z39vp6Kh4onkGg0Ye0ddhRf6U3rc2ztB1C3iKWP7udq8ZdlqePrp8JLbfqafZ5dNphbbMlz/zXO6jCQW2NRhW6cMUwzYp29vxs3i4KErPs6joX2nPOVEgmW3+C7yDoSw8Bt0o1URTN4DqEGZVgYEAp350VSnQ76LhyRIbxnKN+uN/L9+s10PcXoSmjZuR2/kqvm2HUMx6DfGv+xYuz+xpFTARjmx9Qig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7686.eurprd04.prod.outlook.com (2603:10a6:20b:290::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Thu, 2 Nov
 2023 10:06:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 10:06:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/6] mptcp: add userspace pm addr entry refcount
Date: Thu,  2 Nov 2023 18:05:55 +0800
Message-Id: <b954617deb2536ea55aedc987c95272d45a888bc.1698919435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698919435.git.geliang.tang@suse.com>
References: <cover.1698919435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a4c3c2-9ed7-4a51-a57a-08dbdb8b59c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TALK19psXKczE+pMcspsLcgpEbIg5ompPyZMXWPfUO+GX2CQQs0jbHIMz9Qf92pjTURmU95sCZKyCWNt0TpCHlcXbdsP9/NXV/4oVGA2Nv9V6mJhjZ/tyiLcmD/MYpmikxekwJV2kaZUknKxVq278VHF4hFFJ2zWzHneZrwz91gHzrK4XsFC3TqSXR2WEh4Mb+OnjdxzogZN1w3sIFcHBx9h1FyJQ4ImvtUWQ42jsuUVciwYLmYV3Ac+Fahw7AlruZecjiic2frGOE8l8M4r1vyTm5vDahLDAgdd9twhQoIPmsEIDY7h9ne7u4v9rhZZLmQSkUr2FHe8yotnRprgyh5keLFGKh45tZ96Gdh12GwRwekhstbQxpfsSXyjg533yi2Hhrqdbt0ETMeEV7rS4y/81/rJT003J3YgRzyu1KHNgo8KcjzW4m4DW3brT5isJai1wUOSnuVIgeedXCPkTUInIDcCIpGPOUMpyejSCWaIlCn1VULKKvPhTR3QGGkpkGcIopNkZUFfsaZy0uTNxO0rqa7tsSJungVrGqDRe6PLSEOncJQ+i26CpuH8W2UEUvpQKnqJysk4MDmX/qaOBE3Bxjj6dVjfkYavtkC4uB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(5660300002)(316002)(66946007)(66556008)(6916009)(6512007)(66476007)(8936002)(8676002)(44832011)(41300700001)(4326008)(6486002)(2906002)(478600001)(86362001)(6506007)(6666004)(36756003)(966005)(107886003)(2616005)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fNnIbcVl7AQfXO+yRRk8ij6UdeYijjmd9hzbByVi/q2N95nxteacjbN1FWxl?=
 =?us-ascii?Q?7PALf29P2Z2Broks9JXxjF14G5z/uUeTRQHjTmFLLJr3VnR4glTebUPOidp4?=
 =?us-ascii?Q?o/Nhbvj/2TMiewujFWytM9u81/AorzADeBtgAg3SthmxaBvcLRT8VZQN2Nda?=
 =?us-ascii?Q?gTFxUI3AJQyVh+72gYNhke+s8UE7EvivO0vXLMFIzbwgX11jURmZARQs3OAp?=
 =?us-ascii?Q?O7l0yzkr30UcNpZ3xQpfak8fVxPOM5kN/bgeaqIsbSR0N1BQyCNrzd66+Cqc?=
 =?us-ascii?Q?Y3NoLvuEZQdxtn6/CbTcDZVd2XwqG2/DrOEKUQqy9m2EWpVEUHLmlAhdKUBp?=
 =?us-ascii?Q?07KMuN+zKx3Sh0Y48I+waTJ7Fzdpxzu7y7fUQm1ocu5rFBX1ziNLApcKZCvZ?=
 =?us-ascii?Q?dAUPtlszxT62U7NvhGY6kXPVuD7Hex3SegA8P+rib7SSSpvMGBa2p5QUgw/W?=
 =?us-ascii?Q?V+6MOvOr6vMgMZ/b3NIaMaYn9GsM7m+qtroAi2ncBLGmIhy2e1vVmWy2vVL7?=
 =?us-ascii?Q?Tj56z4TnsnZcca/P03RgoXxwLLC+UsSTBC9bg1w3ec9eqQcZqH8gBmzFcbZi?=
 =?us-ascii?Q?12afXx89pC7g9TlTPgAzA9R5UXwtgz3sJ8rBYy0ZpkFfummzzZF7CmVbL3Ia?=
 =?us-ascii?Q?474L8CeZlrEAnhF8qfWUhOFFP1JVQ5Fb/H1tAIF4PQvR0N+OlavjupcJvGGe?=
 =?us-ascii?Q?fKCNeAhsZvTslL1tlQbFm9z+hZT57KMyesFih69yJSiqvIkR1nZ+uUc9NRaI?=
 =?us-ascii?Q?U2gRJoX7wXrV9W/wOlyZIdb6oYwbytiRrVKvjJCJXKA2t8m/dkriADmCAvq3?=
 =?us-ascii?Q?Ljlz5NCjr5NrJLvozlG8OcFnZ3BG5fwH7qYCUB4X7y6lg9HFsQZo0NhDOvbm?=
 =?us-ascii?Q?E1WqNlnssmdLm7FK1ehxWLTnMiU/ElEoVQw6/n+9v3XxUIUUoRcqo2l8HN2m?=
 =?us-ascii?Q?lwt3hVxlC0J9zYfhE1hvdjkKUJCczhlK/dZ5RbDyMYwaXVbZlabhjqlF9f2y?=
 =?us-ascii?Q?mfuEfQHXtXye9d8lnQUKz574G5/R9nkr625eeASidPhTm5+UCyqHwFHghj8c?=
 =?us-ascii?Q?jHbnURolPboMagroP2e2kNQKSFfM79sB2xwYxQvAySJ1/kurQS2ukCBdvYt6?=
 =?us-ascii?Q?GDdhL2cKbUboIkkBNyOfZLGThKyO7+8fBSDxVPNIRHTBY5L8Ec06R2OhAGGS?=
 =?us-ascii?Q?UsSNPo5BZ49h/HofRhla2WiLit6Y0Dr63FBNmjjh78qloYtR48aCtranN6vs?=
 =?us-ascii?Q?2hmgZGejBEruWQdeyjXpvcTPde9knk/+DJb1uonPCBGswjlz3kZ5V0vWWSTr?=
 =?us-ascii?Q?ZYNHyHjr7N1OySpZb0g+DYNq7NrWm22WYIjlqI/bwKF5yCcfptK1LcowBghb?=
 =?us-ascii?Q?UVDTjHgPSaZ7u1rwbjLnjSvJ4HjI/W15PIweGL3RfKK5iWd0jSifiD/fLAxG?=
 =?us-ascii?Q?rYJ3y5ewT7H4j4giTHm86aePYnJYPWAzS1v6fcr/3hDukPtbgXUG87MsoIyj?=
 =?us-ascii?Q?8CEumsIY1fTs7CGWuaQ+ZnNTPk7bLbH6lU3h8kRRWowsQFeX1XRa5EF4dH/3?=
 =?us-ascii?Q?6VIpm87ybdVFZvhPdRSLLmsaBleqDiED5ubzX3OzjVxl2ipwBFalATIYLM17?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a4c3c2-9ed7-4a51-a57a-08dbdb8b59c3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:06:15.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kemKfkXN0ukosUf765MWf2PQPC9J1gWQ/N57ur3FweEx+vUxVlik8HR35Pe/4tqw/WrwYMFI90XWeuM69PWgPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7686

This patch adds userspace PM address entry refcount. Add a new filed
'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter in mptcp_nl_cmd_sf_create(), and decrease it in
mptcp_userspace_pm_delete_local_addr() according the subflows value.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index be95fdbc5055..a3eae1e935bc 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -89,6 +89,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		__set_bit(e->addr.id, id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 	} else if (match) {
 		ret = entry->addr.id;
@@ -112,12 +113,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false);
 	if (entry) {
-		/* TODO: a refcount is needed because the entry can
-		 * be used multiple times (e.g. fullmesh mode).
-		 */
-		list_del_rcu(&entry->list);
-		kfree(entry);
-		msk->pm.local_addr_used--;
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			list_del_rcu(&entry->list);
+			kfree(entry);
+			msk->pm.local_addr_used--;
+		}
 		return 0;
 	}
 
@@ -211,6 +211,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace refcount inc error");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -316,8 +321,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -396,10 +403,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace refcount inc error");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b503f8192341..932290265492 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 
 #include <linux/random.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
@@ -244,6 +245,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	refcount_t		refcnt;
 };
 
 struct mptcp_data_frag {
-- 
2.35.3

