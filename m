Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD010BE7A
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAsHlUUWo/3SS/BhghSMp35ckk9q2nSgntDMeQToMVoWKhGGUGrKBSb9R8cEAD9IweQR1huz9g0DN2FhM+ngCc46BMLlwEaTVi8Kvk+3dWYThyJ0AVFsfzNugdo0rn+8xIp7f03rMmTWY4NhLXvSXqKHeeNPIMOijha4vAa1bdTHXyMuQG7D2G39eJY6zwcv/GH+DYpONWq+fm5YxsnwZWM1EX10D7ori16/cU1arA5qUoSfHWg3WTTXVYbEUyyvKtyUon8MKqfil8rHotQUUgpV8nxuxNyZiOmIl2WAxp8AKhfdsY9QLRdiod1M590q4IPTjqzEkpgV6bMielz/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR2KUpNL48oe2dTze/6T6AaIf85cSiltBjkg202IAYk=;
 b=XMlQsfa674I4zHEM9u0kLI3MKx1gutx1cFrWypEyfyuZ2Rg1hCoaoAQI0dpbwh42xJt/7xuU23sbHWB53ITakp2ZMNP6t99AMJzS2y8FruCrZOT0L0PfmaNBBf/ytiFewFpZJtUh1XenXA82FSMY9uTHmwzTYhk56Pp5+k0fr+GM8CLZIXaHGGmViGhjjmj0lmvVSABLZCKjGC+cT3T5CZjIHyIPJkD8fJ0IP9Spfh5bX6RY4dTE0MYyiBohNCca4qVh0eBHTbRfU0Botjh1Fn7oC4p0aeu0qeRxSaF3c+KK3pqFi0V4m7jublE/xlQ1/SnbSbk2utVS6lk9K2fT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR2KUpNL48oe2dTze/6T6AaIf85cSiltBjkg202IAYk=;
 b=XwY3XXLNSrVldXfGBCn23JyM7uki+hyDZ664s3VGLs2yqVGZDxRdDaK8BX1adbUYX9jIvfsu3SA/99feToaG4dSJj2R1YwnBGUixXaAafze7iLAxK+CKD5FVO6Fg1GOrqS1Fm5sbl8I0JIrrVXBZ6Ddxwg0fZMu8aOUM1seufQ3BaqfMQC6VlZTLxZkEROqFJuqkV+EN2+6WWqCTTjepDYnhp79czSMWjpXQ2eXOXS9YZ7S98MaUnQZNYGyDbGA6tPiGVfjKJMk0mnCDn4X4k/pBNhETL7c32PuLXrseKK4dcoN8tipr9KSSC+60MBFdeh520lOFIQtMlkoaQbzPdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 08:03:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 08:03:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 3/5] mptcp: add address into userspace pm list
Date: Wed, 24 May 2023 16:02:46 +0800
Message-Id: <b897ae1cbd3615b1304cac6f3dcefe42854f273b.1684915182.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684915182.git.geliang.tang@suse.com>
References: <cover.1684915182.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0003.jpnprd01.prod.outlook.com (2603:1096:405::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f5bce3-1c1a-482c-964e-08db5c2d5bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SmwxKya4yZoxSz1nIdPwATIbYyqt5xgrn9+BZYvyBmUaY3t1nucrpIuXuUhrUbwyV8jHvR8dY3xkLiMtyp4cEuqnZKXLMyd5qRFQsFJJWvf5OH1AHc5XWfqWLjNAjn5opfpTQfPyLPr2X9LUixbXLZC5MbfvjZXKYZbxqV0ub290g+EcUBPRFSP+jpyd1wP6GWkHiq92ZkdA/122yb632XUxfT4p4OKpigT7MmHyBVHPb3+a8SSVbf+gFS7gB917PiVapvGoz0SN5WfbFAtsoCR8U78qt32xIpnAaNzRNjxJDqr8cQONBn1/8ffUZeDvXp6QxlEGYWU4DO4fYzCO0/r67MKelXTuuPMVTJGeytNW77UFbkarvqhP92Oup5a11lxLQmnuy9y3djqbTYtyM68+0uWyrPy0sFCGh8cpWIvAjz0wS72YB+OUo9x7FgxcLMQH0tE9AUJhhKQZFG3Z9voBvwQynejeooqVbM61aJD74RLe5kZWxbQbsjOC/eJ8/sDQyMt14AdjUdVC/19QzaJq+O5GJ9epLB2U8TlxCFY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(2906002)(44832011)(5660300002)(8676002)(8936002)(83380400001)(66556008)(66476007)(66946007)(41300700001)(4326008)(6916009)(36756003)(316002)(966005)(478600001)(6486002)(6666004)(26005)(2616005)(86362001)(107886003)(186003)(6512007)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cznSYk4HHJZVmOohNxfzligb2mW/Ctc/sIKXyg0/n/GN096dwdUt8ItvE1LI?=
 =?us-ascii?Q?ND4HVMkTslGkzigwYNomHJlc8mkOEYwRyArSqKx+nVnJrFtmS63GGJHyGKlY?=
 =?us-ascii?Q?cjCP7V8+nHLGAT3hxiMkE7CdMxBqANJ+CAYaOsQ7GaRXgX7issxQuGdQouPN?=
 =?us-ascii?Q?6bkDChdab8Ha7nNT3P6EGH3Xcy4HRRRPNfkaaao67SizP4TZ8vrldKwnDWUi?=
 =?us-ascii?Q?xxJG+tvx+0zxi2JwFj4gu5xdz9C+wrRue+sP/VrfLLp5i+t9nwKMdl2tPDnT?=
 =?us-ascii?Q?uwyc5O+3/qZvQr1/u5qEBnQlqfc3MP1uVdDB3dGufoDBQ127UhstNgaWKVVK?=
 =?us-ascii?Q?4QyJFTJXNuiPqAxAMfrEk1tqhR2eCMhJfFjcvyy5pB3lY5C5qxqQZXNn7p+l?=
 =?us-ascii?Q?yKDV3wa7vSA4SUKI6WvWiE9MUeubjJ/l+Cc8/3juLNbYkCR+3J9GSCiuOVzV?=
 =?us-ascii?Q?t3VeHqeYzK+n4aokh0Jgpnl/2UiQulGqL7tawXetKGTxl3+/jprj1Pq+PYgM?=
 =?us-ascii?Q?FtiQTf4OhUPKGdaBK68ask1QRGjsoC2LnxueQ87PHNrdaCqBsfdlsIm8enul?=
 =?us-ascii?Q?AriLaZwNZ0+7g40laNhLpyVq1XpmpdAolz2ldq3Z4aqL9jpJ5QbQABGJo5Oz?=
 =?us-ascii?Q?X7Y47pMRBBC+tL8AnkwJ0a91Ainr0T+8Xvrrjgd1QhtoQQTO/qT7ZvH6Ih4P?=
 =?us-ascii?Q?JAyXF0m0x7crIxSj/bo6ielqQlqJFNasPa2p1tu0fPQE3iLun7ZXHgesNGqr?=
 =?us-ascii?Q?2W5ozFtWdO1tY4UkdUrnrMY+9Is3R9juDaTPhdMwRBTNSEG5qpqJZfOM4d7G?=
 =?us-ascii?Q?OjO/M/66G7DOGI+52HpzTpWQk7mG1LCZvcizcmWzWdqt5g1ArIF+8OzPbXFG?=
 =?us-ascii?Q?xLqG4rwyNQWBqjnEcykY0cBXmyRxCAbJc6IFJp9rp9/kCHip5QYtzMN3TXhF?=
 =?us-ascii?Q?pgrpijaiCqcelt5qDZFvPHP0xtOJechWGhIh0L+8NAK0bAC0MfGggzFOQoCh?=
 =?us-ascii?Q?3/prBk4zd4atAjQREFvonZzVGd+voFtchjvzucuKJ9auZYuX8Wxm7OsyVDR4?=
 =?us-ascii?Q?aT+utSAj9qdq98TyX85e+b/m6FLU319SIizlshhbtW2dJpX0KK/Mgf66F73U?=
 =?us-ascii?Q?bLbWz/PKO7NP/fqBirF/MUOWyLT4CCZPjFUtEYz9p2IaxCB8b1GSRpxsILxC?=
 =?us-ascii?Q?0IGkWb1E0cyOoatdacRsw4jnWMYCgE4REzwnAzRRcgfLECUI9lWrO8TizhDM?=
 =?us-ascii?Q?NEIE/F8h2TggXeWg9Rh4asrcruCGDVJfsGHy2U+1wd8S7gwMo8lxcRZVkXxv?=
 =?us-ascii?Q?sP/4bhHmFBL+EwxXynjMtIs8N6bDa2zfl7/TgMu/3Kz9NG1ah+/PBtnNW6qF?=
 =?us-ascii?Q?RpnGfmH5ge1JWcvbjW0wCU9ClwA1XD6fzinjb9FFgK2eW5vQNEbKEJAOFYFC?=
 =?us-ascii?Q?ghIUJF0BmfGeBRrUwrwpczQUaFEKyH8sasjlA1Ma0sWhJI9e4Pi6qpOdSkVf?=
 =?us-ascii?Q?EAQIqnOUsRxG4DGdrndYOxMgZKYgCHLAKMfiWb2Npyjo/JVjae5iQNUi7mj3?=
 =?us-ascii?Q?JCegIqfJPajYbex6M0+u605aO1Iwu9jWS78NCz3l?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f5bce3-1c1a-482c-964e-08db5c2d5bb2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:03:28.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwi+ZJiw0ahOITCGdXdU+9xkYTsu1equRQ5BasSmjWYE3ys32XxFJLwpz85omlAp3T1pKtLIxoizwAfzsC4/xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714

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
 net/mptcp/pm_userspace.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6beadea8c67d..114548b09f47 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -79,6 +79,30 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+/* If the subflow is closed from the other peer (not via a
+ * subflow destroy command then), we want to keep the entry
+ * not to assign the same ID to another address and to be
+ * able to send RM_ADDR after the removal of the subflow.
+ */
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
@@ -251,6 +275,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_pm_addr_entry local = { 0 };
 	struct mptcp_addr_info addr_r;
 	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
@@ -302,12 +327,24 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
+	local.addr = addr_l;
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	if (err < 0) {
+		GENL_SET_ERR_MSG(info, "did not match address and id");
+		goto create_err;
+	}
+
 	lock_sock(sk);
 
 	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
 
 	release_sock(sk);
 
+	spin_lock_bh(&msk->pm.lock);
+	if (err)
+		mptcp_userspace_pm_delete_local_addr(msk, &local);
+	spin_unlock_bh(&msk->pm.lock);
+
  create_err:
 	sock_put((struct sock *)msk);
 	return err;
@@ -420,7 +457,11 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
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

