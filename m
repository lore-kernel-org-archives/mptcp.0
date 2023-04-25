Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA87B
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 07:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZKiHP6cc93djMtQVv18bZtgQqeSC4uHlvKvMaRjauOEVOnNV+UL4zMijNQHSdIV5Ql4KvA4mPOJ5cLN7+zWGbpf5F2q91IiCBC0NFem/w5jpHHjs/R4dLEXwuSJjpJHSZl7UdOtLDYD4QzTw9euZvYLM4tTVdMt/8zsvsvd1WBHTL12WxcQM0LUNhPgeSLrbscakZLCvLy7zUGhGmFxkeE8RoBytSF1AJJQHL2n/zD2K8zLgPaUxuzn5u4Ybz/lgACV5YBB4sMLEGbGaJjlpkhdwRAWTtvmt2MqSqnHYlK4MjLRR21C0l/EE5N0MElWx7bBTJ54lmbJ9k01dr5YEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/hBCS4c4M0g1Tr8q5bd0JpYLG1nDUo4RPsquKFw7Xo=;
 b=bp/yI2la4iXNKwcJyq2NZbwxPvu5S1mrb9lpGmsCXEjxYb6esyI7Lio3I96qe4717VVDRHN0kHy0qjj6R0OoaksZCnd9Gd+E4NTjNAGzwUhfCmWe9FAYsL9mD9kSMaVVfoEDWylUKylIw2sO6hr/wvXyuK4dC4U97K0yCt3rvys8Qt7eJd/WS8yoLDr28SuAXfk/75834EpRxhrI06vNPB3zfys4GQPojTBplhJMtwwbc1tITNrR4V7kMZlT52JLroYObs3Z8cuMg1V984JcyVbtXNuBGg1v1qq/FRA517NNZdfftpA5Hbb2NsVkPsuv5HYUb3gTexX+zbvF9zHtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/hBCS4c4M0g1Tr8q5bd0JpYLG1nDUo4RPsquKFw7Xo=;
 b=VcexPT0oCKl9O6G4jRNsa4RHVKqTBhH7Ba2AH+GBfns564qf7Vkq84Cc7Mmj5VJUBP5wBvu0YGJtJyM0KeYM+5B+eFr3URMly4xFdcYRgQpln1PMLAf9xDoTinq6GJ7wBIWO8yKx8p8GJqAkSjqza1cvrHT3SNj0abs3+Kgw2i9exzgvsrrNVrJlOJmllaHUGfOX1NfnNdxlHukn1tISgfmW8MsSa1Wt0q7Sg2RJVZUDyBNXSs/rBS4oNasJV9+tfI/rlxV0U6BKX+DBPfw7w+gxfLW3CjYJrlW+4lzXvuuWZYfp3orMVJ2sNvuh3+CFpgEhdm2GNxZpY4Y6yQAtQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Tue, 25 Apr
 2023 07:55:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 07:55:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 3/6] mptcp: add addr into userspace pm list
Date: Tue, 25 Apr 2023 15:55:08 +0800
Message-Id: <2cb2b598ce097ee2e339f819bcb7a7ba2e097c5f.1682409247.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1682409247.git.geliang.tang@suse.com>
References: <cover.1682409247.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edcd577-3fa7-46ce-f3de-08db45627a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fg9Iw+iBX3PkG6ohz2QOL0NZpF8k85Vwxi8OQYGDPtOofRJQkn0hNAIqOMrj6gzfa18BTH+oQoM6d0IcSZOsfiEFTQMr9HhDKrzh91ElPCx/7eXLvQlOc5Ueu/IKbsFa2JrLoqslBCyIqabdPYj/Ek29SoNLT4Sr9FICReITeR7BLKOEcuzlbID8lemRejjcpOdgZVXrmqw3qFDq0cnfaBRQttqOK41SjjRPaAGGSiNg7IldjVMXA6xpUJpS0i8IhTf5TBNReISy8yjyQnzswjfrydENa5SHliMyeWxGvvDqBn/hWBal/lI1KZToKoDEAXgMC0VZdNl1gvEGLm5OmMLqFYKFEb2oGMlvFx9+luoltJdYrKDD83MKbHrFMclNEbbMyn76J4fqUm4+psPPNsw0ZhMIWHe25G2FBRf6Dk32XdJgy8/arhLm3ISO10OQskmos5mWQ5LCEoO78ZDapt/Q8fVLX/1rf3J25AGBj0VUU/5T3ksUWpXl5TzxEpC6zI2AIlQt96EKZPq9EGo356m3kftJapkYYe6d1rPgOV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(478600001)(6666004)(38100700002)(966005)(6486002)(107886003)(6512007)(26005)(186003)(83380400001)(6506007)(2616005)(5660300002)(8936002)(8676002)(41300700001)(2906002)(316002)(44832011)(4326008)(66556008)(66946007)(66476007)(6916009)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mXWXb6+nEXcLNghDiSTFLFoZtbu9Pmyn/0Y0oLzNoTnUnGRXoUiCXTWiykk5?=
 =?us-ascii?Q?wRnGjvT3dalT2bi37s1tf6/bXkPL2+MKAQbyL7V6k1MFuZe4o20yKxDt3Ve7?=
 =?us-ascii?Q?O89yuS1wmRffHFo0lrMP3hrh/mn6nI+ivLg9iUvcV49J9SWwXw0ZSyYn+BV5?=
 =?us-ascii?Q?V4iqBqbPH38mdwQvrIYhDmHh3+lnQf/2e9J5mfWYwQu2Y6Nj3q2lp+tAjSmi?=
 =?us-ascii?Q?yfStmJpFIfa8S53pluWD/Uno3AtuQBcdW3fdb5azr4o+yTg/1QHe0fCKifwW?=
 =?us-ascii?Q?9Xrj0kdROvt2IGFlBccgepclv97jsnT3bxlXgRTME3whDOdVUqmyT9ER9+xf?=
 =?us-ascii?Q?HmNJncZWhP9SHe0ZjbwrtQyF6orzEpviUaEgX3crsXH0fqqdGQqpY9QMvv6P?=
 =?us-ascii?Q?n9QvuNlH7F5zPHRndEYMwzs6rPxJvOvqrzf7+3Nyz52C0AQZdIpuKnYtJ5LR?=
 =?us-ascii?Q?Ol4RwVf1Z8onDRqoQiorCghKowaT+hBSpQ4Ag8Bl3bLfndJPoNZy6Kp8sUVY?=
 =?us-ascii?Q?7q05iYKn++0f2XOjio3c8EaKAiugmOFCcalZD/0ZS+ygMKyCcQLMdy15gxYY?=
 =?us-ascii?Q?u70xCHn0ZXxtZnqwx6JR+3N6Dr2+fvpGYmLJvSXyYtwVYEumaLXxDm04HBmO?=
 =?us-ascii?Q?RQQt08yNofDp8RQcBvohc+S4hZPpeNa32WXEBnuw68EQs3+Wc0jJa4EztTg/?=
 =?us-ascii?Q?sQZVRb11xmw4eoBpUYkeP4nhRHVOeap9SAFPuCdUVMm6o0g0Opbx4/UOV45P?=
 =?us-ascii?Q?qnFYahG+fvEVF3LUP/0loTDcBPITrfUvxrWnmOY1zWz4+CwhD5DbPBN5xAB7?=
 =?us-ascii?Q?y8XeT9v2FzSfvbZBxJCILqMegEGs0SjSXt0GfHyVTMcWIUt4MrWZr2GLvia/?=
 =?us-ascii?Q?IbxkaPfjjZbiIVrMsbCTzEBEPZ0+hgFSwgGZqQoBjbe+8DCmTy72FoDgxrbd?=
 =?us-ascii?Q?S9HqR2Pt/dnqmtCcJsRSm3BMRhA8H8xOttlCrO6FSyJN3m1eEauI/v4STMbi?=
 =?us-ascii?Q?MMVaGTHWrKBIJR19eC7//caEUoqGSS0Gim/bxHm8G5cV08fPg4btvzBUQfmu?=
 =?us-ascii?Q?ZE1ZCHaB648iWZiHhsoTV4mEGtLDjoig14MZHnIaeikfQ1f+lJqIW8tjkKuR?=
 =?us-ascii?Q?Mn5Y4hD2jT2ybLY4/BjKW0SVP4JlbJ/8AOO/xpG0JAoTe86Z9+E9/Yfp8m+a?=
 =?us-ascii?Q?wbEJqMZkA/G2LHfoH73XI+8GtuLcQmt9LUcaIHAgjKnKoy7EKNyBrSq/YhLD?=
 =?us-ascii?Q?bfBv48fyuASmSfkmCZVUHi/KB0OXU4+QkrPMWWdTQrupFPVJtBnpBZ4+VFiH?=
 =?us-ascii?Q?zZFObydxW8c/eQhUJkY/ZrOvo4XcN3W3RuO2K4e3QzTxoJE3IbXdvIZS1kjS?=
 =?us-ascii?Q?6XQsECfKADlfCo+EWXWuD7HY0VXb92y9c43uPAwRA3J+PyVoi24kNlzfmNhR?=
 =?us-ascii?Q?A9oMwpLDb56+vjenH2SZd0Yjn6hWIIDtIm5lAWqU1XZJnQe2ubDadRWyG+Pq?=
 =?us-ascii?Q?M3Xeh+XvkplJHiLwFFrbZ2489+4dZvZ9jEU1HP+Mm7a86ENNYYBuHAd5nMvm?=
 =?us-ascii?Q?WxGXMjYZvb8VgiSe8ujrUE0LmqCPYQwi1j5YQRXM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edcd577-3fa7-46ce-f3de-08db45627a88
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 07:55:46.9145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9w5ekLfH+iSssPMHTmchZtJIhLfILyhaZaohinkuR1QFLv9nMOKIWbKrqegTOVa5TokfjdtJCVLgdsSjcE5eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366

Add the address into userspace_pm_local_addr_list when the subflow is
created. And delete it in the new helper
mptcp_userspace_pm_delete_local_addr().

By doing that, the "REMOVE" command also works with subflows that have
been created via the "SUB_CREATE" command instead of restricting to
the addresses that have been announced via the "ANNOUNCE" command.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6beadea8c67d..b494c72efe2b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -79,6 +79,23 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
+						struct mptcp_pm_addr_entry *addr)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false) &&
+		    msk->pm.subflows == 1) {
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
@@ -251,6 +268,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_pm_addr_entry local = { 0 };
 	struct mptcp_addr_info addr_r;
 	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
@@ -302,12 +320,25 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
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
 
+	if (err) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_userspace_pm_delete_local_addr(msk, &local);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+
  create_err:
 	sock_put((struct sock *)msk);
 	return err;
-- 
2.35.3

