Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2075.outbound.protection.outlook.com [40.107.14.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304823C2
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 07:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F11xVltNPBZOCa7mdmTcY4WZRgZVShu5QRUBu2yNH+JQXpSekuqEedHFhHnvLEOQSYLqNRctUs8F6CWtgPiPf548Um/ptizeJ+MrPMhVboMOxjws3/PNMMe740XwHKyG2kF3wDDDtZs+d3IaH0Z6Ch0Lcb23JnlsxQ70XkFP9gNyBICdamjTpa61yBxhcMMIEcS5GTXwcuG14oUgwBCYBwu2ctXBY6l+BdvvYaE6G08gqz+uMQ3LGmvnpCn/nzt2Oz3NZ83jhlTVnKWR3ccqugk1AkKZjIniIpn6SePozDimtydy839h4yFdgheugIpyDCTSfHm+uIY/IkEiJ94idg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EfCkrssy6+K6TWdQh8vo1wHv5UNkJXwm+eNA9B6Ylg=;
 b=X16zC3/rhszgleZ4Ekd4dwnTqIwzfvRlVpyWnMpAge6ezc5hlrr61QoKakWBMqVPbadbHShUcXV8qJHMqHPZVMZ0oOW025XitoqkdtfGNT3NXF0QY4QGxAlrTeg5PPQ3DSuQJ8HnjkGHOmg59QkPb7dRBC6J7Tg2vtZpiGzuo1JVJxM+ALsL/xTWU0zQiyHUNqU323ZKJyqZZjnK8HCNLvffKJbTwEF1aZwxD7FuJqoJRID0m5fEiOuVAbeVBdqNCKq6A/8NCanC/V1v7g9HmjMd65Q9nKT84gtbaS2QA04QX8UmBD73g25mwvPgunpG3bA1W5br7/fTmB0D7UldRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EfCkrssy6+K6TWdQh8vo1wHv5UNkJXwm+eNA9B6Ylg=;
 b=J4na+1BMKw03hUdkFgIg7THA+9Uhtw1qD3ewcSvQlq83GjaPWgbKSrqx0cfJknzFcolGxF1nMSnr0xDnyh4qXh/5WIq3aH3srZU/1Y46iP2ywsialTEqnl3EF2ixBF5c2n5Dx34wqeeCsQ7559SxcJd6Aj2fZpC7wth8KLE6JpUHAX0G6XQgr+zBjmi2cYTDpNExzHc0PqXD291I7XswhxOkD62zIhDBPu1vBfYToi80iHwoU48Qr9JWarz+wrIYPJZO4b02WlceN1lqPPOjLMAnXqOzc4NsVbj+C0z62k4lKMyiKmsIPKEWIK7wFU8qI5Emb6HCxnuW2mvNMoL0+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 07:32:17 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59%4]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 07:32:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 09/10] selftests: mptcp: pass fastclose to sflags
Date: Fri, 16 Jun 2023 15:31:01 +0800
Message-Id: <70cf8f866f114c950f14febf9c41f0f09f4ea5c5.1686900596.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686900596.git.geliang.tang@suse.com>
References: <cover.1686900596.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM7PR04MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d166f7-862d-4a85-b7c0-08db6e3bcffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a4l8eycCUqmzJfJBuZ5qMaDMOBHNBYB0xbYRMkcu/X63yvPkOGWLO7nNCkeNP1qpQL1oBQ+ERUdSlKY1XDOA2Gu4qFsRrBFeOWlP/cbMYsY6vDVrt1XyEiTPTkYVMmOvW53zRTQc2xpHiGgXtugz1pc08LJC7PcN2Gw8JhKq6hA+F/b2waV5+uSp3j8N30WPT/3Kn+k911R369ZTHi4efiMc6NapdDK2MYGXjrKE4s8pyDLhmeunTU/6AVRDFBxG+08AUhK4AQQg/PjYN28LumW9sZwrrS4AhPBkOII5GeGZhaSKi7a0bVyL9cgdqOwp8sFVgwTI9wyV3lBSny7XtAjUKdHcCQId4gF1LRq1WZxmJncbXxt1ufR8vZcCzZqcxeXpvLX3YBc35jF1tPgO5Htfnl6/+FCpf60qOO/vmgrr1DAZqOoIF4xqMXAKfVijtAUlZ6Gnj5OnslcEy7KdzI/qSR6BgDjI5JFC0freUc672IC4+aqlGoYEKLzZaLxHheKbHz5ZUQs4r52yQKT8zD8/+XB3HilWYwh5O19uZwMb9O9HRD/kvgqRnMQVgTEU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(6512007)(6506007)(107886003)(26005)(6916009)(4326008)(66946007)(316002)(66476007)(66556008)(2616005)(186003)(83380400001)(6666004)(6486002)(478600001)(38100700002)(8676002)(44832011)(8936002)(5660300002)(86362001)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wMZyKGPsYLFKMcYLZ6SWEuFUJUYkw0HJDIYq1GFpRuQDEb7cfeaHW/4WnKwb?=
 =?us-ascii?Q?hFHCfdYnzYWDCyugt+RPQDCa27CcWfdv3ymnD38vLQxCmi21l42Zk3kDi88z?=
 =?us-ascii?Q?lCShDP7PyMlEURgsBDSjLbfhEG0yKZIHN3ToXA/x4w7CF+vGkTlf1jr/ncNm?=
 =?us-ascii?Q?gYq3H5QCaWFnJYvBPTS5kNTjSOjsDtZ6mu6U8f3n9H5yVHsyxr2eER4pyvAx?=
 =?us-ascii?Q?JBmUqAlHhrcG4nDshzjTWHqrOwYhZQCeSbhB7Z1M4pnpejk9V6I9nTe3pawv?=
 =?us-ascii?Q?mgSrwL5o9vYxjOU6sB0dcKjXvO5DtxILqvHdLEUY7hPER6aEt7MGq/efjRfk?=
 =?us-ascii?Q?TeAN7CIXP3aR9DLoisigSuaw4L4jBVy23t+7p6vfboPOIJNDcfhBf4Rm9UG4?=
 =?us-ascii?Q?M8qDUlA+P6QuNstmD9MlV63lBEKlQkPH/Bf0k25m5nqhwsbT9Lc6qfWQpS+B?=
 =?us-ascii?Q?qbFNzs+6Ei2nNQPtp5I8h4wG4iFqNebgOxEop5Hm+itulQv9B3WyBM1Hx/6S?=
 =?us-ascii?Q?KFXxLfbx+Ixd03thvAcnOSEmT1j3qYW3iI+Ut0WR6x2dNvFN7A9xYL/lav9M?=
 =?us-ascii?Q?9y5NEzC+cS2qVMXp29gNQtGDkstLRIaATMmz5ept31bBZ1G7K0I2Euj+a5tZ?=
 =?us-ascii?Q?SqSoTYrSc2GvrEG0turLINtuv+JSVenl9sYdCJxuMamFYoXn3VFOXu7o/WEY?=
 =?us-ascii?Q?vOzTnuNSdk52v6mbSCERl7nCOtvN8r9k23h6E6gWeaH/x2etuwj6yDl1r6+J?=
 =?us-ascii?Q?xVOpLe+0871qrT60a7YNbSbN26K59eytDk+0D0XrJzZACOsYKXVj98GSp2pd?=
 =?us-ascii?Q?FUXVCXMZurZIrw7rmVAuc3oNkYIry6tUzgSlDZuYXMFEV+4NVu74w1W1iz6j?=
 =?us-ascii?Q?NjRGXP4OtuQ1nSvQzKxhj9w7EBimi82mpv5pSxezRoZmnx1GJj6QlFKJ7K+D?=
 =?us-ascii?Q?yZml+BhDze5n4lJRRcDw8fEK2xga8VQQFPsvHwWdT0u6uWwpBem3Nax0FRVE?=
 =?us-ascii?Q?D7S+9Lw3I1l0K0mMGs/GoRnF/dQlhDvP1zPkZnQOi7CwLWp4/nPjdIUggFE8?=
 =?us-ascii?Q?mdY1viFLuNT4ZWDPt6Fv2KLD26LpSUbqhFyeqyYtvRz2fzQExduRiEGmY2TT?=
 =?us-ascii?Q?IqxUsjtqmlDXqddqO36bD/g6mN8RsjJu8c+oIRGE9pOBamcl053DI1L38g9L?=
 =?us-ascii?Q?t0Y8vsrJbbQFZnSqMgKT9aSaHBr5dn2sEHOoof8LSiVvhavdOR1KhQsHGvP8?=
 =?us-ascii?Q?W0U45qRgJfFR11eBJV6QEIx0AV+4jZKDfZbpoq6KvAHyCyNUs4j0i0wyqmDz?=
 =?us-ascii?Q?kDqKWFlZuML7Og93Nh7AYS68ITWLgZm3zRIJcOP6X3REGhFESRC6VymcXgPK?=
 =?us-ascii?Q?pbxqKiCjFAKSi1TqrOwGiKW+6QYLys6lAOgXDz6UtkuPrryiClg4D1S2OGXr?=
 =?us-ascii?Q?OGirdjTyEystZgJfUlI0lIkJpeJ8J2Z+xpkp6SSPiQ+X+AHcD44v/YRxX/22?=
 =?us-ascii?Q?zsjxMtR+eutGtQy/Tg6TAFr15bmyG8jV6fkpE120j6V7zTfEgf7xXAgGVDYE?=
 =?us-ascii?Q?Eul6FrKyxPRp82TDioXrrlDuVA2sQNr/Rib4kzjm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d166f7-862d-4a85-b7c0-08db6e3bcffc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:32:17.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjhijTv1yHoB0zx1hPSs+NNsGqU+vzVffMXK0+ITEYXHb4lOS8W+Kj6156vTKfyoGZgotSJsP9inNQvYU9BDqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7157

Pass fastclose flag to the sflags argument instead of addr_nr_ns2.
Then the fullmesh flag setting can be moved into pm_nl_set_endpoint()
from do_transfer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c3c8471f9ad1..89379815b619 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -828,6 +828,12 @@ pm_nl_set_endpoint()
 	local connector_ns="$2"
 	local connect_addr="$3"
 
+	local flags="subflow"
+	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		flags="${flags},fullmesh"
+		addr_nr_ns2=${addr_nr_ns2:9}
+	fi
+
 	# let the mptcp subflow be established in background before
 	# do endpoint manipulation
 	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
@@ -1015,11 +1021,10 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
-	local flags="subflow"
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
-	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
+	if [[ "${sflags}" = "fastclose_"* ]]; then
 		if [ ${test_linkfail} -le 1 ]; then
 			echo "fastclose tests need test_linkfail argument"
 			fail_test
@@ -1028,7 +1033,7 @@ do_transfer()
 
 		# disconnect
 		trunc_size=${test_linkfail}
-		local side=${addr_nr_ns2:10}
+		local side=${sflags:10}
 
 		if [ ${side} = "client" ]; then
 			extra_cl_args="-f ${test_linkfail}"
@@ -1041,10 +1046,6 @@ do_transfer()
 			fail_test
 			return 1
 		fi
-		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
-		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
 	extra_srv_args="$extra_args $extra_srv_args"
@@ -3186,7 +3187,7 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		test_linkfail=1024 addr_nr_ns2=fastclose_client \
+		test_linkfail=1024 sflags=fastclose_client \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
@@ -3194,7 +3195,7 @@ fastclose_tests()
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		test_linkfail=1024 addr_nr_ns2=fastclose_server \
+		test_linkfail=1024 sflags=fastclose_server \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
-- 
2.35.3

