Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77731808
	for <mptcp@lists.linux.dev>; Wed, 10 May 2023 04:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1wl3wwYznKgUBg6ILO3WTzEfcr4RljYncCWeNEcTqRVwLiQZ7fvIhWSO0XQkLAguvCQQxQqH9GtBBqaGjKvm8pViSvWqdsqDeMoNFxtQNuczL/fXTdLHG46BT+oOZNpo5K6QOu9iKd8S5+wq5jf/0od40qBr4mWg5WfaQN+ISlBBG4QhrSy2uOZd+6SK/1EE7IAv8nZz6iatQMWMWDidwrC91/rnzNA/9QsccCjWakIsua2Ixlj+k3P07CCo66tB2BkBvTxgg6icWXpM03FlBIQ7/Rtcsa8JKpNbIhczG17Zz6x4XMLnotdOZh+acg1szCl10k6Z1gOTjmzK8njAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v161FelxJj6ksbbSTqbRIq4ql4rHaAQ9WupnvL+gNW8=;
 b=N3LAp7f0AuQnzgFym3iJ1whaKvrXF1t/2dygTRUhMPSphii2ExIRVr7UWGmSj5ewKVtQhHPThMxjrDECscf2Etu77zytnMeLnTp71il2Ii6DikMIZXrToeG7pOYF9Z8wwzyZMf891nxMU8frY9v+xV0pbdV0hdC7BsX3yfpPGn606NAwp+rvElrMHL5AH/rtgJ4aWnLp9p1OVJn29QSEQhNoZRAooIwecUz3X7kSbm3IoAONHugt/FpImzTm6rVz4Ygd3kb/fT2Ydwcv7j1O9Qner1sxyQEGxos7aYlsHww+1vJPaAYivATw8f4Vea7mO+0823dSwVPb6nbvHMMVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v161FelxJj6ksbbSTqbRIq4ql4rHaAQ9WupnvL+gNW8=;
 b=1lpQM2dprhb/nu6fiFUj1K1MQIqJPWxoVLq8OeHzfpZgsnrzhPdy5e04w+HNb2o5HCCOn0ddGuXIo+vD5cLhwFpFIxJASi5R8A3EWS7B1SrTxrGbuDSNgnxhp//LJPVtFccm95GHfxOW53bziuiOoEmdHgjmtIwRupQ787gqZa6Faw8ZmfCt8bsj8pccsZKOSAGuYrqyytpv2/9kFULE79XsYN9xYU8NtvlJGunP9+xuWdg0yv797glRy/V74DuT18UETT4B7b31clKZZZycr6OgfoTwMJfbMM6UYNaazGlX2+JiYi5DptbJZf9vjDjTAeLomj3G3IFKIjHgKlyjgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7146.eurprd04.prod.outlook.com (2603:10a6:10:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 04:20:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Wed, 10 May 2023
 04:20:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 5/5] selftests: mptcp: update userspace pm subflow tests
Date: Wed, 10 May 2023 12:20:12 +0800
Message-Id: <6350d66fcc037183977d7dd6cae5de14c14f770b.1683692137.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683692137.git.geliang.tang@suse.com>
References: <cover.1683692137.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c902288-babd-46ed-28d5-08db510df2c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F3XAl0kMRQh8gl7hBKPKNJ8M769g40kmjeRABv3oWEazghYcHabSXzML7/houN0nJvoTxdUXYq1JEo2i000HrUgBQ/qg9SjTGU4TqsjvSuJ90x1WtGq/ThSoevnvNgXDPgy9Eu5PB8Unefeh7mCs/wOBZCl7eL81oyoJsNNANYQJRQUSjP9CyIi7urK+RAiEzUOoL76c2pt/5L5MXsyKdZhbTWEXfxpJy4Hzjmg2nHaskOQZqU5SnKM66mnOmWxQPoD3jetTAN1sQ9uKVSnCRDiPf/j6aBEl5AqCbKoRAI9G+/w4FNYpmBLCIGeaK7R6N6X330GxT6jI4iBO0fe916POrdldylucOhXkcWckru1yvOSCxbZtcsvfJIscTOLJGE8iEWMteFDQrAy9THpON4DX1Z8NMIXL/EJo/oqMSEp/OIInrYIAgCvyPqS1LxqVAZ6dPrZVhyphLivWopqOSh5aGuYu9uT8Ldlq7h2cmOWlkoSN2LojfIDBQSHJWZmGFtAhJbgJAYTcMzc+Ag7xLYTeD1lSTIE++qkphdHrDF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(478600001)(66946007)(4326008)(6486002)(6666004)(66476007)(66556008)(6916009)(316002)(966005)(86362001)(36756003)(83380400001)(2616005)(6506007)(107886003)(6512007)(26005)(5660300002)(2906002)(8676002)(44832011)(15650500001)(41300700001)(8936002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hQQsPHVKCtOWIwCS5//jlNlR/wpabhI1KMurmpp6Mcqf1jjzi6foaV9+zDiH?=
 =?us-ascii?Q?b55eTXBNsJTcuQEkIVeaUfPVqZCc92CFml4jeHW9pqpQFEAy0iOY5e5O1GVH?=
 =?us-ascii?Q?fHHdusXuWfeanTnCGtjLVgk87S+N49lrOMc3fymEstBoyrzdOUVWrAiKzBQG?=
 =?us-ascii?Q?ay+cFCkDnpM4atap3i6Rp6ZuZWBK1p6kcudwtaNCRs1p4H7hh3KsVWBQmAGG?=
 =?us-ascii?Q?oOA0JhieZDtrMxtJSoQ7LYEqJTlewVSxEroeh30wmV9hrnzTHLLqk0XIc9Ul?=
 =?us-ascii?Q?pGLcNWHjq+6ocFKrOhNtSPhGfXBA6jzh908JQ8G7BHo1f+nK9gANxGrxJ3l5?=
 =?us-ascii?Q?WkcoN3SPtuJZqofOfRgvneaZQpQdcAZ3q0Gofh6ALnUFLMp+iLjsKT0teut3?=
 =?us-ascii?Q?tLPiUeLNKxQLbcUta0olyg3eWscn6mbjI3klnVstYpJOPy/BcdNvEoPgevA1?=
 =?us-ascii?Q?sUG/kFMn4kZfmbaycuu+xO/gdWprzZ5JC1ARy0hoZ4ekgJLMwMUCevPI6nXO?=
 =?us-ascii?Q?s6DEEj/eYzfs6rC2ZGqJD+kPhHCgVxHGv3wrnyv9y28iIalMkITJkTRmVRfn?=
 =?us-ascii?Q?45Rd75RNz6IGnh6UsTt/GragoSZhyyJ1IObSUbFj0Xg7k232cZCTbhd9iCBw?=
 =?us-ascii?Q?5Us8hsU0RA3CyOXIPaDmkrY4DJvfrUVnsVZzulrqTifDc3CQeNIQtJp/fMkF?=
 =?us-ascii?Q?YamW2ZZEblgyPsYrAw9FgY9DS/57p4127eGVPquNpHLRxG0MwX11j9xUXNgL?=
 =?us-ascii?Q?xTcZNWDziV972SdJr7NypFY99sbsuHWhA6nVznRoPWQuFImnC/DMK4AMeAL/?=
 =?us-ascii?Q?wSqSDHOYZA44Zy19e7evjDHUliWc6fseUHPTIUKfwsL9MSSerH6N834UpMCE?=
 =?us-ascii?Q?E7IElZy7x10tt5wS+7/gNLU3RXYp76sV49z3yPU3AEjvFSgzYFw4ExF3APz1?=
 =?us-ascii?Q?3Aa9J8DNBU1RHvCo30o2OgeFkPt+CKf7kG9E9s+yBoVXy04d0U9XHXrHwplB?=
 =?us-ascii?Q?/oiKx7ojX6ZDpss2pokG0trzqd+ciiXkuW6fUlh0MOiNSpSYVXDEJkqUyTcK?=
 =?us-ascii?Q?/QBxZcuFKTPSLZJfx3vzxwKFSWMq4RGVSgr6eF0QjDRf+fBDDxkTx5Fz+DKw?=
 =?us-ascii?Q?piASCXpkTxDyiABqobgIOJrCdsAbEAsb0fGslHC5qEhEnmay8b41/UEWsx9P?=
 =?us-ascii?Q?CS9kJyPU3/rhALLIg+Evoox5xFy23x2ar68o7Fo7n3/O7gJ3/crRcXC7dE8Q?=
 =?us-ascii?Q?cIsJxdcXj8xw56HspjjreoudDTa0V9qBYT24+F7Ylw7RMskx9Lpq3BAMhopl?=
 =?us-ascii?Q?T7xNHzESdb3aniU/H3QZP0biQo1VZ0avDcAvCBzAehLh7oUDvajb5rVw7nvG?=
 =?us-ascii?Q?vBLQue9SyNYOZRyxqyU9ASwghCWevI2T45xotJsxlRoUy3Ld5zpDD5f81CEw?=
 =?us-ascii?Q?Hp/LpZnYA2Vt+bHnOMwKeJUiiJNKHO7tBa/thigxagKtmcw2wKDrtS0TiA0X?=
 =?us-ascii?Q?YiDZt9dTLyobZjDAku/vamFFNKPCiLIdDS9WTl+yU4Uh3ruFAbM9vuJl1qTz?=
 =?us-ascii?Q?iVXorZBKtWfil+C9avB9AFa3gTxmwylpamSe18I4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c902288-babd-46ed-28d5-08db510df2c0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 04:20:55.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T28J9QrJNZwoRIdOdm1gHjZHbQxHYLxHh/okz9QHndwBgUixzlprOA3qGvpvYYVRub2B0VRUnVhUbxypUpA2ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7146

To align with what is done by the in-kernel PM, update userspace pm
subflow selftests in mptcp_join.sh and userspace_pm.sh, by sending
the a remove_addrs command together after the remove_subflows command.
This will get a RM_ADDR in chk_rm_nr().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 5e986ec46874 ("selftests: mptcp: userspace pm subflow tests")
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 3 ++-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0737ddd62564..6aacffa32bb6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -939,6 +939,7 @@ do_transfer()
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
+				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
 			fi
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
@@ -3152,7 +3153,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 0 1
+		chk_rm_nr 1 1
 		kill_events_pids
 	fi
 }
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b1eb7bce599d..02465ffa075f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -621,6 +621,7 @@ test_subflows()
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip dead:beef:2::1 lport "$sport" rip\
 	   dead:beef:2::2 rport "$client6_port" token "$server6_token" > /dev/null 2>&1
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server6_token" > /dev/null 2>&1
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6"\
 			      "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23"\
@@ -660,6 +661,7 @@ test_subflows()
 	:>"$server_evts"
 	ip netns exec "$ns1" ./pm_nl_ctl dsf lip 10.0.2.1 lport "$sport" rip 10.0.2.2 rport\
 	   $new4_port token "$server4_token" > /dev/null 2>&1
+	ip netns exec "$ns1" ./pm_nl_ctl rem id 23 token "$server4_token" > /dev/null 2>&1
 	sleep 0.5
 	verify_subflow_events "$server_evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1"\
 			      "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
@@ -737,6 +739,7 @@ test_subflows()
 	:>"$client_evts"
 	ip netns exec "$ns2" ./pm_nl_ctl dsf lip dead:beef:2::2 lport "$sport" rip\
 	   dead:beef:2::1 rport $app6_port token "$client6_token" > /dev/null 2>&1
+	ip netns exec "$ns2" ./pm_nl_ctl rem id 23 token "$client6_token" > /dev/null 2>&1
 	sleep 0.5
 	verify_subflow_events $client_evts $SUB_CLOSED $client6_token $AF_INET6 "dead:beef:2::2"\
 			      "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"
-- 
2.35.3

