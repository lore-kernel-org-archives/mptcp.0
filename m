Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E9023C2
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 07:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8WBfrIpVbG68gadDwsoDyao9oDSXy+bQV9yPLwXZiaoGxMzEdZhZi6SA0Cf4lFOoqh99PsOSISRkJLEDpCE4rC19yHPjcmee/UWrXqtEcOC4NeCaNRV0e2PE61FgH1g5X2N4y5YHJkY0+e7AFzwQDNeKy6GRcSBm2jMGky4955+uxEvkQoVnLHhTFV8FrXIFHDVLX8ByaG5K37n3EAVCM8lYKvG6zXYTxdAHeeBldhlbwVIBK0snAtiJUvAt+d/T6G3kM9eBLzU3pADQF+lfXDw/pqTR3nuVZGP8PhLEeuM+szdwRHq2A+h1A8IJKWcYvWzmF/OQeTFFzUMK9592w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cm5fqmsWsiZaUfU01wbqQfyei4qFYcVVH/OvWxBR9oM=;
 b=SCR1L+rvRpgTE5Bt7ov7uWGVNOywAky58RDTESmaepgwffFIBnrMsRkMaZf76PoIxsvywfPzWchwVz3zxHGns9v0wEmYgnH04exD6W0U9PwQirxAJ78p0pR2IxWsU+Y6Nbmcas1E/uWn6pFA2NnJ3YBvFM6gJZU+Bx4wzyOUG3Em9cmu3qQV8Wl0Fu+n0qVE31dhHS9Uhl6QH9ifJXTmoBHQoRlp5v2aX6RSfsmJCWP6HCPwFmrVj1OQOBrTzVXDXOGpbDTqgmAHBxKLUuxjfZzmk74InY2FrlJq1+hvzVbHLgVf1OvfTyI/7FkG2luQwRYKO4sgHzjLf9/tCgxqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cm5fqmsWsiZaUfU01wbqQfyei4qFYcVVH/OvWxBR9oM=;
 b=tbvdzm2wLNZiqGWIT52R9N6ubRN3lFydn4RShSsGsW2JpBzw2KFCdGxMy2L3h6ueiVGjOSYLFrm/2llJBivlAdZg/I0TNYT3jlKDn+8mNfZaqnwK/fKzLYobIl2JRcva55kJPGFblDf7vJa8MlpqNbImiMfmGAq27rZTMyhSNRQlbq2EFZRr3owaNRInml6yq6N8JFbTZIewnQejp5YSvWgUtaimNDxvqldkKGhLm6RTfJ7YGCKqTrzDfGFojcn54nCJEAfn8REV5++SFOwvBI/1zwgcLjj1HksUL8pTEAziIKEg73soyww3RJH+07Pp4AWov1dcDge3I34icR09dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB8226.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 07:31:36 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59%4]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 07:31:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 04/10] selftests: mptcp: set FAILING_LINKS in run_tests
Date: Fri, 16 Jun 2023 15:30:56 +0800
Message-Id: <1d167a3c6f9d31a691d28f7bbca8b348964a9610.1686900596.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686900596.git.geliang.tang@suse.com>
References: <cover.1686900596.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3429bf-834a-4f6f-04e8-08db6e3bb78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3DAAnBrijZVr/llrS+fmTMdYGFIVopI42Qgm0wqlwRG00gM9E5bQr/4UPPo0Awk/TnATPIeePGyjDdr7lECHyBAXpFnMxzOe+asb2/w/CACsvmlZcqsTCTE9CHKeqJFuWVitGiU5GYaTCqQck93bImV8kMgOYhkdNrjlkU+gl9t3cXTCjQolkoij2pRSkrVmj8WNgDDYPNGDAmIJfuOGifhxbNSqR9Oy73kCO5xiq+D1HZnt98GmAmJnB+ycYdTIuLnRkHpZ/sJvMeI3OF61R/SlhBwyjL9ySVID/SJ4TsizYuei234WbC4GlLfSV5jm1Q6MJw9ew0M4iUXIBXACjss/jIsSOR1LZy+U/zL+RaaIwr9u3GrA1623Cay2aGfZsO4mALW+8Wru9lKFnHVcztQM0VEsD0qv8QeoetOtRYcEXl9izzoMrGRpPeuSVbswucBbiSPVdUidhxZtfA8Mtz18pzpSD5vseuDwWIVEBnL+6LyIoXA517YZzta+K4WWCX84pU3DxXhw+1D75wH8z2ePgDgdOfkI7sXhCCGgSKiW1E/vllZ5t8C2wqA3/yoc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(478600001)(6666004)(4326008)(8936002)(5660300002)(8676002)(6486002)(41300700001)(6512007)(6506007)(26005)(44832011)(107886003)(86362001)(66476007)(66946007)(6916009)(66556008)(316002)(186003)(83380400001)(2616005)(2906002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4yODxyXqz70ndx//X082BPsOzn7lWNuvDlDisV+XQABD41e0Js92RiFV0xv3?=
 =?us-ascii?Q?49WBWuCNCFMxQ0874DUwTe6PGYOSkcmmpWlONs3cE+OUZbNjapIXFXQqYWir?=
 =?us-ascii?Q?ytQZZG/QdvrNkJUNFZg3fw4wh0mh/rW0huP4+MUGCxxoKBUBhgVMgfOosIIP?=
 =?us-ascii?Q?gcAMLGR2NesblqTw6gbweR0qGFND4OwafQOweNC66ihqJB24ZLaJbrd8fv3l?=
 =?us-ascii?Q?U7tclj6p3tbEJO8sEGkE0MBDfcGDjMepEWSRSLBt4Z/FomBqnJOp9VMdoaxe?=
 =?us-ascii?Q?Z5WROd5V6/0PbnCHceXgaZ3r6HzIbjCiIKtevY7AXKI3EnsUc2kkuJQ/OG5C?=
 =?us-ascii?Q?GRrGceuZgomhJbmMVQkkeSUaqtdrdyXTXgK/IZovchUNNaYur/jethL8TpQf?=
 =?us-ascii?Q?YXHBuFl6X8rvpe/VCdLIy4FXnxYld6rX0fGVF7x53Qq/Wm9T24Kt+yvFOEg5?=
 =?us-ascii?Q?u0G7kwxpKYNMYp3PyzRzAzlGmZ0OFkc2lRZHCFHTj1GFppbsJoD6PLnVRYqy?=
 =?us-ascii?Q?KY19gYV0ftZjppzv71ywtfZeruahA8AmofCc7eeT/oxnf9O7bdfpI/Q+IEWd?=
 =?us-ascii?Q?Ps/7UPYE0kCTeWtxvAMg06an/Mr0WUsuAN31lgqZJ8g9UcnLmVAjmSUYb3Ky?=
 =?us-ascii?Q?PiYOZGuPTmphMRPqnfo+1305pYr/xVZOjt2XJfi0yfz4uHlODgH5eW2dYj+y?=
 =?us-ascii?Q?ijIbYj/tbAhSJcqfeLpdgzEq2Oa30oVHwhuMYN5dDNc7MF8AdQ6ojdN7MRFu?=
 =?us-ascii?Q?BT8NIRXeGVgrqHGNgsDIeDBu3nPJBkQpohe0Sagv7hjusiFwkoQD7Er0PSGQ?=
 =?us-ascii?Q?wzHno93Bjgnd4+RgUAD0KlNLEbf6Vpn1S+PYUYId0XBNUm14Qnye9zRrfwRp?=
 =?us-ascii?Q?lRQlP5odDUy5tPy2rtDPdj9ghyJnyo2WDlPKs+mQFERvzBk1vbb9Z5vouxmw?=
 =?us-ascii?Q?hyv1T9iCmackptHqInV0ncRyNV1KNNG2qs8I3l105T/9JCyU5EJRVg6u2PAZ?=
 =?us-ascii?Q?0bV5uDp4igqdHzUoq58NFSaRlc/Z2duB1OjJXIHJI5GC3eXiKWJFfwtbH/S1?=
 =?us-ascii?Q?XGrQCze9Onkco1NX6YcVu769cR+uuGG0rkQg9Qjl8OCMkxhd6cBQBp4IR/Z6?=
 =?us-ascii?Q?rOC08SZeHa7YMk16a7+6ORrQfKMcIMBRY+ZEaYiBQ2hYr4AbVYSPGsIYMoJV?=
 =?us-ascii?Q?9S0TP1hsEEAfzbgsleLpGfxiJPelToWRIZ2vlrAsV3laalGE9oddTnP+CwFt?=
 =?us-ascii?Q?LuUKLcQABLu0JHgeRRt2jIYcsQ0rhfAsP55Etozo7DFsoPMvNhMUN+iJU+fQ?=
 =?us-ascii?Q?p7Z1Q+t4dZYxSlkh/7wh4Ddb+4xm9/YevWuLSMRBoJRd9X3Ssq8bxtyBtKv6?=
 =?us-ascii?Q?7u6pHypZ0WolsIga/KHyLrQVDTcJyDAndwp2BxtCSJSh4hAon3ibuIP76B/B?=
 =?us-ascii?Q?8w+lItyFhszCSfY+7EBawW0SUeVW3/zzi204Y81ByKKK41/7b7F+rawWiSO/?=
 =?us-ascii?Q?TH1JtModmpVyD1FREnY1rS2awzP8KuQUikJxgcdUNk9gkZNVTRfm61vVBVVP?=
 =?us-ascii?Q?tcO5bW/FA4LAnDr7mn2cLwIda9ChuiCbs5gK3mOU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3429bf-834a-4f6f-04e8-08db6e3bb78d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:31:36.6027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PibswDhej2RYLNd5CUq/x+XDtV0MgQ7ovgyP6uUf2tgOgUsJcs8sju9Tb+NT/mAdpmmAuOqnT+oneeEhwDyaGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8226

Set FAILING_LINKS as an env var with a limited scope only when calling
run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3811a6c3dc5d..5146c5268c44 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2183,9 +2183,9 @@ link_failure_tests()
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 2
-		FAILING_LINKS="1"
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 1
+		FAILING_LINKS="1" \
+			run_tests $ns1 $ns2 10.0.1.1 1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_link_usage $ns2 ns2eth3 $cinsent 0
@@ -2199,8 +2199,8 @@ link_failure_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		FAILING_LINKS="1 2"
-		run_tests $ns1 $ns2 10.0.1.1 1
+		FAILING_LINKS="1 2" \
+			run_tests $ns1 $ns2 10.0.1.1 1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 2 4 2
@@ -2215,8 +2215,8 @@ link_failure_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
-		FAILING_LINKS="1 2"
-		run_tests $ns1 $ns2 10.0.1.1 2
+		FAILING_LINKS="1 2" \
+			run_tests $ns1 $ns2 10.0.1.1 2
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_stale_nr $ns2 1 -1 2
-- 
2.35.3

