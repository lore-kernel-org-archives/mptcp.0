Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3907C
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 04:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648699350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+qBVOJliKY0hyhlNHPkQfxIIHP6emS8Hf8uUZHWUnu0=;
	b=E4EvFhlmhIhiK0XW9waSV8ZQ9Si9zukgYoHSpJ92ORHlTPmPzNdxNqk9TfVFrP30hBc5I2
	fXROBB+b+1hPw+5P+O4D/5Uumh20a0QdSQX+0A9HqBxbEhAcpXsP8uBnqxHHjAg8D/9tcR
	k8sk6yLGNZZ95rfmEZEOLZvkqQRjM84=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2058.outbound.protection.outlook.com [104.47.1.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-6wwYmNMNNkehCyl-I7gncA-1; Thu, 31 Mar 2022 06:02:29 +0200
X-MC-Unique: 6wwYmNMNNkehCyl-I7gncA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kyp+RbHTXGy5XrI58c0wTTPIz6kUR8l6ypYyceYQzDGTOzsPMy+7tKx1wpxvgdIwVbAeO27kI1fTAy5ISXgpMjW2QXz2noX0dpESir0viRH2a+HxAwg2ZNg1HEwlkVdoxKKhSqzEcoeawk4AQRWcK4GNrH9JkzDuXmClzerNl16rt757mO66MCmVwckp5+d4T7g3VPciGYqVnfaCuQMRxVMtpfoXkleYWfk7Xk7DYHh+ro8hOOpkmI4sn5mGq3ET6+8A6MBCB5lEd4EVp4gP+0clZstlkT+y4Ww4tPgkDvcyk04YnyolpPWMobah1WNFA2rvZzwiS6bftg0URVesDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8Y60nGWaAbSAAZNv6julhhe3kD1Q3tjvwPHPSkvRWs=;
 b=eFKkUTh2zOW9Z4qmJvQmbiVShlyRwK8We6xY8JDL2I9sRetO5reAHUkBb+Ou2Tn0oNumlessewRqp9f1s8j24kzfPoP7mrjwd90d6WUqofFWdVk3mfBEMvjY0GePTvn8Rx7Gi8AEEXDc2nMDwaRWiHt+XYjRbEWvsje8QfogmGWbThon9Ltj4Arp+cjOoFuXCHCnOKzupkqwGHtSu/atnGwdmkeZ55OpjVuTCH2jyNfPJLJM2Bzgx/9tTAB5t8j2pXCXoQTPe6wV6RPm7hjukdNVjL6B3lwb0BrvQPLPUwchw1kHlPThghD5znOotgM5qyKsaQ2AnTcg5atX28L4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB5819.eurprd04.prod.outlook.com (2603:10a6:10:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 04:02:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 04:02:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
Date: Thu, 31 Mar 2022 12:02:26 +0800
Message-ID: <887946d32be141ed22d8af53f1a52089258f954e.1648699284.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3e12f9a-537b-4919-6f42-08da12cb44cc
X-MS-TrafficTypeDiagnostic: DB8PR04MB5819:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB5819E289DBF2D7FF73C5F0E6F8E19@DB8PR04MB5819.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iBy9ZhvZx5226T5fN/FOqiahRjpxkYZPrmmgbFSs1JCUwqsOpuvm4ihBd37VM2zH7K6PN6kFEBG6GDIgyvxQtIardNjrn018g9FgvERZ0asGm2XNJ5QJubTjxKcmzJb6bvZMLSKFNim9LuDUpSkTyBWwlI6BDrR1mjCYhu451qSDDjm6O5ghMTC9GjO/BTg9C95escxDN+DKqjq8ccW7wILELHgJK91Eh2uQ3dwmZXIIq5mE9uszuZrEIx7gp456ig8fCmPJ33au9M06KRSIZQ0w1qy+dYuYj7YxNB0vuIaFxgPseo8BGE7WkUPUDN4gBO5qEzXsLVqkDpa11RBPANMBxyv5fAGm+xy+DolnmYYI4QkKwVURH/f7NkhMR0J+kSHI4PJHYtystxaDP0cr3KPwZQt7AIRu+vwKIz3PGmA2FrMglbrec21MERG5fqDp8NKZMlgwV6x7Xsy/SexB6wEr2w0Z1szSsC4u4m6xN5diLIbVEiQfr84MYIdeYnGEoYHWRxO+GmDdPUqfQHMNT289r2pThUIMSDdEvcw0DzXz0wlwxOvQsd1ymtM+BbUIc/koQyXzGisBSMMXvH6Tf6NgiwROY65x6KV9OyO2NBB4pxr/17s7DRA9BNzkRXMYqVfX1GZtwDZrqHdjycHQ+A0D09darW+SaiqnKE3oezqdhW/5KVERLCmXERI/WgS7tx3K9IRA+o5FWg3AAiLNKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(86362001)(6512007)(66556008)(66946007)(66476007)(6486002)(2906002)(83380400001)(4326008)(8676002)(6506007)(508600001)(36756003)(316002)(186003)(2616005)(107886003)(8936002)(44832011)(26005)(6916009)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n2GAwOZd8TcN1usa2qdEanhf0RQuw20H/uCQ66kQm2UazWKgyF52QnRlf2t8?=
 =?us-ascii?Q?sifbMBhVtq3gbbc2pggD9ZGNtRiq+Ix3NjyblyRmHGopSJTUSHDixuEPzXB5?=
 =?us-ascii?Q?VIAoqb/VwaWzGnhMttBi+K4B0u37c8ZO92Ie14rUSr1UnGlrNZfhGkhiDGUw?=
 =?us-ascii?Q?2ebnJ0NFqLXmxGpPFIo4D9YdLAzffk2hzFHx0NcAb5/2fyamu8NKtNAVUhRG?=
 =?us-ascii?Q?HBaSETXOpjD8mwVnKZRnrP9mKYFT+zTAArpvqnMK2L1qrtEHV9F8gjSj77d6?=
 =?us-ascii?Q?4mYdqSk41VFmbc6BoQp7hUK9PGU1h0nRzwMrBTvK4guE4cPkfrGRmz8IS3LV?=
 =?us-ascii?Q?YO7BJeIUB3ovYwMXxmpr7FCxBK1ANGe39Fa9nsigAieJ/jrnojIYPfxI4MZo?=
 =?us-ascii?Q?LUQrX8rH70FVINZORrVJM76pZsxlD1a8CvN8PLYjGuGx65VMI1s6YLlTXaCr?=
 =?us-ascii?Q?qN4nAH4Nr8KdE3QGUKXLFXu9noTdID+oICbqPHDT+KDfGY+rhEIAxDwwdFyI?=
 =?us-ascii?Q?6N3wK3kKWSpNySSYkKtkF76TukCfKKGO8lxPORDDee1dKtQCEuSxsGe0+7o5?=
 =?us-ascii?Q?krkmKcKF07RCeUNmyTXD03aFArF107zV6dwVyCI1kiO37XJyA/Zhl9dpRI0r?=
 =?us-ascii?Q?2Ue3wf4ZKVOX2R7u3YKBP2oadLJH2+PG2W1G1RQWmrDZaiv/EkLMKFvlK4Ih?=
 =?us-ascii?Q?GOF0VXbv0ogoxYqeKGYhb7PMdGRoujA9t6NBTSm0zqoRaaGHtyVr/f0UU9yZ?=
 =?us-ascii?Q?5ce9tMFNj5d1V/Xu/gdQGshRk8cUc9hUeqXbuOUa/gHSPXMcyIEuEMHG+fct?=
 =?us-ascii?Q?DyqO7FHLtbBMEDpkJ3Z9wrOOMbfvtBtxusxwe4xzB2hUyFI6/swThWlPtRTp?=
 =?us-ascii?Q?8YNlac7DgwD7f2hkP4TVu+YLg0/tbJ2OMLQhKa3+TwCbFtqd573Jpr3NHJEB?=
 =?us-ascii?Q?ALvzRF801is9COs1awOt1fNG/1QY9pYbjT+1+oYxQeLfACNB1VJacE0EFNjX?=
 =?us-ascii?Q?yzX5fY0NnDXZXa6sFS4bzzJpjUiOv1OQTSiXnlhtZ8CSrPOAhoZRM0NfKg8u?=
 =?us-ascii?Q?Ono8922Et/mEuLbW4uoAJN5q555PtFR+Wuc0osqs6K4L4wHO+F9+6naWt1s6?=
 =?us-ascii?Q?JLYMKAnrt0apI2xC8u+aFhDHiAB96fIfOq5vWJGj4eTeBV2vXbrACi7JYGap?=
 =?us-ascii?Q?Npo5bt6ghEMm5EdBNJeXdc8qPprev+imMEOgVoLY3612KSbbm3v4sbThx9Jw?=
 =?us-ascii?Q?ZAmEp3VShtuPf+0a/9eLZwqFyc4FKo8O+hiuVFhxIPftj3c8n/9ZgoRnAVVK?=
 =?us-ascii?Q?DcR/rSyfMGkPNdRYh99PEKSwYbvXHLwHOZWa4D5fCSbD/WRy7n1jgygvFXEz?=
 =?us-ascii?Q?PhcXTmTqNPGX6DQ7ii5gkxfWWOTUKdLBut3ChtYW+mYXPcsxXaA5KMG3ab8i?=
 =?us-ascii?Q?SN/SFfC0dx8GZ3uZOKGBCnRjCnYeMcTo7Woz8p5pgwSxd4XFwLgJVyzaUkzy?=
 =?us-ascii?Q?NA51WLxzezYQ+anOUE0iOn2Nz2d+EEh554cFNeqE04qZLxv/fba5OvYUILhQ?=
 =?us-ascii?Q?3pUmytNlnuxVwaQsuAl45he5S9Uheu6As4jDHk4jbh1+WIuSNhpPk7fKGCtG?=
 =?us-ascii?Q?JTW1j9+A3YdhDMBm+9SVVsSD4Uu7+Ejd2qtZZWMEwi3SE14t1m45X06fQuFH?=
 =?us-ascii?Q?0Q/+vwGx4M6ZkWMz4BGZlFY/RFW2QKrE9V2MC7K7RNLE1r4K8qDI8yZ5inC/?=
 =?us-ascii?Q?5KVK5FxejWnTVxuy6WAcQhgawoyMVzw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e12f9a-537b-4919-6f42-08da12cb44cc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 04:02:27.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOBa9ButQhYiWxSkjJWgZmVn+S6cJEMkYU9QrjP68TKxT6shGj8VDRPePa5AC3hu2uRcH/LkxEXNRBvB8rp67g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5819

Use dedicated bpf_mptcp_helpers.h for MPTCP tests, instead of sharing
with bpf_tcp_helpers.h.

This patch will conflict with the next three patches.

1. selftests: bpf: verify token of struct mptcp_sock

CONFLICT (content): Merge conflict in tools/testing/selftests/bpf/bpf_tcp_h=
elpers.h

Drop these lines in bpf_tcp_helpers.h:

'''
<<<<<<< HEAD
=3D=3D=3D=3D=3D=3D=3D
struct mptcp_sock {
	struct inet_connection_sock	sk;

	__u32		token;
} __attribute__((preserve_access_index));

>>>>>>> 81f7e2dd50fa (selftests: bpf: verify token of struct mptcp_sock)
'''

Merge it into bpf_mptcp_helpers.h:

'''
struct mptcp_sock {
	struct inet_connection_sock	sk;

	__u32		token;
} __attribute__((preserve_access_index));
'''

2. selftests: bpf: verify ca_name of struct mptcp_sock

CONFLICT (content): Merge conflict in tools/testing/selftests/bpf/bpf_tcp_h=
elpers.h

Drop these lines in bpf_tcp_helpers.h:

'''
<<<<<<< HEAD
=3D=3D=3D=3D=3D=3D=3D
struct mptcp_sock {
	struct inet_connection_sock	sk;

	__u32		token;
	char		ca_name[TCP_CA_NAME_MAX];
} __attribute__((preserve_access_index));

>>>>>>> dc3031fdfe35 (selftests: bpf: verify ca_name of struct mptcp_sock)
'''

Merge it into bpf_mptcp_helpers.h:

'''
struct mptcp_sock {
	struct inet_connection_sock	sk;

	__u32		token;
	char		ca_name[TCP_CA_NAME_MAX];
} __attribute__((preserve_access_index));
'''

3. selftests: bpf: verify first of struct mptcp_sock

CONFLICT (content): Merge conflict in tools/testing/selftests/bpf/bpf_tcp_h=
elpers.h

Drop these lines in bpf_tcp_helpers.h:

'''
<<<<<<< HEAD
=3D=3D=3D=3D=3D=3D=3D
struct mptcp_sock {
	struct inet_connection_sock	sk;

	__u32		token;
	struct sock	*first;
	char		ca_name[TCP_CA_NAME_MAX];
} __attribute__((preserve_access_index));

>>>>>>> afb45ac4de7f (selftests: bpf: verify first of struct mptcp_sock)
'''

Merge it into bpf_mptcp_helpers.h:

'''
struct mptcp_sock {
	struct inet_connection_sock	sk;

	__u32		token;
	struct sock	*first;
	char		ca_name[TCP_CA_NAME_MAX];
} __attribute__((preserve_access_index));
'''

Note: 'first' is inserted between 'token' and 'ca_name', to keep the order =
of
mptcp_sock in kernel.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h | 14 ++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h   |  5 -----
 tools/testing/selftests/bpf/progs/mptcp_sock.c  |  2 +-
 3 files changed, 15 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_mptcp_helpers.h

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
new file mode 100644
index 000000000000..18da4cc65e89
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2022, SUSE. */
+
+#ifndef __BPF_MPTCP_HELPERS_H
+#define __BPF_MPTCP_HELPERS_H
+
+#include "bpf_tcp_helpers.h"
+
+struct mptcp_sock {
+	struct inet_connection_sock	sk;
+
+} __attribute__((preserve_access_index));
+
+#endif
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index d71616873a3c..b1ede6f0b821 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -83,11 +83,6 @@ struct tcp_sock {
 	__u64	tcp_mstamp;	/* most recent packet received/sent */
 } __attribute__((preserve_access_index));
=20
-struct mptcp_sock {
-	struct inet_connection_sock	sk;
-
-} __attribute__((preserve_access_index));
-
 static __always_inline struct inet_connection_sock *inet_csk(const struct =
sock *sk)
 {
 	return (struct inet_connection_sock *)sk;
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index a58cd24da777..5cfaec4e7245 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -3,7 +3,7 @@
=20
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_tcp_helpers.h"
+#include "bpf_mptcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
 __u32 _version SEC("version") =3D 1;
--=20
2.34.1

