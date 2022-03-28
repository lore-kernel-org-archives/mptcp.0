Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA867C
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648460321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oKutPvnMzM3swtNNeFaTLnrh1cmPsDkeCuk5p70ObA=;
	b=K92jpCL4m1Yjh5R5VE3CKN/5QKm9SdZD8hbWfUhFxyhVg27tORLP8WxZBWZZdGChAWO/js
	9xFBGbfN1dVfeImTs7QqE79anmkmt9s+shEd/ddyTm8EsrLXB/PCMGiISmd5TT+KGfW+pn
	TAFf5H5AVORBWhfrCBSWIhXOu706h/Q=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-Z56jht4bOs2PJMaAANRyYw-1; Mon, 28 Mar 2022 11:38:40 +0200
X-MC-Unique: Z56jht4bOs2PJMaAANRyYw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0g0aa0MaVFTdBczbr0msFDCUydjnfOvwfb2U5fKCnjIHcrfj+0+O4GiHeuyFYd2ms/+mxJoNWWB7e/6YZomAaGO8Ho9R/uBSnyWbwJva0xha6fJXm1+gTogP5pudE3+iO2h5l2larBT8mIfbb8Tppuethuzt51yOuc4A5fsQBdT/79DKCqG51DJklaoQW2+Nm3iIEMh/Qk6GhRuXrmmZwq4oBbclFsVf2XSY+Jp+QGCqrsLkV7ME6p0I5HTit+AAwi0XxS3kvZKpyT/yx0xxJBOS6+M4/o7vgQmDWO3ryb8733iKyzsjBs+PTLvKtjdhD1HV7FOMmQ9L5Svi80mMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY6MF4M9CX8TK0ALy/ifSnr1BGXIGefGh+XzM7fnKbQ=;
 b=TI2zYkLSOnjwkjngfkieR4XLwOH2hh6LMbmClV3iJKejhjayYSD1wBmoP40Ru6pBM9C0YjiYE2AiY5TZ71EUrfau2TYOhV+xMHsUA/B5/dIzAes02ncdYqwXaB4LBUOxvSNq0JFoie/xL+3LTVQse6U3f3Nz7PCme8sEzMmeVEKKbCtB3TPJTuJRZaDGRZEaCEeKNpPkQOFFNk0aNQpjZKk8d1iCuoPdRCMcZ4ddmFe/x+IgJVm9/iU2XL8TAgTX1sdSJ5ReGx0IEnXlQSmlGXfTs+wmE8tyoiL+URJRSCIdL7shrRmo5R2a4kXt8HKdwcqXERNWdaG3rlO+9Xdk6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5067.eurprd04.prod.outlook.com (2603:10a6:10:1a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 09:38:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:38:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 5/8] mptcp: add get_subflow wrapper
Date: Mon, 28 Mar 2022 17:37:59 +0800
Message-ID: <c68baf469fb984a4f5cda094736efb0365a81c23.1648459865.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648459865.git.geliang.tang@suse.com>
References: <cover.1648459865.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d75a7272-5c2a-41a2-db0b-08da109ebcd6
X-MS-TrafficTypeDiagnostic: DB7PR04MB5067:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB5067D5BA0F3D25252A14ABFDF81D9@DB7PR04MB5067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m5FbTrwKq/zdRz1Lqi8HjS4u1XmFi+uCiAT/pHWl+hwZvXuBATaHYzGShXaMCmWw+CCIK6G2aZ9vOj0+GbdBOz1VexLnVnyRBx9uWP09G2/ueRRfFMxV/KVjCfcBswRntmqtT57GBQBeftJQzd1Bp3RKHuFIxLtZKZmomiomLqZgIkUr6CRcH+6b8KVnCLJ+ERDYvlY6JtO2oYMQPsnGkTMM5G54ql7Atm4pH1QugPYRyE5+Pt8gehAVgmVc+DrqZRdYp+SgIwp1YKZomazfXxhKsBE4KATKhgg3dh2yVFoeVINIU1o9N/AS4aUcD/+LYSVjqcc7G/rCfs+kNCXihuMxtqF5dPCgiDGwvTknMP7dyf4BVXU8naN7SC56vEYPKi7I5OVbxtbUXbUMHzepry+vgtFzmTPA0ythfub9t1DDr/rqObAKANNmBEbPgGVQN5TeG0qjMyS1nnxaxUdcioRH+vVlMbQRTVhaCTdJe/Gls8k7vP8ZXIbwrmM8H/ax3am3LXuAQDGfGq17YdU22q2+ovJNwdONw59yyKaKsk8Wa3CNq0YWNaoCk9JlVhH7qZeO4bfJhsWJRI//z6SeXEEp+FL4fklsacRLQ4rIwbrDOv+HpZHEfm4v4JfwLNOsAZS/AaNLuhm9gIlGBFhnTvUreLjZx20UAN9FrPcaNVATmM2sr4dGbaSkfILR86xIJCijyO1hPedD9p1nQK+lbA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(66476007)(66556008)(38100700002)(66946007)(2906002)(8936002)(86362001)(316002)(44832011)(5660300002)(6486002)(83380400001)(8676002)(4326008)(6506007)(6512007)(508600001)(107886003)(2616005)(186003)(26005)(6666004)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4tjc0tydP7kr8k4n0cAcTVXjbRkE3Nzv23UeeeELosPaXJNcJkqK3GlzNFry?=
 =?us-ascii?Q?Fq4t4ttDI0+aijHncnHBAKqh04zRhDNf9wnsUriASalMQOpHODzJzpvyUI8T?=
 =?us-ascii?Q?PcWIgXqq6UMJynU9r3u67PESMorL5UDUSEnK4uCIqbOvGCAeGKqoWJsaIJy4?=
 =?us-ascii?Q?Z0iXy7souTA5kA6HWTl85YAtMWWaxHi0DYaOEqk07ptlPoN4wG4I1XduA757?=
 =?us-ascii?Q?7aPPa7mSPAAqQrBjxzIuCmNjRBCKVSR7BFRfjuXdeFRzpn3TsTeJHQBvWonp?=
 =?us-ascii?Q?IWnRrcXzQ+0dACjGYa/dpmGWRLiBioviMXZJXCWy+d29XUQQyEKlIvYNrkMu?=
 =?us-ascii?Q?2LqJFrJJxUR249Zq2RbLiUNxT9Ut2YBES3s7jhPsGQWroxtpZhzh87qiqLFz?=
 =?us-ascii?Q?tGRP+1m0INVT0ZMtMfXgnwO50UWgphPfvspxL2iYG1D8PmXa1GkBpN3xrw5O?=
 =?us-ascii?Q?CJmgeSeC4Uxd72MsZuEcPl6ShqhqnYAkxt1vzU34OxWuIDiwbph0fdjhzTkZ?=
 =?us-ascii?Q?njTcqkVpClCpyOeCzs0IJHYQCO013FYBGUyAOoegfiEEZsT8cpdaaq/Iieau?=
 =?us-ascii?Q?3ODKLOSnoxLpboLgqT9GluAUjumOqZ/2seLL/8Utu0UM5QWHjcCrVcZzRjoN?=
 =?us-ascii?Q?epViyCv4Mm61i/sw/dvT4U8jPQdhnbSeBhZNXds16WsmpIqeI59oo5gP8uNe?=
 =?us-ascii?Q?BIa8dvJAEMAmNYukvGAWIRMyzDWG+RtKXpmEdlEpz+wfcsHdU3h0TjE6D3qp?=
 =?us-ascii?Q?UiikHGixywVpTPrOT/Jktd8eQbNnvzFW5cSRpR+q2GcFOkFj/LIJz/rrRaZD?=
 =?us-ascii?Q?ZtxVlXOlqpQaC74gZgqSMI6mfCvOSV9YVPUyuy1C5QKs2Hn6uestxZEUhjGT?=
 =?us-ascii?Q?jHreGj2zUU/rT4efTnkR4COmllY7lWxEBWE3xvvKncqjZ+mp3jFNOOw6Sr2d?=
 =?us-ascii?Q?+fBGyjYeNmtGjzKin4dOT/L04tjz8X/E/Hb8/VwUqlZIw8rJPOOKU3yszPT3?=
 =?us-ascii?Q?lAsUqkZL6RG7nXCJmg3noWK3CRiT4dPNIk8xzh3iq+l6RR7/Ixv9yGZ4e80r?=
 =?us-ascii?Q?TofOfAhGULMboW6cKQgCVQpxsreDJnF8D3IuRtCvF8iEYkszP11NRJfadE05?=
 =?us-ascii?Q?DyWqtCNz6R/PaxY35/Ek1yTyHGEBtMkNowuG4++2FxLSCe7I7M9rncFZb6KZ?=
 =?us-ascii?Q?v9LRfDo5TKA9QGQLkeXd+zGn/a6nEKG2GKmh8GnObXyP2riO43bne8rtmzBF?=
 =?us-ascii?Q?reXQH1DFWAuvQB6ETCYoqb65sxfc90xinpceaTG7p1YZwqJGKvC7j0FVE9dg?=
 =?us-ascii?Q?U0l9YDj7aQBuGQhlL0kX/komvG5ChZwJLx65w4SBpFMEozUy/m5c+9/n7VH0?=
 =?us-ascii?Q?15pgs+4/IMAARBvB9nyDfeVxTP2XojAsLSeFTn034BbdnIX9bSBoh8y7I4ke?=
 =?us-ascii?Q?6pECWtLQVBP8rdiil8ryqzkKf4gGuYdcI96oAbbu36VAnwLjQEKFoFdtObzw?=
 =?us-ascii?Q?Fq909Obt2k/BDsQ+99g/W/z1ieA5uJFMoXHtxaRSNOXoQizX/s+ZrgLK7coj?=
 =?us-ascii?Q?nvy8qZ7SVvg5yiDA2H8V13F3P7p+vY7PgEqeW8gpW9FxA3qfo/3zBHTWf+LV?=
 =?us-ascii?Q?rucCmyjonOLVh/PkF4ZS15NDfH53UL4Nfji3+kGyzxx/oD3mgRdhRHbQIRvE?=
 =?us-ascii?Q?Kulh+EyQ1EzgZWlzfpTkEu2L+/wfHfD8XWZZ37FysAH3POyARcR2ulnAwzKp?=
 =?us-ascii?Q?LJSb7SPDzUf0mF0WkwHmczKlkb3NQXs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75a7272-5c2a-41a2-db0b-08da109ebcd6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:38:38.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fOQwYVdCClE94MaExATSuq2BkSKBbeW28qDOPOFOEBAdbMMNSdwCnEu4ua0/pMhXL7WOyOG6Z8K0/yjBURxIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5067

This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
get_subflow of msk->sched in it. Use the wrapper instead of using
mptcp_subflow_get_send() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 net/mptcp/protocol.h | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 82b3846147a6..7bc7768f63e8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_subflow(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1636,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -3135,7 +3135,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_subflow(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 81c35af7ade5..31845b43242f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -623,6 +623,12 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
=20
+static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk)
+{
+	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+				    mptcp_subflow_get_send, msk);
+}
+
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
 	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
--=20
2.34.1

