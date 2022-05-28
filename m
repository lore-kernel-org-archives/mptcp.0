Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DA428E4
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653750782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HihncijsMr9F56VMqTWllyGtHgPR+1fx3CywO0MoFj4=;
	b=ZselhBwTJHqzcEgwz4xAJCZhUoSV5Ort03sTEx0c1AgWPBgg62ljJzzvaMRyrih0SfCMkz
	QBbh8TKKlYAVDxgGbXZZOtgnjFKYVZcoNlbFUp5sKektJoJ9UClce9SltupLCOXmMhZec5
	5R/vB/LVS8xFofRp5HWTebb3aetls50=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2051.outbound.protection.outlook.com [104.47.1.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-M6Mgdg7MPASqaGLiuq3U3w-1; Sat, 28 May 2022 17:13:01 +0200
X-MC-Unique: M6Mgdg7MPASqaGLiuq3U3w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lscOxl/G46pwXGrm/aLrmhJbCGHjZN89iuH8NDvM9c6KDG33h0fI0+qMnTX1pEwpH6MNHJClWkeWCFKcID+VbfQ4UYKGSIBLfF1EylhEfHyiLLpb1d7km+1CgFyEqpfT4w1tgLX6GJXCVo262j2nZ9pUYWQM74vsgnHfjj+7cMrPA3wodjJYc0iw6IJOjRtqQFliE5pL1tIC2hpYxOMeGqs6FRYfcjW2kld/8diokPLSgMet6vwmZwcrFHJlM/jipOp6E2hHW+2nDoPys695KPMLeqMS6cIEF71pOGERnebgGpRjoHWXll8ZfevaRdXs8Q9NornT+87HTbxapwb3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7QXPaJ/SCPIU9O4c2r+Hp7e4B/pm/qUG7fV9XEs+ho=;
 b=dtXfXDTn08nCi57wIZf2EAqrZf+OJMC8YIhsekuvmAKGoZRaridZNuBC6Y2Tg456dbq6AD1hi28zwLIn/G7dUCl9SCG1ZcOjCRw+2vkDU9ZQGvfCCOpWYhsnj/IrUoeYlchRtHteZ9k3fm+wfO/Gn4xBdfeHTVPWOQBqEEZmAgs/Gyp3WthApTFt7l4OzUmQEHvKiYXaG2xc5/GEpf0nIBgJzpMV3IHHX4F0IHJabIc2zlfytShu5ggtoIzRb5Kz0Z+ZJzikP13O7YA/d9I2FlaEtNIKttnQGgl7+qYk1J9YATLCVs8YVm4Xg0pqrC9A2WYAk3RN/eakZH5NWgJmlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sat, 28 May
 2022 15:13:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.017; Sat, 28 May 2022
 15:13:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 09/10] selftests/bpf: add bpf_rr scheduler
Date: Sat, 28 May 2022 23:11:51 +0800
Message-ID: <6553a705379b387136bef0ee827a85f0a381b7d1.1653750351.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653750351.git.geliang.tang@suse.com>
References: <cover.1653750351.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 752f6bd6-b6b2-4b94-e52a-08da40bc8da0
X-MS-TrafficTypeDiagnostic: AM9PR04MB8485:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB848534BC8EB98BCF6DAC7AA9F8DB9@AM9PR04MB8485.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EAJ9PMAj5vpaBlQw357sl/hEf6CouRizdloSiZIJWfwuLXRPctq8NLQpsWMnL3trqgcZ+7dAhhRPxzpsXF6/GhC35NMjiCKs7COLa4r78iYiRQcUdNkUr/jYZzDfELeVI2NuzVkPhvVsuV67yOETfjULxYPQMk6247kvCO0AuziONvOupngpZSsUoOnUq6bGvCXDu3J6nJ0AHohy3NugiazfBtaRxbFCI4omHdPG1N76kpaHLebXyp3BXTDC1wZQ433qrZSPwYu81YriE5DDXyHLS2Z+1SfA4JZf7edHcUHCQh6PN9TMXQrtzDPiLdnMswyiyeWBevOz+3gQg1eI9Zbe23C2E8sX6RaQuMt3dNUX0MWnbWc503kc/4D8iFbgE9+gpZ5a0IABP36T2yyr/i8knKlx12nnQPBsqpxLerI7kOVQq0lHkEuXh7qPNSj7lv2shU+csPaoIaX/77rpYrmJfjUnhpAzcWPdTZgsCmMeGc336f4+FzFonKNoGkx+G6RRVbQjGIy9wlpFm2FQGla+msVL20swP4uGTcCfasYDMj8capluFU4NAfqd9ecmp1Q3olJ8QrMH27Ih3ZwWcKWsyHr3IY6Z5zO3u43JqgNWTCfPjcoW4nTS4dtgJX1CPZVUxEZUNiJ6DJ5wyRe7nA07ZLBVgnKeIkX2yvPinMGFVvm3lLCAaKVIX8iuXHnxBy+Othz0nheUHJ5rYejTJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(66476007)(38100700002)(4326008)(66556008)(8676002)(86362001)(186003)(107886003)(2616005)(66946007)(6486002)(5660300002)(2906002)(6916009)(44832011)(6512007)(316002)(8936002)(6506007)(6666004)(26005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qE2bzkrolnDW+J0lnFciqT85LM1hGI4xf1z7p+vhxeHy1xwMU5Pxp9O8ZYd2?=
 =?us-ascii?Q?BK4ykU2c2vM/wbjxdJwMfgC0kFmmds7lv/cCm5uwbEzW+j8FS5NAmCLP0juN?=
 =?us-ascii?Q?F+9INtcke8rYAM6akOvQPy5WtpxZU3x8VbUAVpH1h5DGXNohXA95RZBV5u1l?=
 =?us-ascii?Q?7lnOHtmFESC8ujUV9VW+4M1byKvfib2jkCq1GKV+lgHXaAiiqRPMxPw5IZvc?=
 =?us-ascii?Q?CVrIfhsZb4r7SLXnDX5MnL4/hwCmId6dtX6Lg+OqJgl8F4iHOizjZjVxboUF?=
 =?us-ascii?Q?t5Cw2rwYSTQWjGg2DPkCzuOLUrhwlX2dwVKDIQpNOayf7IDKxWky16IJ51t7?=
 =?us-ascii?Q?J7Q6Co5EJRzkXQFcXurQ1f1dk3z+zPqyxyg1JwB//n2PNFpPgEn3qOQPk1Cv?=
 =?us-ascii?Q?imubGZTMcCR3HUxoprzSiLkPs/2J9IUjHhNW9sMuneYPPNa7I6JZe/O2RZ4E?=
 =?us-ascii?Q?JsxMArjoipThhtz38g8MPCbRM13y+b/6SzZgOds/7omiyykIMJvZXUd+hMRq?=
 =?us-ascii?Q?h4uXhxPwqOUu+NFodmwhCHvLpoDCZTZbn+evPOUBzkfqRkYQjBNSll6nPrnH?=
 =?us-ascii?Q?hQ9TZWv1lHlEGhsh14NcYLHQPK9gphvrt/j74GvFNN9gBzczOsOHfn6vNWNA?=
 =?us-ascii?Q?91LxpK1jkIse8PlKjIRj1dvvTU8Gw8+dUn8XqhpBuxJTQkAsxeBsQX7CWxNf?=
 =?us-ascii?Q?Xy/siETeKpCClGh5NG1tv7shwzUpTggMnelI9vUGmaF6cGtAB7W61ZXgamV0?=
 =?us-ascii?Q?rAkMQESMPxL//T7oTnQlr6Umpd4Q8fGLewvGrPzqJ5nBM5AMmA2nuQ0MBZaF?=
 =?us-ascii?Q?XXKbey+aG2zH/43XQ4HDsBoYg6oohx+yZjdvjPbHAFTXItw4UXXUxq18Ix8k?=
 =?us-ascii?Q?rOV/kfY2Titjr9EwbXxL9xtBLFDuMhHyHnRF/LDMIuwWUB64m5STsUw0feEN?=
 =?us-ascii?Q?LwMixCgWcnWsIhjZ+tzXgyr8KSrNIxrutdhOMsTdV0EFNMxe0mw8eG90N8k2?=
 =?us-ascii?Q?Igy4PB60ZsKEx7S5tdTXKgH7zXBUXgdPrmKEWXuMzyoDA8m4JgwDSBGdnqOm?=
 =?us-ascii?Q?ljiVGqEfDYg6wAv85gEZu/CmgeDIv5Z9c3dHbW7AlkNeoJR1Fw8XqTvxY5+R?=
 =?us-ascii?Q?E/Cfd+A3JEDpjOmASt9/PXsaFeDEQP6zNOxu+lQXfxqsYmQ5AGj5PkDPgvs7?=
 =?us-ascii?Q?0fF1d60IdAZLcK9dkh2IkD9xkWFztZ2X5RtsvR3ZyENCifr3xGMh/9DPWOXB?=
 =?us-ascii?Q?+32KofJm2Pv8VX626CM26s2k0kxhPzulKhFm82qBDEsP0cR9ztLPEvzx1RUR?=
 =?us-ascii?Q?lSvh1YWirHN5rXrJ2eOLuq+aCQPbnuh7VcZm0K0UuyHmEgWQcQnLXtRwgBWV?=
 =?us-ascii?Q?M9+TwDslq8RcDjMWG5QElHX7Bqrd0fiKJ+lMzQnqvODIOVJr7eVSY7EQ9bbn?=
 =?us-ascii?Q?BE6epGb0hzJT2rkCtKpoa+tpsBo1waZ2Uk/EJ06nC+Ml773IoqTf3kwflqVV?=
 =?us-ascii?Q?oY1ParFOb+yBskmu4faz5TeTjH+IW1dN/XQ18aAFVyLyVtXJ+7ffwrb5QYx7?=
 =?us-ascii?Q?rpfaWxx8aPnzP4QkUdM6a724mAO10ydy3xQgpa3leG0M9vV2URSSaYJnYh1c?=
 =?us-ascii?Q?kjBI2zvsNIGnc0kZo5qnoW0mJ+4uadPiGggie2CzQQVLTJGAQCuONqpQ0Eeo?=
 =?us-ascii?Q?jiPi0SQ9ywpb+7Ntz7RCqrUKrHLD2Pm4zg5xAlEbcjmAW2+7C/NNSozlyv+j?=
 =?us-ascii?Q?oIurD0k7OOSWk2z8JhzP61qj7sz/3aI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752f6bd6-b6b2-4b94-e52a-08da40bc8da0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 15:13:00.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NzdLcmCURCDlNcubvWCfUrR5JjTipvdCmIHy80lXTCP7+lyVhXKiYYJ9c0OPBT1uVXJkCIFGqo3z6kH9hpNZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

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
index 1b9dd8865ae2..480be2ea7d59 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -237,6 +237,7 @@ struct mptcp_subflow_context {
 	__u32	token;
 	__u32	padding : 12,
 		backup : 1;
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
=20
 struct mptcp_sched_subflow {
@@ -263,6 +264,7 @@ struct mptcp_sched_ops {
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
index 000000000000..de0d893e08b4
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
+		if (!msk->last_snd || !data->subflows[i].context)
+			break;
+
+		if (data->subflows[i].context->tcp_sock =3D=3D msk->last_snd) {
+			if (i + 1 =3D=3D MPTCP_SUBFLOWS_MAX || !data->subflows[i + 1].context)
+				break;
+
+			nr =3D i + 1;
+			break;
+		}
+	}
+
+	data->subflows[nr].is_scheduled =3D 1;
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

