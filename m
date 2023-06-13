Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA841FD6
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 05:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CitOP0kBQY9Rhog56sKpX6vI2rkOBNpfp8I3C3n/sqFel/rCGmnsYXYqM99ouBRMpiaPaAs4EvKypD2w4zCg62ggIesvOKUId7XCa/IOQULBQtVSl+4TK1SmURFX0BHaTnrmyHyzznNmxijqs4sweTvqwhNYk+ViBBJ/+fTaA6qLsANvAYLuhWaHNpyc/960yw91wQvMgdLywub0Kl23SnqxmdrBaD7XEoj1CKIovlxW08oDvZN4M0yaKkZZgxXCrZkjN3Kqz6/mjMZla0sBjiKoTFnuC1jwHxeP2IDKWT4JqibroAD3ce9HWxrV/wOAjL6BoYb1CSI5VcmHNmS8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImYi6qGQKmJPoGlK42QGDBObAlrTszmtxp7c4yTbUpk=;
 b=OMXyi+tz0wBZox3afZ24jyYKDXkM9A4Bl9XLoj0XgywBa3evmtIBLZsauegc4sm+CmAYoSXegiVthB9SL+Pfn/3iwWqwzB3thp56EjYyEVnyAu8sOHsfSirpNRKEM+IDpD23zVBLxCicqyyMCvWiHT+0POZO5YUwMfGIXOHQgmGwqj+cnB7XigRHDwqbkNJ/gpcK2s4f6V1SAiraNnn/5BxXayVhInxCvWGPtD11BSs2JBt2YH/ewKR+qsOLsvqIs8K24cpbJEE+4ucfEOscon22Pmh/u6a/wp7ZOqnZSTuOMoQgTI5XD8ZgjxvB5/VKhWtS5WO//IC1qhSHiym+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImYi6qGQKmJPoGlK42QGDBObAlrTszmtxp7c4yTbUpk=;
 b=s8xBsVfbZNaZu7Xh+w+p1B+HJvBTQ2+eRD7nTZQ49ZekPMWjvXe4DPJNnqJXRlpaaivvlgtTYWV29Vefz7STEzz8NEy1ChoIA8LoNVOYaHXbPVE9yVLSC7+iGrAApDiEGjQ6u3GUw6WEs3dS2+q2n1b9R1ufG7TQ5RPoeBuqAOk18a80u+fDap9er84Pt4/fw4KT0MYQPf7eeOTL+WX/ewwTAJQxciQTozQXG+pakaxIvziX/kkVB+kHbdjK2U7a3XZntW+Hb+iXJvj0EHrO6MZap0+nxAfVvBaUD6ERaRvLcXj2r5/jjM15Eu7Li0BtryFiFhfq4ntFMBMqyvb0sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 05:32:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 05:32:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 6/8] selftests: mptcp: drop addr_nr_ns1/2 parameters
Date: Tue, 13 Jun 2023 13:31:13 +0800
Message-Id: <1480ddac401428053326116370ff86fbf3a3fb51.1686634037.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686634037.git.geliang.tang@suse.com>
References: <cover.1686634037.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: c50c381c-b8c5-445a-e098-08db6bcf98d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AMEnx36YLVTX7OdnSN7qw3W6IbiQckQrOD+78N2aNt3af2DxC58+1Zwk5rnCAzgjR29W+pu/b7CTmJaEBr3W8VTc52DR6Oymb8Hib3WoK/4WCuwPi73GW3LM/7/4JYj3eKgf07OyA4b0AT3p77XVhN1m3gODN+GkMKei6vaE6+uSmfPFKMiKj+myYENmyvUGTFStNFJa7MKCuT3atdo0tIQBY5cAVqROBjox79lMIVw2qrqSCxFzuv7aYc8Lz8OfnDzsHGayOIEfeR56WoDBOK9wwKd1oAijfbUjw6+8MpMHpXgiZ+L0Feod1nmHZl6JI9ES/uLETakYkhWx3bcNJo0gu084TySQLgA3rBMfSNotJK0CApINX2HtoKmVXQs7Y05CRvFqB8SI2qf89Cm16Q0V40T2LbN5tydQVjMSB14dxHUTZYMYwiIFfyJyPb8+KrTaxOlTj2yKecysu/yU9YlAdGN0l7eCrEyEb2dI2QfN7pOWJ3wWrh6xjQfFY3hAVPd3awZm2AvpXfVnpZSFHKK+SYxR59GrucJ0+3fyzSiukxNskxwj5CmVHUQsHK4x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(36756003)(30864003)(2906002)(44832011)(86362001)(2616005)(6486002)(6666004)(186003)(83380400001)(107886003)(6512007)(26005)(5660300002)(6506007)(478600001)(66476007)(66556008)(6916009)(41300700001)(316002)(4326008)(66946007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZq05FeZO6KMSXy3QPJwzAVwmXvpLcPNSdLgpb8caZd/XDfXwIbYzqpyYomc?=
 =?us-ascii?Q?jqQNGi/FarhXXpTCawSMxncn7tO9Jyx/vqPzY2mTP/tANN5WNlVN4gWWg5Tw?=
 =?us-ascii?Q?GZGQ67F2JHqjKbcJ9d5gw9WBHBPSeULwGImLl8sFXut3WXrEN5RcHizPlpH7?=
 =?us-ascii?Q?yvY4Cu2yZIZTg+sPL+BJNc0t7yco08T0fHSpbxDD05UsIN6VQPFgAZfsAbfS?=
 =?us-ascii?Q?q90R+jZABDQ/wr3DyIZ0wbI0bTvrJ8Ugja675bXpMld78q93/BZ4AVUnmern?=
 =?us-ascii?Q?nGZRBNnjF/rA7UgtOaWd3CAQGVitWO/wWBaDShovTRR01s4BWDlPTiv9WHe9?=
 =?us-ascii?Q?ueKRMUGbih1+Zhgk06MAeN6jWMUx2jZFAsO5YHZue/f8Sn0IvpXYpBt+xavr?=
 =?us-ascii?Q?zAy22xoKAjcfZxkTM7AaSon4r5FobmnpO67U5OG4EAhc+W4bfbveRFF8HSCk?=
 =?us-ascii?Q?oNsqC34UJZxYVg4RQiCBuZt2uext52m/bruhEfQt9oJ4pnQ3vypcf6cbqIKI?=
 =?us-ascii?Q?OyJnniHM/SGeSeFUK6RS/U22f4aW+bMbCKJlpFNTTMrBM4tS/4A6zQfzQ2zx?=
 =?us-ascii?Q?VtEP1GIFp2/5SX/eGtRH4YsJAur3axPiTQ6hDX+kCx08XAZDxq6z8b+w44nY?=
 =?us-ascii?Q?JukxmFxm7S+jxZd5zcXqNZfIDVgn+wfOt88nUQLo+9lgZcuQCPioEmKLvBh/?=
 =?us-ascii?Q?pou54oUfU56rDEY4nKWOmOV3qEVpILDmd7VjcgGqZPVxwChVPWCjtDkIisUw?=
 =?us-ascii?Q?dZHZsJcOYz+NXkIVqdjx6IPuAhbSoD/4IYWHZlF8Z0gfVJBnRtsL7e5h0wMK?=
 =?us-ascii?Q?7ltkNmTtwnkQNFoqO75Ui5SBDddja7OqaVUXMXy+ugebFEaGtf/jlI7wPOUk?=
 =?us-ascii?Q?iyeOTNkxrSOW45IvaWWGOMI4YXrTQ8Z+BNW9YJG5EWWWMsi4UbMyBFreN8yi?=
 =?us-ascii?Q?bU+pc3xoa+t+aPJHov+8Fr/0ML+fV/XZ4Jc2ahZnBRzBRLhAJm1MG2DCcMBp?=
 =?us-ascii?Q?2oUH9cFAJ+xA4kxBazVD3H6YSGo4kOoyla6PvYf7Ku6lo2ZwBEz91o7rbh7V?=
 =?us-ascii?Q?PnQCR24c9tbPAKkCdlvtcrZg7KGrkya0gOTWEzLFnPBGiIbMMLeARTzl58Cm?=
 =?us-ascii?Q?wNZPZMjOjz4YjBKRJxE0imeQsM0dqRsfuH+XIbt5PSOveyPregRs7ahwSkvB?=
 =?us-ascii?Q?+25vfJ/L74gzj/bxjRcYeAP/APSKu/T5MW58fsfGyNqlLChASuNJ/HrG97QD?=
 =?us-ascii?Q?sb+EFyRG/EKAsfRhtPpF/hIww1y9apgfxCBT9V67piVqSyOEl6k1W9H7igHk?=
 =?us-ascii?Q?acyOHa9iEhY+019fsZyPCQbNdqBNnbXYgon1zK6JThNw53GfPMPNVpScksxl?=
 =?us-ascii?Q?QH/oUs+STIuv679Y7BB6hXd4mcLdd+zwlBbzxykoyOWFmujzbei8hzlCwl7s?=
 =?us-ascii?Q?FEbKFoyBaOOM9gzsnNpNHnS8gV9RIlqNC2SX4ONWtymW06dDnKLEtDB9qkMh?=
 =?us-ascii?Q?bE+CcF5HaXEWT2qp2fMtDa4VTMSSmXxnUkQeQisdFucsXYchC0dE7TSEfbl1?=
 =?us-ascii?Q?BxyPUD4bOuxyrwArI80PkVUedeS0MznGDycFWF6p?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50c381c-b8c5-445a-e098-08db6bcf98d0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:32:37.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqvGcU1OBBbJYnd0vjj0gEZCe1inxSa4B8HlZqmKpcM7Oj6TkSt/LByWCfmDi8lM1uOD0AXuacLErI6lsQghkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504

run_tests() accepts too many optional parameters. Before this modification,
it was required to set all of then when only the last one had to be changed.
That's not clear to see all these 0 and it makes the maintenance harder:

      run_tests $ns1 $ns2 10.0.1.1 1 2 3 slow

Instead, the parameter can be set as an env var with a limited scope:

      foo=1 bar=2 next=3 \
            run_tests $ns1 $ns2 10.0.1.1 slow

This patch switches to key/value "addr_nr_ns1=*, addr_nr_ns2=*" instead
of positional parameters addr_nr_ns1 and addr_nr_ns2 of do_transfer()
and run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 176 ++++++++++--------
 1 file changed, 103 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 90cfd134bf7e..f9bf4733ca41 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -51,6 +51,8 @@ nr_blank=40
 
 export FAILING_LINKS=""
 export test_linkfail=0
+export addr_nr_ns1=0
+export addr_nr_ns2=0
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -826,10 +828,8 @@ do_transfer()
 	local cl_proto="$3"
 	local srv_proto="$4"
 	local connect_addr="$5"
-	local addr_nr_ns1="$6"
-	local addr_nr_ns2="$7"
-	local speed="$8"
-	local sflags="${9}"
+	local speed="$6"
+	local sflags="${7}"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
@@ -1146,10 +1146,8 @@ run_tests()
 	local listener_ns="$1"
 	local connector_ns="$2"
 	local connect_addr="$3"
-	local addr_nr_ns1="${4:-0}"
-	local addr_nr_ns2="${5:-0}"
-	local speed="${6:-fast}"
-	local sflags="${7:-""}"
+	local speed="${4:-fast}"
+	local sflags="${5:-""}"
 
 	local size
 
@@ -1194,7 +1192,7 @@ run_tests()
 	fi
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
+		${speed} ${sflags}
 }
 
 dump_stats()
@@ -1989,7 +1987,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2000,7 +1998,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2011,7 +2009,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2023,7 +2021,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 slow &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2122,7 +2120,7 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 
 		# It is not directly linked to the commit introducing this
 		# symbol but for the parent one which is linked anyway.
@@ -2232,7 +2230,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2243,7 +2241,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2254,7 +2252,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2265,7 +2263,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2278,7 +2276,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 slow
+		addr_nr_ns2=-1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
@@ -2290,7 +2289,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -2 slow
+		addr_nr_ns2=-2 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
 	fi
@@ -2300,7 +2300,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 -1 0 slow
+		addr_nr_ns1=-1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2312,7 +2313,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -1 -1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2325,7 +2327,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -1 -2 speed_10
+		addr_nr_ns1=-1 addr_nr_ns2=-2 \
+			run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2338,7 +2341,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 -3 0 speed_10
+		addr_nr_ns1=-3 \
+			run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2351,7 +2355,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 -3 0 speed_10
+		addr_nr_ns1=-3 \
+			run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2364,7 +2369,8 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -2377,7 +2383,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 
 		if mptcp_lib_kversion_ge 5.18; then
@@ -2395,7 +2402,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
@@ -2408,7 +2416,8 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 -8 0 slow
+		addr_nr_ns1=-8 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2419,7 +2428,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -9 slow
+		addr_nr_ns2=-9 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
 	fi
@@ -2429,7 +2439,8 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 -9 0 slow
+		addr_nr_ns1=-9 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2442,7 +2453,8 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 1 slow
+		addr_nr_ns2=1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2450,7 +2462,8 @@ add_tests()
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 1 0 slow
+		addr_nr_ns1=1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2459,7 +2472,8 @@ add_tests()
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 10.0.1.1 0 2 slow
+		addr_nr_ns2=2 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2467,7 +2481,8 @@ add_tests()
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 2 slow
+		addr_nr_ns2=2 \
+			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2475,7 +2490,8 @@ add_tests()
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 dead:beef:1::1 2 0 slow
+		addr_nr_ns1=2 \
+			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 	fi
@@ -2488,14 +2504,14 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 1 1 1
 	fi
 
 	# add_address, unused IPv6
 	if reset "unused signal address IPv6"; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 0 0 0
 		chk_add_nr 1 1
 	fi
@@ -2505,7 +2521,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2515,7 +2531,8 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 -1 0 slow
+		addr_nr_ns1=-1 \
+			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2527,7 +2544,8 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 -1 -1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 \
+			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2628,7 +2646,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2638,7 +2656,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2649,7 +2667,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2661,7 +2679,8 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 fullmesh_1 slow
+		addr_nr_ns2=fullmesh_1 \
+			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 4 4 4
 	fi
 }
@@ -2674,7 +2693,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow nobackup
+		run_tests $ns1 $ns2 10.0.1.1 slow nobackup
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2685,7 +2704,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2697,7 +2716,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2706,7 +2725,7 @@ backup_tests()
 	if reset "mpc backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2715,7 +2734,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2723,7 +2742,7 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2732,7 +2751,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2821,7 +2840,8 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 -1 0 slow
+		addr_nr_ns1=-1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2837,7 +2857,8 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -1 -1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
@@ -2850,7 +2871,8 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -8 -2 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-2 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -3052,7 +3074,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 1 0 slow
+		addr_nr_ns1=1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3064,7 +3087,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_1 slow
+		addr_nr_ns2=fullmesh_1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -3076,7 +3100,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_2 slow
+		addr_nr_ns2=fullmesh_2 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
 	fi
@@ -3089,7 +3114,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_2 slow
+		addr_nr_ns2=fullmesh_2 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3100,7 +3126,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 1 slow fullmesh
+		addr_nr_ns2=1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow fullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3111,7 +3138,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_1 slow nofullmesh
+		addr_nr_ns2=fullmesh_1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow nofullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3122,7 +3150,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 1 slow backup,fullmesh
+		addr_nr_ns2=1 run_tests \
+			$ns1 $ns2 10.0.1.1 slow backup,fullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3134,7 +3163,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow nobackup,nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 slow nobackup,nofullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3144,16 +3173,16 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		test_linkfail=1024 \
-			run_tests $ns1 $ns2 10.0.1.1 0 fastclose_client
+		test_linkfail=1024 addr_nr_ns2=fastclose_client \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		test_linkfail=1024 \
-			run_tests $ns1 $ns2 10.0.1.1 0 fastclose_server
+		test_linkfail=1024 addr_nr_ns2=fastclose_server \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
@@ -3309,7 +3338,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -3322,7 +3351,8 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 slow
+		addr_nr_ns2=-1 \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
@@ -3332,7 +3362,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr 10.0.2.1 10
@@ -3352,7 +3382,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
@@ -3375,7 +3405,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3399,7 +3429,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		test_linkfail=4 \
-			run_tests $ns1 $ns2 10.0.1.1 0 0 speed_20 2>/dev/null &
+			run_tests $ns1 $ns2 10.0.1.1 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-- 
2.35.3

