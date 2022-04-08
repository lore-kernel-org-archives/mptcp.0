Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E52564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVwBHdrLVdVHLDS9ssimup77ZbpXQ8TCJ5+gqPHa3kU=;
	b=adu7oxWxD2wD9LOVZzcLhlseMq96LDf+KqC4utWZ3yhIKKsangguvcLCyXWg+rnZS0l7cv
	Z5Y2pKHS8hb/O4SO241iy38PyXzUGOcvzF6OhEoFyf4a9nZCYPW+yJixDyZn+fF/aZWS6+
	KEi6fbJv0VQEPl9hPoYN+JB9Z2AxN1Q=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-tamSOaW9MbKnJWvCih1gYQ-1; Fri, 08 Apr 2022 17:42:59 +0200
X-MC-Unique: tamSOaW9MbKnJWvCih1gYQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3+5utFHPFlf1cBw5L5U/U+eKjroP+CPRYUJU18NFd4OaIXWElL9hQ8OSOev9qCVztx2rRkYipoHUMBLfy1/5pLD1ETk3aFdUwZrHAjf3YsornZBRpa1tkUizcXcTDDf+w8OqfWFLOYHHDg5SUQD4p4I+rAbezLFSlYjzB1HB/zLMVDzXynxcLggSTB33ueHXu+eztwk+UJpVpu9g/e7/8BQGP0DrcU/eqBHK4Ko4Dd5U3iSZv7BviHWjzpxYCSHCqu39u8iPdVT1TkoQkaJvPNPS6OWTtCyttGvHR3B1e/UgYD5WcDZQN+psudFMJ5L1Q99jaoTQkeLCKkQuRcTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nw89snvEEU7HUpdSkIBXjqV+CDipC5SNv5JBvOPcUKE=;
 b=MUWG8SzqMfe57nCzaXcTUCKI0jAEYH1kPErHB5pVThExpgsW5Oqm9cB7d8rIuW5uQ5i4NkjAPTzfWIOFfVcEhSmjJnlDr0JybReXUG4BNjSkwPyhQsVJcmg9whtxSHN+I0cJGGwsi7ko5xpdvvESVvWgeA1y/0yOfvwYRvOgdpd/i6lZTmfw1fbX4aT5dyRmhWwIqj8nLjBU/ZvDMwIrQUklGyaeXWf7pVA+tlTa6cdsjp+KxVCGooW00PfqhLhP95/HIo6LUeAB5pDSixYdtHPj/cPCdev3wMA/GQv4jZF9rgzPlXNjVarEjvnHbQhLrotYNcEmazdWiEsXw6mRFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB3957.eurprd04.prod.outlook.com (2603:10a6:209:40::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Fri, 8 Apr
 2022 15:42:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:42:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 3/4] selftests: bpf: add bpf_rr scheduler
Date: Fri,  8 Apr 2022 23:42:34 +0800
Message-ID: <e79dac6191d73e4af8f44c109032a5e029b67187.1649432434.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649432434.git.geliang.tang@suse.com>
References: <cover.1649432434.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:404:a::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77830053-0267-4551-70a5-08da1976721c
X-MS-TrafficTypeDiagnostic: AM6PR04MB3957:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB3957A5955A94554DC3DF96DBF8E99@AM6PR04MB3957.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hBsgMtWUzD8mqRJG4O1hdI1QkM5ABK9t0H4DuJxCaSIC6OgRslcBpnwQ7V6NasQlFORSnmEwttzwghahWBzpDOlAn9ztBixdJ/a2HALNgXDl5mnYutD/2Ag7Wc7/8K6fHhFwgVYLuUdHJUOLvdjc1+Mv0nQtANg895u/7SutKXOn+bzfp3QPOeEqfKDRYQ+/h7waspbHDqD6z1rbrPO7Qfq+yOD5WVtnX1/k9pIytl5sBQLEreyV03UJc9V/fsIOyLNZdlEkdlCmBCU7eLX5XxoioB59gcmw6axPGlgYK9N61sgeOgeIOlzs+a7ebciNhQnsuVJHEz9NqqpWxYbeHnwfQq+EfjNIAYONNWmfBOV8awkeFa7/OrGBmEPeZwlMzVSRzYm2fXOGEpieJRub85FAe02ufGi8UPTSWFEA5o6SXFs+ppCTJgyT5ETMF+m7XifcccTYJ2YB0Pddbbm54yMfuKs1O8kRlb1U7000nQLR/IKG+kKXqBN4oxsc4NGzpvcfA/Tn2ts24vGPCVu5pKsvPdZUwibWMHwzbL8hdtwSeV3RRoUaoH3W4S7moHNRmcj8T5woqt6wRsiQoN0kvyE2OrMNM+T9ntS9LyRg//csOePosgovhq0DP/8kDMSF/dOxAVqlsAIoRPaSeJQNU/kzUP5NLKLcYKIDFfWj4qhEwzSQG030JxJUvdjQyYEUd97kRbxfBd9gyNTtL2AqZw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6916009)(36756003)(26005)(6512007)(66946007)(316002)(8676002)(4326008)(83380400001)(186003)(6666004)(2616005)(5660300002)(6506007)(44832011)(508600001)(66476007)(2906002)(86362001)(107886003)(66556008)(8936002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIrapjO7UequUIbDrXlwiPbqSZEVZj3KecMupo4P9cOxreg7C46SFu6nKv3I?=
 =?us-ascii?Q?nguHAgnwKvTX27/OjiIMXeuzpA7bTBfPFBHRqTXC4vx5Qq16L9fIUj2uRzTq?=
 =?us-ascii?Q?Q8kdYSsnyGDoIMcMFo1C6ZKJ6/9J2zCKP+FdA93Ksnu545beBhulaN9n/eBD?=
 =?us-ascii?Q?n9F6NK2czWb4C2IxB47UY34sbs1EIq+yljlMtnsApRyWCjyxvIhoLpEIJwL7?=
 =?us-ascii?Q?9HzUInbLQtHhFDqIIDbJ78yGQDcjq9YfAtUWxFjfWFxYb18hC0T592zyagf4?=
 =?us-ascii?Q?DXlqlyCjI2JN6TFBNBz1v+pZIOHA9HimIlwThRuaXRUOTUXc8PXB28dPp2Ya?=
 =?us-ascii?Q?iAgl05+l7wygyDt6XAkvo8RMpU7R2eG7SKqXJZnW/ZVXIcj70zvpReiuMMcv?=
 =?us-ascii?Q?Sh0eQTZV/OMdsnePXkWpTP0grTEQhsvATkQ+BVcu3iXrzm2o8rRVmwI1kH0v?=
 =?us-ascii?Q?nvNGyVikfw+j17Wvqtl8fLhwq1Ut2j2iY6U1eJyecjzRnxGXHGDzBg2SGQVC?=
 =?us-ascii?Q?jU3Kex8tzz3vi15sB/zLi1Aoj0bEGKu+ka05QhXFw4X6F6hmxgonlyqpviXA?=
 =?us-ascii?Q?7smWDeHvsn19g3XKdRW3zi21cAZCcwRrl7xvl5YYvyjQG09cENXsWJgN2nmK?=
 =?us-ascii?Q?yDsnX56wJqrQ3W90yLICS34rxzJgyYelucfwYOAD5SuhdjlfdcynNG3c8LZL?=
 =?us-ascii?Q?CLG8GexGHZZTbm9m5n9raXEgpuSWVCx6MmbXnqLA2tySmP2y/xF9zX20VCfz?=
 =?us-ascii?Q?Pz0KOiTSqRW3FHvzQ87f+ld1jEm7U4+S0Vbx1OplXA9ofuqzXPs9zw81TsLy?=
 =?us-ascii?Q?3ebGIV6GvjTVXcaRIX6VwCUOO6+51X9uU1DpQ7IMC27x7BiSOfZyLL7z1nhe?=
 =?us-ascii?Q?+Atv8Oeg9h80vcgBWrQQ/WlZmU2tFFXcgNMzdN5SbitfeesxFHBMnXSfTF+/?=
 =?us-ascii?Q?EVBckie0FO16rfuVq7MTBotOS0sEERrKIePSMlppYdn+djh/Nr/DD1UbGOxc?=
 =?us-ascii?Q?cBviddSncTln4le4afdlpBesgffrlFEKXxsmMhTnIIFZ5jowqYw9eEIaxzUQ?=
 =?us-ascii?Q?QsMbalmleIImZpeOAmhOyJENaAVXH2PyuWeCoAmiG8yI03KswD9ZEfXJ7bpG?=
 =?us-ascii?Q?wi+SMqdmMgPmgflS4WuBE683BHO0TV8Q9NQ3IF3VAytoTfF4+J7oeoZUD/97?=
 =?us-ascii?Q?1q9CSlmYpyzJiUwgoqS6WY/WO5GuxoygcfqmaMPsIKfT/8+NXUDSdwa/krhD?=
 =?us-ascii?Q?5h8AFke7HN5lETHUhRc6sxrpxhHJuvCfhrel8LwK7qeWO+4KFjBD8IK0Y79J?=
 =?us-ascii?Q?KZJLnnSKcLtHWjtJXpL5WVIyhcag4mjC2gUwfZOpufhYy3BzHf1PMuXXkFKs?=
 =?us-ascii?Q?hbVN5YyzCEVExbkMTu/EwLHuc/qOPNHWwtjb0FgMLIKyypASRN18GmnUOHcR?=
 =?us-ascii?Q?Tr1etjv1GYoLnQ0vDrLW/MlHvpDiEztL2MbY7//zVDONGB8eHSV0EZFWq/Iw?=
 =?us-ascii?Q?EFmaOad9baBxRLF9+u3yL+tDktp7LJWIKqUCN7g6CIM+CNWaIgIjEutquicC?=
 =?us-ascii?Q?xk4fS4zYZBRGaPKjBepbGB6BJb7sWm9KaSRmEZqnXh/guB82kKDlZj7Gawrd?=
 =?us-ascii?Q?CmnSpQjpWfxVDA4y9EuZSV9Mwh0Cx4KTYmg/ViqICt9CVQNbaTpUYQypNgvt?=
 =?us-ascii?Q?1Zxnmow02UaMeF3LeC4sjVqKk7erqCNnW2MixjRE3yCbtWkCE5y5Io39WLsG?=
 =?us-ascii?Q?VS4l9JMVLlc2ZlEQ1JgoyVhCYPcGigk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77830053-0267-4551-70a5-08da1976721c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:42:54.2022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HziNeGarPOi9cp3M4+xQOqZdnp6jdI3eO78Xa3xiyvlmuQ4Lc6Tbts3/xbRnIKeBY586bM3OLz1HPSVcF4/s6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3957

This patch implements the round-robin BPF MPTCP scheduler, named bpf_rr,
which always picks the next available subflow to send data. If no such
next subflow available, picks the first one.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  8 +++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 50 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 4f82baee998c..4c2ff78e0a9b 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -6,6 +6,8 @@
=20
 #include "bpf_tcp_helpers.h"
=20
+#define MPTCP_SUBFLOWS_MAX	8
+
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
@@ -13,6 +15,7 @@ struct mptcp_sock {
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
+	struct mptcp_subflow_context *subflows[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
=20
 #define MPTCP_SCHED_NAME_MAX 16
@@ -27,4 +30,9 @@ struct mptcp_sched_ops {
 	void *owner;
 };
=20
+struct mptcp_subflow_context {
+	__u32	token;
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testi=
ng/selftests/bpf/progs/mptcp_bpf_rr.c
new file mode 100644
index 000000000000..cdab0823c496
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include <linux/stddef.h>
+#include <linux/tcp.h>
+#include "bpf_mptcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+extern __u8 bpf_mptcp_get_subflows(struct mptcp_sock *msk) __ksym;
+
+SEC("struct_ops/mptcp_sched_rr_init")
+void BPF_PROG(mptcp_sched_rr_init, struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_rr_release")
+void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
+{
+}
+
+struct sock *BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk, bo=
ol retrans)
+{
+	__u8 nr =3D bpf_mptcp_get_subflows(msk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk =3D msk->first;
+
+	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (i =3D=3D nr)
+			break;
+
+		subflow =3D msk->subflows[i];
+		if (subflow->tcp_sock !=3D msk->last_snd) {
+			ssk =3D subflow->tcp_sock;
+			break;
+		}
+	}
+
+	msk->last_snd =3D ssk;
+	return ssk;
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

