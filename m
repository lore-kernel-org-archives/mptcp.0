Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3E7488
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 11:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKsoSfJBVVWWrP7j9oSHE3Hmi/1Zm2BnetpFGsS/uPJMob5rJyovxH5zn8L1np20+FP+E5G0KS07mfoXw6dwdPQQr9YFimABiGrxtM3wLcaFoMBXkxxCEVib7tb/HIUCTNGf3EYrZXhNXs7sltA1vKB26UTA4eb9u8PvsXq5GbRMRnAq1OGdRBMVEg2o9jv3VisPEcjCW8Ue1TfR56FZm5FvzJOr/KupJnhZpzJgtxguQKHAnPw3ENOsCwkRerWfj5xsgnBsPi1txkGoKktGet/kYAcE9OVs6ZeJWIqh8gtisM7Br/eYOzZXMBbKacest6WSgHc+ssswIjG18oCo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLVOeA0OFNi9ma0naeYSLvtdkD5LsWw5rjdeoTLn/s0=;
 b=E+94rTO9fX3VZytlLrIvXURABO9MtZFlttmsC8YHXpy7Iw+OG85CBltEQJrEldXmY0wFy5qBykUC27Y6W1Ukaww+kvZkBFPLfyYI4DVy1fcvzCTOv17hucKLXifVss3ypEzskE+54grnlEveGON+jy04LqZP4scuLKjD3tj0ed+qotxHqKWpSdrBQ+sgLzaNDJVAVdWSKRvj5Hz5PP2OxZgoB/ECCfRKCaMxHfjE2mSpky0tZwv+ysA35i4iw5qfSg0fHPtdREgNn1Kf3UyyP+Aw0smjdIkcL3y6YUUFa7HKSQcVPuLQXHr3dUXPkyJaKU8ybPHPyIsIRP73OygA+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLVOeA0OFNi9ma0naeYSLvtdkD5LsWw5rjdeoTLn/s0=;
 b=mgL1QflVSi4gbEgAmWpom8MsNjgSW064P6aTQTq2YiEHpcFe2Vy0ZR50aWoCOIJvrfUQRTeNb4RDITq+XBrYRl99/zfxPjqaFDCz0YtIr8MWrRUpCnmc792/jAXut40uQsSeLn/qXQiiK6oaCcRBKfK86rXpP85783MDw2e9ub/yHN60nlVxCZknpBhakBpt6AJxj073YYhzxNTbwSxi8gyyxLEPI3IVHupV0n8jLUR9oPh48LNMrt2fJTIZUIzMmA14nbsVnrlrJqEuw5DRl6qVFV0ijG6oYAoNylB+SY/LgE9wiV4pTBhGhmWTwiTg8WtUaDlsBVJUT/+dLYJ8rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8281.eurprd04.prod.outlook.com (2603:10a6:10:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 11:45:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 11:45:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 4/7] selftests: mptcp: check add_addr infos
Date: Wed,  7 Jun 2023 19:44:23 +0800
Message-Id: <e73df5173812374ce970d33139aa5a725166940b.1686138130.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686138130.git.geliang.tang@suse.com>
References: <cover.1686138130.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f06cf30-4dfc-40ec-f4de-08db674cbaaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O2yUu0ZNhtOJRKV9F+VZqsH6jf7+cYz+8Dm4WHX3981QYilXy98b2dWeapddsn0k/K5oq4U0pdpQIwoUGOZnpcWCeMr1PozjdZC2A3vVx+Jqh9stcdNlRK9XKoOmvcxaQsDVKHl6pDG0nbj98ySQoCOOzGvJ/pwIZtmDtxaVTPMgutDIo4KBpiJM+/NNiSU+bXzq8NVep/Zx1rdtjlKLIG+Or2S7V+PjYVQYRyAxR+B4drfaeizlZlrZWbffH/9zMizrAtHYmw1tX2YeXGXi0n3GHO8ftFzNUkvKckljJ+e1l/6BP26l+3lP6C4XcY6L0cmcj/tww23Y8+MVB0QGBAmUWwetxyui3cdA32kUcW4w11y/1HouyUcK0JBC0w6k+6zcdh6bpXsYLBlOMXpT9b0aCY/1HLqfsKKE6kU0YakaBWFdHYdsSeXfaYtb4nGNNS7TWkdEtmb49G2Of1jxmBJoB1Cqxmhg0G9KpASKwdyOzRGdjhRyLmfADW16Qno72S+65dQmDS++KWbSLawSnFV121LN0qcsXmolg+sGoUM8IqEwPQ4mh3OCU7nDbVWG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(107886003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(4326008)(44832011)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TIfz8XbGdGMNrxXguUd6G7/npNht2Km7SsrU4V85V3cAnQ7u7sEnRcOAmMBG?=
 =?us-ascii?Q?1eD5SaaVy4xwcqbBS5ekwbaapG25i133vvMRv1luagw1DmMzH+KuPOO+y4js?=
 =?us-ascii?Q?N0nGSF1ow2xjvuegtfHMWM8rrszUQ0S1CEA5ZsaKM9/z335/EJyokikwiwH9?=
 =?us-ascii?Q?CKB2MBAFyrUD18voggr2MDRWtvVocwAHhyIWeYdX66WDSCqyNMbJSMkfXcn+?=
 =?us-ascii?Q?B1eX9pCZz/nebwQxyBGwgdo/pNj95VDXrBrIYdUNbiHEu54/T3E2i7DYSXAw?=
 =?us-ascii?Q?UnCsMkopwYNBgPUklgdDCbpgwhdJrJBVzs9RjXMPgbZHOxMPYNAOLcfLC3BK?=
 =?us-ascii?Q?wDNXZq1rZYpOoYrVXu9kV68jZQK0GvYMG2GOxwruQ3P4pUCPTaj3lBtSiRvn?=
 =?us-ascii?Q?cXiwpxNDXqeDSnMgPCRhhPslvfBTHM2xBb6iU+wP177tS18Eu26bx4DGxSIe?=
 =?us-ascii?Q?VUOWKNsNM90IWQrIaX3orTfY8yvBicrv18jAHjnJlis80V6kEwI/wdB93frZ?=
 =?us-ascii?Q?rCjvCKkUxQvdHBR4ivHP/a1bEz+vdoRJstzGZl0JZM3/Up/0tQnMEVLANdpR?=
 =?us-ascii?Q?r7p6K149wvG1NZiB6Ql9SJ9kZK3KhKkRo/fH5hn5WvSasJoT5vkh6GnqXF8y?=
 =?us-ascii?Q?541KL7SV3iHyUd80u0wbkeGTsEDfOqdHqNjy+/pNjPdivRw0WawrzoHYgH1C?=
 =?us-ascii?Q?14F+4CDBrLGQK6PS8Q5vWeHOxe9hPBVrFHiwDLEtGfhTDits/wS2CdeQAt0n?=
 =?us-ascii?Q?X8fgdu0oUOr9j/lojuQujIP5zR+8OQq7Nt1PBmNIvwBdlWZioZIIKGrkMVFa?=
 =?us-ascii?Q?POh4fTDO1ccIgpkoY72y6ZThg6BvXeBIVTDLCFan8cVoi+4VeR3QQAgx2BKS?=
 =?us-ascii?Q?tNqWxP9tLK6imS6kLQq8QlVBSyyqjZ5c6iX8fsYGZCJ1VHoNh+qGSReYBUdr?=
 =?us-ascii?Q?ZpRJAsC9DmTHuDs5pogGFycEWx8SxZbntgV8x1GmlSaCNreXC+B5Lx2gUSJv?=
 =?us-ascii?Q?hjudFvO8wV4jL+rlZQUgjMXpprQ84gkAHBftKyCwTCGJP2vTGpJWFEcn5EYu?=
 =?us-ascii?Q?A+kbV2BcD32VV/V9MdcZ2Kivp0Qgw9a428uqQe0MJnw3hbmME6CAJMeh+WLX?=
 =?us-ascii?Q?5z8kRYGG8LRT099RiEpnzIDykwA6dvw2x8EtHjJfEufFwStpal8ugwLXz31p?=
 =?us-ascii?Q?lhZgzJHQL9iqQQzU/jGgF4FvE/SLmN5F0+J63r1HDYPx38bB+Cm9ZlhA76JZ?=
 =?us-ascii?Q?00xk3LQ34xGB3AiEfkA6thtw1uyMZEVOiF8hoSv/NI1dx50URfzA/lAPllGI?=
 =?us-ascii?Q?v8Q+vdoQzVwr040iXbftH1rTOsWHDE1Qlxo6pR8F/ipCJQ4XDzJHdpGwPxtu?=
 =?us-ascii?Q?+nlKs/lDABDNPov4QM+si2NAQoIt39M0s58krt0xtj5+2UzCJ6RHeEU5LvgY?=
 =?us-ascii?Q?AfLnUzbNrJcxWPV6CmeTtWbRq0HIDmiRxhx7ey8bh67SvK5EpDGMSWEn8m2e?=
 =?us-ascii?Q?odBYCO7LjDHR0PYXrmIk2z6APkgP7AQdQ/UdyAXLmr4vDDuwlsAbYFLt1ks7?=
 =?us-ascii?Q?4STV3DwHdXQ2ram2V8PoG2Z/Ub8xJSbNbap/0pKN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f06cf30-4dfc-40ec-f4de-08db674cbaaa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:45:45.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rW0jD3Lnx2xGTMJ2fCKirp6hkomQMGEQzj4JUNZnKKMlmK/cbrBABggwp8RGgzOd9gQOJ0XhhHCljE9h82z4SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

This patch checks add_addr_signal and add_addr_accepted in
chk_mptcp_info(), and do this checks in userspace_tests()
and endpoint_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 119a309bf96f..530b88990b76 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1820,8 +1820,8 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	if [ $info1 != "subflows" ] ||
-	   [ $info2 != "subflows" ]; then
+	if [ $info1 != "subflows" ] && [ $info1 != "add_addr_signal" ] ||
+	   [ $info2 != "subflows" ] && [ $info2 != "add_addr_accepted" ]; then
 		echo "[fail] unsupported argument: $info1:$info2"
 		fail_test
 		return 1
@@ -3308,6 +3308,7 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_addr 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
@@ -3352,6 +3353,7 @@ endpoint_tests()
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
 		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
-- 
2.35.3

