Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2EC210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653988244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POnbnWuA2JpW18vt2j7lxtwvfRkJCXnWq2ZsnUQDhj8=;
	b=AWP6DdWC6wYUCVJ8E+SSuFB8flz/qGvYb99Wy7YaSklJTktsItzwI3/Hi/AHe6wb99l9AX
	wDn4FzEsVFS8tJn4/YIT+DrJUe16ghCc1ps+Q3adlvxXAXXqaWe2hMr0pUzIh8CKFvd8rk
	5oGUd4cZYTW0XO0rYGBrJxhM6lXUiXc=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-CVOIYptKMl-mGVm_AAGPcg-2; Tue, 31 May 2022 11:10:43 +0200
X-MC-Unique: CVOIYptKMl-mGVm_AAGPcg-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqxGTZavv9CRNJTF1G4tRsri/gG7hAA3iIDiVQjmUC8PycBk8KgJ191MmmIJGqApResqfBAbk/kGrX0AyrquLJBKRIxFroCzd9V9jqR/qvzzf4t238vQrfmSi1URQ962K2tDANeDleW9ERWM+8b7Dq6llmqM4bfeZ0CsEVBIntE5yFDk5eAyqINDsmqnqLAwtBV2qfjXWCPkrjeZ0NleWe57a4fI2k9TKvs2dytdLSbbmHFDvasbIes4eIuUTFmZlVq5TXRXmFEMv6a8vFdQd2fkhiTNPgVhjL4GpqcLIs5Mk5LXaFUwsc3Qt/fLcgSFLUvSaCXMYwGA9i8aTvqOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aD96GYkHjWpnzZzoi+2wezF/lvZ30SDHa4Xu4fmbWX0=;
 b=NIEWBFzlYmGFJR3Rvp8lRewL/QtUTnzQRK62y/iRe2a8pGvRIuX+6+hfCYHcS2FSI87KUYAbeSsUF8jxLVT2m9FvJjMMHGk+pew9vR2Y2LNAjnoupE9uEIl4hmXNt6bY0+wo61qWV0MV4hgwmfpqzvjp2R0ZEdHvNHXyDvTZTHLQoo71WNfOmN4TinWseUmFDc/C6KmrcfCLSQ6Lx6jlhz4H0XZr2H4HZd9vsOf/Ubp9+UfTHhe2RNZ8oJjqzfZcRVY9ant3JQbBLowTVGEBO9W+Gqn7kQoe6fWrzy6epl0Kk/NNec+Qm/N3K4O/Y1Cd9319ZFVegHS4jUs15W2Gkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6434.eurprd04.prod.outlook.com (2603:10a6:208:174::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 09:10:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 09:10:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 09/10] selftests/bpf: add bpf_rr scheduler
Date: Tue, 31 May 2022 17:09:54 +0800
Message-ID: <cac12bbe5a81cead4fecf7cf2dfe421667ffca0d.1653987929.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653987929.git.geliang.tang@suse.com>
References: <cover.1653987929.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70f944c6-85c7-43e1-8157-08da42e5701b
X-MS-TrafficTypeDiagnostic: AM0PR04MB6434:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB643406BAFE0CA67857840B2FF8DC9@AM0PR04MB6434.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+WChmg01rHBkGQ544CXCDDYAuwCYIicKlNODcWg3NokuolBhmATuq/oWGfPE+CPymAlf/7Jyv1ftDBGLGC3y5IKahIxYBFXW2kt4kajXSYQRYdQ5gmcYUOUHyZN9gGN5bcGPoRbaxpQsGJFlMkipu4GoU1WxJTyzUtUEUVs3PJ8EoF/Hxr9sJNV326lVt2sBWNyqX1QZbmdNq4x8oozY1w8nluy4BziF6nnASxFbUjCwLfPCdjy8cbANAK3BKJwxOUxHfc8I0WGajH58OLtGk34fAYS7qen5U0hJpBXpLW08ahb/spwWKK1sbVkDl48gI2O2mlPvNTvVM2X3kzillFNXzAGbbOV/dcCRUFJKQbWQxXX5yxv0kuZNhOLHoyf3D1SBS8v39sjf5H75w9Jqf9vtAkK/krlHDsU1ufEZYPM5iYNYXwtQ0+QFtE64yjVCtxwAFA1T8ZaYF9bdY9GWPfx2IMNKvOMlWhcI8uWRdAauG5rtN/pTl8xRKtjiforY+njVnF+P+OjgA/C9nr72VbHjdHCAldu+NqlAuWlWlroQ0zVSnwvuJVa7WEyDsPLKsuGxv0dU07a3aaRJ46667E27w4XxPZMPbiiXC14mEZmcLIjuaBiCokUbq7nPer1RBLuM5IRTgix2mnCJt0OFp6lZpJHd6cWhIU/I3B+gBFqaRd42lxVMHKYG/G5tLanf196+O0ONQsg7NNM7hMshIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6666004)(6486002)(8936002)(5660300002)(508600001)(38100700002)(44832011)(107886003)(2616005)(86362001)(83380400001)(6506007)(186003)(26005)(6512007)(36756003)(316002)(8676002)(4326008)(66946007)(66476007)(66556008)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a4DD/jBfOeON4yKZOEUXK8mbmE0YC+T3ZW0UH9cvNojiUdRcYMgkb1kDdC1J?=
 =?us-ascii?Q?x30F9HfvMSRd9jFM0SAgdRY21ltorKuYwR0UYkudx1/UbR+GgYxsSwXMa3bf?=
 =?us-ascii?Q?qfKwli14PAkNVKppdCavcx9b12UhK0tGbImf09ihpQnPpvSoVa1Vs7kFf0+R?=
 =?us-ascii?Q?ru0DDblLi0ggRBVU1lcW3JEuuaVZwf7uZ7OKYDMZCpzqjuS08Kt5YecKB7iy?=
 =?us-ascii?Q?mzNLiH4c+bULYTW+VwdWq80pLIkE/3S9s2r6+vLLx+3OlH0vnGE9FWgJzIRC?=
 =?us-ascii?Q?YQ7o32gDv+VIwwXKim3wPm6jAqcaJMBOTTdNlrG22G2xij10SOj2fv63NLe4?=
 =?us-ascii?Q?jjCJaZ2zm2TAilTq2U45I6V4BWGhGLebBMXaEFeBHJxGsKE2SI4cnMochI3v?=
 =?us-ascii?Q?ZfUlhQQCMAAH/+8rLYJIthDbo5/1cabCrOCNcWiGKVLyfdh/gQNCAcNFdpNh?=
 =?us-ascii?Q?qOOygm0izR8ZCDp1LQzLrPIyTC8XUb2tk0XguGByauzUoiRPZ+FQ7nAtISug?=
 =?us-ascii?Q?uYBKNO+yPZMy1335vBj7Fe8vSwiv/wI1C9gVFmF4O54D0zLh/Lo8w6cjHteU?=
 =?us-ascii?Q?bBgRYwhmeEGZLs9MtJ1KUu0E8poZxi7O15BJx0N+NWTP/pdLyWSojzTzfdU7?=
 =?us-ascii?Q?9eoILQLhCDMAm6SIM0qFKG3/QdWX53Y/sjXBmg0omxpr/t67K8+sCuLwowS1?=
 =?us-ascii?Q?prWH9DfcV6kGh5+4fTPZ2IVhKPDf2YyoOEjzGHnBQVvepxLdTEUpxZXimIL6?=
 =?us-ascii?Q?vse2VdWW75GE4Szh3YgVvQNrYvZKgym1ol/2cYvAId3XxNDeh9EFT/BaB0Kx?=
 =?us-ascii?Q?Gc6VrrHYaZ8SJLFdWYHGd9aEE+vBZH40QAR05Mmmyo55KLLxiz6e8dxuBLGi?=
 =?us-ascii?Q?8FVI7MAebj7A0IMXJf7QgL8dRYuvQdgQFJ8nFF4eFPnERYSR3gkf801mTP9N?=
 =?us-ascii?Q?SckgSMcKua+zFSJCCWz5YUEvYRYOkjKJH0DHJ3fJnQpZ0jr3MAgO+v0+Kolr?=
 =?us-ascii?Q?zMjVr0vu9I61BamVQoZsH8LRFLLQiD4GZd8ZCF+A9Vf70Ifvr0z8ZI3a25G/?=
 =?us-ascii?Q?bbRSIkyXLhIqZD/ng410DbGtIufAr1mLaT/EzhAendaS23NYP5WdVnWaA1uc?=
 =?us-ascii?Q?GRCop9bi9Ye+a9nkkC+V6X4IIbU1zD6NyUaIQpbjKhP7LOMVklQQwnOaFyNO?=
 =?us-ascii?Q?TCAxrIYYQKjL+jW9FxORWe9+kSoj2VNimFBHDN77X8llkIYtn+MeFAXSIV+l?=
 =?us-ascii?Q?Yuw/xT1fO894RgkTbcP3liHIFEJorh80F2sKBLg9xI+tVktKYF2h0xaRBU3R?=
 =?us-ascii?Q?8RHL/NWALLHX7+ZvzzdmjV3WIF0GYBSPrUxLklWb1xLkJBzOfweG6PnT46NU?=
 =?us-ascii?Q?ftp2KiyiyQfSGPYQ6ywlumkGxKeF59CHiDL9gsst6fhkBVUmJbfo7G45iHMN?=
 =?us-ascii?Q?lBtEcB45t3dlXFI8vQNCuJ+2XxMBp69+VWaP4zKCNU+yuu2U+EJnKHFkf9uA?=
 =?us-ascii?Q?JzsZYU4xGPjLId0i8VlYNTPO7qcN6u5PqgfghZI828x8IiFlYgUpovckLWnf?=
 =?us-ascii?Q?atYJuZ/KSe4zPhps9x9PZ0ATFPsxrY8xtj7bJLZk+AWxzPvxqkUuaY2Uxsxq?=
 =?us-ascii?Q?8PEO2bg8JH3ofMULNE8F8qEgYIUDDpgnpntOriaoarTboM6SIQjaYYGm2plx?=
 =?us-ascii?Q?IQe5saTKIe59mGkfNs+8ipgRWz77mqMX/KpGNRGEhZl+d1nZ/1QQVJyRXbth?=
 =?us-ascii?Q?fg3ad4JVAWBNiiT40hEb3Qn2elX0SI8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f944c6-85c7-43e1-8157-08da42e5701b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 09:10:42.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2DFw8ZnB+Ejkcq0SGBephEs3HxVCEK7FdbzYkJZBkMYhRJtLH1jDHpKHRZIRaKR5PvGAMO/eV2G2qzAkC9YXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6434

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  2 +
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 46 +++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 6fa496a65bef..462bf6ca2dda 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -237,6 +237,7 @@ struct mptcp_subflow_context {
 	__u32	padding : 12,
 		backup : 1;
 	bool	scheduled;
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
=20
 struct mptcp_sched_data {
@@ -258,6 +259,7 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
new file mode 100644
index 000000000000..03c1032bc31a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,46 @@
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
+		    struct mptcp_sched_data *data)
+{
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
+	data->contexts[nr]->scheduled =3D 1;
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

