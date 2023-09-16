Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5354A134C4
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 12:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiYwT3aXcQ+35SUbHpeGQ6X37xSXw/rSOed9OwIPD+vd08jdIuO1e0e9dWgdwHnqU3+aNKBUOecOn4qyr5uR/bMvd3QNSeB1d/SKvm5HYFWdSgvdar6z/Ced317Tvaxxxz3L0hCpmeT6pPG/Sun2IhdTB4+OVBy9uKz/wbzlLhSHVPiCQSnhE1i01+ECkKWeijqjygLC86YJhCfYfhSep2Ejl/N8Bi3MBTgz0W0Senlzy5eh6Fb3tQR5pFb4FE4MEvxud/C73sYZ9a/9f/zToHPpFhj/fSZ8XT8jV8hya5HfiZ0GewqoLle9iCFsI8wwwHEylCKrx4QxqF811SJ5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+7sU6bHLr7iCmoxRXGKuDMiRuGx2iMajuu4tSBvLsQ=;
 b=eL/kX3aXKVOz3RCa8ViyB80XrH23XS2RMeBnVA1WOUOB2ycKg9AZq1Qcd3KrcdUc8An5s4Y0qhITN5qlcKyZJIvHPvdbEt8oY9fJPjNRIlVE6bY6pxKwUJt4dok+/RRAV9EfPgKvyIZOfWHt7TZli4TjzuBdQp56+sby9q/2M4pOhi4N4B7iUBgYBqbepwdUumbXk01nbUgJaidEPicnaZUiZfK1N9ifs0NozFVL12iTPJRdn60sTC7HXlzlgduPijJYKnGp1dPhPBS7UylSKDgimJS91Mhx8aQN+GR0i4+2XseXcJ9QDtv0EMqnzDALk2gpyZL9ZROQRul6M8/cow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+7sU6bHLr7iCmoxRXGKuDMiRuGx2iMajuu4tSBvLsQ=;
 b=NxQaew3RGxMTL4QSxyO4tQQnY45Q6vtoPx563PJpqgJRn8ufcKo8KdHuCNBMmkaVYmU+6KC9+xhUNv4R+bZDWmkGSBpbNgoFDs0ysrhDXRbPKF2lvsW7aOzgbDkPZ4wFsGe5RSmLmiQD2Srxt1ZWibQNMK9pS/PfBD6cfgolP1QY4dImD6YfVHhkfLq4tw5pkeztoAoVyjlQhlPctvJ+pTrFFAKMZE55leCJWPJn82l0baP7dS4YCMX8tNNr59U3/FmIWUdnGR85Mx+JOkOuDOfbtQZnby0KkChYpv3UcU9t9tVJ44MXNelqbYF+PM3pIa4JYgwhJTjAkLvoJz2mUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8772.eurprd04.prod.outlook.com (2603:10a6:20b:42f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 12:05:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 12:05:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] Squash to "selftests: mptcp: userspace pm remove id 0 subflow"
Date: Sat, 16 Sep 2023 20:05:43 +0800
Message-Id: <c87d7875af17a433d99db6c4e253a5d1b70a182d.1694865871.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694865871.git.geliang.tang@suse.com>
References: <cover.1694865871.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0036.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b06048a-cdfd-4f94-eab0-08dbb6ad2b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9T7NPatbHVYQaqT+uUYkn7/PSChmumDhLHPotzzNkWQPrFrlmnttvmKxVZwOFeoWWl5bSzsbNJWgzHwfKaZr52GIfOkpo5GaNoQ5Xh0nbIo+rJaN3Sq+OwZJUtO0udCCzC/ZARoegG9m8s+MYu60c2nV2MhJwSulcITZg6Q8k6J3nneRa+lQgpx1Tl8FB666WuuWCPhV88lREUz+cpdiqtrsuj+fNKCdjgcwowGINEQpH1ZBIC1cJZ7r1xex92wm1ms118lAyQDF3s0/tfogRfa6v4vu6l2w0yU2B4NAOpapdIelQ9TzxNEoQRYri8HFpBqRpap3P28GBt5TIpSMeC2boZ8hOGqK+g+F2PwDI/ZphbtVrpvEpKIICrHFFu2p2Pl5qLCCx6PVE7Qe4jGwoE8rpBWq70rcHDGczwD/exy9F9ou6Lf7VCoHN2Unh4n9J0HpjZ87m4GriB21DIauLJWdX7xsFdj7A5EyBH58qNG9avnewI3ZnRP9NXZua8pkmbvLTO4hz0e7yYFTs9d8KCs12hTPrzCnbTPzB2iiWVkUCK+EV9xKRCNJ4irq8DlUfY2HJXNA5W1evLaW8JJT0N/qRZfda1tTYDDHI97fZac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(6666004)(6506007)(6486002)(86362001)(38100700002)(36756003)(26005)(107886003)(2616005)(2906002)(6512007)(83380400001)(478600001)(5660300002)(8676002)(4326008)(316002)(6916009)(8936002)(41300700001)(44832011)(66476007)(66556008)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zm1+fZRZEv/3fbqkKxC1lNi370sXOZZyVmrCXLU0vTrk4IwZ8oVXyN6nJiIR?=
 =?us-ascii?Q?X80i0sjMr3vxYHwg7JwD3b6R2ARiS2QbTDxyJOfN/fzyLwlgWP75X3sKSuiq?=
 =?us-ascii?Q?mjfrmOaaYotRFa8F58IRQo3W7x5VQKZLMWcSutJc2Gz8gtnwPYcx8ONUOJdX?=
 =?us-ascii?Q?Sq4M87ZplY5uygK/x0GCxNwskCOK+f5euQ8VxTHCSVErG0jBS4J7JUS9LQBL?=
 =?us-ascii?Q?ndxJprMq+PDqs7KewDQJKf+LgccdPxgVRng+WFsk7gArz8/FFEzii7DHoJl4?=
 =?us-ascii?Q?bmtl/aMoG7HAlm1GJ/BeahGkYLKIcl4UDRY6274GsFEEEhFMqTKrYE+lCjXj?=
 =?us-ascii?Q?aREc/6nmR6WalD82Yx/LSJ7//+1LmYAwhzpejIuvKZ5WHJARS+F6+I7m3Nta?=
 =?us-ascii?Q?ONmNYmwhdWBDHAilCvQRVwVlkRhB9lRlBSD1x6CWdWWMJ4ADnPbIyktOFGVw?=
 =?us-ascii?Q?C9uuCkd+V+8WPmMuLXiHnuWa/BUWhh2pJylrTo2xx3M/G7wjFoeZ5iAmcsc3?=
 =?us-ascii?Q?7tSIuRwuj3PsXBT0K1YzN1komqwm8MqSFvC0v3HrujhrVjPce0Ks/B67uYDo?=
 =?us-ascii?Q?08NLVrj48izJT+yXreMyjcngfNOMmZVHe4VdqWPmyO1+hGbBH5X1l7wrBhy6?=
 =?us-ascii?Q?0pFjcvXDRZg8/Lw6dIn8kJ9fP5ozjiHv8b4voVJnjiSkc/HBO2+tr5oDrwOe?=
 =?us-ascii?Q?0S0T8+o2ebnmCF9qI72+CQP098mQqUdHjDIST7Dz/KeZZYvoaDVbmiSmmIt7?=
 =?us-ascii?Q?tSHpxrgJaQw1I1O3Tg9dVxnzvcCE2oYYbvpQ4paL6DVX2ciiEeoWzy3WcbcX?=
 =?us-ascii?Q?tH4oBoeN3NiiGE42OIPUR7rxcpnnKJRgXzt30us9mKTeSzR3BSVHBkyRosNk?=
 =?us-ascii?Q?MLV18J5Jj2sEpvo9nvu6dBGflXxsFVshFP/jECmVmS1gVespCDIudX3xCsSV?=
 =?us-ascii?Q?T8e/CujqoWFefHwzyj6eNBof/VhTXmZh3vAaDh6rIONZpPwz2HBi6AsydGrc?=
 =?us-ascii?Q?GdosXWyUTlTXCX7A1BCRU7V0u0VuYaz6K9UMln17mCE20ORvBY8+Bol9YqUO?=
 =?us-ascii?Q?BBbWMZHeZYwq9c8kD/6BEXYdynGyD0qc3AlQLOA1pZhsx+Yr6kVx6yWlbgzD?=
 =?us-ascii?Q?/uY3265+QhGojuJWipfo6Cj/WZXj95MElxlBzDMBRxUmXQZ/UeqYOeYz5qRw?=
 =?us-ascii?Q?WqTlxTiIpY85va+6uD58ukAzbaE+TcmqjlqUbHPI4B3NE8TCpARaCibDF9/I?=
 =?us-ascii?Q?LhFLjuOQ8T90MgU9H1GhJa83vD9Y/b/97CI+fBu8bOVQl6pWeC6H4Sf7Qtyv?=
 =?us-ascii?Q?RxyyttGnbg5qhiMTq9SSoTBeZMcXrLLNSTBwBeKxvGwgcELgqtN7EMisdyBQ?=
 =?us-ascii?Q?Axzpi4/W9242JXwRypELOSlsxIzrj+yBiaWyEvsK57L94kEg2n5onxm6IA8P?=
 =?us-ascii?Q?6oJ5icDjZVgb/etsMI9EAys4XPVG/uUtKiwqaARx5XmD/X1J25w0w2tyrqug?=
 =?us-ascii?Q?O4Ov+HssHpVUEV/kzxeMPZXc8FhBvtRJDBhrtM+k/z3jdU+8HWsef17mM+29?=
 =?us-ascii?Q?7ZsH2L5flJG9dDB18rfln0ydXRegyRsVXaVHvIwh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b06048a-cdfd-4f94-eab0-08dbb6ad2b0c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 12:05:07.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzaQY0ScH0Dyv+Gq57JtuC0zXX2aqsHFg5RJHL8dzSpuz3tSoeWemHtNJAc0Z7CFxQStXrkdFUgSOYLrc342zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8772

Please update the commit log:

'''
This patch adds a selftest for userpsace PM to remove id 0 subflow. Use
userspace_pm_add_sf() to add a subflow, and pass initial ip address to
userspace_pm_rm_sf() to remove id 0 subflow.

When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
false, then tcp_disconnect is invoked. This will send a MP_RST to close
a subflow on the peer too. So chk_rst_nr() is added in this test, and
chk_all_subflows after closing the initial subflow is '1 1', not '2 1'.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 +------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b65a468e1ec5..9ffc8e061502 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1771,7 +1771,7 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	print_check "mptcp_info ${info1:0:14}=$exp1:$exp2"
+	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
 
 	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
 	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
@@ -1792,37 +1792,6 @@ chk_mptcp_info()
 	fi
 }
 
-# $1: subflows in ns1 ; $2: subflows in ns2
-# number of all subflows, including the initial subflow.
-chk_subflows_total()
-{
-	local cnt1
-	local cnt2
-	local info="subflows_total"
-
-	if [ $(ss -N $ns1 -inmHM | mptcp_lib_get_info_value $info $info) ]; then
-		chk_mptcp_info $info $1 $info $2
-		return
-	fi
-
-	print_check "$info $1:$2"
-
-	cnt1=$(ss -N $ns1 -ti | grep -c tcp-ulp-mptcp)
-	cnt2=$(ss -N $ns2 -ti | grep -c tcp-ulp-mptcp)
-
-	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
-		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
-		dump_stats=1
-	else
-		print_ok
-	fi
-
-	if [ "$dump_stats" = 1 ]; then
-		ss -N $ns1 -ti
-		ss -N $ns2 -ti
-	fi
-}
-
 chk_link_usage()
 {
 	local ns=$1
-- 
2.35.3

