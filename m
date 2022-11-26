Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2075.outbound.protection.outlook.com [40.107.14.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1390D193
	for <mptcp@lists.linux.dev>; Sat, 26 Nov 2022 13:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/KICPjVGNFEavZvoap2pWKAJb61F8okL43X9201VWnqKAGd6zS4lQfCDhKyyeFFUAIToRJzUkgqnAtrGP1xNhOSCLAP7uILbcqCFnGeI1x0i2TjA8KXv9mSk35MG2nUAYnhMTvhHaqzdvrAsMxjNIg92M2RXmiFTW/OPV1kS7AB5NERRnCZzy2l6J2LP+o4E8LGr9NnuKXvHlvBhkXwve+C33XK3RjznjDSvG9TN/POnYIdT60av8e8IY7IOul/jRqs/XH+75PSoSXX2lvA5GOFNmIxzyiNnl79kG6bIGGmEL4olI6bRf8tdG9jqmKLYjr4sZ2ARwEm4l4LBoMbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je5ZH6fxyEMpdU377mEtLmT9Nve4QKMam4DdBaSSODk=;
 b=de6W/6jMT854LYqO5HqScKekIRDFFtEsBbJtidmW9itYxYKl1XlHVA5IixHyyYdSaEVViSoCT/o4rVitc7bboP/HWzcmthkgsfg8UyQc7q+6ImJr6iuMqWaWGiORq2CY1GqaCd4Oh15sZkDlK7tm40iI8Sf0GgdWGArad865tmAhIFB6R9yU5l/F30ya2OQrJ7sfAoU2K9P+LAd9hIIMjdnGD/QOIYPVGGHR980GKE8nwQXuTZ+yynQVir6pgMiy0J1NDxYwOMHX6cn3rGJFf7VKLRKhuuLI2DW2zPvPlArB7kX49WBCVFrr4u7AbY2Z64sLJRI0+FT4zvk6R8mChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je5ZH6fxyEMpdU377mEtLmT9Nve4QKMam4DdBaSSODk=;
 b=Ck2o2JOCrnOxa0F/vQLnms3WRlnqOb9/BLYGEXiTy9Xg1BpWizNBmzXRu6rPN3Wuh/CVZaXx0i867IBg3TAHz7vRmT9HbTXC8fIcI0Uc/VSOefI2E4VRq2bCl6iYhCTSP8PZVI0DZ/bc1095V+jZICfqmLxxwwNUPK84qZITpWie9VOxU7AOPe3yFiDYbZlff2sa6ngWfujKPvqJ9mjRtIMIM68rSEnS1wf+fBqY2/pBBfUb6/z1CvKD+HCMBMb8n/OIBsR2clAowSHhL+PPYfTSBl/noufc1JsMpII4WGgm0GriPoFDUVpaNsf6culuy3E1WLMFziYNCOVJ/hWejA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8083.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Sat, 26 Nov
 2022 13:15:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 13:15:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/4] Squash to "selftests: mptcp: listener test for userspace PM"
Date: Sat, 26 Nov 2022 21:15:20 +0800
Message-Id: <8b35483cbb565d772293c551740a323fa741f989.1669468340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669468340.git.geliang.tang@suse.com>
References: <cover.1669468340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: b936708c-3e84-4a91-7f33-08dacfb03d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QsozfYF+xM2PUzotwNfJuqPN1wjNdNlq0is5gk01CRwaQXRQmroQxfBu3QmI792CAGW4MCKOsmvb4N0PIn0/u6XdWBz7r5SUOs0irVP4Ptg2dl5Zx3uYbMv7x+0waja0nMgt8zoRb4MiWEs0+F9a08Ta6nvdbVNGy15qn5+rms+rEwsEV5nCo5bzbSXdacmo9EKf0apl+PXwscW8zWStwOudLOuXHeQm/KadDwk5edZf2ULheSURtv5/L/+yZKcr92uBQE7gXF8Vdyyyo4sE8Puglob1qOKwy9jf/ObdswayPUX1RahwSLYC9+3pikVqbTl7Z03M3fenbr+bM1Ti5QKV+kO5HPBaWkZzFYdMgWb/Z0qda6Mjfjr6nqkJCJg1e5v+eHY3yywMu8t65L8GGyS/UcE5W22KeYW1BHrcwBn0CtszOxmtHVJG1DBarIo4gRP4GRLwwsbI0t1npY+/MWbZwi0GGtP5maRLge3yRtNUf1pYiLjnST/AyiM35MAgjL4/F9abvAp4KMQU6kdA//Pv7OPqxQr8c76nKzC2vRrqA4SUwdH3P98yB3u+k8LZ4WI3LJ8PTK2C43k8zPKnVDNbwds6J0zciGeEv3g1gV0hK/luEoXz+l1bT14CpgRimpbpGmXa2XVjUIlC8ntlNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(6512007)(26005)(36756003)(41300700001)(4326008)(8676002)(66476007)(66556008)(66946007)(38100700002)(86362001)(186003)(6506007)(2616005)(478600001)(107886003)(6666004)(6486002)(316002)(6916009)(8936002)(2906002)(44832011)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YpbI9rdxf5Gg2pfY9Qa53UoKva9ebvogJc1qxJl88NdGfdQlOGRgwk91/4HE?=
 =?us-ascii?Q?YfuFz3zF12jYUmYOWwWNyeATx0FtHFoXjBvkW2Xd7IpYdwBy+q/q5j7j0cK0?=
 =?us-ascii?Q?JYIY9Yk1lFGLLDmrpDpAcO3XJz32lRCSyHNjfKlts0ouomk8jnH12Z3YptNA?=
 =?us-ascii?Q?9TS+9d4kcJBTu3I4aVvAbAu95yInR1dmD0WyaWm0+DXqk/uVYx1ZWIKUD8Qb?=
 =?us-ascii?Q?21dXltxw+qatT475NyntkjeKq3avOyuKXZr3i/kHuCLFMqsmXDwd2B4HZ14Y?=
 =?us-ascii?Q?1OmNWeGVvgsigV3Z9J0SwMdrbM9C9bTqALZdPr/ZQCbADQ/WzQ0PDJgYFWeX?=
 =?us-ascii?Q?QpFzlb/n0AjQKVyUZr8+RESgpXlrXSpBEbxiZyz/gFM6hb+g9o764VJxXxdq?=
 =?us-ascii?Q?P2D6g2dsNSqW1yS2r4sLxKTukSQ0vvoPZWCKxJe3YM7Hr+X6/uPUhH4N4ZdF?=
 =?us-ascii?Q?VB64/JaXOs0ehnZptNV5bzjbtFQhEO78SiCurUU9vvyM05ZJ0r72+yLCYxcY?=
 =?us-ascii?Q?rbpY+BqiOtV/hGzOdTNHlADzlv8xrA5WBGx6Odque625i81UOYlBwz6KPGXP?=
 =?us-ascii?Q?vI3eQO213m5gowC0AACKGZ/ezjD3f6224T98/+2HUWDwSW3oGeszzDUmzmgc?=
 =?us-ascii?Q?yi3fkipgjtvT8ET2WQPEViUOUizC9iEu63e3nrebfD+GzynySEUjnaci9zw5?=
 =?us-ascii?Q?eSAaZK+JCMF2mrrThSiU73hcFo5Vy49M7LtE2sFLZoEhoOCw3mRgksDPv0gd?=
 =?us-ascii?Q?CVPV1235ZALNsdPQAqZWfxUCQg9cd+dDT6RpIfGfBoA4MX4NKAz62vHZ29XD?=
 =?us-ascii?Q?DWqY4duWdUcdEWLz2uWMfqGGur3SKzrPOhbFv8k96hhw4hFIWM6y4dwc2fqw?=
 =?us-ascii?Q?WK/mM1SEwyL7nmotb02vpqC/gtCG2MLUKAe05K0ff2Of8DSrLGaJyrlQyEUh?=
 =?us-ascii?Q?IugC/N0VWl08HvPeMFDs0G3wNovtDNeSyGXs2Y1ZjYDIoq7rLHJ+D0VXqb2H?=
 =?us-ascii?Q?Hi+32Ct857AcbmN9IkDfm11U5nOjpoajQQNKxe7fWZpEZYjsXPjWYci+WZLt?=
 =?us-ascii?Q?YW2BKYn52CEoQCPtqapaUULfDcB8UPbgwEFeJ+0tO3J1Ppc+97Y41wjsEHef?=
 =?us-ascii?Q?XCMfCCKUm8GCrUFMyxG2EsZugtIWrRyaxCIEevSqiKhpXshYN0nqySQP6cMW?=
 =?us-ascii?Q?2hFnaPZGdt0lR3InvqDr7Rk87JnXFAqmp5u54Ax9V0BetA5GMZUCgKbZstVY?=
 =?us-ascii?Q?/LWjvtpK4Jt9l++EZohQwTNgigBO5A4O9eMnYlLAxrWEjtmDobTHck0RkSkH?=
 =?us-ascii?Q?6V+DfaFnqE3JL4w5gbNdHMWbnfEeW4dC5yz2keAbJOxM31spDeMRGpVWtjoG?=
 =?us-ascii?Q?MKB8QhwSWL9rllw9+B7Pr8Z+wMtoolO/kF8pcWGcKzvvpTz29vn7sL2DSJ0e?=
 =?us-ascii?Q?ZaNno6RUevmo96WSnq+T2NKXZWfcqvSaz3kxxf0gMvXMlycJULfysvs09qAl?=
 =?us-ascii?Q?BwXLIJxTzra5fKT69pdkK2HZg2toAFlEf8qF2dom1gdVnNKmBnAteEj5CWaI?=
 =?us-ascii?Q?PXYGkpF/+0HuRPWzE0KaTbcZjdxbY96IJM7gTkfQ02gwzDUTJbp8BGOCQEUE?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b936708c-3e84-4a91-7f33-08dacfb03d78
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 13:15:07.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hv0/hxgaoC4DqUeg/s/fiAzvqyg6tWeYbODgJMf6TCptJprQOkhoczyoJA3E+erMGh8G0nG3G3bqQ6iC/aPeSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8083

Do some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 24 +++++++------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f21da6119ad8..d7e8389dc192 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -808,7 +808,7 @@ verify_listener_events()
 		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
 	sport=$(grep "type:$e_type," $evt |
 		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	if [ $family = $AF_INET6 ]; then
+	if [ $family ] && [ $family = $AF_INET6 ]; then
 		saddr=$(grep "type:$e_type," $evt |
 			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
 	else
@@ -816,8 +816,10 @@ verify_listener_events()
 			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
 	fi
 
-	if [ $type = $e_type ] && [ $family = $e_family ] &&
-	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
+	if [ $type ] && [ $type = $e_type ] &&
+	   [ $family ] && [ $family = $e_family ] &&
+	   [ $saddr ] && [ $saddr = $e_saddr ] &&
+	   [ $sport ] && [ $sport = $e_sport ]; then
 		stdbuf -o0 -e0 printf "[OK]\n"
 		return 0
 	fi
@@ -827,20 +829,15 @@ verify_listener_events()
 
 test_listener()
 {
-	local evts
-	evts=$(mktemp)
-	# Capture events on the network namespace running the server
-	:>$evts
-	ip netns exec $ns2 ./pm_nl_ctl events >> $evts 2>&1 &
-	evts_pid=$!
-	sleep 0.5
+	# Capture events on the network namespace running the client
+	:>$client_evts
 
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
 		$client4_port > /dev/null 2>&1 &
 	local listener_pid=$!
 
-	verify_listener_events $evts 15 $AF_INET 10.0.2.2 $client4_port
+	verify_listener_events $client_evts $LISTENER_CREATED $AF_INET 10.0.2.2 $client4_port
 
 	# ADD_ADDR from client to server machine reusing the subflow port
 	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
@@ -855,10 +852,7 @@ test_listener()
 	# Delete the listener from the client ns, if one was created
 	kill_wait $listener_pid
 
-	verify_listener_events $evts 16 $AF_INET 10.0.2.2 $client4_port
-
-	kill_wait $evts_pid
-	rm -f $evts
+	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port
 }
 
 make_connection
-- 
2.35.3

