Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EEADF44
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="zG6/BWgo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWk/njz3TvBHommQQWNJ1UiuCaJKaA1POwOKhpK7GAVpkY+Dno7fivg4NZmjfMwWBbhcIqDkH9+BPADnQ4aMj0eDIGj+rXN2A64e7jPjbQHpYKa5qsDjJP2I3bifLBnt89VHGl6GSxYGMupiciU9kPbpPkMb3gHoMtjmsnp3VjKgcHgcJintC5wU0sKS5LK3w1tvkk+/lPF0FP03EKACxYfDwFpxER8noSE2aookXprDIYNaY/TjGlCrIKak/g7uXXGAoxvuXguxJlt3/TMr/sVI6EDALNhfGqZd3KChMnMsEEtwV2dxELkRezkw+LqAw8xJvDPYNsIEr4FBWecl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUQd40HfRyC71IKotVEM+O/UYcQI2s9kFoLyew8RFq0=;
 b=A86tu698JRUbCIimYA2dJp5tzh/L8yGaKii54DuLjvHllzcltDx4b+hoFqqg8oqaYwDeJRQZGf7B5a8TuqZMBkBsJtyODAG1h3ujmcAhgoT0YcVnY+gf/RH2ZDnzbXVTZdIN1WtxYNbMosKqR5AZujki+bfRrp1fv8cVXxcbiTCdruO00RuyWvjl3V2EEWG6cWmxsMRxtHIWUIyLIRc4gYJiWrsUqId/bMJpZ6Mq+zmULMnMQlc8uxfKVi33T++k0LwiueLMMqIvOUlnN8g8657fzFfAHe95lb06vzDQPoT36pnhBZieoppNYi6iUnLn/Dc89CX4Sr3bM0+fEp5mhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUQd40HfRyC71IKotVEM+O/UYcQI2s9kFoLyew8RFq0=;
 b=zG6/BWgor7eC7cbjGsOz4rKfu6PbyylCYxZyiqP99faxuc6J08ADQ1Kxa80vg6NO55g2/d13YjyDeA/8+b4HbHWHL4Wwh0IwI90i8dLVB/bUthHrPZPRJmTVndy4I3chmEJ/vqCdDoA8zwCEB+bUlzQ9cp0Sw8l4kxWJpFV3qKzDp1+6sLGwMxloZbGyW31kAgp4I/2q32fTzZ4znGXyULj8afsNg5y2tlzH7Y7c55vYzuuQcEf2TZgmIeGFmqBhoV1UUddjdKS5y4wjnNxIT0uVVp3ioELC7ZwU28RhXhTB9QPuaHkIxYAsvTCB1ArQSX8Cb1EI21dYlSvNoOmKTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:14:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:14:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 05/20] mptcp: flush userspace pm addrs list
Date: Tue,  7 Nov 2023 16:14:11 +0800
Message-Id: <9156bd4249b44591eb6908b5a243e9bb37c94f31.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c2cec1-f812-486f-c8d9-08dbdf69a127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TXA1IrgMiBgjZek1YelwPlNDUXiCldzwISUXmvJXsEF/XRYQI7VPu2UExfp5dKzwM9hL2XRUWSvyTa6gdpo33QLA5+pxm/7csyXSQhyLIUwqmXaaoMrDGVyORqsQc/NY7KNn955YY1fSUzD9Uo7SdyRWfARIOzkUitgcq8OZ9H0333rrlwU6KmFfQzOnrrZCc1D7O0k+ZUKufXjVQoHhVNXh0TJvzA9IcdMSGlVt6YXkZWL2aUVJG/MMiq/wXHgF8nQJlbiHBT4MjNRzm40JDFCJPnm5Gm5VaUt6xouoOdVveo9crANfOPX6Jsbw7QaK7Ufd+46xT1RsO1vF9dz0Kc/W9ddli7mOwRphKUlN++0r9M8IHyk2U5OJH3Z139NdWRE2At2hhZ8oJewhjYqsfMx5Xf5zIn55iodFtY8wk2wK72CbD/1ixmV4Chf7IdutPUo4+WFAMDAssZ6OKXcSBnjWi1PLM2zdFIuDmhykRR6hqee1ofk3AZUCu5SnvINRoeMrilkliYWEBIi/L7+zPbq28ivwJvQJr2DqrP00koqprkT+52w2ivuiHkdNugCw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QjwXFS8eLCpBU2Tdw5TFebRpQVKn3jzp+UTravvsUbcDJFO14JBm7oAO4+v5?=
 =?us-ascii?Q?+9hPoHwNZ9kebtTpSgx5alFKJ6UN8pusvDkTsgi0NG3Max49exdofRZaXc0N?=
 =?us-ascii?Q?4oEI/TmOWoLlZU7TM8N+ru0vOElxWx0uaSraLGnSA1xe6y7bwliZ74yb6qpv?=
 =?us-ascii?Q?BEjuM31HY1EuHAAKwWfxetww90pWero5qRmDiK/ac2ylmuPMp10xb6TDRDlD?=
 =?us-ascii?Q?s1okEC9VXVup07/I67Ukgos1TLJh2MBakONEP8YnI+LVP8eC0iAALRimnh4W?=
 =?us-ascii?Q?TnqYdccztxZMXTAqBykGAI06wJC8fImSOzSeP/Oxx67JxWYIgagi+KmrFtnr?=
 =?us-ascii?Q?W+/3GIaEDIQiYEVGPANxsHpMRcg1z6CjaNC9KyaXo8dp16cEEy4bdrTKOsj1?=
 =?us-ascii?Q?d79kx/FF5/NenVIUmPobCUt7qEWEedRt/3raCjdzeSsJbwFFp16W5zXKt/fw?=
 =?us-ascii?Q?tEvcsK0y4PYXRGVuJqWlp45tBs7pn6n0Lk+h3lyVQrzjvSpxA/KicxzZXlMa?=
 =?us-ascii?Q?7+gs35TY2VEUh47vpj4Jkc3I/lWRGfKi3pR9JxLq9RqB6P3EirxfmZ66SS6O?=
 =?us-ascii?Q?HqHKjkwCQQQx+4q1pF2xMY4N56X9cZyBnAAKS1b07Yxc39kUsCVXgfUJ6B8y?=
 =?us-ascii?Q?Ghoo6qlPMX2vBkM9Fmi9ZlmODggc+ONIcJmtzNLFsPx0fN9HOSighVp+LZ1C?=
 =?us-ascii?Q?bah0mIeakwKeGzN0dtB3MrkJgl2vHJt/cI1TTTMIyNKEB+ADQo2CvtIX+amy?=
 =?us-ascii?Q?58kluY3uhKs+MC/DA04pF6Q7UknGivyEJekdudok5RIgGNngy/t/n9fzO60G?=
 =?us-ascii?Q?vdGgClDaVsThxQMx9gKUXGciqh76Tk7Kq4mif4m6ianiA+wCjZKddvBrD8fw?=
 =?us-ascii?Q?KTsERqOqXUO9YKhoF3AgBswPlez+MVWpaux+HT6Ap0368AbphD0lNoQ+vc8b?=
 =?us-ascii?Q?HhrUgaP9x5zSq0VKtEJDLCi+GkLSRaNzn9lx6JZf+is958qHqP1xYIz0gq9U?=
 =?us-ascii?Q?nd8pZIkxaxSRL4GFlagfgxDxJRMA71MOzZ8sl5TywlggTT9cNg1Z7mWcBp6S?=
 =?us-ascii?Q?VyTOv4qNi5wCJ4ikWLxNujLO0RUbzINV5FZc9/v00oW4Yzg/5C2RFrfpPG/o?=
 =?us-ascii?Q?c4+cx8ifF8Xd7q/Z6/lcv+jTtvTQW4+9E3tsfuKVCJWdvbCB1orrolb0vwFt?=
 =?us-ascii?Q?CWGFeanFbFcdqVDIijuCZPJilT15p/krgCYbKBQNERUB9G1zP2Kw/5wc+XX8?=
 =?us-ascii?Q?g6N003HO8LxV/ECMn56dn5/QLIlim+SU1Jf6vG9vQqUbDnWtWsvzPJPJUqTM?=
 =?us-ascii?Q?ni0ijZRmT2Ab7XETcNPoppj9DPkxDuBdK5ANR+H3R7+emm18YCDUHFRdyT7F?=
 =?us-ascii?Q?GmSonQORyFCiPKg8BM9V2Nh1J615Mjhghe34fV79r5C4/g7/McvICqkLdkWk?=
 =?us-ascii?Q?YhgXGbVxAHMk2cN5ZPFIeAp6YAABQ0QqK8k+mjKX+HQPjeCAlF1Wf5Ghg0N2?=
 =?us-ascii?Q?ILdz5UGiucWa8qYAQIP5yNtpQqhgkktmoOeiws/ODUXeemUSccGbXOvqnN41?=
 =?us-ascii?Q?0YL4v/JCbjE/OOE2f68xyO3yC6vjI1icFrjI6vf2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c2cec1-f812-486f-c8d9-08dbdf69a127
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:14:57.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JzuRymfjLx8U/qJRXHwm61ZTB5hvn4unrEnwvudm4DgxWClEWG1P0438qxtmjl9w7KR6If7U6pYqA7wciOyFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

This patch adds a new function mptcp_userspace_pm_flush_addrs_list() to
free the userspace local addresses list. Invoke it when flushing addresses
from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 ++
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 28 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dbf040e39af4..95a793c6702a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1568,6 +1568,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 321224e09d40..fd74c0092039 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -20,6 +20,8 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
 
+	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sock_kfree_s(sk, entry, sizeof(*entry));
 	}
@@ -548,3 +550,26 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+void mptcp_userspace_pm_flush_addrs_list(struct net *net)
+{
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&pernet->lock);
+			bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+			spin_unlock_bh(&pernet->lock);
+			mptcp_userspace_pm_free_local_addr_list(msk);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c38350abac1d..54f96e7f7603 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -944,6 +944,7 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_flush_addrs_list(struct net *net);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

