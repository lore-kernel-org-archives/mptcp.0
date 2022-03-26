Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CF322E
	for <mptcp@lists.linux.dev>; Sat, 26 Mar 2022 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648311890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmNMLvB/AmBh1m1vJWz/O0LPb4kAiSnk7k4m0enRKUQ=;
	b=kYuzdSOsamXzwKzRDY9BC0xQqNS0BySdO5QG3DXzVlJfHcN8tEGs3Ux/q0oLMQktvfBaMw
	EIKQBnDSAj76Xmozfa+OwdDtQ9Cpi0hqpfQfxYYwv5ghYXDZUPb61ygsbyZ+jxhL7M6zsX
	yYPL2zkmlNtT50RWx5E/DuEvMiphuR8=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-N5sZOheHNoSjb3B5kPsISw-1; Sat, 26 Mar 2022 17:24:49 +0100
X-MC-Unique: N5sZOheHNoSjb3B5kPsISw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTI5pjCrONsBxsuteFl2y0s3Ij1l7rf+s0T4WgkMFmKdrnKHFT4vqUN3cTgoXn0Qg1VPA+6RLWpuRA0UisiXx/Xqt9+Y1QLNSYkTYzN8y/T4CYRS0r/Cqak2kOCBYzO2jPaXeQD2YX5yFk7/DA4xeTTlM1jc/cz4qSA/4g18NIhR0S5eau5vqHI4W9tTQfrHt0TCuPygxqZ+oFsqUYaZksT+rZzQxtXSICtO1U3qTDGHQAuvnje4lVUBbn41amTLAH55Db4O/xLW3Yce8kpOxgWbWm5cI+vl/athcSL6ldDjScjoLPWOkwK3C2+4owWBVwWvlvzgzioHFyKpI+CPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJ/YvUcSc5B7fLAa0vkYsyt4Uaito5sQUpIX1n9QaUI=;
 b=ZHD9a3hDtFeSSivPfWWDnwxADuLQ1SwawV3rikqgR9AHAEh/yFe2bXfSBvFwy+3SIwJhuoZyjBj1UoD/Cr9Q8wEjxlnWCOlQ7FE/0lkF+hkx7KeS2cbD3tzNSxDB9r6sm7mx7MI+Fx3HghkB2xQ51PHZ3l/kDSPrVPeOAodJjvTgUxQvgsJxJfgBoU2/68SBULoQkEwBWzxQRCgPwxVkZbawPZclDy9i2HA3sFTKmL4D4RozNNOQxDlBm9LTQ+MUICaZhvFB4qoOBm37UrGwMvmb6DSMmuq1Q4+Cthcec3vwr1/gwg3lng3aDyZnOxpwobUT4AJN99j9/i/1zRGs6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3067.eurprd04.prod.outlook.com (2603:10a6:7:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sat, 26 Mar
 2022 16:24:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Sat, 26 Mar 2022
 16:24:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 3/6] selftests: bpf: test bpf_skc_to_mptcp_sock
Date: Sun, 27 Mar 2022 00:24:30 +0800
Message-ID: <cdc807fdf015131aaf116368d97bdf3da7dc0846.1648311457.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648311457.git.geliang.tang@suse.com>
References: <cover.1648311457.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2055ed79-734d-40d5-1a4a-08da0f45254a
X-MS-TrafficTypeDiagnostic: HE1PR04MB3067:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB306747D01937F1614976F1ECF81B9@HE1PR04MB3067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y2WGISKwZjhS2jVkrj4UXG4abvL7kOibMrTd8KhTvuUIS4bm8+0ux0w8ZVn6SwLnFaTf8+2SNcyk32nI13otk0xK7AT4K1XBHtDpuGvzcHL1An/SJqhgBj5vlHcN6eItF7b6RyfnbIuaFrvvbDY8Q3/IYrRwksSrltgQO1o9F6LSD9pNkeBvV0x16rlIZJCKhBWkMugJtQrNYKgZf20doh9jnce2OdhCwFSQJCXP8PTmDauqjyTCFh7rX1HrrTqoZUWuCIvDqgFJIdYNUQQlmTIAOFuoLVPqSW7HJWtuzSMhuw6eq0S2mkZ7mtq3cV1mogBSkKvGZh8b4A/UUygRFpcNjp8QGOTuhNG6QmbzotbN0QjjN+lsjr3kNER/BNB3ZYmHGfD/1Ek37jgAklpNHW1TELljUdbsUTw6/oiZ3QSzsSKp3u746tXycao+jaiNMbm3LJ29A3HU8PTIQWRAvcd+4Q3z0KVmMLO8o/iAD4DsQjGSyxN646nuKnhkEA3pXfb+hP6EJb+robqMzAk9F8FgFeMiJVuw4zbctKstFHImVN6x7RDmP6aXFQqoIbpFymNhZYJwEdDDTx7AbfDXisnOx0UkThCzED3SKJ5Bgx3ZV0XDSeWsiP3BkVr1T8VCT8cnwz9kajsyvQuk+rTtC+cCnUVuOLlr8gqeyGiibPCWMtz7Bw/F2wfLdkLp3way
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(66476007)(186003)(107886003)(6512007)(4326008)(8676002)(38100700002)(86362001)(26005)(6506007)(66556008)(8936002)(6916009)(44832011)(36756003)(508600001)(6486002)(83380400001)(6666004)(2616005)(2906002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QYuAZYb7eclfcKPgvST7OH6vuRnKeca/1DOgUw8gWzwEd6Yr+P62nlnPcItC?=
 =?us-ascii?Q?ygVQ9Q45p4RPmDmk0AQ6xEHw14F6pTIMbcb7NbQqw7KELQXApmtnwfP+BS7H?=
 =?us-ascii?Q?wFjnKjaepYYwFRwLllBPqnKgGvuuwXUWWIZDobCNqrXwePIBer9+JiTOWyYs?=
 =?us-ascii?Q?RChOITYDOhVC9r5rUDkJXGriJsBGie03c+uqYNoBdViArINPbLTClCZOwBnY?=
 =?us-ascii?Q?Kc/EaZm2wtsYxqA1PVI+qQ/36OUljpiFP37LgURe38DPXtLhpj3ojDKOglot?=
 =?us-ascii?Q?H/HZM/DRbiVyaXZTLkspdQz3YycQ8puyUpCUsfh4lyMPZEuPwiPadKoO8DA3?=
 =?us-ascii?Q?7Hm+x3rw/RaowhJmAyvYtSD+DN5zXFhYnWE3yktjH7cPn235fpaA5CRvXiT2?=
 =?us-ascii?Q?DBcQScYyhTbdmIVBITSsP8EQqJojOldor7fDwi9D4ds1c4HH/I1hxv8TSI8K?=
 =?us-ascii?Q?Rw8U1XU2+qFSPE23z2ckIqBKlve2YowLMJBXgYPEWpkRBQrBSqRV9wN0jmRp?=
 =?us-ascii?Q?45Pe4u83kJyEEaKDKSeuB9QP9+snHw9SMH/t74xWT6vKmnFZ7FVwLQc67xR7?=
 =?us-ascii?Q?6+EdDIAykbKQSS3eps6I31fSXLa26JHK/4CFVy8UwbEEvdodeBKK8VTQSiym?=
 =?us-ascii?Q?ZAv80hkEShSFf0avbvhvXiQNguHWNdKKCXtg53UIQgPzeebmQnopRyp2XZrV?=
 =?us-ascii?Q?Kt1Uhk7ytUjeQGCZu9qDI+Yf/KTZtIAb4zTzdGSzPVQLF+9XtClV8BpSKY8v?=
 =?us-ascii?Q?m01GVdKsQMlSRTE69EDN+7nyhSjBGZ1baec05rJz5fGwaZ2uEZPQ8fPKqOQw?=
 =?us-ascii?Q?gl2mNh4/e2R43YNl4ZeWaYK/vbX9eAeR2lqBahYKlwQboNosTnTo0UfU6OG6?=
 =?us-ascii?Q?JGqRK5nJgcvSYUOkH6Wd9UBrMXA//rsBuESz43hK7Uui2Ujltl9zZ7bkGIKQ?=
 =?us-ascii?Q?wxgsBMLAx0wA9kS2VwRAUXSIdu/vo7MNZizm/26YDs3PQbkBYpPYSvLhZzCW?=
 =?us-ascii?Q?61/kczmsHfKGTwyaBFxcX/XhRq3awGnUJCg73FLKp1DXiio7uuqaTpntbzgk?=
 =?us-ascii?Q?7+CKGJ9KTSTz+V57zTOeHNxEzTcxpcWbflzfrwvcMJpCyl8E1VUDyFm1HkDg?=
 =?us-ascii?Q?HoE9F8K5j+kSvx2lhDewlRclX7ZgoNenyYGiQ5tH64KEC7IBbLpIRU1+HoC1?=
 =?us-ascii?Q?YcDSEG1S/x5P8hTykdJaiq0KIl9QEtWnK2WsfjKWT+SKU+pcBY+sPYmXB5tc?=
 =?us-ascii?Q?eKIqPM52qCUnQ9pR6kZakp+fByPGf0ozTeoVFwSj01ypyI4HsbSItkuc9U2i?=
 =?us-ascii?Q?9hswHdu3HBy6TmyIsk9MBsaBbRFlWaUGMd+ia8T6QVYaaTsGGRg1Gx1Y9Qhs?=
 =?us-ascii?Q?uPBSpNckowSl1EuSabX+r3oyvW2EHaTvjpB5TnKlYgILjkjJ3VzYCV0/Z7vk?=
 =?us-ascii?Q?tf0e9+KJUmUbRg/iz++yK16E+dDp7ZL5wBw/7p+DfGaLzLSSWOcHfA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2055ed79-734d-40d5-1a4a-08da0f45254a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 16:24:48.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOTtU45GpmLzF0OCs9AOeCUGU3p0bIOOigW6SQeTxholH89Ly3UWPiVSg7dDzTXvRXZecrIkLxm9RX2w9c3w0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3067

This patch extends the MPTCP test base, to test the new helper
bpf_skc_to_mptcp_sock().

Define struct mptcp_sock in bpf_tcp_helpers.h, use bpf_skc_to_mptcp_sock
to get the msk socket in progs/mptcp_sock.c and store the infos in
socket_storage_map.

Get the infos from socket_storage_map in prog_tests/mptcp.c. Add a new
function verify_msk() to verify the infos of MPTCP socket, and rename
verify_sk() to verify_tsk() to verify TCP socket only.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 36 +++++++++++++++----
 .../testing/selftests/bpf/progs/mptcp_sock.c  | 22 +++++++++---
 3 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index b1ede6f0b821..d71616873a3c 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -83,6 +83,11 @@ struct tcp_sock {
 	__u64	tcp_mstamp;	/* most recent packet received/sent */
 } __attribute__((preserve_access_index));
=20
+struct mptcp_sock {
+	struct inet_connection_sock	sk;
+
+} __attribute__((preserve_access_index));
+
 static __always_inline struct inet_connection_sock *inet_csk(const struct =
sock *sk)
 {
 	return (struct inet_connection_sock *)sk;
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index cd548bb2828f..4b40bbdaf91f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -10,14 +10,12 @@ struct mptcp_storage {
 	__u32 is_mptcp;
 };
=20
-static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
+static int verify_tsk(int map_fd, int client_fd)
 {
+	char *msg =3D "plain TCP socket";
 	int err =3D 0, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
-	if (is_mptcp =3D=3D 1)
-		return 0;
-
 	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
 		perror("Failed to read socket storage");
 		return -1;
@@ -38,6 +36,32 @@ static int verify_sk(int map_fd, int client_fd, const ch=
ar *msg, __u32 is_mptcp)
 	return err;
 }
=20
+static int verify_msk(int map_fd, int client_fd)
+{
+	char *msg =3D "MPTCP subflow socket";
+	int err =3D 0, cfd =3D client_fd;
+	struct mptcp_storage val;
+
+	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
+		perror("Failed to read socket storage");
+		return -1;
+	}
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
@@ -88,8 +112,8 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
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
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index 0d65fb889d03..a58cd24da777 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -3,6 +3,7 @@
=20
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
 __u32 _version SEC("version") =3D 1;
@@ -24,6 +25,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 {
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
+	struct mptcp_sock *msk;
 	int op =3D (int)ctx->op;
 	struct bpf_sock *sk;
=20
@@ -38,11 +40,21 @@ int _sockops(struct bpf_sock_ops *ctx)
 	if (!tcp_sk)
 		return 1;
=20
-	storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
-				     BPF_SK_STORAGE_GET_F_CREATE);
-	if (!storage)
-		return 1;
-
+	if (!tcp_sk->is_mptcp) {
+		storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
+					     BPF_SK_STORAGE_GET_F_CREATE);
+		if (!storage)
+			return 1;
+	} else {
+		msk =3D bpf_skc_to_mptcp_sock(sk);
+		if (!msk)
+			return 1;
+
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

