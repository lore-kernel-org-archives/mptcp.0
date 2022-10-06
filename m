Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B937F6
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS7N1rGzn2BtlGrIC29HruCeVcV2vZ6wBiMsRm5XIbSnsca2yvBS4s//gFOdr2GADCGsIe7IfpUjQaGCM/nfdO2vQU4QUKWYdpSjifgDlyNn1wk6szTDKFKscWymTLNXH+xL87MQtWoUDzPXGOk57Uiar3nc/4bOv1PTkm7j75mx/d5e544qq1CsHJM4OkxCmnO4Ck5iYe43t3c+YRiOsEu7k4+qfcn5RKszxoxgLmNAYXxZxqVBcE3j/y4pxnoOGFM0COtnBRDpre5BjbJdKVWPzj6lmdm6wdsPHS5f7X2WUI4kNDAhc5o7voubQjfJoyxUqUIK+6bUS5ene7XOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1/o6gkFc6KyW8Wjr3QM1a7oD22sfBNCHYRbBqSUVQU=;
 b=JyA4vNrvIFrdcdpPHlRc7ttZCXA2R1XL+RLaJSVuzAClmXTpB/GTxWCP/YctKlyMiHLNU6QefUoegbSZgW7gRnVJ4+Wy6l0S/SRLwaSX/drf7+HuC2HILM2ERxthC5vphssrmFAHZkbSF+OzxUT44No74LKDcxAue3UsOwPO8/raWHXmbb0oNnDI0p+F+YXc7F4Z8cV2AxsjH2SxBKJVIPzSyJ7Wa2lwp1TJa3j0NSE3Y+l/5yh7xUH0o3eh0YA6Ri3ff+8NaisfoDigckTxsc+U4waKTiB0mDJ3+a1b5QRmyUrMrAF0Ic0xzU7J3l4qBPAp+wJRbC6h85jx9skYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1/o6gkFc6KyW8Wjr3QM1a7oD22sfBNCHYRbBqSUVQU=;
 b=DDd5U2C3Udvb82k+3UX1XvvAvRmY0EkbrdCuHKSDhvr3kGrb4ytbYNZcQJuDPakxw3845GlyO788y6afXSzPRbP1fDtOOZDyL4JYaomCs+qrzuRrf3P1AARyBeO8XagGDn67/Da8GSko3rGXP4T+VjbTAWSQS8dCYbbXBTT9t31TaD4x7Ka9R9PFC13DEFf7hQW/ff9lrONkHN9/DSK9Y4UOwR5oJDRCrN1JZ1vG1t3PvCX2H5fpMW4s6bgl/DjFF4oMfB/TgSjDdKqBL+njIWDD4uMzhIiIm8/54ZmDRRS8bvx+iS0SNe9xGQHddZsH0T/OIK+HIMish0SdFjURIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 12:17:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 12:17:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 01/11] Squash to "mptcp: add get_subflow wrappers"
Date: Thu,  6 Oct 2022 20:17:49 +0800
Message-Id: <08b3778e9ddad94e8a5e21660692afec1d3f81e1.1665058388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
References: <cover.1665058388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:4:90::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be28d22-528b-4eca-c7e7-08daa794c80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ljlNut8TdvtFivMmEeUemPdF5GR5ADxsnjJAQbxXdXou3MahzbtNV6xM4AgAY1eAqNnxzfc9IyCYOwZ87wyROixUedDei3L+JdKbLmGJSu0QCzHkG+Ok7MgHD5TC01icJgJpWw/r1ebbqrkv2QuXoxbd+fqg1oIIJEaxz28Vi901P+Pst0MVo3e1OxAFQEysLYupeQuDm/XASewZzNGjAUPAVnefyqvGtyufROY4fM8yFstYrCMxa0Pcc9dQ0NBJGRH2jv7uoYwy5WKaeRLLUmi8KaGeTii0+QSznz8W372/ikKU9ZsGTYW0UaxurV/U2eqbeBrlqwZZTlfsokbYWi/l2d1j9uHM7Lc8cUTPUJMzrXc3pJSw6JBUMw3hRxXvKOeLChRWvwodADz1oPau11UdD0JxXr9T1M/hCii+uUZG+/LPsWMArmNE47gFOWQOlRF+z/KspzUSDXGIKh3Bm0la1XF8bsbAJokvnnWL6/CECnaWpRjpV6IjwRTlQSN2ywdH2y9np89BtHs3e/1IIGhIL+quk/6RdB5vGmqbdkJKKlG15TyAPymXfsWhBZhh+6cYz6UET8v43F/ToKASbZH3Jvr21RTZxm3tJDCYEVcpv95ZSQqYKHqgqYcRk3cmsdc43Z0CrMyxbSEnCMrqQBpRRVF3AD2+OqgmWqBLDNoz8uVAopfd3YlbA2K4lHlWUBhfZUMGkGdKmZxWlaaMR/QlQ9ssY09tBLuDuzcYTK9eXns9eR24MYAvJmN/jqb1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(6512007)(26005)(6486002)(8676002)(4326008)(316002)(2616005)(86362001)(36756003)(38100700002)(107886003)(186003)(83380400001)(66476007)(478600001)(6506007)(6916009)(2906002)(44832011)(8936002)(66946007)(66556008)(5660300002)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9u0QKxRX6+r2UzXjDQRlZWakPobtaRmCXxQMTDPERanYnUrstHJVkIm/mqek?=
 =?us-ascii?Q?phgs2cjSwJOVfVPEOvQvNCx0J267vrg9eP1Hu1eU9ZmLBngDMLDVPMJqDMVz?=
 =?us-ascii?Q?d/cxifoKb6ZVK6b7EvL5hzxPKgv7yDGEr5zJ/myFF4Kh5JZtOk3iHEhXFzTS?=
 =?us-ascii?Q?tLy48U2D3CID1jlz/PK/EnDK4jI1lMBwiiBlyouMVTuWi7OWx76IpOWFm0Vz?=
 =?us-ascii?Q?Fe7p9MimwaWb/w7JUUJtqKtdwPwJEI1/JGipNYzbmGwZJEqWxqkSCtKbL0yU?=
 =?us-ascii?Q?9xfhSW84PHHVSn30EmJ4GqMcGBNo1RN3mDr5hI4IayN8N76JX7W9vTRUBsj7?=
 =?us-ascii?Q?of9Ui05GldE/FeQGDlJv2azoBft3w1U7JMsCvcI6BTf8h9TjNgpcSMbNjBei?=
 =?us-ascii?Q?JXaZt9gSqauDZwWVMMbiu+TcGmsVQDD22coovK7LQw9pClwEBmR98vCadU3v?=
 =?us-ascii?Q?YFcYXM4w/gOCbaMPsoEr+tRZ2D3s2k8duR7gsTw8ONpmFzI28jPPzmzUwGVV?=
 =?us-ascii?Q?2eidS/UaJhdJC55wW/OaUHYZRmqEQowe8sJtdMJT/TZ9e8WHpLOMJeKXIbdq?=
 =?us-ascii?Q?LjFo/q7U9BIA1oAF6XoW46rd9gK8oyYGIJ19TAZznsbS/RUTsA9v1CUuJpi5?=
 =?us-ascii?Q?PmcfsE9lrKk4y6MalgTmSNwlLZuCZBeI+JdBerwBrbxcKSH1MctL3hc7Cmvu?=
 =?us-ascii?Q?zB3aw9N/6TiNMfydyuirPHjhAPFzEkMZffGSyfH0JxIb+b27nCElUykHFaks?=
 =?us-ascii?Q?322KBNyY4W7buqIINHIHyC68Gp9qsUqdm+ai3bdUrdngCGZszgqEcE3d9kTy?=
 =?us-ascii?Q?Oa1Z4/n+G0tfN7HaYCeT8nqd+DA4Kt8i+cUsIDDdnymd0dxaUP5odOJgAvNT?=
 =?us-ascii?Q?nJGC7XQq0UROyaV4rO38QKhmrQImocUR53vTQEfZRh2JjUVZtXLpfNIOvIq3?=
 =?us-ascii?Q?p9RRLq2zLnwn2Kf3yOB4jMP39R2U9z2vI0f7FZl5eOXvzaeLl9tV2SNcepB1?=
 =?us-ascii?Q?Bvggf2ioqV7sEbdzXLlfkfW6BwEjgWZNQApXxznQEjpJyvzDQO+TFSydDOqs?=
 =?us-ascii?Q?eZDlVNO1wS6UxuFIMAu2S9f1OK5RNyUMkTq8qRtCHuNhorCYO6192bMoAols?=
 =?us-ascii?Q?hOhknZtm2mwpItc7NO6Totq14gO1FJQUUG1oq9wU0izAbqnY3Ddrl8b45orW?=
 =?us-ascii?Q?rCSXO2uysisGr6uWbZQKBHY9fAr+a9h9o5N1rwjUAyy+ZJUmXq/A4oWIdO74?=
 =?us-ascii?Q?X75Sc2yXL+VdsISzO9hFodhOSBmJZ+Wp0l0KvXk2gt1tdIBfbVqHwNuIPg7g?=
 =?us-ascii?Q?mLmvvQC+hs9YRM4EGyXJg343aLC8AAG0S6LAxgQ2DBE6tvUkFyZSdSwI+vra?=
 =?us-ascii?Q?6L6no1qNYggnzIPA2uKHKPj/nwJBe2eZrd53CudcPQO9ykB8a+uU+Psma9CB?=
 =?us-ascii?Q?f2iByCgBwl7MV8x1HHdu5IFVnyuXTQ8awWYlN/buo/bHn9SfLX8sZ9qJK0OD?=
 =?us-ascii?Q?f+UHQisrv3B5g2gVNRWptfJQbNLZnBMh8V4npE6U541W22ehsD32wnxeZDD6?=
 =?us-ascii?Q?g/zAW6FShWvKRXbicvYrMEDI9Q/o+7F5C0ZSdRilBMTOl2QTlm8nmH7gVqBG?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be28d22-528b-4eca-c7e7-08daa794c80f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:17:48.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Crz1mulIA6uYQFDq4r3w4c8If1Y1KE1xa2Ooj1+pLfSR3ilsmUabnCRAigR0pX3rbPNwvlBoDKhOCJ8ZSbX3qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_send/retrans() into the wrappers.
'''
---
 net/mptcp/protocol.c |  8 +++---
 net/mptcp/protocol.h |  4 +--
 net/mptcp/sched.c    | 59 +++++++++++++++++++++-----------------------
 3 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8feb684408f7..d500a00fa778 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1547,7 +1547,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1616,7 +1616,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2478,7 +2478,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3196,7 +3196,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		return;
 
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
 
 		if (xmit_ssk == ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 93c535440a5c..e81399debff9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -640,8 +640,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 044c5ec8bbfb..d1cad1eefb35 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -114,67 +114,64 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 
+	msk->snd_burst = 0;
+
 	return 0;
 }
 
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return 0;
+		}
+		return -EINVAL;
 	}
 
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
 
 	mptcp_sched_data_init(msk, false, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
+	return 0;
 }
 
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
-		return NULL;
+		return -EINVAL;
 
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
 
 	mptcp_sched_data_init(msk, true, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
+	return 0;
 }
-- 
2.35.3

