Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668F2F3D
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:01:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2d3eVEhhVmzw6mTinWLr+y/r/1hb3R9n1rZfpVdH8TtL5jfckDSjSt7eQd21Kg8KqIYk+ug2LK05FU8CJltaQ93z5/w3EgB6fvgGmyNVbcbqm6rDzyziaQV46dW2LOBqFNTkgG9/pScMzNM099BAmuDqQ8nmBt0TEaOYY2Qcn+rm4N0ZJRkQFjKTvdnfiW/xD/mf4PrsY36qQ/sJdpHPQq25yTQMalQypg8h5SVj8SJK4ifLxwUKgbABOJs9GuKEA86vG4XfoZOfMbn/g+cOMTJCFvl+Hh5rh3ckJY6+0pPFZ4itXtmMw6MmwDU1uUfdPDytShpbL5gy3lI2fhQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxQh1Yb/jTl6VKmqplPmD4ZR07La8WSewUrWkcN1jTE=;
 b=FOzXuyRVjbo2tnIC4brll8oPCudaETXI/Vx50K9zJF5nWPmkMlLVQGwhmfWaVejQuF9qG+s6gdjH+x2iFeRKCCvny/CLUlFvvRkslPoxC+r34fxFInw1Cf0MfYYN8DqWMWjwvKTY93PaNpmh7nwjC5bAvjYtQGroaP78QD2Faxguz8jVrw3tEY9UkXItNm3wh/rmiw9E+VkF453LTMterNpK9JMOkaYMZ7ElrwUlfxFprFsmsi3GKrrn3Q0iRWVf0FLbr9aFO3MqD27qmCcW4ZyZxZlwqy5h49i3vvy61kb9GGrTnnWncBkGtN8P9qrEXUObrlHKbdiZSC0Fg5nDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxQh1Yb/jTl6VKmqplPmD4ZR07La8WSewUrWkcN1jTE=;
 b=evSC9pBe4yNQJweWHS7e4xsvrZwW+RocanwkZ4KG0e5aieyBLVpU4C3tK20J22HN8fnUAsVuyCnTmxLNp9ohuQLCIhsrl7QDdT+BHIL1Jl43Q90lnDQyxhFP6puXDbFL7zGRzEUuHEvvffxtqv5f8w2qQskf5DScLlHk5ZzbxS8af+F2pNLgP3vLP+Dj5c4k0RG+herZzAxhAofNvQ3XiM7wgU2A0Oli1nzOpwrz7JlnqFka5WFYU/uxHGNSIl3qKOyyQC1iP1yY2xtXaMi9iq7z9sY8zO1oHrWNL/esyPmKSNjdtR+VQ+jpL2lJEH7YsoTaiwXLzSBipeVia4UnhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 12:01:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:01:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 01/13] Squash to "mptcp: add get_subflow wrappers"
Date: Tue, 11 Oct 2022 20:01:25 +0800
Message-Id: <20221011120137.5475-2-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c24f5e-2eb6-4736-2b6b-08daab804d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NzVVjTMejMUkGJE2I9kZf9+9z74L1yyXxyHfzEugOaLIiCX2hPDuphfZ63sxN3dRYatqVT3vR+Ai6BosUefM7PGMHb5mBkDU6wa7leX5DFCi3jxqaoweUy9a26yVrbQ6tj71yChEOsIe6DZlOiqeismpQ3Ps4aMISYJTWRP2m5mxVV6PEzvRSlMQPkZgW3mkSs0BJhG4bHToDtHD2LnHx6rlPGN4I73dBHL4biQ0din44Y4UkJYrGknr1ZlCZ0/DbGX5oRhZ4HVOKsiectDQmOJMOj9URA37A5av8RNmVvtLpfSPrDQNVkrUwMTYtRl4zzEX7J4jXu0gluG3jiSSrtWbUDWIVY9kycq7gBc3p5emeZI6w1ta+Sd7mnKbyO2HyI4jMxGugbYuzO0eTgM4hEbr+R8MTDQ5RvIR/6+I1CKNrm02nrz6MpI6CAayycLAtoQKAAhFvJtRj0f6rtT2sRSA5IgZuMODXx+L0OvBRVD3Qd42/5cTQCNU4YGBvcQUkTbKD/xDD5z/6mWEvPj3QAF+NehvJ87Praxgfdv4m3Ps6lWeqwB3k0oInI98UMdebDwpyTaS9ugUT0NHvMhg7IRKBbmXmvHzFnZcEFCx3U4b/yVUlaDgaD7lCGmEdk6LWtGbECEe6XZGayaoSzcEZQiLbULjYhSopRzvyJkMaB9hVuhovAE7cim5mv8sYqQfgD+4Bue4s6Icqsnca9ZN8wXRT3SurK1K8Si053LsOkg72CHdNPsPfAHOMWkZUIoZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39850400004)(376002)(346002)(451199015)(5660300002)(41300700001)(8936002)(2906002)(86362001)(44832011)(6666004)(6506007)(107886003)(2616005)(186003)(1076003)(26005)(83380400001)(6512007)(6916009)(66946007)(4326008)(8676002)(66476007)(66556008)(316002)(6486002)(38100700002)(478600001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fshtty/046WH1ZBTlAVolm1HrIyVPXlOfrr5XH5Ah7UKjks7zXdlqdH87rSz?=
 =?us-ascii?Q?zVXj5IZUckZZdliTxi8VxAlY0OoONXK/JN4SeEeImRdW8j9ObwB3e1Nugl4n?=
 =?us-ascii?Q?eWviKKZvHIKZSx/+TTy2yWbvik6ZK0gJ4VB6dlLVYaM3uKAftwRuVHY3OkeC?=
 =?us-ascii?Q?ujfC8M3x6xQ2O36ID87yLO3VNz0OTeh7L6Y1RL15A310fBUwRdDMO2jRyFkg?=
 =?us-ascii?Q?TFaMfC8IM5bTEw1iUMlns2QYMvNtlj+97wyEY+jLKwo8/ulL0aZM4Fxt7TSO?=
 =?us-ascii?Q?ZCaQTKVNGs6oXputegA9xAkASoa4uK16b+RGC6U3KbounU+kzS7qUdBpDG2H?=
 =?us-ascii?Q?DnQlGOa6qnORbk6i9RNEj2HF/1whXwKIaKlon4ik2QpjOZP0qPcVjC/s285N?=
 =?us-ascii?Q?BtM91symYroDY7K5gn9Mbw3k1OZiJVmFtPMBAynLpj6Jwjwj3ugHRhTEVeCY?=
 =?us-ascii?Q?JNQE687k+cP/vesAsUR4aQuE1N1S98Hr9YBpQ1MeSYTFhTus9FmWB9sEeJv9?=
 =?us-ascii?Q?hc+XtR5rcCPAcOF0dj55tsSD4BgeyQ24tX8ClJHUghW3OiYYMW6TvSkkvA6t?=
 =?us-ascii?Q?XJLtPLZ/W4p5YalWN5yHT4uQ7oLkxeH7Cjviunc0J7+17zzwfEHCH0xv3/1t?=
 =?us-ascii?Q?wsE7cwrjVq1WQEKMqTDwPN76zfNhmllwAsBGmzqHJfDkCBXxa+o7H/2ibCAr?=
 =?us-ascii?Q?B6Bxx1cs9Mp1P5jFwYFqmONmmEQJhKeiNTt75mLMFQUPxYHxm71RFzw9+S4E?=
 =?us-ascii?Q?i+DzVad3SE6W7LoFu4+1VDSTB//UngRfGSCQpRZi4gE5Ry62RY4nLpW28Ffg?=
 =?us-ascii?Q?C/VlARB6+btFtvRcyQeK9SSNq69XatYYdSyL7aAGNn3czJMCTARsMDn3Smbh?=
 =?us-ascii?Q?wDMM3dAf5W1v1tQP3yLwUnRYJqD7EC7z1Vh9YTRw6ivFaAix7TiVxKpMskM0?=
 =?us-ascii?Q?kjePaKJV3b6GqwDgi/bBSY8uxs9a6F9vxXkMQXYlmLZBEE3OGYrwId5N3eNr?=
 =?us-ascii?Q?nbyM6go1Hszf5xn8Ma4JssFM8a3NDnGXP4UytqIeJ6h7Sbcz55FXGL2ZAGT1?=
 =?us-ascii?Q?GcTfl4IwJQcoRFDZcrZ2Bx7ndC1ZMlyqQEcwdoQeTP72cszzdgdVJfchHc/o?=
 =?us-ascii?Q?Tj2MV42pY77z4Y5SPRA3jWeVzJcUOKqEVvqXEPA4fqCF3NQehw0P/g+VKKSn?=
 =?us-ascii?Q?jUiLCF5hjOQfYFzdb+7M7RhtLdsKzRWj+UXKwE5jfKiHX+BAUWJLwCUn8stF?=
 =?us-ascii?Q?aGHfuiPFBDVyOhLUxCo+X7C2Wpy86EO18lgkFzwe1/DN8rSR3/DN8YJZ1pKh?=
 =?us-ascii?Q?OwKNOk0MSIbSigIQE+ndwM1WPDnt8ALX0u8LAbFFK04ff9l6PYFbeZiMoXme?=
 =?us-ascii?Q?wI4BgAWPhDVEoGw7m3dh7b191N5lXt4h6FIWQdbwr2nuc2MeXnJhaU1LEiVN?=
 =?us-ascii?Q?8nAnqn6cE0NQYe98YECnWhoGf+RoJgdNC3f8edc3r0tRoF4K0tvR/8eyGIKd?=
 =?us-ascii?Q?S6/600g9p6Vj7gt6EWhf7MrVDvL7y1Ts2P8F48xIGDy0Uf27L60nQzLlNjxD?=
 =?us-ascii?Q?vW0pzYLKBcjooJh+POmLg52mxumRGaWoOLXne4N3qv9b7Dor+2gA/IoeKl+K?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c24f5e-2eb6-4736-2b6b-08daab804d58
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:01:17.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hX6f+exIX09ZA66uUZAvsrRsY7sUZ8gpWy2Q+ghw3dovn8Cnb1XU3a7LCAlQ9IYklklCJMtrXNussSur7HVZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928

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

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  8 +++---
 net/mptcp/protocol.h |  4 +--
 net/mptcp/sched.c    | 61 +++++++++++++++++++++-----------------------
 3 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1aa940928b4f..9a2253436f50 100644
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
@@ -2481,7 +2481,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3199,7 +3199,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		return;
 
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
 
 		if (xmit_ssk == ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 18f866b1afda..d44c97bb41db 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -642,8 +642,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
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
index 044c5ec8bbfb..9b128714055a 100644
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
 
-	sock_owned_by_me((struct sock *)msk);
+	sock_owned_by_me((const struct sock *)msk);
 
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

