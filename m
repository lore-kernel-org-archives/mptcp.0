Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF8423AD
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 10:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648203095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfU3NlHtmKC4wD/Jq/Fxwmyknni61zS/G1XNJI2tGUo=;
	b=EZAnsrfmuGEkHVK4n6bwwybvhBud21YAA+270zrlfwkPe98BnpdEtlHpYtKd2CsnSlLvGo
	G7Q/4sBAi0YtAQinqpYctWq2HaOT4IuOmtGCPMBw4PMcaqemu2mYMlOOhQMrAtF2bTZqZg
	7wZ+sT5RN+pvVyYq2nfhUjs+IR/EMdM=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-2tHKMfuvNH2sXfGvNqSu1A-1; Fri, 25 Mar 2022 11:11:34 +0100
X-MC-Unique: 2tHKMfuvNH2sXfGvNqSu1A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNd0nnfNRTieUjjn/5/9HyKzK3EpGT+wMiS3Hq6BvD9HsAMIP4+9xzPYlom7I2r9SxcOBSa7Nr+SfjLaPXgmHqjHESjdvIqwJu8fyADX6bDf0WtuzvwC/44FJMrDxiadfm1AOOKV78pUn2oV/Fb6NE5YnQn30y5yFizrKmpN5anZFynS41cNC4yVY+1PExV4zTuk9n9hIzUxzeED+uEX0XwBfVu1dOSwkNxeO8DdoqMQH2g7U6n/fIT3v3xILfMmqzRyXKik7/PRgj7JmjU77oVIHBy7/gXI0WPIgtUsARiCbwcoT9sWbrwiTSMZyjQVEHf8A1m6yyM/hkIn3m8UjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci/75E5wzoA0muwZ6d/TDPhr4YYB/SVkUQsgPco6p2U=;
 b=ffmDBh7Xt+IbKRSNeBmyEuWQrt68DRF4/a3eE1PgLhbKsvMvk1/tndAjk4RXNVLiIP14pBqdK0w2RIuLGLfiJOOcu5dodZy9gqUescgJqk9yvdogIYQwti2hKbmup0xZ1Nd8uDK2sdKp+ysUeaTirV0MNND5RdyJJ0PG6+OD1csQJhyja5EpUvxa//TxlqVMZAwxk7qgFOunywuLxS1qoTjhkJzcDgld5va4SJ1haN/S4UZYXlk0qBxJd5GgwlgmILDtunFlohJe2MgbEi376qWJ+QV4TRn3KRVF4fS7Rq3D9QCBZIM+9ViOpWGFmKNG5ivCsq13zL9FxNQ1oXjBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 10:11:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 10:11:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 4/5] selftests: bpf: verify ca_name of struct mptcp_sock
Date: Fri, 25 Mar 2022 18:10:55 +0800
Message-ID: <5cb6e05c8cff43ea887bcaaa428c131654f08c1e.1648202310.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648202310.git.geliang.tang@suse.com>
References: <cover.1648202310.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cf627ec-d306-45d7-bf36-08da0e47d67f
X-MS-TrafficTypeDiagnostic: DU2PR04MB8726:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB8726212B8685B8A364870431F81A9@DU2PR04MB8726.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B8aN+ooiai3GgI3/YJrqXFpOt2v8zgckXRjB6FYYccQkoVoo/B9onloU5LJmMX/pXJzghs8E3j1gI09Zd8hfnkSKcsQSFpOevyhBpiu/6tyRRzONvJmX9EcZvV46/uuzOoTVO1QjilZ6I/LFmxcna86yWPNzF0VLxjI2lChOgQeYeXcwlGBJeKRgk8CKuCmIR9vXh+J8PvdalonE4MbnRm6QvjrtRX8BEOOOOH7Z1HNP9hC0AsFac2C/m4XV0NFOzkkzhAGzbb3sAqFzsXigJ4hvPJxcyXf1FiiajdGkQNOsh3jJcddgPf180n/W+llXKZdSzqvv5+h+bHYToFms6UndomQwUsTIm58BIA+cZ0V0qRtGAjAGgYWREAmrAHhUAF2KInZEqlW6G3tdXUoIDCDTROVwvx1YMPO2sggqAvKYdcg4smeyxiv+ZzseBLYJp07xPUMXgI+uU/6pp15yrvicNH08Y/DuBXaLnLRrzQAKLfREZJ2SqAxxAyuRAibSE5/RYXWdzLxeWZnhNmv5RxHQunuX6+ZC1Ze2vxKnN8wat5MtFs0innFQixB9iO6nwRy/qoQodAqyTYjgNcJ03yMWdhXcuGqMUuapc8uE2f+Lda+3iHqsb4jvUPMyzgi6kv/mB/Zrd85XgjUcn/XMsBA/6AXr02oHXUJ+rpU0+2599nWURZ4FwKNvvOzXkc3mIWZ783g+zyR34YJ86bPrNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(6666004)(8936002)(316002)(6916009)(36756003)(66556008)(8676002)(83380400001)(186003)(2906002)(2616005)(44832011)(66476007)(38100700002)(66946007)(508600001)(4326008)(26005)(5660300002)(107886003)(15650500001)(86362001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PDGW2g38CoxWItNugisSzPRGTeoRWFyaDRW/iNcbNXVu+Dvbgv/EOsJ+WKfH?=
 =?us-ascii?Q?BYI7tGsL0XGKHtXNVAoBVC6ABPsQoWS6fW1fETpelbejVItlL63bKxhZ1kzl?=
 =?us-ascii?Q?49AHFo6D1iqIdhYqZPgzq4I1UKHWYfDBJzJlmr32vEqDiQP9hP4XlapBZAIV?=
 =?us-ascii?Q?f/wPi3bX4MZTKQDyxQJwfcoRW0cUZXQU1HHsIv/IHwRVptPQgnOryoCLAdvN?=
 =?us-ascii?Q?lvL2XNM48kCvFagjEmzBbMnsSRjGK6+Cu4o2bYc8qrUgqLUecH/V0qmA8Y3Z?=
 =?us-ascii?Q?y1Gg+98fBSIYcpGBeIOh6p05RYWFBSyFM4+t+PqG5q0iIkNyXDhIWUSKhkBp?=
 =?us-ascii?Q?J4Pi35GOLLjD4IozkSBhFV96BnLRAkoSs9Ryg0LAMFGwTgtHjuc7sESZc35v?=
 =?us-ascii?Q?aSC9C8yjK7Ix2IBmBCoyTi1rGHMD+oz3GW7IdjVt0+bQT/AQpo48W85vF/3a?=
 =?us-ascii?Q?Mt3k/3AZ1imcTnyQr1aB5K6Dl+ou7jWkHYUi4pzhFNJva/RMhHMO1hiS13Hn?=
 =?us-ascii?Q?9e0nQot2o/xy+oWP6ZqycrZ0QwzbdkM5f6iJA65pZbsRLP08X3umeB1xYqem?=
 =?us-ascii?Q?wDcuYWKxdHXlJ4HPGpZSs7fUeobJFe7g8pE39/SZ8gjdcsUNJnX9QxQakrT8?=
 =?us-ascii?Q?3ib509yb3+dLExFeDwWYFxyVqYvzuqZhQuKzkqzYP53MgZ20rpclGb/cfdal?=
 =?us-ascii?Q?mc0K09hBay3R+zxe6wtl/6KYNoD0JFtDNqqFhIBGoshXJy5A73jbQphOI8PO?=
 =?us-ascii?Q?ABya05N2KchR/bzInTNzQX+I8HqLkcUM8yVJHaiwbwHLW+tTvXMWmWf9HUCM?=
 =?us-ascii?Q?+MaU2FJkiBp7h9uFYUXTOXpB9HHzom1iEUdR5lIDB5jbJwnZHAenBUNqQtuS?=
 =?us-ascii?Q?M0ywJqzmyvsDHv1wRZGKe5fzEyMOOdyCF1FMCTpetELC0U45X+PQs8N3gnup?=
 =?us-ascii?Q?a9ELkOclOMhx3rVJ6HI+t+Jr9weHi18FGQZ4VcJRBbTZdaK+tflnzrM0AgVL?=
 =?us-ascii?Q?7AnlxQOQZVZ83o97BHveZhiG4IdFL2RLJh+gJBlnFzilk6d9dR3bZmGcBxWZ?=
 =?us-ascii?Q?RnziPUONIwAb54Mt/PHFu3PeOrOcYXViVK8FJQKorSu51kVt1/YrKkvVznI+?=
 =?us-ascii?Q?3iJLezKFpzY94TG1nx7pRuu4fcAb3jOpBWhM1aPecWNJ//OjECptd14zSthf?=
 =?us-ascii?Q?z+0XElMB1Uy325L7JHUTH2z7JkKgNemNOK1KBfGj1Ne8S2rOFGn1YD0eUnLN?=
 =?us-ascii?Q?sZjVfk0EvS9///XDagYN4+gJD3+YKFTfCr26jddZIKTaNG55ANPrJuY1/Fwf?=
 =?us-ascii?Q?8N55yXhi6CvoLhTHXesNCzg7RbOohQG7ubBlvhVZtxwwUne5KrARqs3wx5Zf?=
 =?us-ascii?Q?1aooEnxAbxrjqFSdBtf14IJSgnQ3dkF5fyZeaFXKzkJ04EteffoS/dSboAso?=
 =?us-ascii?Q?AdB30E40PHqDKoLBCFbzuaG073UEUG+FJs6bx+rCU+UHAr4ged83WlhTYP4k?=
 =?us-ascii?Q?uIY364/ec4HB38MpXuYR2lR9XotzvwvKd8VXG1RS/alxRqvVFfw9lMjVR+1V?=
 =?us-ascii?Q?PG1NJDAazKtIvs1dwQiPpKkX0DO7nITWSDtugbtnymi956O8Fa+z0//IfRwB?=
 =?us-ascii?Q?235H6GhrEbGmuEewJdYCXdUZMg03ndaiNpl5yg7k5yDXJ5G7rM86/UP3PyTd?=
 =?us-ascii?Q?hal0CoKlm+KwsmBhms/jyFuE6+OEsC7cF+L3PfxyRizdDrO5A/yHxJsAKzYG?=
 =?us-ascii?Q?KPba0NPEFl2Ac2xCkt6spcagafmc4ZA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf627ec-d306-45d7-bf36-08da0e47d67f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:11:33.4103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: po8SqAAFT03T2ciOjf1/LVmcWzLvfSk9SEdDhkl70C759MUMPfTwcZzdBB4pb1aBoGzMcrVCf6unyA04T++5cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8726

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
index 3232ace122c9..ea8dfcdb230e 100644
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

