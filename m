Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042B15A3
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 03:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646797001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hX1ldgh7TUcFLin3Qq5uxCXenLmhGeSGDZ7u0Hv4PV0=;
	b=m/VI2z/rLR3rmlhUi3whInTP2DaM+JA0evTW6wITBdCUGXJMspI3v9H6LhB0dnpqCJnfB+
	CnH1Nlhnp4SvYlgyUxPsWDv+0Doo20bgwWTQ9TO8LAtsgbwfECRQ7DlMdaHuHza9Sv8dRE
	dtZNrcsxSA3HvSAye9B0jcAc8uEsR/Q=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-oQ9ZRF4MOLW88tRGQuR1Vw-1; Wed, 09 Mar 2022 04:36:41 +0100
X-MC-Unique: oQ9ZRF4MOLW88tRGQuR1Vw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoKkaAWT3o/DOAFHwD0tLwdWXuhN0c+lyCJwMlerjiF+v5TKsP9gXXT+AldoZTLzOcdsuCJMwaDFHBHRXIMHgzmb3KiIXIoc1ieis9uasrhSMF9Tr6RcOdbfO3M1TEnHZ3q8SE4/C7A42yj9oO9TBaoTUH2hVKxK4S2pKXJaKV3/TUGoKfbesTjjFbh5UaUXkW3+rup/o1v8kIn0cP6U+Rxw9d7RtaEZSvx3nUlllKpOv3pTDGUMBY4Vz8dH7OTW3vR6ljYNGQleRWluRx1w7LLTej3OaxCTggeQcO9otnwe8gOrFp+kc8bi+Jmx6wHH1Fi3y1/BVjJSyR0Oivc6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS5gJ/tB+u4bAfvnizvH8LH4nt5vTHNhMQ8BApAYnvY=;
 b=lfE89Ji/p+XXmRnLUQWj9wmPHfsufEl89C529NhHh2pymdr14B6y/GQwEhRfJyanBPeRrnBfzFsVgHxfGgokaudBNp5ZpMVnpbpD8atCWLEoNiK8cID/6YTHmtQ37vFIOM8GUf1xudu6NmLdykoV/Ji6PTJy6nraoUVOR+dVyXYcDcViFy3Xntwfuy4FMZYR7s8dMNsUWL9rb2+K91WGYf+jHfrrlrYMhXtQzo0xXWBWMaiG1Y8X8rK/Xb0HG8/MWdGeq/x5jjMV9hgzXaaNZP28u/zOgYEgeMenEOh0Fgq/TEEv3YZCI7sYxwQb5Uk7bHscPI8SLBt6f5+q1wbVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6333.eurprd04.prod.outlook.com (2603:10a6:803:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 03:36:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 03:36:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v10 4/5] Squash to "selftests: bpf: add MPTCP test base"
Date: Wed,  9 Mar 2022 11:36:00 +0800
Message-ID: <5c8dcc45ff846aac179897bb0c02a5bd4e59a31d.1646796538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646796538.git.geliang.tang@suse.com>
References: <cover.1646796538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0005.apcprd03.prod.outlook.com
 (2603:1096:202::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e6595e1-56b9-43a2-ddaf-08da017e053f
X-MS-TrafficTypeDiagnostic: VI1PR04MB6333:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB6333551B1F117C22BAD97D47F80A9@VI1PR04MB6333.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B650iR3BIaNm9B2xf77Ajc8WI/3U7Cw7aJaCmpnb/G17SLVSsjALMDqgpJ+0NIWoxk/JZ4HFqEwTsoBJKLmKD3Qe5NKaoLDnkhI9ofIfdHtE//TKqsHnOtK3U+PzHnNw7DGDmsHtMvz5C0PcolVKtGJrJw0stt5/fldcbAg5ZD/svQYJ+Ho8lztXOoqmrckRyU/td5rS60vmNcBFFrhrQBi2syk34nXjjiV9VIsn7LKhmNYUNb9d5YgNuhBkpBa1Ah0R0X6lPqXEA+yFXawy2I0uS2ZpvJInwr8cJGDZzU8bL/Irqwq4BV2XaO6FqfheDMzoM2mH66m54IZJaArM+gFmtFkeGZLYI/lCtZeBepKoz+LFMWaEICKWCr1LP/IZHvmI+bmvVOsAXYk9UyMe3U86ENMooGiYs6Q832biSL3sZQtGawYrkTHSXfKFGzfA8aJ4A7Av7PiYeOVrVm3kg4NhpgyttVSahMdBVlUS+yirmd5EP+S2lsPcE2H1UTjKcwEKrJt/cfxLYazT5qfEqjxHx+93n+2ANvl+FjzrUH9w92w1cc4mXyBbEPMcKPoyqZZplBFBML2U8Rn/qjNpTgklFUdnYTwPGUyo+hI5XaK0Ys4S/QCfftf5IuGn5dA/4LG8U0yE/MJwt44GK4PYfDDOaZxvD4IVlguK/KRINlr6IBDd3sv+ahyq4dLCH4Yge/vNWU6BvJlhOaWEg0wy+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(508600001)(2616005)(316002)(83380400001)(54906003)(6916009)(66556008)(6512007)(86362001)(44832011)(66946007)(66476007)(6506007)(8676002)(4326008)(36756003)(2906002)(5660300002)(6666004)(38100700002)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UPJBJtJWJ+qbGKkS9E3vuFkreJBmOibVdb6Kd4EkiVv7GG4ODGN4pTcckSHz?=
 =?us-ascii?Q?KmxhHHuHxqn2AXlCL7C+4f9hUohEdUlpUdlfrMZIbUMZuFkGy50bvAYS8F0R?=
 =?us-ascii?Q?ktopVecftoMVgSTq3F29zWtWbeVm4qoHeiJc8jK8npfsF73Z6KP7cYwVL3MW?=
 =?us-ascii?Q?roc79w1Yyck8ucR3OD1aALqtp+79W0qdPXxJaESJiJSfBIoxZ/G/snVrFyRi?=
 =?us-ascii?Q?KPACDEEgYCdEe66Elsxgo23DlxbMiUCVfrldRKZFGRIAJbW6NN/V3JadlD4R?=
 =?us-ascii?Q?39XJqtd6Q8VUAy9CVNBBkXfgSaJxnrziLNBuHjyCx4821qf9Sh0Cv8kVA3gq?=
 =?us-ascii?Q?W4tamh9nJf8V4uxzDUVKR+xLFNxtW5VTUhMeTttMUU2RXCQN/mzd8muZ28eQ?=
 =?us-ascii?Q?BewilSBDqSMbEAPd8MfKjqf5UVmn6f47NTjA5Y1SbTpS1fRAfhzUawO/+Rls?=
 =?us-ascii?Q?QP4IJFAJwLl6tY7c9HiFqGCwvA7oh/9BdfJxkxToMRdFcdheGFYw0zYY5caP?=
 =?us-ascii?Q?Zf47yE2n+jPMyAnyE5j4SrSRgepdBjRvXPADcOVoC9/hwBwqBWTrvBXMIcmo?=
 =?us-ascii?Q?Cr4m7nXyv0rI+xMljrgw+Sq/XV1fOYHHbgwkHgDD2VtgyIWsGldn+pRot5EL?=
 =?us-ascii?Q?mkj/miwttHWuT76GCSF4G6ywtM0ORAU5mT6Tzst01KQtmz1z6ke1osEVsuuJ?=
 =?us-ascii?Q?qfaLZX/Ffel9ML0F5CL4AlPwAG8qWDiHZxiV+EaN1k0A7VSAq6cWFulg1x+4?=
 =?us-ascii?Q?xMUbRgvZ9cO0MJ7op19/iXtBMOgdlQmPss/4crak/q67rDrKHnbEDyOZ6xge?=
 =?us-ascii?Q?teKPicpFbo0RwrxjnlkxGOuIHZ/spwloChA3n+R1pU8Hga3Uco6WGN/pLMCR?=
 =?us-ascii?Q?0my/PEGwjOzAkMxWrmMnllvapH/lKNoS8RmsMPOiecMdkHx6h0QRXcQEyBPe?=
 =?us-ascii?Q?1//0tizqrkFVpU0NLZDVIpIfpnhqpPASTn2ZLJOupzHxYpALFNG8l7n4U45b?=
 =?us-ascii?Q?EoOl4HDgrq+GIq+LbURH1723/nLNc+Ak45Vku3JT0UZcpx2iOa148YS6xCF9?=
 =?us-ascii?Q?6hHhiLiSOlI3bNv35wygaDwXKvxcn5/OJoxHgT7WMx7S7DrNm8lPV6zaaRzm?=
 =?us-ascii?Q?yJVYPXUZlxWSXltExn68MgFzx1sGmH287VbwoFYHrtheFRvZ88uhTmC4Irzx?=
 =?us-ascii?Q?+ZXr833y7vO9TTzJIgtLjIFvSZXqEZISg1AKxW1YLVqCAEgb/tU20dKEc8W4?=
 =?us-ascii?Q?sNc7MhFuRSLsQ5U0aWscROaGMt1+L+ExuyID+R885Pjk1eoPXiail9IyGIYH?=
 =?us-ascii?Q?U4rmFZQms4bmgfTJA68ITqxsWTi1VjONcfWhOavd58fbymBqw4/POh6PgAGy?=
 =?us-ascii?Q?0FzCOr5P9fQO3ARUsod6fRwHFtdNA1AICs7X6l4urx5s6OlcVaWkg4MKvIH2?=
 =?us-ascii?Q?ik9t3y05wpbsjSNI7ccvh0av7Ufz4nSl9cq7Cl4j0hRsBSCz4JC/U8mPD/RY?=
 =?us-ascii?Q?OkYUSa5+QFAa5PC88kn4bco/BeN4L4xtqiZagebg81J4502qg8U2nSZ157V1?=
 =?us-ascii?Q?oLT01RkQQEcbNuIQYaUU8k01i61qCBDOmaA8V5iroje8tulSXjU6LMyxuwUL?=
 =?us-ascii?Q?mNvz9oloCLmWYplrot6rNKI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6595e1-56b9-43a2-ddaf-08da017e053f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 03:36:39.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROsObF6J9pxZrNGMaROId9DeMuzDCS172UQn22w10ZLcU6r2td+icr2HvUnEly0LgFXDzJSRsnldggVoC3qA1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6333

Some cleanups.

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
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

