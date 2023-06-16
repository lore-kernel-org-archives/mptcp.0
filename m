Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F223C2
	for <mptcp@lists.linux.dev>; Fri, 16 Jun 2023 07:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQrM14LeNefZtPhCwwZkV69xQ4srqs47IUTYNKX+rPvp7z9kCj5CBb7JtFzTXgF1YpQtoLQOpMN/pB4mFL8ebqjCOiE7NN1EqqPdsIMH0BsK/Hb/SJztz/VZY5kpgnPgVp/r+OtWBdlHEGdyMDnmceJVhQesxtKbKInjrimllu8THBpYkSrBOHefgoelw8D8eIx+2mi9gD+gNVE+i6u/YUDqv68aONOJwjIOq6zeWhWs7HHqUpMvYQ6tZakT+TAkIT+L3X+dk3zqZkv4OWGRQHKspBbt/qdpXg5AYkawOa0v4Gh7pKltnascDkJQbeXnSBMwTAqrQbaPsgHzSG9FeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImpvogNTkrgBVMcijVoEh9Ju6mjCACaUXhVN0Rhx3/E=;
 b=l5GaLBBgJ9IP3YwyZuXkIuOGG5+TyXo+NB1UJ9vi/BgTXRKUNA/S3CxJMEafNiI41avJCbmOtHzAGITiHyRBLawFolSe7A2/6u2Eiyg+228btCBgHCkqmqpGt6iLj2pnjeHzw0SE9b7TBhMPmG4BljblRTZv1yqxcoUPG0eDhR3jvaRrAMjPNag4md5DloquA1St2qV/7J26ERpHm9KIYVjp/RQ4J7N5E/vI8ZbIKeXk0gfn+87Y5ZNAE6OBtItjCojOlUl8dVoDh65Q1Lvm3PuMkpk8zy0VSvWBwcx7Hdewh51bMkuFZoQzX6Mjp2e6wHA9ma0aQ+jZloWg0YLTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImpvogNTkrgBVMcijVoEh9Ju6mjCACaUXhVN0Rhx3/E=;
 b=wIW3Tll4D1XlBUnT1tG33tq3WVGBTR8nWSVV1Sye6YjGgtYuZRWqY6QysoMrT0PUUiCTAyh1ntsLg5SDm/qeIQ3ExnG/LTw50QYQyfypGhbUrWwLZsq4YyizyY7OrRj38sO1ct1dt7LO/9mF+Vmv3UILMb87Q+VAAe7VZzq8OTaDwaRDAcJ2k94bkYHh9c0rihT7uysYETtmzRiT3uCkNISSlUOuIKK/0G+xe+nicMcXsz6sFM0swMdWA8NZ0XbhgPlJorDJKbZvUTaF0zLOK6IXBwUwQi/aIMWegE7KvhmpaBpMgq5qr5YHSA8nqA+uU01uYD5OmU+hDC87hHuCpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 07:32:25 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::f3a7:5b84:b8d6:bc59%4]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 07:32:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 10/10] selftests: mptcp: set endpoint out of transfer
Date: Fri, 16 Jun 2023 15:31:02 +0800
Message-Id: <0dd86c4b502f4d977add42b983c0aecccef8b289.1686900596.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686900596.git.geliang.tang@suse.com>
References: <cover.1686900596.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM7PR04MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 897a2001-6299-406e-ad2f-08db6e3bd453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zyyb0rm8Vfv5VlDit2kx0rntqUHYjFlA89CGcw+xRNOEshrfSuXlj//+vzgpXHmZTt9Oa3dFixSeLn5Z0qsx2rbzjcN4sBRmvwM+XYUTc4kggpKNPTzE3ZF9n0jMAvnJCY1swiunqpi6B8x4lanJqshM4NLEEamvgk6ucqO712rlS8D4mIjrOTLBgZHiTR4/CnOLU53tjTDNL8KSxVIvHGOru8NzB7IzVToWPJxc+NI0XLpMXFs9HxCdb6g94Hss6cwAlIP6nO2rhkj5aC1c4/vj1mioJZWPZl7Mo8jcBLbU+uPcaqZJQOh8ukwtwgNoLM/o9+pppG7jjp6hl9Pv4tLidD5J+BehwaDhZL8DO21Fh5m0nFdYlQ5y5083SRPBVAjkFEG3GPjK2RE/a3fhvI8NGb4kmYfqPUX/RWRMBtkc3kb5I16kWayTBdJVyb2bJ+jTgqFbujPGz5QdD1GrseaquFNwYS4nbG88+fA/CB/XNehH2OLSmSK7ljRYKR9RNWgqg8M5hvlh6PziJJj+67tWQgCOtU6Xvm7nMf0XDdMM44H1EUmJIh3mBoB0e0tG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(6512007)(6506007)(107886003)(26005)(6916009)(4326008)(66946007)(316002)(66476007)(66556008)(2616005)(186003)(83380400001)(6666004)(6486002)(478600001)(38100700002)(8676002)(44832011)(8936002)(5660300002)(86362001)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dBrgx0L2sDggMBBdnKJxJvvPotKJVEmtspao5/tRijawy5A2E/lpAasNDLEs?=
 =?us-ascii?Q?N98OSpoefM8kNuDi4uzvSLRn4vd1WfKprgnK4Lm8lEtJ8T3nSEGp3SKEdJ9h?=
 =?us-ascii?Q?99cFlmGmufn2vj59IJnSUw4AhYjhX2NG6gMzjQL8qEYDPbn8mWV8VnP6qLPp?=
 =?us-ascii?Q?SAGrkim0iyQHit5c8HizQSxdlhFcX6EEc12LI0vuiJ/UVp7AFmEZV7zBfT0+?=
 =?us-ascii?Q?+SU7At/KaSmjvZs0aahTJ/iFVonugxH8jGIEqkpESVdCy4GNqbN6i/SQFOPc?=
 =?us-ascii?Q?f2JYgJH+IW7TNOPmPzuY4SBs6oMBmP56hg73DwmB4vMviNrOZeU2CZnnfjWe?=
 =?us-ascii?Q?aw5wFgpPQvdMqnGL0jY3UhtfCjbnUyxLklSzDBFISk5pOHVdZlVni8pojvFX?=
 =?us-ascii?Q?J/0vR5TuxOMiHlEkU+0hVDz967O59OeB3EY55f+HtDH54sUmPv9j55RYd6Nv?=
 =?us-ascii?Q?pBmJF5XgleYa7CbvXZoT+LZF9+xE41NqmaUMmCBYL03xnKTX1zOh0sLvhwNL?=
 =?us-ascii?Q?OyjtRV3kh5CH04Ak8CJOi5MRu5O+vH1mvNXshszYdA1b0oWxjFXdZtj5hvtw?=
 =?us-ascii?Q?/scjyhqzGoWzbIxhwenspe6B3EA3iThCuOwl04zZA/lcAlDG9McgbcCO7S1x?=
 =?us-ascii?Q?WLrSU3zggHAHw1KiLetVa8MXAVXuAsR5B8wB7a/2RJU+Lf6guioV/dkRtcux?=
 =?us-ascii?Q?hqlkD6Jtq1NW4x9JencmVmMVlQpp09OqBrKOtzpeVkjJCAJ0MSXe61dMDESM?=
 =?us-ascii?Q?YegtTHDy7Ce98FKmEu56/X/lUqpUG0xO38cj36cJbqrPG/yzXwJhWqBIObuT?=
 =?us-ascii?Q?E76/UC0IGr17svOzS0YrM5G5rM0zehP0iuXeqQkhz0bL10yJM+Q66gfMJlHv?=
 =?us-ascii?Q?Fo3JiOdj1CCW7yINNaUdLDHD0MUjICR6pUnbVB46uNjxRWU186Ge9Z4e2AY6?=
 =?us-ascii?Q?yDjxit1AqLSy17KPygP0wvQ7dyt2ydeJ/XVUaTqS/jMFIwOY+XUcoFwfPXG0?=
 =?us-ascii?Q?B6tU9erkQMIMa2EO7ySdbdrxMlCnQRLYPApejUUjFiLUrWUu20rYOAnK/T9Y?=
 =?us-ascii?Q?VScB0glOaA2uY8sy3Uj6lMa0LK5o3lVo5c4l4wIpoELuF3BWKNW14JsXnhrg?=
 =?us-ascii?Q?TJb62C9uQLfg3Cn10z4+b0cidvt0A0VGWUwPAgLDG0aJKO2A8bXNgIZOZYUF?=
 =?us-ascii?Q?86Y8BIor2psX6Hgl7NpcTYNMTrgzcs/JLufFMhS6aVijlOpjNfDKi1UTVer2?=
 =?us-ascii?Q?oqQwlZixjtCXm7GA8BsyLDDk21X+G0vObkHngrL9xrT5g2MX+NUnu/zYT2mh?=
 =?us-ascii?Q?LopWVDwhZA9QGajnjOAnNfPrBd6qiUnHYNGJALEXMT05rL0h80Sn6E94g/1n?=
 =?us-ascii?Q?copYKMsfAeRnAjix1hrpkvp9EdWb4xyMV2TfRtwrpDWjOsKerJhB+gt1UnHQ?=
 =?us-ascii?Q?ai8ULLZKdgEcL1T3vu+BE+E1BxfyA/XoASOr55ureO/eBXD9887lpOZzaagW?=
 =?us-ascii?Q?XOSLgMKFf0IPgHg21MN/pKS6Lhh1PdnqWxMIxfzkNMdBt+9iU8zv8haWv7Nx?=
 =?us-ascii?Q?KVziZVEn6KLWQiZafzFh0+3sMs3bz+hp4OuOIA0D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897a2001-6299-406e-ad2f-08db6e3bd453
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:32:25.1380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: by2sU2317cC4V+PE+qQniQdm05QL6pvMFXO9sqAvQRqRCQs0jIPRv64DW5vX8+Bg8HEryrrRQvf2OLm/U/1l7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7157

This patch adds a new flag set_endpoint_outside to control whether
endpoints are set in do_transfer().

Add a new function run_tests_bg(), in it run tests in the background
and set endpoint outside do_transfer().

Many tests can use this run_tests_bg() instead of run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 65 ++++++++++++-------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 89379815b619..f5a79a88131e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -54,6 +54,7 @@ export test_linkfail=0
 export addr_nr_ns1=0
 export addr_nr_ns2=0
 export sflags=""
+export set_endpoint_outside=0
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -1086,7 +1087,9 @@ do_transfer()
 	fi
 	local cpid=$!
 
-	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
+	if [ $set_endpoint_outside -eq 0 ]; then
+		pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
+	fi
 
 	wait $cpid
 	local retc=$?
@@ -1203,6 +1206,22 @@ run_tests()
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${speed}
 }
 
+run_tests_bg()
+{
+	local listener_ns="$1"
+	local connector_ns="$2"
+	local connect_addr="$3"
+	local speed="${4:-fast}"
+	local wait_join="${5:-0}"
+
+	set_endpoint_outside=1 \
+		run_tests $listener_ns $connector_ns $connect_addr $speed &
+	local tests_pid=$!
+	[ $wait_join -eq 1 ] && wait_mpj $connector_ns
+	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
+	wait $tests_pid
+}
+
 dump_stats()
 {
 	echo Server ns stats
@@ -2285,7 +2304,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
@@ -2309,7 +2328,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
 		addr_nr_ns1=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2322,7 +2341,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		addr_nr_ns1=-1 addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2336,7 +2355,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 		addr_nr_ns1=-1 addr_nr_ns2=-2 \
-			run_tests $ns1 $ns2 10.0.1.1 speed_10
+			run_tests_bg $ns1 $ns2 10.0.1.1 speed_10 1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2350,7 +2369,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-3 \
-			run_tests $ns1 $ns2 10.0.1.1 speed_10
+			run_tests_bg $ns1 $ns2 10.0.1.1 speed_10 1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2364,7 +2383,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
 		addr_nr_ns1=-3 \
-			run_tests $ns1 $ns2 10.0.1.1 speed_10
+			run_tests_bg $ns1 $ns2 10.0.1.1 speed_10 1
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2462,7 +2481,7 @@ add_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		addr_nr_ns2=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2471,7 +2490,7 @@ add_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		addr_nr_ns1=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2481,7 +2500,7 @@ add_tests()
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		addr_nr_ns2=2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2490,7 +2509,7 @@ add_tests()
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		addr_nr_ns2=2 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+			run_tests_bg $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2499,7 +2518,7 @@ add_tests()
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		addr_nr_ns1=2 \
-			run_tests $ns1 $ns2 dead:beef:1::1 slow
+			run_tests_bg $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 	fi
@@ -2754,7 +2773,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		sflags=backup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2764,7 +2783,7 @@ backup_tests()
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		sflags=backup \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2854,7 +2873,7 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
 		addr_nr_ns1=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -3088,7 +3107,7 @@ fullmesh_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
 		addr_nr_ns1=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3101,7 +3120,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		addr_nr_ns2=fullmesh_1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -3114,7 +3133,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		addr_nr_ns2=fullmesh_2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
 	fi
@@ -3128,7 +3147,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		addr_nr_ns2=fullmesh_2 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3140,7 +3159,7 @@ fullmesh_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
 		addr_nr_ns2=1 sflags=fullmesh \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3152,7 +3171,7 @@ fullmesh_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
 		addr_nr_ns2=fullmesh_1 sflags=nofullmesh \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3164,7 +3183,7 @@ fullmesh_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
 		addr_nr_ns2=1 sflags=backup,fullmesh \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3367,7 +3386,7 @@ userspace_tests()
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		addr_nr_ns2=-1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow
+			run_tests_bg $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
-- 
2.35.3

