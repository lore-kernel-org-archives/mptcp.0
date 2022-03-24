Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E81FC4
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 13:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648128538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iI8Hpsh5XV4NBkVhBeuNdGNvSfNghF/2YNDO0mDFlcs=;
	b=fopgujWECXBQM9ENs5kIOxwEYc4a06lyezzjpAoHsiwNIqtuh3pgVn4Fsp9ortQplhZzoW
	JEVqy0xdYXdq5XjiV3ay9XX0pZ89PRTD8YvdXTUloXH7TpPcsKq9ZbL/u1XTMKZn2m2iJL
	j/HRSV8bPRjIGIZhU0jJ2q7TQ7Z3SIo=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-dGhdkktLNKmdg1JiFCQk0g-1; Thu, 24 Mar 2022 14:28:57 +0100
X-MC-Unique: dGhdkktLNKmdg1JiFCQk0g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvosWITc/BLxJ2AGWdx+moBqCkHPn7P4fB3vFH59WW/8DyyuqbISyIVzwP9eVQIbIJ+GwfQiTq/E0+4DFgY5o/pwF0/X7mzxf4/shUbUPsqjqb0gg5qU/XMzMeesoDh+iMh074tQVDc/RNQIcJnsWLaX2xlTdv3jmcOTVy0o6q1vZn+Y26m4ObXU7eT1Vsim/dFVybzodxzuIBwAls6FwiH/fQqWGweIND40fWiAyuUTK2rV/eoAubbma8T7NvAI42uA2UhDwRo7fCT+zjexxVBnIAN1EOhM7jVSKDgzPT527+x+TpOiEYlE7zrdpTItsx5Unteoq4XYkVui24QtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NLZTysU2QelzO4/FydM6dQs96O/rYn5QB7PvAVroCQ=;
 b=HlNuuFLfCn2kwwEKV/OnkacJB0grKiJr8CHmW6qSvK3QjY7Z1KXxGYFEuBFxSTb8WaiWlfCxPd6sj1jRJFFoBL2VboG2Jkk203EyHttr0s1RH+Gj4Rq/ARMO4MAtAmqcr4ZJUZeuYWf1mrxUo2BZ16D3odGtlCqTAdjHl5tGc37e35+7WkCsf51NqQW2LKNB2KFuQ82g+cehUIh+gfycaJzURIhXsqIvlbge+5wEBTY31U6rXAUfkUC3HO6yShV2HWpAKfPkRHemhTgKM6uTxz4zL3TvoimgosDDxo8CXstnHyqDebtqEP+T0f2hTG+ModtNKTztu3+oxICorsZEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9133.eurprd04.prod.outlook.com (2603:10a6:150:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 13:28:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 13:28:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 4/5] selftests: bpf: verify ca_name of struct mptcp_sock
Date: Thu, 24 Mar 2022 21:28:31 +0800
Message-ID: <e4a6bc59a0399d6e0518af9c59d3a5df68a996b1.1648128255.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648128255.git.geliang.tang@suse.com>
References: <cover.1648128255.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f100dbab-b12e-4533-9b89-08da0d9a3f1c
X-MS-TrafficTypeDiagnostic: GV1PR04MB9133:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB91333F2466AB7582DF4EC9BFF8199@GV1PR04MB9133.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v3fK/0mvNjBS+DFjIMYEL9WsOf76P3VnbY9UJ6vvs3smjXJgCVwp4rBNdhpr4GWULcSuYlTRO/QORvg9CA1v9XsBxVkmuYuGKSyNom823UbWQCM29RHnq2hEPKhueWLFZRMT4CbFUV3QGTRoAfFHJfpV3JtxtDko4yrw+fW6HDZnD1/DQGmG8jXrUq3aH3Rl4MKL2DNRG7O6Zk0ThUsIMrXvArZUt3lSshbko4exdBCRHOtCldtz5u3ymn6D49CST2ra1goH7XyiQ8JgYKb3y+cm9uFQCaVt1Fg2meDLWTbh+KAMucPq/DlCwmUIUp8xpFcYstbS18SP7aa19lkPfFOL74cPhHG6oNhFgHRSfB+vC7J8MHXzyy4U0hZXykdShMS74q2bw7QiF8HqFDWQLpj+4a7pBEukJJgxhHnnhj5z/4cCi2AbM3LmGQpHR8Kp8l11EOXT5y/s3sf5IpgZ/xqcY8bdiLVvbOsDWHbtuqwqHle11f2gXsHxUDnUzmblVdM8sDD+Fo0AJ3uP6ATeVhuMePao8nnBek0/oUxJLCKCWI68i5FXh4DtSSzzqVGEVX6QymNxvhjjDFaZjO6ooBixzvUcfCA2FYUMAfggKQ/ShVdCQsfLTIHbMJvwt/lCTBUnqRB0sGCBp5Ki1fEvFCRzlIPmfDFt9CFDff172/eEVxLwAovInvqHoukRLFV4kd0fGJl+negbr5HMcX4KeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(107886003)(6666004)(26005)(186003)(6512007)(6506007)(83380400001)(6486002)(2616005)(36756003)(15650500001)(508600001)(8936002)(44832011)(86362001)(66946007)(66556008)(66476007)(38100700002)(4326008)(5660300002)(8676002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0XWGKMp5E12HdPETd4888e++bWS8S3n8oMtLwWq6FY/t2geHcMLnLKYZDId?=
 =?us-ascii?Q?ByPhkDAsHYPiBlKLRg8ygLk1kLxrkuBzlH+pAHwRHe+jq2sV3pfw00AobWOE?=
 =?us-ascii?Q?XOI+ER6wOvfsBT449OxlJerokkaMDoPpZjr1lOHfv2nAutQeBPzqPXkCqhFh?=
 =?us-ascii?Q?AsaFFZdhKYfnNI+o61xAEdN8DWIloq6rg5fjyKxTg0V9Ue4IJhrZ04BinsWq?=
 =?us-ascii?Q?FrIbBc9yTyoZTLYPQTDszuyFZ5qtMbQNZ1+n3iUyxjqxR7+cHwgz3AlHvFCQ?=
 =?us-ascii?Q?E7okMfyqc5rZEeg++jchHVnGo2NSs4JoK8DDCsjtgJhKQn8svHGQFiXYG2wK?=
 =?us-ascii?Q?oJifHE4hKGHVriIEcQpn4wvofOxXThDhqhswNNQNDvLTkaEE6dzqDs4UZAwD?=
 =?us-ascii?Q?e+bvmHsDQtxtfdy2Sv6z7LNDeLtJO8aqxuuhjKci2yVnGgJrcMypvi5IRPMm?=
 =?us-ascii?Q?VYfchb9NDHMi1dRS6VQZ1rz8+SILjSGrD2uU+vi+tccLL8TQbL74m9vCKW3d?=
 =?us-ascii?Q?AFn+XXI/8oFHDvF1jNYnHaWiILAEPCr4yj27oGBKJtDNRKQTlMOfq/o+pnLD?=
 =?us-ascii?Q?h3+Pu4QoT3MBvO3iaRFs16sPxH8yJzuFTPhkUEbIURnfk1BuKgUfokiaeMYF?=
 =?us-ascii?Q?m/mF/TUVVQVf4FpwthfpNgnEmZeter15Qp0VZcf4tbLguJJ5aiKjK//NiE8Q?=
 =?us-ascii?Q?H4kHOkwYU8QZU2GqY6EgU8rkXvHQukC4W44AwNwnKVNWYC4k4EcOI+13ZoiB?=
 =?us-ascii?Q?gGx8fb9aMcHSH0gJDlKfBpqB0vo3t7HGqsccUh4m1VINimJ+5u7x/GXJzIlS?=
 =?us-ascii?Q?x6GqRr3kFcEU3J+jFlKBxXwzKP8BnbRUufA2WqqS+ng2OjPpLMl93d8N3cBM?=
 =?us-ascii?Q?T/BfydIKipUyHlexJqSvm/2JAFbRnmPn9NxTbboJg80FH6L3fvg+45Ahbw+0?=
 =?us-ascii?Q?kx5tNt9mjftcg4dmUgImxHoNHOWUpD8yjRt47RlMyiPYdb3RqfrslptgQTNh?=
 =?us-ascii?Q?1cVKUwrPU+jWmd5dAIoUXDa5Np3yfEY8cgIYyyhBgoBDfQ8Nwy4xEtAijxZs?=
 =?us-ascii?Q?5mqHo4BnxnNsdAQZk9rZCA1EG80eCeeJzU/XxiF5NpzLl3vIRYVmG3tALDL3?=
 =?us-ascii?Q?QDEusujHulSXShFmGBlOaURQFUNpJsnynZnQfMrnBbVgn0m1hQKG+9+eYhpd?=
 =?us-ascii?Q?VaBCXWLFSNTc4zKx4YZNruR+ZToDe914PH3DN9DMKVh8C1hNpwjKqj1w8qsP?=
 =?us-ascii?Q?RYDQ030lahipRlh1I52nZdQ7sc5mGqtXfrs7rMXTHkOvkaroFOF7gqCYsxPE?=
 =?us-ascii?Q?CqicpjespFmSTGxXQdmhojvXlJC+Gk4ZpeP60kC6sjkT6ih4NYS2FMwQPsEq?=
 =?us-ascii?Q?R3dZ0ipX7NfDFBsIucWFyWh7NLCozC9G+Du5YF9skyHi2W8MCIxNoQI3UH05?=
 =?us-ascii?Q?aS4pye4rD10MFi7pnBMWZ1ZgSWLmQXZXHKZzhOP406XbC7L1C3Fohw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f100dbab-b12e-4533-9b89-08da0d9a3f1c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 13:28:56.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpIE0ijR+UdStR/nrdZ7OgATrg1EtHuThuggM6jqDGmdZ+FP2ZaOwx1k4AyO4Z/Fwy/gkrezNL3cNd7+SQJ+kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9133

This patch verified another member of struct mptcp_sock, ca_name. Added a
new function get_msk_ca_name() to read the sysctl tcp_congestion_control
and verified it in verify_msk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 24 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp.c     |  4 ++++
 3 files changed, 33 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 9ea6687c8f4d..bebe382bcc7a 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -16,6 +16,10 @@ BPF_PROG(name, args)
 #define SOL_TCP 6
 #endif
=20
+#ifndef TCP_CA_NAME_MAX
+#define TCP_CA_NAME_MAX	16
+#endif
+
 #define tcp_jiffies32 ((__u32)bpf_jiffies64())
=20
 struct sock_common {
@@ -87,6 +91,7 @@ struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
 	__u32		token;
+	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
 static __always_inline struct inet_connection_sock *inet_csk(const struct =
sock *sk)
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 770104dc5448..32425f9cd76c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -5,10 +5,15 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
=20
+#ifndef TCP_CA_NAME_MAX
+#define TCP_CA_NAME_MAX	16
+#endif
+
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
 	__u32 token;
+	char ca_name[TCP_CA_NAME_MAX];
 };
=20
 static char monitor_log_path[64];
@@ -79,11 +84,22 @@ static __u32 get_msk_token(void)
 	return token;
 }
=20
+void get_msk_ca_name(char ca_name[])
+{
+	FILE *stream =3D popen("sysctl -b net.ipv4.tcp_congestion_control", "r");
+
+	if (fgets(ca_name, TCP_CA_NAME_MAX, stream) =3D=3D NULL)
+		log_err("Failed to read ca_name");
+
+	pclose(stream);
+}
+
 static int verify_msk(int map_fd, int client_fd)
 {
 	char *msg =3D "MPTCP subflow socket";
 	int err =3D 0, cfd =3D client_fd;
 	struct mptcp_storage val;
+	char ca_name[TCP_CA_NAME_MAX];
 	__u32 token;
=20
 	token =3D get_msk_token();
@@ -92,6 +108,8 @@ static int verify_msk(int map_fd, int client_fd)
 		return -1;
 	}
=20
+	get_msk_ca_name(ca_name);
+
 	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
 		perror("Failed to read socket storage");
 		return -1;
@@ -115,6 +133,12 @@ static int verify_msk(int map_fd, int client_fd)
 		err++;
 	}
=20
+	if (strncmp(val.ca_name, ca_name, TCP_CA_NAME_MAX)) {
+		log_err("Unexpected mptcp_sock.ca_name %s !=3D %s",
+			val.ca_name, ca_name);
+		err++;
+	}
+
 	return err;
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index afacea5ad9ca..6e7d2abf6ce3 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020, Tessares SA. */
=20
+#include <string.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_tcp_helpers.h"
@@ -12,6 +13,7 @@ struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
 	__u32 token;
+	char ca_name[TCP_CA_NAME_MAX];
 };
=20
 struct {
@@ -48,6 +50,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
=20
 		storage->token =3D 0;
+		bzero(storage->ca_name, TCP_CA_NAME_MAX);
 	} else {
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
@@ -59,6 +62,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
=20
 		storage->token =3D msk->token;
+		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
--=20
2.34.1

