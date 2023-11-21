Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3E3C078
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="z8ZUOrPJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF6A+myGcuDDj8PPqwCfVWcBPwT+H9A+HWqxvZ4ouhF0xsOBAZVJZysPgTmxpfJUYwpcmYHkFj/UMBGIwekfKCW7v5wGeHO5o1M6ZPM5Wjm8HIAUxXx6s8Rl80pY2KT/eLeNE2KCAt7UVxi8KOUI+I2+rxvvK7pyq4rDatgJTHO6aaqkygtfZICA/ahKtKmswCWCLvFX3WxqESmF9/4QgQfISvLvBLrsZrS7qnH2E1DiOleJJ42tfFJIIoQi3S2iMf1lE/jlivncoc1AbPneVr7nwE9dsjO4M1IPeTnM8B7qlE2M70huCPgP5YH/xfMEfbt3jicgj8qZTQzr1OMxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=DjqfnqvBPxP1UF5G/TSb6xjtcyOiLPDxQb0exeem1IGew49+4lLdTvEw7iDeOXFiFU206MbIwMe1KT0l6I/1TfUKiRjVDefy0ZvrvwriB7q+Te2hf0bY5n0ClZVV2hTPQMGhpKoCfSD6ro8nzXNttExvTsuAV01wpq86oQy5zSgN3BCZs/FoRoRhhxK/diVFnQHTczXE7PzzHtSR/gourp1UXyZRC+Q7ejlgg50OozLzCAmXKknDj0u0AAOKwaZDKzRVBrKBE+gm7TCBrzRHTicVv813LZEREFfkVsz1Bn7g+6UtOsP3FHJ2RTeWbqU+sX3F6wHTfnxZlFHsWNqBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=z8ZUOrPJFTfEmIiA71fgaoaSWOLE/7+8c5thbrBQrmRKYLgMvSPgepqA+qqkjdLh2w9y9q0LfsmlmECa4yMnRk4/Y562pXxkWTDERMYoZFLRbiKhotJW3yoe+gEsI/UOZ/99lmFfRdq7Klw0zk88MsDNWD6bU8wb5ZtFW0nI0p+tgAZ4Px30eZe37rB8G6T2OQFho8++9kK6kry1DI4a4ltLsY+u/lwu3UwZ5q9ulSJZPExCqQMttt56LbaVFZYZDRIaWfkP3Pc490ym11Ri580DawL5te4eFUGCKYLOTyGgqBOBdMUgiroVMHOkwgF2QPBmRC8RuI1l46ww4XMZKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:54:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:54:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 06/28] mptcp: dump addrs in userspace pm list
Date: Tue, 21 Nov 2023 17:52:29 +0800
Message-Id: <07f28a3a25e8d5448f4bbfac6fd27310dd40adb6.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 679bc27f-a5f0-4c0c-0dd3-08dbea77cce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N8H+6j8HCemGMgTYLycNl3PMqtFFX6VwGXUuV8etHf4HoC2XZdpwr3McP2/OG0VmEEbO8zlER1FYAHWW0ncVVrqyRrpBlb3QnYy4j9e2caUCatP2gZk6E70/5VZ3x8kXZzPb2drU081X8Yr1ET+B0aKIw7oFUnmT9d+HOUe+xn1h4hPqS7vc3m+L+g2p0dg25G1UHM4Vc4f6Ycn91eC3qdKHc4w6WLvJVDL0uZuCFe1EzxCc9kcjcI7tGvrvMzKfi35KV/CUHizq2Dci0/SRh2lLRIHpUzyHqup4KgqSTRLXpkAt74ulesv/yEdqAi2ON+gpjV35c7GapoBMOhuw5Qv0BYwe5GNNHJJRb11Nc9xvxOHJVWwiNSxR6+Jvb7tG/MVtpjdVeJk/LnUVgdheyW/YoQMD/EUXeP0I1RddMSYNmmTs/sr3K3gBtv63IOaxN7AWiPEhjbgS+mMqF2Y/cfujO8SmzRcxQktVKQdNnTBOpyB2G6asmegZbtPfkdQjQd5Yis9RqFLCiRK2UxP3WXewCrGua85Qs9i9voPvnoc2foOSag1ID1PEytiYAfI7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(83380400001)(86362001)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OA7Rb724K4wkhZ/OVAKuTgQcKo21m9iQ5JWtklvsr+MnfRrNMysjNU41Wcgb?=
 =?us-ascii?Q?aOF2rRD+ODLO1sMkwMP3M3n6zxTsDvCnqNkLCIWQcAX+PiPWkZoiKwKoGeph?=
 =?us-ascii?Q?KCVT/WN4TbAU+puZwj4ufmaGTABuC1gJ9jbbjjflGoGTxO4O9lylErnERvjD?=
 =?us-ascii?Q?if7VEbAXc9bFzhfcVdYl+AEHkp6erwzze88NslIuXfqZRPMSyn3jFZNmJTtL?=
 =?us-ascii?Q?z+n9b9l8ndSkAbb66q7bffv/554uHQFp3zUkOOJseos7Z5lsAlSPRD+b2qMC?=
 =?us-ascii?Q?U9XDxdVLhhrnQRHFJzRLb8a4UH4LDc2YFljEcw6yBZHy/8VhaSZZc5FImkUk?=
 =?us-ascii?Q?RJIdGY7aE4qfYDIgqlvuDx1UHs8OQOxclBARjvCCNsWfcVE3biS/lvMfnr32?=
 =?us-ascii?Q?4q++q1hSkxb49iTlZbrNqg2oRXAUuSJzvdESycHlRvzKNguyoIa0NkvMGg7l?=
 =?us-ascii?Q?YWRbMKR8Od9yXnHpi3Gps0zBH4vecCxN8BfL0OscrzaL6VtbkieJwqMmO3XF?=
 =?us-ascii?Q?K9dab1oZhZliBWdCBdxZrzuUQhQLVX9DJv9MuBGBW5ch9U2FW+EbAd4aSuaR?=
 =?us-ascii?Q?jXel0KrNWj5dFwylF9K23fhjmVVKP+0M2JKZaBveUQ2+qMX+6l0nIMUvhDoR?=
 =?us-ascii?Q?P3ZL+eaEktNrnTy3plgQQOpU/r96H3bpQ9vZQeC5rFvJZmudxE2MjXkPY3wM?=
 =?us-ascii?Q?8PB+PDKAm/N06K3JrXQA+7b7Nir7kIhudyd4PlTB4W/EgYt1E3dtmbNPX+2m?=
 =?us-ascii?Q?LYNIVT+77Ixqt4pasBCa+VomlbmaLxzfCVwryc+4LopzyKI/jTxERBozzCsS?=
 =?us-ascii?Q?+IJ20jDODanOuRwRHpmfur5DCXYpaQzrpfKXhdK4XDh4yc7O4GGpPAQKb4yH?=
 =?us-ascii?Q?495qFoaGsIbYGhM4SYUaf7odwfczPaHVvMkpotlstEdRxh+puVnyfq4TyziH?=
 =?us-ascii?Q?aixRUBnJqIDuHbw+lmLoY+RCqVYYu8XyvW4xag2rK8/6XJ2d4tihs4aal4ys?=
 =?us-ascii?Q?G8Ps71Kj2EXeNEQWWaQNIvhgWNUqnqLZXw4PmRP5aBiCjMpN8l/halBwQaGu?=
 =?us-ascii?Q?Bl8I6mCa4lcAPmDrE6A6Kv4DO3pfkcP49ZVDdQZsDShz71dXXE4IyBeGJKNb?=
 =?us-ascii?Q?8xCOZTbq1yCVs0OcMTGhvaZM+A1SJPgSPMirmJ1+2KJBZ45nFsDCcdDB5zPt?=
 =?us-ascii?Q?ATdngZZb0odzPopP2nfuTmCfVMYuRG3K3Ay5n7ZMBgdTbBg7JtB6Oed1doGo?=
 =?us-ascii?Q?gRkId3euDpjeBZLErCvWOKuzbwtBzRy6vwzeTEsC8JI+ODQCzpue/MX8qxmr?=
 =?us-ascii?Q?RoZtfxudNwgfUeIiM/6NwMaZ6GSQG4ecjuAPRYNBdccW2lw2OIEyAtXMkagt?=
 =?us-ascii?Q?juI1Py62UfVVaAYACwcXEpkJqvfemgIjwBlIxggs3Uuinx5IH4XVJkRWtuX9?=
 =?us-ascii?Q?rr2jWBcKuHuaPFhAddcSug/3gP2HLreTi1K2hK4fLLCFcvW/RhXg8F856eRp?=
 =?us-ascii?Q?4QzlTQXyExNjI8DGjg+fZTN36yb51r7QjiR+Rdv14K0e7c4gNq5Ulwh2Hx6k?=
 =?us-ascii?Q?QiAWxyFKLvghWK/YkFOk7PCO+nov96bacsrWRxjy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679bc27f-a5f0-4c0c-0dd3-08dbea77cce8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:54:06.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAKho1U59ryIhkRRGme8l8cKLqnIDiYuC5F2aUEeKCqP83dVZ+/2VMAQlPIqeA8ogdC1fHRlwxp9Ix25EtZGRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

This patch adds a new function __userspace_pm_lookup_addr_by_id() to lookup
the address entry by the given id in the userspace local addresses list.
Invoke it when dumping addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  9 +++++++--
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4cb52df57ba5..08b4211fbcbd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1673,8 +1673,13 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, pernet->id_bitmap)) {
 			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
-				break;
+			if (!entry) {
+				spin_unlock_bh(&pernet->lock);
+				entry = __userspace_pm_lookup_addr_by_id(net, i);
+				spin_lock_bh(&pernet->lock);
+				if (!entry)
+					break;
+			}
 
 			if (entry->addr.id <= id)
 				continue;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6999296cd5db..5e45e36ce1d3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -549,3 +549,28 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry = NULL;
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&msk->pm.lock);
+			entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+			spin_unlock_bh(&msk->pm.lock);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return entry;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 88f5b422f941..c30e59278080 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1021,6 +1021,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

