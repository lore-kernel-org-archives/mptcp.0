Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51A11C2B
	for <mptcp@lists.linux.dev>; Wed, 26 Apr 2023 08:57:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPfomNs2WmVxQyG+IwsCSu+PDXZzbtfFNmgw5RnHmQaLEC4SlkWgEshMdy6Yz7N7/TxYLp0B3Zo7UHfWiFFIVWC3hCFPJ5azwxniHN/38aY7CFzQEFmMSpObaWQ7lW5iZBecduJceBkRcDsb1NJxO1CmmOtvNDBbg0NSh+dvVfclOZpfi35PF62h7q7VWAgPpSlbhMvbw4CTU2Yty1tvZXijOlIoVGq80acPY1O2eRVlA54lI9GAKPRlzkh258/uPylwt6M2AESEdE3aA0xIAZG0hRb4yFpkYCMLvUlQ5jNnYWOWPv782mbt2LMFQRlB8ZgXMuKGI4fiNrwkpUAcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pQKRGKQCPOSK0aelt1gkY82J+RWhqBVjAQBYPz7ODU=;
 b=AN5CrFqyRpt9WAo8UaKfMw4v6eOTEFo5IfY1LdpsxeRsnClbtDh60EBtz/xM/nBIDwzBkoDC2U2KlzdLcXOmjyLaiNG9m4IptoRbNoZuTw10eok5NmssULWsBS/lEpZDTLXwj2Fbej3DDQtEb312mMCm7YwObxlk1Q5rNO48PASC0AjdDIR911qtjc1ghG7dD7oLVI9A6d+jhU1W6tk4SMQwFx6jaP8f3iCAYJ+uKYZMVF8gip7AnKbdlWw8FH7NqrMkZUo59/pCICiO3NF90u3lm9kvmJO4vpmyykA0jW5s7gLZpwTrEqMN19q+gMZJEVG/GKXIZxK0NMbTjeX8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pQKRGKQCPOSK0aelt1gkY82J+RWhqBVjAQBYPz7ODU=;
 b=s0w1lHfTX2wCU0HK8hdxxPrF8rjcl1pqczLrEj8vMG0lM6/+psvFLNQ/S5vNcZNoJHMBj4H9KbnUKNf5j2lFJP6gOzvbbnua/r0UUvGQkQYxmhg5SGSJAc//UUjwNJUv3INjsqlGF3nsHlni0Xm28EvvYtH+0Uv/a/0oSCnSlzQ+FyAAcJyjTdro4xGK3P6AMttNH4ldHuJ5qXlFOeNJiTF6E8W6ME2V8Ggjk4wapsWQ3U2E18za8BqrZVAunjp7OMiHV9OF4WB4b4gQ+Y1WP/TGSHdUiclrcJq6zeC6LaE3Avo4yGNXSpO1NmTdXNyPmEoGFgNaBpoNHiUp39+8Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 08:57:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 08:57:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 6/6] selftests: mptcp: update userspace pm subflow tests
Date: Wed, 26 Apr 2023 16:56:27 +0800
Message-Id: <6d3687d33b1a7f6b40e75047ab09a625ff79d923.1682499136.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1682499136.git.geliang.tang@suse.com>
References: <cover.1682499136.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: ad543c1f-a93d-41b3-b16f-08db4634481a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gp231SULPLBVDPgnK+dTD1ON32NT0ASUxBj4W58KoXKkRgkW3mHGwWEedZ18L8/ZCxzAq5buMuXYvF5RVK/4ktwDZalsnLJw1mHolY552Y1MP1Gz5R8CUpjtJ73sFbrXAbZepNcdkHUIhJoHk0Jcz5PkNc202z899y/vXZaCKA86HFK8aL0g56Z8qPH+HPx8RQ/bL0a+K9Att7ylMx0mOYuCrFoorGBDqJaxUWYrTC4Iz2axB2glkYlndNGM35YifqVfkaaNEMZ0erwqFCSFzL9I6OXzVBC7mOM7MpqcgYhmo6bt80qbGPFVWLTvbap0HUaaK2mNPzs1JtiAYFbYxGEE3ylVwCNTu3tpsRXJJSu405ZottjF2fGLpmrrySSvvm7G7gVaZprCZWFcoibfC4ZWUW3hYJnieTWOtbF8ADXGMDjlhYpZuScSDNInEjmiA8btaEYW8U8x5PcdqOtcI/hD+pl8U1BMyzQ7ZVSQxJBKlVJqQPNLH5U5N91InUGPYNydwYKRQEfUiS14PJGxUDIyXU3VkuQnxI4bIP4illI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(316002)(83380400001)(966005)(107886003)(478600001)(6486002)(2616005)(6666004)(26005)(6506007)(186003)(6512007)(44832011)(15650500001)(5660300002)(36756003)(66946007)(38100700002)(66476007)(66556008)(4326008)(2906002)(6916009)(41300700001)(86362001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bn22r7EL7nmgtA8b7afSVGJhDSMFkaDKnvwMd5jlj/Xm2Uu9ZeI+gWuaeJQZ?=
 =?us-ascii?Q?Z9GV44Dhie6XQ8+AOJh/2GOTh2ExxjQhnOQdgScmsc+jZkYhm/zGyWmXFz7x?=
 =?us-ascii?Q?C6FwPZc56CjGYHfwr3Mb/rsPduKHSQdN3e+ZdKx2PAqnJyo1f3FLKp23AN9a?=
 =?us-ascii?Q?SAW1FM+vQSdJ7nNcbl9Ej1jaW9vn1Jr/n41AtRcHPhJT7LEn4QbJupEBCV3i?=
 =?us-ascii?Q?IFsle2AxOrMFcx35BnhS8xJQl5xiBP3BteENqyE9wbJMhDVaRtLKO45OL0gK?=
 =?us-ascii?Q?ZEsdJuhlLzXtfxHoJkTjHZ7v27Ra33v8+AI1tDgtx9dE9uhJTen0C/0FwufQ?=
 =?us-ascii?Q?dCEO/zIA4W8CPcz8Xsq6vtzGQH8kgn0cKfVE+6XKhLoxXiZnjfdR3bFFMFf9?=
 =?us-ascii?Q?Cz++DVSJxqPaBebFUYD0UP1UiFpFL8cPfoFgRdcSj0DeeLQ1dUAG+buL9uZT?=
 =?us-ascii?Q?ASXkguYZADFXDi2Y1Atbtx2obiX9CCcPYqpVYUyGoMBNSejfM/36K4+doHg0?=
 =?us-ascii?Q?XhyAU5DekaPqaU+cUxmLPI5V2jiMWrwUmooMpN8PVFomHgNyYdHk8QKqb8mv?=
 =?us-ascii?Q?saXj8vX0YQo6GBX9hGoM/goNetrejkpfnWgROWxXm9oT5W4e9IMioWMEle7I?=
 =?us-ascii?Q?bV+zkKcSYJt3dGbz0wpDH6lQ8jC+XV4ToqOBAVjCkHtpYJT3OYkTKrZnssWB?=
 =?us-ascii?Q?edHmuTIsoRt8E6aiiQ5Wr28JfE8uREw1lUovbgK0tZYTWhpwwE0byuqGM7xG?=
 =?us-ascii?Q?qsJQrhj65MuFiP5qqfvxuD6kplCA4vbnG9dWLBytOGzGG2f2gE7w6P1kTY+I?=
 =?us-ascii?Q?XxWEeqge0o20NZlZRqBpyOlpMq9EXH2axDUlyJeV4BBeMAY+L1CQ5RJcTuw+?=
 =?us-ascii?Q?qnbz7vsDtReu++3TMnD+1CU8cxQFDfsIiQqlOYpthR/eyJI2Ye1HpnFEb3kr?=
 =?us-ascii?Q?CklIc9e34MsvlYcyPtrmS9wwf4oauLbxGjH6hz7qb7GG2Xq1eUkOycIrlYBv?=
 =?us-ascii?Q?dWggJBOfkiWuy2W8QGGQAV6N6bk8ZfZceytodEIJZBx33yAdqrMdLEGhkC1f?=
 =?us-ascii?Q?kHhKxNi7s3utuUT6+VEWo0l93mUe5eQiXIhLOAHtIjOVfXifLjS0r8NENAwb?=
 =?us-ascii?Q?x85UZlw3lifM1cwcMO60EAcrQ2eMiBdc/nYa03SoqL5NusEGmcQEM6YBT6y8?=
 =?us-ascii?Q?FShx1g6FUWXTbXQT8GmngB6ToEdfECDrVGP2mSFN3l1sNDpOaN/ENjF14tAO?=
 =?us-ascii?Q?wep55nmmeLchMTWz4edEdibUDXUUi6b5/znjamyyK5b4NDO+b++mM01eCGNG?=
 =?us-ascii?Q?4squbgNrZBGQ5lQJAS5t4a9yO/Y3tmPn+usgjhDFFWNpmGtc65EwCEzOY033?=
 =?us-ascii?Q?xbTQICuwogRoWEdttB+4MT+SfUrNynAq3a2Nu5LJ0t/+l4jjlyRCl3G6tTKQ?=
 =?us-ascii?Q?Mw0rLZOJyZPi/mFlOJAM+ezzrr7xx8/lXeU4pX6AQnCF3c7p6eIylj2NzyFz?=
 =?us-ascii?Q?lLDAsvxRxX8HEpPX9wlH9GH6XgYsQ4k5ZSapNsvLKCgPs7wzS9JbiQ/+pYHt?=
 =?us-ascii?Q?wiBXnFnP7kvngr9eARJx3biV711O5CU8YAHV+6o6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad543c1f-a93d-41b3-b16f-08db4634481a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 08:57:36.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bRCUsesDYNFYhkDRFYd/BPWZn4cHT+djjb25AVwSukQyLm2uOXsRSj0oFBb/udYR7oty31RMzgUAReApV2zXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237

To align with what is done by the in-kernel PM, update userspace pm
subflow selftests, by sending the a remove_addrs command together
before the remove_subflows command. This will get a RM_ADDR in
chk_rm_nr().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 5e986ec46874 ("selftests: mptcp: userspace pm subflow tests")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 67d5d724266a..19fbe1c34a0c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -923,6 +923,7 @@ do_transfer()
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
 			fi
@@ -3137,7 +3138,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 0 1
+		chk_rm_nr 1 1
 		kill_events_pids
 	fi
 }
-- 
2.35.3

