Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3515B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SpBUqF82YcGxUV8LoA3SHgMQyEVY6JxpmipXvwT1K4=;
	b=Ck7EiwuRWHz1Nm8pBPhXFbJepytpdLTPFoG2YbCsZ+k6D1AZRBaGw8bCAaN+UGUs5hHKCr
	M3sG/UzNZQo1s0GRwYBYg0HTrC1opQP3/Yc9UhY5F6PASg5OuReCiKTOYVf77HcMLDPDPD
	gb9C1RrnFwJGg8+NZ3eol06huZC5DmE=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-M9siTDwNMV6veUVk7GiZuw-1; Wed, 11 May 2022 09:57:03 +0200
X-MC-Unique: M9siTDwNMV6veUVk7GiZuw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOskHCaEdbMkZlJFP8NrHisGQPTjuvtEIaoQaMXvoMOfv3S8o05X4H0790fWBm3FVNn9pD1Q/MJogYrOdPvTiyaEvQ8NwZq0OQr9ARz/K4dNLM6MeZLie2S9yOvdUMaSFNbn7dmK87AdPzzGv3LkRAvQNy7793MHePXYnY/7LQnvO7dGsU/Nl9qkXt/gCHUImKZiql7NZfgDsvmMDzAr1bBBgAqQQoxaNZAwSg2qYxGXzXubwvZVcgynysDmSZeazcvZMJxf1TU6oOVTYqqBplTUE0CdDvV2IU/lpIthckYOJ+iPcn+/kayycD0iZ+IxFLRVo57AlbYnGklCMvNJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf9yf7UmVsH27W6qFBq9WT1ryMXyhCiu10+nip/dPT8=;
 b=Rj+p5Jp5NqTU6YlfMFy5WWDNjONc05WWav0mT0R2Wy2tlH50PowJmCtT1rMEIafOXZJSrrI4MDBsnmr19qtsGv/GIw17n4A4hDH3SQ+w6BGKcuDgUKoLpPS/+6U7OSI7jWRNVyeq4QuHHAf/YCLd6XNWbig5yvhv3Rb5shoiqu2S92cRXwR1oMMNtva2eAYB8Qk2eLCQ77cPpokgz8uPRSdBZ4jR+4XmoJdP1qvacAD2dDzDtyMj8x4fOgE8viRhrtVD3V62yR8P7WZAIz2k/c3c+HzFuD75eqwY+HKfRcWQS38MG4QISNJDQT2ox4DZfdcA5DtrO8iq0LXlOzz/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR0401MB2653.eurprd04.prod.outlook.com (2603:10a6:800:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:57:02 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:57:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 06/14] selftests/bpf: verify ca_name of struct mptcp_sock
Date: Wed, 11 May 2022 15:56:12 +0800
Message-ID: <48d9ec3f7e336e5c92b2458277aa997d4f0f3216.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1eae894-1165-4b29-5de0-08da3323d508
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2653:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB26538191287B05DF9D461717F8C89@VI1PR0401MB2653.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pb/MG7hB0B9oEgtZc1ZeDFSrZkmuJCnCYx8gf1z/rb2XlWirP6x9Jc6rp0pYwULeJlDrcp/M3qYqCACgenlUybDOmld0a3h71RE9m9pdKKJGm05X0iHtOosFvidUkVKRDjQHmF1vnwkBYVn3OkkcIpXkzbF9dBUFfaXA4LVJ1uO1w3gYXmUhhXdBZY6WEqtIrCPf3kPDhDdoUtBhtJoiLK5SUb09pnJmmRhMHK6HFArbatFxxFPqrAyPgLPKp5ckJJpcWi2WZYStf2NuruEWacWG10qIxYuCZMEjI9+8ZI/I0aMJvfuOgI7bKazn9Exs8fQmsUp9u71BzHv72qsO1KTnLXg/tuh4t+BSiRjufqNb+FZB/R+j3zIe6L9b8dacyyJA7Viy8KsoAeZbz4+Hb7kuujxmcsWP5CoGqu1D2CcDxuvsrJEN9H9vpbGIAn278dN7eNMlW9qm3bxoG93gJx1S6hmlHGoy6h9tUwj35jrltreChAI8xOmFvwfH4Bn5ndRbjzhxEjGH7CiyyBLyZd8UCeg1P5kXKTo0PfRZWbR2mWpoXBrSU8iyXaLlsV9ESLama9Vylc8x7aU1dpOvG6ZocoUGFuvrGHJO0eK05DoikGzZYH7JwSYlfNyZXzEGJ6enbZj9l9nEIG+2Wn8f/1h7AGknD8o/eTZ4XLyb2PyHROHYRKxUfukQPsDNpVdOWdbp0tUoFvS4CfIEoB17eQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(66476007)(186003)(6512007)(86362001)(4326008)(8676002)(44832011)(36756003)(6506007)(26005)(2616005)(508600001)(6666004)(6486002)(316002)(6916009)(54906003)(15650500001)(83380400001)(2906002)(38100700002)(8936002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o1qwK4kErBjucZn0PvhmWdN4Zwuec3OwB7EyfLJ6wxIm3wXfDn6JG6izzpCG?=
 =?us-ascii?Q?3tBR3bbKI16++/Ep1n+dtDnm/za525ea8aiUSwBX1DPoRkQAIDM/mISoxSAR?=
 =?us-ascii?Q?JynPqjKBIwUxLkNS03vkBC5+L60Y3I3Vum3QIFBfzHKVvux3j8UIQoZmfb/Q?=
 =?us-ascii?Q?pGC2bcaKL3SL8pZadM+9d2BYULiVDj26sl2KWztCItRu4+gMK4IvEDQ/Y5dh?=
 =?us-ascii?Q?DQQJKOJy9GUmqIAxcCm6SnZJa4iOfwfR0SbwBc03F4TouQfn8ZKipv1ihOyS?=
 =?us-ascii?Q?ClLeGMLWdGz1ea6hIO6vFGLH1yD5+RSvmh1d1fEdDrn9ERVnnr0i/YbOOC6b?=
 =?us-ascii?Q?OwNtnjMk/i0V0TRBTNwKtexy9nBl7V2awymXZyXlkW3BqwzufxmTRow6al+V?=
 =?us-ascii?Q?pNig4j/7w5ECyOQlrHhxtmXE3m+QEXgKRahdjibT9j0GR/r2tbXoPAiYsD21?=
 =?us-ascii?Q?lGxGg4PND3Rrag011HhYQmKhDfOjgB6msm6UhW26klx7FelpbDEyUG02LIDr?=
 =?us-ascii?Q?4jxsBnngOOVGf1gW82qwrUMZ473OrMHX+UdqXwoYx1gHxeB6cZbmnjuEl6aQ?=
 =?us-ascii?Q?11Hc5PtyA9dU+Zk1b7gzYCkoATza96SOpOXrMqLnn4j5go+HEohbHlDWCSEe?=
 =?us-ascii?Q?wTZgH/kDqkN89xm+pQzKl/23YN2RvDn3wHFHohWe7Zp0yTc8ifZ75IK5Y4Ht?=
 =?us-ascii?Q?Rw1LFcNj+aTFs8ZayYHQGj+kgE4zaSY/IYjnh9PZSy/xdHllW5I+fh4MEEFR?=
 =?us-ascii?Q?WQeW594IQX4DbtVjGyN0Nalkf+96u7awNGlPH6hLr4FyQ5EN1Ni+8X32WNee?=
 =?us-ascii?Q?XsYRJOq6wdRWqWe6zcdPS71JBEXASWPpR0MSkxtC4XXeAkLP4fH8uyPb1W9o?=
 =?us-ascii?Q?gjdRXY/jO7OxqqpHQfFBm3JeoeEkflwPPTnidhBv3uiAats4E4oULW/eh1kH?=
 =?us-ascii?Q?RwlqQP6V82CCDRWHAwsxD98FIlS3ZfN0zCOY191pafPj2JpeTuPEvo9dPjCV?=
 =?us-ascii?Q?/0o1B0Zx4wF60ZX83EGpNAg4od4XoyRnjEkAU2TujAmJPZtNVMflNwMvJZyO?=
 =?us-ascii?Q?J2hv4HghbMHEu8Nci8M91JyuMXUZvW/qkCxeFHzLe+/vsSKCVGVO/YLqEaZD?=
 =?us-ascii?Q?h/Bkzy4cLpgqIXSiFsbV/Z0oo/gOunoeL44FjxKXM1oayhcg3vLxkFPRgMXL?=
 =?us-ascii?Q?BFOh2a20FsUB4RH/GN15o4t3HpLNG1pH9Tv/XeTn1lDydPFS6o1ninMktSRt?=
 =?us-ascii?Q?Gj0INpwfGdQNO8sLEgxOgGa4PXlJq2CMpAbQnU+BWAX3BtXCqe+lbe1+SIV9?=
 =?us-ascii?Q?TH/8HEc0ViXMT3orM5IAgnPEol3HCOFQBpPNuvKRsyjmhOifEXpyJgcCZKj1?=
 =?us-ascii?Q?Wenum6OkQL3RRYB0X2XQccafrwi5cduFfS2s9D20+V3fQYmUN16yc+MJJF6A?=
 =?us-ascii?Q?fnZ+VoeMcYWAbdglE+bKD6ChmWczXbLUKo6BckfK1agHP40BBdPGipDn+gUG?=
 =?us-ascii?Q?WKAX85glgAYZnmakbV5R46VZ95HIkK1shw2LQQItOtiHy36IOGo4B8DChCt/?=
 =?us-ascii?Q?8T4JFAdl5OOyFe4CzMHncyMnqCGwKODB9kiTOdVObPQHEqpgdC6RUDsmTRh4?=
 =?us-ascii?Q?l1Z5r7NiZE5dCUd+581dRIRj8AZoif3B11TsVgJGLGeeaeXDP8TTHR3ly8xs?=
 =?us-ascii?Q?wj2Zc3dDhDqLt55i3LZH3PbYnyPdV1eU3xw/23uePmCOnxE+lwcYpiFS4RJy?=
 =?us-ascii?Q?Wv6hQUdP6YVFp1VAGksoDch8UunkL2Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1eae894-1165-4b29-5de0-08da3323d508
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:57:01.9969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaswKIA9aOKgRGiAsIlaeU0xevfwtf8V93ke98ByKoLihYuI7KQLExIyEurwBRfqf4+JsfU/R06bkN0S/sfQhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2653

This patch verifies another member of struct mptcp_sock, ca_name. Add a
new function get_msk_ca_name() to read the sysctl tcp_congestion_control
and verify it in verify_msk().

v3: Access the sysctl through the filesystem to avoid compatibility
    issues with the busybox sysctl command.
v4: use ASSERT_* instead of CHECK_FAIL (Andrii)

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  4 +++
 3 files changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 422491872619..c38c66d5c1e6 100644
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
@@ -230,6 +234,7 @@ struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
 	__u32		token;
+	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index ac98aa314123..2ff7f18ea0ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,10 +6,15 @@
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
@@ -75,17 +80,40 @@ static __u32 get_msk_token(void)
 	return token;
 }
=20
+void get_msk_ca_name(char ca_name[])
+{
+	size_t len;
+	int fd;
+
+	fd =3D open("/proc/sys/net/ipv4/tcp_congestion_control", O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "Failed to open tcp_congestion_control"))
+		return;
+
+	len =3D read(fd, ca_name, TCP_CA_NAME_MAX);
+	if (!ASSERT_GT(len, 0, "Failed to read ca_name"))
+		goto err;
+
+	if (len > 0 && ca_name[len - 1] =3D=3D '\n')
+		ca_name[len - 1] =3D '\0';
+
+err:
+	close(fd);
+}
+
 static int verify_msk(int map_fd, int client_fd)
 {
 	char *msg =3D "MPTCP subflow socket";
 	int err, cfd =3D client_fd;
 	struct mptcp_storage val;
+	char ca_name[TCP_CA_NAME_MAX];
 	__u32 token;
=20
 	token =3D get_msk_token();
 	if (!ASSERT_GT(token, 0, "Unexpected token"))
 		return -1;
=20
+	get_msk_ca_name(ca_name);
+
 	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
 	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
 		return err;
@@ -108,6 +136,12 @@ static int verify_msk(int map_fd, int client_fd)
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
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index 4890130826c6..c36f2f6bd2f1 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2020, Tessares SA. */
 /* Copyright (c) 2022, SUSE. */
=20
+#include <string.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_tcp_helpers.h"
@@ -13,6 +14,7 @@ struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
 	__u32 token;
+	char ca_name[TCP_CA_NAME_MAX];
 };
=20
 struct {
@@ -51,6 +53,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
=20
 		storage->token =3D 0;
+		bzero(storage->ca_name, TCP_CA_NAME_MAX);
 	} else {
 		if (!CONFIG_MPTCP)
 			return 1;
@@ -65,6 +68,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
=20
 		storage->token =3D msk->token;
+		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D is_mptcp;
--=20
2.34.1

