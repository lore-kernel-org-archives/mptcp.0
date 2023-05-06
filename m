Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2C1105
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 05:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acS9y6KoQfw5p8/HykaNpUpIcoTNVKj+V3I/ceDHv3mLS5aNWBdnI4U3Oih0ZAj2ebz5uawuspQWuhnKRHDDE+5iEbQey2h8krysPLYXxqSZJ6u8Ur75OrLH6+PreJK5PdmE7Bn1LjZ2DGTF6Fr82FzWqImR8/c+UjENfxG6jhm5WyoZ57qrUbqOmXuh94kgfaOX/kbSFClcFn/QUpIqwOzM/GcSf9elmTUj8/cvTbTB6+8tv094KZNTBkG34bQkGRVkG0dIoDDudbqqix/F6RZItuj90DlXGYaD+FUezVS2vEWzArkO4ew/rzwVve3LsWyYcHLVwOUsMrjU4PyUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BCQ+Z3iLWrc2bQ3xarhPzmNZq8Lw8NHhg4VSbt72ro=;
 b=TJHgH5L+LPbIvoNVHdaCEm2T/cdaw7CyRHTM6+79SRS9KW6BXBSO78zLulJqHJis47shNX7ekq1JnOSr89U7rIqAKAq+8IdW373aNgSCSwRGxkLQUwSwRVwqa+HsqOzoRvAr9sAmP9id60euaILD99KOVEgZd8lTxZH+WQTfNENlgTslzOsGP8ouUbA0X9cyKYMlDuUOSQqYNB08j6Acn4QqVnvnBwCXE9stEpD+XXKOYeBg3myKc0JO7ntmzphPpkVhImwply/Fynsz3TFBb7H5F/f3Z0Ddw1l6r3w57bRQ9hR5AO9QpnDjNRPQqZy6o5vmun+hm/Gtc80MoDvWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BCQ+Z3iLWrc2bQ3xarhPzmNZq8Lw8NHhg4VSbt72ro=;
 b=hyPQYFO1sy3zhYrevyHqEkDppZelI/IqGWkSG210+mKcmA5IWLiiSmUinZsxNutPxWwrTYGMXuL4eDMAYVjmAaoQptWgX9FojMh2ghIuldMGenSlo3AasPHJ/ReoK8ygPGzjK0d9pwfmzxpovRfLZHoKJA011sPagwxdCUgLHXhvaVSLWxjntMzzDgAk/x9THC4mcmQSPqeOFI3gzjr+G7B9m76qztU3EXdwJ0MSaXdxNgHK4uOXje5H4cD9KmPOX5Jlw6lzcKxLlSbFloC9+t823KtHdsOtPV0gPnNGzQ6EMd2aS70MrZ7mS52dgHi9L7MUBnm2qNOhNgatA7E47A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 05:09:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Sat, 6 May 2023
 05:09:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 04/12] mptcp: add addr into userspace pm list
Date: Sat,  6 May 2023 13:08:52 +0800
Message-Id: <c9cccc5d19557ea7ee8443c665af46eda6de44b1.1683349666.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683349666.git.geliang.tang@suse.com>
References: <cover.1683349666.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 682bc862-234e-454c-45f1-08db4df00e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j/rlKfiIbuZNuhGTV9Jg+KG9X7z/aiXtOgPJhDqG6FDY/v504LQ0hFipsNRTkNRI1n4SH1V9ijLLfUc49VA9m7V1aClNmitmKdPRIZ0ita9H1zgmv/9rcPIvagNhJkwn50s5g89BHG+k8WARdgffoahqBuGr3CHCazf279ch2Lz/DVi8w7bFE7PB2QRzMS6Bk3TxSHmcnvPyGWH5yXr05f203WMpcIAQzasnhMDk+iYfql/5wWSRQ+XHD5wYxx4AUfzpnvkiGnFFc8+BCjZAHzWxYh1YkYN9ej5sxWFaDdQ2gfLRxYV8GHp+W1DfGaoc7eljL4byDdEjdz1Jqb7qFxIlPzQvJEk8JkLMOrUd5d1sBwGPCU+p/5PigGQdHxueJtEr7thX/KO9LnsgwTq1uwR0QJY/fartgcs4nGvg5lZ1HtYoFu9IIe6q6I3S3/3c2sCpa8MDgAaZAhN/ZBvC1KIsqC/i7MlFyPJfBhcSRPkv1taZB0AHxMR23rAm8h9+mSk1dYWrXfSkgfmOC59Oah36F9T1geMEFBylnEVph+M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(41300700001)(44832011)(66556008)(66946007)(66476007)(6916009)(2906002)(4326008)(8676002)(316002)(8936002)(478600001)(6486002)(6666004)(966005)(83380400001)(107886003)(6512007)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dp31PVqU2S9AOL8IO7+czhcXpHj6nsPXtX+LGRrcVfzCOXzsBvGPxIw/9kq7?=
 =?us-ascii?Q?WD1JPqd4Yp/DmfqNSS4rBsfvyhKyEDfx1k42pXM56L6GPqplQlMvsfPHmPVo?=
 =?us-ascii?Q?rjZhzKqImuzma5OJ0DPgrzLwFQH6j2HpVDI2QcNUTIvha1k69x7hgO0CwaPm?=
 =?us-ascii?Q?6jgnams2K9DaXSq/XXSZ//7YoCZyf6dG98KRe+RKDOSUSZU0NaHRHhFVoGzX?=
 =?us-ascii?Q?L81Bf2plqTVA5P/guQZwsHszVXoZeGaLVc1cCyIg+5mbsqZJFHw5go/88kll?=
 =?us-ascii?Q?TYzpqdFatWeEKmX2g440EfmS9JZE4K6Q2ALHR7dOGkRArTwFfGXWeDzWDJOC?=
 =?us-ascii?Q?sHW31+L+C80vv5mpf6MeGLHFxcC6rYX1WiI5CC3IG0TI3lyOCc1+702i/XwI?=
 =?us-ascii?Q?wL+BwH4Q+5KieTOt37BA+HHCpeVzhI69nLw/QKSDv8p2/yZxtm6111sZCksW?=
 =?us-ascii?Q?7CtUSg1z6ddosxmokEFkJTGOSEEKqHfj3Dmfm6rb/6z17xsfxwp4yPhzQwuh?=
 =?us-ascii?Q?to9BzynpHWwFaVP7rBr82a7ExOX5TexsrGx8silCl0FLKyEqXx5s0/15rXs3?=
 =?us-ascii?Q?gu1gOt/Ko4RUWyTOJeRr5lmtDbAnYHh7z2U1oQgQDTbk/BPCtXDLLgwCoVu3?=
 =?us-ascii?Q?wYHXjs4cNQPailKcCeTmO5rQWXOL7b6Jebtdvax6i55BToPt8d5aCTtWULrS?=
 =?us-ascii?Q?rNVZYOOX+xv4eJLnjVGoitRcnYucwf0P2ku0kMSZXTFiJBYMJZR8wqOu2ev1?=
 =?us-ascii?Q?cZCAZgYmcq+SyU1aldVHL3u5No4stImwkXwUZybtBgghdUQDO4d8w6B6TATp?=
 =?us-ascii?Q?Vg+s8Gt7RvoFbxDqkv2E7TZ5uAKoatIAHKNRrusjz2P3RLFTaEIwIPu/X1Dn?=
 =?us-ascii?Q?u3kyPK0wfc9357Zi4ruTWJjDL/AsqIgzNEyipMfAoF2AIPiaJwSG6d94cwOz?=
 =?us-ascii?Q?WUX7MxYLkDXUcQ8uX3/pcwiKYI3iyi0ngxyTuikniOe+jrXM2lwus4fCae/s?=
 =?us-ascii?Q?z7/rndMnB9Fg2M4HWvM/RivBOr+tkhR3TWScS/1dmjvQblZAuJtfEfwvYU5s?=
 =?us-ascii?Q?sxyXg5BHyy9/+YdM4t9VaY8gVEslKrrw/ohrPrtB2AjT8XoPR3or06e5v68p?=
 =?us-ascii?Q?EAyV7bHfVj+bctajn9pGg7D0n4rzPhFUFF/2l5F1DD5/dtMtjdTB4onkucc7?=
 =?us-ascii?Q?R7Q28AxPxtWgm3jjMB/JdT+fY78wNO2JvK19srKzKzp3k6jhexwRDb9NzihU?=
 =?us-ascii?Q?KXn0hk4/viKa/MB3Jbw0GZMZCOrqdDqKaNfdVCWpYAb0WjawhPG6GAR2IOXm?=
 =?us-ascii?Q?vSeJPZdwyuHzalBuhZpjDLH6rl5u2XaqqJ4X3ZrLYK6J3D9O+VsrncU2gjT1?=
 =?us-ascii?Q?O0jWYFh+tAbgaCgTWfad2YxmehbK8BfCrl7IdAvsFE1tP1sLRaoQZJpA3VtD?=
 =?us-ascii?Q?sjNrsnvy5NdG1b3fNtlEThoVIjMxus+pzHAop1w3beUGZ9MG83lcQGQwv48B?=
 =?us-ascii?Q?k0I1fRxKCwx2Mu3/4Yjr6vXI6s8zHbCrFQzDJh2nkQUj5VYjRSU4rSbzGQ+y?=
 =?us-ascii?Q?AIWElxbepAioFUecm0PyBPJUPHk05UhkA3VvdduO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682bc862-234e-454c-45f1-08db4df00e52
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 05:09:23.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InrOzE/tdCz1uEQ4geTC+/3vGlDhBw7HK3XcYI6VXsOyz1tMV5lEc3ByDDEdstAgulIrnKncTqY/lGtevdK2aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

Add the address into userspace_pm_local_addr_list when the subflow is
created. Make sure it can be found in mptcp_nl_cmd_remove(). And delete
it in the new helper mptcp_userspace_pm_delete_local_addr().

Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
it when connecting fails.

By doing this, the "REMOVE" command also works with subflows that have
been created via the "SUB_CREATE" command instead of restricting to
the addresses that have been announced via the "ANNOUNCE" command.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6beadea8c67d..ec26a3f0bc64 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -79,6 +79,25 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
+						struct mptcp_pm_addr_entry *addr)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
+			/* TODO: a refcount is needed because the entry can
+			 * be used multiple times (e.g. fullmesh mode).
+			 */
+			list_del_rcu(&entry->list);
+			kfree(entry);
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
@@ -246,11 +265,17 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/* If the subflow is closed from the other peer (not via a
+ * subflow destroy command then), we want to keep the entry
+ * not to assign the same ID to another address and to be
+ * able to send RM_ADDR after the removal of the subflow.
+ */
 int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_pm_addr_entry local = { 0 };
 	struct mptcp_addr_info addr_r;
 	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
@@ -302,12 +327,35 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
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
@@ -420,7 +468,11 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
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

