Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72089362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654066021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8pWsLhLRkMcloUowRbjzt+7hdZXzoh4CmO0chWZObc=;
	b=Dl0U92gm4hb72IfG7gmWomrtH0rKQtmIYMzvT3xHe17W8CZ6+NKi+AN579/j47n7Gh5M80
	pRj1cVaT0yoiv08D6Mo8oTOjxj7oTXKQbfooXEQN/8cuhnZYjKIPX253ylmzqKupPkg3a7
	mHGzWIpm5Cxl+l1m2n8cmksSgOS2G+c=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-0cY0DzV-OduibSO6XK03-A-1; Wed, 01 Jun 2022 08:47:01 +0200
X-MC-Unique: 0cY0DzV-OduibSO6XK03-A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9DjNosvTPKVi/SnrRw4g2mWy3aWaVD9PqrvFUklc1sZ3G8SblLnU7X2+GVYqdi0iVMN7Kx7ujRwCBEg1Hs5Rzhh/5iatH92iMkb6pgB89gLPAOegKtCTROTbS1UcHEFvNbF7M6EHm5tCfbabarANwa7kHgXPLjGlsTOjib97suZi6z+CPuJ1oQ4hVQStCUoZOl7dqyxjUWjjm+uMvHOWDa/tDooK6/lm2UUImeM24mgUmHHALP2AaEU6qSdGNQWm+oqqGIUsdkDu/4CR8mat2/DYY1f312weU7LVCdhXAMNTgxLowIb7m2dWA38i87NMDtk++u/Hd7pib7SUeBsqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrNrzeKQuG1cd4mbS3RRqBZ2rxIdyIm5L24Rj4PGrkE=;
 b=Ui56u3cBow0LDO9EXHjMVwmS6pKh/iYdxBF8oqkMfo2ehZlN85RoGjzh8vC7uACq/8ZQReGKT8E3jvR4hem5lTikUG7lcVgvgpg5AufF+Velylxy2uL6bLvvkbNCtYOd+UPPOvPcM+BVz5ap4lLNAbHRxZA8SJ0HcQrM5WpmbvMQDxiLpJTtiCHlbd0jvCoV135xd9VYE22g/qQR2JpD47JWeazgiXpBMVj9uOMHfqttz3hypSVGxpWXLa8+8X7UFtOCC9kdMyenYRJZLZYmLVnqEwf+HuHTalZ7uV4NwexbSDOSz4xkjiq/Gr+cbRUnK2F3YmuLhCyk8Y1oQS2+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6904.eurprd04.prod.outlook.com (2603:10a6:20b:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 06:47:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:47:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 08/11] selftests/bpf: add bpf_bkup scheduler
Date: Wed,  1 Jun 2022 14:45:57 +0800
Message-ID: <af98c198ae0c60f0ff7e980d06196dea4db575af.1654065674.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654065674.git.geliang.tang@suse.com>
References: <cover.1654065674.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c8e7b6d-b4a7-4ac9-d95a-08da439a8748
X-MS-TrafficTypeDiagnostic: AM7PR04MB6904:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB69043AAF397E48C59460A7FBF8DF9@AM7PR04MB6904.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RB0FTlDO49mtzcXPWhGqtpn9yNiBpKE+2itHU+RWsWveyAqUH/MHhmMJ1TOt/crw7c8J8J2fTQ4Gx7p2nqhg4zWEHReUvl4HYQaXZ1DkVzBzqB/tLaRCC2ymteWX66GnIiv9yw5nPGW0udRT50rvE4/dFKzAZvAmSNjK9j3f3nSt+Q2S5Dw65k7X0cvD7jg8X/rWmN+c7R559hE5kGk7SXZrbdxa8keN+9sbLQDaIKHEaF84C0UTScRMPCl2p5J6tbsM2NTe2pC8PXVRwfB+iRRNO+g8E3OM9Bz91jcY/teGRPnYiSLeozqAls5ZIV/8XzqSAcifBOvtB2bMEO35d2+kZdYYW9e1x+3ikpHMj7Og40aFOQ0Yege/ZS32zOh0ItiEYbWb4yy+ArI6kkJnyYCLVApiyrvM5kRndM6viSp7yidsDGzmm7W5TZjt9mjpPaFrby4dupHvjYjpxQRFXNUqhIsF9jHers9y7ame3pasA5kXAezhmjmFgy1By968en+KZ+AA8HgOwKFMVW4j4b9kxlv7f7uhP47I1a5RexFgm7S6BpNHsggBPZ9+zlMm25t25L7/msMQn2hC0souA5u+jobC+j70dOpe/RfhFHeQx6otgE2s3vy6Xr49eQeLGC6fVH0xzSZ4WMZdyxQ/RDgNmc68F9dBfhGwloPnlVKQ5q1OhIVFB2fODXdpjh6h0SsN9lDPx00v0jIVLwCcTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(107886003)(86362001)(6666004)(8936002)(186003)(38100700002)(508600001)(5660300002)(44832011)(6486002)(2616005)(6506007)(6512007)(26005)(66946007)(66556008)(66476007)(4326008)(8676002)(36756003)(316002)(6916009)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SpukuwQ3SU03DFG0TcI3ROymU5WozaLWfsp+09YmKlCduM6C/hwfonjO4jeb?=
 =?us-ascii?Q?KHV0uvsUq3RomIuHyQUli5tKDY+ehc6IGtA+MH/nxaoVNwIGoOTJRt5pYYjs?=
 =?us-ascii?Q?x2eKeFC4rnJXk3zdhnmPEWXKDO9c8m2hcoJMp/dNOD5xWV6eggiwIGF+qkyD?=
 =?us-ascii?Q?JoqR1VbjJmEorMQdoEPXWtarx/lOWlF6Kf5zDUYH28IM3Ys47oDHeaSBgkGq?=
 =?us-ascii?Q?kd5lDXAG7WocycBHEED3xtkZ9QRjwedEKSG9hNM90ZiukvSjcM3MEBuRltoz?=
 =?us-ascii?Q?Uui8+SXEVwDTi2ylRed5uTmzUdXSDkIPUlCA8O3nzH6Tv4lKKodgNLtHE+Oq?=
 =?us-ascii?Q?4CSnPZoil3fTBMI3iaeMLAkG47ZyrvbFZ/pQxgwzotTtuN+gRoYacpiL8bCr?=
 =?us-ascii?Q?GhDd3y/BznC4YfyuVZfBPgf9O/Rfsk9FtrFDUgCNTxc5P5XHkwHI0gQ2YiOD?=
 =?us-ascii?Q?+QisEHphFI3mrjRbx+c0dt7a8nYYXysRa+kO6dLlmuja1imipqQjRKTzVmu+?=
 =?us-ascii?Q?0yKBAk45sZk+KCinUT8UjL23UsT59pzgdNW1RSKC+4IfuKlaxXb0Y1ta5XfN?=
 =?us-ascii?Q?MkZ21hCH5ZpnnEVH0PM3A3yyrow7uwebjI4DTI4Dy0MuEH87H+KLujlO/pos?=
 =?us-ascii?Q?XzhXp/ima6tWlOwthbFpnMMuxvvp640wCiNEuXlq+NXnl1xqFj61gKwdKljJ?=
 =?us-ascii?Q?wBCQ/xcNgd3CUCui7KenKECDVmTiF4IUCHam4r0kNSYRnCxaR2pBhkamGpWS?=
 =?us-ascii?Q?A2Z7CnNq1xK4KTqjAYjix71mIHeam2Fj06+ip49U8D+r+zg7ayqtDh17SHjh?=
 =?us-ascii?Q?eEifZponDOr1xkNOY5hd83nULEP62L9Vmvvq2tGgczz7gdTGXhq7iHAch9SH?=
 =?us-ascii?Q?jAYpXKfTkuX4M7upphZDbZcTBgYmyf1EqeZlXEW6gxpxGzRyfwb+hdcOMrDn?=
 =?us-ascii?Q?KLRV2qadwcrl52QTqJVsEwStMjTjgK7isotBgtwRE46hTpujgmhafBGFvfkC?=
 =?us-ascii?Q?Xy+RerShq6JXIIgntHoAnCkBKFpTey91bsvqM7bRcYvGIkxM0E2RAkDkIzev?=
 =?us-ascii?Q?7lJdDrZTMiZ3Vy7LjIIrE+Y1ispJmBwyDIsiqsVfEzmOiB5N/sR/Q2XI7LXD?=
 =?us-ascii?Q?ScYor0E0vt9J+eO1VBEMd1mekOqydPVgGozDY8SOJWIcUOYRKEdTEhzJqdCt?=
 =?us-ascii?Q?QmH6K+Xgy4N1qGya2IpPjSdkAWf4iaGpH5mcGgNhawW/TLlxm0CGsxqeJWz4?=
 =?us-ascii?Q?qwgVdLDWWdiN7rRBzKkn7FBzuqGZidi/H+/viMefHrdj7tn8lRV2tbfkvpFv?=
 =?us-ascii?Q?Edjg/0GtJ8r1CNPnZvlXgIj9JPCUMzIEZEJtmvwt9UIuOTFcBoGhkb4JWZkI?=
 =?us-ascii?Q?LSX0yMr8H54wQCzobTo4A8zajOypysC7IjwCnxtlMfMRi9otjCVYFYCpxPSp?=
 =?us-ascii?Q?g7yePXVb6wTo9/JQ3GoQpwJzq3PQr7t6CsCjQxUS7HXYDC0wMEuHK9L7uxTJ?=
 =?us-ascii?Q?YSEDGsNmT4h78fxNbIm1uD4Rf9Ytm7Uar+/JSUo2OPS1Ph5WI3b/vDJNpOC+?=
 =?us-ascii?Q?H/bv3Sx8RtBUk+HwS5FUNvbmhgSmNozfTzWeTFsQUKO9Z7zFZ9c4juny8ddX?=
 =?us-ascii?Q?8Fmaao/X5vVwwrz2NF9cA9pSqCII8ntsPZUyXkFDeRa0Njae4WVfJtc3UOUA?=
 =?us-ascii?Q?Wj3i6tms4jUmEAu0E0uNRVdWBBAr+M20paiaWO5U4+Q4ohCZrdwPzE/I3Rte?=
 =?us-ascii?Q?u8WGGI5ovtQ8Wu75yk/p0T79Ies5Gew=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8e7b6d-b4a7-4ac9-d95a-08da439a8748
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:47:00.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH1GxCfj0IdRtGhyIQ2D5npzRsb3TO+UHe0SuNrVin3Ss+4YiFVw9gXrjuGoBW8IvYcvDsQdyzK+b0z2ZotZow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6904

This patch implements the backup flag test scheduler, named bpf_bkup,
which picks the first non-backup subflow to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 43 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 488de4b920ef..1f8addd61f14 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -234,6 +234,7 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u3=
2 w, __u32 acked) __ksym;
 #define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_subflow_context {
+	__u32	backup : 1;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
=20
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/tes=
ting/selftests/bpf/progs/mptcp_bpf_bkup.c
new file mode 100644
index 000000000000..2431d5f89150
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_bkup_init")
+void BPF_PROG(mptcp_sched_bkup_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_bkup_release")
+void BPF_PROG(mptcp_sched_bkup_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	int nr =3D 0;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], backup)) {
+			nr =3D i;
+			break;
+		}
+	}
+
+	bpf_mptcp_subflow_set_scheduled(data->contexts[nr]);
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops bkup =3D {
+	.init		=3D (void *)mptcp_sched_bkup_init,
+	.release	=3D (void *)mptcp_sched_bkup_release,
+	.get_subflow	=3D (void *)bpf_bkup_get_subflow,
+	.name		=3D "bpf_bkup",
+};
--=20
2.34.1

