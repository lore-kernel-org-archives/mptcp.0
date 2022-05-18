Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6251852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652854304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m43ICTnZLpCuEB/VLMAo5Qqq77ZaISrTpMgPW2TXlK4=;
	b=g3qrC3K6sFR4NH7MrdIeJ8lEgpNpyh2yJwoIGxfo3wYH8fjdK80lHQ2pW9rZq7KaiNmT23
	LVlBRZI8mlEwSB36vvr1O7Zl4qklqbDIQQgr42diLm/LWqj19wiaVf7nL6foCcugKSIRkN
	UAZnqA/1em8NRl25tiRSgkcReg8girg=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-_bH-WooPNLe0Q5tC4kf4Bg-1; Wed, 18 May 2022 08:11:43 +0200
X-MC-Unique: _bH-WooPNLe0Q5tC4kf4Bg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED9c93jyggy19sStsrco0am4ZbKAy7z4d04r2JGmVOenUAKrTa/KFgS+jsgPMaf0oSbyvqG0RK5GMlKaXW1n+5HenmbNmdtSEiI/tWBjDLvejCcMrvPzUjGZJOSiU59SJJXlSvPr7HklW5zzICOIHMTlJ/vmjEqxzn6RbdUnNkj8WKFST5H5GtjzNG17UIJiK/UkEb3MWXr04yUfvJez3A68NUUgkYXVlT6JHDm8k8vd75I/eePktkS36pEjjs61g0RMjjAcwQiaxTHE9DNgqN7SDYywgQU/jI8RKV9keqjuX7w+xRs9HteAbUNtdB7BJojLTZV+2mS2Zx9vE8+2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iu/m1tcWIUhp/DpoMoOXl8dSn8GytXkn6dNCl9GUpk=;
 b=hJNjS/j0yxQpkA7G3C0GgD+eF9Oq5haoUiHAXYfg3StKhsNPRYM7Hq861DSWcwcdJk7esXitMxNHiFBVgpndU7WP6F2xUgF3REWyapcyQ34d2EPjJR9xQII6r5tHJCYeggZeeWpJnEhb/IXQfMki6Py+cgNpYGkERBIRdnhyKRPwyJg/X9RUUZmMeGNFoQSUgpMjUvnB+xy3CBiB9bb8mckvQSaqU2scc5Nr9SWkq3izWiVPHlwAm4Qot09Ds669gEVG7Myp7iZ+Ux1DAgz7H76558AUGNuDc88EdxiSc6StWyyfpS6thMXaU5vAPfC6e5Ch9jQSGEJobBHGne9LhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 06:11:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:11:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Nicolas Rybowski <nicolas.rybowski@tessares.net>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 06/17] selftests/bpf: add MPTCP test base
Date: Wed, 18 May 2022 14:10:44 +0800
Message-ID: <c175dc930444eaaea845b99717953ea12132bc69.1652853898.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652853898.git.geliang.tang@suse.com>
References: <cover.1652853898.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:202:2e::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3d8865b-1216-42f2-f8d6-08da389546e0
X-MS-TrafficTypeDiagnostic: PAXPR04MB8256:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8256532614012B98FC9C0B06F8D19@PAXPR04MB8256.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XPH983rvFhRGqCxj1cA7s8Do1FZRrgqOis8ydh1+OGidIznWD2gQgTbLhnx4myaThsiXaGlKwfeaIMIi4FvrkumYnEoR+YnWNKnoAcLC8rz45o29jtzy7rXMl/Yu5a1bSCfujjmqOnUv1YJBsbSGzWFLCy0M75M6Fm+WwHmk8oQr/2nl+LxKtQnEQcYuM6JNRUKWhSpMdhSsX/gz+/0PiXgqsF8Zg/V56vSfctWMsah5G1IgbXKoQs6EuODwxqWqoHMfIRgYA62dMJjuo7rq9neuTsupmm+L2zjOdxggrJDWDLXqRWc3R9S47QUU/c70wfO/DzoYxdlXASU5dLEhwN3SsYGK/OVpQxRZskCPd3xLY+fT2Pdlbtf41z9mO5Rn+ybtMPX7vaH2A3oeii6SrhZ62RW87z492VM623+IVCB1qtHckHnky4YCJWNa3wXSCSyrtyt8Oyj94236LETJR7VaPX1iDFzx05mrlLyfPHUVXuNxRrbCy2KZ1W4mfqYkI9L7Z2DtFdi7U0qwhkEstnmBbF7H4r0APZZ3FhxFfE9jp69MYm5Qmxe/6tViEdsx1Z70kOyUiDNRO1WasZN1txVOXpXg0GAlZGHLEeB1jt6b/OMMTSXYgPnDdlJYNoiZwdvSkjfs7Si0c30c/Ko03dA8OsRQxxzkocCTt40e59UvjD58ImJ2R+a1hTpOIBUCctPHpF+hefwYBQx6B9cD4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66556008)(2906002)(66476007)(107886003)(8676002)(4326008)(36756003)(66946007)(316002)(6916009)(54906003)(508600001)(30864003)(8936002)(38100700002)(5660300002)(44832011)(86362001)(2616005)(83380400001)(26005)(6486002)(6512007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xPkj48ZV0NovRebHa/RJInnMI9lWe/2CWg/nnAtcwqW2RLN6GlBW1FsAz4a1?=
 =?us-ascii?Q?Pr2O0Sq6heH42lZZTFsr7hdkQGJX8LZ+j29TARZluwM6VhVrjsI56PlWV1yt?=
 =?us-ascii?Q?6RgBT24MaOwsmLIM6g9gD7AOIW/oUTeQY4OKzgnH5OZVrgEGYS1o+yivuxuv?=
 =?us-ascii?Q?r9mzxpr2jfKbo4OQWMgrGZEzTmHqejULvTN5bqxNf9l8SpJn3BDuGYoPV2rb?=
 =?us-ascii?Q?A7LWSOoH06NhdG/W40XeSNrbfEGCNWEKIALzUbKUTueqwJizZ31kdintisqR?=
 =?us-ascii?Q?jVYeifvlb1N1TbK0m2rGXwfTUKW5BFzjttW5r4AUO+2cho1o0V3JlXPOnnLI?=
 =?us-ascii?Q?7Fpl/xGitg0DADI2lNKz7fLbFbkjfZ6pDkarsGALOpvfDH/PjFsBwZHCyMcw?=
 =?us-ascii?Q?sp5t6jJu7Ln0Gdr20HjSBzCDq6LUIljzjCIbp8gcfFOPs89bHAVd2IY/rQck?=
 =?us-ascii?Q?zs9PZibi7/sLIV839gFajpU2zTe+F5AnVJWfqVFo7PK7jTqhzrk3yLS6NfvM?=
 =?us-ascii?Q?uUPFBQXzLHdLevncexc4SAMjiRKyw4km9ScRzs8GHHhZN7A5aow/zpAdpIzV?=
 =?us-ascii?Q?He7/RYxcvK6jRX0D3NB0IA/roKqNlqFwQS8lCZS5DKDFeC/NZfbTQJ96+c/r?=
 =?us-ascii?Q?die74V9E2US+LC8XAdgS6EB+GCAD64Z8yP/OXUM5JGRWRx6f/3kWZV+2yITy?=
 =?us-ascii?Q?OC221OK8f0fcmss5uK7xQuM6n1KoFyEfoDDTkgpsf6eKNfZr1hydmScJNgjf?=
 =?us-ascii?Q?E3U5jXdpaesy+WE/AsBMjyVOM8McLrGD1eQO08teds66ezAJFWQ8VPPB558A?=
 =?us-ascii?Q?JavzUE77nIyBooaJg9FDibAC7HvWzfC6R7RGDjbKPKsid/JpKZOU/IOjkM36?=
 =?us-ascii?Q?L05YRCdiUAiDshxGBTb10qexwOU1sBhxz8Z9rqAQPx70F2v3XEKOvK65f+yo?=
 =?us-ascii?Q?ro26Xgo1SdK5YxX6FtknyGJCIDEq2g1wgAAQyefwfnd6bxK7GnTmSnHzVz7A?=
 =?us-ascii?Q?8SmAZ5svJLQpPRyLMpR8sWvqTGgzA2lGVsxS5P4/Bh3Qdv8ihlQuTb6aCYUH?=
 =?us-ascii?Q?XlLbzuphuSSqSD0uiESEzgXlzQ/a8b8+8dXQZHeytnHSuyEVBHstSS0DUX4O?=
 =?us-ascii?Q?cIm/j9oxZhKNnFhSrH3sdpMWmcap0IOLc3Oicol34vqwLnO9ZaKzZUTAhMuv?=
 =?us-ascii?Q?Z3ZEpJlzte9d4ojzW5sVt1Y1nPd01Gb0PnE7elr6x2Zk4V2KuQrYYn/nDDp4?=
 =?us-ascii?Q?d+zcV1z9J0uJ0NiHlqNJsQy2pBT7FKQAxU0I5+qc4oTH/+AbetWCm+ZnoiyZ?=
 =?us-ascii?Q?c+Lre71EyFidmKUE1gWgrFGdRDCdqPp+S9iLf4lVohyVjPGTTSpHSRvKQ9DD?=
 =?us-ascii?Q?1J5lhFIJJ6zGGeV35SX1VDL1CajQiZoPMnbzVJQcx8wO79k7qIfIxeiNl740?=
 =?us-ascii?Q?+ETqMLvKZgyNSA94dlM1uF0mJgxUgaZFrYdzf4ZnsZ/gkXPYll6o2JHVO/0A?=
 =?us-ascii?Q?RBP7mAKAgM0+jtyBc9KUzCafHeJ7gptCcydZP9EeC431gSnkigsPwTpTW0Xz?=
 =?us-ascii?Q?Y/yWsU7SNWT5Ur0aWitcbjgLtFoHqfOM1JCWtt16kSAQpocwDQ0XL3eK/j2+?=
 =?us-ascii?Q?vNsMjmqhj17DFZTDpXX1hIMkunNPjZtss/bgrFcwoZoRjRevM9q1rENyUOht?=
 =?us-ascii?Q?XO7wbiMRv6KF0lPPZrMLvq82rths4n384hvKqpZ1RItcU39eBsVVo8PIhB9g?=
 =?us-ascii?Q?RSyZQSFi0ArImnQvcf7sEZCztyg+BII=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d8865b-1216-42f2-f8d6-08da389546e0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:11:41.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNpv/v0H/2ta//1kgnHhzcQBIVceF6SuYRks3ayq3EtNDtbpUNwVfiLlNGVAm4ENGwREhqrJv4mE26XNOwTUnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

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
index 000000000000..59113eb982e0
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
+	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
+			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
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

