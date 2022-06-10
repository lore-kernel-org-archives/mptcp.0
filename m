Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130057.outbound.protection.outlook.com [40.107.13.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCC7A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 13:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/GAAQV+asqPuPWF3VvQt0AAaRdpPRDgDlweB82QF+7i8jjWar0bxtnssKkJZAnx8uAxTqCzqK2ChhcOhXmoCnWvBHeDyNF+sN6kxQGbJDy8Y5riDv3yZOsj2joL3s9DwEMHrLpwt37ZTiZpq8uT1+vCsA6L8ufkRK4dpau5d+pmbBBH4SVxrzGIAG0jwYvxwZ+dUYc8vliziopYc13CB9Nxxd0y+dzDj8i0eeulnuNB6TT1bj59YouRkZoHrxRHrLUV8vOsxI/PGZb7yXk3JBt9KEi9Y41hXT5L8xqGabzF9yNzPIBDsMUFD7DhMgYPaeiqZCVy1GW0Yv6oDyZxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wv7CiusYeICfszj34mJ88VjlU3IV5qAk5TZfmNFtXnU=;
 b=mIRrDuDZDGENes+LAkMxtDZgll2xIhZgrlbl9TZAja9mUwEuGejqDKcmDf9st8HdUBm76BaXIVyCUgSYoRl/aivBXj/Iot2PhRk8UX7EZfnwLJylIm1WRCm0mQBXCMb4Jefll71oWdJYTy3nE5DEx0LlIEf1Ct7P4GKIiUH2TUfL1E+mUrzkFse2xbASdFMitrRQ7zzmfQyrzhF+OFWXQjqLHxfx1H9jtk5sAR5liTdzU0meFAGWzvFNyohF01ZV8evAD7ttGbhwBLVT0KGtc2aXQk0tRZeYusC9hdkXy0vp3ilGjjfHknlzgamDvqOP1U1wnI8eEZuLnw0o207VBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv7CiusYeICfszj34mJ88VjlU3IV5qAk5TZfmNFtXnU=;
 b=iRC1JtaOOF8TvI0caqeWGuW/RyWttG2+ilq0HiOQZ9xUog3kY9Cl3MO+wD6HLPKWaKx6uK9/qPNU62x5nE7NKzOuCbFMU/4ii+Ic0YGRKEKiOCp0ioZ3lRh1gCHwaY0Fc+dssHqzLTB+zSc5/iz23hQE8wjLEvoY/Akcf1SrGxoMvyFg8yAZ7QJjclsFjuAmbagHZeNyLFn8FB1ls8QsRGs3JRSIIeKXFDuAY8+kzh5jx6N5WUbndb8rLHnntuzDKXmkroLaO5ExkTgTtlHFC6DJ7jIzr58teZBeCSKVvdjwXgcqWYpxBEQ+j6ac2KZSRDnDcCsiQn4BqeNwQFDoUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB2925.eurprd04.prod.outlook.com (2603:10a6:800:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 13:06:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 13:06:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 2/9] Squash to "mptcp: add get_subflow wrappers"
Date: Fri, 10 Jun 2022 21:05:27 +0800
Message-Id: <da449b39ad40660b583e1e93909909b9b563c7c2.1654865847.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654865847.git.geliang.tang@suse.com>
References: <cover.1654865847.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0190.apcprd06.prod.outlook.com (2603:1096:4:1::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64fb93a6-e63e-448d-85de-08da4ae1f753
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2925:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB2925CDCD2E88E73BBFF45910F8A69@VI1PR0402MB2925.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WQmTh0YKRExUutyhVibhn9aSeWCzsbgKK3PvmIfdVpp7BASAuf8DalMRmzj+ZlDJszlxsKn37/HbfxTLuc4C1drys/wP+hS76x90x/wXVlw6WNIb4P3szihVugBcXzQZwm3t36uj/pgLHHmERuOYW9BsRtT7tc3W922JD2hbFH0TQnP75SP9iuvxzEZ96KbTQ8kDXPRcICSQ9fXEQSCCHTMH/ZGvEBW4JSAYor/oFoD1VKFhzV+omxCoe91EUqCt1WoAIWc6YYTkcEsleY8K49PRDwEwtP1OVhpW/OWLcW7tpi9d/GPsoRYdHN46efeD28ToQDlJ+UsudCXgZXGnXMj+Q8raL4BDrCMjDy9ewSiZ3vCYptxZK9xFn6NfkN9DOJTCmmAuc5YFDCJFcKi+jGCpaLznS05Fq6z+rNmWZGjA4TBI69uxZ2bTiyw5Tzui6sk+rZWE5NAmW9pr5ro8vRrfq9sUAYktS/5Ggxi3IT3xposvLr1WjBPFTtTDwjh6H1Mwmo3pX6I4pLGGX1xt9GqeuPpEGJquPonB1bQ+S/V+7MTTFD9U90KebSX/jK6ruJMCN4yQ1SaG95Gcz4EPHoigMkD58Sz79gQ7sMncOQJZI0Ef1lO7I0A2QuheAH26vxNwHemm2qmrKqbPGsA+K60a0AIboC6gxYQYh365dVnmYEg3UpLDlL/BvcLpaRE0DbiBcq4JfhVkMcwrUkk5rQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(186003)(6666004)(107886003)(316002)(2616005)(36756003)(6916009)(38100700002)(2906002)(6506007)(86362001)(8936002)(508600001)(6486002)(26005)(4326008)(66946007)(66476007)(66556008)(8676002)(6512007)(44832011)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1zw7vUX576cnr+9c2r2Hnwab0E5CL/IXZUxrX9lZoGaut+IQ0yq9/r+Tb0vl?=
 =?us-ascii?Q?kwqnsd6YCg4ajTM3EfEOeuXdCj4/Q6rqFpfHBl2VD75wZQbFnFJodMUv1GeU?=
 =?us-ascii?Q?nWs9k9Iy5VeFOOLTAxyL6eARu7jxLSVJfs4f4s+q6nG5Mrf5+vt4qzEWcovE?=
 =?us-ascii?Q?CPBYuwaxo29q478KFdKN25cTnK+/1HRGZROXoLyB4q0Y4Y226BOjrEY0L8TA?=
 =?us-ascii?Q?Lr1JEk+bBmIpaljtFJuYA/+EogU6MMfhlhITlboaYYE7YRQHPGNL+fde46M5?=
 =?us-ascii?Q?XJFhjnTyfjHr/3X2H0r5Bj7XEqZl2I8qFlyJajlDQNZ6teHBCEkzu65O6sW4?=
 =?us-ascii?Q?8NC4sAb0KNMcH1ZacajWl6t/1zoFi8Ue6BRQVA0aOg5jM9zH4ANsPO6cGA19?=
 =?us-ascii?Q?1z7CT+iNe8zjTchpl7F0ddfRQhGJJGmBRTOiFmo+u8UgckF/ODPUDk17PIxx?=
 =?us-ascii?Q?loAsHypSVhdvjYIVZQUQpwmwdoxXMUClzmJNfy0ygY3luJCh1KxaT5lRZJgL?=
 =?us-ascii?Q?BhdLXVNtkuegiPoC+S3GLb90RRVSzS6XXBxQ3meF6RyO799KLLpKh+gpV5vs?=
 =?us-ascii?Q?gUsVuoLHNlIQqoldeQgFpDt2oO0ElyhiabW0Z9ka3QZaxPOB1Qv41PynGL93?=
 =?us-ascii?Q?bQ2cwZrhQmkQ4os4yyHsvauueqLjF7eerNgaLakxvpW9kdhlOhaFkYcUDn12?=
 =?us-ascii?Q?vmLDOwv0/h/qRr2SyjifkuhJLlvk9rnmfu1/tlPkn+M3Y74MZ0G4+exptn40?=
 =?us-ascii?Q?cFDeuwErGqa6RFfGyy3eSn9v6mlzJnQ2ExIUBbuqr2BWFLbCE1tExIH7dbry?=
 =?us-ascii?Q?8N0I+G0qFxd3sMlrE/KlHJoJXQ4RWoA9ZIIyEeUXjd/GAMIlxwYBUl96qWn7?=
 =?us-ascii?Q?CZBI8jXm2WhG8IBN9vD5hElpN3NdhbGS/EU4hptDMiN6Mss9uixtY3SqjkIB?=
 =?us-ascii?Q?cBXFOrCXTGEMiqjJdwrC28ySvT+ewofT6eo1OdlYECKpLsmx7IGN7EQa3LwV?=
 =?us-ascii?Q?xPKpGU1hzACbuG9zBSBHH9nExnTdy1ib1xN0YPRRVeQr9K/DjuCb2rUhVWCT?=
 =?us-ascii?Q?ZGaP8iuClQvRuDXrppYcL5ruQGwrzQ4LZ866XfaQQFS/lzHJs8Y9B/SPEPwt?=
 =?us-ascii?Q?xLk8IgBo1WZ5VpYn5WePAzooe9gDa8pAO6mkkAqfFTRRQZHHkxmteeJpThDT?=
 =?us-ascii?Q?beOMdQ14KO91Bzou4aeVExKt+TSHXZk1tMLCe43OnbMPrc+hI9C++38jhbGf?=
 =?us-ascii?Q?h2CamnGPi5FhzT1W6E4FG2cqdyg8eD8LdvdSkgqYoCt+gxSTT+gLR2NIF2xo?=
 =?us-ascii?Q?vEGPEZJYD1mEolLqPt1ow8/DPkfL57Mp8Y8t4Ba1T9U24IScRPOE2qDsJh5K?=
 =?us-ascii?Q?nj1YBJjWpYX9lqj4eDpmPUcLMd5PrHH45ItFVJITQn+8q83btYVreC+VMmcR?=
 =?us-ascii?Q?B13PVJb/L7KAgaydxsWrRwrSJp8aN96Urpf6PNSUVFyBmzwqhUSfUKbi7Os9?=
 =?us-ascii?Q?fK27z2y/RoA99LffqpZY4DcOJd9+J10uXIf397e/0mPMkMENdhb+1AvPbLCe?=
 =?us-ascii?Q?qCqCWWUu9VZLjGRRggSHJ2pg5MAvgKlg4Kah+U1CmBkyZOkYnLQpm1GAoPid?=
 =?us-ascii?Q?DldbahcSZg7fiATjZzI9KqAUc2dDNwIwf1diGG8GXDyEyvcS8id3/m68NCSh?=
 =?us-ascii?Q?1PObgADr1M0SCXjnVr1k7dOaDMNJroNXOgE0n0g7OY4RgbiIJdczzhGBC+ko?=
 =?us-ascii?Q?Zi7eYZySx3IhF9fz2GQm0oswYdydzUk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fb93a6-e63e-448d-85de-08da4ae1f753
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 13:06:00.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UlJlbWwyNubnZHSKg6u06yvZ424063PtfHefyWeT8FmiGThoPMk4amU0r6wB9H7W1Zp9cvIOCCNkUQG2L6k2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2925

Please update the subject and commit log:

'''
mptcp: add sched_get_send wrapper

This patch defines a wrapper named mptcp_sched_get_send(), invoke
mptcp_subflow_get_send() or get_subflow() of msk->sched in it.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_send() into this wrapper.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 15 ++++++----
 net/mptcp/protocol.h |  4 +--
 net/mptcp/sched.c    | 67 ++++++++++++++++++--------------------------
 3 files changed, 38 insertions(+), 48 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 58427fabb061..ab42059143fa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1634,7 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2180,12 +2180,17 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
+	sock_owned_by_me((const struct sock *)msk);
+
+	if (__mptcp_check_fallback(msk))
+		return NULL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2438,7 +2443,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3092,7 +3097,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		return;
 
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
 
 		if (xmit_ssk == ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bef7dea9f358..a5a6e8aed5c7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -633,9 +633,7 @@ void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err);
 
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 8858e1fc8b74..527ea07982c5 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -117,60 +117,47 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 	return 0;
 }
 
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
+	*err = -EINVAL;
 	sock_owned_by_me((struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
-
-	mptcp_sched_data_init(msk, false, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
+		if (msk->first && sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			*err = 0;
+			return msk->first;
 		}
-	}
-
-	return ssk;
-}
-
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
-{
-	struct mptcp_sched_data data;
-	struct sock *ssk = NULL;
-	int i;
-
-	sock_owned_by_me((const struct sock *)msk);
-
-	/* the following check is moved out of mptcp_subflow_get_retrans */
-	if (__mptcp_check_fallback(msk))
 		return NULL;
+	}
 
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return NULL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		*err = 0;
+		return ssk;
+	}
 
-	mptcp_sched_data_init(msk, true, &data);
+	mptcp_sched_data_init(msk, false, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			/*
+			 * TODO: Redundant subflows are not supported in
+			 * __mptcp_subflow_push_pending() yet. Here's a
+			 * placeholder to pick the first subflow for the
+			 * redundant subflows case.
+			 */
+			ssk = subflow->tcp_sock;
+			*err = 0;
 			break;
 		}
 	}
-- 
2.35.3

