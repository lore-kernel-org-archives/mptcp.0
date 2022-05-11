Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA1215B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R7EZ708XU17gmD41ukgK0uDU9aNw+KSghNubvgymCBI=;
	b=MLsI2X7G/5C9VKASiSat81Nu1UD+Vpz6tx7Qa24pxUMDHBSR9R8JEQkJ8y3sIkKx4tPsDp
	AAycZsMy1nLWD0kK/dcf7fQoaa9hzqQ8y+aAw2jAYYkL75WCPwUkHQ2bm8KwQR4M8rOqhg
	vAzHJZXDvHFbBHMw7F56MxHH7sc+BxY=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-I-9_a0X9PEetSZvA2AeLKw-1; Wed, 11 May 2022 09:56:44 +0200
X-MC-Unique: I-9_a0X9PEetSZvA2AeLKw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPf5uDTWoRqqwvxK7iXLtkXKQLs5UandRpJfsRMRhtZ0/94ENlbFuy2gYJ9eFIq4q3Zkln+vZkcb3ZFpUnisrt/lYd5IiSsSnrF1AdtgR8LhCX7mruIfNSapnQGOHTxEARuKE1j/ePi4eWxUiBmPKkw/ExaZB4Go+EM+IwYmybw+r7YEZyeZCpMlvXMYFsDmisoRWzr+VgGMJZ6iXl838pFxD+hDqG74DRtcdMeOEDvhtxhqDiQZ3Uz64v0RwRyn2u0ZkGc50WVZaMt+1r/u/yhqd8bBF0FJ7PQZ4+M9XfciA6QJfEqbQJD3jXPGmzqIoTrw7m4HIVNm2q/8/y0xtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBzZEErcHOVB+2i4IYYGbj5TY1tXPJbqiXItowcEeis=;
 b=ZcmaBctjPHPJBwSbCwXU5Con1GwlSzxpBSWLiXpP0QX0g7HXTqHhcennBY95f/W56fTmUm1yhUJ+NCBYoMNw0CzaBCld/SqjU3Bw3lHeYoxd+9vWjWbfw/VZfiGqN7e70DSK6uquql010xgxp8bQVTalCFeKKKzkxiZlQz8aW13LM8d4sHxAv6o3DUbgPZZyNgM6YCdReMWmtdQRdXnhbp26lPCZ+gElmX9TSRActVk1C6Q4xBrcPAIhm4nxMhdFgJxHNKza/la0aAvvNsn+TEdkoPr9OXf1A9+gkpOhcyYHc9JlzzQTfodH4EzwF1By/iMU2tpltoIkHIm4Kr8ppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4461.eurprd04.prod.outlook.com (2603:10a6:803:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 07:56:43 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:56:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 03/14] selftests/bpf: add MPTCP test base
Date: Wed, 11 May 2022 15:56:09 +0800
Message-ID: <01c977e6a7dd70a7eeeec21dad1a1a00d3d3101c.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55fa0040-0a8d-433b-21d0-08da3323ca17
X-MS-TrafficTypeDiagnostic: VI1PR04MB4461:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4461F277A9B5042EDBEEB950F8C89@VI1PR04MB4461.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KwXMhFkQR4CY32jHiKLhqYwMMCV131F3PR1f/XArN0GuPL3YNNGgkjoVRVcleVA3M+rk5y6hcXDJUkCMYIclav2SjS/jZ38PSUKLtPsqYj1WU2K+lME+IWN1vag2Ei4tIteDiK0bkIpwCEYvNqVQevbUzHdK4jSdiiBqdSwsKvlzdQUFSyqyg635ADnyRiNfVgpAT+o7yyQDzLF34vLPLmXq53Byt7yrXC6Lunaa/0EEhoOcqgXLnpAco1/ZQO63wYaStGv9W9bmcu3hRqJ4f/sFiKLnPwSF6EpWyvg4hxRJe4FRGhbnXdCC9R1Y4uygfC64hQspBXnZdcgw09A3adG3Fe7aMqCLSeNTtnCBIYAQmkZEvB+p/Cs0nCmcMq7Jztt9w1+NkxvYfWVuNkhNP8AwC5Qeauzv/YaSww/b/793pEPa9N5XfC/RDyce5RvYjWh932grT2Zpg7pWGkj9GWI1LTCSMbgLWwF3HDanFVyj9XqnnQaHaRWMKu18EqqGxfrYLK7IO+Q3Io8uCuz1bI1t7c9VXk0oAURytkyE9C4FQk/rEpiH1F3o3akMHBo5OT8wocpKFELYH479osp4pAMDLS76qYu6PMVRvFlE0nQKdHk584Qls47b0/1JlCELgF2ZES2KM6YlpYy5Eyg0hPT0CMXMYZmwjo9OzVNtCzYPXZWspv4Xu5ZHCZCP4045Wyf9c8zudYvDFeJcatU8eQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(508600001)(5660300002)(8936002)(316002)(107886003)(66476007)(54906003)(66556008)(36756003)(186003)(66946007)(6916009)(6512007)(86362001)(2616005)(4326008)(8676002)(26005)(30864003)(6666004)(83380400001)(6486002)(6506007)(44832011)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NxVacDZWiCSH9ypbgdiHXL7MeRPpMzf7j5RYIP2rkAMcWmGQZPUktBMqQXaC?=
 =?us-ascii?Q?IKBFzGQdvgqj+baR9jZpGGk4Cm0Cy66zNgeeDOHLpRsXexHC5zEtfuFJHi+D?=
 =?us-ascii?Q?mymKiqqrE3DdWs6OZPrJSDSgpv7qijJ3mdcC0osgJkJ0kV27smedOg02W+aZ?=
 =?us-ascii?Q?ryQB5fs+tq3I7aul+NkVJfeROFVYyVmtbGR1d7JjgTOeIJ5SLPqAHZlTkTid?=
 =?us-ascii?Q?oyBcZjK1DaWXw+4wIPwNKDMMAsqkin5ItdON6SvODeAAso7JEM9PfT0Fydpp?=
 =?us-ascii?Q?N3+GuJUChNk+um27x1+LBZied2yf3ADJvJ3CYJKZ8xUmvzQ6XQr4qBfY7IKV?=
 =?us-ascii?Q?fP8C+DUOla2I3Bm6/icT4L03c/c8TCRORkDlNMvn+sPz3IliuWB5VJQl9YBl?=
 =?us-ascii?Q?Pnb9BYkS/XzizC45zErO7VqOeGsbGMrnQ+Gj1XxwV2VT7D1vS/ulaCC8ewKT?=
 =?us-ascii?Q?cMjf29mAZQHGvvjzIM8vF23av6xco56AgIRLO/u4br73dG4XHrh2H0Uu1Ov8?=
 =?us-ascii?Q?4pUK1cLrV7iJk82fInFQgarsFq+TNj3lgQ58KC3mwbgpaF3e7xaOXes9kKFw?=
 =?us-ascii?Q?qyoSFmsHvMS0wf36CuCfxMot0fh8TeQR8ibjQ5wvZ4QTUjVOAbhSyfaPVB4l?=
 =?us-ascii?Q?UrENVHjv4SF+ErviPVn38esGOHUJ7WeBhjbvfEs376q+yan9vs1iUL8W8wlg?=
 =?us-ascii?Q?RF6TFuSHyQww2kYZsRXzJEcLJyOyeeR+Cc20RFEEZYEyiYSzIAimNXpquNdm?=
 =?us-ascii?Q?s7yjeuVGUaQGTwgNkddIuQrgzo4M4vVNp37aulzdhkJ2onLH03+QZTJXZ7vU?=
 =?us-ascii?Q?OJpaGT0Mz/TcwEEAerjLtHoIDnvR5FoP+bzo/am+sN8324SD6X0Ck9TRP5ML?=
 =?us-ascii?Q?AOc1T79aXAU9M5V+Yfd09ctbL8HKVmhHmAh2nBMRJsJ+/o456sarL0ugaeG0?=
 =?us-ascii?Q?LnqJrap48Mb1/fWzjV09Svh1TwuKKa2fPze1CgrfiuD6266KM8rlqZxcvfR+?=
 =?us-ascii?Q?fSV8RwWaTclj7HxouiFRZYPA1u4Cbpr5ZkoK1A+VXxaHWf/PMUXt6fi7GEb7?=
 =?us-ascii?Q?CktUV8ziM3SxwElEo8g+yvyfyihYJ5Hw67xuBJvz3ZK3YWIZxz3oQvyqmVw8?=
 =?us-ascii?Q?/ak5sg2tZIjr8eBQhGMcbfeyhJOM+yjJqa7dVAIKPCC5B63CpoxpnY4AfheV?=
 =?us-ascii?Q?g4QfDwyychgxFjaCpi5Se5jgmzlDonNXBS1jFqKnkM7Re2aUYtM5kMIZdUxX?=
 =?us-ascii?Q?Wrx5QKJ7ZcJJ9TGKJ/g7/0qHEiJzJeoFnPIt7au5XG+Uv+NXyiTGICDLkzeN?=
 =?us-ascii?Q?mNL4oTx71CPlXCOMbguEB7GdpLShcB43UJzZseKEJ2rtIWFHvaoLjJ4w8Uwi?=
 =?us-ascii?Q?dy8TbZQxrWBnmhcrSxl0p1gr4rPJq6mzrloJ+zT2vwg4Mgd5F+DP3NkJ6TMc?=
 =?us-ascii?Q?a1zdwuCgLIjdbl59le5ySNGvC6kqXKFbagsyBwJD2CDoDL2pRPZKAGMQosIj?=
 =?us-ascii?Q?wy9MpFpeKHpjCYJBhSo8G334t6cM57QRRGxhao7WzxRvCNWfmzkbj7dUrGDK?=
 =?us-ascii?Q?aPyw52XUTue2AD05YT+MtcFGj3Wej/MhRPXM6C/3zZgtrb77iEoaBMZ7MWbr?=
 =?us-ascii?Q?1j70dV/XMay06UzKXVELieoOiLFFXGgy8NPm09zrsai7RCBlel6eZKW/S0Wx?=
 =?us-ascii?Q?w3sTpRoaV4tyVmyG1n5aBLf28TRttEfEgCCu23GQRqZuRI1uX0LW/SapXv2U?=
 =?us-ascii?Q?PkULhbU3Vb5Voy4WjQLX48tLBCVkK6M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fa0040-0a8d-433b-21d0-08da3323ca17
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:56:43.6388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktYTnw8qlg857kDdKXSuwLEROR0MpyCQK6WpXE0zkCN/09TGk+LmGiFiWuuewek+WqC4MGSdytG57b2RmIAJuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4461

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
 - use is_mptcp in tcp_sock, instead of bpf_tcp_sock (Martin & Andrii)

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Co-developed-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 +
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/network_helpers.c |  43 ++++--
 tools/testing/selftests/bpf/network_helpers.h |   4 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 136 ++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  53 +++++++
 7 files changed, 231 insertions(+), 8 deletions(-)
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
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index b1ede6f0b821..22e0c8849a17 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -81,6 +81,7 @@ struct tcp_sock {
 	__u32	lsndtime;
 	__u32	prior_cwnd;
 	__u64	tcp_mstamp;	/* most recent packet received/sent */
+	bool	is_mptcp;
 } __attribute__((preserve_access_index));
=20
 static __always_inline struct inet_connection_sock *inet_csk(const struct =
sock *sk)
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
index 000000000000..bc09dba0b078
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
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
+	int op =3D (int)ctx->op;
+	struct tcp_sock *tsk;
+	struct bpf_sock *sk;
+	bool is_mptcp;
+
+	if (op !=3D BPF_SOCK_OPS_TCP_CONNECT_CB)
+		return 1;
+
+	sk =3D ctx->sk;
+	if (!sk)
+		return 1;
+
+	tsk =3D bpf_skc_to_tcp_sock(sk);
+	if (!tsk)
+		return 1;
+
+	is_mptcp =3D bpf_core_field_exists(tsk->is_mptcp) ? tsk->is_mptcp : 0;
+	storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
+				     BPF_SK_STORAGE_GET_F_CREATE);
+	if (!storage)
+		return 1;
+
+	storage->invoked++;
+	storage->is_mptcp =3D is_mptcp;
+
+	return 1;
+}
--=20
2.34.1

