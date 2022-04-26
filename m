Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579A57E
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 14:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650981700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RDlydWiAwHZ3O0hxyi4E5TKaVuJH+Dk8t/1KIGdEMI=;
	b=E6mhOvwVls8NN/CbHbYtiFvEjFyra6SBRtsgumT1FmtepYUrxXYW3XITFVj4kwgJ96acb9
	FqP2HgxRA1eoz7RQdyFYVnVyNVqByCcJFcZhJ872vvpwjr2xXKCf2XGdG1Dx6Vr7L1pq4A
	1v9I0DEFnMxMZywcP8xIaYj0ztpDPbk=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-h5ib9KwGMD-v8zxB-5YBCQ-1; Tue, 26 Apr 2022 16:01:39 +0200
X-MC-Unique: h5ib9KwGMD-v8zxB-5YBCQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzssoXtjK+/AlQ5s6qcmFDcP1V/0auYwDPE+GSTIR2/YRG7HQSDgJa3ZwPCq5YyLdUidIpX/MoJULItxQ0otiiEBRyX/AsHIzMMhkiGENWJqY9vK1+silCp45Wh9z7KRcwZ4dwKjehcSKSjyDxxxlFjfEVAKP7SX+GkOoU0tcU7DB7LHrcNf5sOenedWVqZASxd7y5BvzqXkmwcZcG5O2LjKG0nDTVEhU74dJ/t7x0UENC3yU4FuILp9+dikJ36gVvXjwoKZGTWUyUtFwH758C5iNaQe7yD53izwTxT5MxoiFUzWXC10Hlz0BF5YcGzNTOdTzf97OTFoq9iOMT5R3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2K1eTcXjHmFeX1syZLtPL8603gz/hgxgKtqjwkUSFk=;
 b=NxYNrsIUT3t/EzKyAAVy7MMyEEQQxqCq0qPSpSiuzSP2Vx5557dBGJXg0KPsfrYXQ2RptzcreTDkqlnp4a1391dnwxP9Yaqebee2R7cac+x6IRlEFajYOggF+Fu/DnkjDpua3oldm+hT2x8xI1Y5/97xvp0GSLwabGjWaX1gXt/zfMrYQQY0V4C3i1jvDYDXCQRPpTjJj/2BToX2kzhUVbiei7b4Zg64oFqicbLHvdZ4EeYt9JeUADy/gib7EOl3q67IPZSkEKqTzr7P9bJitnSvtCvQVuD4/tcTclpLm86lDauhGMn9DAzhmSNWhxLU883WKW6OalgygHVwk/b71A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 14:01:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:01:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 7/8] selftests: bpf: add bpf_first scheduler
Date: Tue, 26 Apr 2022 22:00:58 +0800
Message-ID: <d70fdf58f787b68319b5c4262b98480bd54d3e3f.1650981078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650981078.git.geliang.tang@suse.com>
References: <cover.1650981078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f79847d-2e90-445c-544d-08da278d485b
X-MS-TrafficTypeDiagnostic: PAXPR04MB8816:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB88160F7F0F91E0561376AEDFF8FB9@PAXPR04MB8816.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JJaXrWtH6jJHWGG9rBnDizqBw5Jspea7M3Psp6MrZ9mHzNrvknmrBiAxBVOj+VmlTjO7JiEu8CdvnfpmrPQjM9d6ZMbuRiHEQfhgc4lZDu/owwxAuxlxera3hNw8niEQ+zq6rDADGt6s6iNJ173vXUbVD6wUvkyJKe4bSmB3Z/aOWwwy3Cx2IWp59tvkbFKMka+IhiasXhqmuw2fIAHzZ/BgFLvemt/Krzp3Unj8fciLnj+0rQFVFc+Bw9s2POLcW8jtS7c0aQQIxHBoaipiresuOwmd0DCsZ1fGO4A5JyAeS1t5PePom43xhvmLqUSUUdkF2tNUxiYLvaA+K5JAm48h6KC1kRTeigcSepbC8QBzpPCAXw6qE9mUJbEM+XN9v9rEWjHsdFVIdH7aqqQAMtpcFmoxGfH3bdZtKy3Asolkb2HprqG5I8/BJs8+CBidhKyr/ncmjtnq0uBIKhEbpgpFFmFItG+mItRG8S6IaYEfCAfOO08WICY6HTs66hKCAMkgC4vxDMrllDRUvPVBob9CxMI+koSKSHRfhJoSWSANz1oASqBa1iIpaf22gM6jxJ89NFxh/qae3jCP7DFN7HZvZGmtI7JzMeU+t4T0SSpTUSkqihbNrXnB6W0fpFLDwPI7HdwbLTNei8XRzdpa/RGHsV1TawjG73Uk5BPQg+Xol8oXdNkONm+qrcEUAPQALDHsAdTaIOKeKDRplw4UIg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(8676002)(4326008)(107886003)(2616005)(316002)(6916009)(86362001)(186003)(508600001)(6486002)(6512007)(66556008)(6666004)(6506007)(26005)(38100700002)(8936002)(5660300002)(36756003)(44832011)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L1u1Rbs35yhI5HmsAt6JbTc8dWUGomiosJlddN3sbxI2FrRzZGkFIom7f21l?=
 =?us-ascii?Q?11mvtwq3+xwKGkr4YBWIezluqhkBCSlSwOMMkrOPc4HLovczUvR0IlGRHuMr?=
 =?us-ascii?Q?KqwXrGsfUT6sr9ufJ5r9vRu06MtQ/FDv6KxoiaU/brG1YBOySbdmPRF46ZmS?=
 =?us-ascii?Q?rBpAsmyzqQ4e70cA6PzA28Oag5qYOpTw3f4FMSUPjRe+AdA2B5jPjYayDKeU?=
 =?us-ascii?Q?aZdULxqZS/FzFzenpiL0lP1QLMiSsmEp72h7C6MZPN+aV8oUQmDhPIbJE5PF?=
 =?us-ascii?Q?4JgROtNP4ny392v911l15+yqa6zVjD5fflpN0FIHV4Lcgv0ALylcYq8Le3wH?=
 =?us-ascii?Q?puNtmgCtg97eiD3to12OybUAj1O0znHUTTf1vG9Q81N93mtg3heXlQbPcbyi?=
 =?us-ascii?Q?GN9ywnrXsNPWmAG3jK/x7GGyEoR/SqaTKkdryrkYZ0o4uiXvZAA29qjgay5M?=
 =?us-ascii?Q?KtpEW7g8Mk+aZeVUL5/i1lm4mEzrEfubCFzKYkg2StmX8lEB1KuAZqngbXYx?=
 =?us-ascii?Q?itHpiXRWVfkyFGgKQR4ln26NT3d3mA9R1FSEGfrJ3vFy0uNLVOyypwkQoTEy?=
 =?us-ascii?Q?2aOoAC21N/7+dP+T6jx79wvPdad6Z1+Su9svwtRiuCglMCDSUFjIe2D5ptRV?=
 =?us-ascii?Q?GB3N1oR9Bgyd5RsDQV680lv6lNLByOh6z1lcTC8J5vTaPM7WBHH/qMUVJi+1?=
 =?us-ascii?Q?nWUitrr6MHuyVuLzBCAHPcd12cKkbUWrEvwVVCkdR9BM8xCAkRUby95FV+PE?=
 =?us-ascii?Q?hvHhz9Q1CC/iQPOYwadfkb3lLUTiqonDiGLOu+qojSfcTY0Pan+uB6t8ctpV?=
 =?us-ascii?Q?XNRtDGIyMNjLKBNriScBAYILBSBZlb2l5X3LSDIRLsq4barL/8khluBs9I9q?=
 =?us-ascii?Q?GpvkyXkmIkwAR5NNRmNTJg3Bl/HTkTe89K0Chrz5YmHhQSFcfa5GdMHr1lCy?=
 =?us-ascii?Q?t7ayUA2J8oQLlztiPzUws48ypU97Oox0AT+rOZbxz0LE4sFkxMs8Fba/REx3?=
 =?us-ascii?Q?fD+x6dlZzseKjClhmJn+7f9wKAN/wE8Rmv7wdz3ZU74e/UXAGSUEVxc8aBvH?=
 =?us-ascii?Q?XgaJmyEep/BaEabs/SV7/NbS6aMn0UBMUfMngvuJ5R3cRUQxxa3FtMV6kzxu?=
 =?us-ascii?Q?0soTcRP6rFFXalOcW4GQSewrsR7dbxWgNm2nEy8j02vqlSeZ5hnDFkbm/fBY?=
 =?us-ascii?Q?UzlkDxrqFlKAI8rY0Ey9STY9Fsj4VBiccB08HOsqNxVnPWNQKx+4UceMuy+i?=
 =?us-ascii?Q?kdaDnx4StaHgE9moEZzh2nYTweiOD9ViBZ0z4+LmbsfA9iy/G126j+DnbYkH?=
 =?us-ascii?Q?2UYdbaxBWFniqj6OpXkhBdchdr0oTdBef6xQUtHEuCkouD1vTnIJh3jqV2mt?=
 =?us-ascii?Q?Y2Ka7HHrE35vD58epKnQ4GmhpSfUDjMw7XAJ/M48MRKijPs6qYfWr5tkwf4B?=
 =?us-ascii?Q?/0v/sgE8q1hsm3cUlFJmxAPXtwvhtrzDxm6hDY/Pn8Velcc4lQ4bVz62XdPD?=
 =?us-ascii?Q?ODMO7I65RT9k8PGbbDTEfNmz+F7a19TUnh8Gc9PMSv5XxNWjxtPjO6rtg5Z5?=
 =?us-ascii?Q?VQWNLzgZfj1w+khake4eWycrIDuvsI4hcP3Hm8xLnYepoRfb5bRA7f4hKTsT?=
 =?us-ascii?Q?ZLQQo0MShEGPdXF0iYl7kf2dLcVWpEB3q8b3l092cBQXfKKlOGs7zq8PeB0N?=
 =?us-ascii?Q?gG+OxRdid2KaEFxVbdov93EXUW0JcRYlvz3iLfUzfOEu2B/kBxWnYW1T/u5l?=
 =?us-ascii?Q?4/YFW45/4X4FBOUNDHM9fydvBQL3DZQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f79847d-2e90-445c-544d-08da278d485b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:01:38.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzSXYzaCnJMgxD1DFO/j2kFzasn7/x6WpWUm+NQ37htnWqFEGJYnOCNdjdKUt3Qtl3sPJOcK1U2r2n6eFeSolQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816

This patch implements the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data. It's a sample of
MPTCP BPF scheduler implementations.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_first.c     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
new file mode 100644
index 000000000000..0ca9754c078d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -0,0 +1,32 @@
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
+void BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk,
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	data->sock =3D msk->first;
+	data->call_again =3D 0;
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

