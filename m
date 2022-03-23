Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273CF1391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648026608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhWWPtoNNW5ijMqp4CS5WIg4Rwerv6jageCTLWEqmxw=;
	b=g+1kGdA3Fi5pYmAjpJttaCce5hDBkzB125OnuGob9C4IlIbmyB7LZxMlKXzqP+uuAJtKzn
	w7E2KCckB6/MdOR51bY+ADWRdEju+edDtoOtWNr/Kq4Nxn2wxTeoyZ9IGZxx33gX0yhxdm
	87iIMQ2J9ZfO+AbMbyjZ8kaTIKGhOyE=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-3VZw8nBHN7WUsbPH6RYJaQ-1; Wed, 23 Mar 2022 10:10:06 +0100
X-MC-Unique: 3VZw8nBHN7WUsbPH6RYJaQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCnVGh31k2NgB6UQls5RwpfL0DD/28Y9ZmTFyhUym5+EUCOt/WcxNn3+72qDoxHmpQyoC5t/XqJrR7HJTH+2SlEEzN9ExMoied8yWbmDa48LXqdHdagHWsF7c0/6d7ibt1srIjA9NZ5PYK3Q51zqoIUEc0yrsn1oDAtDtDjOiraAG9fTqHebz/miUr4P8tDy7+KnxYiqHLFBmgbBelOrtw/7MCQrFVResWVw/Cs2zlzZ0h+OzG/5TzzJEU1KK6hn7hKtIkdtJjW6zIg38Cw853Ne1SGty0S+qZpS0b11xRnHrfBuRcXpOOgZ0+kiKutuvGkrCuDfLvnwOJv+lgTNUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWKnck8ZELk/ERQWZmBoeazpPOZzmXpwf5oGttD13Ow=;
 b=LrwfGbJp158dTxP2WmAGAjBJNe2/5IKZJe9as+jVeHncmdjI6LqR1Ifr8Im9Ha2AjsTwW8I75wO+Lm686MuR7HmiOr3W3eGahqx86Ew1aYnkWo0IwEsMEnpVUy4bKaKQyRxPUBA1Jh2Ku9fywVV87QTh1l80sDlBEaqryPYvZkvH+m7BqN0mewS9vAn9KhFfyWYRdVm4K78L49EcvL6ZWmTTZ1apfr5fSbdibtdWRD+qxuwB2V2158nHfWjJ81M3Tv9vPGUt8L/xA1G/yYuSTMDYvzd9GBgZuraxYtMTJ7N4dgQZXcCCmO4QiGbbo3ZNL8BZ2UjrK2WCcrx4e6swGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5988.eurprd04.prod.outlook.com (2603:10a6:208:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 09:10:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:10:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v11 4/7] Squash to "selftests: bpf: add MPTCP test base"
Date: Wed, 23 Mar 2022 17:09:33 +0800
Message-ID: <115c3eb0e04f8ee0cc223ae81bbb5fedcd8f2aee.1648025308.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648025307.git.geliang.tang@suse.com>
References: <cover.1648025307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ded237e8-6760-4339-aae1-08da0caceaea
X-MS-TrafficTypeDiagnostic: AM0PR04MB5988:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB59883AF56CC76F9AA42A420DF8189@AM0PR04MB5988.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xOXFSYJiRqG8NS3/GrxIpbFTrwKjQ71iXEJh5lUD+IXKo+H2O/vOwSH3vmaIASqf+1Opi5zhZb3gvlh/FpUZoGSV9NgAKaqLSASld+cKPdhBPO4h9sziDI9+MYRuo3y3Qe3nT9Jlg/fooTdffEf7yG/LfG4p/LfaBOhEF6lr67bsyYtP2SoQuQUPU5/wkQt4eXifHvbZnY/A6GDOOaAcemMDXklzipBIA4K9wcGYGQT5MPnNdRzXQ2gmMLVxAikf+wPUKUcUrhoiuSMTBmC8TtNFGqkszhIGLZwUv6j0ra6b+bE2tRhcGPlv+3CyjtsAN5wNw5SdF323V+FHpvQGGje++o18y581jqiv+us5j3c38RkM+05bW0Xh0KZLJW5hRldDgaIcVYXLF/upnSwzmaqu3Mrmv+036AT3DHDIXclHtQgrF+3D0/nOBiyHpx0MgxcAY39clidpQm2OYdV6DKB9BpGgX65OSGoAzimciR4S6f5Wpaq8rgRFrvgZpY/xWgcJeBm9ufY8phufEH/i8K/I23V999gm50bORW1ksQQKGyJaSKtaO/li7Q0VscE2npLu0LhF0/70tFYUvJzT/bwEYqSvhekxw/bM+WE4pSA4iZSNcC4LGBBdrg6Fg1XqyCG+jztRLEVIN0P3nebrbCigS7+P4P237CSFmBDY23o+luZFzs1lRGEyUhzDSxAV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(2906002)(66476007)(8676002)(66946007)(186003)(26005)(2616005)(5660300002)(44832011)(66556008)(8936002)(83380400001)(86362001)(6916009)(6486002)(316002)(54906003)(6666004)(36756003)(38100700002)(508600001)(6512007)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?htaPwew8ubjOEK5C/08CnWJKUBlaJgp41ANodJtfOjAIOm/q5WOdLXadPfhm?=
 =?us-ascii?Q?lac6iFFOZwQb4/sISRMxauJ/S1UeuVR90ZGDz5F9najgA4sQ+yRP3JvW9g8U?=
 =?us-ascii?Q?C+W/o59Zo8ai/w/bhch6UELFq9+ZqgIY9SmHoOBGg382lroAtWnevmm5zEAM?=
 =?us-ascii?Q?7j1QSepXpD0CE/uCQ8f8RrRIWy96gDKo956Fv5Mkm60z7Nv314VYUvBk8aFT?=
 =?us-ascii?Q?zkyZA7BVSE+gkh5bsln472g+qVLjA5x3bGYuM+JtvTNAHGt1T0yxR5q29tMi?=
 =?us-ascii?Q?2sdTrGiuZUKX5Np4w/Lr8Ii/Ln2gUysJ86wgKytaDRay2DdlGFIm8aJu1UWu?=
 =?us-ascii?Q?gUJ4uLn/pyrWcQnLE+ylWvCJ7oDUTk4uq9GNO7aR2OLYjpgfzD9tZYEBwjo3?=
 =?us-ascii?Q?Cto6LZccS4P+2TaUSa7GurU3KbwA7Qt44tH5LuSJiTgR3buNqjp0XYgkK9EO?=
 =?us-ascii?Q?qoKzCSRGrAYZheP4Ms7xhSDf9HSqa7oGkpNZvxra65sJ7RegffBGG1WjoZxA?=
 =?us-ascii?Q?jziQwgRVb3TTsHjOYKedqRXgL7LK0s4HjbApDDZITnSPeB2l1JMUiwqkzV21?=
 =?us-ascii?Q?HKUXRo7RmutWn2pVCOTp7TgWcmsE5L7tqkU4Nup1s0BpwbTzlUtM4tk35GHO?=
 =?us-ascii?Q?m3+PcL6xeDE0lYSxl3DdVrzxLdsXPGVC+0LATqMNxaMVejT92pWdCQIRUmR7?=
 =?us-ascii?Q?DTTu1vE1zNRI8AyjNj0uaKuLhfGZGgqXZHceytg8sd6MAMnmn8NSYZz3ryCf?=
 =?us-ascii?Q?E9MNtxohZWFZThlOYjKKyLAy16RN0iWF33Y5vVgmqDGnhO3imUsYM18wkzZt?=
 =?us-ascii?Q?zUr5ztq1M2tf2BlIfzcX05TzhIkybWJmUFVglexVOh44QiCbQAsonvHKA385?=
 =?us-ascii?Q?ONg4NxEvgvqXArhpcl0rikR8yunIIV9T11acEfRIKOY9TBNqYjyUZCy1jz8v?=
 =?us-ascii?Q?KEKfz9d7FnlighJU3UnI2TXcgJtHRVXOsXM1m6aBvdhC33HKzRfbSGvZmBNg?=
 =?us-ascii?Q?A/B9CIA3kpUcXsNOIa9aQftVJwELwI8DhLBMHOByImcY5fRFDjTOb/Wy1zbV?=
 =?us-ascii?Q?Ek++mpOe4o9jQUd00xPJ+z6lgpS+u61+OTYUA4VklyU3VLOvgpFiw0pqnQ7/?=
 =?us-ascii?Q?Jkt/lZOvLCTdvLRiEe4AW3jUD5h9w4TKrEV+BbNx5MRWbz3vpkJTFdanlKb9?=
 =?us-ascii?Q?HDAKyaNTekiPr3SvJ45MbQaTa/xH7oaKGPsaHpDbIvedmTBTaLknS9c7ggi4?=
 =?us-ascii?Q?oa5MaYMwspWWeSRmTJ0Izf8ffqMLtuy2lhuWdc+SdCmvMkjT1Sbm0fnZYua4?=
 =?us-ascii?Q?84kIde/tAkjH4z73M0UEyMakqJmTHSIpod9wafelbN5ubLAYSjqmvlByb8ze?=
 =?us-ascii?Q?ZnnA0Juu4dJGV7F1HOeoRe66+1mG0KBRoiBKY9Sc7kflZkNY5DnwGWD/cTeh?=
 =?us-ascii?Q?HeH61vLlqXPQjPUOOt9G23DrKeXF8F412ib8kXn442Zy5KInVQ7pgA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded237e8-6760-4339-aae1-08da0caceaea
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:10:04.7439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwZKVffxCurSOoCXpwrOER7N2oCa9TrfEBveqygtjUuRMMyjAVPsemlO/yrGORBY7VRgMfdh3DfwgNyaW8Nd4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5988

Some cleanups.

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 26 ++++++++++---------
 tools/testing/selftests/bpf/progs/mptcp.c     | 16 +++++++-----
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 04aef0f147dc..24d82b19efbc 100644
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
@@ -87,7 +83,7 @@ static int run_test(int cgroup_fd, int server_fd, bool is=
_mptcp)
 	return err;
 }
=20
-void test_mptcp(void)
+void test_base(void)
 {
 	int server_fd, cgroup_fd;
=20
@@ -117,3 +113,9 @@ void test_mptcp(void)
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

