Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140053.outbound.protection.outlook.com [40.107.14.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E461A7B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ1v/eYGVP8uv/tpn9/HjsyZcCjnZSHE7ZwXQU5NLVWfLySZ1PeTjKqXZvL/S6+1PrQSOxAZs9UYXtYK6k66aegRdf8xIl4iRPjD550LPHwYVizx5JqR+PSwhZUtvhmQ6+9vA/VMJvz/PAe/0Cvgg5eU0jRnqIimcmgRyCXfNN5f+7YaMqRTPId75lLSrq/FDm+5SyZ+wBtcDLGBM10cKG1RZGkR6aefS+hV4SHFPZLuHfgYV400DjGtG18y9cy9RyioNHW05P3xqAM5Hr9ob8HSdbxbTK+IeeO8aaY4D9Fm+5YCgqfVKUigjBo+94UqC5yiSmrm9EefQEIlPB1ELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thC1hHV6QaryPlboYWmmIE5a+gRB3JRnQoT8fuJ5Ozk=;
 b=NyX5Kt47O8t422/rQO8YdfJxS5HCw1Cf+j22CAe51ZJ6xeygNnyFM2hyyEXPg/+5yFozg9qHQcryzYFmmF+WanGUQEFgFYMFErQD5jCklU245oVYCQgeIVjGzi/tALp0f25/snzEORbufbDFgNQMIrMe4hNo4qV/Dhsas4ebbMu+jhQX0HR+th8mjpFthOZ3sl4+ZYCQLKd871k6aDcnSltxRGvfIXx8IaFrXdYg8SS+gEoMsw8wzONpQs/Uxd4mFkXvcwvCF6agH7g9Thej0XybqiZCPaKwtCnBU6rdXFhji55QL9mGMTF0j6eNcMjlyzKe7DTbAhfLZOKNHMzBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thC1hHV6QaryPlboYWmmIE5a+gRB3JRnQoT8fuJ5Ozk=;
 b=WF/6u7iplbiF+qQmRZuL9NyD1yXGYkqIYf+ftJFcDHfEZQQohMLY5V5I4SrauSvuOX2kKLhDVz7cvHEmV1xbb8838475ApCdzLO69Y8bGncaYvxeevScjsNU1m9tAwYzci21zkJE/ko6hrYFwrSB7TFgEbJo/xmEu28qvGoCqUOINyHsuKk1lX/37XP+KOAy99L6h9Lmew1VtkgVN20056H936NCR+cAzmkOek206xyukXoZnzfa40vpl6ouc+rlW+Z4c5pMq6q1F10H8/wV0aXRQ/HRw+Ojdfkk4+MVPx1q7jmM1PwH/Si5bSErGqYZ+k12qYRSk9w41AF8k7NJaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:06:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:06:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 11/15] mptcp: use get_retrans wrapper
Date: Wed, 26 Oct 2022 16:04:20 +0800
Message-Id: <c3a0ca135397a6b5b2e0d4957266885b7e4deeca.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0184.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4b999c-4fd3-4b98-8472-08dab728f889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RGxC/xwJ3lUQeQj3Wz8vOqqq4CYdFS1jG+JMqi2BvueJfI8ZqHgYQaFL52V34u3qXabv/sHO6sg/ulxs/RDuaVgVntdg39Gu2ebBC41oTcIfJ+ndg+ATWU8FHaMs/Xe4TWDN+6oVinoJhePVk9Bft7xM6kM2kTuiJQ7h9Cl8+nUkP1An17fmj2qLGa0pg1duA1g23vSMO8YqBCI5vVWP8hKeDtj0bTb1Nnt5XZE40yGAtxO5U9n4JSwSlahyFKqYKvz7oGH+LXCsF5BT0HqlZ4jdlRREWD9fAl28ccyisT9YF/0xZSrAK7lbQbwxAPF1ZGik6Ls1ZOZNfs7Br3v5lcFbTQYmSq0Q5XrCsFQHRzpuei81bHlMA66w3LE+YFFwpjoxO8I/oSVEO+JVqp8yliVvuiuMI/pfPzI9Qp56RCPxfRTCUBag8AkgVtiO8YjnkFui76+n1hzUPLprxcMMR/XR4CuGj8F992AGthlRcPXoZOC10DNWgaADVIpA28B8SXqyKXe1o/Yn+kdsHH9HBLoYNPHJ/85j8ud2S5uXBAMZVaBE5RuW4fqVQnbjgNdUFNjsKSSPlhnEiCcqimGPIhGYToE253hxN6X1PWGHQLf7pWcq8AwBdssgLQIX+h6YXhzlV76smiTkXDezANKoK482Yf64yv+5BgGR7DWY5nzP2TKDUO/BuH4uAXLUFuPEVcSN0M5MqRC3EhsVvn/gzdPRk6aFnbeaKsZmBWHYzBxqJq2o/pw2D6d9Jwxg6YzS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(8936002)(41300700001)(2906002)(66476007)(66946007)(66556008)(44832011)(4326008)(5660300002)(8676002)(86362001)(6916009)(107886003)(6486002)(478600001)(6512007)(26005)(316002)(6506007)(36756003)(2616005)(186003)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DKzfpOmdI1JH0SOlWXjdhxf13nBHeLwRNyzdeDIvc79OENIGb+dY0U0tZwy7?=
 =?us-ascii?Q?PW+j0Hn2CWpSMvr9hRO6h3dKPXjOxV46M8JMuiNe3l6sFzsquNWO0Vy8nSGr?=
 =?us-ascii?Q?2Q55hSrD2wwlkLHlyMOE9TYoc/ZlAbGRL5Nv5fb7sjWZsMn/1IsE0pw/9F7j?=
 =?us-ascii?Q?QCNZBH/biJa9F8gtHHOYxT5u/fnlFgu1fzrRlUCWgTiURRZ1qcBhFCUtTQe1?=
 =?us-ascii?Q?JfnQFaiyZZUjHGLVNcW0VZ8IEVwUZZCtKOgIh3ygqjLHBXVBrHOmXmHiXq03?=
 =?us-ascii?Q?klC177AFPFsxd2yaKDZ7lkhLLWMo1/j/FdGAfmqI2VhxwhnTK7D9kWXXrVkS?=
 =?us-ascii?Q?96dwiystjhk52nyJTDAeH8WUYfF0GLPiYDpZ2UvM1Gae7IfnvMNV6jo3AHKw?=
 =?us-ascii?Q?+NJtzC2BJ+GgJkvN2aICQ83kinx15j6okSRgeVUVgvMqu94x1Hiaq+PM/pWV?=
 =?us-ascii?Q?fG/mg6VNG3m+NWR5fPfJimlxLQSeSuSmEhTJSZT+2f46RUZuwoTjupM4JGba?=
 =?us-ascii?Q?6piu8l/y6HxK5FSWJmfs21YMvEqzW+RVXW8iEnw2ys1PBudSRN3pMxravFSD?=
 =?us-ascii?Q?PT2V66qthxHgdmNrGmUvzZy+f4v80uU4efGUBuggitFvJJj3h8RTLI3oMIFy?=
 =?us-ascii?Q?KUzBJ7/PKWSwmTJ0LnWIvIC0j2Fw75+zU/2Yh6GleEH+jywuLmnxwaywFRET?=
 =?us-ascii?Q?nhiDWFXzbknFxXN0y9nvqqDPZpHPzIscIHh2myjQqSmiGN/wKvzpJJ2QBYwh?=
 =?us-ascii?Q?5zRwor8SiNJc/7LVEX7NavSyGCUTEIAqSqhMvYkTwj8X8YZa5fnbibyO0bKU?=
 =?us-ascii?Q?Ja99aUqknnlCHyakjJF2omXHioNcol3Ohn6q+leJqjIFSq9KkOvWL9x8U+CC?=
 =?us-ascii?Q?rG/uowt6HVfIL6OXypU68cBbhu1Yqrp+c7mbGWWWIUfNwHdDWTVgsUE6UmG1?=
 =?us-ascii?Q?84lpS4BmNTnb2t0x3yLjJ4XtwMhaaBhj/SWpcLXzGnjSXa02qGuiE2y0HiCA?=
 =?us-ascii?Q?1ylyRwrD1uYmyBQ3z+X0t2QC+0z0HkcFi53R9ZU7b2+gMS/NQ2tQ2tPaJnGp?=
 =?us-ascii?Q?BL9WiJKZti+W/5fDKFqMqJR9KfCUqb9X0n2QA2a3+woPEtKrbmN6yRepRn4+?=
 =?us-ascii?Q?vAAXt8MXHwON293pDleKmhQrZ/z4aLzLxsOycqujWhl7JD8uq173qL9dWcNM?=
 =?us-ascii?Q?OOByqHQwt42cuN+jRmCHA637fkVPJv/f+Yf6NeksB+OyT5GMDwcmjh0UdnHn?=
 =?us-ascii?Q?UguHez+F7p0gUNvZ2ipmep0RyHDsGccaWTl1rSgj/Q3Fzq8q5lg2sNHqra5L?=
 =?us-ascii?Q?Cv6dBMw8VAI0QDQPYM73tt1YS+De6He23Ui1LrqHbOr/zYqcHJp6uIEqmZvt?=
 =?us-ascii?Q?WEdrNMdLvTH8OwsNIEg23Nj58sJzQ+BeQQnfqA2fKy1P9apZPtVzclpUqab9?=
 =?us-ascii?Q?lFXaMQeuml/cod/AXEakBZkooUmxZXXKDuvRiwyxbQ37XLobm84QyfeluJFw?=
 =?us-ascii?Q?zJM8isXc6J5AVP5/aghTV8xzF1mwAX+Ht7svSNo3p7qeJcuTrnTMncPXmkWH?=
 =?us-ascii?Q?wU/NYuc4e/zbCVkFD98S2X8YbjUZRE6px9vpJwxHXP6/YMeuXiWO2GUo8s70?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4b999c-4fd3-4b98-8472-08dab728f889
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:06:22.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5eoiVeyZ/60YNzdOJiDyomEeR+R19EqUGQR2quT/UpfE9HB+A+44ktTYkVngty9AY+PaUZLyBZtxrPQZ3L9ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777

This patch defines the packet scheduler wrapper mptcp_sched_get_retrans(),
invoke data_init() and get_subflow() of msk->sched in it.

Set data->reinject to true in mptcp_sched_get_retrans(). If msk->sched is
NULL, use default functions mptcp_subflow_get_retrans() to retrans data.

Move sock_owned_by_me() check and fallback check into the wrapper from
mptcp_subflow_get_retrans().

Add the multiple subflows support for __mptcp_retrans(). Use get_retrans()
wrapper instead of mptcp_subflow_get_retrans() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 69 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 24 +++++++++++++++
 3 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 277f1de31e65..f2e592d53073 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2241,17 +2241,12 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2525,16 +2520,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
-	size_t copied = 0;
 	struct sock *ssk;
-	int ret;
+	int ret, err;
+	u16 len = 0;
 
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2553,31 +2549,46 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			u16 copied = 0;
+
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			if (!ssk)
+				goto reset_timer;
+
+			lock_sock(ssk);
+
+			/* limit retransmission to the bytes already sent on some subflows */
+			info.sent = 0;
+			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
+								    dfrag->already_sent;
+			while (info.sent < info.limit) {
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					break;
+
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
+				copied += ret;
+				info.sent += ret;
+			}
+			if (copied) {
+				len = max(copied, len);
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+				WRITE_ONCE(msk->allow_infinite_fallback, false);
+			}
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			release_sock(ssk);
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
+			msk->last_snd = ssk;
+			mptcp_subflow_set_scheduled(subflow, false);
+		}
 	}
-
-	release_sock(ssk);
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cb8ea1eadbae..8b1054fc2c3a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -641,7 +641,9 @@ void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 063f5005b2db..4da9b1ea2ef7 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -143,3 +143,27 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	msk->sched->data_init(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+	struct sock *ssk = NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = true;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

