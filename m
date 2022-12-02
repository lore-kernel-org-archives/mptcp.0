Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2070.outbound.protection.outlook.com [40.107.15.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB48259C
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 13:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcszNjvKta2fkOPttfHk8wd9ZCQiaNn2LvT7NGrKGCYsKNoi5b/tvhTvsimQrA/twKAhYQkQHuzAluOeQECcEAXFPdh4oaRW0dtglBNbRT6NCD1TwVACIWTimSWwpWF2reG5WSUo0lUQz9q/JE92N4t9blrtSQIt7GFUIM4BtnX+G37nSQ0DVg4Sw/F4CxHuK3OJd/AlQYpUhPYqfP0fxlRP1ktuALMzMn5KnP95ISW/ag6l24DTan+9qWhXCdE4uNadakJARBSXjhB+HV/dsCJugJTwht6NILuAhpcTDEn8yoA/xg6aALjITxQq4rU20yhuWHNbKSJ5V2VQvDC7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=eL4sVnh0j6Ll2J43B+8BCGPnqKN6PRWmGgN+ZX1EeW4/nbkW4xdxRZkyJ6fZYnVYeW0KE1TfSnOVOO50zG9l9zKQAieUInaA02hS5LPrfGiDBQywP59fybrr9SW5DwX6GpxoAh74QdQ3EBsmxucuh5PEay0tCxRm4iLxis5dhVwa8QlvZTxNtwSZHBuaVjtThkyPFMlz9ugo7+CPTqFkdoSBPDJpk7xQ623Ah03Tk2gZEq8NZ+N55/TXhcgyE/+2CSqt/mQ1UV+VcCkKTcQ/InF/GCJuciLSEc/OWYVfF103E+AsqGeYqHJcX1BGCGl6MMblXyHy98FGRfKQl3cl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=Ym3C0kM4yt68T2QQyUTQGSgX0EfIaLM+FUY8CX0TTivwygFxWeoXlCnovQN31Wnsk8NfzLQssged9Z+THpdW9uWmn0iWp7B/XYIXP0t+5Mz92sCeG1kBRAhJGOvE+49624Y76k49ya+KLZnscts1AWrlUnNca2dqeQthgc0IbAzvi38DsiHV4rn+UeYbQXiFEGa8F5b96wwm+YdvfeUHK7xnxHaV9e3IdNv7YtLUjgQO/l8kJvkwybGF9WPrOIE1z8/zr2ZlhzqmKDVUTY9Zv/+kzHw+thNAsQ6w1O+RlauvKD9Zf6Ya2jzTdSROxKoaZey6IRT/uKC39Xte/m2TPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7509.eurprd04.prod.outlook.com (2603:10a6:20b:23e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 2 Dec
 2022 13:30:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 13:30:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v22 4/5] selftests/bpf: Add bpf_red scheduler
Date: Fri,  2 Dec 2022 21:30:16 +0800
Message-Id: <62299b41d05afb9d7b9f6f5dd41cc1806383313f.1669987293.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669987293.git.geliang.tang@suse.com>
References: <cover.1669987293.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b21d342-a20a-4128-f666-08dad4696f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3GcBruAXxMjWTrkDfVy8agnZPOzaP97slawiqJsC7CoRofJPnc12rpCp0NJnPFa0SEd3LH+2CVt4hmDg5hm4BQUv0pcTr4mxX6Q9fx8/f2PQs5hdd7p1JXnOGYB8+N9rAIwRS4pIIiBnqAks9rMqpu5wWc85JfCxJeI9W9b0GcuFVLDPzoBVWJPf/d2RxuYyAbbNvlRbdaVX49aHv4U1O/ny2bNAz0twgrslJpdpnsoLt5Uo9gtaASzwm+65dc7Hph9nKC9/0vq+kE9Bkk99CLSc98KSJNwOExbMFxuJtSyy53TrwBZERC24VzIbD5dj4poh/kDgUvJstNofzXtAsxAYnlR62/qbC3oAOtyfHFgZT/TNC68Bcgj1qSIfUNVEQBNgGfWzS4K2aVzqWmIm0UIoC6bjLIwvKkSGPuwy4rabpbKVWUFJZWo6O/id5yIx35ep/ZNZlda/oN1YZgh4bTLldXBPUNsb1irxUr7+iF2KbhUCnIgX3D1afONvOrQ3k/OLrOKiUzf/AVDLNA83N2x1Nkx2Cg0ExIKd7weMeZtDqSGdXVyGrtp4f4tgFPWd0rFxJ43ln7Q+JovYsR6JFyidzY0apF10ADSlR/aqnrfPhgY+YHd9ui2n2mdKNHIGwSWXJhp6BgfT5lRKrp5KIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(44832011)(2906002)(36756003)(316002)(6916009)(6486002)(8936002)(478600001)(6666004)(107886003)(66476007)(66946007)(5660300002)(2616005)(4326008)(41300700001)(8676002)(66556008)(6506007)(86362001)(38100700002)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FNc+aYqeu+QaC982L/iHQlJtpWJWMp690Y8BjlE6otfotBhlv3JZlxnx5LRQ?=
 =?us-ascii?Q?TV92EeH8N/1HnxXNL+Ms7s9rKhKkhpnH2dPGoYTw9Z2S4zg1eJvF/9KVIrn5?=
 =?us-ascii?Q?lCVYOdvN88YFY33sPNtVWdK21NjmVoVKvYf6J9ud7FHESOBIPdxTMtvpKUFe?=
 =?us-ascii?Q?YMgXBAkQt81MahosFHqS3uaBQMqPrwOeXIRz/dxXxo3/mL83jex030Hb7Z2J?=
 =?us-ascii?Q?oTotSUfnaYJ7CA8aYkHvp+in3ya3rfAhD5kS8AdnHLxJh+0pYuyTuY/7tnS8?=
 =?us-ascii?Q?mw/JDf1aFvVTyxV/hrWrAe2qwfoYV23xIM7j2E5TZvYNQdJYmHjt9IwcR8eR?=
 =?us-ascii?Q?936E2Rya24ZmSIjmu4MahBLCR2LCmlkAAcoX/m2HLq/3OQn4BlMnXN5my/2Q?=
 =?us-ascii?Q?YrDZfrahQvzt3VvwckftTDIkOR5MlnD0/d42Vhpn+KeY4xiJPg6T2osnKecl?=
 =?us-ascii?Q?70P2ocKgofh90843B7eyIMZ/C+VbjDoPfLtfm9VN8qwxXqhZjphy669P95pI?=
 =?us-ascii?Q?rJo3rYtVTczuyv37puIrL298G5q75hCL2nmTIxIRp01dZpbcjs89vWttdN2W?=
 =?us-ascii?Q?59J5QySNuJgsfwWVZqq3JD6zCu/OEt5LoebQMhWvnbqQgMfvvRoj67MV93P3?=
 =?us-ascii?Q?/nWp+Riwf3ekYTrYXBQ4MV6Kwq8I6x7hP8yUbFgVN1indmLjQyBLxEfVm04J?=
 =?us-ascii?Q?iLuL5DKyAVI3eeq+VK8ARzxJNrXElR2P0662TmfJt5ED0sq8d/o6+TpiQqG9?=
 =?us-ascii?Q?mp+IgKXEY7eXl6Vtw5PBYjtbknoT/xRI3lOAxxyF/FpBlTOxkskrh9kqoxHh?=
 =?us-ascii?Q?1XX70BMflvFnodKmqt+JFOGnYqjG03rbVRhBeyO/7UFVeF8Te2dq8AdaIiJa?=
 =?us-ascii?Q?lm4HfK9UwtwnigChC0zcfOWcWvTE37OwBhaHMNJoMzDxA6W4MdGYDKF+fGFZ?=
 =?us-ascii?Q?KhCRkgj4s/LxZiIqruZ1barytwC8NmBB83qF41xs2U2W8qmXkvc5OPHUlr5p?=
 =?us-ascii?Q?ORC6kiShJpGtqY+jt364DPnv7i/rM/Wv+KadPstWG0J02zbD2Qs/QNpnhU4h?=
 =?us-ascii?Q?Qt3TLB+gbzqd1V2IrIdTIbq/CfV8saBBjieqBgttDLv19D3+cVGwnDRwhcnO?=
 =?us-ascii?Q?na4OpYx15SpSkC6c0eTTze4phqVVDqH5moqg3YNLUDttODgu0Zx99BoiChnu?=
 =?us-ascii?Q?J2nEEzdRfWBcBHDknO/TqRU8MePx5fMA4i6MVgJc7bpF7AlxYI1ga6YGIAyU?=
 =?us-ascii?Q?pACC2SZplTa4f10XSYqcPuNl+uGR9fT7EPv6uDyrxMUFr3hZB94JXQdOAxp9?=
 =?us-ascii?Q?pC3DvHJ4/fLpb1lcbQ+5EyAQhDs2cCLMoRAt2BeN5kmZQ9w4AO2+aTkou+pS?=
 =?us-ascii?Q?3rEf8E2xXFIbrCcUK2CBW3Drv8+pA4dpPmozThW9r2/XwKf+PGTIXoGpTc75?=
 =?us-ascii?Q?nXDUnbM2Zv01yTLS6quTl0L4nsAiSsbMmDANN4YLFjAW6UcoWpRZGbPWWLA7?=
 =?us-ascii?Q?lixRi+jgN4Wr3QYAp7AzIEHDFf+swsJjYm4Ii05CeussdxCgdUrjD0oW28uT?=
 =?us-ascii?Q?4kEKFzQCpRj6OI/oAzbVbhFjgYLnXkGxilBL9ZQ8NBmX9RnLUgxoyuXxOasB?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b21d342-a20a-4128-f666-08dad4696f16
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 13:30:52.7870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t27pvxOxsaIHZ+cDYbAsujJjZMLHtakTsGUUciFETpKRnNdqIhwRSth3tqm2lBsF3e5ldGQ3UiD7bkLBWx9VjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7509

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..30dd6f521b7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,45 @@
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
+void BPF_STRUCT_OPS(bpf_red_data_init, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+
+	return 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red = {
+	.init		= (void *)mptcp_sched_red_init,
+	.release	= (void *)mptcp_sched_red_release,
+	.data_init	= (void *)bpf_red_data_init,
+	.get_subflow	= (void *)bpf_red_get_subflow,
+	.name		= "bpf_red",
+};
-- 
2.35.3

