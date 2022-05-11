Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86D815B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwhjTBcpXQVQKOc870jf0cthSsqmz8e+9edPui63mB4=;
	b=c8eKQe9y8UgLcSKcM851T5JMy/hybDOuaW6Jvs9PDAFiPcqubcxoXrKLxZPZ9Up+nlpJDG
	XumQCErKxWCXn+pAT0LLK1gYFzya4tVpFG2Y4O8HRBwMGv8QmTOKBCmK/ELQGxbj2PxvSb
	bogNevas2A9Bz7dLqUX0QwHW0ATJOG8=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-p8yvRme1NqCKDTLjzGkgOw-1; Wed, 11 May 2022 05:40:06 +0200
X-MC-Unique: p8yvRme1NqCKDTLjzGkgOw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tz2vwN5XIbYveE1ZpjtPU3iJM+G6SSGBmLKk4kVl2mLXMDLJ2ScMXgm1LioXUT8i4w8Jdj5QTFzTPKJlp+bjkUlwVQI4Eqmb3QGRGLbyq88ztgQKIGHCI13bHtpXYPvaqxeNvsCmQrxVyYKnsaAMl5tk/4bRbW/Qe9JSYAL/KWVmKCUY9uZmmLrIuuoDzYQB4LI3iv8Kdc1gjggj4ibNHCErL/a+Ubm1AUV3dKksLyAXlcJ0oryNhAvE9EMb5ymmXJ3Hz8I6ersAnHOl/Hsvdbpp5bBwAinegxA8NS+bqB5c+vDTmt/KrrmbepqNuzqYsY41LOhpNdBIZv7+X0lVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi6HXoBZrXWa0F7ugJxrRFWQ0vqjBE3i8YlQmC0/ZVQ=;
 b=EGMgSlMYhF9qedBYbYVB/rwLpWBvw0wRQBoPThAm9hgh1jNsRuY6YYb/EXAPNPdHCk09XakaV49SMIR9CSpyx3puWRvCMai5iBCHFq+ciry0iPPYLnDYbCicTxE6SCnANcXccy4PNnJhIZT/rxMGmGMn5U+PPQrl3zaIDZMqI+gF8+3C+G+Z9xEIMLlxP3Uxx/u2PqAVg6LHVuf1xWM5BIZlHH7AFkj+ixExbSHrFkCGubUjaKrYtnOTxfN7tN8W7cE8AR4VkGPagAYlIQ/WfivrMg3oE1g11BSuSm4ZA0aecuC8AtiGH9i9fno0cq/1mNc9zD/tDz764IRQFQSJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:40:06 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:40:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 05/15] selftests/bpf: test bpf_skc_to_mptcp_sock
Date: Wed, 11 May 2022 11:39:06 +0800
Message-ID: <b2b70505dd1ab4bc0fbc60715ee45b54114a3034.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b0c41ab-66b4-4117-3e21-08da32fff06d
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB71561C33EF2770E6316EA272F8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aQPUZLvjx1nked9/z73145DrG4mdvfYfV/BQa69YQXXOdu0YCvjFUxq6MjKZeliuvTqCRw8TECVgxJgfuINwVhIY1pzTgT721FvQAp2ZOuXBCyQgn4fWT305RgfzQdBDAQfkWtO/mYC2fAsA2RDDq7Q5V9HKfvAWvu6YUtiltSit9yRDfYLG4DsN0r9B70WEPfp/setbFd0hQjSaDJ+V8TowSDxtuaXUNPeLncKt9nbOtbQPnjrpT9TLwseVYUZ/LEq8b4IBy3F6ZvxPtDxG9k+W3BUAhiL97HDDzBPi8/h1ZyLT5NsTr8XWAJd+Yx+mQ9w73WEtE/tPd9ygDzZMZtKxs+r9An3Vr8B/socW0s5BoDGRiSY4D9fblPajBfyZOEB5WfvbzOKcTpTGsNz3RUmUi+WCwr+rDmQPCDA7zCdkzNdFdzYUoPWZhO7c3Iev4wQWY6bkhBAVXr9yyC5zQST2xRhXvLrh4g5/VT6sxeF/j5sPwxwOWyJ7ViwO1U3U1rHiv0r+ejTDQLsLUmcEX3chJ1+W3ma6AE77UwpzYIzzeML9HDsLBY1JvYhsHCBsqVG/hPw+qM/Qo0PG4RcUGoa5Kd8dsAPVvReZGwMOvEYnG6dOtDK64GKQyJ0uXpxPsiTZx0n8LkML8UkyR539DA6cRpHI/vrcrA7GOmDDgV6UhGEZ2ZZWN4BM02yWQdUj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(66946007)(54906003)(316002)(508600001)(36756003)(2906002)(44832011)(83380400001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lTnkCSOwN/l+fGL0e/YzDaMQ2D0OapX4OB8/QYR77Dsos7YrsaZ80LaghEQF?=
 =?us-ascii?Q?/Tn7hnFogQz3Da2fJ6HbrS1rgWQHIZqbKeBKNFSePp6/D+faQv+Qqb9eD9FN?=
 =?us-ascii?Q?jY3XUMfjl9AYesERZaEabbbss4Vb69QON0vKK1gMV/ltu8gnxoJbW1bX660H?=
 =?us-ascii?Q?fh2sE6Dw2e/6WAMOLy9B9c+lLDLBJXtca/FQhJNh7ugKsguIswcp123nOM3F?=
 =?us-ascii?Q?Hw2efzgdBS2ccTbZv4GXZjvg1Yktz77gCPt33KU1/sfmGm4Q4d6WqKwPsWZ6?=
 =?us-ascii?Q?c7nEErvzHt7qw7BAOhZdWny0XQng4Q5SAwiJk1a6Qih6fw0wnPbhgIH5nEA4?=
 =?us-ascii?Q?NGtRBAT8flfnicYJLfcELVo+HxJdRvo0817l4hcqUk8MS4mjq+nBFoj3Xhlv?=
 =?us-ascii?Q?TgS9JBBPbicLZF/BkIFvJsaNoA3eBdQQ1WgdZTRHJ6rcDJVsPSaBbNks2BRP?=
 =?us-ascii?Q?EwihXph/xl94RM0upda8sEE0dHQPr/zLMbyIX+0CXRwBgwbnBkFQczfDZtOj?=
 =?us-ascii?Q?j4iMAqQi1AO/MAI3+epCr5pjh3M8TU/x0W1oIgCeaTYlkD4/MZjYEFv8GK1P?=
 =?us-ascii?Q?5c05TUidsoPOptnKCEw5duJAoc3GrgOJjot2oLrs1bC3YT/15/V3qV0UCfbe?=
 =?us-ascii?Q?difQPvr6hmh83nvA4iQHeIcXJsFl5SdEwU514zBO1pOfBdJ8SipWIrluLKga?=
 =?us-ascii?Q?VEWMxhK9MpOATI/irZyablZifixM3UUf7Kjj7gPKKMT516zoN7f6Ckmu5+fH?=
 =?us-ascii?Q?fNudjBRApbJKaYGur6dOadJii2mvAZWiDAcw3ra6IO4chCO7GqR9EKHKGjO0?=
 =?us-ascii?Q?LiqraXniDFtLWhloPEq+cTZG6eFc+uXjgsz6FY0tKjnLJ5HqFVKWkFMzQ4ax?=
 =?us-ascii?Q?Ne0VdHAX5ZTEZ05+Ct31FJPERWObALUOuu0v5cqdxOze7JZSMVbk24XN5mB4?=
 =?us-ascii?Q?cwND+KH63/R0BKqJqPcIhEbUZisdMi2HQPecvFIXSSjYhtijsiLfC5126bzS?=
 =?us-ascii?Q?0ii00gsosopNX2tA4iS4a46zlTWBsdrFMUNMZSUn8RP3mjg0uVRytxl5iYRF?=
 =?us-ascii?Q?KcGc++7fDovrmq+q0UABDYV46/e6824GjQtoIvZv5pAJ8ds5YLP2FOQSo5ds?=
 =?us-ascii?Q?VQDCbFuirnZId0iluwLMViDVSwKQ2gvPBMmDw9AJsMPnY8iWfqc+vbwBhlsa?=
 =?us-ascii?Q?euKXjSrb2gpbLvLG2LW1hmW4Fvg3bqOkc5ElWQeB00M9Ry+4ikNLdyB9gb3S?=
 =?us-ascii?Q?LTY557X+OWb12eSqz84U2Tuc807TxTW1rFweil4+V95CDoTwuyswl9rNSFBh?=
 =?us-ascii?Q?DXYNVqbypl4J4VlBanQyG4jS3yXjPgv2vUK4kBRlZ9t52JCCjo7ZUzR7nFtm?=
 =?us-ascii?Q?NJbiEPcs5lxs/Y9ZZrr0lvsmnXASqAqep66ZA/4ZmMZPgivQVjZ9ZwHfdqIl?=
 =?us-ascii?Q?6XIcC6TsUafQGZOJGDt4GrMr+uQxfTYCMk53kYJk0VMOTGOghwWhsiYLaEfc?=
 =?us-ascii?Q?WrL5+Vkc6pYXYmtUXExNRjX6jC4T2UC7vbio73Z44JaBPt3xweiQAMNVrmld?=
 =?us-ascii?Q?DlPCeuN81SqLsoVT14k5E7LoD3S1ouAyN6QHDG3rYCMZKDryNmAVsx49RUyw?=
 =?us-ascii?Q?m1+KDuUn5gfULSYr4mHh4Snn6VVCxNRPBe8vbgmlKk0Ozb0et1XwtXno1y1l?=
 =?us-ascii?Q?ddurQGZexFp6j0h+cnb4JWik8hfXph8LH/Pm7ZRPnyrAsbZgjQ2XXtYSNGzF?=
 =?us-ascii?Q?izH9CN79hhCGP4PxmFQ+9YP24Qlsz6w=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0c41ab-66b4-4117-3e21-08da32fff06d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:40:06.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ7F9W2MsWxlWRYbpEh6mWdY1+GsBNcTFCvtSKmNhxF/Zmdp4Y2MlfOkzPM9Ws6y5n3bhLOOBctLy1guTVYh7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

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
 .../testing/selftests/bpf/progs/mptcp_sock.c  | 24 ++++++++--
 3 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index b1ede6f0b821..a43b1afe22bd 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -225,4 +225,9 @@ static __always_inline bool tcp_cc_eq(const char *a, co=
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
index 19f5f8a183f5..dd2448d1e7fc 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -4,8 +4,10 @@
=20
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
+extern bool CONFIG_MPTCP __kconfig;
=20
 struct mptcp_storage {
 	__u32 invoked;
@@ -24,6 +26,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 {
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
+	struct mptcp_sock *msk;
 	int op =3D (int)ctx->op;
 	struct bpf_sock *sk;
=20
@@ -38,11 +41,24 @@ int _sockops(struct bpf_sock_ops *ctx)
 	if (!tcp_sk)
 		return 1;
=20
-	storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
-				     BPF_SK_STORAGE_GET_F_CREATE);
-	if (!storage)
-		return 1;
+	if (!tcp_sk->is_mptcp) {
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
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
=20
--=20
2.34.1

