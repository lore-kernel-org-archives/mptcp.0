Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CAF199BC
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="nd7Cr8pt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+Kt2Jz0OyWW+pHvFjukGu8jygadI5k3rDSXfUAil6xyKOn0nLJOsBAKkFjF7VOdqDUHPF4Us3WyhHLd6UbVqjZb4vm4CWxBgHNIytWjL5rv2kGk9AJHiik/ZsJ2bFj18ikTzJTPcffLNQ5J4elcKoTTOrAWxSuf5LaMggSYEIBl1xyszmXLvAVqZow02oV+o4RmIFsWfbOgBuJn7QEivOUawp94AUa7XKMjhPsZgqv4lfiF20Ujpn0vxw2XXSD6wLs42Bk06k6rWPySPhcWUHIAK8sTgxXCEqr7O6sFjp/gUcFGXysyb2qJx+ENAMoXPkvf5PkgjfkDnjj5t/12cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fip0DlukTFJI3TIzfqqyr/9W2ee62LqBD7iRvG88oi8=;
 b=Oa3P06vu0AMLFT3vLtVbKTNKeiPGjLJ11WYxxF7YkXDqn+JhOCKXGGZC/OMjsPCLtkWkZYK4h4BsuKvHGH36dBiAsL4eLqicXywNCRvW4yfKMxo7sO6Usm8fTeyKJ7wqfps2CJZzqmCB/WeEHra1J0Q1qtOXt4SgE2Xo7EnpVTWgezivXwv43VnIVPvskypJQhna11FkML6eMraymHusK8Yj5Q/GEFSwsOISnv7j0e7xcqxBcg2VUEulU/ema72eBN95nDwWbwHqvcIcCD2znzHGMkAbWuTAuIW5UUpx1BIf6SqLwzykQK3uWuALbMjqCk88e3hYujP2aT7sJxu/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fip0DlukTFJI3TIzfqqyr/9W2ee62LqBD7iRvG88oi8=;
 b=nd7Cr8ptRDAtsSN8X3yEtb9atSkfVMz4G6Y6CF/PvlN+Av/mRw7vuCHZPl4gg19HDYnJFJPuEExc7tHE+Fo6JFDKjTKY7VfFdVlp+TVkND+Wlx6gegk+tI1/1IPSTf8DY+O7AXuqLJu6LtiuNS1qZVEVw/y9bHQNaX14KpzA++44pbv92PwwimRTROfe2YxRl0pvTwqzXrtOKiGPNHiqANtfFM8CYPqCVSrGF98m9vl/a+YzNkD+CM/eRnXF6b1zzOdYoM6zvPIjBzk14GUECpF45H8tAZS+tAJun02iWbd0m1nTksMkeb+f/8rL1bL1lKCGToYOrrkSQ/nqusKiFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:12:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:12:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 05/13] selftests: mptcp: add mptcp_lib_echo_* helpers
Date: Wed,  8 Nov 2023 22:11:46 +0800
Message-Id: <76626d6fe9f7c5c8f6ef412e4d0d96449b8d5421.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 61be9123-93ff-4e48-8966-08dbe064be69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vn+9wMhFRk3pWwENtbUBvNQxGfNpA1BsNqF/TpLEjQ7TJtbcOeunYXe8scVh+MZtPlHAEqrLVGvmQN31OgMQ5KaMIUntMAGjRk8LhkzSPayqntTlqQsAZZH35+KgrWGK9d2azufdUYlGmH+hWYP2akCKudlm/MHJ8BuNizicAH3dBljZs+pk8fVEI0o0K9Ud5dCQNVXtC4S9Ie0oO5oeXIN5zOjCegEwvGCEr9H/YWK1kkHOW3HFxNy3coc1DbZ1ylwgw10LXvU8TaDRzUkx9t4l9KY15gakV9bn5vYw4DpWkG9+xiq0oBoD7/9tBsL2X9aQx9m6xTQWWV5N6WuRoyHF3LLYJ9EcdkdTWOVyWWek4laK5YnlvvvUUrGfn+MDf753fHi4KYyzn//SxS04Ve92iJu+/NEasinoUpmSSldIoNcqVR/UN7I1W3F+l54rTQaC4Qk9J2QkI5vr2eSiLUe5hlEnMaekqtNKDk91c4T84DW+5WIcCjt2f9dJxV0yxXF6naceGk9/xxgMDSGPVPUUkJ97DMBvDkAx9f7CfE6COKWMzHOxEIcqiUZARPHm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(107886003)(6666004)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MtLUuE+8oyOs4j7DsczgrltYs8Ju6MnOPmJhhJbrtcXsCrNgj04WELMYyzoM?=
 =?us-ascii?Q?pMG30Y7Qa7R4tbfUEDtwSEIJJQi75emJywAHs9NN+xWfJBTFN/qRQZZRIZIW?=
 =?us-ascii?Q?/JVvmga7A15rla1j9FbQpKzVcw2fgb1YGeZ+xnjijZU5ucwXRdlgQn67yz3k?=
 =?us-ascii?Q?EyX2j3pcb99DI4O9uH66HZSenKWTcXBMnjja1O79AzlqHrtN8M8N/T7omi8r?=
 =?us-ascii?Q?85qlSuBAIarkGsGpYwVOjOxY54ffkgndHslZZMsbhPzEsTOFZflpv512My6k?=
 =?us-ascii?Q?omIL/6LtUSTg/uMEkykAs2zCjA5qe49YFPS3qtoSEftYYVy2NviciB3kZY7l?=
 =?us-ascii?Q?OZtyo09PM4aThwrQFI6iX5tvcfQEHhxvrNRa5ORrXPn6GjfU2d+Ilq2MZrId?=
 =?us-ascii?Q?f9rZ8TtBynttJRSUBkockOM2vX131ZOwYSDh1hYIGI8QAduylhOBfAG56s4C?=
 =?us-ascii?Q?3C9T/EZKC8SJhqdp8LjI3Qktzfjmr5xceaDApDql3Y4s17an0mZrbepYdbTL?=
 =?us-ascii?Q?KKUwrF3H71x+OKU1zUPqCM2z/a2AX4zAISHWMXYzssVGP4W13G4lXF1DrR9b?=
 =?us-ascii?Q?f4p0kQgqAEJXtg8lkG21NiufBnRUKKtMNdNk9ebxD50CjfF7OxYcOM6aAnmc?=
 =?us-ascii?Q?gTqGGfuXk26SZNn9flkXVRMsnRz6cSmYw0I9Ws/zApxtTDGGZQUq8C5EnFoC?=
 =?us-ascii?Q?s/RcOMDBpAiuRpON1oeXbPB8kE1LRajZ6woUuqoODxL7sYx2VV/U5L8+ttoJ?=
 =?us-ascii?Q?Xe8g/gWs/eJmRNb2fdWDmwXLAoFtE+TgfdUwIHDHxNYjxvqEFHD6vtbhDIN9?=
 =?us-ascii?Q?PuEavdmWKHhJGMiHNBR/BaDuWhF0ElrKM8Tnw/l0ISeoCVxHebjgG13AZEao?=
 =?us-ascii?Q?qLtceEPYZ49rbuBZxUgrn/X0U+vkDQoX8F1uP/KLrr4qm9H85s+4wIL7Al6C?=
 =?us-ascii?Q?iua/o6kcEI8GFMRhLvd3NWcuiPzsXvsiEMv/nvvB4Lfv1u/p7Jd+Q6GNJNhu?=
 =?us-ascii?Q?7/A4KPjxPrS4uvkxedov2ynFUUL2fN2J/3PWon2Ko0+UkGlFGiveNlEC7CsH?=
 =?us-ascii?Q?uJIVwTc3cyI6mRZDMULTmLkh/CJdVOKfjmYh8D8Wc8RVc8w/atSkhIE5KRIG?=
 =?us-ascii?Q?RtfKp0JSCYOv1Lvwo9xWCflUXKFFN4vxdnQCJJhgxejy7K9HdC5UQ4ZYKY5+?=
 =?us-ascii?Q?VRTd5nCMXMWS9RE+ZDLR+hZjVqPikJdm5xGd/weWzeR08bxx+a81Uwqo4iIp?=
 =?us-ascii?Q?TgZwkZdGKNMz7ZWI1ni3hDElxrdkDr4MseBxUMFLZwBdWoI+jN+7VE/6fVIz?=
 =?us-ascii?Q?uC1vOyvbD3DuZ4xHrarMvpxtrOzq9tMiakXqHVxJc9lBW1u8XPFVosuF/rbo?=
 =?us-ascii?Q?+kQfixSIkmAOkPrP1v4oUVE5RsSVJth3I3C7s1ZEzZEWHkjEH2i/+n0fbUVu?=
 =?us-ascii?Q?SzKAGzJ/IAyfJfGvFTh8fipAaVu+rPPaQOai3CzJq++kdLeXEtvHfMOwPZsh?=
 =?us-ascii?Q?4+ZtQN4ooMkUWiyWndzWNedWJoXs4xTLE5XYbPTanIB0VS1LUq3XuIpXo2OI?=
 =?us-ascii?Q?1gHNYfiN+Has7D5Wn0soAfJFPYvjWXkXNA9KyOl8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61be9123-93ff-4e48-8966-08dbe064be69
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:12:29.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IOJ5jde2BEPRcYe60DxCMYQ3C1QP4NuOVs3SZvQ/0zdsQHoh+GjPXbFEzIqqYSoEznasnRcmqKV+2VvkTIItw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

The helpers mptcp_lib_print_* print the text with a newline, but
sometimes this EOL dosen't needed. So this patch adds another set
of helpers mptcp_lib_echo_*, do not output the trailing newline.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ffd78187237b..7a68791c5773 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -33,25 +33,43 @@ else
 	readonly MPTCP_LIB_COLOR_RESET=
 fi
 
+# mptcp_lib_echo_*: do not output the trailing newline
 # $1: color, $2: text
-mptcp_lib_print_color() {
-	echo -e "${MPTCP_LIB_START_PRINT:-}${*}${MPTCP_LIB_COLOR_RESET}"
+mptcp_lib_echo_color() {
+	echo -n -e "${MPTCP_LIB_START_PRINT:-}${*}${MPTCP_LIB_COLOR_RESET}"
 }
 
+mptcp_lib_echo_ok() {
+	mptcp_lib_echo_color "${MPTCP_LIB_COLOR_GREEN}${*}"
+}
+
+mptcp_lib_echo_warn() {
+	mptcp_lib_echo_color "${MPTCP_LIB_COLOR_YELLOW}${*}"
+}
+
+mptcp_lib_echo_info() {
+	mptcp_lib_echo_color "${MPTCP_LIB_COLOR_BLUE}${*}"
+}
+
+mptcp_lib_echo_err() {
+	mptcp_lib_echo_color "${MPTCP_LIB_COLOR_RED}${*}"
+}
+
+# mptcp_lib_print_*: output with EOL
 mptcp_lib_print_ok() {
-	mptcp_lib_print_color "${MPTCP_LIB_COLOR_GREEN}${*}"
+	mptcp_lib_echo_ok "${*}\n"
 }
 
 mptcp_lib_print_warn() {
-	mptcp_lib_print_color "${MPTCP_LIB_COLOR_YELLOW}${*}"
+	mptcp_lib_echo_warn "${*}\n"
 }
 
 mptcp_lib_print_info() {
-	mptcp_lib_print_color "${MPTCP_LIB_COLOR_BLUE}${*}"
+	mptcp_lib_echo_info "${*}\n"
 }
 
 mptcp_lib_print_err() {
-	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
+	mptcp_lib_echo_err "${*}\n"
 }
 
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
-- 
2.35.3

