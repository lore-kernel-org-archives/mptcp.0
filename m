Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A1322E
	for <mptcp@lists.linux.dev>; Sat, 26 Mar 2022 16:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648311904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1EaMLIu5lwEbnkHkNepVmgxpOOR5gMbW+DwPNUFRwA=;
	b=jdXd4RFB626thvKaCNV8lX1vebfuE0CpHAJdxtCHOigtqzioaDNgvpzn0TDMN73jqYQbQ0
	6pYHRNKuHXkQvdYQTAzFLIndL15fBctKUopQOn2afs3aCeclC2fUwUMTtRZ4Ny5kzhqXRl
	gTC40draTh9MXv6uTdiRXf4lW44rOqY=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-JqX4TTRXMUGXU5SH83qnNw-1; Sat, 26 Mar 2022 17:25:03 +0100
X-MC-Unique: JqX4TTRXMUGXU5SH83qnNw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7BNxcRSgNmL25maK4E6ImJx7M1VGFW320RoK8WYz/Cfd0ghPfdLGMdwBFYED1e8JG2uK/BQsHIq6vuw0BCsJCVGYnQyqARof9U1FcJs5qJi+5387M85o6cGwwXjBfZNkk2HtBkvRUisV6HUzZhry2682VKXi3g34cWJtcOu+3HRT/R7D+P1Lydi7LHynyTvho90jptuunGxBkU40kTaBAzZq8QhLdlwSnk7tRRRKKNTrYsrfjo2i8H0SfdK4dj5lVE4G0CCYDsT5T4NsVqMN2/krUw82GQUqS70WZzK4vaHdNQm7zOBrk3BVK+E1mB4OlD5QdPgX9BWvcohxB7Gkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMkoJakN9o4vWWLxjCeHTpRI4RPIUMsPrFR2xNf5yOc=;
 b=KQlgSKvHLFsTuXIcRzEHhAXdggOP564f/HS8+NZW4GQ+NzFKIrky9P/+3V1nzyylvrG2H5zgoVTfUbzr1l1S/2VNWHD6BZqPqB5So+2jHOjpqRZ9O1ECTsQoAZFPeHDGllHeHgNi2mlOdlT61s1Jd+92UtL2h3+I5qaNc6w7ji2NgDD2OPkkIDJnMZOm49p8QWtvUcSGcjXAX0BtS3yM1cqUOAhbmhLsyTwM2ck/LZS2fmXQ7XJWtRtFzJxoBztgwTLjq8WAAWYn2cJ8b2rzUxa9z8xj3h4Xv+ktUsO2Qz5C7HQdWKQDvTrlEIH/rypP8IeMfdIulcIlp4meww9+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3067.eurprd04.prod.outlook.com (2603:10a6:7:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sat, 26 Mar
 2022 16:25:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Sat, 26 Mar 2022
 16:25:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 5/6] selftests: bpf: verify ca_name of struct mptcp_sock
Date: Sun, 27 Mar 2022 00:24:32 +0800
Message-ID: <ae5158ca929a39b4a6d2cadf1872c4d89ba499b1.1648311457.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648311457.git.geliang.tang@suse.com>
References: <cover.1648311457.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0196.apcprd02.prod.outlook.com
 (2603:1096:201:21::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ae5079e-9877-41f7-1049-08da0f452dec
X-MS-TrafficTypeDiagnostic: HE1PR04MB3067:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3067AB28889F220A798E90AFF81B9@HE1PR04MB3067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c8knFQ9ILpsR6F8b+9uIdoedz1OU7ICSFpwWqG5hiMFA5UQ/Od4AHrSBBA/WWou7QP2P5uYfOkHtyMHh89ooXvc8IbrC2HL6I4O2frOAdRagwi2cbrUwXbfnhrXxswRP3ENSRF8GJkoOhY6I0FLWP8nIqxKHWwtGsVR+hPReAZ5pIV09dh23UuR2wF6Hu77FyiaUU9QMaYRqu4dDgfYDC20ZzgR5+5jpJcF+D1ZCbjhqrx6aBrMYBpB71qVI1Rrjh6/aILhmKka6J8F0ntxll8SBzu/SVEzMAbRkaPGsHQZp7nsRLDN3mAs2fbj5Lh7nEn0mCrR2AXdPDLn3P28j4c7VnUpU9pJqXJvyFLwgV51Zla+8wexdn/FAfc6D6a+1TDaqQLuftJgLBUXTHBIyAcEyjbEsXDFHHeTw68qyXR+XBOSN7ROZ+6Vgq62GtEWZNslO/rsQ06OZqQerBxudZsTqdokVQh4W4dhe0S/TlnDJg31oDvWD49soLH0KNJYURccYem6CJVRxa6FUlavvvRKtI5QgRVGUt/LeeFuq1eH9WO7QiaRiww+IugX+1BtuEZBjKNKTOI7/GsnzXOWYp3SuPxtlAgS5/UM9aJ9olVgy7o7SCNXKjKwFAtgnYOb4j5O0nYMgUNjPbUhmTD8lLq+Bi3Qe8peAb5Eyezk3VfYIqkNTfhtc8FFpF18M7C8rHIAMm0ae4dGeYSI3BHSfDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(66476007)(186003)(107886003)(15650500001)(6512007)(4326008)(8676002)(38100700002)(86362001)(26005)(6506007)(66556008)(8936002)(6916009)(44832011)(36756003)(508600001)(6486002)(83380400001)(6666004)(2616005)(2906002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6MmN/qqTGFlne8r0l/VJhcPwGzzrj89V84NkmsFOJYOtPBhyom15yGKupN6I?=
 =?us-ascii?Q?qEw6vCBU6GQp5gN/Y1ulLSo4j+8ihJQY109l7fu9l7epvdVR1dM30KcN9oqA?=
 =?us-ascii?Q?1hWMBZtlNhTkRZLNyQoa9i9JNOAdDpI7I5WRRU9u4Ck4oMkEgvG31/cK9tRR?=
 =?us-ascii?Q?WlwDOjaZp2k0BbAw+MJCJ0FCqg2fbf1/dUhjKDjZ8vfdcHXy3KNXkPunjQWi?=
 =?us-ascii?Q?a4psYiZYywE85rI7dojtdmDFotWNwpVfduKabK6MOjMh5TeyE5CStgzv0A+B?=
 =?us-ascii?Q?i/ktwfYlSKtxQozhJRZqOtmk+UdlyNVVlFKXgr4/Uz4z2vI9asLASSzWvqc9?=
 =?us-ascii?Q?KSyBMm2c6nDBfRkzcvWZjyUGkDxH5SCy5c/VpM/qxJKK83BKlNSdxjk+J16y?=
 =?us-ascii?Q?rI6LMRGr0AWsvmpagdC1A8Afkv2xlksWCzoGMUJ04CjHiY6fSTTVHcXLjIgm?=
 =?us-ascii?Q?ZlsCbiE3EKMMEMTDvs9on/BWQic7UFmIMw6KeyrjX1lXzSvt+09LP4oHz0Pv?=
 =?us-ascii?Q?dp1A3kXDsptKX5x8QSrm+nYx6cR+fsuP5tiqaqeA5a367f8iooPUSUBfJb7A?=
 =?us-ascii?Q?djY0+cEsziAC7ZpF3WEDgKVFY/39JjnPQz8kx36Celw3oSP50IhMr8kjDI1y?=
 =?us-ascii?Q?jiYCPmdyT4Rb8TmTlO/Ur6PvZ6+k+bfUp5nTEM7omTF512f9BbfO/1YhEAeT?=
 =?us-ascii?Q?DTVOCWo+G4RQ3Mg3igkxE9JMbIX08tNda+OrDCnJJnlqhT0IC3uok7z/7wOy?=
 =?us-ascii?Q?pLew2OKoi+LtmnOLyDDrunDnFJPQkEyQq8hrxdQf+se+UL9MFJ8Q3c2Ydy4w?=
 =?us-ascii?Q?A1Q2oBOsxOt0lnUVndYzZZxIrJsYb1WQSy4DhnjrgqhyY5wsO800RysjxbHf?=
 =?us-ascii?Q?3A70lTXn77+VMcnagaSQ8omV8iNb3wk6OJEk4ytOhqddJrtYVMjU4YON05vF?=
 =?us-ascii?Q?8lIlOdOdtnbOerOpXwrRzFBr/mbanj8eGPYw8aUCj1WSTAVjiuVyp6lmVqjd?=
 =?us-ascii?Q?drzaMESZrt5wbPT8WudVsrk5zgz37PWxdPyT+I02P36mBP+MTfmOfylFT1jk?=
 =?us-ascii?Q?3IXyIlW6XoXtwoW03hOGIV4BpKQjp1howUU4k/W/sbeGTb97/gp0eU9VlguK?=
 =?us-ascii?Q?TJdcQ8DpEsreFIjn77nNQP/OQaawKE5PDQQL5uJBsSJ8MX2eYY83Al6m2XyS?=
 =?us-ascii?Q?tEf+XlxkWzuZvJiSiCU3jXjDfONx4h4McM28hZ4b36fyYxzfxu6OPeV9DoQX?=
 =?us-ascii?Q?Yw34QCSgkzUgMgElzs8lkdDM6XnBu2Vl3fBMpDhTPgGG3lyrrSz+Use48HmK?=
 =?us-ascii?Q?OaFq0YHSSTcgbGpUAWlNcV+lCdH/6hOHY0hWPXpNfo6U70SKQY4j/olINIi4?=
 =?us-ascii?Q?Z5tnXNDtHurEF8KwxllBPgSjAPTivko7Z2HXAWmoFZ8ThbMmDx1nYh3FI8Zq?=
 =?us-ascii?Q?KHJk4dGkdnsY3CksReJ7g7ll2dM8QXmjJiZbMFNUfSFvTwneDUOcCg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae5079e-9877-41f7-1049-08da0f452dec
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 16:25:02.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0+Aun0tI0GXVc6IaHUEOEusWYnUDaUnDBN8W5BBOB0B+JhD5pjRxacoCXURG2IbcBevH8XpNdjFddXEKxG4EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3067

This patch verifies another member of struct mptcp_sock, ca_name. Add a
new function get_msk_ca_name() to read the sysctl tcp_congestion_control
and verify it in verify_msk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 24 +++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  4 ++++
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
index c5d96ba81e04..c6bdd9c5f126 100644
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
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index afacea5ad9ca..6e7d2abf6ce3 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
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

