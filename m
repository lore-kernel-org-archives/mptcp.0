Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20054.outbound.protection.outlook.com [40.107.2.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F917E0
	for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 05:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUSRkblmwaX10JmjRUWHNrh9kU7qyzhXbWYOJYt/gziw+Auoht5lSngP5rDhcmxXOmuktfyBxNagK9nA+1RcuhuZ31hSUZZItJOBMnX40YBJMhK45/dd+lfXZQXS430j/aL/GEKSxVrB7qN/bHpeQLm7Xa53RtgRThcXW2WA7bcovs5AYdxhaz4AO+mDDUWamZK0zoI3Vuk47RHfv/dzzQdQaxUf98MfTc6zEBm+r5tItRoNLJDFXiHApaDBGgP11ArPZKxYU6CWWlW/aTk4NLLm3qoA1zOjEx2iPyomc1F7K92sA/ySBDBuVWpoM1i20HMoxst+R8QqVH5bsLJFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDN/WaOXBhD0amBFC4D0WJxSjVfwDVo689M49l4QnMo=;
 b=b4PioGLBHBc+5IOyfkUeTjkx43m06UkPq8mF3zUPZRr0VrZhsT0d185V2RjBABUAINJxDgFkOiczUJuE+XqvkvYwnjsDrFsGyEBlU4PejuUxtbIIc+QRIjQnF0oig5pHt1F4QMeGT5W3EjmdY1OphtVkugbPVHVIkxK9XtFYBZaDIapfMa3n2H/lUJR9IPpM51KahogEY3V8FxsDSBu3gl/yvloDUzCM5XfYwVwoGCknYZDRlIgSZGBq3JS1PnXybg0125N4v8n3ng1dRuWbNgQRJM1xPFkpSY+OdHysXBQKv1jeNlAHvbhUwhJQ4Kc0usc/twbl6Q9GhMmh+wGrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDN/WaOXBhD0amBFC4D0WJxSjVfwDVo689M49l4QnMo=;
 b=166SO+lR6nThiFmLu0qtFTzG8WsqL64rKNOUt0JPjmgQ54u7R7HbzGpXAOII7x1TR7Ns+AYWYO2N6t9nNaPew/i2r2K0NrdivQImjqUFCYwdW75rxvejC56usqSFxwFLhy8HP1t4dYjUc3RHlx7G0gb9PA9LD/+pNJ8zdTbCWSmmN+OAEzjoKLYiE5Ao0rk3GmZLvhdWMgk7LRZ1obSnKBvgtNlZZ5CKrAu7ouA3KlGoZxnL/Ru1Q3AVWkD2ZvBeXq8XAi7gUyW2P11h7gYowXS8RAlrQLesW79oTX3LbRphn3OHxF1C0DQfmB68eV0Zzi8wy+Ahkl75rn3DTZy7Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 17 Nov
 2022 05:31:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 05:31:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 3/4] selftests: mptcp: listener test for userspace PM
Date: Thu, 17 Nov 2022 13:31:33 +0800
Message-Id: <25f1826e79124415086fe3d6ceb139e2ec80a756.1668662624.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668662624.git.geliang.tang@suse.com>
References: <cover.1668662624.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc1b97b-f724-4b62-1aae-08dac85cf9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OXnM8Q4se068QbIT4Er+mrno8EJCFxy1TYSSbQAdTrnxJO/40Ddzp/BDYtL2T5a1h5tw7IyHyQq14bHG3j7pK1TJJ514sBmKquMIoCLKFnlZEcegsSgeKY64xqUz7W6o1EAYCZicC7M7AU3NzWsG0RVP0HOuhHipAG23mre8ZuetBPn7NlBhaeM8ezm+zLfPzSfHyRPC2BVUXZz0Xz4q/ZQqGTLiCUcufQxixVkWc35sohk9L76sA7Bjvi9yAySMZ72NpcnZ9zxzxCO1jZA0zyz1/Zi/lr6RPIKIgr8TvxFkIL+GhUdW39Kix+Gpwa9H90QXqVlISaQJFcx4t7hqEcJPKdKFbEIJZoDwpGkgYRhNuYKHMlXVt5qv1Rm/6VkExVp+T7w6QAmNrikR7ewfM/pmd/UplUWmiYPa3llxmbmCuNYsyPQfDQmzfur6WgFPZIOn9nUeEzhm/4fCJ/3wvi+dBPmajVLzzZgvLl4pfS86grmGSKgmqKCPc/P5aUthxDHc/w9ejLtrQf1DzgWbi1tmOGJSjCeHFf/iz+1C5/afyXFKJkAgse1hG+hIDZeXjElAmWBREEOlBQryk3EUk1vyVdZAUx5J2DL1i6yGnH7moKkHUETJNIzg6zdSbhRJ3I7E7yk8I9okSijH1MfDHw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199015)(6486002)(478600001)(6666004)(107886003)(6916009)(6506007)(316002)(86362001)(6512007)(26005)(38100700002)(66476007)(66556008)(8936002)(4326008)(8676002)(5660300002)(66946007)(36756003)(2616005)(186003)(83380400001)(44832011)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6px1YA6XyveaaoA/1nIM6Nn3IpA5rYSeRekjbtGHMOv5xosTZ5jvCy6ay6u5?=
 =?us-ascii?Q?I09/lCNff/BR67IkIyKUHNdiG9QcGbSsyHzs63Ga0DITJtRSisL93LFBrj95?=
 =?us-ascii?Q?IEONruPCyTFJVF4S37Ym0VuJWKLTZDbm2GxpGKYeiX1qxkMzspBaNXnLAW0v?=
 =?us-ascii?Q?62QVnXkDaZvKgCJ/XAmYdxQ564XfqyXYapQvExLGdzny+l0pRQ8TRt2nUBh/?=
 =?us-ascii?Q?Utzzymu8kYiw5iq3H4sotXegBbNmGswRKn2/1IIGOPT0y33c+DJyxEbhCqZs?=
 =?us-ascii?Q?AdhbVYKh9s5Iy4s/PjTrxsitgnJGd7lT/bJ7awK5XMq676jVkA0N+cgrPPBH?=
 =?us-ascii?Q?/IfK6H/KMFtBs99+zLLxXsYmEMufrddOe37yWRRHWkN7c6lo9TWvG2k4Z9dU?=
 =?us-ascii?Q?qbHMnCSUwh+OOZYnvYbbPi/JRVmfN6PhI6VBIT15F3joMUOU+CHXqEt9psGU?=
 =?us-ascii?Q?2f/XUmWrAjdqPutjwjVqWRMllyiELCkZPMzBJZVwKJd9Ah/teGW2KWse1pcJ?=
 =?us-ascii?Q?St5H2TX6BoSm3Idqhpdx84ILbm+K5wYpcYa5B4oCCh7THs5INaGkrlUuT/ot?=
 =?us-ascii?Q?9MY2A80plu54vyD6xbUQTB1sD5sKedWRvOAllFhFTnRMwbrdK1fT80hT0FqD?=
 =?us-ascii?Q?0CytRmjY/RF4hiEW9TQmMB0VRzv6lgac1FPLNXRIKQoRepX2eZYiWkPMgjyu?=
 =?us-ascii?Q?kCEO8XbKkzjM0z6bRM2E1etZ3/HismTTIyBV21pWpgLaLzjCa7zxYJ7uSDWw?=
 =?us-ascii?Q?iZk1CBriMKyFfzAihvI2ke0V4kxPNONYJNVGRhZNStc1yTOebjPleXH1szI3?=
 =?us-ascii?Q?CPl1Q2FRW+O+42or4NUN3IziNMe806IZBuSvlX0oOQwowkaDDWmvPKEYTbCo?=
 =?us-ascii?Q?Ez6KrKmaVBbkwOm11I53VtKSws/Wvd6oeOi3iLfyl4T40HRzgz30/qD4rXvz?=
 =?us-ascii?Q?FM+DRmUTjsr8YePuseAzBEGmHg2IeTJyqYEJzfnoNvTGvfrUqvJB01iZ75mA?=
 =?us-ascii?Q?MWwqrnc1NVQi5xdaBMGQzOgV82QguhZeyxR3y439N9FFOzvhQxlapZNHA85P?=
 =?us-ascii?Q?X+vxCqewkYZ0+BdJw8VQLMcu1QRjIPDNeaYpLj1RjhpvnIx6YMRQ1Uxt7zzi?=
 =?us-ascii?Q?MCeDYSCOJqx1axnvWL855+uW5tCAx3bHV4iKsm1BnrOeVfqWLUXd0ZWLvn8o?=
 =?us-ascii?Q?f/PTBC8d2eM6a53c/xjkGpGRr4bWmmPY944RtyHIGny9AHV8Zkcbgs3UfRUS?=
 =?us-ascii?Q?RdU7s3I37ZyiOKs3fWVGOMYNh8UEfDeq9ZyANH0m1uLg1Su4Qm3smNu1QKuB?=
 =?us-ascii?Q?oY2uwYVvrlezuLhtYU+kbrA62IJvKC2rBsjjs8t6odcOhYJlSenWoL0YULjC?=
 =?us-ascii?Q?uwxyJ396g+J8ARYfYs+4tERMdgkGj7QHBgaGMaisJxyHt64hJxIqICLzZMok?=
 =?us-ascii?Q?6IUDuvVb+kIrikN1S/8IpKgOFmdf8/ye9TIA+7PI022zb3AYIw9Aaghiert+?=
 =?us-ascii?Q?cdQPVNN6K/h0d7teozHo++WkFGJ+6l/ElCXqdRKONwfNW+UyuTiG83TZluI2?=
 =?us-ascii?Q?kmihjo5+4e/Jc9TKNSWii888TWBoX9rIJm+g0h0gSJ2JihVUY3JgJKUsFk4j?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc1b97b-f724-4b62-1aae-08dac85cf9c4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 05:31:28.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4GtQlsvQZ7v8RHuUc/GO7ydcLh3+iuq0uhDlZ62+GEurLwA8vsgRdnbzRV3zyA1iHq4jWvrE/wDj+0n7O6o/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286

This patch adds test coverage for listening sockets created by the
userspace path manager in userspace_pm.sh.

It adds a new test named test_listener() and a new verifying helper
verify_listener_events(). The new output looks like this:

 CREATE_SUBFLOW 10.0.2.2 (ns2) => 10.0.2.1 (ns1)              [OK]
 DESTROY_SUBFLOW 10.0.2.2 (ns2) => 10.0.2.1 (ns1)             [OK]
 MP_PRIO TX                                                   [OK]
 MP_PRIO RX                                                   [OK]
 CREATE_LISTENER 10.0.2.2:37106				      [OK]
 CLOSE_LISTENER 10.0.2.2:37106				      [OK]

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/userspace_pm.sh       | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 08a88ea47a29..40801279ebdf 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -11,6 +11,8 @@ ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
 REMOVED=7          # MPTCP_EVENT_REMOVED
 SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
 SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
+LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
+LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 
 AF_INET=2
 AF_INET6=10
@@ -808,11 +810,91 @@ test_prio()
 	fi
 }
 
+verify_listener_events()
+{
+	local evt=$1
+	local e_type=$2
+	local e_family=$3
+	local e_saddr=$4
+	local e_sport=$5
+	local type
+	local family
+	local saddr
+	local sport
+
+	if [ $e_type = $LISTENER_CREATED ]; then
+		stdbuf -o0 -e0 printf "CREATE_LISTENER %s:%s\t\t\t\t\t"\
+			$e_saddr $e_sport
+	elif [ $e_type = $LISTENER_CLOSED ]; then
+		stdbuf -o0 -e0 printf "CLOSE_LISTENER %s:%s\t\t\t\t\t"\
+			$e_saddr $e_sport
+	fi
+
+	type=$(grep "type:$e_type," $evt |
+	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
+	family=$(grep "type:$e_type," $evt |
+		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
+	sport=$(grep "type:$e_type," $evt |
+		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	if [ $family = $AF_INET6 ]; then
+		saddr=$(grep "type:$e_type," $evt |
+			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+	else
+		saddr=$(grep "type:$e_type," $evt |
+			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+	fi
+
+	if [ $type = $e_type ] && [ $family = $e_family ] &&
+	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
+		stdbuf -o0 -e0 printf "[OK]\n"
+		return 0
+	fi
+	stdbuf -o0 -e0 printf "[FAIL]\n"
+	exit 1
+}
+
+test_listener()
+{
+	local evts
+	evts=$(mktemp)
+	# Capture events on the network namespace running the server
+	:>$evts
+	ip netns exec $ns2 ./pm_nl_ctl events >> $evts 2>&1 &
+	evts_pid=$!
+	sleep 0.5
+
+	# Attempt to add a listener at 10.0.2.2:<subflow-port>
+	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
+		$client4_port > /dev/null 2>&1 &
+	local listener_pid=$!
+
+	verify_listener_events $evts 15 $AF_INET 10.0.2.2 $client4_port
+
+	# ADD_ADDR from client to server machine reusing the subflow port
+	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
+		$client_addr_id > /dev/null 2>&1
+	sleep 0.5
+
+	# CREATE_SUBFLOW from server to client machine
+	ip netns exec $ns1 ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2\
+		rport $client4_port token $server4_token > /dev/null 2>&1
+	sleep 0.5
+
+	# Delete the listener from the client ns, if one was created
+	kill_wait $listener_pid
+
+	verify_listener_events $evts 16 $AF_INET 10.0.2.2 $client4_port
+
+	kill_wait $evts_pid
+	rm -f $evts
+}
+
 make_connection
 make_connection "v6"
 test_announce
 test_remove
 test_subflows
 test_prio
+test_listener
 
 exit 0
-- 
2.35.3

