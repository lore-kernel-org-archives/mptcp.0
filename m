Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C47E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653033954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7d8NvmdKCiiH/RRJIW3gvKPGOIsA2nNqV4LQUx8UVj0=;
	b=DVbN8eElmifSi4K+CZtQg2JaJn+gmzjYPKljcytUHV/tqffwFdLco2DupvRwjJ/kdAX5CE
	wjQ/Eq2s61fskoghXaNx7/tnBFLT3RE2dq5i++XBTAVPkdjYbKoD6butHgY8WrsWG5ZfGd
	Ak6RX2Zpxo+VChEO8DCtrhqs1LtD2u0=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-t6t9qQ2APya93uTDG-SMcw-1; Fri, 20 May 2022 10:05:52 +0200
X-MC-Unique: t6t9qQ2APya93uTDG-SMcw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDKk6wWkz/S4PLaDUBMo2euWZ9xDeqjYpzGWGpiUy/Tcqb24w+kszmhiwtvEzusJMuZnK7TSQ5IK3C8YBJgJyTprQ6kzvjnEMLvKzV8+lg6N8GRIWTvOS7Y6OvJZaqolt8DUI8YxmWCiIAFXSNTINZqgqV/6yq2Q2sPm3hugRNWnEU2pxWkq2aB8TFEZygH9p5llm0Oow0YQbcLUgC87Wqh1R4epETzV7vPmO7cqWbqM1NHd8pbWglqXRl/6A61zX3Bk7uediYd6f3zk3yKRVzGMLfgr+VxnhmrJLHWscQKKWhxObCDIKHIxqTPRYFFf6h8GsoRyONXiUgadLflM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NV4vZRspBC07KPqjA81BhSi5G3a10XdPpisiE3wq0E=;
 b=INYD0CGOAaJQ0jc4oM0PxwGmrmK/QmezwJ4xVme8M0Yhs/VYManH6jEDHaV4vsGXYs0dbgjLtFmRGnzxd5C66qbSPIq40DDFpuV89Xu8kCnu2JEx2YK/da9woMiv8JcRQo92yHORHFtk8QVZn2LzEYNFpe1/oip7o/jBDYOPGxEC9CVpluktIzrnQyrmLlXmaUDgbSLBOT01/sfDDlWjPpvhMLjZYM5IRi3XubcYhpnmtTAEKU0YOOpYYsJiQqnijIldPo3Xcz3LoRQ4EjwCbgVGiwdzldb+m0t9r1dGOpW6ZQTYrZ0uPcZ39b/10Sk0iSClwRbncN04MN+NaH0wKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2757.eurprd04.prod.outlook.com (2603:10a6:4:94::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 08:05:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:05:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 07/10] selftests/bpf: add bpf_rr scheduler
Date: Fri, 20 May 2022 16:04:52 +0800
Message-ID: <6362a518b317124f75ed0c938e7b4b0dfb5d7c1c.1653033459.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653033459.git.geliang.tang@suse.com>
References: <cover.1653033459.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba09c01-5bf7-4d90-36bb-08da3a378e28
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2757:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB2757AED0671265FDD1022D98F8D39@DB6PR0402MB2757.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3ceQnio13p7N6dDpGkcFaVYZWmJ50/97Pe3FEIocvfIzcwbt4R6UV2ZxTnzUxG7JKiMuMDiPqgbvJ6VB/PCw2D+kqt05XBAcmkTiLI67z5BS537POeo23bV40omp+n2zf18+qkvGVIW4rxLoMlQhWdex9HR1nvuon0WG5U1+8T/hYpy2iAwOzC5CLF2ade8aj7pPLJWjI0glkUd9ZPv1u/7IdqM3gY6kuEdXJiPMhtb7+FiU7pxB4VleXoSoOtLA8fOL+Vkm+IHYDT3LQl5UMW1DOwyPuUlJZtvHZFgwxTcy/fYzZbP+lIaazuNAfdDNMa1/8TkJmBF6+CyGGHHcKLZ1QyxT8p9gmM4TcpZ/G4b8p2k+YUBRMpUdCVjsVJxfprEYxualjZFv1/7XEqLXSL3aLiAu+27S60Mnrvcba5k3WIHhEYq4/mL4jH3kFL0JuJMNHtXfOsm2BHjqQspBldubJbkhxqYo3ienVylYrQfndm2bb/yQ4pxqTuIsoRjGDFMYAKkGPHDzycPF+3PGq2Kli61+iooZWlv2Mc88+64fjSS7k6whBKsHQOkk2fkTlHUv5+UXxXUtR8iysI7bSxam2AJTzdfdNcI4eCtdUskahPP4/d7/5H14YHJ+u9vyZU85jaPvMuIAEGU7Cyvy4Jg+IS18/UcWemKyqVdpK1RTPlhQ8cCzrt5eQWAxSLlvyIe+4ovdI2NBgscmfNc/gw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(8936002)(508600001)(6486002)(316002)(2906002)(6916009)(5660300002)(38100700002)(8676002)(107886003)(4326008)(44832011)(36756003)(66556008)(66476007)(66946007)(2616005)(6506007)(186003)(6512007)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IlmCneQl/dYso90QNYBhIt/vEf3rEg+x/2zujKPUiOWGbi3/TnLRmMVKjpiS?=
 =?us-ascii?Q?Eci2D4j4G6WL+c8tfJ9b/9Uuft5SY71w9TKPmk+f933EtZ65vsqAXlEOLxwX?=
 =?us-ascii?Q?Ax2Yjkw3tLsvddGjFUA92xkXCmOslDU5t6sAT6oUuRRoMnLKFXElezmkaJD4?=
 =?us-ascii?Q?jabRDfXq4QFJVbAQYsvaVgv1wmvQzE9kYydXI3vLv//rGwUPFdO+bmvRlq6O?=
 =?us-ascii?Q?uxjYbIQ4op27DzdBz5v5DRjU01rMYxQVh5sGFGes4cBd8yBhGZ6KYDtzXx3e?=
 =?us-ascii?Q?CwjRHAiQeLC1fFUd6cdjgI9v2k9Nyd+9hOR4ApsO5DWufsnWmuYND9/oj6y0?=
 =?us-ascii?Q?EjNwFK3euPsnN7vAaXs7SeCGKS6JoXeu0LnsNdsor/E8XLJVrcrgcN5mupZk?=
 =?us-ascii?Q?pUIvlkvw/B5Gnwlceiu2s6DAISWdoSGdhPr6Mf6utwZ406eTZIvPTmzES3CF?=
 =?us-ascii?Q?e/qgqBq1x3hVDabVUf6lg1T1zMok/XvgKaPg9dCtc541gAXRudmV46ePTWM9?=
 =?us-ascii?Q?ByAsBJCzWgHbscC0ospogJwHPHne3GA9Ub4oH+gRVodpt7VOSZTGA9L1DaMo?=
 =?us-ascii?Q?XuEHMxazPfKVJWUe+HfhoAC/V2aBlhk6FKhp6fhlQABhtzItTVLduwuRTvCF?=
 =?us-ascii?Q?YlmBtPsM298RplS9lElSTcbMByKA9am8bcCPw1RvtU/9dUcVGxSo7kCcES3f?=
 =?us-ascii?Q?Q2Ql4P4LSdKZBoG2cNWGfkzx5HuvZIBrB22j981wfZugvTZFiK6sG/ncaGsY?=
 =?us-ascii?Q?B2I0Cfqjx1dyle2f0K4Bd+5UfQDSmaYi8E4WJOgVRwXY2u191irKqkZi9aCR?=
 =?us-ascii?Q?7kpESudOidqe6/lXBsVFH+IHj9NOn/hzsGQchMbDQ5dFBqfQGPwN6LJ6PC8K?=
 =?us-ascii?Q?KBxapnQO3O8R9yY+lL7VWzigumqjtU6Xc23m62KQVohoSZBmjCCDnZkgFe+g?=
 =?us-ascii?Q?kQJBaghpbFW9wZPiT9uRirSMWAC91cKtPSf6qkzHsf3dYVlFM3nrQlLhwmXr?=
 =?us-ascii?Q?MMeYFQ0ETGTYsZSTTp/VN6s8qxXWn5jYPNtL+jvGzPJVlgwcJGDovJ4sJOwC?=
 =?us-ascii?Q?1y7flhnltiwvLJeyVd3CS1MP5evQsldGKWhM9qVxzNi9zAz4OzLfptOTHYUh?=
 =?us-ascii?Q?7HCN0C/iUZb5Z39ht6NtAFAVuM7JsqJcs/LRaH8J8i3jwJRnhGTRZgwFqxQO?=
 =?us-ascii?Q?zX8zRc44AvhthTmrB4cfwGKklb7MFtfS8oESMosxVhSdZiz1YPvDCR5O5oO6?=
 =?us-ascii?Q?WPV1s43PK2GlCTgBdQI6iL1de6oTrp6ee6wQdJTNsuBPtqFb3GvEyJ5uMH2m?=
 =?us-ascii?Q?GeqXJgozGpmNgSrDxfprR6IVJmnybNcLKjClq2C2DYThzDyrk4TbSId+8cJu?=
 =?us-ascii?Q?vkwcqizfCpstNU+KxZYFA/TO88VT2Uy+HSIaG4Yz1l8YVwsiZBqqH4czESqq?=
 =?us-ascii?Q?ytOBqVWo0cIdiyRL/esbLEUaxZOvESz0d8XALA126db5YG5Ntxs0n6VlcU7s?=
 =?us-ascii?Q?THCxqcErKxQKxLVpGjHRf39MiXIEcst8nlQulsyYCQF3S+SBQzVdGnAe5w/H?=
 =?us-ascii?Q?VqEvRyUGtv+dPYD7taaQHFhW9rvAuWa+uPYiv9C1dN4M4OqJYQYStx2gv3tz?=
 =?us-ascii?Q?15x/63xPzEMSoN01aN/M61m5ksfbwvilFozjz5pE7nS8/acdnTvH31pzliFP?=
 =?us-ascii?Q?AdAKTjjHI6u33rtmWrd107KJA6h0R8auEON3A2vd7liN4x9AvbKQuj9zfUCR?=
 =?us-ascii?Q?VyyaUrnb4djBB2nVaz42VEhjqLiHfPs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba09c01-5bf7-4d90-36bb-08da3a378e28
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:05:51.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ5lP0WU80Jri4idGm3bv9wJJLzyrC7NvvM2KrccFfS743RyyGdVoyTu6fbFOs4psKxxx7c/hNPYXe7Xgt9OBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2757

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  1 +
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 48 +++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 97407c02dc48..a95eda06fe7f 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -257,6 +257,7 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	struct mptcp_sched_ops	*sched;
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
new file mode 100644
index 000000000000..74a98f5bb06a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_rr_init")
+void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_rr_release")
+void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	unsigned long bitmap =3D 0;
+	int nr =3D 0;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!msk->last_snd || !data->contexts[i])
+			break;
+
+		if (data->contexts[i]->tcp_sock =3D=3D msk->last_snd) {
+			if (i + 1 =3D=3D MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
+				break;
+
+			nr =3D i + 1;
+			break;
+		}
+	}
+
+	set_bit(nr, &bitmap);
+	data->bitmap =3D bitmap;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops rr =3D {
+	.init		=3D (void *)mptcp_sched_rr_init,
+	.release	=3D (void *)mptcp_sched_rr_release,
+	.get_subflow	=3D (void *)bpf_rr_get_subflow,
+	.name		=3D "bpf_rr",
+};
--=20
2.34.1

