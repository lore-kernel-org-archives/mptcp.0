Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA24015B4
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652240400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3pqgR/e0EliKT9OR7AcAjI835k8x+k35FWH4SeX8eM=;
	b=Bh9OXfRdimnVt1Tw6Y7sCiCXEcTgZc97c8rvO3PmxB+67XwDLN9O7qPPp+Hs7rrM9Smes6
	Uf24Md2fyz6796A8lRZg8nD5+6imJC742c3bHlKqltTnZYm8e+wZr9+Vm+47FVR7SbmkDp
	zq43rbm1odQHvNoV5bM0sMiCNQ5V/aw=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-0wwNemcdM2GvZoLNqjp17Q-1; Wed, 11 May 2022 05:39:59 +0200
X-MC-Unique: 0wwNemcdM2GvZoLNqjp17Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm7wT3mhjsj+6K3av0UTaNKFzBPpZpfaP64aHZ+ZZ9uudUQfVXVRkX6olxJ8jie4bbJSXEAYmQW3Npl0fAWjDHKSCVKvKI0WDG83G+QZbRwQ7PKXhPRdT9D0P22BvQd9cNpfp3JAOGFG7WolISuorx+EvKd1hoZFeQx3006uInHQIgBJI5yzuGnZbsQfDDO+//ukDmx19YXyWiNC62W0/5e1dCewdCzI+s5p4xXnzPHZjTqMr4YXLi6ER/wIquXnGad3O+PP6Pf80Ws6NxiNjn3B/k22PwG1o6W/lpnvBHR4ONiUlwhTe7ahCzuiSRU35KTvg2KfeTMaJUwZWxogrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUVtfW5pKHs3YYHsZbCFTXMBzVVkzqTFj34qWuqC1Kk=;
 b=epUZVH0lteGLZ/bwHN+NARAa/7bz0VdmB5J8c/4cVbE1pfbFf70fjqdcH1ZEZyjNRi40qxQsSVTjvM6wSaqCt43XHZZvR8sXxh4w8f3+S+zk4mkNi31+FUZyLfk81waJU+6mJEX84ziwuO5IXH1M0vjPseS/8z+i9JCUT7WVK7Dhy/DjSik5GNIaG7LnxQEmebb2VCJDOQcA6w+eXq3xryCUF6doiArdYqyXx6VtYi26bRvi7Gud/ez+S/A5XMqwRgje+mXHtpgyjJLLBClBUWtZ21YTrIP38ZopSCrK8iwvulyVtvjxNMmU/XkkQ2m0+jG1OjC6vKv1PysWiykXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 03:39:58 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:39:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 04/15] selftests/bpf: add MPTCP test base
Date: Wed, 11 May 2022 11:39:05 +0800
Message-ID: <c5c0dedab1946e4379060df570d288a716d72b40.1652239604.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652239604.git.geliang.tang@suse.com>
References: <cover.1652239604.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0170.apcprd02.prod.outlook.com
 (2603:1096:201:1f::30) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c1297ee-c0bb-43ba-116e-08da32ffebdd
X-MS-TrafficTypeDiagnostic: AM0PR04MB7156:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB715668D3E6036E4B0D77D5B8F8C89@AM0PR04MB7156.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kF/yi5S96GdeOPZ1E48Lf5cQ1HMDr2RQ2RYDNtf675CcU6srPsCEbnRCGYe56AaH2+7rh4965bUWAMuYtVEkR+CR6bm5oaLqd6Z8qkPRZ8zF5GuN5mCby63JqtzOuIRddI1cmx7OEcZMJCCJlAU32ER5dVWk/AyXHRFTV7A18vx8XBoP/6c3Gpd1VzIFcaLCcu3eTU1+gPNGu1Xfo9sFNee849QyDLoTUMLHy5HCU9e0iCL7VZL8j5nx2+HFX2Ct/xGR+9FQEBNmuoQGkpmz4u1eElXzCRvgVEyzqZ8DOlIW8YuPV50JMQVFTmC1k4Klpzcoy3EOfbxqnZ8rK9yWX9x5j/80Cre2Mr8A6EwOijnEx0kCRSQb1eJA3OdVGNHJkzZpP2n+fAlfVnnputFXQFKgU1yLzgr5XuUXM7YSGgj1AgimN5TpNCKKhR2IY5eCsqgcwqDncNvvaRnYaoE6j95IysjIkEIXFANkm2wtAYJasaSTiEwrMqHHDtxoMWIDX3P//9j+sfzASTF1h1B3K05wM0/aFOdfXZfIBQd5PVSDkkjHzHPwXwsT0wTOqkQQRiMnx72UPT43la7JAe/WnrZqxPfj7KLC88b/ic5x4lMO7XkWKMRZ7ybTCrfMEPEAY4DdshnsoceY8ZQsYshvAgKr3W/QK30WR2YQJOu0VU3B0OhPh8is974PVMroHA90
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(86362001)(5660300002)(107886003)(4326008)(2616005)(6486002)(66476007)(8676002)(8936002)(6506007)(66556008)(38100700002)(6916009)(6666004)(66946007)(54906003)(316002)(508600001)(36756003)(2906002)(44832011)(83380400001)(30864003)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?veJIt8XJoVc2hzkd/DZlAb3etypciCAzvFQawzyZXEA54JAXcZQONWsXOd/Z?=
 =?us-ascii?Q?1tz2d67ksmJCgAXqRGEIfAip6nFkpdQGWzs91ii0zTqrdJj/+wJSAFGlG2xA?=
 =?us-ascii?Q?U/J+p6+mX+lnZquMPfddYuvrvJxwoiHj3OWSAQJcGGzyTg7GYPRIWw9yKvWy?=
 =?us-ascii?Q?TNh4k5X6azi7sVKOfEX4u6ImcYKrOI8IULpvJSbi/fjYm8uhVgRo9FOJ0JU2?=
 =?us-ascii?Q?gmRLFQYlMn+bPLcj8R4tkn5Gu9zgp5atjremCoWfMoOMQnQhTz6wXdwoF/xj?=
 =?us-ascii?Q?ZpYZcm8Vc34U1CNx1gr8i1RyA/D7cTm2kKVRzCG2rLrzlKocu5szrHg9O4xF?=
 =?us-ascii?Q?VVx472440z6n4Qsy7m/YogTmFAYw/KK3ejtGk4yNw4vlijoUOBtuRg33chKl?=
 =?us-ascii?Q?HXlraGccNcUggSayBaDHj3T/UK2peM9NYPwBTSt9mvtiy8gSyKko7XU12SvT?=
 =?us-ascii?Q?TejcvEMGDyn81m/vr3EQNA5D19hx1KTsmfU4b1HyiijDtT9/szDVU+iqh2yK?=
 =?us-ascii?Q?S2BA2KFBmeMLtX/AQrU3F7hz+73zTylTKM8i7AXULbCRW54IdguEmFsfZrIJ?=
 =?us-ascii?Q?bkOTyUi7EsIG2njnDrQGQSg9VsGAaWCiI2AyOnWdwOHVZlKdezwJI1HTxgPm?=
 =?us-ascii?Q?0v/Z0MFneUcPA+zdtD4ozPgl8c5EdTr5IjPu6MyhbVwf4ocJRhoyIJSaam90?=
 =?us-ascii?Q?v3zse5v37CZFZYs+R/nzf1EuXlvAhOu27sMXOchY7VJQ7s8pn/tHq8aQBxci?=
 =?us-ascii?Q?2ufJA44B1UvCTyOKI2yxfxZKYqsjYl3UFW+RGtNDz26alIZ+pltWseBDwbyn?=
 =?us-ascii?Q?BtR+H0t6+O07cTBSCT0pStei7svH/320uQYPk1kdZ4eE4TsG0uViTHsoEu1C?=
 =?us-ascii?Q?Vk+5T9+MaMsfuQXg+84GOVc1c6b8TOnG30nrRxUc8QA+WQ+JQoio/qze569V?=
 =?us-ascii?Q?faDFh8YxXd+g3MXBqD/LRqK4UDpoALQRuAvB7wRCy7qhczO4CL+LJ4nOXvlY?=
 =?us-ascii?Q?cVdLACjbrijEcfEOb2byyBmvskr1E4IpDe5m45n5EBIiG2iifQ8VT8bV9H3W?=
 =?us-ascii?Q?d/x+vJM9W9AEDc5iCEJtI1gKE8CHArCHHC+pjJExifD8XO587OU8nSk46RIo?=
 =?us-ascii?Q?CAyZdzYdqGBdAzOWmpKNBo/L1y9559kRYogbotbgBXLAZeuWMha1R7txiU5+?=
 =?us-ascii?Q?GN0oZjHNi33+QE/YEbFGjO4+wHAMErtopLxIRZHqDWHTOs810Ulf7wwXV4Qa?=
 =?us-ascii?Q?xWV5vVXkmrT1qQ3FMi8mNykCoYy4rQF7A6J2gT6Mw2tfJB0c6AISlFGc/Rl7?=
 =?us-ascii?Q?YHPLDIui19KZnok+yHbWZDHlzB40Jorh9EzBEToMybdAo46jzPPgkWa22orP?=
 =?us-ascii?Q?VLyBW271KJo7kqBSZW+NzuppdP4JoGBIlNynMGU+KXrvrBnFlrcHU1L5CNSO?=
 =?us-ascii?Q?yih+Uu3+6OtxVj/Zmi6FTPh3FbqnCAgCxnYIe95RUjJszRrLFpSqWXAUtBz+?=
 =?us-ascii?Q?JEDDDZI8h3Oz2dJzvwe2H6RGIctICkzsKw7T6gJ6KmieHcN4/SOfKzC1kPl3?=
 =?us-ascii?Q?e73QXCRnSMqTFTOKRr0ydYr7P82gYnQerwCwjUaDuXcuKxAL7fqyVU1itVW/?=
 =?us-ascii?Q?5/nOxPop2TLSU5tWImEVDM5A+G/nc3C0D2wrXWfXw+nxiS/sb4AyiMMSaPyo?=
 =?us-ascii?Q?l/eUq4T/KAIGJrhBMQbfMDmKIGRjtuAUw12zN9z5CmYOUOqvAEHc8xr7SEJT?=
 =?us-ascii?Q?6R2TmujwKGB/dpa51CvmR0g1xIyLbWE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1297ee-c0bb-43ba-116e-08da32ffebdd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 03:39:58.3091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ETAVk41P/CvbTceCH2ZXvuflyN6OSiFe6XksL39s6YO1VK1yFJuIMrfOvQXwaLqQ7O3tF9BANJkOOI0b5682g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

From: Nicolas Rybowski <nicolas.rybowski@tessares.net>

This patch adds a base for MPTCP specific tests.

It is currently limited to the is_mptcp field in case of plain TCP
connection because there is no easy way to get the subflow sk from a msk
in userspace. This implies that we cannot lookup the sk_storage attached
to the subflow sk in the sockops program.

v4:
 - add copyright 2022 (Andrii)
 - use ASSERT_* instead of CHECK_FAIL (Andrii)
 - drop SEC("version") (Andrii)

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Co-developed-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/network_helpers.c |  43 ++++--
 tools/testing/selftests/bpf/network_helpers.h |   4 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 136 ++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  50 +++++++
 6 files changed, 227 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ea12c2b53f3..fe03a22d7fe1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13798,6 +13798,7 @@ F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp.h
 F:	net/mptcp/
+F:	tools/testing/selftests/bpf/*/*mptcp*.c
 F:	tools/testing/selftests/net/mptcp/
=20
 NETWORKING [TCP]
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/b=
pf/config
index 8d7faff33c54..a25e15d55918 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -55,3 +55,4 @@ CONFIG_NF_CONNTRACK=3Dy
 CONFIG_USERFAULTFD=3Dy
 CONFIG_IKCONFIG=3Dy
 CONFIG_IKCONFIG_PROC=3Dy
+CONFIG_MPTCP=3Dy
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/=
selftests/bpf/network_helpers.c
index 2bb1f9b3841d..c9a2e39e34fc 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -21,6 +21,10 @@
 #include "network_helpers.h"
 #include "test_progs.h"
=20
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 #define clean_errno() (errno =3D=3D 0 ? "None" : strerror(errno))
 #define log_err(MSG, ...) ({						\
 			int __save =3D errno;				\
@@ -73,13 +77,13 @@ int settimeo(int fd, int timeout_ms)
=20
 #define save_errno_close(fd) ({ int __save =3D errno; close(fd); errno =3D=
 __save; })
=20
-static int __start_server(int type, const struct sockaddr *addr,
+static int __start_server(int type, int protocol, const struct sockaddr *a=
ddr,
 			  socklen_t addrlen, int timeout_ms, bool reuseport)
 {
 	int on =3D 1;
 	int fd;
=20
-	fd =3D socket(addr->sa_family, type, 0);
+	fd =3D socket(addr->sa_family, type, protocol);
 	if (fd < 0) {
 		log_err("Failed to create server socket");
 		return -1;
@@ -113,8 +117,8 @@ static int __start_server(int type, const struct sockad=
dr *addr,
 	return -1;
 }
=20
-int start_server(int family, int type, const char *addr_str, __u16 port,
-		 int timeout_ms)
+static int start_server_proto(int family, int type, int protocol,
+			      const char *addr_str, __u16 port, int timeout_ms)
 {
 	struct sockaddr_storage addr;
 	socklen_t addrlen;
@@ -122,10 +126,23 @@ int start_server(int family, int type, const char *ad=
dr_str, __u16 port,
 	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
 		return -1;
=20
-	return __start_server(type, (struct sockaddr *)&addr,
+	return __start_server(type, protocol, (struct sockaddr *)&addr,
 			      addrlen, timeout_ms, false);
 }
=20
+int start_server(int family, int type, const char *addr_str, __u16 port,
+		 int timeout_ms)
+{
+	return start_server_proto(family, type, 0, addr_str, port, timeout_ms);
+}
+
+int start_mptcp_server(int family, const char *addr_str, __u16 port,
+		       int timeout_ms)
+{
+	return start_server_proto(family, SOCK_STREAM, IPPROTO_MPTCP, addr_str,
+				  port, timeout_ms);
+}
+
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms, unsigned int nr_listens)
 {
@@ -144,7 +161,7 @@ int *start_reuseport_server(int family, int type, const=
 char *addr_str,
 	if (!fds)
 		return NULL;
=20
-	fds[0] =3D __start_server(type, (struct sockaddr *)&addr, addrlen,
+	fds[0] =3D __start_server(type, 0, (struct sockaddr *)&addr, addrlen,
 				timeout_ms, true);
 	if (fds[0] =3D=3D -1)
 		goto close_fds;
@@ -154,7 +171,7 @@ int *start_reuseport_server(int family, int type, const=
 char *addr_str,
 		goto close_fds;
=20
 	for (; nr_fds < nr_listens; nr_fds++) {
-		fds[nr_fds] =3D __start_server(type, (struct sockaddr *)&addr,
+		fds[nr_fds] =3D __start_server(type, 0, (struct sockaddr *)&addr,
 					     addrlen, timeout_ms, true);
 		if (fds[nr_fds] =3D=3D -1)
 			goto close_fds;
@@ -265,7 +282,7 @@ int connect_to_fd_opts(int server_fd, const struct netw=
ork_helper_opts *opts)
 	}
=20
 	addr_in =3D (struct sockaddr_in *)&addr;
-	fd =3D socket(addr_in->sin_family, type, 0);
+	fd =3D socket(addr_in->sin_family, type, opts->protocol);
 	if (fd < 0) {
 		log_err("Failed to create client socket");
 		return -1;
@@ -298,6 +315,16 @@ int connect_to_fd(int server_fd, int timeout_ms)
 	return connect_to_fd_opts(server_fd, &opts);
 }
=20
+int connect_to_mptcp_fd(int server_fd, int timeout_ms)
+{
+	struct network_helper_opts opts =3D {
+		.timeout_ms =3D timeout_ms,
+		.protocol =3D IPPROTO_MPTCP,
+	};
+
+	return connect_to_fd_opts(server_fd, &opts);
+}
+
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
 {
 	struct sockaddr_storage addr;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/=
selftests/bpf/network_helpers.h
index a4b3b2f9877b..e0feb115b2ae 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -21,6 +21,7 @@ struct network_helper_opts {
 	const char *cc;
 	int timeout_ms;
 	bool must_fail;
+	int protocol;
 };
=20
 /* ipv4 test vector */
@@ -42,11 +43,14 @@ extern struct ipv6_packet pkt_v6;
 int settimeo(int fd, int timeout_ms);
 int start_server(int family, int type, const char *addr, __u16 port,
 		 int timeout_ms);
+int start_mptcp_server(int family, const char *addr, __u16 port,
+		       int timeout_ms);
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms,
 			    unsigned int nr_listens);
 void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_fd(int server_fd, int timeout_ms);
+int connect_to_mptcp_fd(int server_fd, int timeout_ms);
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *op=
ts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
 int fastopen_connect(int server_fd, const char *data, unsigned int data_le=
n,
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
new file mode 100644
index 000000000000..cb0389ca8690
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+/* Copyright (c) 2022, SUSE. */
+
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+
+struct mptcp_storage {
+	__u32 invoked;
+	__u32 is_mptcp;
+};
+
+static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_=
mptcp)
+{
+	int err, cfd =3D client_fd;
+	struct mptcp_storage val;
+
+	if (is_mptcp =3D=3D 1)
+		return 0;
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
+	if (val.is_mptcp !=3D 0) {
+		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D 0",
+			msg, val.is_mptcp);
+		err++;
+	}
+
+	return err;
+}
+
+static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
+{
+	int client_fd, prog_fd, map_fd, err;
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	struct bpf_map *map;
+
+	obj =3D bpf_object__open("./mptcp_sock.o");
+	if (libbpf_get_error(obj))
+		return -EIO;
+
+	err =3D bpf_object__load(obj);
+	if (!ASSERT_OK(err, "bpf_object__load"))
+		goto out;
+
+	prog =3D bpf_object__find_program_by_name(obj, "_sockops");
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name")) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	prog_fd =3D bpf_program__fd(prog);
+	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	map =3D bpf_object__find_map_by_name(obj, "socket_storage_map");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name")) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	map_fd =3D bpf_map__fd(map);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map__fd")) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	err =3D bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	client_fd =3D is_mptcp ? connect_to_mptcp_fd(server_fd, 0) :
+			       connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
+			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
+
+	close(client_fd);
+
+out:
+	bpf_object__close(obj);
+	return err;
+}
+
+void test_base(void)
+{
+	int server_fd, cgroup_fd;
+
+	cgroup_fd =3D test__join_cgroup("/mptcp");
+	if (CHECK_FAIL(cgroup_fd < 0))
+		return;
+
+	/* without MPTCP */
+	server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (CHECK_FAIL(server_fd < 0))
+		goto with_mptcp;
+
+	CHECK_FAIL(run_test(cgroup_fd, server_fd, false));
+
+	close(server_fd);
+
+with_mptcp:
+	/* with MPTCP */
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	if (CHECK_FAIL(server_fd < 0))
+		goto close_cgroup_fd;
+
+	CHECK_FAIL(run_test(cgroup_fd, server_fd, true));
+
+	close(server_fd);
+
+close_cgroup_fd:
+	close(cgroup_fd);
+}
+
+void test_mptcp(void)
+{
+	if (test__start_subtest("base"))
+		test_base();
+}
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
new file mode 100644
index 000000000000..19f5f8a183f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct mptcp_storage {
+	__u32 invoked;
+	__u32 is_mptcp;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct mptcp_storage);
+} socket_storage_map SEC(".maps");
+
+SEC("sockops")
+int _sockops(struct bpf_sock_ops *ctx)
+{
+	struct mptcp_storage *storage;
+	struct bpf_tcp_sock *tcp_sk;
+	int op =3D (int)ctx->op;
+	struct bpf_sock *sk;
+
+	if (op !=3D BPF_SOCK_OPS_TCP_CONNECT_CB)
+		return 1;
+
+	sk =3D ctx->sk;
+	if (!sk)
+		return 1;
+
+	tcp_sk =3D bpf_tcp_sock(sk);
+	if (!tcp_sk)
+		return 1;
+
+	storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
+				     BPF_SK_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return 1;
+
+	storage->invoked++;
+	storage->is_mptcp =3D tcp_sk->is_mptcp;
+
+	return 1;
+}
--=20
2.34.1

