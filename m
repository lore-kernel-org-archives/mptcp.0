Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706921391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648026619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2k8nmweHy0v24jiv6g5uW9Bf7pMCDlGzpz4ok+v5S7w=;
	b=Nt64cEhyGBbElEob3HTXtZtSJuO07HQiKw+57Ea3ZO3/vTmsDKZ2ER25PSHldmmm4B76CI
	9U++CKmHuV2CH/FblVwBbIaBbpzdrhy/XctU23JP//KI4fLJZXH3fgAnyKEI3f/IbXVqia
	PoWlV6g1qQEYdXMdmofBaToWJGoxCHw=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-DoRDR-lbNwypWtGPO20DEw-1; Wed, 23 Mar 2022 10:10:18 +0100
X-MC-Unique: DoRDR-lbNwypWtGPO20DEw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIUwqsZjG9Zq5yOHeKOl2oGFtgkL84IVuCofoWf7DbhdaW2DAxq2KxFDrozri5Cnh+MSqV2qK3XfRjuiKG10Hum228hLcuWVZfdOSRLW/3IzDvc9e6VOvtDsIOaMLZRYC/qd6rAU1pL4zzE4ljQTBShAQXcWDgX6FkgOvjepZ2gaXRVRCOciwtZudIcYqNIUB+C+zTYZqy8KnTluyYU4DVBMnF1YIBgm7r9JU3JOIZxt8Hll6OwGvLwQEbnWpEE/cRg5HLl3YWtc5QzaPxfIR3t1KbChNyf2TU1cfQCRoff5iWwSUOTq8GrCrtNHCQ2u5pPjUbSuhVpQf2nkcRpIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dahY6Mv8Hzt+n+f11O7lPW1pCxQ7p4KJvoQKSqVtcfA=;
 b=nmujoudsfYLn6WUBx5hHa4w8xoAdclF47RwPXtz2DW2SYXFa8g1PUGR/WMtGjWGjJ0vrf/RZyas5DgFdS4nPVmd8xtqrZXdOGqaToOHw1jnjaDIdT5uwFqF2Kwn3R+vBHvZwfuZ+kr6L8lknzBG/y/PYpYfUbPJTvhqdaG/YEqfAt1gKyN/GxhgcLPUe90NbKn0RTbZuhq8+IiRLMazeyxJcmw/n2CVJpnD+qCeoD/x3XC0Z7aKELNUMYRZ/QD4RIfNZO8zVN9W7MfGyuzmxMjv7bL+eKiJ42OJ2QJ5HUpaaKTBPnLzG0Aq45RPV1h6t3f14TV4gbXf/fWMZ9PkhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5988.eurprd04.prod.outlook.com (2603:10a6:208:11b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 09:10:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:10:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 6/7] selftests: bpf: verify ca_name of struct mptcp_sock
Date: Wed, 23 Mar 2022 17:09:35 +0800
Message-ID: <42bf5ab5eda469d54c3e00d0d13523b815f31554.1648025308.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648025307.git.geliang.tang@suse.com>
References: <cover.1648025307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0181.apcprd02.prod.outlook.com
 (2603:1096:201:21::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 865aae99-0022-4a1d-391a-08da0cacf2bd
X-MS-TrafficTypeDiagnostic: AM0PR04MB5988:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5988DD225EF9DACA6B6BCBE8F8189@AM0PR04MB5988.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kKhnsJ6Fjb5nVKb3q99IL0mhzCFpsH5n/d74qp9B6itXDI0DXHBERL8X+LpD7VSNS2MNtMDCJqyzwxtGA27D/LsB6F/KWoQVl8Rm4qEBBJ4M+94w2Ac5JTGRCe3p/REntsgMMI7fiCW533h6B7H80Y+maYhosxkJewwAHMzxUwZ4swwJgd8bD7aHrJPhn5i/fWsYdkGgarYgTMAXK4cny9xk4ilNClN9t7L7bP2wwGDnBAuVKeQDmdNf+5r5gEtNhgSucNDsda40XcfJnvjqBYcqj7FVe4vYlNX2YYqd31T2BfrQ9ftiwJoGvd3y7MA3Rs8bWaTUrEvn6ucEhdZ2cZQjIou7w+bVXxs3qZ0McFXCmnbCdPGEeDbGZajAE69It7pOdEyrABTdpdxl+vv/96f565TNauLICzt/tJv90JaUuEWNibhONtWB9valbu1YHkTq4bB9SCG8JYzX2nBb0rQmpDMZJMWqbYVJ6uab/Qo5z00FcApY71u11IuuNK2BeSyEqKhKEMVxjFl8g99iWe/fw0nNtWg3Sk8zLK65qD6O/F6DRX9WLR6z81Hi8kbnHp62ybP89zHO2gK/CBoQ36WgQII9B/YC4LjGyGkBc5laOSIa2owlTdEMNbPpZ8wnIcoLXEF/MIXujDmuCIZET8VlSz6ddnfh5AMCGqg/5p+FoM05X816sLp+mMpf8E3Okf1bQqStSmiZNStYBz5FGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(6512007)(6506007)(508600001)(36756003)(38100700002)(6916009)(86362001)(6486002)(316002)(66946007)(15650500001)(26005)(186003)(4326008)(2906002)(66476007)(8676002)(2616005)(107886003)(5660300002)(44832011)(8936002)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PtdL0BprH8Y3c5a2Q+Ia9ZfA/3BFF62jvO5DSMSl88kRx7DMvBmt46JmeWrC?=
 =?us-ascii?Q?63Gy/VIfdLqn4yflLkqkJ+6BfRotqb5B7sbn1QTgX/8v64U//tZw06QO55MJ?=
 =?us-ascii?Q?J5dfUfvH7noHpNuEjRsjErSvVeG8PPyF5t/yoibuXSZ//F97DW6+f1+/g1iA?=
 =?us-ascii?Q?RhPmgcZfEUOc0HYRrr4yRg2BHtcJa7/PzWbolMpmYhwG++BSmHMP5saKBplY?=
 =?us-ascii?Q?kcI6ZaPUXpGkhtUvAcV4/GrG+5seLOhM5JUtONQiElDPomz9d73g1CqCvTlQ?=
 =?us-ascii?Q?p50K5278fD/9wKkujZ0KGWxTLGbtTpdXJHI66TDuh77tVYBaytbaeq6Esedu?=
 =?us-ascii?Q?23t11eXx84aOLYJx63CUMEQL72XQ9mQiaAXvJ/QotRBsXuZBwpfvHr6hHQ+F?=
 =?us-ascii?Q?q3U/bqovPLdYKWDjP3iWTl9G3PZLjHvmNqj7e8SR1WxDVC9T3rT1MAZkyK6Y?=
 =?us-ascii?Q?wXAIvXOFMqh15K/Kzp9wmQUUA8i8kSdJ1I30wYMcqpKvBUwQU2izssf8Sqdc?=
 =?us-ascii?Q?7ghTyhCBjrtWn4M7DCQzY30YXuB3VVhHKzah64SqfUVC9VvkYTMSU5hHVC10?=
 =?us-ascii?Q?xcSyD4ubUddQLAgKvYCnDk/8YTfs3949PNC3uql+HJxiA5RHBgjqJPJGbetT?=
 =?us-ascii?Q?UObSMMqEieIYH9XkPyX55qPi7YIpjLWug0Qoi1AKIGikg1PFYVy8toJTCgij?=
 =?us-ascii?Q?yq92P1t+tNoFI9wXTy9KxQoKUpHPPMA7Yh5bfW09scfuS8BLDd0RmxQlFzEZ?=
 =?us-ascii?Q?aezgxF5vpimS7t8AwpL6EwRihseOIHs7bnahZ3Fy007CrnBc3LW4KzRSsoOL?=
 =?us-ascii?Q?Mojm1Sw02uRgHr4Xmo8EJHQCShIhPY9x2IxEVVfcVzUqx1hk94vKRWAtXBBQ?=
 =?us-ascii?Q?M4bcvYW0N9Tk0H1MEZhEcCdauJNOkT43ZLCG3Y1xCHS3s7Dhn3JfSIdoIU0g?=
 =?us-ascii?Q?XDlTzbWht+yaIxa8WPRomt3HVDkwNFUv32mqTfcxtWRcgslZbZRzlrz7Emnj?=
 =?us-ascii?Q?V1J5UZyRTpZx2KQDOJGcid8wHhd4pH3IbXclNhLAqaPKaN82PZ+pjvdF6cBb?=
 =?us-ascii?Q?kOALrULAvn0y+UEIwJpWvcMSmLV9OxaE3hKOGFelYddB7DKLexECANR9ALeO?=
 =?us-ascii?Q?X8CxejFsj2WiCa6JOtrWdqw2gjCOmqnZXzLZrPWZAty0tDUbcKDbqLQcqYab?=
 =?us-ascii?Q?f2RYGydxe9ePOAznm2LxpICXtc2Es3RJliat8ujh8Fj++xLiWj7sEkAle7QF?=
 =?us-ascii?Q?b9rojFd63P7pqaEzc+HaUVZwqyQvu9UHhTMtgS7a+FFcfKUH99F3to8sF+/t?=
 =?us-ascii?Q?QYxupdCPG344TJbO3Z6142DGygu2gETfLlVc4YKGMjE8GKfDYNs0uuQ+stbG?=
 =?us-ascii?Q?bDrh8PiM7idAwQKM4begw4KnSCxt+jebxwJcRdFdpJIF3/jX4kWaGksgTVWV?=
 =?us-ascii?Q?geMauMwsArs4pQIaJQx4r5OJuAzRUukbB8NLYYQfxXonI/croK9+/Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865aae99-0022-4a1d-391a-08da0cacf2bd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:10:17.5554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4WXzWrpsTAj2457bGNaQc+e9DKkq2lFmbVqLpx0jatrnANyfg433Ghjla3Dc3xGR1Lc8gco8wMhvjAHSshHzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5988

This patch verified another member of struct mptcp_sock, ca_name. Added a
new function get_msk_ca_name() to read the sysctl tcp_congestion_control
and verified it in verify_msk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 25 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp.c     |  4 +++
 3 files changed, 34 insertions(+)

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
index 80e57ca1ea4d..0f8ced3845c9 100644
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
@@ -79,14 +84,28 @@ static __u32 get_msk_token(void)
 	return token;
 }
=20
+void get_msk_ca_name(char ca_name[])
+{
+	FILE *stream =3D popen("sysctl -b net.ipv4.tcp_congestion_control", "r");
+	ssize_t len;
+
+	len =3D fread(ca_name, TCP_CA_NAME_MAX, 1, stream);
+	if (CHECK_FAIL(len < 0))
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
+	get_msk_ca_name(ca_name);
 	if (token <=3D 0) {
 		log_err("Unexpected token %x", token);
 		return -1;
@@ -115,6 +134,12 @@ static int verify_msk(int map_fd, int client_fd)
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
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index afacea5ad9ca..6e7d2abf6ce3 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
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

