Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CC7E
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650981686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMCvNiFSVB1qO9513VU374v2BjAUVA7DsJxQhsYS7J8=;
	b=bHL8n6caT0hC2f1onCQinL2pb6D8nG7yySTzeeXDIC0xzF65l7dOONx8afYCEu00a8DWxX
	nB/LUIEb+RgeAKZwhwARKyhTWAMtso0r0u+tsaqdhbn5XemAa1BQsBY57HsnrQQh36OVkE
	iGtugzMQHtF993BKQRHkKIh3dxGrNgY=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2054.outbound.protection.outlook.com [104.47.2.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-C_FLEcXgOZOREI8iRX8qRg-1; Tue, 26 Apr 2022 16:01:25 +0200
X-MC-Unique: C_FLEcXgOZOREI8iRX8qRg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bU9tSRisL3hoJu6ilTSsAbkNQN9oNiu03/7d+0naoVsiWijQHOPVp57rufECiieQPofTWemoRFs7MCfj2pCIz5WifWKlN9m3jTp0bb1yMhjH+nQxAlHI1V/0C69QXUsyyufGN8meNR+br35HPo0069g5YOEJwNdmUEbyW4dWI+mzSrZhfLdkcYs3wQJYRllGi/RmpFz+DkjmCcr1lREFLTUYnkXK4iIiaOiefC6M4lETEoik5VkIKz44YjcmFJ+2pt1rCvcCfUpgzSB0jz5evuuiREMni62V8KovcN2y/hNz2tTdfzeUcG/atu1ueIjSoszvQEb2h8qsBD8cxMQ0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57g3mAueaU3NZoSF+1FZeXzAaLHaeBhQ8ohe3aw6CHc=;
 b=A8+qOwX9fou4WH+PP/zhXXHz2huZLa17ZelNcMQSlr20ZWH3VuSRc/7hCrdaZbPLtli54uXd9ZBPQoaCxu5b+Al5pmEvheM46EWCe90h07gFSoKaY8nSk5YDHb4XO07C9CwMy8J4FLMABRzCAVCu1pf7EbRoEkhQBnFHgHP4XwYpFxWRJ1BcQ1nCOMQMUS3nxKse8x3Js2TVZVUAnpqzeCgvqi1PQBoJmYj0dNMU2un1wnsJXLTgbvbrU0ww+XFBa6vA7AvDIDQA05F49Ln/COgbof7IjSuaS87XmmZkY0kUZVjCzdOPtBrOkRCJt9wihQU///05tqQXIwoX6bPlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 14:01:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:01:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 5/8] mptcp: add get_subflow wrapper
Date: Tue, 26 Apr 2022 22:00:56 +0800
Message-ID: <498e71bccb513727e889e4720841c112bef074ad.1650981078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650981078.git.geliang.tang@suse.com>
References: <cover.1650981078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5050c8c4-ada7-4f82-aad2-08da278d3fc7
X-MS-TrafficTypeDiagnostic: PAXPR04MB8816:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8816CB9724293983B09320ACF8FB9@PAXPR04MB8816.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1c2BnPquh6AGOFjMj9cK7enfeym7iJLE7Nd7o8WN0n5cPSpN1F5L7SrFHB6sCvadsse5SfxLOnVi4L/8hKFMhzZdRINkBfgX82ynrKaMQRRTxth7Op/CajpsGPJ76Tx+2O8wGxYtw9etTvtqQtqrr0qtfhZ8TSQdiz2psORg4HdyiidXs450rZgmJ6fJfhfZdJpn5DQOb75GxPMn1e3zHJ6zhKRydXxVKW5LNVsHVZ4+jVpWtOLKBprJqcY9Xuh86cvdKObMFa04w2t3gv98eKfaPTmQPVSXhSiIZRvNjzjTKwmN1bgNFYXzZL1TByAZuGTRsJCj1XYUK0IFvh8fItSB6impSJQhH+5gJJ21e3W4GODiGcI+vdl9C/yLbEiJ+G2PeXNHkUik2garHeVNTbtuK8MpWLBedFs5nPzxirZaR3NznEkFr7hDAHo3tm/LwB/eCsqT3heL57A6w780rjZb1Rkixd6gyKtdKTJzEL9EIV9BVK/jvhsQ8CATWbK4jOmqk6gbW47omJXYNFzUJU8mzi9GG5Vkx2vzdAGLEwvS9b1m6FP5SYUh4MnaoYtSRmuUY/CVW2uzY0sCjC6cSGbZiPjMlUYFIpMhHI3ORcUS892nyfa/mOiGnYXGUpj6+ATo9JOOg/v+gtEXdSgd3oCLwtQgux3/CVCO7a3GZlAQVWhy7fBEVWXoyfI/3qbD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(8676002)(4326008)(83380400001)(107886003)(2616005)(316002)(6916009)(86362001)(186003)(508600001)(6486002)(6512007)(66556008)(6666004)(6506007)(26005)(38100700002)(8936002)(5660300002)(36756003)(44832011)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TFQGGyYuAuHerqJGhzizmlHlf6aSntP81qh8XqSi92cAmHSePep0RN4q9Xcw?=
 =?us-ascii?Q?IcGm3pPwlXkwHCampLBmKT0MSEP8OEnwHtM5ab5JEQbr3K+uFvA4IPHhWGZB?=
 =?us-ascii?Q?BpSEF8fg3PmSMHV9tz1FfIOuONpxA/+skZwSF3iEB8qB9z46p6T7GeiDKQvF?=
 =?us-ascii?Q?BAgYJnhIcagswoXN//O/ZOz7fKWgVtG0MgLvf5pzT2lSjCPGR3MYjZdkkrAo?=
 =?us-ascii?Q?+r2f2DuxZEm5mK2bcD7Z2QCxvyT041pNWBOX13/ogT7lIZ4I8Z75/Ofs0TVK?=
 =?us-ascii?Q?8ifZy66sJRpGN5IvwpE1Aqbqj3Vq7oCszBBDarNzl4njcN6izAhgF0kHrR9S?=
 =?us-ascii?Q?lJIRdPXRNV7kMeXiyg2sPqpx7fAQeiiiZ9ZGMKjJX29KFUw+ivdl0Xc+lmn0?=
 =?us-ascii?Q?rcnlDJ2UNM2wgvM+Z69LjSVQsumekfLVM6yV2jYthm6bpgRVm8TPfm7HiWc2?=
 =?us-ascii?Q?IFJa+meh9pmsQhD54y8pW5bpLGT15CmmtHtcQs7pis/HTFlP9GLjPXJo45gd?=
 =?us-ascii?Q?21GLAYn9rERabtHiN82EVPISQ+GA6oj9nDmj+3cHw4aFFVV/ycjoBlQWeQMD?=
 =?us-ascii?Q?+zViBFow248QsS6EvKfp2ORb5YzKyUOt8cxl88W+gFFCD/shxE4mPo+tXnmJ?=
 =?us-ascii?Q?fKdHmJh4wdaL2abMSPaQbvjErRxQxvWvB76apCv+9Vr5UB4aXMIG6TZT69wU?=
 =?us-ascii?Q?u0KGKBz0JSP8hGPcjFM6SIiKqxWh++f28yNxGjcJx4fw8bK4b8CZM8srxMoe?=
 =?us-ascii?Q?c3ZWwrbIc44WFIeuGadNkisqdolMsRM/6MbFTl6Aod+iItdu1WrYoYHhnlOR?=
 =?us-ascii?Q?oryKdYSwEAUbJb9BgTczPgHCOhG25KFWlu4Gyp5DJXEbCUW9D2SOrwa0fuIy?=
 =?us-ascii?Q?q8xRyPu1ZBHsB9pY+bVqA1Dp4V8uEgrd5YKh38B9Ios88A0urfQcKsZWYjr6?=
 =?us-ascii?Q?jsGGsqbYiNvYjGd2zI39CRunV2477apyKvUMxDGLqJ6/vc0lcw0VZ3VUUKfk?=
 =?us-ascii?Q?0qAz50rNg+Y9+9KjwQdSsqUueP1PMfBNjfKzq2VP03BCIdIvTh3WEdpBjaO1?=
 =?us-ascii?Q?p4JU7oFxn1BJghatGNYDMJjc8EdVQR5BL78/RmefjyKytFA7+6JiShdrh06O?=
 =?us-ascii?Q?twz5bOdEV3ozwycFg4XaemI3odfTn4VUduxRalUUcyyEWI5sF5Dpe3vJeqQi?=
 =?us-ascii?Q?0pkiZbF3xSjPA6qd8YpjnwUkgqj3WsGx+KEilkGHPWW6X4ghgW33j0buNHPr?=
 =?us-ascii?Q?35D476lRatrfqMBEP9sBH2NVFevQdy1AzsvUpyhY9BpTp6vVbge3arY5wLQC?=
 =?us-ascii?Q?esrENWVL4T3VTzrrlDGf/cviXw0ZAFtKowom61B6vSXa2CLsh6XEmzA0P3Yx?=
 =?us-ascii?Q?djBiy+HFmYDZ3L9sHYNDmMEByzlPXFo1VEqf5Kynwg/xG2/2mPY5I6fyyaDw?=
 =?us-ascii?Q?kNmmGfQOsdAM6o1Ux0yIobTF39JF7hRfGpzMjAdrmGux67wuqPlu3dbqUqhd?=
 =?us-ascii?Q?pGa0C37AvEVHpCMLsaJYNAXvaii/5wmUd5k+CENs+bqOqnC4b78FPQGFf/OZ?=
 =?us-ascii?Q?noIXtPEAKcVvN52U+AaeQTzhWZ33MOL4/FwLACZ+uUhXeETCGl8JY4+DQNUk?=
 =?us-ascii?Q?D8gdCnLPJ7QccU13kogPAylxXeELVfs+XvbRGTYhJwYp6x0z33gkASdx3Bhi?=
 =?us-ascii?Q?lc2IyTaPj/sXn1RdpbE6ZzkKuvJ3NYCorRoChV/KyZbTwxh14FLu8eqvjz3k?=
 =?us-ascii?Q?m4QW3DYs420KOtURkz4Kf/H6leGVdsY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5050c8c4-ada7-4f82-aad2-08da278d3fc7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:01:24.2143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chrFY6CYJM0JaOKervsTX1GFKnVVxaacC8RAbrmsN1nF+rYrZBhIdMF4Xab/ISn67bJ9zsM5CRRttxhhBMKMJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816

This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
get_subflow() of msk->sched in it. Use the wrapper instead of using
mptcp_subflow_get_send() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  9 ++++-----
 net/mptcp/protocol.h | 16 ++++++++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7590e2d29f39..c6e963848b18 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1515,7 +1515,6 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk)
 	subflow->avg_pacing_rate =3D div_u64((u64)subflow->avg_pacing_rate * wmem=
 +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->last_snd =3D ssk;
 	msk->snd_burst =3D burst;
 	return ssk;
 }
@@ -1575,7 +1574,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_subflow(msk, false);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1644,7 +1643,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk), false)=
;
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2489,7 +2488,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_subflow_get_retrans(msk);
+	ssk =3D mptcp_sched_get_subflow(msk, true);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3154,7 +3153,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_subflow(mptcp_sk(sk), false);
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 22f3f41e1e32..91512fc25128 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -633,6 +633,22 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
=20
+static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk,=
 bool reinject)
+{
+	struct mptcp_sched_data data =3D {
+		.sock		=3D msk->first,
+		.call_again	=3D 0,
+	};
+
+	msk->sched ? INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+					  mptcp_get_subflow_default,
+					  msk, reinject, &data) :
+		     mptcp_get_subflow_default(msk, reinject, &data);
+
+	msk->last_snd =3D data.sock;
+	return data.sock;
+}
+
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
 	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
--=20
2.34.1

