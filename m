Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6F7B
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 08:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648714518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/TARNDr7lxsuXQa/UvmYbcfQRE6kkV47UXZXdKVQR0Y=;
	b=bG91JxQeQLPPEedygz5Z+Pqi1zuNhLiAyYVS7ov+XmwAnj20F6tbDiO6pTHBCGQYP2JD4z
	mB2uHyL24BPDbDesygfbni41JnbYU7TiUtJIxoVypIUQ5PYIw4DQ1vxVSrJfaOtKyE65Gh
	mnhtPhae3KeuQ7ZdaDeCRa0o3Fv8TMI=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2056.outbound.protection.outlook.com [104.47.8.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-y9tsLTwaPxWyCNqPrIZ3vA-1; Thu, 31 Mar 2022 10:15:16 +0200
X-MC-Unique: y9tsLTwaPxWyCNqPrIZ3vA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErY1IyatXSdaObxPA9DACLIG8lNv1Ou9bMO+6E9GElNSewS76nob/uH3iherDAigBq4+5edLXRSGJIYwEoZFFAGwwnnAMizXHeaHYHmMqdi1WMZiEtUB41qtPkVO021AcQt1Z1c7QMO9/V+yLcQ0tzkLZD/2Vrm7DNKZ5X9d/VqKmekPk2dyNMKYVb9pehFJuoIUl527ijWEoxQ+ndmSAZdtKavXu9NyHkANEJZnbvPWferPE8pRjLK/DMaC0HVkmqUkpx31NE7hjn37Wqw363+1+qL6QspmVq7SiuuXI3Vv3vXFFF+WgPrw+1hGg4B91OOd9UHZRRumcxvXkw1TJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUYv5nmboUNldbBpoYh61KM/d4gHsQ3uT6wpcdMN1lg=;
 b=NR4GmL6gYsMML3qm9KzZQjYkycyVVucwdlCLFRUOScgsyyV8uMhaoJkoUYoogy8BCbv6NwmyGSXOHnKvU6puG5WlT+hGYCyXL0DcX127eop+K5E7Deddg46YbE/fgBMosJM/WgOj/vE6OuK5d2m/ZfuSf9F8R2dj7Qspx9sGEOwH7lgpDw2u7/DHJGaY+ckly0mI0LoKsBsPohHNIpnntuanOknjVifKe6O9tElcHqJwQV90FocZzDkNhPtKEyOFH8fCt2okNQO+8rfliaNzniy7mG49KQBR9R9HViq6XcAlifH9dVfqTaXsaO7xurvnDA2iND/BxxdTeDHyuSASrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8966.eurprd04.prod.outlook.com (2603:10a6:10:2e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 08:15:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 08:15:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
Date: Thu, 31 Mar 2022 16:15:21 +0800
Message-ID: <ee4784e6ba97d5b44994fcad328d4742b0f0ccaf.1648714461.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:403:a::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1217bd73-f6e6-414c-435c-08da12ee9608
X-MS-TrafficTypeDiagnostic: DU2PR04MB8966:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB896678A8299C711E2C6538DEF8E19@DU2PR04MB8966.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IwYphyZ1AlpRnD5fckykXRRyaZY6tQ6nrRwws0TI9S5XGFFRaC7H0dMBQ+lJxX4/pWF5umJHUcGkbfIBpxuQkFDHNSWgKavN/xHHQ9O+mFMkjBxjD9kfQMeoWLHbuJ4t1k/blCRWaFGQ9Df8lEX/AAXLbTpD3egd55ezUOw1WuTILAo3JpeUZPRcIBVoEVDbx+F6JoMEUh6oAeWaG4MbpZON1lNMN5bchgqvO6EFSWw/Mtq8QkIK21kQr9VGbtjsm4l/D/vuFG6G/8Vfh5k5f19mraNB8mp8c8XjUlbtrpL2dwKXYM4O3kmMBdC31gxBsc3EZcmf86iydixwPYIuRgl+FaEVX1kDiwiaTjItSH6lsTGc6xWe/fI/VHxjf/u4P7tHF3EYo2Ou3c28qHlsOn92Xgy/SM6BjZSCGz+tKZc+WJDHUWueYX6O8kbK/zxPge1xh8SVz70ohS2+J205PGYofeADA5289tl5swJNEfge48FRkuDD8HHCsnmgyqMLlshMVY8YFoSwZkInw2aB3rWUNu9/KUocTUK569+FXjTYLxzNp/co20Scg5HA5DsD7iF4mfoOLogafo9uxcs9+i5UDQmRAbHBEJeNjMA5AiiNhONwKAdco+sElTW12GRhpAJ5e73HK5+2sJodAi/UUGxDpc4jZzCLEgOXJdemhJElIMIHzU6UzimYfuzw/BY58zKRjWr/LNE+IQpTPMB4ng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(8676002)(66476007)(83380400001)(66556008)(66946007)(107886003)(2616005)(4326008)(186003)(26005)(6512007)(6666004)(8936002)(44832011)(36756003)(6916009)(316002)(86362001)(2906002)(6506007)(5660300002)(508600001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?khHI0xLmy2ftyiO68T3hCjcRHtO6LO8BtJEJaA4LEJOVk0GaJOF+INR5oazN?=
 =?us-ascii?Q?3DEd2rvTjIdPBkMTdFbzBtaLIFZRt74/EaCT+1lfMgsS77ZSMppWBzCY47/T?=
 =?us-ascii?Q?V2ImnXPaGn2gc6mhmzfKwy8WZpWn9Nvyvh8Xh6AjBX58qoGzqHc5PJ/neSzK?=
 =?us-ascii?Q?84ezBMP0QaFe+9GsePtiqvBCEFk3rIfm0z+rhlxgwGcwx9kPG1kx3L8XBXCL?=
 =?us-ascii?Q?rQDqwQqhzMnHhnBxrTGe/+hjRy/izuokROAa92s5bNF131oOT67IVnlg+4G+?=
 =?us-ascii?Q?pSnZnpxWxUMcPUAq5ZAmE2+K3KOiXxEijVmGCNnt1q+VYi7FIvUcdIMRRB0A?=
 =?us-ascii?Q?Y038nN8h9uhM5MdXXFpaI5BM/LGUyurYEoapbd7fZ0OEaq7yCxBCgkXoLXKd?=
 =?us-ascii?Q?JOgd3UErFsBRwZeKKZYlHZ1GOXz+/48o2gQ2t2E+hgKZTgIFHVIR0SxjIjes?=
 =?us-ascii?Q?qW8YHvRvGZ4tW661leso3/ivDSYJqbCeDaVSBqHw3WWUIn2ApamaU88NoJaE?=
 =?us-ascii?Q?vdYnjvmhpfyhHY17MTqJA5dVvlWwDvU8dSEVmLt0mcBlOpcUY1MxWFQ6qAZ0?=
 =?us-ascii?Q?O/PUaMTYtXvZ4v6ATOOB7xyZrbIe85Ch177tusY3X2abOaCNTml0s3P+5cXx?=
 =?us-ascii?Q?IHuYqaCJJe4TICY64LgFElBkVHzEi9yFsh2/qm//kQMcRN1U7TTD1xMt/vj5?=
 =?us-ascii?Q?Xcq6aku9dy2tibZl1E4QHgLJOMvHV8zeOYsLsdYpMtRweNw5RNZFHt7D2nW5?=
 =?us-ascii?Q?uyqRpuu+DqStu5vBPjf33eXXsLojCzxNVApBes4g88dKyNksw+VMrg9d81od?=
 =?us-ascii?Q?fwNuCHsc3kN/IALYSbdywe9GV9vRrw2f7Hbw3grjMPJC27CqlwiWV+o7SH3q?=
 =?us-ascii?Q?br1bhb4bNS0aolOOiYzvxH4PbSnZNiX/67Z98lkP8TpmV9tDVIMXdbN5EVA/?=
 =?us-ascii?Q?nhOIMPQAsl2iRsl+ahkr3IjCF90NYPidKoUdzBynBwpSrx+0cQ+Z2eiW2Lei?=
 =?us-ascii?Q?AGddV62xW2q6wplq42mX/ZlveeFB77kfTy8lMXnQFOtIRbUIBlEMcca2dLvc?=
 =?us-ascii?Q?r5JmmOy9LD/TzJscZrPc+I7bA10RaTJISEEYCnrCYbAJhMH3ORG5cudSw2xA?=
 =?us-ascii?Q?mP/dheNN8n/ul+4E1kT25YRH0UsJhwrpEsNDoqhEys/Nh3ARz+q8vy6S9OzU?=
 =?us-ascii?Q?1uJFt8Mt+MvACuf4kqJ2GfnPMvx6lmBmvVZvvN5X0v6XSmKjlPttTIadPktY?=
 =?us-ascii?Q?Avv89Fbj2K5ddpW6oOGQwnqzWU9XWtI+uEUbmE7UDB+sBi1wZlVjumb0YE79?=
 =?us-ascii?Q?AQrXyndp7LP1Ixc5Z2QOA5MdHasbfqknZOZ4REj3LSq4TXpPKzTr8C9CCHub?=
 =?us-ascii?Q?ohwJ1rjtxnyMVLvoV41/wivFGi6UnS1ATzqN1mtn3RPJ80eA7mX80z8aWvvk?=
 =?us-ascii?Q?A83yVhx5Z/5zVqm67VY3+IXytWM/raaZBYsEZlrc0FLgcfCugG5Cfk1oE771?=
 =?us-ascii?Q?3TapOCzND0ugBzsu0ef/yQ/F4MRprCWKtfdA1aAzAeSv7BHtGXybIP6mYqij?=
 =?us-ascii?Q?XsPgjw2Ptc2iXX7a/QS143SvgDs95au5nhyOqSX5p9kNNCrC8Yy2xHRZTv9l?=
 =?us-ascii?Q?yjj4IojfnXXCtWEu2NDdz61i6qD33hXiXLCvnC3mBFu5H1XAJ9L33ZEYv8pv?=
 =?us-ascii?Q?njsUe/C96v1OhTcxQFAxpT5dz/gnNqKMXbkT0ni/PfcE338nMDPbaH3MYEMb?=
 =?us-ascii?Q?6R3ZeSKz1PLJNF3tj4bGrET/a5Ij2gE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1217bd73-f6e6-414c-435c-08da12ee9608
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 08:15:15.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGFUulXAdCKBNSqI4p89E7R25V0EWeABmP/asLkCiWXAunHJ5p3nXrx2ZdMEpzftzVg7+H7YBhh6kBRAoMwBuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8966

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

v2:
 - Update newly added file in MAINTAINERS.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 MAINTAINERS                                     |  1 +
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h | 14 ++++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h   |  5 -----
 tools/testing/selftests/bpf/progs/mptcp_sock.c  |  2 +-
 4 files changed, 16 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_mptcp_helpers.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 778cbf7c5a3b..40a62dc29e31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13745,6 +13745,7 @@ F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp.h
 F:	net/mptcp/
+F:	tools/testing/selftests/bpf/bpf_mptcp_helpers.h
 F:	tools/testing/selftests/bpf/progs/mptcp_sock.c
 F:	tools/testing/selftests/bpf/prog_tests/mptcp.c
 F:	tools/testing/selftests/net/mptcp/
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

