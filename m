Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F482A46
	for <mptcp@lists.linux.dev>; Sun, 13 Mar 2022 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647169173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOEOdw14pDykTt6YIAuKv+FOYOgk4GJugxNkPtgNKSQ=;
	b=Vo99a2f52ycSn0n/kIx2H7Heb3d1LjS56nWoTdAIJDyUPOSNBVsRU1NrzTCkdO/GM6ZH/f
	uStXMC1oqvJEeMe2FIdr+snGLWfH54pqIuE4lAyBRHkamxejtzCzXhTGdU6zgG89PFq4AK
	CDM5ur49My6VKyQfhP5NU/PWTE+qClk=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-ht_dxphuMSSfxYSWNkjkuw-1; Sun, 13 Mar 2022 11:59:32 +0100
X-MC-Unique: ht_dxphuMSSfxYSWNkjkuw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh/9Zg57qDHnDse9R9/MiyvFqqJ23FBI9VJyMEjf+gzNgAg6nwyk9nT7ana3iE+/CQGTAuvRCb4AwB6qutw/7V/QyWzCLheoxipJPPt7c8qA6lY2FA/e6AUcKJnDAJJaCGgE2xoijb7ngMyVb/rnQt9pjMJsdhiMDXOw++tya8UVrRSRy4kvrJa3VA71BAqfzpuW7tF1vmt4/M1ndQ6ZQHbZqXeRtdG94Eb4se1NKDUyu98w745/Q71fLJX86ZOiscrweAuufUCuulg5rQqS/fip1J7gScO6fUMD983qPEf2tGdIhugilbRWfRf53zW6O/eNc2pjmmWsEwsrND/ATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG7RWQ6QufPqJ+FFMWAzMa45vyIW0j78rZ5gJHYF+yg=;
 b=XtSLNKChu1vlJ9UzQbfdxWa58HqA/Bk1lWUdOWiSfBrcnHPPdBMwITxQA7svyVQHxbt2nw+5cjpZdw71XfFGx5iUFE1ySbW721rZWXqTBSyZe01Y6h8ZnCIasRW4WEfSnMDT6rI/apLP3wdcqriTmg9PlHWXSXefpJVBB3hk0sB7pAlhLrymFdk6dO080mk8WXpWfErjmaCjetRXnTJbQL3TydY5b7C1ZCNBt+SsqJvT3jMIkxP+jJv5NBTUYJfUhcOgClknBRm4I4vdcOEkzLB79Y4T0gKIEOX0d5+g7BkHsYN4ok//CqCp+pPzXmEEx/g6+7WWcJ3S/47Bn5Vt6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9283.eurprd04.prod.outlook.com (2603:10a6:10:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Sun, 13 Mar
 2022 10:59:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 10:59:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/3] selftests: bpf: verify ca_name of struct mptcp_sock
Date: Sun, 13 Mar 2022 18:59:12 +0800
Message-ID: <02c05e67dc58698cdebb95664f1d636c64259973.1647168955.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647168955.git.geliang.tang@suse.com>
References: <cover.1647168955.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 359acd7f-4584-4a08-d517-08da04e08cf1
X-MS-TrafficTypeDiagnostic: DB9PR04MB9283:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB9283D905175DCB004C3D70DDF80E9@DB9PR04MB9283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wvmHAqfrkaHcWhtPjkjb+OgttDfuJ0XxinLyJzU/6FgFH+ZhkXBvKj0C0WGxF4Yc7z9S64C6AdJ3ARNl42d1JYzpYuYxTFTso2mobNf2Uuws5q+rYgnVA0oej1J1RmFBIL2DqL7bv5BqCSF4Szjx7uBJkpR5wBxntGt5bbTQjdGgyalQ/+mkSIzPD4WIghNp57+SSpnht5S3FRV28TuF5By2xm5qUzNlI2f1We8dwvyXlwvGDN9xsmBaDG4WgMtqCfRvbfPjtGV3Dv6rX3raYcJyRiBMqNbuT377VSQqKtxu8MuM+CGG0mB5NbbuOWb7ljlkBGJjTwAtpdLnanMX39Jca9XXAg36rchvY7OHTHeEiVCCYKGlTvbZU5FfLxdq8E8D/epGZX5KjeGTrMKq3ibWKjwEjCqwSeDUnsaRhMJFE8Xn4km2bgWYN+rJzJDS4Otj26aluFt6qu0eOXVkB+t+l7AeFjT7JLmy5tHAkbgwqSBzrPG5fVGxA27rpIBsC/pIiQ6HBtrZjg4BYWaVl89qOQYzS1u8+FQiV3KQ3EgiBIE1zWQtpPvJqOTrAWQYFG8tqKIRpFJ4qjveHJ3OFNuU8wTTWcph4EJR6I1h1oeE2tJ0l0WanavNqCIrNr/gEEtHqOVgApZmU+fbbNmwHzf5LOQyN9w0lEgjmGDrsvoDvfYpObBZbnQYS90z8MON
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(2616005)(38100700002)(26005)(186003)(6916009)(86362001)(66476007)(8676002)(4326008)(66556008)(2906002)(316002)(66946007)(8936002)(5660300002)(44832011)(36756003)(15650500001)(508600001)(6666004)(6512007)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EssGOIbJ/02dkSBz4K9Og2ucGCur2SgLAGdvoYxq1O6h2+xUVzr3fu1to13g?=
 =?us-ascii?Q?4wc+yiegvO5TRYt92Qwb+NPiEFfjNEN/jTj6Q8vTYAYK0WQZ2X2Y2eIoQWLV?=
 =?us-ascii?Q?20eA9RD4pdKQVR1chs34e9FEKKGS+4YZPPsa4x/EQn88qkD6JVwMKQgljYN+?=
 =?us-ascii?Q?KfgyDpB3xFEjfVCEzr3anOo1zAn5kK2d0WGqHIRjQVWFvH2oFTIRpeD0V/So?=
 =?us-ascii?Q?qHBROmfGGFpcwPSm3tMbGnc9JEkuNDcIgnhVRC1UmOuWvrJJs8TgEpr4brOu?=
 =?us-ascii?Q?16UwntV579rvoUCHzlAsN3xJDQU2l5ZuzsjUTVAFOWUVVfusl0aHWsUSnfHA?=
 =?us-ascii?Q?+lXOEjhm300dqgeHAV9ynxsGj9auZ11rtWVutw7utm2HubBJcn5HGQs9JUYY?=
 =?us-ascii?Q?d1ourt5V6zU9aHUg3h8AMvLLb3KqDF5UOanCLkW4H+2O4i+vNR9r8Nmb7iN+?=
 =?us-ascii?Q?2gCmDCSPXMB7iBQkfgj53U+U0BgrP24xJRvAXEv0jkN/mN06UcTuDgP+4dwI?=
 =?us-ascii?Q?ovA06NN7R9aoiTFTXSWnda1P2jvn9G9rL49dWW4ph8iNmbzudXNBBz9PIBFA?=
 =?us-ascii?Q?WQfUW02RjBgpmsQf/qFc6++QQLSePp/+oovXLL4w0x3JDJpmLzqhk7kOyn7b?=
 =?us-ascii?Q?acTd9rgEeefRmrkhoYYk7lz4mDcy7k+1Kz9Wc4hon8MWw2RKWoCXjiE+xGUm?=
 =?us-ascii?Q?k5UntTtUCvPWh6RF8rwEgTDRqc9BPrX+Fca4cUQogIb5B0e2Xw8KcfuZi+it?=
 =?us-ascii?Q?uwIOEC14C9DC/14wo/aPX77+FyOW5ciR8sZOgmWo7nr6DefUUq+bPAgoLrhc?=
 =?us-ascii?Q?neJ2N0E25tLKSGMwrVsKTjObvZrFp1/xwW/A9hT3cgTXw/Cg+ZI64ovopmLc?=
 =?us-ascii?Q?1Q3nHq43f5Yv6B8z2jQqcLFBXs7hbXzzRMIrmsC3sajj/db2nW/CPbPYkbt0?=
 =?us-ascii?Q?4xQI8nexCgvpODOEBsFI/xC71TD6WEB4eVnVxQ70JW2k5ZoB/+ZtOB6wbqdd?=
 =?us-ascii?Q?DO88RTJL4utL9g3lX67sDWMTQEKibaIUVlYGhI8v1JyLSp+fwS7SLCOF17Cf?=
 =?us-ascii?Q?SoTZ4PONnMyUfF3Hfz9hSS/RUA0nXRZHCjY/tfZbPci2qKGWplYwG5UThQpm?=
 =?us-ascii?Q?baXYn4AdlxWOjK3bOuel6bXwd22OEyXrtagEGgkcTCqQGc9JEehLlAWb04ZM?=
 =?us-ascii?Q?SIFWpniy0OsLZPGppXIBDJ9G2RlVPsHcOHsYoRsMDSJZcyUEnm0hntHz1/4B?=
 =?us-ascii?Q?Qgy70MmsDJU2BJ75/4b36btliE5vAB8kxB4pTrW5GLKfV736XvpadpzVg2Fi?=
 =?us-ascii?Q?Pk1wAqtF+tHaDir1ocq9JC0tUSgS2arwg/oES4gHc0KK0FGxyIz/EOMR2e23?=
 =?us-ascii?Q?4YSHq5OpTTWC7P2ziwwccISCuEUUA+/sSQLlIbP0OfHypnudnezkFrq1Afkn?=
 =?us-ascii?Q?tLmi+GqgGbH+4/5RCn6lztHWIiWtcVTjl7p922NI3hR9A73D4zblRA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359acd7f-4584-4a08-d517-08da04e08cf1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 10:59:31.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKrOFFeOF5Ri9DE7UprSHi00pT3J+fAjAKOuBlGKooY/zxiKFEbpxOijSA9QOXcHem63awsknu15GHoLImAljw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9283

This patch verified another member of struct mptcp_sock, ca_name. Added a
new function get_msk_ca_name() to read the sysctl tcp_congestion_control
and verified it in verify_msk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 33 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp.c     |  8 +++--
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 9ea6687c8f4d..57de5ca5ed50 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -16,6 +16,8 @@ BPF_PROG(name, args)
 #define SOL_TCP 6
 #endif
=20
+#define TCP_CA_NAME_MAX	16
+
 #define tcp_jiffies32 ((__u32)bpf_jiffies64())
=20
 struct sock_common {
@@ -87,6 +89,7 @@ struct mptcp_sock {
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
index 80ae5a9777bf..aff35ab33379 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -3,12 +3,16 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
=20
+#define TCP_CA_SYSCTL	"/proc/sys/net/ipv4/tcp_congestion_control"
+#define TCP_CA_NAME_MAX	16
+
 char monitor_log_path[64];
=20
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
 	__u32 token;
+	char ca_name[TCP_CA_NAME_MAX];
 };
=20
 static int verify_tsk(int map_fd, int client_fd)
@@ -77,14 +81,37 @@ static __u32 get_msk_token(void)
 	return token;
 }
=20
+void get_msk_ca_name(char ca_name[])
+{
+	ssize_t len;
+	int fd;
+
+	fd =3D open(TCP_CA_SYSCTL, O_RDONLY);
+	if (CHECK_FAIL(fd < 0)) {
+		log_err("Failed to open %s", TCP_CA_SYSCTL);
+		return;
+	}
+
+	len =3D read(fd, ca_name, TCP_CA_NAME_MAX);
+	if (CHECK_FAIL(len < 0)) {
+		log_err("Failed to read %s", TCP_CA_SYSCTL);
+		goto err;
+	}
+
+err:
+	close(fd);
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
+	get_msk_ca_name(ca_name);
 	if (token <=3D 0) {
 		log_err("Unexpected token %x", token);
 		return -1;
@@ -113,6 +140,12 @@ static int verify_msk(int map_fd, int client_fd)
 		err++;
 	}
=20
+	if (strncmp(val.ca_name, ca_name, strlen(val.ca_name))) {
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
index 928111f56f69..61adc4396abf 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <string.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_tcp_helpers.h"
@@ -10,6 +11,7 @@ struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
 	__u32 token;
+	char ca_name[TCP_CA_NAME_MAX];
 };
=20
 struct {
@@ -23,7 +25,7 @@ SEC("sockops")
 int _sockops(struct bpf_sock_ops *ctx)
 {
 	char fmt1[] =3D "invoked=3D%u is_mptcp=3D%u";
-	char fmt2[] =3D "token=3D%x";
+	char fmt2[] =3D "token=3D%x ca_name=3D%s";
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
 	struct mptcp_sock *msk;
@@ -48,6 +50,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
=20
 		storage->token =3D 0;
+		bzero(storage->ca_name, TCP_CA_NAME_MAX);
 	} else {
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
@@ -59,13 +62,14 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
=20
 		storage->token =3D msk->token;
+		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
 	bpf_trace_printk(fmt1, sizeof(fmt1),
 			 storage->invoked, storage->is_mptcp);
 	bpf_trace_printk(fmt2, sizeof(fmt2),
-			 storage->token);
+			 storage->token, storage->ca_name);
=20
 	return 1;
 }
--=20
2.34.1

