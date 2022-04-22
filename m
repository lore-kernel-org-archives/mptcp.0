Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE923CD
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 07:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650613426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RDlydWiAwHZ3O0hxyi4E5TKaVuJH+Dk8t/1KIGdEMI=;
	b=PfWLoBBPbL4XzEebqjvGKTriFZ+YKq5ZKmguerl3gl89NlQix+1p8Jr7nlu6ZvH+aUqRfg
	LSiL7d06MyihpPCZZfdiblLZ9umAQuw1aSRu+7DstlQIG+bdF96y2j25j2FFTfqiRaCxL1
	HQP6r0Wm3IIxHTlqlfrd+k12Yr24N30=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-aooNH5UyPeib6xvbGpfC-Q-1; Fri, 22 Apr 2022 09:43:44 +0200
X-MC-Unique: aooNH5UyPeib6xvbGpfC-Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9D2+PXqUaKVHIVP3vrgjL+UuXB9pyYfEAL+ZvhFFR2AJJR+k6qbWjywpNSNfSK2ts2i/4Q6ENt3ug1AFXY8sOO/AQuNCbDJNltyb/1p4b38qdzX7C/Emx0kuLZkvF5ihiHlsDv6gFu2FFHmkJmm7fg8UiaTTPtQnJRb7V2DFSQCHtR+rwN0oxwN7jVF0pu3HXZEJewVEV3pyEsAQi0SV9M7iM4KDmvHthooSe0UkqW7qIEJgZnfXDnBYcWsg62J1K8ROuJhz6lDkcSzhWhNDSpYVhFJGzeoQzmS93xUSYXyd88a1RsrU5vv5Q89HiSxBHyirdauSh9eXR553SqnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2K1eTcXjHmFeX1syZLtPL8603gz/hgxgKtqjwkUSFk=;
 b=e45SZ23ZIzFvSIpuIRvF3oQq7pLP9tq2A+YXcZ/7jnL02kAAMCjm30fBuwa14YNJRLpdsULX/tia8hPb2cPrviqwhZUsH4oF3PJCIOgjPb+HuqHSU6khU7inoHYV09+5G5CccET4nlml3I/+2bdF89viSJOwwgh2Sw7mWf3clRDPdR72zomBaiEt2eaGza6MX5PtteBvgphIQuJweS4cA98oteAJd/Tey2GhbMkITGHutwDlcPFqxZ+CaqD2ApYumR/03lOtND7hgGKSi2xIQfo9vxug3dmT7QI0e4kCZ/yxrIGysMpoDd+KVaXDRBFC5JIQ1VGiQO0SbjI0TabE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5876.eurprd04.prod.outlook.com (2603:10a6:208:130::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 07:43:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 07:43:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 7/8] selftests: bpf: add bpf_first scheduler
Date: Fri, 22 Apr 2022 15:42:55 +0800
Message-ID: <a165d9ba4f6502d2f592ab15dbbfe8576c432d28.1650613135.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650613134.git.geliang.tang@suse.com>
References: <cover.1650613134.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fd58ffa-653c-4bbe-bb4c-08da2433d39b
X-MS-TrafficTypeDiagnostic: AM0PR04MB5876:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5876452B92CF65BE0E04BF4DF8F79@AM0PR04MB5876.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xkLuLFo23+xl+476xYJcNH1wKdv5Chj2/TUHifSKBy4upNoGtKTiE0deC7nDfPVXLXpiPZ94L8tdemS7pIHYjX6PwX7zuu8ONzfiuk8uK70xLtY5L5m8XZNHl0pOceJgny1ayDtJW7zKvmKXnUlxHdBIpFLnBy92czbWkBVUN+vbMtsOWVGDGAdydOlfO+/FAhTW4cU6E+mCFMfwrV2SJBjp+hdMyCJrc3cMWpzIrkbcHKcx0/DDVs9WOnFZS8MolVTJRHwYyWbTEERN0GGsLP+SaLjs3V74TtIjnuOa46WFhVg1j4T3u6RPtGbowQsa75R1Njs2u2AyYf7yHjQv7UhMH8RyMWAllCwdwxBcQdmRn2U8NigEbznzvKQBAETySXLi0AJsvxiRBiagP8UOfY/dBVNxXX3HQONPXhduKEnpwgEi1GO+tsFISYVgU/RGPgX242ZfF1vnngDMC3WodHT6kMMNKvBZghEhBoNOwswidxOJEe4X+DDpR6jpgbHr9JFvRj7HZLvjTBOBP/r3wHt9B97wdOHbYxgr+T+AyjyRKIO9CvCc2/UfNquIRnYJM4GR1LNp3jL02QuYmshm/yzrs8f9Nrui+WLr+ej20Uf6b5IKG5ob/xvsPmz+kJ/95t8cryblorPqEcGXR77t17f4Nk57p8uSAOnGRjw++lzhhvYMN9DZUPjVqqPfi/z5u7oOMxocFeBm9Y130ZBKaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(316002)(86362001)(5660300002)(6916009)(6666004)(8936002)(6486002)(44832011)(4326008)(38100700002)(186003)(2616005)(2906002)(107886003)(6506007)(6512007)(66476007)(66946007)(66556008)(8676002)(26005)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XnsJLOHgl4Ugg81n2hVvTko4D65R062fRfdJ8rpmhSThMjPtc1bVv8y1XYvO?=
 =?us-ascii?Q?JMYqgEE6XUMiionOAga2dPm+GCghQnm+9H2/+MlkqkcqjE8TAX2RKWrTzqXZ?=
 =?us-ascii?Q?uqX55nqqsotODlr42yy+n/u158Y2LHjWRMXTURi9P3PUB9fmWq6uU37UargP?=
 =?us-ascii?Q?CfAIydocbnKxycGPKKgNrFLPX4m+fYGrvIsqciZ28cJDnTV+wHD3nhkM/0j9?=
 =?us-ascii?Q?qMFatzNhrSPANuyEu8FXJsBXHmOBqZyFQYrQcmcMbKFwT5BJmEnOI2RQDl14?=
 =?us-ascii?Q?2miib4KvlwHOctcvymh712qc//VbWRVYJqKXzhJKv/qd7vgBtfgTxv0ROnQm?=
 =?us-ascii?Q?0+8ahV7JcUumz9YlM0hFQigdkr3eEcopNSWlE4CVNMIO/coteB0agnCwSUNU?=
 =?us-ascii?Q?njYjIE32a0jdqFXSrvj/iADvg8Sn0ts88j0neYaXjNn9BwYnm6bRuHKJ8Y8T?=
 =?us-ascii?Q?KJRYlirB3gncDJu3z2SCH1Gupr6szNTVAF8l8sGxmBCh3h+ZcLWu/2pZIo0e?=
 =?us-ascii?Q?fziCxJ1qf7M4ShNwnDzWPDS71Wi5AVA2pLwBzT3pM+td5GALYP7B6Bner6sj?=
 =?us-ascii?Q?Arde3SfyoCVpSGIJLPWI+1LDDoE4xM/4KW9a0MZTiKsDr/XGfOd/i53l7t8h?=
 =?us-ascii?Q?H0VtwXUSYP30wSec7eqJT1Pdgj9FlfdjBBrL5vlpoNAdH9yBWOmheLaZ7bfU?=
 =?us-ascii?Q?TQ8PkMCRyWY7i3och2Aj9WDze4aZZFuAFILsVPRS6ZIeNYK/fcEK9fvtF0LY?=
 =?us-ascii?Q?N/rmlInrfrtEXtgAZENNiq8iGazAjMNrWtejvwZWSJaCnDz1b3sZHhlJIokk?=
 =?us-ascii?Q?2RRXFzUVIwPs6eeFA5oUAsAolyViPsFU+YxYKNlUQIkM8ShkX4OzXPOfMsLU?=
 =?us-ascii?Q?668F+PCn1H6GhH+ySFgkyoppAcbbV3Iwc6atw0S0ffDTmhxMpvpPwLcDteyo?=
 =?us-ascii?Q?6fUC2bdzeiNaOXJipL3dbBsDU4LmXw7aKSEDFUTdIk7K9/qqA6gm1Bvkiq2+?=
 =?us-ascii?Q?c02dKrXgBtbteJIjYvmlykCW9AkHdbZeELs6+jcJnRoPWvbyuCVT1IS3b+Cq?=
 =?us-ascii?Q?wzUkWbUZd+aJsPozw3tdHoxvjuGb6YYMDCx4olHr6MIRKbDTPv8iZJlg6DL3?=
 =?us-ascii?Q?IROZXUHXEJkoxeGgIwNEzqzJe8qX915wN2SMjSlAAqSjD9p4EEJllUReIk7u?=
 =?us-ascii?Q?mnrwbMi6WnobE7NoO5c4SbfAkozqa3iq9L8U8QdYJvLYFkqN5br7M8M/GRwC?=
 =?us-ascii?Q?j2dLZuRk9GWqrLTm1Z1S9a3N7JItHmy6aYL7bJJh7/SXCyflOWLjjZan96aY?=
 =?us-ascii?Q?yP0hZtHvdydLFIr/Qd+wBqn7lMMhfzrd3Iz+PA6zsiZgCrcJJTFtzYm0JEpW?=
 =?us-ascii?Q?9LfWRthH7Bu68aiQBb4tqF8+HUAS+e8dHU4z4yoODRDxy5ZmW3p+p7E3GxV1?=
 =?us-ascii?Q?cYsdcLTZ40Br1IvWC7/Hk4dWqR5DyVoFeG7WqvboE8adm0V+6citNp1oPJKs?=
 =?us-ascii?Q?7iFtg7O9V1sqe2CWr/NSPk+NT9zx0yJ4zyaF/4m+0uITHWntDuKVOrJlw+Dz?=
 =?us-ascii?Q?4UorQ8/Mfh4msz2/qUWYSGQULV7oCkzelC0rMTl/r8Uq4kqJGH+dv14IpCIJ?=
 =?us-ascii?Q?6SHLOR6cDM4e8HiI++bWjjjCZrHiPeDRGgYy4ReOyuHTpAMnfu2cZgaKVzji?=
 =?us-ascii?Q?3eqw0KEr3zEDZHDsey3YlF53dN6PvG8UPe+8KHg3PjZYuCueLHFzIhf9KVUA?=
 =?us-ascii?Q?xXBAza28fshNEzRBtDHWD7gMfmvHiIA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd58ffa-653c-4bbe-bb4c-08da2433d39b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 07:43:43.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrgrpajtmwMzpuWtBJKNJdka0dSZaC7f7ei416b7tBAqQaoQEHK/fzdU5qwmw0ZPSNXcnu/aPm7/aZqVG8LJXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5876

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

