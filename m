Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485EC621
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 01:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651024636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMCvNiFSVB1qO9513VU374v2BjAUVA7DsJxQhsYS7J8=;
	b=K8vNH9OI+P4URx3m9h7SQ1tPK3YoJkEGScTzgIgEfn82cRBT19hrnpy3kER0NIRoOssDpG
	uGsvX7rF3t4vAX+PeYl1/4K255qYxd+Hm4IpjgX4VzwHBQRvVYa7VmDSEW2obVGF14y5wq
	p4xzIUIDu4IziURNlABzAKr6WmUGi4k=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-m_MXH29VOe-q7_BeivHlRQ-1; Wed, 27 Apr 2022 03:57:15 +0200
X-MC-Unique: m_MXH29VOe-q7_BeivHlRQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itQUlGLUJnCNhJ/6v1CWJveBjsmNDpc9e73ek6kmS/t7IZlcdffSw9sUxWbRxeFaUANLITmlVlKi7sQ6OlRxgU4+cU8yf0MypxmUp3iTDCjhzy5AtEJB22WD8R6e+l9cGli/lS2xOvhhZWDCx2RC05FaqjsVAHcNuTWATo0eL3P3xgujmqROEBLhCJ+kxs6qWaa6a21f0CQlRlSI7ALMiy+SaA/2Q9ZyCQfBlN4pUNmbu0enW+Gjo36qPbHH0FKzTpl9RQWDgk9h/RG8B0j1H0vJuZwvehSkyb5cQZG0UikuxtfPqEftEa4mFyTwsHwKs/oU3vWMoS7WRyGEroUI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57g3mAueaU3NZoSF+1FZeXzAaLHaeBhQ8ohe3aw6CHc=;
 b=flA/4Zwm8wSQDjPoPjR/FIUuk9iCS2Qg6rpPOymoyljPlhGeMuLYlIJ6+9BkcXFhUnOtMIEIRSTgr6aetBidXbJDyl6KT+YiLdZOSQbWglP7zPqULIvwlm+ws//83PbUf44L+iQRtK8gdhGuoNwKMfgIawg1t7HttWq/oIpbNDibASdTiRLwIOgcpvyUn9ng6VdLqw5S9hSeL3ZUlBw6uv2cTS4re3ospvinjBfHvO3rikqvdOeoNrfHRXU7P0+IjWexCFebXuSpILVO17TXXtCXSTDttv+wpb818uePnb7rPeEaWaQDJVCxgIPGyJwa2d5Yuv8EtLEg+xaWQuuY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 01:57:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 01:57:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 5/8] mptcp: add get_subflow wrapper
Date: Wed, 27 Apr 2022 09:56:52 +0800
Message-ID: <f69a828ffffa6b0a57d8913a273d84a9150cc860.1651024344.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651024344.git.geliang.tang@suse.com>
References: <cover.1651024344.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 004a3856-a599-4200-e02a-08da27f14031
X-MS-TrafficTypeDiagnostic: PA4PR04MB7661:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB7661ADD648ECA434DED3CB77F8FA9@PA4PR04MB7661.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cucJLSZKjoshMZPfCroiZgQ1vGGuuQZPogfBIYkfligvTzJMqia9scND/EK3mueZd4EIxcBOilVpt1rNNV8xNB6Owo9fd/smeHgyl7utQXpHzXWNCsztWLHmxq0CEMtbowCvSgd4AC+uIRDiup5m40xmNw2vozyOt5nXxB2uNRJtivQLx+e+/o9XDIy5f331oy88aZ6qCW/+V928NDhDlFbYAf9Hny7uBPh1PEV292tRomDGjOIGt1cF2e95eEFFL/wflnEOr1jEDaQyey2/BPWqeZLZJyVmOk7l3+mcSq5TtOXOHF1iB9y6CLo6WjmKQSe6NLbt1VrPqmsT4YM+SoXYB0inWibbs/YNlr3OcKVw8IV/+OWkUBMuZGifvZMmFzmtFloZDDcLgqU43fCJJdHUUrdceZU+80m2G5yjsqvnCA1K5L8O+bEPuIbs7lCL63vcYYvNtf/2GcfdE6m64ThUnsFDXIHVgp43+GATwe3N+fPqQwQJBD7Su9oFZiqttIPj9iSfqHxjDa0ql8sxXqhGy3ZSBeXaX1NII1vhPxfJ3QHhbLgXr7tPplNjATRw1p8AzTO/m0lfARtO6bdh2WdTlVSRCck9hymz231Mz8R4rOt/1Y25/XR9GYPEPRI/fZAtkOOILwFc97OyebISTg6RRKtXzLyzqzOtlmco2NUGdQCVTcsdgjql4yCnkNVO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(86362001)(107886003)(5660300002)(6916009)(83380400001)(66476007)(66946007)(44832011)(66556008)(8676002)(316002)(186003)(26005)(2616005)(4326008)(38100700002)(2906002)(6666004)(6512007)(6506007)(508600001)(6486002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eS8ogZompriWfbBc1eMapcLSnZF3NkkieilF0fC3mI069jJGV/vCMe/iIl1t?=
 =?us-ascii?Q?UFrhSLgSoKlrOvva+TwMSD8WA1OpI2RkMLe/GwBMnXicR8Z6mCE8SheyqEOD?=
 =?us-ascii?Q?Nbrjujg7HPn7gpyWNRAT48FzpgCp3QoalAD466lGY4s2e3P5OW4283NtBsKD?=
 =?us-ascii?Q?rjApsFQ/KUsCmaMx8P4xFTD8VgB66p9v6jTghHGMyiOndXOm3ePbUYOOUi9N?=
 =?us-ascii?Q?X+65G2G2uC/FkhGiHuRqsPQMsQMHit6nTVEdRdCQFSNI+rhYTbcZQW7LMOjX?=
 =?us-ascii?Q?2js1pULeIc4bHLxigr5ioPGmGgZo4eSwdin7phbh/wkxvpQbZoTsfNCmYmdb?=
 =?us-ascii?Q?hzRlasKJHKVEVmqDUc1fi3X/3PwPslc3eSzPztErLonNNar+JA3MhAj0hSdY?=
 =?us-ascii?Q?5bcYiB4pPMHbuONzQU4I59iv3/y34/ibX+jf1Fs0qgiU70fSbjJPZ3dF0BrF?=
 =?us-ascii?Q?2G7D8j0/RAi3nVQSpEprFjIDVyB3eNW20fx9iA2vJukKFcTN4Fro1yp92QdU?=
 =?us-ascii?Q?3UEtQdWcv6cdpodMkMleFvQ9+XNX4dXo8yQAtUqrFcD5UbRs3P17GQEG0b2q?=
 =?us-ascii?Q?2agkzUuTNig3dEpMnr40S78xYOBtJFilljCnDk++kTh6IgbgVkQPUN0jEaMO?=
 =?us-ascii?Q?bcBd96JyIwFRdVNrJfyjSg+rwj/C87jFaKs7sKgyNByMV95FOcE7ez+4HHo2?=
 =?us-ascii?Q?/KqQkDlB8jM1UmD7kYnlbOouYKbsPUCPq3hh3cEEeWT4ix+xnAMh3MZVIQ+1?=
 =?us-ascii?Q?NZW7fXn1p1UMYndaLf+xJk8u23VoMdHg0iQ9JE7l2Y8OLlIOPzNo2RUOeVGR?=
 =?us-ascii?Q?PRbK5eQzpIUN3NDDck8wiW9YE96qfwDhUX/SWOh1rbZCjPUZozw7LYLpx+IK?=
 =?us-ascii?Q?DbYGaahioIAniZ0n7zwukPbXj/p58TCq8War0Qh5tT7dEXbCgm7pI5hjUPX0?=
 =?us-ascii?Q?tPzUztBlyplH5k4BScucjaaOgIMfshrVvKVDtfAbRWf+OfV/UFymjCE6l6Kj?=
 =?us-ascii?Q?xws2pYJSzKB+TJAo4oRQb7Bw6WNNtToKuZPO6qWTwp7EnGWX0Pte7KE1Lk4H?=
 =?us-ascii?Q?KRMZYs51lO1GO4GnUAo5D7B2mty+t0jVcevySXjfEVD77EpiqV53olXDrV/P?=
 =?us-ascii?Q?stVX7Pou1z4kg14nNAc/VekmQ7UNEsCy8WkisBsbIRFzKt2sOL0oynXcr8+I?=
 =?us-ascii?Q?FLTrh5IDitF1rzkvEZ7MCcZXxSuQQ4w62wdYXBNZYBIpaL4jQpnw48+EpXsG?=
 =?us-ascii?Q?Dh1xE3HTb3kjrmeV5rOMWYpoDWf878jqb7MKLa2jIpw+vgi0Sg89QzktFxun?=
 =?us-ascii?Q?1wUAKBU0cCLN1xTw6Fa9Gy/n9aToK1w6IatSTllcttDW0ae9tTYrcWP2GyrA?=
 =?us-ascii?Q?phn6g8ffolFl51tz6ZMSEnQcrkP345tjL7XWGqCih/FqjY4fVpxDXDGt7nyb?=
 =?us-ascii?Q?XqTtcUTY+jjXqIqZJfmKhV9HS1TKF0s1lsbz6nGsAfxcTtW/VoAo/CASi+0+?=
 =?us-ascii?Q?d0g6Mr+xrcP2UMulnkrrV9/ZOhNgkciRXfoiUNsoh5rUkzWDN3rjTzJvhS+E?=
 =?us-ascii?Q?bY0Rh+CqlPEAkippF0JxRz79m08Eqw45l/8FEItDQ8pyOMIwnQBhfk8UooXo?=
 =?us-ascii?Q?OV3DlGer6iJFHzAKe/Jv97jsmqhStBNutPoGvZ6KwGeTfmJvZeU3In7w1fh0?=
 =?us-ascii?Q?E/MLk5T7ZA3hynat33tzM+GNnk3oQ0EcD2aIVqekWw25+I2SpGnjvZjd9q5l?=
 =?us-ascii?Q?Q66wjj/0CGkHhiXLf2u8fvwO3xKp6V0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004a3856-a599-4200-e02a-08da27f14031
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 01:57:14.6770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7JJjG1xY4fATRu1bj+xKIR7ETHM41dkWUXU5JsFili4hCXbNbM7xEOSNuATNGakPf4YLH1mglXhqL29XwDKxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

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

