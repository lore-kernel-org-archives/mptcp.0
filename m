Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6C28F3
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652271491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4Pu8vTlD18Oma7+ixgjVcsorCuMmBQdq4o1zV5XsKI=;
	b=emyGTRpLa4dOb/ED4D8j8GV3h63ebz8E0TT7Nfd7heolQBVhcwApnPKTzndN2hzh28QrOq
	ICrlJjJFfWhiHw3xqmNryGhl8ILx3TuSmqRdbDYEOZt9IQR8bMBIJlozxbw0dGZFYxx1Ot
	YtSiwKu0CG/a7w13Trl7PVJQPq4i2sk=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9--osboKs5MVqwR9pntjilZg-1; Wed, 11 May 2022 14:18:10 +0200
X-MC-Unique: -osboKs5MVqwR9pntjilZg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx7Gb1X0rW8bPrxk5USkPj62xFBHUaz5oRSDR52i41jitav0AMlfrVXqZYEUSwVtOjvU0TrigcNrK876qsmoOt+hVOrTM+HFJGjc223r0a0Men28r6sT73cOjqvYhyxv/KpUcpijAHBDGsBaO5u79uFQ9Z9K8lf1jZVvrqH9anqA0FGdWSae2o5kP4uxxiGZXeXi0aXSRWn2EjwQkW3TO6XCfALvMsQSnqxvoLSO4rMrcJu11nfvbF3c5OmgChV1IW+8gRzjSeXNdEthqYj4M4JY8yFzp61i3pBFJa6wYB3tuhc0Fmndwo8zzzbWtwRGoI/+63ZPmkMn8bAvu5dDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6Z9aVh8Xcv2DIh+yS5PrU5Z+TOdnbREVPtk1Ai1UKo=;
 b=MKPW0q8nyzViVF8IsydOXNEfDVgbzOkK+FCXM0UiIAZl24vWg088YuISS1rjoz7wHCUGy6tTG7m0NP4KmaTxhQV6AqhlYFsejAAQ9jXZNI3fA0VjIXOlQjbn8+n8ECAvEaxfsKE0tyMvsOA8M2YaJ9GbomiIrGG+7pDjcipKEnH4cQAT9TaBG6xF6aYrnOEIGMK7RHVpVugcEE0eUq8dWR2AJbHtW/7v5O5IVYi5DPoj82IEQH8w40/Je0k3gtTIjkt3Rm/UKOp/93m5i2sueLxycfndbIGQc+N5UCk4bWhwyNVNMIhBoDDkZjNmbwKF3TsCS2+TcpGwj5tI97S5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5716.eurprd04.prod.outlook.com (2603:10a6:208:128::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 12:18:09 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:18:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/5] selftests/bpf: add bpf_red scheduler
Date: Wed, 11 May 2022 20:17:44 +0800
Message-ID: <d4030fcf25c89148fa26b72a04678999a27c1e59.1652271034.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652271034.git.geliang.tang@suse.com>
References: <cover.1652271034.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bd226bb-4493-4827-136c-08da33484fb5
X-MS-TrafficTypeDiagnostic: AM0PR04MB5716:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5716692E5E974B608CAA1C3CF8C89@AM0PR04MB5716.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+ChWkld1P0S6XM/+N9bmSWQ1Wlf+86qSmN1m3RogR7UtqV8xI0kRI23MT/4WcEiCoM+QSSRuGUSgZtPp7PAwynRHPc+n9YDgMphg8/xG3uSV6fxKTYiAVWmlkcvkzUpozUh46K4PKtezBYG3g4FbUgZWeNExayuse5IpihaX+MYOhLDaiHhJYxaiDZ9A2boqOErJGZzCRpP3afQvlQw+r6qqgZaWv6UuRca3OiCQUwjgUtQ1NbvVIh1mRtTGlI0Mc3AMNJOKZd/86WTaD9hwFKy/+nzJLKB+CJtmvYC16cIbFosdXQhktKhEa3zeYkiFEZFli0j6KsFk27RjsPR5brBrZKC4lnzjeSwAo2p+OhqoLL/hiY9hfA7s+9xeVScCcU8AfuWCT6wLIuNV6BP4Ac6mR8VY3KCEMpSYxjEh+y36nxnEfG6lEHuWXidU6uCDsZMFEo1YOPofG8ZU0hXFi71vuSuCM4huSDsBatonQCPjIKW/HZRPOpex4Vzz4w4bGwqwkXMH7fHtErPfLckzBuJjjie/+x/fnchdiF+BI/8dAFSOlxoyGlPfSth153AYLhd48NyMhagJb2kLqQp+FvzTtXBsyUCJtutpylc+vhm8L9KN3QtQ3AoRgyyQoFW/ITMCEWc83VH79QSSiexdMohZ0ZQYIBPzguEdS2u6DqE2xc2i4LgNvmW0URUSHleHbCkCS4LKnLNMQwURzLqT5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(8676002)(6512007)(6916009)(316002)(66476007)(4326008)(38100700002)(66946007)(26005)(5660300002)(6666004)(186003)(6506007)(2906002)(508600001)(107886003)(2616005)(6486002)(44832011)(36756003)(86362001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xcQwKGwum4f3w6xvvcP5R+lOYGxJeCBj6DVGtmAFZK2PI+vhrh+44Vlbw0Nz?=
 =?us-ascii?Q?aoQ+Oam/za13TqildaOwHCSVI4dq33ImDuZtF+YkJxbMjQKMPUP6S0fuSX89?=
 =?us-ascii?Q?sjZBA+zI6G/hM4Y1EMmZZ1JOjMMxlhwXB1HYDhIkbv/HoZfFr2ZW0yk9xFz1?=
 =?us-ascii?Q?m0k21du0OzADQ/iIwSOguKH/PyXqLqda9iURw8Kw2giiBkgqksLh8yomiM6s?=
 =?us-ascii?Q?c0EmWsRwN5zAc+wPWxRBZs4akNRRXYEW0/0BcaWRFpS1Cr0+7EWrbdpicTn0?=
 =?us-ascii?Q?2ktwrpe1quQvy5tg3f2Z7XDBz7bblE/DIKKTefh2iIxMp5yBigh0VFBTWbI0?=
 =?us-ascii?Q?lywPwKvB1RoRypXLH5ajzxFV2Rfzic5mhc+6YLcPvF46AUI8nB3tWqeBhAYD?=
 =?us-ascii?Q?wCdGIqyWPOGbNCYPQtlUj/nuZRy2GH17d9Qd0HOEVYpLimZni3T2/w+263Kh?=
 =?us-ascii?Q?lxO5YP25gnTQAycwMCq5z2UUCfl/2bJ+MygjNvO7trAGrJjn9PyDLRdq/SZ0?=
 =?us-ascii?Q?5mXhAn3ITNTANV1qDXJmvJiH2RaQ1HF85zDK6Xsjoji+/rbc0/+FU9kzERnO?=
 =?us-ascii?Q?T/A8zk/HavnQ/VxhREDyUSxIHdO98VH1YVDqdYMac0i+SvgqqbILXhoqF2Dl?=
 =?us-ascii?Q?vrMp0KZ2Eklm5nijIJbg3ffI9K+h0SVla0Ikq4Oa+sOgd5kQZodVjHg7wuWc?=
 =?us-ascii?Q?PtMIab4RZmuY03ofV7oR0QR/PETyo3N53utxyDT4bx9Gk+S/FfVvS8SPOH0p?=
 =?us-ascii?Q?auNU7+Hu7iR+LTE5MUFA6dLuO2fkIXbh8Ql0SsnmhrrC6wCPYJSrvqWoFhmL?=
 =?us-ascii?Q?vOxUtgdfV0G/WvFZviIWzuTJ9vaTsvFU6HhVkqNcORmBbe3XH1gxn0euMcpi?=
 =?us-ascii?Q?xurn7IQ2tKk7REJQeqR/RBV/MWqn0YxDiVvgrwfpH65KRGmto6xjuOC1mgyM?=
 =?us-ascii?Q?+DgY2TVOJ35rpDawkfDGl9bwF8PxSt1ucNacNaiw812jnT/hxL6nkzCNokLy?=
 =?us-ascii?Q?vTAlEfgMTKpofpolRugF5Vh21Wx3U0UG5fD3zxDDvlWuZvy7uoaaQfXGdIg+?=
 =?us-ascii?Q?0m0gsw+KoP+aWYjKKTmFKzU8QaxwdP8ptmVJ/BCREJnKk82kQ4HpsREFjnCQ?=
 =?us-ascii?Q?5Afl3SeSIUZfVfbxZuHBauX+sIpngwTYwqR5HTtq79zJUW1CQRTn1igfjohz?=
 =?us-ascii?Q?4OfHYgdlpZJY2FXEmLSeFjc03R0yB8ZW3rXpIKLlUm+A1aNaK4BsUdHZx96E?=
 =?us-ascii?Q?oWzfHQMztJIL4RU8FBRNTfcED3RRBLac+/vwCOVHGIX9qwXawVxiLOu4h+/C?=
 =?us-ascii?Q?rc29ZxdCZ3vggjDvOXxLjic5GLeFB6l9iSvYwhRjeCnXEtLtgNWX0j0aXuIx?=
 =?us-ascii?Q?7K9FyMWFObgiNk8fA0cEHVXzjMzFgteG+YwHidSFGzZ0XXyIpW21LF8ffO0i?=
 =?us-ascii?Q?og2ifJaZCfnp+8+BIEhNhFVD8rgH5dj4XENzhzURj3tnW8XJr/UpctJ+auR1?=
 =?us-ascii?Q?yeEIunJ4Gru+0KWEGAs6UmCa+RfVH2eBq4MPywUCwOXcZlW/e64lDXGR4Ewh?=
 =?us-ascii?Q?rZW36YDgl/jBQAG7468GzsxBO0puJrCB569FAFno3P3V6oBlUNWkrvrzibzx?=
 =?us-ascii?Q?4sKqnT0H7JbimBZEDOgXmvS8LcmruiVOBUpfIXbKDOxHD8M9fOmx1uv9WUz6?=
 =?us-ascii?Q?nIjvW5nlXWp+E2C3xsfnjaUjQVubVuUeCUou23MU1PWTdbbzYTjQzntfQPdI?=
 =?us-ascii?Q?1xiJpJThY9+zZqb+gVufYFT4N2c/baQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd226bb-4493-4827-136c-08da33484fb5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:18:09.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KFebqV9SJhXUVuu7MDXf7xPfg1Nhf7GVA4wErDo2Ij3dOL9qyawZeoyW7oGDG7ZAf5zcEOnW5IVReccJ0cKvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5716

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/test=
ing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..ea006a895cf1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,54 @@
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
+		    bool reinject, struct mptcp_sched_data *data)
+{
+	struct sock *ssk =3D data->contexts[0]->tcp_sock;
+	int i;
+
+	if (reinject) {
+		data->sock =3D ssk;
+		data->call_again =3D 0;
+		return;
+	}
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX && i < data->subflows; i++) {
+		if (!msk->last_snd)
+			break;
+
+		if (data->contexts[i]->tcp_sock =3D=3D msk->last_snd) {
+			if (i + 1 =3D=3D MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
+				break;
+
+			ssk =3D data->contexts[i + 1]->tcp_sock;
+			break;
+		}
+	}
+
+	data->sock =3D ssk;
+	data->call_again =3D i + 1 =3D=3D data->subflows ? 0 : 1;
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

