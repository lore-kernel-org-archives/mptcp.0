Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71CE7A
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652948742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkjKp1Cvxvy02n7w3yYz2n9NsJ5xEq7eZKycP3jGCKY=;
	b=QgJi2fVhcBRnwAi72lKEeeoV+pfWxpXSHtZeFnh3AxP1OvB/HT8TcvGQnt9nmfY8wKoT3F
	MJ3fbKy/wMIZkCYb3zRTOBps3gbQOWHAk/u6OUUa7JJ38Mrd+WAc6i4dNTSDUjKucG3n2B
	3O2x9s6UzjgHqfW2PoRP2VmHJXepbVE=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-3YIXxftxOoqNyNuxVsn_yQ-2; Thu, 19 May 2022 10:25:41 +0200
X-MC-Unique: 3YIXxftxOoqNyNuxVsn_yQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkPSV7l1WRaaH72vu6sowvtvJM/do9DZ9wVVsiThh3Fgh86Ij0E2GQVca5f2j0wdA0mUQ2Q1CiqwJhiHyJ9gNJ7DdDvGucrcn5KjmzV6pB9hlvC/jg7HLY1gVCOoljEOuRlgXX8jPZ+eIT3j/Uhq8oLVBxIuC17oyzYd5lPQKgAa9nxLKCmIUTUQknCpU3Mj/vw/LhprBkRAGjwTbGL4Rc8DMxIo02/4ZcOeVo0m1ss/mn2CLgfFNJ4wXPMhtFMol82bRw6imyKYw8XbfUxk+EGITweM1Jeurju5/eQ6gYMSDAMuD5W8+Y0E8qVGOmINLBfZN6gtaDMuKpydRFDk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6EWHAAEhdwo9vOR9nj/bBQbcDKZzQyvxJiYXoz6bnE=;
 b=B+JvjGDJJR3z+Tw5JHRSIREYGWmv9S//oCbH+ySuJFWWdx1IH2eaF9nSiNX/qv/Q64XzB0rb5KPgFa8hiSLpF3N7rEKSQBsW6vcIHoY/kkiGqd99YBIDTIuezbmuCzaWbiLXuDG0zfGCARIfRA8ErdcKlMnJyzQj+l4Cv/nFoJWL6y86V61nSxIujIRFQPs/TwLmYwpkw2nHbBXNHPuL602xQefNedwaRPq6pFTvsn92htrm9HwFyYwy3zU1lhcyiig72qKnoVMXV4xZF+cREvZca7dqppkr/b6NbMxZSzV0r3IAYI68fy0SSqNGoMWkm4P1vEOpZBlW+J0sGIPSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6652.eurprd04.prod.outlook.com (2603:10a6:10:109::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 08:25:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 08:25:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/7] selftests/bpf: add MPTCP test base
Date: Thu, 19 May 2022 16:25:14 +0800
Message-ID: <d366fade733384168f79f0d5e73a692736792a98.1652948238.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652948238.git.geliang.tang@suse.com>
References: <cover.1652948238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5ca602b-7666-41b3-8d10-08da39712861
X-MS-TrafficTypeDiagnostic: DB8PR04MB6652:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB6652C112A9EDD50DB4A1AD80F8D09@DB8PR04MB6652.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	og1Azkpotf3T5OosiTZA43NvTDGE0RWltIyh5HxfcOAdOmKEH1fypjU9gEGJkISjWaa4OwWMDoR6KZMcsP1AAElSKn/9B1pyoTzOYsFQbEe/xvCdiTnu7x63lXlMTil3+kKazYFb+gLFHAgmZgP+lx7hSfRRq/HKtKkm9jxszcWU9douU30Yi+P8pGJT9CGtBQZJYcfX2ynwIToEWCZqW7hOECfpGGBok0dttNEEKcpCgdaSwHxu/6HtiT9zVZP3pl0vJ8ku5Pr02MOpaQdYmD8b0FxdMiP6iu+22zzr+0AgAMt41nr+Otw1ChcQR4mRiJWRd48YBECmRd2MGQ+5Zn0ueoRdsN/JjTpuQic+6BVZ9576g8oPS/HgooEu7pWLPnTTxb00IQuYlWilCQjCNsZOsqOlDNkM2TH74NcDHvnb6J8Ll/nvaG2MdSz9HcwgLvXZiL/2meE8lBGQsdg16SOESekJYMyyTRtyfLGfDLsIz5qaGlXfzN4/cVzd1OsnRwrKboxFBwCUxqZzItXbNg6kjqWCbAZIQnG6Blbjng/8IV1ZkufE6KB02BupBiyl47AH7IJqCS4QSycBYUqq+ZySBpebcUmMHXDzP9ydwI23aXtxl1uSMRSEfJVSu+6h6c+xjVQPAWaNGbVQO+r0EEbVwcW8BIWFTPdU/giSL32kn2CG59xNWQ3KngL/AAFKM7Fw1WXLEAVB9fPmAPBP6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2906002)(6666004)(38100700002)(186003)(6512007)(86362001)(316002)(6916009)(54906003)(8676002)(6486002)(2616005)(44832011)(66476007)(66556008)(30864003)(36756003)(5660300002)(508600001)(6506007)(26005)(107886003)(8936002)(66946007)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QOO+NgRpCokGTZ0op4+w+KIKWkHBBn15O8jKbjGom2073AB/weZQooAJbbzr?=
 =?us-ascii?Q?25QtueI6SJulYKDspoBzcJmSalRQrVbPmVk7fgR5OadJM26B3RoximRsxu8f?=
 =?us-ascii?Q?HTZExpYnIo3mUQy0pa6mHV/Vz+NkH7f7bhrfvQ7DpYLFpxyOY9BiJcUxonoH?=
 =?us-ascii?Q?BuwU7lwBYV7vEY1mJ3BWmDxFkYPIGg7rCh8ZEKuuv1AS6zd3sRecs/YiFAcK?=
 =?us-ascii?Q?Uk20WoYs0Cz0BRc8sR08KdNQ3d9sYb+PfwHByOXgw8suDJQghqRif28LqKfv?=
 =?us-ascii?Q?EPQeM0NvOlNfNpOJ3tqrW/YW/WPZhI59K1kt1ymXHwRo3OLlTam7n7WBP0dp?=
 =?us-ascii?Q?7ntyZ0pS/bq0fnaDIcflyzTHaLSavx81wIOMiFbiHtDhT0ISqw4rtkpexqXS?=
 =?us-ascii?Q?o23ikFL0vWucrwm1UuNcDeU+WrYTMtmMjAh+dXUlaqd0/O/BOP0oQw0qOtOA?=
 =?us-ascii?Q?QFwvd/mZSeO4TeTKNkeySSG2jwOPbOGsDyg4xmPDWcN4WPwQEZ7jy7rfjeF5?=
 =?us-ascii?Q?tOKAyltC1gCDo+/irK+T+YGAAmL/KSHzYZb3/6lDeFhajAaAcpvyHo2D+pzG?=
 =?us-ascii?Q?yxpT04+Kr8imSTMy8Bw1SfgOFCjV/azZ16jGMyku/yS1ACJasCsDCWBsn/pt?=
 =?us-ascii?Q?bcwlRuXSD8T4Ffw0C5MZzC05aXXZBXWKul0I4eVr0btbVKL+xKPf8pFwtU1D?=
 =?us-ascii?Q?2kVnFS3SgSfmKZCOFxz/TvL6psCzKDMMD0DFYKqodCtX6k6vlxpG908RipIt?=
 =?us-ascii?Q?fDtzsOwkaIS1T2OYfiH2/eP+NQX9mXQ/ByTR7NtQRMtNwRCBFTsEakMReGOj?=
 =?us-ascii?Q?+JVx6VhA2tMkRRyUiXw9iFr62GBkEWU6uPyvcY1axp7PoWNxVOpYxxPeTgVA?=
 =?us-ascii?Q?bOJ96WYvN+PPVgUGWaDv9PfN81e35bXZiSa0/eCU7NHS2/Q9Nv9WxWB++g/B?=
 =?us-ascii?Q?tlFTfKfR4r40IAP1Bln7njVEVQw9eI7l0Oe2cM1Vx3ZyAjBl32hiXsvyH7le?=
 =?us-ascii?Q?Uk2+LeFBJmPoHjuqMytIX0H252UyxTOFRkPk4zQCN1lPRkjVU48If+/tYN/5?=
 =?us-ascii?Q?HYkbdxwnHaQ2RlrCg20ek1dJJFSnl9uOzpHHyF9wY+ioUFcDK3xYqxRj70ZV?=
 =?us-ascii?Q?qXYT9BkMc1NMT9hHCPP9WuL03F1ywCJvbPVVU4PkVryATmIDnwm7gI/80nfF?=
 =?us-ascii?Q?N2F6IxqIISF17BKna0VjhKSY+I9Y8D5eLo/GFO515Ag7bBKEZUSPMyxfpAEE?=
 =?us-ascii?Q?QCvQmS7ez1cs6UiLigiIz7wL2k1CcJlry8YATRXvgPaiK0aTi7Qn+Zo+oYJR?=
 =?us-ascii?Q?1sG8eEuSwi59CKsLNEhSs/oh3FHU29XPsYGkOCVwX9Z7YGRQYIt95wLHJkRh?=
 =?us-ascii?Q?kgwBTADJZMc8TCp1+4KXDxMLAzRavUTeuIrOasqsTQxxp7gnG1pNgJ6aeq0I?=
 =?us-ascii?Q?Z7JhLbHSkFV+nCWPVFv0kDHgaGzANBN8nLYM5JkxJTyEG4Vy9tRVlshYUjqZ?=
 =?us-ascii?Q?XuQXdNpQc1r+g9+8KdJudp5wufPoQ5s7NqRr0PiM74n/7MCUbk4vMdOYTTY8?=
 =?us-ascii?Q?lngVWSvYtQrMFSZNF1TEGh9+0/rOFPETiktozj2/+ZL1YY69Dn//KfqENUps?=
 =?us-ascii?Q?+/SeVwral8pZ7eaBvGOdRPx/EyZqxvGlG7hxQP18SJMNI/CuFvbGE2/ss1OY?=
 =?us-ascii?Q?hYDT3lSwTa3gO4idQcyGu+CJIUBjk5Cd6jXVOGidXUHyfgrmwolHql4hWUv9?=
 =?us-ascii?Q?eH9aOsmyP7IKUwDgabvtZm5k7QaBiqo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ca602b-7666-41b3-8d10-08da39712861
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 08:25:40.0415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGU+RnsQJZ58VSkwgXaaAFoel+JHYeelTOHamX1ToWszz5PmBv2liBvstlazFVHa3+4uyi8fqDs3YiRBzBimrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6652

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

v5:
 - Drop connect_to_mptcp_fd (Martin)
 - Use BPF test skeleton (Andrii)
 - Use ASSERT_EQ (Andrii)
 - Drop the 'msg' parameter of verify_sk

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Co-developed-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   1 +
 tools/testing/selftests/bpf/config            |   1 +
 tools/testing/selftests/bpf/network_helpers.c |  40 +++++--
 tools/testing/selftests/bpf/network_helpers.h |   2 +
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 112 ++++++++++++++++++
 .../testing/selftests/bpf/progs/mptcp_sock.c  |  53 +++++++++
 7 files changed, 201 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 69b597aa4bc7..00e29c9f8f5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13799,6 +13799,7 @@ F:	include/net/mptcp.h
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
index 2bb1f9b3841d..59cf81ec55af 100644
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
@@ -247,7 +264,7 @@ int connect_to_fd_opts(int server_fd, const struct netw=
ork_helper_opts *opts)
 	struct sockaddr_storage addr;
 	struct sockaddr_in *addr_in;
 	socklen_t addrlen, optlen;
-	int fd, type;
+	int fd, type, protocol;
=20
 	if (!opts)
 		opts =3D &default_opts;
@@ -258,6 +275,11 @@ int connect_to_fd_opts(int server_fd, const struct net=
work_helper_opts *opts)
 		return -1;
 	}
=20
+	if (getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen)) {
+		log_err("getsockopt(SOL_PROTOCOL)");
+		return -1;
+	}
+
 	addrlen =3D sizeof(addr);
 	if (getsockname(server_fd, (struct sockaddr *)&addr, &addrlen)) {
 		log_err("Failed to get server addr");
@@ -265,7 +287,7 @@ int connect_to_fd_opts(int server_fd, const struct netw=
ork_helper_opts *opts)
 	}
=20
 	addr_in =3D (struct sockaddr_in *)&addr;
-	fd =3D socket(addr_in->sin_family, type, 0);
+	fd =3D socket(addr_in->sin_family, type, protocol);
 	if (fd < 0) {
 		log_err("Failed to create client socket");
 		return -1;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/=
selftests/bpf/network_helpers.h
index a4b3b2f9877b..f882c691b790 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -42,6 +42,8 @@ extern struct ipv6_packet pkt_v6;
 int settimeo(int fd, int timeout_ms);
 int start_server(int family, int type, const char *addr, __u16 port,
 		 int timeout_ms);
+int start_mptcp_server(int family, const char *addr, __u16 port,
+		       int timeout_ms);
 int *start_reuseport_server(int family, int type, const char *addr_str,
 			    __u16 port, int timeout_ms,
 			    unsigned int nr_listens);
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
new file mode 100644
index 000000000000..7874d8264836
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+/* Copyright (c) 2022, SUSE. */
+
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+#include "network_helpers.h"
+#include "mptcp_sock.skel.h"
+
+struct mptcp_storage {
+	__u32 invoked;
+	__u32 is_mptcp;
+};
+
+static int verify_sk(int map_fd, int client_fd, __u32 is_mptcp)
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
+	if (!ASSERT_EQ(val.invoked, 1, "unexpected invoked count"))
+		err++;
+
+	if (!ASSERT_EQ(val.is_mptcp, 0, "unexpected is_mptcp"))
+		err++;
+
+	return err;
+}
+
+static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
+{
+	int client_fd, prog_fd, map_fd, err;
+	struct mptcp_sock *sock_skel;
+
+	sock_skel =3D mptcp_sock__open_and_load();
+	if (!ASSERT_OK_PTR(sock_skel, "skel_open_load"))
+		return -EIO;
+
+	prog_fd =3D bpf_program__fd(sock_skel->progs._sockops);
+	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	map_fd =3D bpf_map__fd(sock_skel->maps.socket_storage_map);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map__fd")) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	err =3D bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	client_fd =3D connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, 1) :
+			  verify_sk(map_fd, client_fd, 0);
+
+	close(client_fd);
+
+out:
+	mptcp_sock__destroy(sock_skel);
+	return err;
+}
+
+void test_base(void)
+{
+	int server_fd, cgroup_fd;
+
+	cgroup_fd =3D test__join_cgroup("/mptcp");
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
+		return;
+
+	/* without MPTCP */
+	server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
+		goto with_mptcp;
+
+	ASSERT_OK(run_test(cgroup_fd, server_fd, false), "run_test tcp");
+
+	close(server_fd);
+
+with_mptcp:
+	/* with MPTCP */
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
+		goto close_cgroup_fd;
+
+	ASSERT_OK(run_test(cgroup_fd, server_fd, true), "run_test mptcp");
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

