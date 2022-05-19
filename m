Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC07A
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652948769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0wyAiqJrxbsrOzQZkOW8J9DDbOtPs1v+mOWtujL1zzM=;
	b=f9yeW3qceuUhkQHgVmHpwmeoRoDPG42MRsLb9XcK3PoDIJ/xuS5SwQDx7WnWARjXKYFHwT
	JfclQgpWOCtgX7lUr/2tYjGLZtJEA1XptocDg4u7goGbQEmksYxdbvSeLK9GhjymgE4FnM
	BDZ58NbjjAk/hyltoT7hymo7X+NLEb0=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-fulWZ2loOTWOJ_CghUzpMg-1; Thu, 19 May 2022 10:26:07 +0200
X-MC-Unique: fulWZ2loOTWOJ_CghUzpMg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG85BMrtTBO6W06qrJ4klKevJ/6lMLCndycbespQ3tvXRymbZRZ59zZ60TW6/CeVV0MiP5LbyUrOqmnJq4BF4IxBNUOKJq7+wRubTrkkaCi1H0uSCCAcWo/MOIkIS6JS8/i97VMrhkkc2IPWBFTJWe1d9gfkUJQQZ9G3HvfTR8HDS3prDcj1+dyps+EhSM+7UrWpr5IuETiUItMueQM1cdaAwIx0JPPsc3GdPMdF5/pjWqfdvijUx5OOMfrR/pJEkrYe56EuJ95zjsxTj0ItcVqcfVL38WZx5ZyPg5z6Pw5Wi/PwxFy4Dv6At8cpfMUpdD5oZkdLDttINJ+QaADhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0DMObuDqhBnmp9GnxtaVVDhXzRPXx/uK0SQlwZG57A=;
 b=j+hfvxb/EIdrDWEGIr4Fp6wwQoa/IGJUjCD5GoXb7Smye8HBiFDHGqh8LpfGO4tlkh1HlZRj2Lsh9lZe7VGlI8ucmSJvndz8zDvkOl6rC6LQHKzFGWi7d8J7XlTH74Fz0m43ytCRwaeGEFjTwhS1b40wZzXBM9cJntqVa2Y///ytLErTKLwCx6WOcSUUiSa9DG1scGfcCtafcTN4LGrtTNTtd6WGSNOGWsUl9YPuwvlb4E6VKla2vx9dLL0IWSxZddVG1ifpPw1KxvqM7iHfDbJ4XfP0ixjzm75fYB40+zwD3tvRkt3ib0BYzAhRyTOPUckxerlrtoOr0IEs85HB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6652.eurprd04.prod.outlook.com (2603:10a6:10:109::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 08:26:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 08:26:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 6/7] selftests/bpf: verify ca_name of struct mptcp_sock
Date: Thu, 19 May 2022 16:25:17 +0800
Message-ID: <1e7c38a83f8072d038e13dd7ca0637fe92d4f366.1652948238.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652948238.git.geliang.tang@suse.com>
References: <cover.1652948238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0012.apcprd03.prod.outlook.com
 (2603:1096:202::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb47c1fa-c4e9-475b-55f0-08da3971372b
X-MS-TrafficTypeDiagnostic: DB8PR04MB6652:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB66520195DF587ACFA26B3142F8D09@DB8PR04MB6652.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rxsfynEBSguwqdvAz5bLMLvLFYIkppoCpQEFREgO3E5XZ1nfwG072cDGYCfYTnD8VuVE9TVeE55zURX3jECLoIYGgVwXBKaVYbzzQgoNROgEct8TQ5IhV1r/B5/K8EcLFhnjHRMaC3H9eLksZuRqhgSapzeYgKKr0JprG8wj2HJb0yp97uaBoPgaQcFPOCgNXij66skoRru/qPmqX5/J5wptC9P/M9nrQcL+CAsvOGo7MFTymNbitijbP62ajOhNgvQilLiIekXtjzbkEF0mGxOho4tu8FPrQWQfmcbVnRIxYliKs/DpP81HZuZydZHq6076MRRGxGCw64klGq7fa7TyV7NBqlhXGlKrUHF4YWMq0Bfe2n9mLoGPrBI9lFQK4KTDTzAOnch6YbLl8bg7+G7M8o8dOvdrDxeQfbWRxIBlA/OQ1LH9NQSRH9XBAtr3kmYFFtTJKSXuqo8ymZWQScxKcgvOkHLIb6TFcbucIfdEpteFzUNlSdhHghjrU3yexmTWOyqFo7/Q+ZqBnbPt74LedK7je+YI59Oi3KCMyfqYEx3giZtjcwTOLGva5+eb/HR6A1Yw70EsQ3iTz9czozs4HfSCQWmbYURz0cp3b7g6+hgMFk6mvUWjLtIOCGKw9sheHgk5OSqO7JL8U/7xSSVPzFGTvq5Ees2p/Bv6ssrd845I8+rISMISRZQSrHsg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2906002)(6666004)(38100700002)(186003)(6512007)(15650500001)(86362001)(316002)(6916009)(54906003)(8676002)(6486002)(2616005)(44832011)(66476007)(66556008)(36756003)(5660300002)(508600001)(6506007)(26005)(8936002)(66946007)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RwirtCmycnbKhbEamXieUJy4nTGSe632H64T1DLhztXruFPOnHRWKXjvxPnt?=
 =?us-ascii?Q?ehtIsAj2jY9klMGJbv7l59XCvaPJTMssiUUbd3b90pRTlFO/9WHNb8O5FMc4?=
 =?us-ascii?Q?iVwjNuyS2klYX9zxcA/htsBRg+61hVjZN4J/scIxugWctQOT3gn1MpkTv3hA?=
 =?us-ascii?Q?HzZ+mhjFWh0BQVwHdzJflcTp02zKeBAPN3L86MHqBVG34wpQIJuVUzmGDVBQ?=
 =?us-ascii?Q?Pdr0a6101J8V7DTObKjyzvunt0UeXZysIyj4Lz1zxand9Kxf8CL3fnragWA3?=
 =?us-ascii?Q?nDd84fmb3lJsVL2WdP74CXKoN5PRWvXrKkYsEWVhDpLZO8Aq4g3pbNOdNK3x?=
 =?us-ascii?Q?ub/oZTmMmwXVa0EeHoHVAysPyzYyyxDBsAgO/JQPeUX+CFKLXJhz6JcOZdG2?=
 =?us-ascii?Q?GHGsrm3co4k8l42djdrvoTRLNlJTcwAGe6vYBOKXioUi9K55E3wspQXf0un7?=
 =?us-ascii?Q?7c7ZRYfyVTfHX5NDy0fiYJ0ovQokcsF6YObGvKbh+iDhyu+QTXWz91nGe9iN?=
 =?us-ascii?Q?RyMxvLtpcE/RwSMfWrXP0LRHijsan2LjkGuNhLNAqYE+lbF71SkWsKKjzZZH?=
 =?us-ascii?Q?ta8uAQwNulX+3zOblWOBD5Uy0Mi4svqpVf2Lf5CHFyjclIkHGtFNGN8zqxlE?=
 =?us-ascii?Q?EEYVRjFUd9vmkoDTD8kxOLowZ1+rLkzkb4qKf6JSSAFL2NL0ntTkSNtzjHxH?=
 =?us-ascii?Q?Aee3nWf3/uqJCLLdeM5wU6D0YL3n5zu6/Dlmh/g6TxA1Y8y9bhPg9nRur65r?=
 =?us-ascii?Q?GW2y3y/+9pn2kHklN5SFNAC2qhOQoisQ8q5T1WABqKeOqDXfTvGVAIwHKl7G?=
 =?us-ascii?Q?0r/EJKrg+fJN0Ti48v9d+r53kA/3OxHrY0JHT30M6nnv+0kWu6sPjBmCm/vf?=
 =?us-ascii?Q?T83Iqk0v2K0R3UPs1UxH0xEqGc8mu+rdWObqbHuGFjS2QBIJIw8lroBVjWDL?=
 =?us-ascii?Q?1Gr1NCETKPPrKJ0P8MjYUlZBCPX3mSNk0auMfwr7qeWIFDF3u6iMXOsisecU?=
 =?us-ascii?Q?EGNicxlfivlGu634yb36XjVsiIb2QYjaq+e44LTLvZcLIGLXTH9qiQRi4zRB?=
 =?us-ascii?Q?BvyUKantBHRCPq+w27+QYBZ0SR416wWLvIjk3s/W8V3fN1C/fW6etK6LKZnW?=
 =?us-ascii?Q?tFklP2mV/mUYcgil8+jqbAa1I2g6cLvea6DY2eWoE0jajAYSO6a6HkNFKv7J?=
 =?us-ascii?Q?PIc/uVdnbxzg4VVhS7rdkwAOdzljGaEepr1ZK0e8sSWPBkH4K8IPkZ4sqr0f?=
 =?us-ascii?Q?1SGjWhYAhsQaB2oY5/VJFLkwKoCOqE0A4MScHA+oUvIR9LSwtOGNKYpe8veO?=
 =?us-ascii?Q?4ms0l5mRL6V2QuV2aI0djHQsAwiufB+TMFK7LasdkWOPs4uehagN2CAoebzZ?=
 =?us-ascii?Q?bRnE2TJ6xK+2fhE4p9Sau/FLA2IrbblUhvIObLZY8vdIcLzA88JWDsx0lp0g?=
 =?us-ascii?Q?GiZcDGFPae6XoIq0+kl3nzOWjSjhieLD443WmLILN+u4mPOAzjt6/Vh11/V/?=
 =?us-ascii?Q?lkbSrs4YNBl1bMSohiNRj6xSZn9F19aAdML9KEQwx/fGyMfYuEboBzRXIN71?=
 =?us-ascii?Q?/b+TReMBjexvPA8gcOtSmp5SN4YW31kbNXJ5zRqlBcmZlAeDgkgJiYxHx8/4?=
 =?us-ascii?Q?yX/ZaClP4c+8vSWFlUNd+BCWoylwZoUe4qghsIqkybAOkw6XepBWxIKbO6Es?=
 =?us-ascii?Q?iOdKn1mTKShojWxnxUrSLIb/cXBCLaCWAEjzDJzX/VrfdkEWAJ3YI0sDdXn2?=
 =?us-ascii?Q?gI31C4xL3QlzmwKYJ502tEJUz+6pGmM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb47c1fa-c4e9-475b-55f0-08da3971372b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 08:26:05.3989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjUkpJcr4mk4XPBkfzDiHe/HPOSFBbnju20WW1mz2lBfR2o0f8j0zvvkyourT9/nNl/Fwght1in1rMU+o6CdmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6652

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
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 31 +++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  4 +++
 3 files changed, 40 insertions(+)

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
index 138bcc80ab9e..17ad1cb07339 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,10 +7,15 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
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
 static int verify_tsk(int map_fd, int client_fd)
@@ -31,14 +36,37 @@ static int verify_tsk(int map_fd, int client_fd)
 	return err;
 }
=20
+void get_msk_ca_name(char ca_name[])
+{
+	size_t len;
+	int fd;
+
+	fd =3D open("/proc/sys/net/ipv4/tcp_congestion_control", O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "failed to open tcp_congestion_control"))
+		return;
+
+	len =3D read(fd, ca_name, TCP_CA_NAME_MAX);
+	if (!ASSERT_GT(len, 0, "failed to read ca_name"))
+		goto err;
+
+	if (len > 0 && ca_name[len - 1] =3D=3D '\n')
+		ca_name[len - 1] =3D '\0';
+
+err:
+	close(fd);
+}
+
 static int verify_msk(int map_fd, int client_fd, __u32 token)
 {
+	char ca_name[TCP_CA_NAME_MAX];
 	int err, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
 	if (!ASSERT_GT(token, 0, "invalid token"))
 		return -1;
=20
+	get_msk_ca_name(ca_name);
+
 	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
 	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
 		return err;
@@ -52,6 +80,9 @@ static int verify_msk(int map_fd, int client_fd, __u32 to=
ken)
 	if (!ASSERT_EQ(val.token, token, "unexpected token"))
 		err++;
=20
+	if (!ASSERT_STRNEQ(val.ca_name, ca_name, TCP_CA_NAME_MAX, "unexpected ca_=
name"))
+		err++;
+
 	return err;
 }
=20
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index f038b0e699a2..6a78e7b754a8 100644
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
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
@@ -62,6 +65,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
=20
 		storage->token =3D msk->token;
+		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D is_mptcp;
--=20
2.34.1

