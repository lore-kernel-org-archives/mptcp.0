Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660623AD
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 10:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648203081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzyjNLcDObpv5jLoWkJWRKSEVHToUjOmCF4XDxaTuQQ=;
	b=k1WXLob87hPgkJbU0DXwH+FGpyxahp+aCblpMtnysFIiazurAsYP0xxMhHE5zOnx/qjCzk
	LBplrbnxHKnanPSM9k2QPmjMkoUhXFwOKLcEvs1TgvTmSFKLw0T/HCGjT8XwoauQg5AVMb
	dh1yNTlEsVzdR6xoYDY3dnrWJd30xmE=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-SsGfQNMRO1SudIEq5mEVDg-1; Fri, 25 Mar 2022 11:11:20 +0100
X-MC-Unique: SsGfQNMRO1SudIEq5mEVDg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqr6j/EJBPJsfxiiEYxk5GCzVrHMKAxTEQ7a833HRUSaezZEYp8XaH5xh6/PrZ1UBdJiCINHbdI3Q87mgHlu3L+VmzMe9uaBF4W5i1IYXE8t7Vyt3+qaZ/qOhvZcxwES1UtgaBZFSkywkxdJPSvu7nNyQ0zYSutp+5n/fYXyN4hoS1LhImxpedgKyCnsQc9fi9Si2IeEmUmj2H146IwcTYIT8VFpjQg6ng/YUcnS83uuM2ABcMPXAxNXouRYJL9HcQBokVCafASJxujQAB8/xrE8LD+bIRRuT8JfFyuCXeC0yQCRXm95T6/d4H/BRsQ8h4Q0cvpTw+AhKe2MkVma/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+R3mXoj7/H/g9cgoZKWvYyVDWFS1soENavrgXPvK7M=;
 b=EBCWRQYgcfZ2uzx6X6Wk9sEkUWgNAi2+M/K2vfeH6T8cerrNZ6HI8pVAA8tmt2QG8CudQpJAftTERhUiBNt15UNDKEMWlbTOtphElwvZPKViapwsf2f6UUKag035vCRmdn/TR7YJyHrGvpptq6vAucALhy2fNvmWRLtzahAOPVM8MXUcHl3J/sqQ63QRxL6rluhI4LKeymGt3bJlUBapB6Ur1zJZ4qu3O4M9rNNEq9GSLJclNe3T/ZoXmUzCe8gidbj/tP4OBsXapONVGihZm60g8Ix5DlcekG8oFWrLzveqrs9z8/o60xcs74eKk6jHIMevc/ngdDA+St3m6FS9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 10:11:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 10:11:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 2/5] Squash to "selftests: bpf: add MPTCP test base"
Date: Fri, 25 Mar 2022 18:10:53 +0800
Message-ID: <ad72e534750a7839349cb6a83ccb33eb722aac26.1648202310.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648202310.git.geliang.tang@suse.com>
References: <cover.1648202310.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0e60bbb-6306-4f7b-604e-08da0e47ce38
X-MS-TrafficTypeDiagnostic: DU2PR04MB8726:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB8726C230E5EFE56F954A67B3F81A9@DU2PR04MB8726.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	taEoctJNHWLI8eTRVBUat625468Ud5SxAEXZ4WlofcGhCLitso5A4041WciPhphN8Uq3zoOk/4f5D1fmCaghH2ftm/DFO0dgC/wtpwLHPieqj4UkgTblQuXwJ7ZpRcuH+0xZ69J5w59RB6uDFt+Atk2WvyX5ZjAv5nzzgTnCAiozGUGiVg4/q7E9Di9nnjSzuR7fmVMScqO4o2SWM7WR43NoBBortDbYnN1X4EJ8LOVI7agC4PdO+iOQ3x5omRTCt/K5ZH6ddn/bVBAmd/nzL2FgSuoU80Y69tCM9lKg2xIRWqr6ZRjsLFB3xVqKTjPByL0qpnoiQSBQ26D2rQBI9VN8GtEOTrR4HjIUBtHwiQiyhVf4XOZ4ET2XQdy4gbYovwM1HUjDEAINuizjyg3dVJJCs7YTVE//Zp3RbVtQy2kIUdNLS85JFcHh17mSeVFWgBLMICOSDuE3jhr/45qg1YjcNrXi6BQ+HVUzznmbW2kchhKLjWLaL5xDZXcjSphUEFG9A2A8ixNMPKr2QNA7l1X96UuQ/gWT/Lc3zovVivBR/nwXGov4iHS+g/C3EYSAJf+bseRPQGmNDKoKVOA0sNeTCXnWQEE/KmkCXOuVvRHvgnxiGycObcnChsq57nk8V7zkuk7xleWBq7ybAO9yH/Htc+mPmuuyOkiojHNy7E7039Q3PckRCToUwIH+uRGljbleWpYoU18ylHo1jnyYwg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(6666004)(8936002)(316002)(6916009)(36756003)(66556008)(8676002)(83380400001)(186003)(2906002)(2616005)(44832011)(66476007)(38100700002)(66946007)(508600001)(4326008)(26005)(5660300002)(107886003)(86362001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AczoPNMTS1bxb01bNq1kjrMZdp4CP6Ah8XVGuGJFpRHlMZwgIX3YsovMhowv?=
 =?us-ascii?Q?uDG8k/SsBgFn44HZbY5Rb5XFzyQZWNwr7wD+PhCzpE6l7L00JYFareeC4jJN?=
 =?us-ascii?Q?V0BncLBfWmuSkrsO6bPErNRHfVZDWeLH0GfIEJ45XEAQ3xF6i+6n+NVPmB/S?=
 =?us-ascii?Q?2OncXkhMkMoZi51r8EIHx5Pa0ILii6aps6XNXPEWSVoGPzIeozZsyWeRqPZk?=
 =?us-ascii?Q?dAFGKI9hpoEhezqzFAC101d3qq1eQpROoZ//VTtQbyVw47mMYkqjSmzoueGm?=
 =?us-ascii?Q?wNnYUxMVAIQnJPHCTZwgUa3r9Stif9IZlwbmfYqwHyzFetHwmGT3WgsnMJ5y?=
 =?us-ascii?Q?udOhAECiImNLFspS9+encv1Lye61LjKurVliOdaFfHh2u1lAq+XhRQ7PJQOU?=
 =?us-ascii?Q?6O0D1MHFkcxLxnf25JVd0IJddxnrc2vnhQxjB01uDfz6NLFytRxE8OmisIWK?=
 =?us-ascii?Q?wpeDNrO2ctatsgo3gZxTTKekAny+vRaXRaQBLkuQwVQ+IDidE/8084XbHvNp?=
 =?us-ascii?Q?btdn96izAav4CGZXMo4R9XryW51CZoraVIm8zLnUofi/+vSj6QudUyEEiVZk?=
 =?us-ascii?Q?AodDfnmVEtSQJFHETKRGMOE3AIHFXoLDMd/qCnw/XnkpHUTwrCyRcUTBwVQM?=
 =?us-ascii?Q?wP8mNc5YEQ7rGToFwqQRqTQ8qxI0x5uhC0aHRes1iC09SzT+XyMTi9P7NiTI?=
 =?us-ascii?Q?YHLtPV/UXPbdamfl5mXyUZlYtu9mBC61vIRc1ovNatyLWIqTpIgHv8gecAXb?=
 =?us-ascii?Q?uo+vF6a1aTpTnJlwnqOIV7KM0QB1WzYnk2Cu5c1xtdC4lc5c0yy+Tz3+ZDZL?=
 =?us-ascii?Q?LP7MbB2mCMr7tx74LteToB6GCgkKOO+96cXrILzg2JIoH5MSj4wCgkxsSHVU?=
 =?us-ascii?Q?ZIBhKMTvxkzgOB0KyStWDlLNHBqUKxG8p0Y4VbMirJWsQJWDT1K3m2In5brO?=
 =?us-ascii?Q?wry7ucRNkvEQw8RM179V6d2pYHKkgA0i2h3DqELsMPt7CPQU+bj7gJ8O82EB?=
 =?us-ascii?Q?nQNUHXZXSLeaEonVFPjXkOxb4ASDgCFCK1m4wVSfofuXaaULgk6lr00BOrYH?=
 =?us-ascii?Q?aGxW4AyoEWb2a5vNDbe7tSi82M85bxO/Zfegv7bVnrgd1hYald4Qx1H0Pgr8?=
 =?us-ascii?Q?a93z9nvb+UGpgZbZ2Ais+Pzjbnp/G3eKePeuYKxMhi34Z4MX29H2mrUJQaFO?=
 =?us-ascii?Q?Cy33yMVLrcOJWCyHJKWCMSxwQQL2x8kNGztChYglzsZrP7/l7QA+fVtLnSgH?=
 =?us-ascii?Q?d4kW50M5yM1Xw5v1c0u8krufymzSF54uSNfWMS+QJIKNV/veFRxY2JS5gII8?=
 =?us-ascii?Q?dnMtkZ35jyVOAl9bmHNhmmqPSoelo+bKeTuv++Z/cY/cdMiFBolbhrDvdV9y?=
 =?us-ascii?Q?S4HGUKEOjBYKz5BgMlSXDRV5WrSS1SEZ/zt34spimimzmr/Xn0UJYG3c4P7G?=
 =?us-ascii?Q?2dccsdJwFvmWye+HEOKbKcMELjs3N6XkEAzn05PGa3BDuV8qW82XS7XbBSCY?=
 =?us-ascii?Q?jRJxotkyCAYgjJNqVNKwUxhvFg+gaHy30WvCiOa8+Z9G2gVqy8v8qkwInXHN?=
 =?us-ascii?Q?FoNxtjjB+yQ4hygyOJK+oPFlH0i6NTxZ9iJIcjVuqkxaM3I74awM1RFG2MPJ?=
 =?us-ascii?Q?+3TfGyCy9DSkYPzTwqiF8cq+QGFR+yOA4uD8u1gaTO62uGtXJv0Kabjz6Jdu?=
 =?us-ascii?Q?ZeswNu1hKC09OsNUNftFbMVfegOqFm23pQHwgrWErgwkggOofZu8/LUwJvUQ?=
 =?us-ascii?Q?DxCwZpM5oxV/d17DFeTmYth34oG6LGw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e60bbb-6306-4f7b-604e-08da0e47ce38
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:11:19.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKttMMbIXeBSf1Vj2LmJIr1X1UoaCvPip/jYP2ZLv4kMbLfPi9iI+Ote/bd1xd9Mbdi9QWU6nnMmLcOn1mjZUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8726

fix libbpf 0.8 build break:

prog_tests/mptcp.c:176:2: error: 'bpf_prog_load_xattr' is deprecated: libbp=
f v0.8+: use bpf_object__open() and bpf_object__load() instead [-Werror=3Dd=
eprecated-declarations]

Some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 77 +++++++++++--------
 tools/testing/selftests/bpf/progs/mptcp.c     | 16 ++--
 2 files changed, 56 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 04aef0f147dc..bfd521e17711 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
@@ -13,12 +15,6 @@ static int verify_sk(int map_fd, int client_fd, const ch=
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
@@ -28,14 +24,14 @@ static int verify_sk(int map_fd, int client_fd, const c=
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
@@ -45,49 +41,64 @@ static int verify_sk(int map_fd, int client_fd, const c=
har *msg, __u32 is_mptcp)
 static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 {
 	int client_fd, prog_fd, map_fd, err;
+	struct bpf_program *prog;
 	struct bpf_object *obj;
 	struct bpf_map *map;
=20
-	struct bpf_prog_load_attr attr =3D {
-		.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-		.file =3D "./mptcp.o",
-		.expected_attach_type =3D BPF_CGROUP_SOCK_OPS,
-	};
+	obj =3D bpf_object__open("./mptcp.o");
+	if (libbpf_get_error(obj))
+		return -EIO;
=20
-	err =3D bpf_prog_load_xattr(&attr, &obj, &prog_fd);
-	if (err) {
-		log_err("Failed to load BPF object");
-		return -1;
+	err =3D bpf_object__load(obj);
+	if (CHECK_FAIL(err))
+		goto out;
+
+	prog =3D bpf_object__find_program_by_name(obj, "_sockops");
+	if (CHECK_FAIL(!prog)) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	prog_fd =3D bpf_program__fd(prog);
+	if (CHECK_FAIL(prog_fd < 0)) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	map =3D bpf_object__find_map_by_name(obj, "socket_storage_map");
+	if (CHECK_FAIL(!map)) {
+		err =3D -EIO;
+		goto out;
 	}
=20
-	map =3D bpf_object__next_map(obj, NULL);
 	map_fd =3D bpf_map__fd(map);
+	if (CHECK_FAIL(map_fd < 0)) {
+		err =3D -EIO;
+		goto out;
+	}
=20
 	err =3D bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
-	if (err) {
-		log_err("Failed to attach BPF program");
-		goto close_bpf_object;
-	}
+	if (CHECK_FAIL(err))
+		goto out;
=20
 	client_fd =3D is_mptcp ? connect_to_mptcp_fd(server_fd, 0) :
 			       connect_to_fd(server_fd, 0);
 	if (client_fd < 0) {
-		err =3D -1;
-		goto close_client_fd;
+		err =3D -EIO;
+		goto out;
 	}
=20
 	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
 			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
=20
-close_client_fd:
 	close(client_fd);
=20
-close_bpf_object:
+out:
 	bpf_object__close(obj);
 	return err;
 }
=20
-void test_mptcp(void)
+void test_base(void)
 {
 	int server_fd, cgroup_fd;
=20
@@ -117,3 +128,9 @@ void test_mptcp(void)
 close_cgroup_fd:
 	close(cgroup_fd);
 }
+
+void test_mptcp(void)
+{
+	if (test__start_subtest("base"))
+		test_base();
+}
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index be5ee8dac2b3..0d65fb889d03 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
=20
@@ -25,22 +27,22 @@ int _sockops(struct bpf_sock_ops *ctx)
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

