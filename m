Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8C193
	for <mptcp@lists.linux.dev>; Sat, 26 Nov 2022 13:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7nr7qxlCpUfz/elVdLplGfAYovmzjH6w/QHpanRrhKME6bXIL8OU3xaHhR/X5yRFbn+9yGRwVsZmv1IHc+caxri70ps7OFfqPgo9t+YYnt4sFy/Wt3GPVwqjepO5V3Ch6jVPZr4aFaF65f0fA3n5fNNsefF455mGB0TnaZALkY04BoUvIe9AaaFeCN3r0hoPQWTkSYTZf+mLMHPfVRol9sHDh5dctwMdd7KRmMOatmhtfkeuubkfXI4rrymzDqENZeoogIuE/nv1xd9iuqDxvheFQXWY6xyNJDjrpIFP2c2WaV6vNo+K7AYKx1BcsI7K0erM2IeTCuFEM2lM/TyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7b/EQtAHglTxvI1FOcRGsg5nmMJHHBqRb5LiTGvwcM=;
 b=UUMf7YxH+4A1WGQrjm5amQlcUGHTelLYhm0mk5bEEkpIjLH27Z/ty+nbJtNOAxiC5GfELedhyXT51CU6ofQSkuANSge0PQf+tKn5cDlAMFFGHdezmNXCy/AKc9ScHNQlUHIHcagRnwGdrc7esQaHob5YIVPAVZP60k9+rWK/cTC5KpMn2MOQALb84WMEHP3U4l4zpvynkpZILS6odUpav6MWZ7FBXXzp56qj9yUeawH1gVrBGDloKyeAB3A6bjhTVjkEOvRdkZEvn8aB8U4CVJxkR1wkqS9WgYJMo2mG+hoIL65KHBgcVgisRPkFz+ik3n6dqJ3BdRScXlddtRSTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7b/EQtAHglTxvI1FOcRGsg5nmMJHHBqRb5LiTGvwcM=;
 b=reTDSxfR8LhoObM9C5m/SUAJxUGqq8PAPjEDiE5LBncsc+IByw5fScbch3JpgyvAUie2wFvPwOoJINLERutdaOstEY5ZfD1PyBHDjZ4dUGl2SgW0wJl+kss7SRhPKV2LxMcWn8IABrOswl9ZtdKfthuEW2kmlwxUmey31s+YJNisPVsojXxSu/OdXtUtnlNxHasnaTpMv06wrs2X7/3tqY2JfjDgIisAGdw2w5qdVI5/9RWMVHKlbmoO3ueRGbLZaE3EUvXvreoMs2dium2eNIazBACFlmgoNJeIJdYjAZgaNSAC+wqF4PC526fEt/6xtVBP/U89NLnBM9Euqjl6PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8083.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Sat, 26 Nov
 2022 13:15:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 13:15:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/4] Squash to "selftests: mptcp: listener test for in-kernel PM"
Date: Sat, 26 Nov 2022 21:15:22 +0800
Message-Id: <35f7d90c998235855500e6d95dbefef988cd2bf3.1669468340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669468340.git.geliang.tang@suse.com>
References: <cover.1669468340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 34783c25-6384-46eb-619c-08dacfb04626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZIs5Ohu3fBm4XOpETrYGiWabt8uLProE8A/8TPbRC1slyc0LxL+8h86n2IMXl5/N0Iplh2i+qLq35YlOaFdIXTNAG1e/5uzTbvQ/xNCqMIWulEhAQN+8fcC97YEmVhni2msc4oJa43jhgFbEnarD1epG6C8fys/8mmOx8RRzM3Rnjj6RlHF9P+kJv0sTz9gU2VBd3x8TJ2gYhR6vZQK3IPv9DspUKQf52Im/BqSDCCPFujl8Iun1r13Yt2kMvLFpIfJrWgiSm25u3r3cQMMCADyBZYLw87wA2GQ3ZnMMrcz7tmqq79PFu+rrFpYaCp4hbZLJsjSStuKd+ZnGiAkkTEZJ4h/CJHcn0sAeSyrK/JsLrvxfAWbLVF6ZxWJECUjUUyx6/cLhSo1kHOdVv2mK/LAaSPpet3HR/kxcIbGg/5k3OBeX066MWtoTMaCEwQokaZwXrd70OGTS03ze1XvqyFlU8MUiAxedvzOPRUrVx7Oh04KaaQW30BHwCm36NTaO4dE9puG//B2XpnWyRobFvTcXh9dH9eFdbTm0eNGnTxO8ZvDRE30zsjMO+A+6Kkr6iwipWLggH4YdXLqYsnb/sRMlH9zKKbp5LZhHkwCKMSdYuUFVohFHQcbj1Nvu6OzWipQSjR5D972jttj+DUlvEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(6512007)(26005)(36756003)(41300700001)(4326008)(8676002)(66476007)(66556008)(66946007)(38100700002)(86362001)(186003)(6506007)(2616005)(478600001)(107886003)(6486002)(316002)(6916009)(8936002)(2906002)(44832011)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hWvIJ35IOt6T8nwFzKXpXxSCumPsDC9fe6Dfi1Kq2r8/682QV0MaKS+JwYht?=
 =?us-ascii?Q?xo5MONWN1bezo6o8JwGSQzxERdd118PE4hiXJXi6yfumJLT0MDMxuzUcREq3?=
 =?us-ascii?Q?vWebngchl8kabXhIVhKssS+8V74UNjbftY+G1IRmPDbVqYfw2fCGOgEpZ31R?=
 =?us-ascii?Q?aGGRmo2U8qCebempwIdRKvIVePRZupCym1hsRdSB9JnRoAleQqHbBnSqkdsP?=
 =?us-ascii?Q?0IrDGhUaVnm7W+pnOtP6lou8ZBqxRw9p+m7Kn5wG9uAb36yo3C67QHcKaV9M?=
 =?us-ascii?Q?mImbaAIWxySBaev2TBJjsrQN3pTsd1KyxtfVsvaR129Hff9hW8PXxcF/xRd1?=
 =?us-ascii?Q?caUd7N+oUojvgOIrE3zs6fZx3pDMx/lBHsL5Lp+ZPoCCf4q7EpESqPhT3gJ0?=
 =?us-ascii?Q?b1rdpbPSX8R3vAeAvKb1tTALW9zugfDVOa5L7TJHWQO5Ul+A4XNT9ll7H143?=
 =?us-ascii?Q?3fU+mXQiFmsUjCSNTLbFI7u6G9U56p3Jady1hA/DyPKpql2RTJCKVXBrag9W?=
 =?us-ascii?Q?kFixj7q450iPKmTKDbFP3wFJJzOpOnXjCPb9K2miaNU7BCynfxvP+LnklHjO?=
 =?us-ascii?Q?z9egvsK5KGnoJU8qaRMahQNgaYdVzMIsepXr4/8CmXLBzQmMlzVt3WbvQnGc?=
 =?us-ascii?Q?hXzOsqngMz5vN3pArh5DUTKheK4GSz0p8xqsxkOFabPHm/Euocv8sPI8RWfG?=
 =?us-ascii?Q?r55hUi9iHm0Gkvr0j8oMlQF+ZXtj5BCVVk+l0PpA3g5yo4TLBcVIcBMygS8m?=
 =?us-ascii?Q?PQ1VZ50KNDT8qjTThTV2tKZTPrm1XhJQk0/wTRLnWcO6rv0Oj1WzFbqx6ipH?=
 =?us-ascii?Q?uy6oRHyipbbMnLxaI5J64YLKfZoHgC7BOjNG6Sn/uzqx6AMEFYjwiUNOtt7a?=
 =?us-ascii?Q?6AhK8mDV0O+xfif1rT6ai0wFzrDGvT8j/UGNtbwG7T/o/h4Kl+JL3six+WOs?=
 =?us-ascii?Q?oSx1CCCDub//V/zR+YIlI+QnzoDbjZd+QSVvOR7nlz2VvPtUhgWmszJmg8IJ?=
 =?us-ascii?Q?ZAHmoWih6RqzmyWCo/hc+7EnhGVZopi83fSm9TO1XT9EunGQyE1Bb7tXbCa1?=
 =?us-ascii?Q?nt4V9PDD4rDaeH9VbqQ8xjIWgbvi7woMEHsm9v0PKmwfggEgIxlExg7h9JA/?=
 =?us-ascii?Q?UzR+z6vpvcNhahYfhdFnZ/CAWB7o242wTulGI1A9wzvDUkhrJqllLj+HmyAc?=
 =?us-ascii?Q?BbRVpwBBy6TU2wbMA/CPR5H/XllyGausSbLT7lICQkVxEjpNfxmuT+Vu4+4j?=
 =?us-ascii?Q?2sLKdK46zZMKD5AXORDwQ5NprwmFYxy12fiYjfsre5/Why0Lk6WARwvXtwA/?=
 =?us-ascii?Q?zgjKZjxycz3R7OZTxw55hJwvEoNo2jZFYogCejNUrV7mk5/V49aDteCPq2xt?=
 =?us-ascii?Q?45rvYF02JF9NBrWcVCyGcgbyl+6oPQMQdbZChisF8wnxR0WYljNd80r4PagR?=
 =?us-ascii?Q?rGxvOSKdpe0oX7beeeRVvGIjtZJw4kCxeyRflmkFlGeVuMlNea0DxUfh/aL9?=
 =?us-ascii?Q?s3TOEZmgV7qi2zwzZ97RDPrNzgAkM/gTZF/pgt244y1MGk3YxU4osaIEp4Ng?=
 =?us-ascii?Q?2Z1uRUrj2DXwHqEqr1mY70kwHfSsiIlnMy50HOwJgZo8qh8Ag0BajYDA5+Bj?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34783c25-6384-46eb-619c-08dacfb04626
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 13:15:22.5866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuVt2Ul2zZkK5HMs7yc4pZ+txA/B0BJHwXLQRa1hCnASba7to9T2rk9D37glqLcV99ptvNF9MzIiVqQCtfvQvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8083

Do some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++++------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6c4dc890b71e..d11d3d566608 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2545,7 +2545,7 @@ verify_listener_events()
 		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
 	sport=$(grep "type:$e_type," $evt |
 		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	if [ $family = $AF_INET6 ]; then
+	if [ $family ] && [ $family = $AF_INET6 ]; then
 		saddr=$(grep "type:$e_type," $evt |
 			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
 	else
@@ -2553,11 +2553,14 @@ verify_listener_events()
 			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
 	fi
 
-	if [ $type = $e_type ] && [ $family = $e_family ] &&
-	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
+	if [ $type ] && [ $type = $e_type ] &&
+	   [ $family ] && [ $family = $e_family ] &&
+	   [ $saddr ] && [ $saddr = $e_saddr ] &&
+	   [ $sport ] && [ $sport = $e_sport ]; then
 		stdbuf -o0 -e0 printf "[ ok ]\n"
 		return 0
 	fi
+	fail_test
 	stdbuf -o0 -e0 printf "[fail]\n"
 }
 
@@ -2586,15 +2589,7 @@ add_addr_ports_tests()
 
 	# single address with port, remove
 	# pm listener events
-	if reset "remove single address with port"; then
-		local evts
-		local pid
-
-		evts=$(mktemp)
-		:> $evts
-		ip netns exec $ns1 ./pm_nl_ctl events >> $evts 2>&1 &
-		pid=$!
-
+	if reset_with_events "remove single address with port"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
@@ -2603,10 +2598,9 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $evts 15 $AF_INET 10.0.2.1 10100
-		verify_listener_events $evts 16 $AF_INET 10.0.2.1 10100
-		kill_wait $pid
-		rm -rf $evts
+		verify_listener_events $evts_ns1 $LISTENER_CREATED $AF_INET 10.0.2.1 10100
+		verify_listener_events $evts_ns1 $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
+		kill_events_pids
 	fi
 
 	# subflow and signal with port, remove
-- 
2.35.3

