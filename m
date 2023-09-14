Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2063.outbound.protection.outlook.com [40.107.241.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A31D521
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 10:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWo9RgyuqbIGu0p+bSlE0ktJOFhhgqJ8L0ly6A5dSaHh1bmZm18XdX4rRPZqc9CujlhB84ApEhhfVfX2nGro9D1sd2Z/4+hExznu9P613jONvd7RtkaUt6yoKK0H89BGIjkU35hGliQUIb6R1mK/i/p0d/iGy/nCrziPA1iiu5dq+OLfPnHg82YFRHW65tLnTHx6djRNaBuGVVZK9vWbzqFx41zzCR+l0JKTAwjJjKUmLbFm/Vt0pvJKeq6Imn7jn2HlpF5iZ/xsf0/cOu4BIFMV9CSJSeh7jYjUFHTXv9KMqhfofCOqWjG6YbGyiI4Wf9fl7pg9DvlC4AQEyR915A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NqyoYGwim7ejBKptH8blWJJsNLB73puzIrFxTOLHjg=;
 b=EUcWIidTtxfOdp7DhoGkP/4CUh8PzzGXkZn8si9Itms7o2iZ1v5+KRLrAV3ZhMDyp5gJ6vzEPks8/rFnpHxRjGdubDqmkbOvyWoNWt1cJSOoBCU4s6DcxomccLcNu7vjWW6KTAYsFmtLVT5QEzcZ7zgDXOarKuY1E3jlMMdr5V9bQav4o6kGsyVoRY9ePk0gMp0yxWAoPFkYisk4/Py4wTb0Ob0jADjym99XoZsAGLwfLmt/hUoKDD/zWXgr9w/EvxVbrq2+0S0pRSGFu5/RL1yWPc8eEOZo1T3f1rVgJNmniy+XJ/C4LtuYcpUiXuHH13SOIq/oyK+yAaxIUYbsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NqyoYGwim7ejBKptH8blWJJsNLB73puzIrFxTOLHjg=;
 b=zDhA1nNI9WfXysRnt5ZLMQ0Iag5CyIzIgNL9e8jUXuHy1+uYj2mNEXNKWthOw3+6Oa4+ztR8kAnlJIQzP6iL1K5Yv1+2X8RnON105WKUAYofSamB7GVgvwbRPY2t0/mn4VqrSXBl7hiwgLlBFUBR0TfdAIk8zYBH6v91pQZW/oeWKNSmTb2JDWQlcZHZbxqgcFvxRESaAGkkZBBnXIpIp2tsUmvtAIRCGk2bbpcrHovDspj3+RMRNcRRVbbtZ2J+owteDlVHJXPo2TlsIz0IglXXOlX4qrS3yxWcVV77+g7p5etlWg7hDC8blL18trVPn2NR+5RFOfxeRWexhIVMCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:04:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 10:04:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 8/8] selftests: mptcp: userspace pm remove id 0 address
Date: Thu, 14 Sep 2023 18:03:25 +0800
Message-Id: <63e60d8054440395ab0a82d7b0e24db83e154c4c.1694685050.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694685050.git.geliang.tang@suse.com>
References: <cover.1694685050.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 16181f47-9beb-47e6-39b0-08dbb509eda1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gr38z7RNkSSr4HaEeJ/aM+9wXl8eTy93MgUFSMhFCENSMTT97rLTJTmSEATj0OyYQ+epxuo4Pi4SKfSSpqf5btVO2G5jsBYwyyhOShtChEBnBRSIDNFhw+Av5tHXDJjQmlSLHpJ/+8MfkUUPssQx1hkk37dx0WuKMfw+8dDo0oRAoqr25nSNp0q61rBZ6JNxu8c5w4Lef/mnriUJNGy81rZHmlO+hWKMB8S/MChEdL9WozcHobH/d+FUu6DtRHjp259AnbfsqZd9E4g0g3t/GJAULFkmf3HZvKd5uppXOdZZkELKQn+/gVJh3M+xPbZXW8pF+JmU+Q/BGysHoGIMKBi7+w9CTL4WgEnT5u3K614gayGFC4zA8vlgCEXnTWlWcU8gOdWgrbBiOlS7bR3sc+d7k77CxzB9+UWv1JteeLCk/WBfxh2yRD2sM4cCK9LG9zhxakzOuHcoTbOZ8fGNRwFN3J5ShtQcI/vZouY7dEJShv9V0HnU7v+Ai6XTksKBoiG1eypcIifUs/DCps1zFk2FBnMfPPdsA9aIgzQfVpiNhCJEQXOp86O6ssvWCDR+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(186009)(1800799009)(451199024)(2906002)(86362001)(6512007)(26005)(36756003)(2616005)(107886003)(478600001)(6486002)(6666004)(6506007)(83380400001)(38100700002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(6916009)(316002)(66946007)(66556008)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pVlitlxZqmRKGc7K6aZA9xEP5mekKQ0ClA1DfH4J53YWzUwsmzVcuhA9djW/?=
 =?us-ascii?Q?mpm+iX03vMqWcWGPIZ8g6BT7fQxapDmbwn0C4pkeXcDleyG04eg637bfXQIx?=
 =?us-ascii?Q?8KKoC0hIv9jLRuC5KnCWVBQYPa55pS7iyxENYa+eGqvNzpNd49xJy84wt+PP?=
 =?us-ascii?Q?RckfajitjlfmoPfK5jbH4iJPp6htymF0tBNWKM5ysW9MnGYm8HmqNTXHxc7t?=
 =?us-ascii?Q?i5+NgdICQD2RwHsYZOYVPO3ZheynBWHrde/Mt6cPdU5Mnelr2CzAW+C0HA3I?=
 =?us-ascii?Q?FVclxaXM2ayKSg6Y2zk+q3nO9c9VfP+5FrvsNYDYpFfJgT/rhRx+RlbKnmmp?=
 =?us-ascii?Q?1P6zk2ID2rIUiC4GPnoMDtOYrjSP8oWZYkvDTl63LMgE/dACXU09Hn1SztzG?=
 =?us-ascii?Q?qvucyOe0sfycLO5QQofhKzf8O33BJEHnwzCs5J+5+W3uhhiVo7PoXOAiWTN1?=
 =?us-ascii?Q?UhF0WybY2iLqMGvVC9xissoI70vkqTYbJ+ACtzu1E2PQkmyaDE75Gv8y0LDY?=
 =?us-ascii?Q?EOSZ3G1bQEIXtV9QbOSzZi8CuSYEJodzDT2iK+byMbBvczotEZnThmkfhmZz?=
 =?us-ascii?Q?X1t9aFReLjEvRovxFIsJW8HMMvb5gJfWkk33HJ11RcpuJTnzc9ZmKtJ/9U4x?=
 =?us-ascii?Q?FKjO23OM/TQVv59TSHyIPb1FkHiEyJfKFioOGAr1PRKaQcwWJbvG3wyiK0fM?=
 =?us-ascii?Q?dajypPujGBUMUzDOsFGndoAaBGcwSOSgZeojIl97ruH5+OrzmXm8YDbpp7Vb?=
 =?us-ascii?Q?WDZMVCeHEkcWhQaaJnEXF1+9+Co5qNuO0EPRB0RNn/OcI/GxgaJclT/4T1wL?=
 =?us-ascii?Q?zBqipr95Ch5DFnKJK9FSHOQwwHFD9Zh+VpGSlYmu0ezIx42JIONtZyQfZypN?=
 =?us-ascii?Q?jJrHSI8jbncgbZ7znxgSKaPObRIHoQEuUw3o1WCjk5KNCZAl1UqzSU/wGU/s?=
 =?us-ascii?Q?iY5ihtyiF5Y4QiMQZmN/hqiJO91n/O0k1d3mu384FAFSS/xcyWpDK6JSMQO1?=
 =?us-ascii?Q?09IQi2p1THqgqGbrfhGzSyZ6gihibO17tlBqdJnf5ydwm9n5AQlbLL86/A9p?=
 =?us-ascii?Q?zaNnn90v+ptHCRyZFHT9VQWo9AaEWtDH6xuzGbaHL0kic0bwvszO9H4rg0gu?=
 =?us-ascii?Q?/nue034ZmvRhAVSpyTOXf5coaS6XZm4dcGBLUpmHPmiINJQdNxhKRNVm49tH?=
 =?us-ascii?Q?3Qxixi9UMs9lSIE1jTzzL2gvJFqRp2KhysH+ab/khiuVY7+Vlz1S9g0noHu7?=
 =?us-ascii?Q?nARiLwqYSLd8UXFpCCstjvvasuk+C2v+jjmk37njORHIx9syZAJuV29Oax4s?=
 =?us-ascii?Q?Zi4iNDoLRh+ICl2GQ28FGPMjL97ZUdnUTc4R9XE9hyuuA6f9hD2Yt8tpIACG?=
 =?us-ascii?Q?FEd4bj8TCuO6XnEi2k8/YhVsb9fG0yNoEmOBPrSEp/6WRdNjyhSm9AbdX8y4?=
 =?us-ascii?Q?M4afojzlAzaHVsKsqJXWYJg1UJdKoVZwykVIYcvdiwsRK+5HkN285hCKKCfG?=
 =?us-ascii?Q?RFyA31scTYDO+wo/em/teldSMJpFeqXCThQMyi/lwkeriL2LqtIGZGU/yQAj?=
 =?us-ascii?Q?+oeiG9c5jB65/w+rXBZqIaXfvISRGlZ8RGe2NE64?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16181f47-9beb-47e6-39b0-08dbb509eda1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:04:05.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUe6FLnGOy/eKQVEOwcFlaB+aHphth2ncJ+tUfD0AsX4MyRhjQbK9eh1f0l65K/+fjMx9IfcgaKDTtP52exilw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d2c458676068..8a24a4025ba2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3517,6 +3517,30 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 address
+	if reset_with_events "userspace pm remove id 0 address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

