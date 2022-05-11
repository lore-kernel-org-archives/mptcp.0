Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371C15B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eoiVZEh+M5aKGceU9M1TVHD8wAdcjp3OPj/yUu0ouVQ=;
	b=cBJTXl+ZW8wJ1Hn2ss8fTlsPvB9yjoo96piLYRVO4Gf2TfsaNDNSXi6ztKRmJgDNeExvAH
	ZbgbpJNONa19ES1vvTuFXx8RCjVPfzxh2TU+hS/vwR5RBDiYW4Emz2KmQyKwVXdeOj28M3
	NAIo2Dc/IPrxCQZ7aScypvV9gvIKYCE=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-l6Xant_2NmWSPGNK4QWY0A-1; Wed, 11 May 2022 09:56:52 +0200
X-MC-Unique: l6Xant_2NmWSPGNK4QWY0A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qfz94Nx8tw81TdPlwbiQdm8WKqMURUtUD4ZEzFmr81NVYHN/BXWsU7tsFUkdnf1KMql3cDVxoByRXhGyPF1+O8EZHuvb7GOUC5l35/W6rPdbppTPDwk5cIhgrZGiu7nl0Dl24LM/IdYRuycMG3Sn5zCfuhmKekUwtb5ZgpGMTU5XOUYJTpSQxFl+/jYvT7xvV7gDwMG3D/KbmJn59Sau2LM2rm8+PusfrnVBDliXmHs/O+cCZXMUUURO9cgh4Tu+wtZI6rl/zcBvYOIs75lwxVXbebTixIxmol32dRBgpB8dnxiQS7zu6KhUwhy2AGCDdzFWwp06gc3tHcYFWl1uSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4SzUhMAcpIqyzFHPAC5lL4EI1/Noit4FFmG0HiLlqo=;
 b=NG28Qu9AUb3pQEXwlBLZoM1WSj/WMaAT6WnI7VyIjxphkRm3HnhS0PsHfypeKhkCiz5PtS1rCTw62bAAPPYaxi5L2GGITzCdeZ2Q1hoHQE6QgLeL6ASrovty1Ot9VtULgy3o00JHSzVhyU015ub29bjRjCIPLak9TI4y4yo43aYllb6sgCV0HzvJl6Xvk0mzSK8TiF5MbVhKd7yWm0b2pecoyTUViSwuT59d0J0yXMBGWhwSwfggTSKFJEw0vmHyoUa5k9S0MpUINW+7R8ThpLGTzKFN+kpgzz4dZUo3TGZm53OxMwC64dOnWnoGps0m2XqlNS/z+CqqOPC87OT+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4461.eurprd04.prod.outlook.com (2603:10a6:803:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 07:56:50 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:56:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 04/14] selftests/bpf: test bpf_skc_to_mptcp_sock
Date: Wed, 11 May 2022 15:56:10 +0800
Message-ID: <729546874e1175dac710097855a555e71937f0fd.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb95b635-6c0a-457b-0864-08da3323ce1d
X-MS-TrafficTypeDiagnostic: VI1PR04MB4461:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB44611B9D98082A20D7B613CEF8C89@VI1PR04MB4461.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RbvPpjaMe/iyMmA3G1hEKFaldHRM0TNIYLpkGFOWWguTH9MwoYwbl2B2tG96boik//B4NbZnuCGxIZ0Dg8pUZ+8kmhaMRhB8Lo7gk5rIaYLLlJaOg+T9G9FITgWlkcAXwuXPWhZkblYuGpjby7JrrPhS/wy8FvfIJTBEkT2C107Y8XFgs5FoWzHjlUu2r0GGQnfP5dtx2ZkyVcvo8OhhcA4GiX73Vco8nhFbnTJpS72qPlwuQK1ErqksU1PmWigRPsQg1L9/IQCLDNehy0Gbrq+i0cSCfE3wqPsOrx29dOg/Rvy0+vT2emU/9g6G8n22dgZWIM3je0QMWCzJX0ZONxMFWnEXAsR88/4Tb6VpPHcUR+E7gcLvkTiJQi+DoCs0Lmv3FknOIHT+R80IYcknBs4lku01mXoSu+Jrlt7xu79Mo7n/ORpc3E4BfkucY0kDkCWd+l8fA4LklBtOApuEtS/FKDaKPiRhAcYh3UQC6M3KBJ8vMFzY+i2d6SuRhPcLoMOtpBZ4HpnBrLBzNgJXHwPBJBhDEYhzGlokrTx81OYeYIDFDOFbmx2/e3mgdm7QV5Q0a0FnZHmXy06MMhkYQ1w4u0N3JXItSMaa3bl9OyZDpVsbDPlh07+ML8J5AfDSyyGSVfiP0lKqyv8zq9kL9GeekDC97VUGBIsmyIQaRlN882QenpdjxPy08BteJOYx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(508600001)(5660300002)(8936002)(316002)(66476007)(54906003)(66556008)(36756003)(186003)(66946007)(6916009)(6512007)(86362001)(2616005)(4326008)(8676002)(26005)(6666004)(83380400001)(6486002)(6506007)(44832011)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x2gSLJ8XjohH04Bg1dHUvsp9IvlNh0t0j4OqsYebocCdBhABkrpGQ8Y+dNj8?=
 =?us-ascii?Q?XqGXh3XvxtbGlpXEYMN8LttSw1IU+vUk2WH0o5nyLJMZDnUa10E3H3yfmJLY?=
 =?us-ascii?Q?zaN9JN5bQUfVm43YjOgZdb/MgD2wQcDlue8bLYiqhSxaXGZyy9W36/P+/mQw?=
 =?us-ascii?Q?Uv2vLkQsTkbdy2MuGuj5FejAY3RWjZLrTHDtIwBxVsn4M5Kr7rtIJk0Oo28x?=
 =?us-ascii?Q?1w5ZrYmqNGqwn8YXimGS+MJ2js6YfBoYUrCRf9HtQlI29t9XBJ8rPGRP74re?=
 =?us-ascii?Q?xcoDNEr2e8CgMscmBIiHFPvalZM/nJEh0ANNL/ILMd+2PH8L0MUbtaJPalxU?=
 =?us-ascii?Q?kwzXLSWJoyRFw66QerupmO/SX8NGcJSVXQIaKPWR3JjNxrdmvCzmhmuw3F3P?=
 =?us-ascii?Q?ox5ZJjXABVeGTu8uDx+V8WyvnpehzwQGgBACY9VbNUR1t8Zx9aqe5BGJDdbR?=
 =?us-ascii?Q?Eov+gAVTtgyplAz10DsUV5PGdmtCDNrxoeasRIQyQmFdeYhFTRaJBPjL193L?=
 =?us-ascii?Q?WP8QqntO7kUfs3e6xKAHR6XfkxDYJrO6KKmFr5g2ArlkfnKnkUw6PFNpNvXq?=
 =?us-ascii?Q?EzLn1Xs4e3Guu5mU7joE0b2D28sc2RYSmsFo1F9dLtxNNnpGBYm/LXf6EoXy?=
 =?us-ascii?Q?i5INm2YBw2Az8lig6N1ZCoGEVirHUj0YftGoVwuc/KRYY+TV/t5SMPsfaf+C?=
 =?us-ascii?Q?rP35AzzOJngdsnecEHCu5Rh5awjSsSswysumiwzdTFcsbN0Av/HPx1Ms+xvS?=
 =?us-ascii?Q?/Alz4mQyEFkTXNaDl69MhZ/yz9R8mL+JInlCgkKmCN7KhaPutDQkBnAaLUhY?=
 =?us-ascii?Q?3YOjAgSHFJjHcJe9LmeGDhkH3KYdY9fmePk5n7xDi2IkwYsbmEcFil69u5Xy?=
 =?us-ascii?Q?8z+xdvnZ0prKpn+o5UQ2ESOo8djq8XQ/QTgn5rQTGAMb9vpbbTFMm4Qufi3t?=
 =?us-ascii?Q?zI6SBZvl1LAIWJcix8t/g/tLB0NoxKE+dKvgzTx0pE/y41gHYQL+DTf/hnBw?=
 =?us-ascii?Q?W2XgRWcgTOz1AEU5NdDtW8tRH/hiodl9hwD1mF3o+NEaiLw9zo5HYoriYW1R?=
 =?us-ascii?Q?nyjN0osrF0UmCOn+1NXSoKTlO25qLC+s+6B0WG/ym+tez3SBZRVjH8bdwW6X?=
 =?us-ascii?Q?PJgp2LNSwJNPf/gBJkkYfIdA/rW9NOB5AEr+KPRURhoGda86J4FOYSNq7jNZ?=
 =?us-ascii?Q?uVUK2o00uw+QCJTbSHodmOls67Oo/0WJo56nt6RlPvk3tg6eZSSG5Ve7yy+r?=
 =?us-ascii?Q?Q6AYUu9icPSXddlMbARb6BDpUYfmuUsb8Qu65zydOOn/QgDlfCzMMwU1Tya1?=
 =?us-ascii?Q?SMzS5c62PR0mETy14WlP3ADOjJGZUEri0Ki4PMwPWFUGvD9Z+6Dzz8xYfXT4?=
 =?us-ascii?Q?JOevXWJ174X5OE3Vkw9H+29RNa8xHiCFprOFUAAFgdv8RRAWxWau6cqq6sOm?=
 =?us-ascii?Q?3PFVXxeaHEIUxH6xIx6ijpnhcLx5zo0nSTdELdsJct+QgBF26X1vsC/3vGo+?=
 =?us-ascii?Q?PZjiMy7EmeSLdfH/5vV5CD3gIuN2bGi3wTcPW51irdJSYSv+tO1TLIkcUf0J?=
 =?us-ascii?Q?yyaR3VfawLHvZ6AnClidPGu9e61nCNdJ+a6dJQFGZ8faPKuKyT6NjTKcIhL/?=
 =?us-ascii?Q?2AWBCZRDgU1qdeeDg1C955bKwCbEn2ydOVQ9dMyCRI4FLUWhXVuBFkCnYpu4?=
 =?us-ascii?Q?2bd9VlBQY7Prsx9slgm11KFqttabFw2MnrZ7SCbIZh0JfTBWenccR5bTYEmE?=
 =?us-ascii?Q?DXcEfEPPyeTV0J7BHR1gNLxmpIFfVrg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb95b635-6c0a-457b-0864-08da3323ce1d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:56:50.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZLj2i1c2YCJV6n06v5HTp8julFetAfbAfj/81F8lPGJ5bDO71U6r0Ku0yYgSndAZBYBC8mWvuVo6rKXG7re6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4461

This patch extends the MPTCP test base, to test the new helper
bpf_skc_to_mptcp_sock().

Define struct mptcp_sock in bpf_tcp_helpers.h, use bpf_skc_to_mptcp_sock
to get the msk socket in progs/mptcp_sock.c and store the infos in
socket_storage_map.

Get the infos from socket_storage_map in prog_tests/mptcp.c. Add a new
function verify_msk() to verify the infos of MPTCP socket, and rename
verify_sk() to verify_tsk() to verify TCP socket only.

v2: Add CONFIG_MPTCP check for clearer error messages
v4:
 - use ASSERT_* instead of CHECK_FAIL (Andrii)
 - drop bpf_mptcp_helpers.h (Andrii)

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 45 ++++++++++++++-----
 .../testing/selftests/bpf/progs/mptcp_sock.c  | 23 ++++++++--
 3 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 22e0c8849a17..90fecafc493d 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -226,4 +226,9 @@ static __always_inline bool tcp_cc_eq(const char *a, co=
nst char *b)
 extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
=20
+struct mptcp_sock {
+	struct inet_connection_sock	sk;
+
+} __attribute__((preserve_access_index));
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index cb0389ca8690..02e7fd8918e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,14 +11,12 @@ struct mptcp_storage {
 	__u32 is_mptcp;
 };
=20
-static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
+static int verify_tsk(int map_fd, int client_fd)
 {
+	char *msg =3D "plain TCP socket";
 	int err, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
-	if (is_mptcp =3D=3D 1)
-		return 0;
-
 	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
 	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
 		return err;
@@ -38,6 +36,31 @@ static int verify_sk(int map_fd, int client_fd, const ch=
ar *msg, __u32 is_mptcp)
 	return err;
 }
=20
+static int verify_msk(int map_fd, int client_fd)
+{
+	char *msg =3D "MPTCP subflow socket";
+	int err, cfd =3D client_fd;
+	struct mptcp_storage val;
+
+	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		return err;
+
+	if (val.invoked !=3D 1) {
+		log_err("%s: unexpected invoked count %d !=3D 1",
+			msg, val.invoked);
+		err++;
+	}
+
+	if (val.is_mptcp !=3D 1) {
+		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D 1",
+			msg, val.is_mptcp);
+		err++;
+	}
+
+	return err;
+}
+
 static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 {
 	int client_fd, prog_fd, map_fd, err;
@@ -88,8 +111,8 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
s_mptcp)
 		goto out;
 	}
=20
-	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
-			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
+	err +=3D is_mptcp ? verify_msk(map_fd, client_fd) :
+			  verify_tsk(map_fd, client_fd);
=20
 	close(client_fd);
=20
@@ -103,25 +126,25 @@ void test_base(void)
 	int server_fd, cgroup_fd;
=20
 	cgroup_fd =3D test__join_cgroup("/mptcp");
-	if (CHECK_FAIL(cgroup_fd < 0))
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
=20
 	/* without MPTCP */
 	server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
-	if (CHECK_FAIL(server_fd < 0))
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
 		goto with_mptcp;
=20
-	CHECK_FAIL(run_test(cgroup_fd, server_fd, false));
+	ASSERT_OK(run_test(cgroup_fd, server_fd, false), "run_test tcp");
=20
 	close(server_fd);
=20
 with_mptcp:
 	/* with MPTCP */
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
-	if (CHECK_FAIL(server_fd < 0))
+	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
 		goto close_cgroup_fd;
=20
-	CHECK_FAIL(run_test(cgroup_fd, server_fd, true));
+	ASSERT_OK(run_test(cgroup_fd, server_fd, true), "run_test mptcp");
=20
 	close(server_fd);
=20
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index bc09dba0b078..3feb7ff578e2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -7,6 +7,7 @@
 #include "bpf_tcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
+extern bool CONFIG_MPTCP __kconfig;
=20
 struct mptcp_storage {
 	__u32 invoked;
@@ -24,6 +25,7 @@ SEC("sockops")
 int _sockops(struct bpf_sock_ops *ctx)
 {
 	struct mptcp_storage *storage;
+	struct mptcp_sock *msk;
 	int op =3D (int)ctx->op;
 	struct tcp_sock *tsk;
 	struct bpf_sock *sk;
@@ -41,11 +43,24 @@ int _sockops(struct bpf_sock_ops *ctx)
 		return 1;
=20
 	is_mptcp =3D bpf_core_field_exists(tsk->is_mptcp) ? tsk->is_mptcp : 0;
-	storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
-				     BPF_SK_STORAGE_GET_F_CREATE);
-	if (!storage)
-		return 1;
+	if (!is_mptcp) {
+		storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+	} else {
+		if (!CONFIG_MPTCP)
+			return 1;
+
+		msk =3D bpf_skc_to_mptcp_sock(sk);
+		if (!msk)
+			return 1;
=20
+		storage =3D bpf_sk_storage_get(&socket_storage_map, msk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+	}
 	storage->invoked++;
 	storage->is_mptcp =3D is_mptcp;
=20
--=20
2.34.1

