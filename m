Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D448D0
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 13:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646745455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYPDNfmCVnLrOz0gyGkmvgagnx1AJDI1jDzFUgxZUnA=;
	b=JfFSJ6/7ZdWql6gm5z+QCGyS9bcPJc3C15eX4sJp9RcHngatiwcl6CCAwDKw8otNYNLeZw
	esv21Pd63XWfbHNNJUtw6mXZvigK1zktZJGcScdUfKLW3+NumG4SnrWVPW59UahCUkVhB/
	spaKGVmniNxo/+YOJCsF8gcs/LYNVL8=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2055.outbound.protection.outlook.com [104.47.9.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-jgUr4z-XPBaBOKyvGbrUfQ-1; Tue, 08 Mar 2022 14:17:34 +0100
X-MC-Unique: jgUr4z-XPBaBOKyvGbrUfQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhhIPTwvxXQXmgEOSYCldw1WEbYA2Us0/yHNHXf0AlhEodv3tzdLaHzq7wP2Tjorpm5sb/NoV2fZ+W9SjqJ3ZqsIJFZ6CZ7rRcB1eockA6R537Ps8N/0KRrhV4QEFEum+Lc/tUEMIdkRpf2713DQNCiBngVDfwt8ZwpI7HU2pciBs7WcUhci8bXuYMDpmPtn4EPR3WPcPAE4pa00pZkzKoWvkZy9V7PrRh0YCgKYlUaUoSRW+vXEghotm+w0xDcXkHK6daFR/y+eKM/kaYu9YEbWQ6Cp8Tf1MzKggnHQLSQXkblILhIqAeR+lQusPpsVjCUuUar9y+xUQQH9Sn3qRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y1xhUxGzM6BOcEEjmOFfBjPfuJRwEJdeGFCk8YardA=;
 b=jcxU1G6jlXQ9SQSsIub6XmTEN1MXXL5E7yDY4g8AkIRKDNTeRFpJPPYOGJ0RugKCQGk+6nVsT2RMrA4Aft+XspSF/c2l6+KvEPX4Xu3pJTihPF6i33Qa/C7UX/fHSnndYniZZ9++Dun6laj6BECj1Xwgf1vrrG80DG86edsE+HhcA4oML2DTZqYqErV1TA++gijNr1UH2Ae3dNlStxMswsWGIB8G31Hs1HtkHbcZ5B1RUEWpYac96IkopfIvNB/PhOj7TZnrwWqkxGUN/Ke/0kAPyHufLp63oXyM0H+pv/8ugVDHjYJWpNOo4RKrlUxiA98vuJKs4QOdJ4r5d/fu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8142.eurprd04.prod.outlook.com (2603:10a6:102:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 13:17:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 13:17:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 4/5] Squash to "selftests: bpf: add MPTCP test base"
Date: Tue,  8 Mar 2022 21:16:57 +0800
Message-ID: <b1632557aa3911b96ff7ad1346fe604fa23eda6f.1646745228.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646745228.git.geliang.tang@suse.com>
References: <cover.1646745228.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0195.apcprd02.prod.outlook.com
 (2603:1096:201:21::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4df1ccb3-d7c4-4f89-ccbc-08da01060165
X-MS-TrafficTypeDiagnostic: PAXPR04MB8142:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB81429D2F4DB4865A1C51B154F8099@PAXPR04MB8142.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lvdb7ckUSJkTuoiAtdHcqpwHlLiW0J39yOuG4BvpnTYdWLNyzNerrAx6KSWY4l5eyjYmbnblFMlDYevqXHotF7aQkGsR30cgOzikHj1r5VtPRXeXD5DcFX3Fn/y9qEdP1MN0POiIPg8XcA4FCEINl0Fqr0yvttlcMM9x7oEP22F2et59h/lnTluY+dz71CRPzkLCZL+e+WT31msqMpIpBPzvAtvyCcSizbPGYGO/miVqjlxVIiRvSeE98UqEnlw39/88Yu2Y01XJOXhOstMrnTrkz37ReWfjJNpXjGr5Mj89EFEv1E9Izjmcw7lA4jQYSaZhot+sEId9LDS7mZj2n26hxaM00x4tkZkCLNxTt69lrjrzEDsr/qspyNqp2yXGUPTAT+PwnYBTG1Y/XaniRH7A2YtsUJre0WgRVZcNyErCBTWCnTXro8gT5wuzhlFzRUq4L8xRekpHMRFdPf/2pOPV3crqzwQ8A/kDRnde54JQ3fx5bowL1WWrjHGGBZYAK5n4NmoMm33hkXAElOWVug9QI0bDLaLLvlL0mGS1+FWPACQkfjm71wNqh8hZNMEBqHbY7+9DHIe1xy/sRJsEQ7Fp1IT9d3k7tgsFK/f+L/0JKJuOuUgCJyJouQY1It0rJH8ubIMsNaWsVPbh8bujVxBymiCRAqx9uNjkngSqsfloVOs1eetbQ61/TGJJFP5iy78TvGE/WLJ2xuGmtVflew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(316002)(6916009)(2616005)(6512007)(107886003)(44832011)(36756003)(2906002)(8936002)(5660300002)(26005)(4326008)(66476007)(66556008)(508600001)(6666004)(66946007)(38100700002)(86362001)(6506007)(6486002)(83380400001)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KxfQGQcj/s21L1QNGiGbb9d0XSxM4h2NXh1/Vw5YqaK13BD1N89YIPER6RD7?=
 =?us-ascii?Q?Lg/XsObtjsR7GXnVcSxmzV5WDiBxy2or1Tgqrq8qN66EAolLau1tnaNDBBbi?=
 =?us-ascii?Q?G+isX2F7InzR1J59DBpbYkIpQsBxFeZL+0/heVpJfMY9tv3+EM7GfXNzxqrv?=
 =?us-ascii?Q?y0EGcWLRqPaj/7voxITW95NSvJFxnW0QROZDysDp56JE47kpUxRrYPibSA9K?=
 =?us-ascii?Q?rxeZ4gNYgqUwEcQZg1re9ACizGqAeg92CnuWXobuEct5WcvbQX/HOKLX+wCI?=
 =?us-ascii?Q?Kow81f/y06g/piPuEO5niE5SCrTNPHlNZN8wjxLYGB4joCe4+YtzT14mW2Nj?=
 =?us-ascii?Q?SfebnX1l4DAvEr0y0fnvJkp/5O0K2aCDoLup4wi3TKR5R6dHORAKsq7IdCXc?=
 =?us-ascii?Q?c8Nvz6RyGrHcLBx/pTJIvJP/wBx6H1qPtRS4zfr4LpbcLcdMRPz9eCsjeLG2?=
 =?us-ascii?Q?LthWdrQoHp8QLueASvelGfm9TEKt90iYbiTN1J421u7vlTeRbs2jeDrQlBac?=
 =?us-ascii?Q?ugE8MGfSJJMNUeiVFSJIc7hdbyJyH4GKwA57nAZIz1NIcUpwxkmiULC1B0dp?=
 =?us-ascii?Q?4YIgwNvdqoj3NeUnYLXlU70GI/2a6GYpWjwW+OHWUyor8E9BB1s9HrEwjJvj?=
 =?us-ascii?Q?TNm87hMbde6mPIgd15m0xv/sGZw+BxtXNqJMIs/EfR24rM2KL4oTfEMJ3ACH?=
 =?us-ascii?Q?LrnfYJGXqeCELr6Suu3JxYMDatw2XhyL4NNE0hhpKsz91F1XNYoubiBn8hBR?=
 =?us-ascii?Q?3IjPRAQv1nMeBOQYYsvhXXYjyXSpcKFO23XuHzI2F13G4UbrOeZ0BIjnl4Io?=
 =?us-ascii?Q?uZ3NKtOqOCIrOiuhf6Fyi/3fi37dCIkRxYSF8FwIjZxNLRSTzJyILxUuSF5T?=
 =?us-ascii?Q?vaXkQeY8EhMNCcXlf+TcBZIvczgMh0C/+MmoWaVtoAoKWofWQPUUM91OWzyI?=
 =?us-ascii?Q?OaGSmSPx9teIJbTcJiJ8GMmJCtkCxNY+jrAl8GRrFobt8MM6gn7YpNzEmMfp?=
 =?us-ascii?Q?Z+8445BxOgn52SxU7DwlmkIMOkGlFcAbg8YHYQTF9liAo00/aipQajQ445GG?=
 =?us-ascii?Q?6bMSXYdS6qT95OWCZcthU+H8UojL9V9kA7DH82csbio2P7y1pEqbYkvP8iCr?=
 =?us-ascii?Q?CWErFdqVwPRiEjzQ9qySlubRr2xfTM0yDmFFNRluNukgOm/hD3iftoQbyQcW?=
 =?us-ascii?Q?fWOsCTqdFSUk3LZEb4ybIsih96hXl7CUcUNjfOnKHUIrVM1dfGRjB1KPp/5y?=
 =?us-ascii?Q?Nwq7V4PrDKCTD8mqPrdiKeRcmJVihyNUzExP0lHGC+c4l0c+pJRQmFknpIz1?=
 =?us-ascii?Q?L1kNugOQsJZctwG84k9xzjYU00bi73wdiFS3lzOqQehjH/m+OKivs8giQZmN?=
 =?us-ascii?Q?1xT6OX+jNwAgBR9mjYhr/Hi0hGBIndKPQTtWjrLTyczvbPFGabu4HtH5vJdY?=
 =?us-ascii?Q?xMMHmXFDEh5ZMPjeL+fvS1JQovuvXG0TgXKlZHVWjKziAcB5GfHVi43Uxqbg?=
 =?us-ascii?Q?/zbJCIOrp2RGDoljYRzoNey2wcT6Pc56yvUxIkquhitBLrJb22JU5HuYIbo/?=
 =?us-ascii?Q?+Br1U5oyxlkAcUxDIOOzNqP0C+LX4THm63UTREqbNHaxtR5tWpDOoYGN65n2?=
 =?us-ascii?Q?Y+nkxwqpniuPJR3DKoQeyCM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df1ccb3-d7c4-4f89-ccbc-08da01060165
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 13:17:33.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApcLFiBR5AGPVSSjGpnLP+JR4NhPKwFYMGfmzBPkDmGevtouyXgC6+3bjKylafmXNYFd7sQoZ6R1WICvgBP+sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8142

Some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 16 +++++-----------
 tools/testing/selftests/bpf/progs/mptcp.c      | 14 +++++++-------
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 04aef0f147dc..87ee7bd8a689 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -13,12 +13,6 @@ static int verify_sk(int map_fd, int client_fd, const ch=
ar *msg, __u32 is_mptcp)
 	int err =3D 0, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
-	/* Currently there is no easy way to get back the subflow sk from the MPT=
CP
-	 * sk, thus we cannot access here the sk_storage associated to the subflo=
w
-	 * sk. Also, there is no sk_storage associated with the MPTCP sk since it
-	 * does not trigger sockops events.
-	 * We silently pass this situation at the moment.
-	 */
 	if (is_mptcp =3D=3D 1)
 		return 0;
=20
@@ -28,14 +22,14 @@ static int verify_sk(int map_fd, int client_fd, const c=
har *msg, __u32 is_mptcp)
 	}
=20
 	if (val.invoked !=3D 1) {
-		log_err("%s: unexpected invoked count %d !=3D %d",
-			msg, val.invoked, 1);
+		log_err("%s: unexpected invoked count %d !=3D 1",
+			msg, val.invoked);
 		err++;
 	}
=20
-	if (val.is_mptcp !=3D is_mptcp) {
-		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D %d",
-			msg, val.is_mptcp, is_mptcp);
+	if (val.is_mptcp !=3D 0) {
+		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D 0",
+			msg, val.is_mptcp);
 		err++;
 	}
=20
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index be5ee8dac2b3..a14ed1b66da8 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -25,22 +25,22 @@ int _sockops(struct bpf_sock_ops *ctx)
 	int op =3D (int)ctx->op;
 	struct bpf_sock *sk;
=20
+	if (op !=3D BPF_SOCK_OPS_TCP_CONNECT_CB)
+		return 1;
+
 	sk =3D ctx->sk;
 	if (!sk)
 		return 1;
=20
+	tcp_sk =3D bpf_tcp_sock(sk);
+	if (!tcp_sk)
+		return 1;
+
 	storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
 				     BPF_SK_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 1;
=20
-	if (op !=3D BPF_SOCK_OPS_TCP_CONNECT_CB)
-		return 1;
-
-	tcp_sk =3D bpf_tcp_sock(sk);
-	if (!tcp_sk)
-		return 1;
-
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
=20
--=20
2.34.1

