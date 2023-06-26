Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A887FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oev6/W6c9hySFA5vrdeQa/1a75YOVzcUJeyH1Synjz8fAx7ivXaoz53/yGz/gFKtGUEuAgjmr76jpNMkmwOYH7re1vLcjKZ0s570h0UxvLoq0xGlhit6szDSz7Gj6bmm0o/tHTvkX69x1Qy9bwLfiLwB80RuCJF9dFaJewDvZARmrV+vtto23IEcazdoUDw6HXRT1VvJrPyeaIm23h96hLOHS2BoQZpU9iWTixBzurCw3UydVVll2JMvi9pOVJW5Xl8GyUsnyTHFE7+JtrV/A9dthUUQt/RJmAmlqWOe/jd2A6EQWq0aWYI6/CgY1AC3vEZCEX5xNvsOBPABlVxNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr9z59N+KLMla6215PGcW4rZQWmSpBgyJjNgqVIEnEQ=;
 b=PiRgtiTp/y6yDctotGGUwaUYgwfU2PYJbjaZRIaK+bLWu5p0dKSjQIncgIo2nKg+pA0Dll9lYCOKUp9Zkc3CJCprWQjGBJmY55hGcHoXqel3WWyqTITGxg+tb9Dpd0LvMB7MTK3adLTSUjkYSxkd3gXUhTW/ddgWlQTUtC+Djn8nlBwKdvXnTx9olI2ARuiolLVfDiEYjB5cON+a8MWoEurRTTas53/0QQ+Ez0JX+EFRGY+uEyZraXAREkrDwCKp2c70kTIvijlwXqQvYngwdqEcqRVfEAIFLyhL7WmMf+A50T/OxWW75XhBYkh+iuYAPO75iLWoYSdGvBKO+S6xnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr9z59N+KLMla6215PGcW4rZQWmSpBgyJjNgqVIEnEQ=;
 b=nG8V38JLiUCBMDvp+X12GYOcAZvsukKtW/AaBymX3OShsz/odNqSt1jomy7zdP4Yfjoy6hUeUyYO4HREZIEZJsIueGeRHzxlOSbZovS5Lz5BgS2pP0XrfX1LWCRhLAK0OPiNROQjmbu9tPokTzEyHpf/FqQBEX9DW95dquB9dRzDjKiO9ib0NEVUrGRbN6PFWPFxEqUyr7OGQQXnj/0eJVzsoWi2bUqmkcSuFM1zNCyMwxMEkeCR4H0SkHyTCBpZEf++Wp4o0W279Cz2bbZLssrP+b6Ib1OWa8PlLhMS5BDHEsYrBjOBDecDwBbAj+3HrlBCJGiQt+psTshdBC5aBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:24:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:24:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 11/13] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Mon, 26 Jun 2023 10:23:12 +0800
Message-Id: <6fc63365893a9d9a06a35a28c0475a4438be6736.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: ad28da01-bde2-42be-7a79-08db75ec7653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yMsIzl5YsVlxdIHVEGEH6PRCBzxV3ndbnPfhr/sPdAmBQLQJtAl2fYUiApLpDByxahJOR+UiyupdLMT25g1xyfoG20oxVq4y7nHMAmfqYooBUE1gtYl8ROgw0zSmt9YDgcIP7m8f4aaX2Ay958PiSMlWlFfU1cM+pO+c45q88b44ssUpLpsNB7ryVF6fVjE1RyCM2Cpu2vUGmsgIWy+CMAOg6NwgJb+py1IEdZcGNWBwJ2Z5samz08cGaMZEvymTBH756l48svs7c/LeDH/+Xbco/qiAH3zQNzZxJqXbDIQKNvAu3CfBh03whI9IK/M/YzF250CGCvFwDpnG1DMe/C6R1NsQCqXQrNMjn6ufEzKos5a++KckW0NcrjWsKG909mjBAVbCPKCZluWfYacAfC07/XAbThl1CeaiwTYAlHmbgQkk5i+ztOhs6nn6wfNDnFTHxccTyEfgdPma/j9GCg9PIPlCkH2hoO5gehq06EyThk3PoJMMtYqZ6voMmA7hv1X9/x/yCXHu08OO0FDzaBIY7zVMvcZ1FvV2IiEr2s6/otRk5cOZ5EhxOusJibbo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6666004)(6486002)(478600001)(83380400001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NF6a1MW9U55lkNSodbQWkgzorfUHM7xCV5uzlc0GgHZ5hJBXIkKlXK89zs9J?=
 =?us-ascii?Q?R7taSpa7UntFfuzDlwiR/6DAaaLZe8uBUB78hwwNw4cfQJkv1Y4yZ3DfvitK?=
 =?us-ascii?Q?aleoi6JePa7lTBXqaMtQtY1rsMg6UIXFwy80c0MdMOa4U0IST/BGS0Ny+vPS?=
 =?us-ascii?Q?h6MxkA3zaggFq6G1re7TGLyuTEXvMkzL5UsZxDWrgigB4kmsNVStMD4afrIc?=
 =?us-ascii?Q?V9LI3RFHbeSwbVPJ6+ONiKUPRw/QDmWxNpWnCnDlyBb1Js385fVpQPxhvLyZ?=
 =?us-ascii?Q?vu8mVX3S7//1r0VeHQXqg+Pqj+l0JSEXafUDD31XT7I+DxkpWd0yj3DE9Or+?=
 =?us-ascii?Q?VmQpupliYdpodGjfTrtw1b9oDRg5RrEvJDwTf9jb8s0fSKiseMxzPNdpIMr1?=
 =?us-ascii?Q?hBxl93pZ/JIdi7w+KLtp4z1VZgQgKNR+7va7lyC9AqqkUASsoo000f/qXh1C?=
 =?us-ascii?Q?1Xd9JDnnt1k0uuI34yAZ08FFKACfy0zSD0LC9AYS5BinSkksFEkC2NXjUaMA?=
 =?us-ascii?Q?/+a8c48GRXUIcRNOV5g7o/6CEpvNlSmO884NjZhAilF6m+3IwkhYdpvYiJT5?=
 =?us-ascii?Q?b9yf5l/udGB0FL8GFmFE3XLUsYCFCU9Z0SzceKAaWsT9w19V5qzCk0pcxIfy?=
 =?us-ascii?Q?ni7UeVfFqhmVFitIt/u7AfbWmiGUgSKEpS+3bT9pVOLz8gotfHjCI1dMBZcg?=
 =?us-ascii?Q?1vGko9THw8iE0zQSyi1nUoiEmG3MM4rMXJSsoaVzQd4SkKQ8tcJnQprwb443?=
 =?us-ascii?Q?e0sz90fyC9WrvbTTt2aV/36/Us0EO0T6+fczJa56HenPuVr4Gd++IM7BcWnF?=
 =?us-ascii?Q?plj7Jw/i2K72xz+X8Suqaiw65wDYDWQ9+SvGLHbeBJ/6zNKJnBRP5KEPWBe3?=
 =?us-ascii?Q?4ATTpG86Jnev+pBKL8EnEPxqr2WTi60HzvKS8s7B1b5ozuIkutyHg87GD4Ha?=
 =?us-ascii?Q?JwgIgxquKgvC0op4UWQsSD7Jz5mYPuuANOwAHZdAYq8X7wHmn1s+0UMAwsjV?=
 =?us-ascii?Q?Sg8HJI30gs4ge+7xGmGCm0tX5acjTMQdcEM3x4D+WIqorguvA3/nhY8NsXIP?=
 =?us-ascii?Q?7gfung503CWHw48hzDAKSeDTLkwW2YhOf8JTk36nrKnHT/cCZIYiDNLGXVUr?=
 =?us-ascii?Q?3gU/7W9+6jSR73Hz3G2yzARuD0nPqu2Dx3ObrP88suKJo6wY2h6b94OaUO0s?=
 =?us-ascii?Q?l8BI0qwDFlvC4834Q87iW5MS038SBk7S1F+BoYFAYb8yf5oGflV0dMViSkTd?=
 =?us-ascii?Q?XAJnuLvwClXqDnVbw0T6QAe/hRoxnd8H9+yI7bHLaSZDmk/hBVHO9nM3b9dP?=
 =?us-ascii?Q?ontGPDKtdzKAyX8EwsA4cUSHLZ32LjejV+ZMWNbyRS58PWR52aYSSrFBZm9u?=
 =?us-ascii?Q?HAd6SndGghjolyyObgggeL+bkq3YJcYKVB+Qi84aWqXPq9RVfzBusA6jbg7W?=
 =?us-ascii?Q?8pwio1qJJNsT4RVO2PIekxXJSnt+jXbzDKl9uOd34jsuakvtfNcQclylAxNL?=
 =?us-ascii?Q?gLuOMv6UldLQ3wCqpC2nfyu4UmCj+QeoVrI/4rjHS/mcgu33VhdJJvHClxYY?=
 =?us-ascii?Q?15mJVLQdsiDQkpw7ZV0kAvEWcBVktTNbwfky2kVX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad28da01-bde2-42be-7a79-08db75ec7653
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:24:26.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LQxRK7DKo718jfckzAiH7z0SmmntWFqvOxCbQiYmKR6XYnnBb1Yc9l73nbji404QchBhVoe37z3WPkRjqkvLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

Update API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_bkup.c        | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index b2724426676e..2ff69f8d66ed 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -16,28 +16,31 @@ void BPF_PROG(mptcp_sched_bkup_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_bkup_data_init, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_bkup_data_init, struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
 {
 	mptcp_sched_data_set_contexts(msk, data);
 }
 
-int BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
-		   struct mptcp_sched_data *data)
+int BPF_STRUCT_OPS(bpf_bkup_get_subflow, struct mptcp_sock *msk,
+		   const struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		if (!subflow)
 			break;
 
-		if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], backup)) {
+		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup)) {
 			nr = i;
 			break;
 		}
 	}
 
-	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
 	return 0;
 }
 
-- 
2.35.3

