Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5421852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0wyAiqJrxbsrOzQZkOW8J9DDbOtPs1v+mOWtujL1zzM=;
	b=B5TiwZKwkDiAeuJQcdmUvs5i01NdLl+ddYJ+/BFnl8zG+Za/2zcAJ2PfocX1cLwQd9Iq2p
	41XeggfIyVSsaQCHZZt6YdZ6wIHdb36rsvJulkYUbBDWTi7xiOuRBXBJXrBmxpaVn/6ZRM
	qmYipaS1/TU1KswxyyURYHN4SyHVBVU=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2176.outbound.protection.outlook.com [104.47.51.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-Jfh8NfL0OtC7AuGoDdsQtw-1; Wed, 18 May 2022 08:12:06 +0200
X-MC-Unique: Jfh8NfL0OtC7AuGoDdsQtw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8DsDgZoqfyVlliAgm3rUKM0Gz7QkOLNYmXrCpUFtsR5cwf9yPhBEpGPYx6lkWwMsnQMFgs4tpOd5AQODbwJZj19BW0jeyBT5FktIn/i9M/LsVpA7iDPAXNqoJCWFXZUYbh1ILcLnsUaHtIFAFk/RwoWzvvmw3F6kgqEetiShApbspLiF7oJ7AjbvLr1C5grhR5w27juGvUAdQeOV32+DrSiSDCsL2WRyYpPTsUuef+Kf2TJvt03W7z9i/UML4PWCJuxlFEVh1eSt5EWA5aJigeUaFRhixmKUH6TKEMrtE4U300HfL44C2iW/sRN6e5Mo3m9lrKwlsT5lFpw6b4jpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0DMObuDqhBnmp9GnxtaVVDhXzRPXx/uK0SQlwZG57A=;
 b=fhy5cSTRfYu/pHiSdzGkjfufnDmcV2/pUPBHDXUS/R4q4D5Ooe9l20tGPxww87ep2GX5TPSg+qU3g0zm0ZW8L4p9wSyTMli4/MZYrSwcU7sApCQvH6ytiaun+KUOspwaI3/S17yYmxJA86ahvEv12c4P/8+MykcOqUxH/x2Eyj0tA3LH71caTIxQW3oSScSCiL81pfEj66QGTVhydPZTgKSnaG6e0giK7rZbLF41aJkPNrOy9MT2CdSh9s6sX+ZQySZ8Xg33sMMD2/beykzTjgNF2cDNfwxTFjlZytQxVH6zHq376jUbYm1Wt8MA+0rs3QWp82XupQsSUCiLXoPQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2584.eurprd04.prod.outlook.com (2603:10a6:4:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:12:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:12:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 09/17] selftests/bpf: verify ca_name of struct mptcp_sock
Date: Wed, 18 May 2022 14:10:47 +0800
Message-ID: <faacbdad4a6e7cef25758b5e77bc439548bb171d.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 104eaa3f-2b29-4fc1-01ca-08da3895543e
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2584:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB258478B0C570D578F23B03A7F8D19@DB6PR0401MB2584.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cCJVnKMvQu4w2bYyesZSwMVVcXcx7SY9rTQniiBo1ypeUAwlxDHn15lIW8/y4BRyxsqHknDIz3Yj+zuI5TLNRX8xlLrZHDxHk6Xi5dltdsgDqfxRYdLV4Bd915IQgiWsky7lCEpXilhIaYSxMn9blF814YQ0gKJ23pbn+amDjC1TBEJQyTTYWgHN81+ndbofOF9pnn3/jDDCcfFZbe7IrWrdhv96m6agTMSgRJXGlV/nFjxKxQO5ybQ1yotxAcZf6idESvlyeljsAhITjlyLy04MFp1MQNdxIhviGFIqo1qcibENHHSABnfjuMByJYA1InhLxYdDmM2KxEijLqD1HTKMdqNGzFCouxD6ETXFSKTZXfg0PCxrgYsNXsuypp7rGvZHIIb9jpk4iZl1CexKkWpZVXKsCFUzcSSh0qdgtjzQfb5B51h4NVaGJhfldyc8K6uBN5klim/qaPEKHgY+X3Ev66IUTQGTulHPBJizzBiZvIkN4agb+i0zJ/euvNLFPdOdO+IrJVkiL0IAUFFY3lbtfSxUsaRscwRHph3pkxny9JBWulZ2y3/9LRleNhxLxS8Z18QpOeKSPgb+8Dtu6jthhhEJlBi2O3YHnE7k/C+v+vixokVPaUIDZjffaUUFZa55AzAcYbZOwZ1AAgRB8+oRWPbz7bOsmogEQJaj6jY430/9IcQegark6Wp/TM+b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(66476007)(36756003)(44832011)(2906002)(8676002)(4326008)(6666004)(38100700002)(86362001)(2616005)(5660300002)(6486002)(66946007)(83380400001)(186003)(6506007)(6916009)(54906003)(6512007)(15650500001)(508600001)(8936002)(66556008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LzAnjdt/YbSRYRGGmPJshbTrVKZQzTAhCstD5SptDo8LXVbHt46ZSyVca6Yf?=
 =?us-ascii?Q?p2RIv/95vcf/dpLnDoH3wNeIGx+3nLgnnoL+ZkBq1SslXxfmI3/Is/OTxvkI?=
 =?us-ascii?Q?9bLiWWE2WmfWsvAaO83f2lOIhObTumu2UwyBs0IFmaEqsp/oC+5ih08KErTK?=
 =?us-ascii?Q?mAbaAr5iP8+HF0TA3NAO46H++YeSYJ2Fip1G+z3d0t8v8J8cUscICK8VR9Pw?=
 =?us-ascii?Q?pz/f9jul3AT0EUngfggg+2A2Al+dPPHwj539i/sZnLcZ9BTfgjzu+JU3fKiZ?=
 =?us-ascii?Q?hk3kYinUUtncSwgBhUCDCT9pU5NRIkeM9t7dDBwHTCzGoJD4RKlAv1czdMGQ?=
 =?us-ascii?Q?xPVwUt3KY6Tsx2Q/RZWdLKsKZgQqOnq+TAk3X3cmc4rbj4aimg2x8KINYYuZ?=
 =?us-ascii?Q?Cv/YcBWDOSpUejA/o35BnD6OMCi/kwRTldlypYH1Qdaz9/rXY1nWJ6RAGFhw?=
 =?us-ascii?Q?8OUeVDF3IRnMvfarTGgK3waXS70wct0ZkmwMLaEcj+9MQYWfatKDN8ldT8uT?=
 =?us-ascii?Q?bRZOzwnxoHITeMMYVp9TNMdn8XDZ49qpQRIhjUFyEMhPB9j2nphP+0Cgh/2b?=
 =?us-ascii?Q?VRzyoe2sxp9uR+d2fmGbwi5i3zmObNuyWsWUzw4gd6rTnq5N2NfC14hYTCty?=
 =?us-ascii?Q?moBWkjNotWxr2iXviwuwmdID24XbxycVRYy+ZGDHUoqSi9lQFzDINF6l7ozE?=
 =?us-ascii?Q?3QMi02/haWjjpBUshMcxtJRyClMfs59T0mA0P4Q4q1F4WWk7+CRc152JK7GD?=
 =?us-ascii?Q?jZCbIoioh6wNQT/5Q3oOV358IzKmZkUi4W3/if7/gjBgYPW79yg3Gy8J1NPf?=
 =?us-ascii?Q?gPH+CGKdmVcPUlWMuoq2B1SVccw4uqbVxyqdmrmrRFy2q5Fk5SIiJIac/UXu?=
 =?us-ascii?Q?TzJqWbEIu6ngQc7C93BOQFjJQQ/kQX8nw3VSdzgqhRK3v07Z0IKJRJowZT8a?=
 =?us-ascii?Q?/Eq83vh4rXPoDUqmAZqytA29Ly0gmDB5g8U7yr3Zc9CviJDfCOfyHIz4xKsT?=
 =?us-ascii?Q?YrXyq94ALRJSfEaS95cyzjTg3HH4g6TWRRhkPo9CCQvz7/Zisw+QZMoRBHw3?=
 =?us-ascii?Q?uX1BOJXo/zFRwiFpfMOiwyImyOUqpbBJyfRMWQiI30s3XQh7Z5gNLIOR/GFX?=
 =?us-ascii?Q?cKLeXDaJt1ex8HtSNU59K13GoA3zYG9ynV6P2RiUNJkEFwQtA3hsGoYCeit0?=
 =?us-ascii?Q?td3FvuOV+9nkjEJ4K2AN5jRdQjSPVvQu25QJ0gUQZD54QvrqhN5hHniPxCa8?=
 =?us-ascii?Q?rQogjycI9rGzMb5+/FJZnphzms32BK0WR/kauKG5wVQn+Sw9NEcIm2g0DHhI?=
 =?us-ascii?Q?q8quRkzWAHK70nuJF+vmkVHcD2NAi0EwK97L8TjNlxricNxgC2/8viJDv9vR?=
 =?us-ascii?Q?3qJR6xG18oX7FzmyORZ05X9AidL5QVtVrt0/DoQL5EUne/0D1CClE3Orqym4?=
 =?us-ascii?Q?6MtQW1yp0YwogzPZ8ZXebJ2+dpx7GJeEC85JTRRe6GVlBsT5O3EuffTEcG3u?=
 =?us-ascii?Q?9mSIb2NE4bECYFrWnzqowMbWtc/+7WD9joeWI8IFYtkMtIK+SI3rS2XuWAuI?=
 =?us-ascii?Q?ORPevOoN38a/RHJO3N7Wqwl5MrkpNWUi6yxgiXMr7qUtxo3rn0FQhGKmK0OJ?=
 =?us-ascii?Q?dgCnevM3Pd1MBWJ0nWCcE1gFdLcS0maMq2vtKzBu8rchQ8zatIfmtOa9TdRt?=
 =?us-ascii?Q?LWDdWolvJGa7GAaRIeXd09RXJzBhFD5WsPxc3Q678qa3YXrXiX8SpPsgjHHg?=
 =?us-ascii?Q?15uEPrCWp7xsdstqRZtizHQXlY+haQI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104eaa3f-2b29-4fc1-01ca-08da3895543e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:12:04.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VY0Sr3dBaqUxRCkfNegnbcR3pwjnxeAYot2/rppryd4Cn1qHArLG+ZN86S5UiRRQo+MFIBAab/EJgq/+XV5Qwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2584

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

