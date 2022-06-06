Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4623BD
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 09:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654508869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SsBCKaGSnSib8yKzRg7exL65wED8f+Ur/LUxp2VQOk=;
	b=DdwbWIjgBMuy/5JjdUADpqzxBqMzKqO0Sb9Pgrg0qGM1MN9rvNDDVnATmiMyPpcZuQOsxz
	BJuDU1/mNV+VyvWTV0FEyAvoibNkghItSJG1riwKk58LX6u4aCPkXMAVtoIvfq5m8LIljW
	jDp4Aku9HR6uu6MTzL+8vv1pQJ9HuGk=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-S0fbRGjKMqC6FQsOCwzLBQ-2; Mon, 06 Jun 2022 11:47:48 +0200
X-MC-Unique: S0fbRGjKMqC6FQsOCwzLBQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBe9ZU+YIEd4AqFbkkrd/xmVPcoNgt5KXaudIaB+LsJzK5mvsN+fTkkT5yYMMaayFIlXPW6ImSNrgxmtEiWpFiYN7cgF4HnSePPLPxwYgnEWo+Zwdotp0/gL4Y+lr4Gc16+Xmkphep6t4uPcjK4HNO40oYKnpZZRO1VXRAUZ4WotzjfUJN+94OH1DEdF/cgmirCaBSxrs+w0c7KLCwbQsROTu3+G8NSNj0LIkAkRxnK+y1IrTGeylJzu07v9+ZI6z9EyB2PFH2a9oCo/xHVCyR4d4qV9qE7NO8tuivm8ESR5/5JcW/hiJloPGoIfG9bGYsoAbVmXcvJ4aJmi36chZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP3UBW9MaHYoUECvpYCXr/Jf/GWdIt6ZXQXJmbYnsTE=;
 b=SFlVgKZsf+GRBguA3uRTPXlsPu05jgwQFuAAOdYaaEus0X0hvfhgYf42PpVElRNTfp/oikictYp1J4FFL5GQYNjCcqCjYN7MX/HDOsJDPUc1iAjWiChreuuGxCeJ/TmSaaPVRK8pst1wt5gxAwYo6swV7NRuC4Jm5EKFGy10kGlafcaxzu1eM9nCz7Lq2Wp9bvcrVJhyZRt+We5jEF5ilEvsxIAGQxyorC+MkFTCpR0KFIhlwrGkUW1spIpn0j5tClVzQ57YBGVY///VMOgrwEHva+5SnkMdesEU8c+Jy/VplCjIuGkczLpe+7mp2J/L/4CFNMtNzo1jNKMDz4/iEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4802.eurprd04.prod.outlook.com (2603:10a6:208:c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 09:47:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:47:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 4/5] selftests/bpf: Add bpf_red scheduler
Date: Mon,  6 Jun 2022 17:47:14 +0800
Message-ID: <25eec1eb990715df3012c1b5c4c5e9b8a99d71b0.1654508532.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654508532.git.geliang.tang@suse.com>
References: <cover.1654508532.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f38d7d2f-8566-442e-504d-08da47a19c28
X-MS-TrafficTypeDiagnostic: AM0PR04MB4802:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4802943B336187C87AC64E63F8A29@AM0PR04MB4802.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O9d0U37O92t+l62GG1K7X2LNt8bbxasv9mhk6q3QjUyIxLolxai+MLkvat4hHO9wsyFk9GCNLx4btm0P7JwQBsG+8I0rpJLyPjGlj4y1oILWK9/ug7BVqKG89TZWRIZW6kzoOJtwxXtm8ReE0dw0gVomlXF7agRPB4wYVl0TgcGXEhzOgnJeKMU7wkO1cmMJsy6VKYYKjcPt2fWNWaKUPuqyAl9Z0cqVkos6aR2tliU5EF051b1570k5+EuIu4geb64tAvepLw8KLeZ8lNFE8QdDxrxnq9pJ4pPEDpQUjJlcAYWPJhF0IhLpwlebhfEljNdDxnL/iKdbomNbOLw9QVPjaOYnjxJPgsrl5Cj+UNJG3LwZz9oLHnlEiADNwSTspx5qjQHl0psrYktgRodtIdnvsHddFr4avL9ZNmN2YC/Z758AtxDgbRH4sI+aTOafsCUfkMnmM61mFuqJpElldcRIfzPM3wYqETMDWp8kJa2CtSmh7v8l209vPePkZmtMZ57USMnLSwATtAu++Xz9ltkIo+6SvKz+SzfspGUqW3LC7aXGZPOLyqR/f7ddsUft6nby+CrKUij210vSDjuDzhtMPcTImrhJw0NUbYJxYr8+CmYGsQOC1lYy/ip0kMJkdGOsIctXHKijhRvqq0nLaH3Bdf2akKl6nhor1BPS3B8J5e/Y/TgcVMfR/92z5VTyq5S02iWcKKQn2UCQQdpGNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(36756003)(6916009)(38100700002)(66556008)(66476007)(107886003)(316002)(5660300002)(26005)(6512007)(2906002)(4326008)(44832011)(8676002)(6506007)(2616005)(6666004)(508600001)(6486002)(186003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fgIWybtAmvaDsKi3Z2fZ34wayWh8SQzW4DDaGjGm8KdtYXeGGP42WjSYl10m?=
 =?us-ascii?Q?Q3Su88BkCUfjMd5nxrUiHZBqR+H1jo6eIdy5tkoShGkuLbXg2qM0suLnw//O?=
 =?us-ascii?Q?DplsUXBO7YMGP3Hur1Vg69pUgim2CkuIvKJYWPBL98/+vcNwizTlvnzVVojt?=
 =?us-ascii?Q?hRffhf1GVtAMM3e6emJ42vCTA5CZhB+2OgvbW20CgStFgod0JUpKxythI4En?=
 =?us-ascii?Q?UavG8sHtJ5DUEkQdhEKFD5JP71kfBwVefWRjxiCvnLtXOw2uECw9sLAHErwI?=
 =?us-ascii?Q?Ss3IVd7lQs715Pcp3V/Q22dICx3uw/v2WLm7UMDarxUqYP2+pSeCBPWFfljq?=
 =?us-ascii?Q?1UvTybbp3JyYy1xsGR5C0W1vQPmpt/vio7O7OSrtKD0Kl35OAgold4U0aQCr?=
 =?us-ascii?Q?IR8HGqEn5Dsw7nNkB7LmqyvB5kH6Rl7GPRLx9ZbBrNV9DOZndYSf21rHSuKM?=
 =?us-ascii?Q?ukRyeUPyi03VH80ik2QxX8YYX5tl2MgauhJwl31bOLYblfiGqNmGv6/+edt3?=
 =?us-ascii?Q?EBandedSX1r0PG116PrvoXpANeaMIGuMU/mouyu9IZTT4nmExe0ZEpIe/YbA?=
 =?us-ascii?Q?9LWSUEwQIXBbD5u6FlA4LEteh0/vSna/ywR1hipp1hSSkMUo0hKaX0VOQCrF?=
 =?us-ascii?Q?u47aYOkpmqR3tZacmtYOB8fZ4T8tjp8qYuTobLOKxL1RQuhm05YPfE1gtYhL?=
 =?us-ascii?Q?qhsqHKwe0BDNoc+wEMOX8iespo6Gmqt39NF0WAVoG4A+LoGZCEoiqRXD+tmC?=
 =?us-ascii?Q?+NeaqMRr7UkJOsH6bjqPu3CqNLxkCNIyVAkFG+tYHNSwXYtuaBZkjuHxShiV?=
 =?us-ascii?Q?rBWzGMG80ideOkaCJ9VCbNHrcwYoewsmLRKhcP7xrz/IMVLkl32h7uxpd/ca?=
 =?us-ascii?Q?rDvGoWZlKvMFanVAcm0/5H1t/vPp3cGKLsANaNqSEDNXVFYJVxV7yikASGZ4?=
 =?us-ascii?Q?pVT8+o04lEMTN6K+PMepG5iFeqG+/VcgaqCta3Ewj1xhz5KylBbAy5E/unFV?=
 =?us-ascii?Q?eECubUpPKTeDixyiC8Rsk5XsrWDyG6J8wSoT5vUXAzHvkcaqUJvVXrBrZ8aj?=
 =?us-ascii?Q?qMXYiTfsgIsZXVN65RCev/bag90VKFT8Xtx4evA58NO/boujQOfmzVncO+Xt?=
 =?us-ascii?Q?TIYe3lIYusI+qWv4qyS5EgWdnPNrOPIXABIk5ttssLVlEjjgGcONuU22j62q?=
 =?us-ascii?Q?IGqWxhskPbuVmH6UQS/+jUAlH0TitJhh/HoNh19X5Wy8VDgtmEFbA0aeF0we?=
 =?us-ascii?Q?sF/VY1QrJEkNrPhUe7Rr/FR1k/j27LSUBLV5GKApdyLWZ16tzyjBbezlr/UK?=
 =?us-ascii?Q?jzPxBoBdH4f6LyMoEBkHajnWCnUcs/EohA8zHFEP3CSd0c/ku53MpjsZRSb0?=
 =?us-ascii?Q?35CpBQAVXolx0vOZ42vlcTRrff9ZUllODhi7QYTEr4UVTjIq0Y7q1O65sPTY?=
 =?us-ascii?Q?xc8oYbV0Vg3iRWdqEk77s5A7iG3GqdSfohtk4h5chGvdN5ku9S7N04mpN5pN?=
 =?us-ascii?Q?fpic0r9PYcpA7UKQxnnPUuURcab0L5F5pXhOfWa1/reLvE9LB5lOFnhGcCEa?=
 =?us-ascii?Q?VGFNFDzthcdE0z9RHO+efq5n1isVzHeCtFu22O4GsaYWr+Rjnzrm//JlBBGY?=
 =?us-ascii?Q?qYT5W2Y5R6lTTmJoiizWLvgYxQtm3H4I4CXcWMhxG09iK3M52pF2k+F4HanD?=
 =?us-ascii?Q?C66xsR3yIldO+awUKqbXB8WY9tNYg+rkNorlF07GDerMAnCuoAKPFMp6EMhA?=
 =?us-ascii?Q?0eiqBXTe6IKXqXn03NbaN7AkQrjXI3Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38d7d2f-8566-442e-504d-08da47a19c28
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:47:46.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFQwRfxq4PvenPJYX73N/NIqJTkui1ikqp92gXUKNaOtDXIqZpp/owGRbSFPsI8IWOYVzNfcjTTHKTLwXWst/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/test=
ing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..58f90473e495
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_red_init")
+void BPF_PROG(mptcp_sched_red_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_red_release")
+void BPF_PROG(mptcp_sched_red_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red =3D {
+	.init		=3D (void *)mptcp_sched_red_init,
+	.release	=3D (void *)mptcp_sched_red_release,
+	.get_subflow	=3D (void *)bpf_red_get_subflow,
+	.name		=3D "bpf_red",
+};
--=20
2.34.1

