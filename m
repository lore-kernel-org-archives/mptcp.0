Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58A7A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zaRqdn7t8koqVA50UUmWO7Yn7NKpzbiXKACroSGfyrk=;
	b=Y68dyN76oupnkA13eHZu8ssMWG//o3lnQOceH/6ba30u2w8ns/Bk228gx5q+kt3mBXcGdD
	GNnHnhaJXihflR3tNJOmG82cdeMfiwDyfV3/AslYn/SsZb5M48UwPQk+dZ9sWREPEC124Y
	23NZArVaheqRnc98GTSm46iZcK0eNTY=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2108.outbound.protection.outlook.com [104.47.17.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-uLLUBaP7P_-XcY6CnYBy3Q-1; Thu, 21 Apr 2022 08:23:17 +0200
X-MC-Unique: uLLUBaP7P_-XcY6CnYBy3Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCiJ4F7D7jrdZoExZERQcf7bWmz2BbrN/PHlUXJuDtmHXRRYS9xva4Y94hDQ1C5p2XeRnf37MTRQKxVaxwddaMJv0L78/dNWfEPNdo1uzh7RWORgeIBH9nDQlXJNez5vbAkblGg7V2YL85SJ5g4cfqtUeCh/MwLk6VfPZBia0GIC2rOqhCsAr+PtYNUliB37L8mjBEVyqXEnv0T+FTbnj0ddI9G7Zmy8jnwwakwfoHHZUeJrR84Z4xBknAwVtEl/v4sg8O3vrTeAPOSR5vE2DixMdoscr26Dxo4IhSIjLoTdA0p2FCP1W/FTO0koE9nTpD0uIJ/nxn5hn4oHEzn1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UmstmiOK4CbQz80u994PaP9FxNe9yNoi41BDRXmkhA=;
 b=Ew/MXL2600EEEjrx8R0KvAr8ttm9BXRk1H78TFP1FqPI0ujygD08VcpJvKx8nP+Gd6D3R1NkoEVhVYzg1YVMdyLIaiwccHSqyJP8PiuEgPjyINKJqbOCuLXUGKOC+pobUgBpOLjoYHsV/GCffF79U9ythFCefn/xMwFl8tGf3ar4H+aqLOhopaPu/HTEuST81GYyoL08HPineaQu2ixee73fLJ3jc81NUTVQgeuN0Vqws2S/LA12sIkDrCnGDLdt9u0WqOguzlr7y5v7/iXjGRuMaRLBBJp9GgpQ4gpzDJIzSNfBdMQuRJLEsggZZmpYjVIMF2l3izJywxSHXDojmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:23:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:23:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 8/9] selftests: bpf: add bpf_first scheduler
Date: Thu, 21 Apr 2022 14:22:26 +0800
Message-ID: <6de7223645d341ad58053cb3328ca6801a4dd8fd.1650521788.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650521788.git.geliang.tang@suse.com>
References: <cover.1650521788.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0076.apcprd04.prod.outlook.com
 (2603:1096:202:15::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1ea9aed-b122-47ff-a94c-08da235f6bbc
X-MS-TrafficTypeDiagnostic: AM9PR04MB8100:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8100D0167A8A4A5CAEB3EC8AF8F49@AM9PR04MB8100.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SlgJQbH0TVOsz93I/hlPr7uAvN5bExQiVNaQEbTTbTJYd8OPA6soAFEwrCgXXQZbE5S6zC/PY/BkxCt7ujjQZJudR8tCoElQpWyg6hBgsVmv6KGOyGKGEaQfRh0DAhGbLNuET6L9Lwd6VhKtWz78bPrOoTfBXxE9eNNpyjkJ/LSDaBXRCP2CKExmOBxGQmcEqmJTs5PImvoeeTDRgjzP6/LsZBY1yRvy5my/LqfE4/8/WyPNKBHATsp3v7dllTvm2WnZagC+iAKeCErgqdFCaOo9V+HyK8MPtsq3uiHMyapxc556ZPVruO0jakZxnQvkLcHBCLiiZOaR04KBkumWYL/51jneBV/K9r2UQgKzaCxvHAyqIjd0nkTWbV40fwXnZyHbjT3GpqYuPJKVGUr6biEFuXqqi+jSIZKVcAHTKtjsb6j874R/V/U7rIkWbOxl+Xjdx+klUYVSieaa84vp3rM6UtuCJtE2bje7DmVPdgr3w/2PlZr9KyJr/NLVSZmN9Hi8/Z+diVsQTMA7SEdHT+iouYGo/5f6zKYAKzLcjov6oIk31ccF/oYqQj1Vu3kFrGBvuI1K7GnVlgC88azGfr9+pc0MEhGQR20yb0eesPuq1RUFVhKhEgiRDYnaJ/1+d2gjYOjszrv4D39cLGoA021jXb4vOjRpCTvIWK5aTfaCX1PkxaQE0HN3LHh62MuRz1G0rkYw84dKk1aEhFJtbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2616005)(86362001)(6512007)(26005)(316002)(6916009)(508600001)(6506007)(6486002)(38100700002)(66946007)(66556008)(107886003)(186003)(66476007)(36756003)(2906002)(4326008)(5660300002)(8936002)(44832011)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rDEwk/DuWHX/NOHgyOuojPASEK4Nt7uS90rJGliZMB3/6qj8m/bb5E5oVmWu?=
 =?us-ascii?Q?B8ht8GjXgGtqalXDHn763pmFaFYIhUUhC+siynHMM3Zf/gx8yyXHCycLAx2L?=
 =?us-ascii?Q?x3qZTpv2dM/lNFb7UKRd8/JnthSf47Rdp8r3ndy31p1S6R/4d4l2cOeSaUbY?=
 =?us-ascii?Q?37/pIuCMeko7i4jgbO4Q+FXqbor4NVks5YWWHx19Y9YD/jSJuyD0d1Tl/l0j?=
 =?us-ascii?Q?628iDJMBjc/+Y0Q9kIfqigzyLZZGvUdi5iISnBrC6BTgugX1OWR4I390OcLX?=
 =?us-ascii?Q?55sTh7i1uZLVEFZBIzAXhnVARGIzsIHGwsnlFuJiQrakP8JPnfBatA5UeCjs?=
 =?us-ascii?Q?RNwQtz3WA2M+MpqMM1NaaCZJEbfY438Jxc89G9aySoqO+HNlOtrY1SpMA9QR?=
 =?us-ascii?Q?pjVpqhboO4wVI7CcThT9MOhTIAaurflfqv8SSuGXoElX887f97chjONp7+sL?=
 =?us-ascii?Q?dadeVrw84drZsLW8Wq5KKSUcoAXn/nZLRyixyq1Za8/nkyq8IP/3SIBikq+3?=
 =?us-ascii?Q?sm9NQU5A9fqemVa7xrWCms4E31JTRWS6KecTeA/99TJVrm+qO/WsPfSzl6Ex?=
 =?us-ascii?Q?BbHkEeAzlgDUHlr8zHswW7sFG/vwKpNIOLMwd1gPxO9FspWwBK7+zhwl6zbx?=
 =?us-ascii?Q?yklZ+atSAcXiuKYTiGmwnOYerbDTxFxKzA77XGaATwqPI0oqnywp/wqeoK4m?=
 =?us-ascii?Q?ZoeVltKdCZ1dmAhSQIJT87alPlHerAS5jl7mlvagIziaAoLzOe1hwJqKk4QR?=
 =?us-ascii?Q?ksEVB8o63av+34AuwfpERjq5YHRKD1McCd/sM1XXf68Z4vjJX7miU0uXQnAz?=
 =?us-ascii?Q?om/6XpOKPOw6P6/q+omw/kymkiMn2JfHcL/tZ897hG4XYIQSFMqkRLNbj1JK?=
 =?us-ascii?Q?sS+ClBpnykz2ljHZPaGNl2To1D9dsTmb4+UVaDTPZIIsjglsfkcVcE6ZAH45?=
 =?us-ascii?Q?IU6Wt8p1Ol/H8Etf7dX0yyONS9L6Ps/z/u8GxGAS7BFpuGgVG0nIg8auaz0R?=
 =?us-ascii?Q?douAXRnD32q7s2ZUq3bjrjJT00eRRbl2ecCteHhoIgJCz5KrF8o102/8lwAE?=
 =?us-ascii?Q?//h/w4P8gqEPJSA4AdquFp+DVpNoBqd1c3qtcyCJyD83Aw0yQh2sqkLSwH9x?=
 =?us-ascii?Q?zgt6TUSGue1yhAAws2RvURQiC6Eq5wHZPVq6qBkI0308r+wfC3HFGJ21W7Qj?=
 =?us-ascii?Q?elxJ35hSX1rQ+6NXHQeeIiet+HbhJcewMHSt3zS88mp1QSFwk1tlKBYxsVQZ?=
 =?us-ascii?Q?XXQVUMDsnP9bcOzcT1Cy5EQ6CXSJxNDFbwk8N1PDXXTG6TspA5LkavgUZRQr?=
 =?us-ascii?Q?rG6ZY9ub5Y0Oo2CH4wAaJhzbGdQHL10Sf9+I7JA4Jduw936AP80xsl5HFrQu?=
 =?us-ascii?Q?QW8XubWdPUj0aMufXkYD7s1qPSeMgBpaOkHZRdOuOn5LKs7FrMT0P2SOeHX7?=
 =?us-ascii?Q?ceyqYclBhQG0kI5Pc5r5QucUaMwqVKi6DoNE7Oh/AykndtIUsbR5v8FLZRkg?=
 =?us-ascii?Q?vmOIOvc1iJsQrXvvQOfx9sQR/U0z3sqVwya2ySdp9ehG2jbvhmybe+PDvZeD?=
 =?us-ascii?Q?Sm2peeDNIwJkdRR50P92C9VIXedXenJ6kob0z9Z+nK0X4owKHpsl/+4dlb6n?=
 =?us-ascii?Q?8nia8P3kE/8uuw0CwJewE9BFsysoBpBNxmJtXRfDVvdQW2PMUpZUDIEH0nuX?=
 =?us-ascii?Q?8pq2HDvb5kEisgMGc33/HXyFGzP08onQe1PxETzE9/cexBR3EbuMF67iISeO?=
 =?us-ascii?Q?m44fjqJ6AaBu3MaX4uuoy/3Gj4v9XA8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ea9aed-b122-47ff-a94c-08da235f6bbc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:23:16.3519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICgUDhWxGbt/XrXnBfLmsbIIgQ7lzL1itNJjVp0mshBMTPjLlfHH2fzaSl/PtMEl/AUqin57doAnjC++i5m4Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..892be785dda2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_mptcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_first_init")
+void BPF_PROG(mptcp_sched_first_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_first_release")
+void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
+{
+}
+
+struct sock *BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk,=
 bool reinject)
+{
+	struct sock *ssk =3D msk->first;
+
+	msk->call_me_again =3D 0;
+	return ssk;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops first =3D {
+	.init		=3D (void *)mptcp_sched_first_init,
+	.release	=3D (void *)mptcp_sched_first_release,
+	.get_subflow	=3D (void *)bpf_first_get_subflow,
+	.name		=3D "bpf_first",
+};
--=20
2.34.1

