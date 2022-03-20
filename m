Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506B33D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 13:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647784532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dH1kM+YaTJrmTMXQJ4059TKdD0MChNczTyG4gnDSsx8=;
	b=Hi9/z8/YZYpZ8yEe+PvtCL3TPBZhF7R1IRXRMBV1YcAbCP/i8XH7OwOp56jStFCoHGbMwt
	UFBWemSEJu71WdT23R1S2xfKivRe8LeeZeVFuUdgJvnI+Sh0CApQr5gnLEJaFerC5qexIy
	Hv9HkSkXf4PI21MX59p1MHhHZg9au1A=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-BB_krWSWNbiWTohaprekHg-1; Sun, 20 Mar 2022 14:55:31 +0100
X-MC-Unique: BB_krWSWNbiWTohaprekHg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgvHHB2HjmYmClBb+hrAkh2hdt3Tbh/5p5GuPinZvWUeMD+nUpU7QkkReXixyC6/dezH2Yuwq1vxgy1YJUq861HglD1NjU26L8tFC0dfZZa3x6JJA6Z4ZQT4fzyhJoZisYT6EwBUQ4sp+ujab3nlxilkhm1pMIkAvKHQSL7bGkgFYLpwwfAXzdznmxEbHPY03yyrHMkQeD0tqlOF19dGVrCsyQYGwb9Lmpuq37D6wd1EppxZVeDkk5dZSKTISGtXBEbvU6ihgRUCEPOCNk/Y5VtakEF1WCCouY7PcOgATjcJsCHUWUy/Jy64g0eelK30Gh/0seveQtvRiB1LnoQVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TerbmaibzhljMAX0eqSLZycdME+GMo0ProuPYZmnDN4=;
 b=m70Vx/xtN5weNR4o8DMgACCb9U6fGXZqoANbK6L7x3RAaKlQoV/MtHslFNCM1PkwgXQNq/oFfNVHzSzQoAVLeBIQIQatK/qzaBLCr2VsBnbuAhLzXT+R4Um19N8cONIj+1C80L3QTJHFdsHc5ESbdiWhTPOo1szqLtEnzJqztacKoO6lo73Tk0N0/0RIbeC9yRqdpY998eVUV6vobpi38dbHCHe6FEF+ojAErcTnByPL6z1gUBNPbUOQyuaaq4BEVez18x2PSUDfi0QTBdVGng6BIWTpsS/n2DuXf4HlHe4tow4sZ8yD3yJjobE2sXK3X5yHHl4SCch8dDZzDK1bcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4558.eurprd04.prod.outlook.com (2603:10a6:803:6f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 13:55:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 13:55:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/3] selftests: bpf: verify ca_name of struct mptcp_sock
Date: Sun, 20 Mar 2022 21:55:10 +0800
Message-ID: <44d0fb218df30ede0a3797351ee833534c8fad72.1647783989.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647783989.git.geliang.tang@suse.com>
References: <cover.1647783989.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0007.apcprd04.prod.outlook.com
 (2603:1096:202:2::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66e4f448-d182-4d3a-abdb-08da0a794bc0
X-MS-TrafficTypeDiagnostic: VI1PR04MB4558:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4558F5AA54D33373E662CDD6F8159@VI1PR04MB4558.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hNGfMNyJc8u1qhf+pdDD5YpJLWBwkfwBw2MWKdlLHqSUIJbCi0/qGyNDnSO7EQNbO8QA9Dk8z/wqw1UHYDh8y4nG0UBLOMBn42nAEnGahil14/U84c17L0oXb+OtvGsaQO18AfKV9B3ZqWA0eUMivjfY/fRjm0K9yoHfpQEbBqIsm97csy0osHafov19nPV87LW7iDIyqXqz6j0ViQT7JolVeVJP6Ya8nE/bjaa1r0r+Ei8ZWKUss58OeKjWfCkgLMdEKu8NMtdWwpVSGM1QzCsqe6uN+9DfsS4TzXZ4o9zYfy0V+X7jSeJcAbFlDqk/vnT+L3Zv0foXr8MKMnRT3wByA4az6w6TV+6dqK0tQa3o8r7tfChnBq59yP5DbgzGlbRgDsWqYILOB3Btgx/RFPniJlqr3BNFul99vIkXThX4NaFylPJxgGNObqxXzg/BCg9gdFqUH/uJtE1bI26q50nlMzJ2C6Z+eVVjH6EBcgnO8eT1kQBllYe21yz3sqqentzl0Hw4cDkAI6rJ7K0YydWP+aSXHtBioE/FiA0FVkzDz9asmIMRrAfCxMpAh1vl+mvnstXf43N/mXqHfMiF/zi7AEMhI29xKbh79SVOloYxIF+7m3ZNsK7w9+dgb3uOJkfOCldIncKfiF9raj9nQ60ifwfp+rY63+WtrXl8kzldvTI001rLSsxhqe3T/xu7DG+DU3/T6kwd8vNs3tuvGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(15650500001)(6916009)(5660300002)(316002)(26005)(186003)(6486002)(6506007)(38100700002)(44832011)(86362001)(107886003)(6512007)(6666004)(2906002)(508600001)(8676002)(36756003)(4326008)(2616005)(8936002)(66946007)(66476007)(66556008)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DpbUYMvneFr6xqQYxb/rGME8Cu2EoNzFZzClJ8PIYXkAon926EcXlyelCUhx?=
 =?us-ascii?Q?JPV4w4pFwz+3d00RwryqvDCaz1cIM5W/stEqUKS2ruDsQ2fAWYkhqREKWUr7?=
 =?us-ascii?Q?vphNvr/mk1J6YmjW68P92cL62mlFip1C/Ckhm3OgIlJjpPnB33JJ1KP/jz2o?=
 =?us-ascii?Q?OiRxXCHxjJVHN86t8ft2FRRS5AFQzIIylgsnpOWFQiDZOszJoLXIpd5Wp8ni?=
 =?us-ascii?Q?ujn6rpmPxk7XULtkEQr/2xvgbsd9tIslgnygfp97MsGBYS7TPqJMWW18NtI1?=
 =?us-ascii?Q?/Vuo6qSeHbkNSr/Gg6MmoeNQ2OWWWFrIoLuo0oI0FuUTWuKNVmBTEtlmyFuV?=
 =?us-ascii?Q?QENzDmNU62kBb8U5EmY7XKJShkd+LfcBZHs5/+hEWTFIhmh+rSQyrvynwk6l?=
 =?us-ascii?Q?h3tfyQd9zPjBPGbw3FtHLrMUBjt38Qu9XL1x3Fkg3i5mgAe1AMIGdatqGn/W?=
 =?us-ascii?Q?JR1YZ1AINIueuHkSGdgrTWIM+Q4Di7IAoaudxaS0reB+3x5lOuXyyXN0fFc/?=
 =?us-ascii?Q?LP2cZPSy5iloTUYyT0rmcsK+xsHWMIYpIzvGM8rghzU54knFOYO6k0ozblxj?=
 =?us-ascii?Q?ski9afMQ/hy+us3IYNRtONThbh+qgisYYbQNYY6qERWNStLKT88T/NvyZ/ZW?=
 =?us-ascii?Q?MW9HJrQbCoDpy64vyKG5V9UgdyS2jvNbFXmbVn5DI0obLeTCK6o3xWIQTDTb?=
 =?us-ascii?Q?Dhrh2yo3+vTkmdVSy9uK9sgbWs6jpameVOZJQ0YdrE7M9i9aFz+7AiCfOI/h?=
 =?us-ascii?Q?/r+MfuB58bd/7mmdXDIJotAWwFdYhE/J7/9dnpt/CKy/3XTcuuAHpRlVV9TD?=
 =?us-ascii?Q?cvWEnfIcL5YlENEa8CBakVpU8ig3s7UgiYqOsy7f8+lfTXd0k230XURhXJ5O?=
 =?us-ascii?Q?JLFQP4EJPOovik70Qov5v/VPBkW5qkRJ30CynQlh0ima2JjrzLJZYmCm+Alx?=
 =?us-ascii?Q?SYFOgzomvvacQV1IZCmb5AZdW+EYG57wkeD2fKlBASFSofjUa6PeLIGByNtW?=
 =?us-ascii?Q?KMzXwTJbihEDX1TWYVbhDCPLFP82ARi0qbHYLXAlabiXZl7yv27TKldM4vEB?=
 =?us-ascii?Q?oMiH8ZAYn0yXvBRrb366hzDjmy5tbEUo6a46MzfLG6acM5nAns/0Es0N6Vwq?=
 =?us-ascii?Q?PciulMCXpvqOAuyXnj8XloppdhVJ8Kf3+jf4a8alhJRVWH0n/pD0ZzclWVlL?=
 =?us-ascii?Q?wEcKpRK2yBrOX5TdsEWgQzKz93wO/o/HYoUQTIaReSsKc5wEJhVPheCI3phK?=
 =?us-ascii?Q?VYtMMsLCxYDSKJS2y/WduY6Pcb0qXaFVxtTm9QUU6x1RuosdDjzprwzKyHLe?=
 =?us-ascii?Q?dqC6/IctQL8jfz7ybfrsSQQ298LmC444CJyYZox2gj1B69Ko/ESfrvh9FR4C?=
 =?us-ascii?Q?NVIW+B29ZTdFMe/qlBCltV4R8NwONdvb5jF631KPpZfWaNVwDxAtLEF6iuHl?=
 =?us-ascii?Q?XgAWYOuO+/EtwPfk7rMTwb+ixTGT4UaEXxW+90nW2ZsLd7S65E1aKw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e4f448-d182-4d3a-abdb-08da0a794bc0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 13:55:30.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fN386ITL0rSobYtuRPe6VWb2+Yd/6/rnoZUN1IZugDQ4P5TfgMFAWwcRF0fIZ7ZaJraSOsE2GzU7hX4qcdFVAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4558

This patch verified another member of struct mptcp_sock, ca_name. Added a
new function get_msk_ca_name() to read the sysctl tcp_congestion_control
and verified it in verify_msk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 +++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 33 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp.c     |  4 +++
 3 files changed, 42 insertions(+)

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
index 80ae5a9777bf..d2941fbc686c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -3,12 +3,19 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
=20
+#define TCP_CA_SYSCTL	"/proc/sys/net/ipv4/tcp_congestion_control"
+
+#ifndef TCP_CA_NAME_MAX
+#define TCP_CA_NAME_MAX	16
+#endif
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
@@ -77,14 +84,34 @@ static __u32 get_msk_token(void)
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
+	if (CHECK_FAIL(len < 0))
+		log_err("Failed to read %s", TCP_CA_SYSCTL);
+
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
index b08448a12c02..99718f20c5f8 100644
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
@@ -47,6 +49,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
=20
 		storage->token =3D 0;
+		bzero(storage->ca_name, TCP_CA_NAME_MAX);
 	} else {
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
@@ -58,6 +61,7 @@ int _sockops(struct bpf_sock_ops *ctx)
 			return 1;
=20
 		storage->token =3D msk->token;
+		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
--=20
2.34.1

