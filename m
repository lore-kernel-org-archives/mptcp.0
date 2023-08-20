Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3482573
	for <mptcp@lists.linux.dev>; Sun, 20 Aug 2023 12:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn4JWKrc5u02LQmMTRINlJiDnWzzJmuBpOPn7t+Jk7OLZhKvBUVDPFZLBIZzEyXV0C91EWCUdOrkANeV/gZoFyrPKfz0YHLznZ8ocfS6UzY6soBQiwo7nBEDXCtRwXeRGUd6dcL2tZGR7/4mb3chWjEY/3mIS7x8RWPqC2A2+2I/AEjKOVH1Ojgr9ORszq8X4ZPI8VvdN8eYUizV8p1fRoCVqPDpZrDfLK490KH8PWyeYBVMv2sx8kIL+nqGdd5wMSw+/WBT21ldWVMrb1HbXR+Qhs3UJkwKtmKs6HTYpX+4+OON9d2urX4Vh2xUAfJhC2MDIGB+XYmPINlFbJCVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEtyyDez6JxiffhT6nIaQUDzNXzve38ttlJmzXCkumk=;
 b=RnACd1UAtE7USgX7u/+/gxb5t05uMZZzulju2GvFpVIqOTjjWdJtxOpnJgV2Jg1eIqXxxBOyPj63/2v1XhIKr25MgLq8jERi6tHgXpW8/JlMZJ4uDG7fv5E0hSJwKHssaaQrT/iRnopO4ldVYg1lyzjGwQ1UNlI1JCIoiCsYH86FS55HSrDgegjfSU2ZpOHQ+a+4Tiud2oTed6eppjMV3Yq5UJan1ME0iLPunsnkE3I/9cMD+YZlyTAbc5VsDwudEsgLCjsBjDaEvtyuHgc5pObcv4z9RTETs7IRExgxBcYiJp+L9aa0inzrU/xZPr0r0/jtg6AHvzbGO7+kjjyfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEtyyDez6JxiffhT6nIaQUDzNXzve38ttlJmzXCkumk=;
 b=QPGhOOkv+vs46dhZjjbP2ln+Rbq79950c+FxqJ6EFIGlyZiSD7J37YQ5t+BjsLZvUX3wh+cZHz+hY9b0Yc5FQM7OI6/M8CDBDK2icqnMT8WGSKTXA752dKCxFVUDEzExJCCD/1hKl0S50FMCX4/c6An1F/aTiczpD4LBhWW8mMIKk58Lif2zRwnRTmkE0FhCFcPF1rMvhXulyy1if2ZdiBfw5V35UF6qQCYXs/J/c/rJinXLSaRet8ix0LGzslijUKuddSsXpTzprWga3kKY+0YawQEf0uw6MsN4Izdy/aspWJmEfRgZsHUWRhghx0tOTD6x3h6ba/wzI7E2VAk97Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9523.eurprd04.prod.outlook.com (2603:10a6:10:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 12:06:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Sun, 20 Aug 2023
 12:06:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 2/9] selftests: mptcp: update userspace pm rm helpers
Date: Sun, 20 Aug 2023 20:06:33 +0800
Message-Id: <09ea03a7bcb66a822ebc723718a95b2950b24f34.1692532859.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692532859.git.geliang.tang@suse.com>
References: <cover.1692532859.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::30)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: ab158600-76c3-4f97-e11a-08dba175e7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bwRmDrWR/pKeAcSefGogFmL42PCYYdwfLOCsRFxJ/lubSADpnZTHHOakDsqDZ9VQuC50q5L8YnfXSCY8tlq3O0BvUWSAClzktUTjPFPbZldL0EcyYqMuv2/oNuHaZBGGWFmDadRK3vh+S8Q7Qy0tfYjZLwJmlTsY8+gutw9AeGHo3y8dhVApkffuc8el0m59YJINGWmN0EfDmOrg8jNhVhZCd4/Lq11RIeu1MToi54DCE/WRlJzC2/Ac+sRbdWi06kRV3BP3qnDqhsYv3/jRXoKuApHs+IzKiedKICU+Lqkff7WzjtlD1nd8yW8Kx3Fr9Vkf7ygytOZIHdMtOFvG28FTeTsvQMfoHhg+bMNWVMbtaDG9yiXP1Fj6vMz5sKm7Xd1sd/gFhZ7xW2uYT389uAkY+L8qE3Kxri3QG7JTFXguo1z9niC2WZwb6BIY/bJg9yhg71Uxv29i6l8oNV/DQKALDDjYu9OWI8R+Sur6HH8CvYHqlxXlBx6G8lE7Xnkj/FXapyVB0vZKMUrmgzvmVBzgbOFFR9B7ZhZJI+ff8YJ3lMl1tchrUJzXXId1dQKsWvLb8LdKcLCFso3KcMnnIBKXRKqERe+vS4Rk9u2E9e8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66476007)(66556008)(66946007)(6916009)(316002)(41300700001)(38100700002)(6486002)(6506007)(26005)(6666004)(6512007)(107886003)(2616005)(8676002)(5660300002)(2906002)(4326008)(44832011)(8936002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SviwK69OAX/VNNuul8zdBveCAHNuqeedduwNON+fUDnU70rZUHzmY2ETrk++?=
 =?us-ascii?Q?iBC4l+fQkZxuoyMRmaD3FYbq1W6R2yDGjqBQ9GNC81BqnfZejnu4OtFeIvsT?=
 =?us-ascii?Q?ORQ9Xxhlcp5HdpF7Rq7fVklC7u0WXHsjlC0dNmxkPSAORzt2Jj2YXB7V4I6u?=
 =?us-ascii?Q?7Guys1HHLqfidI52hZa/q54veE3aP1w6Aebajm1WNYeuZl70lo7i4V0CaNt7?=
 =?us-ascii?Q?rhCVGn2Ws+73DxThbfg+8b9k7sOrZjzEoNEZ3oLes7QfIapZrWg0oGSP2JRM?=
 =?us-ascii?Q?uTEBL0ArVX+1ZvfPQsVUi1CFrsdBYP5niXHsEmR0bbofFLDE2Cs5lOyPvWOC?=
 =?us-ascii?Q?Fzu4ZfRjRlzgM5FPfL2TWpWexDDxPIDncDc9t9+GW6uhp4rA9Eu8EoXMMiw6?=
 =?us-ascii?Q?izn7oyxoAovkd4uAmMGKlg7xzoN2Da7OpGW8nT6RhXNnmyEaZm8A8TKbVUQ2?=
 =?us-ascii?Q?Fx+jEjwcX2UNp6T+3i7SwoWlxgpdMXdywPd3GDIZ95Okv66nMd+s0LE1hvB4?=
 =?us-ascii?Q?co+E3ss3cd+xOqox/+udmo4AdR0TB6bxOpeC/9nyNHe/Ru6DvojtHkXvoO+g?=
 =?us-ascii?Q?QN8BPsiIXyKUiLI3UPHq92pIdDJMRyVsr7vLImNDTsU7uuTaRdta0Kq1YwWg?=
 =?us-ascii?Q?wpTetG7RaJGhDQSvZH6Ksxt/VbOLDQcRQbgmoWJGMKSYUZFDS3FTtTo8/YUI?=
 =?us-ascii?Q?N1Bki916LZSfJHwbwja5w0u0k+aSXH/q+Lg/OfwKGtRaEiKVFN2J5A7raK7x?=
 =?us-ascii?Q?3n2lZOFovIXy/FuHSUoTbOaU+GQVQzwe28x6SgXiC9Grwir36q+acUqsW+pJ?=
 =?us-ascii?Q?9f+r++35YhV5o5EOK1tR/mdEgUuPuvWxH2m3L7L0imjqeXRtvEuh/ULZm73k?=
 =?us-ascii?Q?Yaftx4jA8xBuYJnwNbwlf+WECx0sTwrCT24tJNiKFvJaGzMu6Z2x6RIr+epQ?=
 =?us-ascii?Q?ZpoIFJFDO6ONhh6yylhfAItz/5uPg1s8vklOQC64ZxUxJyigcRW6VkxdKqCY?=
 =?us-ascii?Q?hX/rBdibjIPHpvnB1yKXjSP+7ttKfl0WwBLI/CHmVEiCpzqef7vTryUaTMVj?=
 =?us-ascii?Q?JK0O6IyHE/8yv5GtHKeNwCEv9eX2B4ynOcj4camI6JRqbM5lmM/7EJ+wrdh2?=
 =?us-ascii?Q?qsK+7QfzCmINznT8D4vf4GzbmLrFy8DkvlYCR8Onoy8WyeGlxXzJR3kpHjb7?=
 =?us-ascii?Q?W/vR8K2/u5mzc6c1mlno276IBb9VfFZ3MxpRD2LEH7+CwdYd5SZhcENCgiM3?=
 =?us-ascii?Q?/QHpkDQqGkecsIk7GpnD5Ki2EshUIZMXXkhXJHT0LADP4HgWvAlXOlGk3Qai?=
 =?us-ascii?Q?5xUdNcGIhgR0q1QkUEgof3ryPlCo1GDxFA9HAOkxGI1vPiDMZ3FHKIxH4dff?=
 =?us-ascii?Q?/c25eF+ZBJXlA9Nt38ApiT4AGtijBwjInUOSzM/zinTtyW8ss2HWY5yDzzNZ?=
 =?us-ascii?Q?UCROsg/MA/lll4cP7ONe3tRyC7I2j7XXsr3HWdatMXGGSy1C+r3TM5zR7qpS?=
 =?us-ascii?Q?BWgXdmjyzBQxhlxXWvl9dMkjz70bd3EvDDOKjWN8YC+WMzDWzdqkdcaJHaau?=
 =?us-ascii?Q?jKOaR5P6tQvXfbHPsyUZcyrkpM92kJoKx7Y8oWLb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab158600-76c3-4f97-e11a-08dba175e7df
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 12:06:37.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxJJ2piGBlDArhlV/ftjblNLdqZze1w//EJB0koeDKxtWMS89KWRPT4KjPrKIK6JtEacaSDPm1RRYJlW1pFxxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9523

Add two more versatile helpers for userspace pm remove subflow or address:
userspace_pm_rm_addr() and userspace_pm_rm_sf(). The original test helpers
userspace_pm_rm_sf_addr_ns1() and userspace_pm_rm_sf_addr_ns2() can be
replaced by these new helpers.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 59 +++++++++----------
 1 file changed, 27 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a0912b1d6405..0e7966cd2d39 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3275,25 +3275,17 @@ userspace_pm_add_addr()
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns1()
+# $1: ns ; $2: id
+userspace_pm_rm_addr()
 {
-	local addr=$1
-	local id=$2
-	local tk sp da dp
-
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	sp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	da=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-	dp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
-				lport $sp rip $da rport $dp token $tk
-	wait_rm_addr $ns1 1
-	wait_rm_sf $ns1 1
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl rem token $tk id $2
+	wait_rm_addr $1 1
 }
 
 # $1: ns ; $2: addr ; $3: id
@@ -3312,22 +3304,23 @@ userspace_pm_add_sf()
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns2()
+# $1: ns ; $2: event type ; $3: addr
+userspace_pm_rm_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
+	local ip=4
 	local tk da dp sp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	sp=$(grep "type:10" "$evts_ns2" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	if is_v6 $3; then ip=6; fi
+	tk=$(evts_get_info token "$evts")
+	da=$(evts_get_info "daddr$ip" "$evts" "$2")
+	dp=$(evts_get_info dport "$evts" "$2")
+	sp=$(evts_get_info sport "$evts" "$2")
+
+	ip netns exec $1 ./pm_nl_ctl dsf lip $3 lport $sp \
 				rip $da rport $dp token $tk
-	wait_rm_addr $ns2 1
-	wait_rm_sf $ns2 1
+	wait_rm_sf $1 1
 }
 
 userspace_tests()
@@ -3419,7 +3412,8 @@ userspace_tests()
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
+		userspace_pm_rm_addr $ns1 10
+		userspace_pm_rm_sf $ns1 10 "::ffff:10.0.2.1"
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
@@ -3438,7 +3432,8 @@ userspace_tests()
 		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
-		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
+		userspace_pm_rm_addr $ns2 20
+		userspace_pm_rm_sf $ns2 10 10.0.3.2
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
-- 
2.35.3

