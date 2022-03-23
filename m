Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B589A1391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648027795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=el14mbDNzMQKfIz7X8FmdkOL32gSiWivSI0Gycj16jY=;
	b=Ch/+aZFOdkFeeh0/skJ7jejk5m24w8w3AU65UDiLWeUOUu3vpFEopRzDDpSfjE/GHOKoDh
	u/Ub3Dwpleopi/8mhMsAG+OMF/jf8X9gzR9VtndlJHir7J0Z2/G1DK5XcmyvvKdya4/rYR
	AmDz5/qIXeRw/+WJYsps6n7r8iIWrX0=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-jf6Gii46PW2gfwYCbw-Bqw-1; Wed, 23 Mar 2022 10:29:54 +0100
X-MC-Unique: jf6Gii46PW2gfwYCbw-Bqw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3+YAywFNg9Bydd2yP32glVVIxTj7I/i83J+lUKbNTyP/Kbid33B+B+LMoRsPrLVSQWjoDekb5loq2irQU0jXDw6nRaBcggnOdYcFbtY3irW2A51pWsfmTtbmYgtKEvKweN+wB8/B54DRU5kauri9JfEBkYWIkLgPgO7/Nd/vizYpcy0PsozBEu7N3nmVG4Br7+uw7n+Lk7tfCA/7Sdjlw1pY1sXiPujkaNLVoFl0VfumGo6eXZpXmqatC1X1OPmBkPna1Xi487cWKXsDZwQY3Vdbey0aMNn0HvEAHHkvaowlVTEz8VgF6zD4kYAN5F9UG1M2HSO/NU4TWYZbV5qOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5FH9XtcH7HyTwHY5I1wHeCwYLtUvyGzKzyt2JprDa8=;
 b=VFe3UpTxycrfn8R1reTA2gzHuInKU7dF8gNI68LPepq/ZEDKY/n0P+kQZukccndwXBUrLbZ82LPnhCjoF8xZiymrDMkpvJ5Hf446EUqJ1s2Tn4brRbiCwJFgYERb0XJkU/G37Hi0v4zVz03PyHjzIa6PBltOKdmvnFYWWFh+pRL4Esl2XSmxf5QeEzygOILh94S1qbMAIy0qnJlEko+eOE1ckT0PQxhdKNgbB+h6LT8eyqjf75wpaO28v9mSwdvGlfjUUAtlazA7//wDhdDpBT8IR6sszgZ6SFv/LfZccqfE1dGIYtJmQj24lxlTMTswm/2Nk98dm7i0wDRiJUecdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2536.eurprd04.prod.outlook.com (2603:10a6:4:36::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:29:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:29:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 7/8] selftests: bpf: add bpf_first scheduler
Date: Wed, 23 Mar 2022 17:29:06 +0800
Message-ID: <c5cd2d7d9f4340e1f696f873f5ee2220a58fc1e3.1648026806.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648026806.git.geliang.tang@suse.com>
References: <cover.1648026806.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a11471e-5fb5-4839-6e67-08da0cafaf34
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2536:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB25360FC9AD78D7AF64E7F244F8189@DB6PR0401MB2536.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F/lQPn7Vgr2s5NQjFYFprsTD42NpMz47R3YvxkhaVey1ZHQG74cS5sqEyV9dUzw7DulrbD4icX7qnjXWSgQuzz7tYYEGfXIirbQ+aV16VwUmTAcWW0MYT/C7zODdwzjJK50svTvnnZ58FyduPa/IEmiByFOyGcatEXvKoPLUCH+aJc11xjl904naTkczhsKc2pKyXOA3wSKSSSTyyS2qgAM9gE7hsX78bTcC9/+owj/trovLOlGEqlgJmTrFnHsj+JzXQiC1Aeq3n7btmt8E/AyShIFjaiDwMMPDJPa36qbAzp6SW99HAfo4iUTitOz4rl4ksT7sgKdGvE4DUS9tkciwMmVfuPzc+hdP1i/hGto20KJrVVWxYyoVQ9fnDWqHb4cZXX3i8GIGhXeaiaVsHaNTpGMCSDQAxuQReqpNtMqrjOmZt7je4tveuFuNDKCVHh/EGqhjGjZsCSsZp2wroVBS8hQJCQhZGTzJx+tl/uupAGQc4QsaYdLKTz8lQzGax9xUj94Pu1seQF1t/eWYypvogU3gNi00JNjNp8TRapI+wJ9qLizBqOSY2oqyKrFXrToy85nATA7h4AHILEJVrCrhnMRn/Gk38LPUnXtEz9t9/Vn6qUJSYtxnfRFVH3W5kIhJIf/CG5kwvS9a/RghMAO7iCTznSHhFtu58FQDgjO9N7viOB8RsmtWT64isQ3D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(44832011)(6486002)(8676002)(66476007)(66946007)(66556008)(6666004)(6512007)(6506007)(36756003)(4326008)(107886003)(2906002)(8936002)(5660300002)(86362001)(316002)(6916009)(2616005)(186003)(26005)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jCJCSQaYzT4TfSxHKjPSFSFRr/TTLFyJ+HEzO4Xx+F2p0tleRFDI/tBZDXmA?=
 =?us-ascii?Q?6rY3K5SBrU3uxY1vtSeaPUxnMm7tmVQFFeAt7n/c0nXwfjeJsF+OWi1seJ8F?=
 =?us-ascii?Q?85ehNU+vqBQyM11my8jkD8BwrA6Ev8f5DEOlnKpYfSkrcfDxxjIAh0GUYD8L?=
 =?us-ascii?Q?hDsoMKj1cotmvMg8BPXjnzsaVRnu1IQMmX6/aQwROqsVCAxmxt8KEiDm8Kdc?=
 =?us-ascii?Q?R6uvkxC0NB3yA5/7oKCF8AckU5isSX93WVKUdhZQTmJHPYxpc8uZVjjOvaQE?=
 =?us-ascii?Q?MHPMUxdovJOrFr2Bpznb3HnVjmDTYeMRCcbJAkKktq9XrM5CNLBz80DYzpmY?=
 =?us-ascii?Q?fZsJMUDc1UdA1f9Xatbus7SgsObGklotTiWkzu1zcOEf9wD7FZYjK6n2dwGF?=
 =?us-ascii?Q?y/WLvs5eY+YL6cg3k6eNnNnHH2U0RNBBift6Mlsn0i4H/WXplb9PUqvoZWcv?=
 =?us-ascii?Q?LoA7ONUNAjsOfAA/Yvwrr0ef95UbVhPZ0dX0tAS65fGn1g4rAFpQz0tlVzI/?=
 =?us-ascii?Q?ddgdZcPp0WoHiK6eYbmWq6rESiv8jYRY9IVXzn+q/fXyjtY1ndnhBmytI/Tb?=
 =?us-ascii?Q?iZX6nPams94vGedMXvnb3lG3ckkU8FpAY7IhwYye2aPT2Kwhp0tuJnF6QkUN?=
 =?us-ascii?Q?p26A2I09v9eCwiP3q4WaGbpbjrJKkZaIIG9tOy86a9/f8DpO9tOTACy9hc12?=
 =?us-ascii?Q?Yh/bbOn97XSg6Srk0FC731189rs6RpnWBb7B5/ft+kgM4Stt3DK/YvlsZ62g?=
 =?us-ascii?Q?Wyq8BoUQfhSjukDxaJ7r813D9xDlnP4jYmwvqaH5Sk/lsDYHGmJ4Lt3brPG6?=
 =?us-ascii?Q?tFhiuetC+6xK6mOHYfzc6ytQt9+1CCzPPF5btcVJ0eyYjyLtJHv/LTLlOk17?=
 =?us-ascii?Q?x8SYslXcbizIMre0HXswX53/Et6B3rIxSY6DfV0bvgE1nRgsfvEcgQTncjl+?=
 =?us-ascii?Q?dUCulWMsv4m54YvBYgBvjf+1WA9qAnq2orDDqsdhQ5ZcaNc1k7AN8F2gDU3H?=
 =?us-ascii?Q?Yr/xtt/pzJTfXSOGpJgx7MWoJwviHEHVwnKC82G7gFKihMETtLFNPh/VX0xM?=
 =?us-ascii?Q?s1Dv2Xi3eD6+F/cCznSdRNiHDXNY7EujNW3vYNti7KdaHZsD4rFWsumYiSIs?=
 =?us-ascii?Q?vvHBpoYCotkiw6KaLt9m8BxnZGp0IMgGuX5/gmEGRCZTvX9rWKMx9YxgHRE8?=
 =?us-ascii?Q?7B1oJwUwrHaIrUfuISCXsyrxLmhYFseKECds/VQZ9sgv5AHdLZoosa1RSxcl?=
 =?us-ascii?Q?z2na443dhUNg29nd25funo5jDBd0m9U7pszOBiuifdty1bXLIfost1Yq+b5g?=
 =?us-ascii?Q?c8clsXUpTgc7LSOQCD7wd0QgZUAc0VTcMK+0vLkuHAJTTkjv5FJ4XOQUrqPy?=
 =?us-ascii?Q?OV0Yfc34E6277MeBKKr9qYTzAlFURkUGUkqINfJlG1mJqQn7751nIToam4QG?=
 =?us-ascii?Q?4mN24FGy5ikLmruRQXpx6yJ7YnZIHKcuHbXVkZjlOTY+c+y/HjuK1w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a11471e-5fb5-4839-6e67-08da0cafaf34
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:29:52.5230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tX5MNKABXlEgtOmt9DzoXx99YH1nZ62RPdrWFEubPMY1kXx2WRV7nByW3zCL4GGI5LEto8nou9a7yCLR6UDmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2536

This patch implemented the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 12 ++++++++
 tools/testing/selftests/bpf/progs/bpf_first.c | 30 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index f92357597e63..5bb21b24231f 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -197,6 +197,18 @@ struct tcp_congestion_ops {
 	void *owner;
 };
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	char name[MPTCP_SCHED_NAME_MAX];
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+
+	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
+	void *owner;
+};
+
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #define max(a, b) ((a) > (b) ? (a) : (b))
 #define min_not_zero(x, y) ({			\
diff --git a/tools/testing/selftests/bpf/progs/bpf_first.c b/tools/testing/=
selftests/bpf/progs/bpf_first.c
new file mode 100644
index 000000000000..3ae5c1eab5f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_first.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
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
+struct sock *BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk)
+{
+	return msk->first;
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

