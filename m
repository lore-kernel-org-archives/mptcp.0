Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30069.outbound.protection.outlook.com [40.107.3.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED08FEA6
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 08:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbEKG2pcuPMxaV0XYfPe/6bBeCn6tw4gr0FLaEb4piAzVpxNGk2FLc5Gp2cj0h7eUyj9dnPEo3aozET+Bnwo1XDPBmotnSQyn7IuYzs8ADCXlCZXKJA5ACy2FMcv7alt94apTQVM+VdXUD43DOX3qO12tjrnB4YWqmEV4Puj7yfbpMU74cYA30wa1E5iFSVV56oAiFnfsXLZK2x6xgfttafEmALd14KlmJVrY4c3rTTZeuHwb8GKZ+71MTNcD+bSLq9sBmEZx3LdbFeabh2cyL56tcB+IkOsXH7jnC1wU/9x/QJGmj6G9pEt6GzHGbpRTaZKxQT3kgCnn2KHp4T7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SpylYRiXp0P4k3XioNA01AuM9ZHejqqclsSfyCQrL0=;
 b=ANFTGxgumSoELWc/TRklTfej03mPgSxpH503UxdszDeNxsh4KFO2cW17zvKuFkdBZjYR4xsr4DeoLUGq4RB7MH0PuFTo/aeOqwKfZ5XvPeMv7lcTRfhcP/n5uD2TwAKAQk7DvGiZ+UPPYhBQw80RGUwPPk/AToZ/OUw02u9TpuMjDqlsn6Wq9rGmQ1rJmIIg/HjU+xKXm9P3euhAiVIqy1ugdvWjckSTuNHgX5etep4+xCYK0yDSvbwjmWMoz3y2NeVvFCWxt3CONV/0LaFy5mHX1ba+4RCwisDcBym8Rjo5UWIEZdkynAS3weAfXWzpF6NdjuC2XtAUNAoX5JVsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SpylYRiXp0P4k3XioNA01AuM9ZHejqqclsSfyCQrL0=;
 b=IK/+YMg3P3TGsDLG8eAKxIFeAx84DMI/d5pGPTctd9NtKd294YRZ8pIeRqz9KZOzx2715E4AFJmdJeof402HGVVVIvUY71BcmfcVJKzna7lhf9EsYRaZHk9JOpEYdfxGiXJbTONAdOkQOLgqD+x7Z6+FZ8Rg6KYSXd9N5ctUzpgNUkZ9/nrumxSIOV9gnXmHfDYot+TG+lHv+CTJjRmCfMOD6XdMNf8xkKqq7DwI/8gskVEdHPRImcn8ADACvKUrK99D0TAVaYCPfAGoZMyY9ioi6oQTqGfDMRMgXz6mqN2pLlS6QRshjHvQJHZQDIlQB8vIyXqO3XKboYMOFFutvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4381.eurprd04.prod.outlook.com (2603:10a6:803:6d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 08:51:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e%7]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 08:51:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 4/5] selftests/bpf: Add bpf_red scheduler
Date: Thu, 30 Jun 2022 16:50:53 +0800
Message-Id: <2a4bfa0a78bcc5ef6986a271de12457d04c61b06.1656578856.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656578856.git.geliang.tang@suse.com>
References: <cover.1656578856.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3789bb6-c57f-46de-f4b4-08da5a75ade5
X-MS-TrafficTypeDiagnostic: VI1PR04MB4381:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BO8IpZsgMO9u7nv+/ZMfASk/bEX+wUoxkG2hESwGKZpyn1CLkJKNy0dWSmOlTl5lFaKBtgaqSZrQhFQaaKYfYA7YygmFfxIq9+MRNfk0Y2lFuTfBTMUi/5WYwnPOGnsAtLs3q0ozeO/aIp6X9BWolHFQ27PNMYl8GUBQnQoxZEsbgiYx2xU5rzjzOv84Hu7g1CEnU8I8M6S4sSFOf2my+aDKlly7dv9BPo/QGc8sCOKFFAL21o4a2IPnKZFGJHlM90lFvVu5llmaSgOWTnbDvphIiUdnfiUKPimf6Vh70ulpe3YlSUH0bGQMdKkp2WikQ26bwlJYg6ZieT7hfHm+Ov0+mGbVsoqIv/nakHC+QN3moBNqMl8Z67ElG5fy38BJ0/vMW4whlH5JdWMTg3aQg0ok81F47M6YpU4TG9jjdPqpJ86SQIWermKXfPewAI6vadnC/x0dtKDvIZU8/z/28eln7oZeMImiwehzjJzqSQNj5j1OqGBR9bcpch+MB4XcK83W1EenNE99iS6tZT4HY83/wwjkvVsCd/bA9DRoUgtNd4qABFkIKnQmndLrLR9OVletJkIdMTA2bT1uiCumFCSaGngabrPsoy5l8+Bbqp8A8B9KGo6tXhV4vB/nqDotNopRPPGOVzczW8FOn9b8IYrcQpcTKyTr2DApPVBA6LZsDnyGKQ80Qeol6r2kgm8ktXqRZtQcHHll2CQhovRwiFDQjjuBU/xphaxjKHJuPdzT3cB1BiiEK2dhFOliqZuthQx1IYzjBXNWzFXeP+keHpSsDvAh4P10W+bvOeHTfB2cgg8qlyQ55c3NcKI3nOrJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(136003)(39860400002)(66946007)(44832011)(26005)(5660300002)(8676002)(6512007)(4326008)(6486002)(66476007)(41300700001)(2906002)(86362001)(66556008)(478600001)(36756003)(186003)(38100700002)(8936002)(2616005)(107886003)(316002)(6916009)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qVXjntrfjLoFfIX+AEcPy0/xPwwFeOvw0dxA8jcPzd7/5uWv/kPo85S63ZgH?=
 =?us-ascii?Q?NauJfHnX/FCTPNEAqFijeDTvgQlefeUFi+V0fQeDnoj22O2EEjI4Mw0i0Vhq?=
 =?us-ascii?Q?SQSZosjqR1j2/OoXyiBnjGQExgQ9Xpuncy4HyCQXGkWiJosNW0Guu0/6nQ5+?=
 =?us-ascii?Q?HklfKllizDWh3OdPwk/kqutZe+cGrPVQpThvhp4pzCtvZClKHI/395fB/7wp?=
 =?us-ascii?Q?LKKa8awXqwVCHn1YBCD+iisL/8DSfTUjKQ3TxeoxwmYntGgUsCo2ZFNYqZId?=
 =?us-ascii?Q?ZCA4YW6EyX0aOqEWZuRYiSI9xOZRIrKBbL6pJWh4r+3FZWP/ISYX018D/Zu/?=
 =?us-ascii?Q?spjkuQmpItYjmXKX8K2DLR3I7nJruXYqntQfLt4yPnYY1Pd97Anz198IpAN6?=
 =?us-ascii?Q?+a4DBqJJxU3bC97g7zgVt9TCY2h5Cwe+TFkYIPKes1iPkrOS+mIj4/NUe9hl?=
 =?us-ascii?Q?IdkjauVSuLGpWG9DKHXgSyDYnkNe2WDqq7GEQdACvYs/tS46/PPor1j5qTJh?=
 =?us-ascii?Q?LHTSsTYKuhUKB+R2A3/Y/mxWWe9UbFsXLUyYOC0dUHN9VvSgb2SqmuTo45fF?=
 =?us-ascii?Q?dUdGGtBGi5TIE08/Bfr6s6kch0psQZlQplpUnbskvauSW7RSJGbnj32Y511P?=
 =?us-ascii?Q?zqowjshXFsjyihfZKQnLDhgtMobsbQSnEJKaA70lRwRt62KVQ7NkcNJ/8nIT?=
 =?us-ascii?Q?B4Qfyr/bfmEKj/3KOoXCdhB+fBlxdgezRgF0DA0lFUvxD6YNwpb8m6XIGgHV?=
 =?us-ascii?Q?ZvDHjTEo5XWKzOXDLMdgn0gsvPypGV3UxxmgvnoPiJ9UdEKkt/EqwCu6TTG8?=
 =?us-ascii?Q?F4kp++o5NuAc6HaY9dTVIqjcv3H/qtcz2oLn8wfJjPTZQHeSZJQIFE41zpfk?=
 =?us-ascii?Q?fTeDMR7DHAK5bCyeyuv6evMYRMVza3xFsPIVDV3NAfhrDKyZRrgo+uErGvQt?=
 =?us-ascii?Q?Hk/tzUgjuIyrFiN0yqUsvDn2/rLTUY169qeX2FgJaPzqCAMrmhbnthaS6Dav?=
 =?us-ascii?Q?t0Po42X3IgYHOSis51rxDWE0Qw6OqQ0BvPOduUFOLDhexuAy5CwDVsPc8GzA?=
 =?us-ascii?Q?z7vQkRbmKOKPd6poNxGJSH74mCRILNdpHqCt/HiEChS2b6fSUhYs59OyIxD7?=
 =?us-ascii?Q?mbWfNBOqo7V7rEUHYiKgvgRnD1jzFQbEYSIylSC5raL0B1422ZeyGA4C+1f6?=
 =?us-ascii?Q?4VFPgDNGBJYL6P3XD+WHOhDz/AEOrrRy22XYNqovSY4/pYb5cc9aIne/VT6Z?=
 =?us-ascii?Q?WaASVX1nP0lsOXWjMgklTaBvRg/VsgyYaoonari1O9PW/oMIA8Xov4I/UwHp?=
 =?us-ascii?Q?YVDRCErWn1bb9UtBgehuQYPmafqdZELhHeGjZRyDfpIEZeuqV35ohSUn9vNR?=
 =?us-ascii?Q?HO/84+Ory375WkPlmDznpk3fAjSacVdEtyyi6aRsI2PXO78iY6B9/Cwkofqr?=
 =?us-ascii?Q?gETtkWYKUqLJRqul0OrzrgcdJRcXynOXFFa/xKwk32p29bIGTUxdYnHuuVco?=
 =?us-ascii?Q?KhbJDz43MaK9T7zCsJriknN59sfPsn+6xl/BrOcXx3D0ngvarLDGPqlQpz8/?=
 =?us-ascii?Q?7wzOkgj2xsHk8oYXBysKTquQ7+Lof+CA9PFZEBtPqsvwHmtF/eYFtP4OXup3?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3789bb6-c57f-46de-f4b4-08da5a75ade5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 08:51:10.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yIl4W0HNFu8BEAZmyOVgvwDflH4YEJ2vD8XEZEUAO40qMSVyxqvrLFVtILE1e8whrePbGixvfG5WihE1LTpD/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4381

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
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
+char _license[] SEC("license") = "GPL";
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
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red = {
+	.init		= (void *)mptcp_sched_red_init,
+	.release	= (void *)mptcp_sched_red_release,
+	.get_subflow	= (void *)bpf_red_get_subflow,
+	.name		= "bpf_red",
+};
-- 
2.35.3

