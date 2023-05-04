Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7DA2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeWRRMd7wsXyhpBgc86faMWIG/3mW4Z+y7Hm1x7FBiBvsA7Ou53D4NT+3wZJzoZE3i+WCBl4tJEfLbfsFwsm2nLxvhmjWRpIu1woBCXZv2RnlP+Jt6a3lQcbziEIJonaJZvh5zMAw9zSnTAEmRv6eJFCWTutzT5TACyg40HPF4uRECC53GMVP5ysr055lDt6Vkd34Vg4bI42dPjan2xdr+uyWDVd3BBUgbRiaZ0DV6AUJP/l68o+3yQyuNHUXpHoE1EZtR90iH051JzVOAa1YJPQ2jNY68CoI2c9gnUCEMpBb5OYkU9OZv772VpoftxdqlFuOgS8m1xYx41dqDJkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/srRT2GtK27VP2VUy15txbcj0MEdp4n3NV6IeN/TuL0=;
 b=mUg2wDv2y5Gpq/IgaEcXQjsnqCVBz7S4MtqKwS5D5qMs2L9bQKtVIpr+9a4K7rp0lb7aocmC0iEvPfMWw+JdYn4P6yQ659yGPkZl7I3dZBnMIrDpFH8FAQZ/6ODK/Ep8MWf516ihc5cZuqHNpaM0dST8ugUNO+JE0H/gYtHXH66M6Q8l8M188EMNXtEP7BBfU9JjS3aWqu1R7cHVUNsDIhC+GwnhDP9mystu15nfXWD/lX6o2CH4Tg1wC9q+ygwVYbPeoAMbIOfrq+rFSw7lQdPRtl45aax2wJGFroljYA0P6lfyBLve7/0BDWyMIN35C1L1MAkebG9+dDwVR49lcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/srRT2GtK27VP2VUy15txbcj0MEdp4n3NV6IeN/TuL0=;
 b=N4XZUmEfIwwculqWM2/t98MHdeOWewhhpTZCMczJwv3Q1VeXnxsaphk4sNZcJom1/esXq8WlM8n85IfD+eK+GB//a+4ehan4pFcW+mgK4kmJ426H6sIGYJ9J7JTXGQIGPLC8DFvBx05vYavV/kNFCMCt8OYSf2CMRR0377qwcq5Xqo2jSMKYHa4FcVXQzFgcro3q7C4w0MS/wD3PhBscVSgGsBFF5HHsPt4hGy4tDk0cGL4z14M/wS0yM55sZtqHgMEUYzV1/DqgeVFc9RWsApt1paDSAMVKH760bRNdlzetKvcAvPBsSo6V60xNtYGAxunh405MMEZiDxt8MuIgdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8908.eurprd04.prod.outlook.com (2603:10a6:20b:40b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:20:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:20:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 04/12] mptcp: add addr into userspace pm list
Date: Thu,  4 May 2023 18:20:09 +0800
Message-Id: <4ec2d013559dce53d222e9cbd53c45a4b4d5ba12.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
References: <cover.1683195386.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fdbab4-7d1c-45ce-61bf-08db4c8939aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+0gb5ig3/+VVMW6VYoaPUscJQjApvOaykA+PVd9FQC+Kp62vC6tlxtqjCwaiWb6LkD8n7AQIz1bTx+yCGcRG1wV8CY0i0Tin0zj8YQ+ptNy4EST1obSSycWjnnS3EGrW5u3jkb4xzlhmV+SL8ZRb11pkRFYZA+Q/P9JYOKdwNYHn76azr2D47X0yT+Y0ZDUyc252SzqAneilzmRpugya/tsIIZUGjUCu/suX3IZ/NZopfHahYEeqOnNvQG08xveF470Wc8qje1EbnkU0wmtbFPKThgUEjUJY0Bj3FwO39drxGHbXXVoOUEGwOUwaFFcih8rZMhxlP7L9Gaqm9ZODDQw5HKP6cKlO+VQsaH4gMm9mlDaMTzsw7qefAp9wvyRDAKDa73THSBYEjNq2VGkVT5kq6PgaxiQjFgEJrfpTVikL6VZb9/lu3zB//MJI7+Zwm4pKesjkJusNtqlzsEAowc4JMqpQajAym1AiSce1NWKwNEZxjAvBU9/9FeZVMz7r1BHZWMsALWoNerWqvZJR8iQeoXGovFQ9WVAMqsoilZs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8676002)(478600001)(966005)(38100700002)(8936002)(2616005)(6916009)(86362001)(6512007)(6506007)(26005)(6666004)(66476007)(66556008)(66946007)(107886003)(83380400001)(6486002)(4326008)(36756003)(316002)(186003)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?363LGie+9v53HUpcSWbIiGui0LJHF8aVupClqTicPwFwBkggKUzxW55CSpbQ?=
 =?us-ascii?Q?F+HplPKnwaWIqHQU0tS7pM6FKT/TkuOjGvWmyf6mNerO0jTqPxRnfRTxuInP?=
 =?us-ascii?Q?8EAWfoFW0BQtymtbaiIwlztS214Q3rjPzOyXt+cwi2/Xuj74majXtLm73TMf?=
 =?us-ascii?Q?jgF3HdWYeF6KRdF6Eww5BbrMpnPzVELM1EcIJ3IzaPVzGuTz5zZ7zTgQrjGt?=
 =?us-ascii?Q?CNbFPjDf5eJMGI7dP0svnjkGxYsXdRR3d05YZT6AKKxNDks3ZOqENrq/cxE2?=
 =?us-ascii?Q?DvKdoNdU4nGgf+L6yZyHfVpPHctIItiPx98m+hZnN9VxjdT2/7GhSHcZGhX4?=
 =?us-ascii?Q?wg1A8XH6hQmOmE6I08Ba/CQoBhTGjQztLtuxtXXVD4SutJ0yySsQst2x7luz?=
 =?us-ascii?Q?8BXVmH7LQ7Xj0ICwVfkoZtdPYRh/BBqQSG3NkHa92esoi878rLLKNn/7m6nR?=
 =?us-ascii?Q?ZPX1XokwERctZ6/bHfvT9B8Ukle+NvsFtLQfiDho2Avg90EEiRbJpYNSGMgC?=
 =?us-ascii?Q?rKryd24ReI7MGj+j03vxlqc0dmRBXfJ5bMICUQQyMYTVjDYAIAwV/T3rpyng?=
 =?us-ascii?Q?wH1L1S6Elt/+LKY88XEfNYiFOscbyZ6xwnZ+vyG7BqCm3JTd2tKEEdeCDXNW?=
 =?us-ascii?Q?agWb+HQzdAUw6qUVwfEeI4rTs0JXbxntaN+DJvDd9oUzOcdP/V8foamsGKAe?=
 =?us-ascii?Q?5KhSlq7sPJBenXbj1lVEk2Adj2KGh6ZNjIfN7+N5u37SPnl567ojEemgkFvh?=
 =?us-ascii?Q?rwWMzoPTpjKI/raPsh+Tlq+Dg/ttZUpmVys/MfY74SH6RRz5mC+865wG3Bkf?=
 =?us-ascii?Q?9sGCQvnuVpmmPHlCH98gxokoqwin6ZO8Axarzu3S6BY1d96KgDgdyL4jbVb+?=
 =?us-ascii?Q?VMeMyXtVoDg9hIintfFo/3P4G/87/3sCEQ7eqRFWe6wPDSrggRwDtzqksucX?=
 =?us-ascii?Q?ABceOtYhbNxiK0CuJT47G8NoctXj0TDLkXdpf/Ef8VEyOlj14bRNNdQ0iwtd?=
 =?us-ascii?Q?eZLg5o8G8Zyq4aZkzv7gWgBJGznP41K0PPhlcEclprkw0E+5Edrh73lfXg3b?=
 =?us-ascii?Q?H4AJ5gySqzpYKie3DfN20jO0vyJjzdrt4mpTGOnm/rDsuWWH8h2ikBMTIoHt?=
 =?us-ascii?Q?5mdNUd3psGABQgAincJcotJwCCNNIIkEFxOu+APxv8QwgTnt6RQT1o8hY9gc?=
 =?us-ascii?Q?aUE5siOx5OPrITW7Xr/72tdt83bgTSenuzzUcPKNb7JrZWUU6YuN1dC+Tkj+?=
 =?us-ascii?Q?L3R9/cbUDCgsCNqpprb4psCd8ifxgYFxGbZ0w/s9QJC9S429GG9Nt0Mk0Msy?=
 =?us-ascii?Q?NtQpWTU/reDaSG0qjbFLA16SzjSQSCdIMqKYVVilnyj8MTpZ3JWbe4nCxUMq?=
 =?us-ascii?Q?IgfAFUkD9oRWc272JZYozraXVNk2CyXLITfNK5+0ZVFyHffWYpprXcf+cfGT?=
 =?us-ascii?Q?Aybk30+5A/Kr834YyJGjoZBMebj/sdRiWJ2KJ85I+gH1KNjo6UqltGzQNu3t?=
 =?us-ascii?Q?ZzU9tCH9WqheKzHhBsCXdNJoqlZP/992ftEIm4wzA1NJm2E3KuKydlw2cQlS?=
 =?us-ascii?Q?lleikKHrnHy8HLkEa8wZmI5N3lPUxvIU1oTl5jZ5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fdbab4-7d1c-45ce-61bf-08db4c8939aa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:20:46.8447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89sIZA4etPe7ctRt/d+yK44dWQ4H+uV93VmzLit0/CzEhJuXFmShO7kGYxdESk0l1qTpqOex2ggob3XeHF6whQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8908

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
 net/mptcp/pm_userspace.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6beadea8c67d..c50e1507ae35 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -79,6 +79,24 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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
+			 * be used multiple times (e.g. fullmesh mode). */
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
@@ -251,6 +269,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_pm_addr_entry local = { 0 };
 	struct mptcp_addr_info addr_r;
 	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
@@ -302,12 +321,40 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
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
+		mptcp_userspace_pm_delete_local_addr(msk, &local);
+		spin_unlock_bh(&msk->pm.lock);
+		goto create_err;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
 
 	release_sock(sk);
 
+	spin_lock_bh(&msk->pm.lock);
+	if (err) {
+		mptcp_pm_remove_anno_list_by_saddr(msk, &addr_l);
+		mptcp_userspace_pm_delete_local_addr(msk, &local);
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
+	/* If the subflow is closed from the other peer (not via a
+	 * subflow destroy command then), we want to keep the entry
+	 * not to assign the same ID to another address and to be
+	 * able to send RM_ADDR after the removal of the subflow.
+	 */
+
  create_err:
 	sock_put((struct sock *)msk);
 	return err;
@@ -420,10 +467,14 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
 
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_userspace_pm_delete_local_addr(msk, &entry);
+		spin_unlock_bh(&msk->pm.lock);
 		err = 0;
 	} else {
 		err = -ESRCH;
-- 
2.35.3

