Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F48468F
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 15:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRxqkZoFCpPaeooNO3EvLEs78BYMw6tFSBIHWk21piFCzinjweShtW7/8Yqzz4fvPFUwBQ7Aa4AiSGqaDiqkf2kPI3/1n62hOoUG3BhCMqZ3JFh4eDoCWMZNoZcd77uUCNHVVfF/eU9zCxMMgOk/fYouVugY1qPKyDZzRnaSMS7kMZeKsMFnnsSE0GuKRcQYP+m/OzldTEkKPXIVmYogaiGfm3tEK5Ocq2oaS5tpqmQMnbCUj6IAXnNTYoI4FH9VGy0jv1DQaE9+68YxHsWGTAezMUsbFrXVVW9Mj7DNkllG7889+d7cFU83cNcmDlpqqvIoNF8fzfy/WTlHzd2s4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7FwW3+QYUMg2//uT/VcVWVxTW4TBHoOkXwxeQQusrg=;
 b=MMEEBVryabjumXTqyuhdxfEF2yXP3e8cZXYnNzdDtwhKFnyj7lkT8b+odCZxAIp070Szl9RLza68raBljWVAhg5RjzovPn0HJohM6WeCErWfbhyAoontSulqPfjJDCBPJeCAxHLJcbZIp3Enm2wfjzrmLixZiwzT2Fm9TdIRc+g7hbJdFGSCoo2HlnuJPneg0vc4zKPF6Aq82fcmWuy3kL6c3A4Vu77oSEx6KDS05PLKHCxC2YQkb7kYXdi4mQY+4B/JulbVo2qoGmjxzg+6VmkMkmq9EP+f1ojTCIJKcMmSpKb3k+M9rXtjztv3r4bJwSkDARZM29BNjIYdNA1CfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7FwW3+QYUMg2//uT/VcVWVxTW4TBHoOkXwxeQQusrg=;
 b=Mfq2+ctLbtab9LLM/oOr0iM57vJdpPJ2DX4clgQqc1i9RQih57nOvDGH1AqNcbKh31FU588FlyDkInQU43VgYdd80inVOhO8Z42oi2Y/BS/CLo5Um13X5DECxa484w8vCn3AXIxL/2Yp2Vyl5SbjIiFYpojRLw5++Vq9thyuu6A5/XfOXgIb7zUA5MEVk3TXhwYywWRYN/HxDDt4d4X1ufOvTsgXDpxdqi3O8O9l5I86eRxjQbyFTsl9LqbsDFgmp2b3VSZMnf1CFjBNe9tdgsF//k2bZCQpAwKVMN/LGwYbRe7ugiLCMLppNmKn5VtXxvjygWlap4fxEX3dnACUxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 15:02:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 15:02:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 03/10] mptcp: add mptcp_sched_data_set_contexts helper
Date: Fri,  7 Oct 2022 23:02:27 +0800
Message-Id: <e4dfa516f06d56433f877ec862ce255b1462a1d0.1665154582.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665154582.git.geliang.tang@suse.com>
References: <cover.1665154582.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b87783-58cd-4694-bd32-08daa874eb35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rd8lUM6GOlGkQ0nW/g+6zrgjc0eRiu+KzWbvje9rlRdOv40cvy3cZC3JfbRtw6I2rMxz8ROo+nJ+AMdgyrMW7nY6GYZ2vVTI1fLls1CGxrQLHnwI7atmoO2P0qvdE861R/kS7kxFNhYiWVhhAb7zTkAPWOmroxQbRXeH7wlTPYUFBB/4paik7ZYOCNqm0ySOljaxw3rsL0RdqeJo3SgdULH71Y52RhE2fKH6mEhC8ic9fEjqfUT+tRDPmNtPUzHLA8K/gofcJljXaVQAPROtkLHEtXBVpzxPz03LdapqboGiu2Ada+OY4IHCRPb1x9XKj8fqmI+wBYKrxgPELe8y6YK69LaNFcUqIK4MWqyHO5+DrdJQM9XYXC4Kw8+YPXHJxQYghdYv9XIUzsCqVA0mPbImve/n7o72aH9QpvytdnQSvq/I//IQNvV74AF4ktURZddKSJbDCnFelGklQM8/kbffPpMng9nwRMoJUQahnQDRMyWm91HuB96VjVG+7ovwkudjXPSHymY+a73SUfRd3qI9L5JVRHB9IrOTM8nSY2j2frBq5f9RX5RyMp53Bq/4X8gUjMaYxvKcgxj3BQHv6eWkC9W8S6KOGAzqz/gYOab3ySklGEFSg5vNEau+Ny2/0nD6YJWdx1DQBxnh7z3qfiZ4GLz2B0+59AkWE+utut1dsARxQv+9yA7aLwz4/GOe4Lk9K6g6tpi5RqA4itKoahpKE26jNxuBFtaKFKSp7uc66Pp7foe0V7d/SVq0/IS4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(5660300002)(41300700001)(8936002)(6506007)(26005)(6512007)(36756003)(83380400001)(2906002)(44832011)(2616005)(186003)(38100700002)(478600001)(6486002)(6916009)(6666004)(8676002)(86362001)(107886003)(4326008)(66556008)(66476007)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kkYl4l/c5RoCrPw8/65YaP1fqqbhmPOMZUfJX7qlwIK0dszFII/VfC1wU+97?=
 =?us-ascii?Q?t6/sp3F0XPcvaJYVTbcv+W0V4WDgKv4G4jJPfJA1qN8NA/5QNr9L3k5yV5jA?=
 =?us-ascii?Q?BL2TW9C209F23I8LXE9JzkUNNJn/5L2jDtaovPszAfMw3mxZk/WPGSFUrM6R?=
 =?us-ascii?Q?eidApCmJXFwnP+sbQY/8JPMrxEg7uiSJjZNG6IYJMFYcongS1fb6CEiPqVQI?=
 =?us-ascii?Q?kNxGOAMT87+8JnL9tEaQgfrCLA/XxoAnG9/Ad+91o7uEl+CpeF74Wcbxhd7N?=
 =?us-ascii?Q?EutsOOTunkdhZOgV6/G3VxMfFoRJ+ZAGEr4WPkrS5auLlgz/0du8Wc/m8V0D?=
 =?us-ascii?Q?ZPPR+MP76pkLmbrI5U0lxWWYLGAhBynOJR7Q5OosKk9/v4NEaqbEEVTJBO3F?=
 =?us-ascii?Q?iwrKGKTwXArIhAOpmyoY9AqRDbc5V8KhZl631nrkKWM7fC/zYoI+gAnVZUHx?=
 =?us-ascii?Q?R2N9v4Nyo460ALNjMRrrJqdAw7uAuKrv/+MLT+SPH8Lx8rW6mdPz1fbrmc6O?=
 =?us-ascii?Q?UKODVsYnw9IBUdDC4+2Fy2jbUubawK1QHL9Z9EfK39uWYLwwqf3PiLJnpFqZ?=
 =?us-ascii?Q?kJ11a6vkOkd9xLmHHaNhU0THAImO4UrZy+uCy/WOBT8KWUE9M3XOFZF7jyrk?=
 =?us-ascii?Q?Ud56QHdTNIVvEmhuAcqOkYFPzdqZL6wgpm/J58hF9KevYR6yPAOQY0pC1pS0?=
 =?us-ascii?Q?PZo7edVZGrXkD/jlNC94nyml2s1xZ29n2LYFpJgkyLHJ/3zEJP86yJLB5wQH?=
 =?us-ascii?Q?Tq1cuiP2hj7mgT8UBwmBr0m+vKCMUwSejwD2n+PhPyfsz11WXHuOuHt4B8Bf?=
 =?us-ascii?Q?TijOVo5iq2vRhkyY5eAo25inQTcgvoeLrwyvvrLiQ70HPA5z4iu0VHY2uknm?=
 =?us-ascii?Q?kSt5UQm6V/28qlUT3ybbTXcRIOGCsk+KlQ1wK/1m+s0hHXqjakDRShMCRrSK?=
 =?us-ascii?Q?uOFwI9QgnN4tH+gYqEJiQgF2ZMbTxyCE1XIBTQDsVV+smMhKlgblDmF4A+KN?=
 =?us-ascii?Q?gXOGV3i+A0ZsHfXuJQCycLEIVrNjzmhm5+qYTMlexru9O6cr/6My7dKSGlki?=
 =?us-ascii?Q?svM8xa44nZjdfn0cyaEkxd5rI7wkPfSVwObhAACfUipMem3iAlv0RNYfvyx2?=
 =?us-ascii?Q?OVjkoy2F9lC5TX/NwTHjHxnO/HVH/w3gKi78692voighfUAWXeAc2LPG4HVw?=
 =?us-ascii?Q?MUYKcEMyud/FgHDbiOWqwZUjrFb2LAy129C1328cXw9YKrPmkY8owNLQuiMU?=
 =?us-ascii?Q?xndsQU7Dlrdv+nzfn5apP6KNuhG8YTjPjkRf1CclsUMeTCuAKrnTXJbf6hum?=
 =?us-ascii?Q?JResOzBY1eN/xbEsAwvTSj8vOdgIyPZy2cfpEeFmndt4nxx/ZWqvkUSF14Xl?=
 =?us-ascii?Q?r4o5fNVX3dDQhzJc3eNSo1EZmOIMg6a3qBUvjRG0SYG4PrMcoH0iEhtSu+v9?=
 =?us-ascii?Q?PhcUboEkRyEXPavbzca9yD9tZ+fHCRITqjAvDjjBFxkvwkZ4aNGgjJiEqXz3?=
 =?us-ascii?Q?lU+3TKdtn002Qmjs6UhObBr8A1YQ9xy0moy/WFCA7NuT3kXndTX4RXAR7ZXF?=
 =?us-ascii?Q?vaEskqyDYk0S4xYCgUGo3Hd3zzsLcaHOnslhJI7dJhxR3Qy40bESu7SfOdT+?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b87783-58cd-4694-bd32-08daa874eb35
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:02:14.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEisn39UO9WnEn+LB6xgHq1r2qGkPiL0Ss7k/6LZDvYyinYXDLaS/znQ3itFR42eBHkp+1Sz8ZtOPYzbHkrPAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295

Drop mptcp_sched_data_init, use sched->data_init() instead. Add a new helper
mptcp_sched_data_set_contexts(), it will be used in the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index cabcb34d8af7..126cc7fe0b5a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -96,14 +96,12 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
-static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
-				 struct mptcp_sched_data *data)
+void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+				   struct mptcp_sched_data *data)
 {
 	struct mptcp_subflow_context *subflow;
 	int i = 0;
 
-	data->reinject = reinject;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		if (i == MPTCP_SUBFLOWS_MAX) {
 			pr_warn_once("too many subflows");
@@ -115,8 +113,6 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
-
-	return 0;
 }
 
 int mptcp_sched_get_send(struct mptcp_sock *msk)
@@ -145,7 +141,8 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	mptcp_sched_data_init(msk, false, &data);
+	data.reinject = false;
+	msk->sched->data_init(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
 
@@ -168,6 +165,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	mptcp_sched_data_init(msk, true, &data);
+	data.reinject = true;
+	msk->sched->data_init(msk, &data);
 	return msk->sched->get_subflow(msk, &data);
 }
-- 
2.35.3

