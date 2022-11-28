Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC05364
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 03:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtwsI/oynGo7B5leRr3f1OQgetFxqaPklWC06UAGq2AvTEpFinqMgBx1yrK6mv7VZuZx7z+cWUrwXeXTHUAFyKGvxL40mFv41ZhYjRsKobCVY7jhaQW2RVdVoacBRF5xg4zWWkSyIkERIQ/ElrOVcjLMm3qkA5f867g6drB1o+wH7kRjqhoTbVgJgCuv0Oi9EgZsYNPg5BwL6zjtJn3YVeLumA7GuJYHQte/RmKr6Wo++4PT8Z7K2UhzkbgpikHo9+CulrpYxOdwhYAgXq44G3Ahk50cpyCLzaPKbixNH0csZT790rNSzb/ukwR+RW9iFaz/8tpkFReJypa+m25yKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QEMd8Mi0/PajzdLzuTTF70jgSCn2S+ZVIEDTpPiwcw=;
 b=SPjtMzAIpE3XO5+c8q0wHWjDah68b0j9YIBOEbG12BjZcGw3Budb8wozjLeGyw1aopZvwUYcLdq/O9mpN03KPJJWST2N9vBPZf2FojsjO83d9inA2punTzpjpN3Vb2QQTQOb9UdvGRhxwh9npt9e0piHxyvjHulNjq86JyBI/uePD9CC6tnjcwkk1FADYBpsrP/HgeP9TMEI+P77pno243lTHYQGx6fgwq0WW5bxGandN31oY/8K0k9HrdKZTCC4z3dVFGFBVIr8jgKZvq8Tmr1OgkhiuxuyzqfNhseqVoT12CPvQFHdFkMsJAIDv75i6SPa9iVpQDjDYeWYtW2aUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QEMd8Mi0/PajzdLzuTTF70jgSCn2S+ZVIEDTpPiwcw=;
 b=zw33FVkgpxPe8M/77G4ZEAg3i9sKWZhlYpitlIoUXZzCpmOK92KZK6C8pLWFW0dVi5GLu87idfx6QjmSKAP3C9H9dil6n7TZxhYCR2Ni3j7MyVJ6L7P2Iwjdk2XVLwaG+jehygnoOKebcR04uWdL9mzCqKk6U8c4LeConC/dmzFpQoarznxzD+AIaCM52xfULgBhKqhNPZISojlcoQVTGeCO1G/Ldhh2+RIcSfRUVjs62B5cevoXzypLwxguwJ478bDbxUx1RXjqpwIJiTQa4m87W9TD/ZKAQjhHu8Lg8fdv54tNbFjiS56SNXXU5KO3a2xuwM7DZsttEqU1NIK3qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 03:24:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 03:24:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v21 5/7] mptcp: add mptcp_update_dfrags
Date: Mon, 28 Nov 2022 11:24:01 +0800
Message-Id: <82e851ded78f7d563e6676c3e087b0470cbe451f.1669605531.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669605531.git.geliang.tang@suse.com>
References: <cover.1669605531.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0228.apcprd06.prod.outlook.com
 (2603:1096:4:68::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: e5837b30-b598-42e8-6c20-08dad0f0014e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xaWA29CY2UPjm+B6t9ukpKmZaGAadjt5+/GaUjhjhYyzQyNasMLq1htB4S0uAwTHvraXd6VaWxXOmSXSPZe+f7jtGgvwCyH/QrAb1/WXvMn0TjJid0Z+vbcKlXDZwA5wJwAaLN4ux05ORxPExUeHSYHPJZI1jmAsL8BUQWnI1cpoy9sbjZtHGK1nTGVvb0XZN+ZbZzrbujP8JI4s6P+IrHMdcS8w7RcbJ4ugcMJXPub6voeQ38ak5L3sNN7gQ3v9nlnWrcyDngDR8N2KfjAkZKYphGklsf8fMYQhsbPyA0JNHoY/DGD+OSrGwyWBhfGQsh198S11ROmhHAuWvBtnjTOVCoYLW67z7yZtC0moC7QRZ55J1A4pnDFq/AFdUepFPyOHbV8DicMaHmmKsDwomG2F+xrVJ4WnjllB8eLsZStS3ysWhXANb0sdWpeAnIueNsyZZzDfqQ7/s/GXcD485v66xWYdVdmXlj1UywKFyfuC6Z0H4RdgiqUafMcmyamRLF2dpi/0VZpg2KoBQBDOPylMCMNw8M/JJM4gOptYp4o2+reitoDPTYme1Hyq91xsmeyDcmDpN0pNv0vZmz0dX3/gUuMZQ0WcsVMZZJK82iWFyA0Q1ORGyo71x9GOTTQhp+Z8dU3ETax3j6/ImjS2aw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(36756003)(6486002)(26005)(478600001)(38100700002)(6506007)(6512007)(6666004)(41300700001)(8676002)(66476007)(66946007)(66556008)(86362001)(4326008)(6916009)(316002)(44832011)(5660300002)(8936002)(186003)(2616005)(83380400001)(107886003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SVSWYhoKndCcvsyGdAlLtnMTXPoRuK2Nu+Z+52Hr605/6jjcgPT/mm5C3gjP?=
 =?us-ascii?Q?yhcchbD/nWtSz+7m9yY26kGSXnmKj8J0VquK/d0q5dr5dkTcz6RPMprhIog2?=
 =?us-ascii?Q?z5sjohDG6zf/wzk6geWBnueLyEC14NBKM5EncjZz+GuNSkpTuybBNZ16S7zw?=
 =?us-ascii?Q?uBx4M5x2OgKmTLh84qcF2Nmhg2DyBOk3ZB56TqkCI2zotXzYMz//YZdK/HaS?=
 =?us-ascii?Q?xjE19smq+PZIqtDzc4NgL+aFyVb6Ung/mh5x/xACYQgs5IK61yDrV8TqpnFJ?=
 =?us-ascii?Q?euyyXX+CIJf/raqUIPzYSX8x6OQrvJ5MAGiMr8Q8uMlysdjnY07l0AjpPt6g?=
 =?us-ascii?Q?5sR1vwe39D/RWdBLGpR8tHPrTBp5INmt/sNkBDT4YYlQ+h0dYv1rgc1g9EUs?=
 =?us-ascii?Q?Qte1aU7SYrGF6w8l0xtATrSbnUba24k2He+ZLFhij92Msn6YdvOAYzyHygYB?=
 =?us-ascii?Q?0n6VoH+x1mYkgr43nWC9Yeckrx9AoTW85Po+pV4h9QiFqaz7R2BEE4FjR03n?=
 =?us-ascii?Q?D2+7dM8UGuS52/yF1feJeo8qrlEel7OPC2bEa5bKFIfYVt0o2xa9av/lpYoz?=
 =?us-ascii?Q?xBxZZMqfDAx5NKvR8w+iXYIbEB+iGRbLb5o+VF6rR3HgZyEkdlWuOhBlaLj9?=
 =?us-ascii?Q?v11+bxDEkwNFStQ8hnwcWsZrULcOAfX5vj9h/mKY9WonsmD+LkPp/M8HSKMi?=
 =?us-ascii?Q?zje1yg0DdLM6+FyJ2tDNaezhYBUzoeMNRp99hSXO+j3vO/9MJz/rT3oDBx9M?=
 =?us-ascii?Q?vUCRQmcp0q2biEXRz34lDFG+e6LMh0G/cgCAOOO6mK3Ya+IwjTqj5ACkyP06?=
 =?us-ascii?Q?5j5B7Jn6ElZDCreES0q9ScgEZpaM0z0INLsgQsLqOEMH8jKExHLLH/honaFG?=
 =?us-ascii?Q?mZZGrMGPwBzvu8XwTadUCsAYjLMnj22q1fzzSN0p+p9Of0/SVAXK4uKtuVbK?=
 =?us-ascii?Q?BRdxrcrBx2uo4muPncckxEf2znibEVvws4ONAiklVvX6zaP35k+R5TrvqT3W?=
 =?us-ascii?Q?qloRJYau/HG0bX519TS3MgCcMeT5xuRhZ8SAUw0VguyXGj9wWpiuAtLX1wnS?=
 =?us-ascii?Q?okEFW/fAwICKqTS68PPPFE5JqR2/bxHJG2PvDkrlbKaN9tCKrLlo3TQhlL/q?=
 =?us-ascii?Q?b/E4nG+LDuSpAgGcRE+C35RNXtyF2PN9jZsjCegWLwBxfmPsexCzHw1paonQ?=
 =?us-ascii?Q?lRZTMkMzw9iUzwXub4IJ7YQvuMDz6AvW9+mP20vQ3ADHBxyhQxwR4lHr5tTx?=
 =?us-ascii?Q?Tfvx0SrDMdhlR4skT/xNrj6/8NsqR+PZK+n697y6HVjIlCjo+nFc2j17+qeR?=
 =?us-ascii?Q?+PFuCq5zcUtGeyZnQ5R+OA1OczH/QTYcyjFzCpPdPJvlCv1OGXt+cpOQHkAv?=
 =?us-ascii?Q?/H1SPuAKuQNltTmo8CMpYoTxOCYSvMKjyibGzA0R+aZfCzwycHJg2YuauCJm?=
 =?us-ascii?Q?Pp8yQ0zr9gpj90lmAMHzml1aUC9vj1Q1NF3EARh6upcchtmIvMSd9F5HcaSm?=
 =?us-ascii?Q?z13qnkWU+271qxNoH2eayH+TIc/gsucow9QW+0q1GDZIV05rA2uXPAxZMPrb?=
 =?us-ascii?Q?9zJgGxbkXyKQdZLje62Zia3YU3uAar1m3iOdKElLeU57xO3fc039YviC1lZx?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5837b30-b598-42e8-6c20-08dad0f0014e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 03:24:06.1647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELK3BjkdKl1CM3t6OEso7y4gKsx0iLq1DNRwdq/BrznbL2RZ5x64YX07HXT0nSL9uvV8MlOCNLBdVec/qj5O6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

Add a new helper mptcp_next_frag() to get the next dfrag of the given
dfrag.

Add new members first and last in struct mptcp_sendmsg_info, to point
to the first and last sent dfrag in the dfrags iteration loop in
__subflow_push_pending().

Invoke the new helper mptcp_update_dfrags() to iterate the dfrags from
info->first to info->last to update already_sent of every dfrag to 0
in the redundant sends retrans path.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 28 ++++++++++++++++++++++++++++
 net/mptcp/protocol.h | 13 ++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3fcd6af96721..23116b0840ad 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -992,6 +992,12 @@ static void __mptcp_clean_una(struct sock *sk)
 		msk->snd_una = READ_ONCE(msk->snd_nxt);
 
 	snd_una = msk->snd_una;
+	/* Fix this:
+	 * ------------[ cut here ]------------
+	 * WARNING: CPU: 6 PID: 3007 at net/mptcp/protocol.c:1003 __mptcp_clean_una+0x243/0x2b0
+	 */
+	if (msk->first_pending)
+		goto out;
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
 			break;
@@ -1112,6 +1118,7 @@ struct mptcp_sendmsg_info {
 	u16 sent;
 	unsigned int flags;
 	bool data_lock_held;
+	struct mptcp_data_frag *first, *last;
 };
 
 static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
@@ -1502,6 +1509,23 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 		msk->snd_nxt = snd_nxt_new;
 }
 
+static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_data_frag *dfrag = info->first;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (!dfrag)
+		return;
+
+	do {
+		dfrag->already_sent = 0;
+		if (dfrag == info->last)
+			break;
+	} while ((dfrag = mptcp_next_frag(sk, dfrag)));
+
+	WRITE_ONCE(msk->first_pending, info->first);
+}
+
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1515,10 +1539,12 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
 
+	info->first = mptcp_send_head(sk);
 	while ((dfrag = mptcp_send_head(sk))) {
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
+		info->last = dfrag;
 		while (len > 0) {
 			int ret = 0;
 
@@ -1572,6 +1598,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				if (i > 0) {
 					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
 						mptcp_schedule_work(sk);
+					mptcp_update_dfrags(sk, &info);
 					goto out;
 				}
 
@@ -1657,6 +1684,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				if (i > 0) {
 					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
 						mptcp_schedule_work(sk);
+					mptcp_update_dfrags(sk, &info);
 					goto out;
 				}
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index adfb758a842f..782dcfd55429 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -358,16 +358,23 @@ static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
 	return READ_ONCE(msk->first_pending);
 }
 
-static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
+static inline struct mptcp_data_frag *mptcp_next_frag(const struct sock *sk,
+						      struct mptcp_data_frag *cur)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_data_frag *cur;
 
-	cur = msk->first_pending;
+	if (!cur)
+		return NULL;
+
 	return list_is_last(&cur->list, &msk->rtx_queue) ? NULL :
 						     list_next_entry(cur, list);
 }
 
+static inline struct mptcp_data_frag *mptcp_send_next(const struct sock *sk)
+{
+	return mptcp_next_frag(sk, mptcp_send_head(sk));
+}
+
 static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-- 
2.35.3

