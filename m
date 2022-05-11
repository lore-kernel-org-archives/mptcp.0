Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4A28F3
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 12:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652271485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6KxwViq407XjpBYg/2MwokLSnXeuG3YAotgrsXNM5g=;
	b=GZgWrBSRRHgIt6X+v+89jwj7hWRX3pgKwDZsZ+5420LtaEMuhHUXouSSeXkIsEGKiCOZmy
	5AGpcCmpoC0EVAosiyQDsK/17xcMYV+PPp3aqGWUVROVj3XFCcDFTKLd54nycsd5srIOqX
	0xIwGxO9Xwi5X1ck+KEThemrlLIkJmI=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-1z1J5_meO3SToN-1I5XqdA-1; Wed, 11 May 2022 14:18:04 +0200
X-MC-Unique: 1z1J5_meO3SToN-1I5XqdA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBnhy8hVnM3gTFX5oBvM80fq2AXho+2CooPkVgU4+viEhtgaGIlXjZ4D9hxD+eRdpD1TrYT6bADM3elFI+q/oCLiof/eUniDU7B02MjPd9GvzchmC1Ka5tSWhA+Qv819BRGHpubtXqaqSq0UyCRPoGz+xC0ueDd3V0ziZZzJqd23PVRI23YtsK4enfyMLT/dmlyPYA6hBwMMdgBtgy/I9v8Bu0Fdnrnlf27QzpHr/K5f/Kz4IGoArQgGrebGhcZro5FdtATSc/peuj3UZW8K1XsIcHPU9WLdF1Jin2x/l8aoLS4GjIuCpz8fPnW7q2poglSzYoqUEbkwnIKWljZWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEN+3zzLFXFsufRVMN+l26WgI2vygNtX+FYhUk9FO/o=;
 b=QesRH24UGGmmewYWjL2jsxb9XVW5JxBDa/w1WCbPiSGepaJRaC50seIZMPzqpo+R7nK1PkHuO7cuAhpOajbTUYNv1JD/FluEe5r9VhTuSAk6tlRCtkDW/TAhckJCzMYujsk6WDUxaTPZGyGRE1sTAzcjqRE9L8pIYVxjuUD4021pyvbFNbnJlaTHlE+YLKfyN9tV2ijM1kmlaqa+Jk99tiy5gf0ZVeMmk1/nbeqMWYFpBlQmdR/fBruMReRqfsFDABTy2ecPHYN/EgzFzn/xDfnoKUkak76feACUG4FC5hAYuAPq6CJvQtl5/34YsgsFkM2JzFpbONViUzAHMzc+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5716.eurprd04.prod.outlook.com (2603:10a6:208:128::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 12:18:03 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:18:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/5] mptcp: add call_again flag in mptcp_sched_ops
Date: Wed, 11 May 2022 20:17:43 +0800
Message-ID: <567c3b16d4058a9ddad6ee743b3d9887ea77fb68.1652271034.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652271034.git.geliang.tang@suse.com>
References: <cover.1652271034.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67fcb6e2-646f-42e7-894b-08da33484c0e
X-MS-TrafficTypeDiagnostic: AM0PR04MB5716:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5716214865382D24EE5220C5F8C89@AM0PR04MB5716.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kqd1XTg1xImzg908kyoOTJ1hiTT8cfe9F5RGZ5JeDkcPp5CcDD1wtGU/So/EfKiMiZUU/Q1mjvs4oZ1/cb7ZVeEkhx11V1OMFlS1swo+IzQ86fW0cktAZ4kAXBLhQkfR+qm2NxvPndrYAJ48CMzS75zTVLY3LBVT3BUXa34bQsajGBYScxcQWIvGGelIw3h7meTMrxXChdeQia8E1s0KoHmdhYqoEIsxsjswrgo+zbTemxXOOKx2DBTS5LL3wMKQikitWvqQyeAPY5b+Qt0gLRZjSvdU4rneu6apiNK1hSr6anyuhrUBAIXhN7ovu+MJeS6j++shjh9Z2EYsuL2wf6J4w8AVxxbRHcjpnt+xz2q668r9fOKudzbqYYwD3q0N05ytPVWP6DDXY408Rh/++sFvBmvz1nhpix4fnKh+yQNdNWMb8Pg99TGy4pXbEFYlEnAkQggD7NpD8XT0lal/8YdUoRa6T+1nlmLI8mVrXNzIRfZm8JInJo9GNwInNCGS+8guG9MKEYUNzMsv5ObGEEaAc1cdSsWXqtZtfI6H7OLb+1uVjIsR/dEHC/chfx96q+Qq+U/SZdYD1cIK7Q0zhrMDyjStu3lrbhca0QAFFmJOKJIJYjdsmXn8z1b4fnfGKuS3tRcZXneX/wFiu0G0lAdsR4FrS9xcG/REBMLRljpXRdXNnuaJJZnkdvw6HzF3I+DwjfF7wsUc4hPQDex4+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(8676002)(6512007)(6916009)(316002)(66476007)(4326008)(38100700002)(66946007)(26005)(83380400001)(5660300002)(6666004)(186003)(6506007)(2906002)(508600001)(107886003)(2616005)(6486002)(44832011)(36756003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RpgLKziXzEBHDxMsBW+F8TSZmsTmrGuAp6UO1h2kTmY1DIEv45KklvjaWQHU?=
 =?us-ascii?Q?HH9x/AvIqiwkKGFhWHqDiccQq1dywUxpQjf1IHS4ZbiQSVCqiH5dYAM/TGt6?=
 =?us-ascii?Q?KCMagKjrozTP255HsO9dFrux493dJB9if9RJjBdpNcSykhfSmCTZEy0P+Umd?=
 =?us-ascii?Q?PpA/upwkB8QtQs4c/oL5E2tdCANVQlSJ1ZS3MOwC3sUWYmgcZMdzUOty20f3?=
 =?us-ascii?Q?NEXnJ3ZtqTII/Qe4r9oOA/v818FnwLrXUPufOOHZ+htCFKzjQMq21u4GPmyu?=
 =?us-ascii?Q?lXkkiEKPyGRgtqCKKgC52zYtBxxY4uBSjGyC7FRH4gWFmP0LZ9l/WGjItZ11?=
 =?us-ascii?Q?plq1rzlXQLfK6xHRElPSCDz/7zpQFr3clu3S38863wy34VRt5+uyr6VYZ+RF?=
 =?us-ascii?Q?JNb1RvTqSa22NjDYsQWpZEqHDyReHh0A0esgY9VUYYpfOpsgTDjN8mftO7Or?=
 =?us-ascii?Q?u/1GdqdUi/aVvJeHHNzg6whr914arNgkAfXiJiarBrLr29XabtdtSkKUKIAL?=
 =?us-ascii?Q?Q/tMDjhr8FL7tY64n+qsXaDkIPx1OE1iNgdQOkex/79cCLlfom7+6JoXkf0z?=
 =?us-ascii?Q?e9BFsNRWoBEgNfa10i2xoUdcej+PnkVKUOsMa8SWHcNbP4IAxxpfj5FYmB3C?=
 =?us-ascii?Q?4zEKbY5sz9LAOeTRxx0wzW0nT0Ith/11oQPwvsbu0zg21kJHpiKML5qdRq1V?=
 =?us-ascii?Q?tMz49wwWKJ/mGkHQLHLzh7iLOdg9CYG9G0ncMrUPTEAS6T9iCmC4mSb1lKEA?=
 =?us-ascii?Q?oGyu0oF1zJprkkUoIlrw/c5JWh4Ajwx0cDQm2VpsDFFz8MyStxZM6WoHlFGw?=
 =?us-ascii?Q?diD2PN0adwM7YAB8WujIVdHOoNEy3rXW7wDU/Viy4PcmxtIrx19ESRvIF2bs?=
 =?us-ascii?Q?tjoQLlBNIj+uxQ2u89TxDFUOVHwcTbWopWvFHC1kWaVMZLB3VjHi5cDJGYfP?=
 =?us-ascii?Q?1QHkT1H4cWjfHciQqdt4OIqA80aROSfFUgn5VYWjiz8d/3NKMp26FbIMqjt6?=
 =?us-ascii?Q?YnamLZF6lM+q56803jYCp11QcxDMzNYUZKAb51grTmlA/mTqWBylscSK9Fs8?=
 =?us-ascii?Q?6SLT8ld9RQz1xmlV56ieAvnSzQyl67/TnG7B2cEYcybZZT9aMtTslwseavjw?=
 =?us-ascii?Q?Bmoy/U/v9VwJZdCNWPT9Blb3zTSb5GejQW/ZUO4xS6DQNy3FIGv9yw37lXLU?=
 =?us-ascii?Q?6t1bTAu/9NpRAi+WLV4+GsVByJ3x5HLCg/hnd2TwiJ9IRDnPQuT0jSCFXyOZ?=
 =?us-ascii?Q?IILSiryqMEGuPF/yr/A9AkBXE/AyeWvyBPDGkHmQy7hJph/sH4c+gfDDt+Sj?=
 =?us-ascii?Q?1oJjZ0+1CNlAkXfe0l/F/K9D3YwnTn0RHMpuS5toSvs1eXjaiuM/m5Z7pL3j?=
 =?us-ascii?Q?B2cf8GjugelIJC2JGaEeUsBtEiauUcTsIrFnrbvuOTcVAXZhmlwwTFyyKSwp?=
 =?us-ascii?Q?6r0TEQwQhIHC5XkbTm1/YIcPMcZr11EaQzL+54btR1wLLYrnQVZ/5p9ocXDn?=
 =?us-ascii?Q?EJUWYltRmASmBpO58OB6twNETv86B1n3IgOa0L/6qeVGADAvIXeSVVZHqw5n?=
 =?us-ascii?Q?nlNy/vi2Ik8Ch81RC2raFu+vC/18u/bzpAtRpYilwhW5w7j8StIcll69xXb1?=
 =?us-ascii?Q?SIC5z3tk6aZLwvlpHJ5/nCnXL6khQxw6mrKDDxmYm/r8VULQZrUCIa3/JFdQ?=
 =?us-ascii?Q?5FZiw039uKXVBkaHyt5BsbAdSZURCpaSZNiqsPdkgskLobrnJavvkGgojr95?=
 =?us-ascii?Q?MWvbfagmsMAMuV8L+9jymesF50kVFho=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fcb6e2-646f-42e7-894b-08da33484c0e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:18:03.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JblhKHb17z6uijGDGp2YlIPUgflCSicUPtqSV+FsgDFpXlOfSGTViqHwYPMXoo9Vy3X8PjWIk2MQ9HQrX0RZtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5716

This patch adds call_again flag in struct mptcp_sched_ops, init it as
true. Set it to false when the scheduler set call_again =3D true over
MPTCP_SUBFLOWS_MAX times to avoid infinite loops.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 21 +++++++++++++++------
 net/mptcp/sched.c    |  1 +
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d48c66de8466..8c9991ef591a 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -112,6 +112,7 @@ struct mptcp_sched_ops {
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
+	bool			call_again;
=20
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1105c8ad670f..9c1ebd7a507e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1560,6 +1560,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 	int len, copied =3D 0;
 	bool call_again;
 	int max =3D 0;
+	int nr =3D 0;
=20
 	while ((dfrag =3D mptcp_send_head(sk))) {
 		info.sent =3D dfrag->already_sent;
@@ -1587,7 +1588,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 				lock_sock(ssk);
=20
 			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <=3D 0 && !call_again) {
+			if (ret <=3D 0 && (!call_again || !msk->sched->call_again)) {
 				mptcp_push_release(ssk, &info);
 				goto out;
 			}
@@ -1595,16 +1596,20 @@ void __mptcp_push_pending(struct sock *sk, unsigned=
 int flags)
 			if (ret > max)
 				max =3D ret;
=20
-			if (!call_again) {
+			if (!call_again || !msk->sched->call_again) {
 				info.sent +=3D max;
 				copied +=3D max;
 				len -=3D max;
=20
 				mptcp_update_post_push(msk, dfrag, max);
 				max =3D 0;
+			} else if (nr++ >=3D MPTCP_SUBFLOWS_MAX) {
+				mptcp_push_release(ssk, &info);
+				WRITE_ONCE(msk->sched->call_again, false);
+				goto out;
 			}
 		}
-		if (!call_again)
+		if (!call_again || !msk->sched->call_again)
 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
=20
@@ -1632,6 +1637,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 	int len, copied =3D 0;
 	bool first =3D true;
 	int max =3D 0;
+	int nr =3D 0;
=20
 	info.flags =3D 0;
 	while ((dfrag =3D mptcp_send_head(sk))) {
@@ -1655,23 +1661,26 @@ static void __mptcp_subflow_push_pending(struct soc=
k *sk, struct sock *ssk)
 			}
=20
 			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <=3D 0 && !call_again)
+			if (ret <=3D 0 && (!call_again || !msk->sched->call_again))
 				goto out;
=20
 			if (ret > max)
 				max =3D ret;
=20
 			first =3D false;
-			if (!call_again) {
+			if (!call_again || !msk->sched->call_again) {
 				info.sent +=3D max;
 				copied +=3D max;
 				len -=3D max;
=20
 				mptcp_update_post_push(msk, dfrag, max);
 				max =3D 0;
+			} else if (nr++ >=3D MPTCP_SUBFLOWS_MAX) {
+				WRITE_ONCE(msk->sched->call_again, false);
+				goto out;
 			}
 		}
-		if (!call_again)
+		if (!call_again || !msk->sched->call_again)
 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
=20
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0d5fc96a2ce0..10736c334ab0 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -67,6 +67,7 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 	msk->sched =3D sched;
 	if (msk->sched->init)
 		msk->sched->init(msk);
+	WRITE_ONCE(msk->sched->call_again, true);
=20
 	pr_debug("sched=3D%s", msk->sched->name);
=20
--=20
2.34.1

