Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25A20EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxjZ7pdD83y1hS4EYdAGlaPJc1LSgR709t2FR5yS/zU=;
	b=SvhvF0K9vrHMOlDvam8sZzjg2iH74v2nHD76p0Py0rTZvVxL5kxPLzQPKtqgAoaCeQN+l9
	r8P99rh2WgaROCz5OWZa0SaNxAb6HytlgvuuHZgLWg+d2/A+49QZCowWP3T1LuDwpPNg+b
	8SfJUE+ass4Aq0Aa+Q6E3WptJfdHD2g=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2057.outbound.protection.outlook.com [104.47.9.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-ouM0BFotOtedFmnXZX4VlA-1; Thu, 07 Apr 2022 06:03:53 +0200
X-MC-Unique: ouM0BFotOtedFmnXZX4VlA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2AYTCfZQI/iX6ASbo4U/KnV1GgytKVkSamfriI29F4KtL0hGeEIqDpvckenOWEP1mL99cz8wotuK8gm2ZXi68RGCCp9ZtaGCyjxtM9tW7NAjBcYNrQTl4QL4PtTEsdFfYbf+JEn0pnSWbZ0+4fStSF7N9QrG0psJx05IKYpssQ+VWN0xcdewZ1FhvdxN2dbaVtjZzbjRS4Cu+UIGQIlzpK8wkZGEQggi24cvfAm42vCSGULe3x6VuNKkicnStPC2KIBiortzSzNsuPJMjjVs8bCGIUEs/AwPLglDpII2c/ANxPtB33ZRg2vSni2eJ9H+yuXkZi4aBLt3FSOFuVhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIFj6RPpzflxj77/1/bXfH0GhShReIWDWHFRc2L5qRw=;
 b=ltCcYZ312oI8maZDVb1G4l33tI9ItOJrQjkLy/NA6Ok968ScXsNE/t/N3bGL6QqoH55+F09oo/dIBt9O2H+wPl6Fwu0iZ3XmhbeJjvi08pLUI7c/qB8ULvbm0/VJvwW8/3sD/2RcmvLHLejxiXV608SqY9gKBHXoX5BrP6laTYLlLf8XjWl2IXrx+IoE3NwTn0Sd13wYjMbcnv/TaKeM57nDo93r+zAwdFLyR+BPbvTJwOYbk4TCGiE6sDQPAZBG7jT5VMa6AxCp69NJkDrZ6XVYYwS+fVPvSupv0txGthr/emDTx6kRwObwqjhmU2Ar4LLPdlroi+RKHgeaq3zHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 04:03:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:03:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 4/8] mptcp: add sched in mptcp_sock
Date: Thu,  7 Apr 2022 12:03:16 +0800
Message-ID: <acdfdf92c72b4a80eda84b9ccefce4d5bbd09a5f.1649303876.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649303876.git.geliang.tang@suse.com>
References: <cover.1649303876.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0012.apcprd03.prod.outlook.com
 (2603:1096:404:14::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7395bd19-ffb8-4f79-9669-08da184ba096
X-MS-TrafficTypeDiagnostic: AS8PR04MB8818:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB8818DAE951394EE04138ECB0F8E69@AS8PR04MB8818.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gqpKfq4MRS/i27yiSaxzMzJ8Cc+2KWNP3/PwQkLpIQu2ucXXBiOFE8IY4fl/rvsycrrdo+zLe4JLHY6uj183h8iTwEwSt6cuY/c84fizMKdhS27KCkpajxsS50kmGe86+12HbdeTcwOTT0ro9W0QGIYb6iGb1k86YO/tXut+KnvRHDcum418Bi9K2RM6AL9uTBcOOwQUBqptGRnXaCoK5/OqbRRR9FtjV+la7OOCh99sV8SpAFEmA++VawoXp55G5ybH4YJ3PMJA2l2sWOlH8oAjz2E42KzJWSQi8ST7llfVf8tZPLjDzGW+J2HS9sGIab5JPQy0u/K+82Si3vkgIMtj+mD3wDFsm9ViFwobmZqawD+X4ybGLmKjB14ZEIhNJkjIfmvVFv7fn2rjXxp7bYCgSs3kmF2kSysvu+76UIT2qNlk0aYA6RAauEDprNXm0+0Unp/hHf+FRpXD/l+4ojtJQhA/Z+K5xHjnEGK2LLRNnvgqC8JxbIn4gpCA0f7KD18dO6ssoMXFv5Crr8uXw1SLsfV/CD4W2DzqzdwA855Z6a1ynd1qIwyJ/DwQlxR61BKds4qVxCJS1ercOgk4oe0kofgY5UZYsVnsypmRfCrMiCN58HSB87m4v/k8TmrCAe6KrReXBIrrdSKXwvSrXY1FNCHmvYwMNuSV/mFk2LyWBkxvqOhqdANZyh/I9P5g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6666004)(6506007)(508600001)(8936002)(6512007)(6916009)(2906002)(4326008)(316002)(36756003)(6486002)(8676002)(107886003)(66556008)(66476007)(26005)(66946007)(2616005)(83380400001)(44832011)(38100700002)(186003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aWma+K9bftSJLq+iMS20AqFPTLEdd5gJ/v2cImqM6FRkXxJ45QizSUkC29zN?=
 =?us-ascii?Q?RM0bV72x0MZU7I03D/uSmuadQI11e8JdFjWAOBQaHZbnkz+XTQne5v368adz?=
 =?us-ascii?Q?ZOmAThucrKxQLjweVszSsqdLF5qTQTPfsEpZjlbWkjzgml6nHXa6JRbBsfnt?=
 =?us-ascii?Q?9UOUUx48ov22Ry1S1HVDTjq4b8qnjpdaqQg3U7ScFELovZLrE2hhSERhoNA0?=
 =?us-ascii?Q?zM1E2gvBx8KmUBcrSIpiI7fNDqKfJ51yA+EbC7i8oz3PJ/oPS8NqLL/A4BFv?=
 =?us-ascii?Q?oQ3LOsO3F4IX68kx1+SANZgPVBp5QRi7FrUv85K3WPueSpgHQ7l+49URnEXs?=
 =?us-ascii?Q?12xadPaA70PbzI4c7z0IqlVfwVpzuZ3PKWQL0E2QyDQ3MvZAHBS8Kd+tmtMX?=
 =?us-ascii?Q?j17TKGw/8Ix1Kqn4eo5S6Pbvhg4/mR47fYaGsdcV3xAfjlaKmB7HVnXDnAUF?=
 =?us-ascii?Q?Un1wK4NYXVqpnHUDstwc1fnjqmlYXzMgOfuI7HbcsLNuBfw6izplChtHgmJx?=
 =?us-ascii?Q?BUOVxnRvGtXeSharYiw+tGbwwuwNUH4TJUZAJXERMnO4/93dfH6ap1dEUUFB?=
 =?us-ascii?Q?72hlhMU9okFruKoGEWos7DNoP+eZr9J9YbQFQWykxhaDyhnBofu7uuUf09/v?=
 =?us-ascii?Q?izxaUaZfLR76pTzRvltRpdhd2VPXgXy2wakEzEiPrOQk9L+cslg39jwGnARS?=
 =?us-ascii?Q?bLfKTeFgVHItwhZXXAACX9uyF4JGXx3gGUs0BtepIaOCaNhnZBWLRBptV1lP?=
 =?us-ascii?Q?W9hJSASNQJ8Xsic0SZ7uparlx8s101CzNMVsSwTTDXMqfrs8tr+f6xXekHD5?=
 =?us-ascii?Q?WiL9x32tr++aJIjVQhaHy2VKIiaT8ys4iMRXCJ3WG23t7CLH2MMc1yEXPvi5?=
 =?us-ascii?Q?MpEaDUclovyoVA7L3iAy9RSyBqy4MDFZT+a11jzRmbvtAPJE8fbzVm3gU5gu?=
 =?us-ascii?Q?BvZ6obpWyZ9SXfeqeA+DGOJ3Yn2i59I+Wj/gKAr52VeFUubz8jfR1Tc8HiBq?=
 =?us-ascii?Q?rXgJhkJP9b22X+HXFFYmidTlHg6lVhLeOkP2ejClsJmUMo3/6yym21c6VAiU?=
 =?us-ascii?Q?35n72Xp0awctQdEU+OOT6lrBN3VtFGA8gQsYh20cYGIuMHuXOvKSDOU6WR83?=
 =?us-ascii?Q?89Nb5ngMbbXyKZFi6oDQEG23sCdqm+nFcoTp04pN65eCkySE27VkA2WZmrZB?=
 =?us-ascii?Q?lTeL2zXU4yjKO9SAM1tv2StawCZ/p9B41OzjG++1pcx7RRsI+qgrsdSSmWGC?=
 =?us-ascii?Q?oH8DOs9+DRZ5TT3rwAQms0xlUL3uMIKM37SSDSUUYm1YAOUwNToSF6Rat17H?=
 =?us-ascii?Q?zLOkiRPhlnOCDZY7rLJSrZcndUn8Q+lCWPzJ4FfhUWmiXIHZvT8OfqDLGPfW?=
 =?us-ascii?Q?rLNRsRHIzbwUsKweWWwUMi6N3dLQ5+XHOv/yuDrJV2Zep8GpjAnxqmeLxiv2?=
 =?us-ascii?Q?7IEPjRIHWN2MFUEvMTTK4/oyIe8QbimH3vm+Bdjngh5/IYbU4QhVBCaCRkvK?=
 =?us-ascii?Q?QRH+gnqNbKI60dM3EjA4R/y8eiBSLlBIQ1T9GXURYJre3wAjf6miCj7xWf1c?=
 =?us-ascii?Q?zpjCrECgi1Y+/blRH5TAp9apfoKACuapF5AIySPQM19ZmizNpKjmXstuPgor?=
 =?us-ascii?Q?QNTz+/tHj+Z41bZAgTiZC9HKz+e2QlbrJfBGTro3xy3VYlDPE+U5hlT91Gsh?=
 =?us-ascii?Q?YOU2RJxi3IpLKQ2sR370rkjWTam7iccyy8Qeqqh4qsNgs+Lc1v57HEq2ZtqH?=
 =?us-ascii?Q?dLnQCFi5H15tIBDdmy7atv09hkB3MEY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7395bd19-ffb8-4f79-9669-08da184ba096
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:03:52.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XdNGpKs+DQ2wWl1lVo2XIIdoPwXBrnjk7tTzu99pstLaZCm8Jym4SkJvcZztd8KqOFe/Wn1cjio0CDOCxLy8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818

This patch adds a new struct member sched in struct mptcp_sock.
And two helpers mptcp_init_sched() and mptcp_release_sched() to
init and release it.

Init it with the sysctl scheduler in mptcp_init_sock(), copy the
scheduler from the parent in mptcp_sk_clone(), and release it in
__mptcp_destroy_sock().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  7 +++++++
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8f0e71c38336..37f4f6f3661d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2657,6 +2657,11 @@ static int mptcp_init_sock(struct sock *sk)
 	if (ret)
 		return ret;
=20
+	ret =3D mptcp_init_sched(mptcp_sk(sk),
+			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	if (ret)
+		return ret;
+
 	/* fetch the ca name; do it outside __mptcp_init_sock(), so that clone wi=
ll
 	 * propagate the correct value
 	 */
@@ -2816,6 +2821,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	mptcp_data_unlock(sk);
 	msk->pm.status =3D 0;
+	mptcp_release_sched(msk);
=20
 	/* clears msk->subflow, allowing the following loop to close
 	 * even the initial subflow
@@ -2993,6 +2999,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una =3D msk->write_seq;
 	msk->wnd_end =3D msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
=20
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack =3D true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 65a08110268d..1016dac065c8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -288,6 +288,7 @@ struct mptcp_sock {
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
@@ -614,6 +615,9 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sc=
hed);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched);
+void mptcp_release_sched(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 52828eb741c0..5d20d252088f 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -68,3 +68,37 @@ void mptcp_sched_init(void)
 {
 	mptcp_register_scheduler(&mptcp_sched_default);
 }
+
+int mptcp_init_sched(struct mptcp_sock *msk,
+		     struct mptcp_sched_ops *sched)
+{
+	struct mptcp_sched_ops *sched_init =3D &mptcp_sched_default;
+
+	if (sched)
+		sched_init =3D sched;
+
+	if (!bpf_try_module_get(sched_init, sched_init->owner))
+		return -EBUSY;
+
+	msk->sched =3D sched_init;
+	if (msk->sched->init)
+		msk->sched->init(msk);
+
+	pr_debug("sched=3D%s", msk->sched->name);
+
+	return 0;
+}
+
+void mptcp_release_sched(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_ops *sched =3D msk->sched;
+
+	if (!sched)
+		return;
+
+	msk->sched =3D NULL;
+	if (sched->release)
+		sched->release(msk);
+
+	bpf_module_put(sched, sched->owner);
+}
--=20
2.34.1

