Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07D520F9
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 07:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8S11fBdN07qHZXsxL76/CNSZfVsMIVg49Yl22qOx/t+l/p0W6xHA1yl3UblrByuMRvIfOb1+HsQMJh14IrRfwASmpbuCQBJX2wj0WkHfab35QhsO5cFsd1UEOCfUjtDh9rZw3DjLCdEyBI9czwkFSCvnvz7j4gCbqAVtAE4klRhVMe1JCGUA0nwk8bAnzptdDmF1TNt0DB4aILK3Ad/0lCEdxP24Ml+3oQ6MP1T8JrmMIKl70n55LncYrmmsNCDW1Eu3vlfHJcdHc8C1tBbQWdZhPnJZf5L3lh+z/ldFcsb7acrnu5LLwR/yUELzNG/G9BiNMXP1cBpNMvwuvJL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATOt5fz0bt+FpRtt29VJCZeXFDJR8ymEOA0eKIHs5JU=;
 b=NAAjFHEPw0o1rnEV30nX4PLuaY+GmQdku/lfcvl1/l+nfDdXS5Gzui8dJd//lFD5bbrXe6ep/BSMyf/SLgGb87cUFWOs6Q9lqRqqZdsSCQkSU9b9qwO3YDFwYAWTIe4yFuIMskXJurr/tkZh4deGq4+WV1QdrdYPcieufD982fd5H4oMPMNMQmC1r4AYbfz2DfVRMpGtkzKFslh/DLqtKArWGtUc/UEksLi9CWTqdA6lynPjyh7SddKZ9qcSkja8NpahM7ujGqTrHyc2CW6hQkLiqSt6/gHVSiutk1nz7Xv+81gNfIDqGOt8xICSjfjbOfMeMMX4K+9uUJm9h8ILkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATOt5fz0bt+FpRtt29VJCZeXFDJR8ymEOA0eKIHs5JU=;
 b=oLeWWrJ3LHL9TNqIXdf4b5sRkiGMWdCS19oQ3tNnVDgjr5nXQaelfifJWYbfQtSxeod+jH2g63wRdhApdBC7I5dmTf1Ff6v6M0zvGLmyDl0Mhxc8gKQcKqM54eqSioTFYJFQk+8IBqCHJR3QHnOyz32Txs2twJ7A86bK5ok6f/+mhtxaNwpIIj4eyTIbYDl6sk/1f60iCSKG95YzK58l+j0MWL4w8QEnZKE7NAXxS9WmPJbiOXhJ3FoMgzF75LaCaL8HRfw00Rtow/gpiJLQ/9FhzTbiQX5ccDhn15KpHarvU+RcgAakIDrXgwjesI8up8XaV/gAJ7vlO5GcTDpfww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 07:20:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 07:20:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 5/7] selftests: mptcp: drop addr_nr_ns1/2 parameters
Date: Mon, 12 Jun 2023 15:19:44 +0800
Message-Id: <cf017beba25fbe111daa9fc66fd780f2d8665b57.1686554287.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686554287.git.geliang.tang@suse.com>
References: <cover.1686554287.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0134.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: 97efb7b2-7691-4196-ec61-08db6b1590ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LzHS2p0CDkAW+0X2LjLX8cAYNOh5fWigIYSnRrTZ46/k0gL3aEsXdG8OjGn0z8v7S175ZxjZrGh13BykkW0I0v91rDoKFxZtAJSGqyfMNEsXZANuOg0EpqYezsvGMcJY4AaKTEYU6XB6iH9NlQFDNg4+48ojHmU2f7lG3QfBF7WQ/iMkFRx0SAA2KRi7AXTz+LS/0c3rz99Eball+WVE+AQRVDp3NJOUClRspfkrQ0OUlB5Y5b9OwvR6hew7Imt3Aq/eZOWHW58k1nJjvPT/t9/Rw+ByMj8ebF0Sd6+1DyH2TmwfML6Hv2bEPHBaba2JdmUVg4Iwp9zUdeqec1vo4YponFHQYFXMUm37L5+LUZ8CngutRQwlPZJTwa6Ewv1fTCRYxQauSZ5NrwlxfxotCcmZQ9IXw9tNAyY2crtiQiZ7DblzsACl0wqu0ZdSqIUn1cFETETzqg4/IXEd1yUlqBY/9D1PP1hJHOTmD2PfEOqpNfcdfwjG/C4PHNcOcDe79re9ZY//3Nrfm36IFvAEJX4j72pITTIa7j87tO2ei7FQ+TjXhDntFFMDmyRC21hP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(36756003)(44832011)(2906002)(30864003)(8676002)(8936002)(6486002)(478600001)(6916009)(5660300002)(41300700001)(316002)(38100700002)(66476007)(4326008)(86362001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O1w2p+QtMkuXMZrYRKLEx8Zk4toPtJRXOa0xIoJJoGZ352e3vLT+0zL4m0Pe?=
 =?us-ascii?Q?D91kJw3T+5o6jB3G7l9sx38aWrPLqrrIVVRKDXIzkYyfcJw0Mwx8F3YHZLTO?=
 =?us-ascii?Q?+J8Mq/8ZWGGjTotTrD2xgEKMAHPkBWuk/frEiBXLdmhFI7UaBLAfRDbo7jxR?=
 =?us-ascii?Q?di5bmyNRhMRai5qy0qLV7d2zHCdaGReeoaQJH/0Ia/ICWiBKKsJSvW/smSm1?=
 =?us-ascii?Q?C8HVbKVyE5ioMgzTnZAjQagMDxDgaLvQXPHrusb7vHby6BvmoFdFAA+Y9Mcc?=
 =?us-ascii?Q?qFXOOcvZMLhA9nrw9RbJINKT0ZGKCdmTQlcAZAjf60xGrMj23E9sxo0i5xhr?=
 =?us-ascii?Q?OTQx6rH/e/Wd0aMp7LZFGtpxfVG7vB/tnt+fEjYyx7zMaWwsJKZBfypiWgy8?=
 =?us-ascii?Q?H7gq8On0d9BIleyJzZjagigI5cQI8ZRG1t71FNywjxMXatA4zOuZ5MP1ila/?=
 =?us-ascii?Q?FQz22lEWf9P/Yf5iTGpFpSVwDl/i4OXQUxZETESrHs1CewmH7Dh+w0BJEZsC?=
 =?us-ascii?Q?qle3q7FbTMO2eHkcUpBtEahCkKFSq2YsqNpAF9TVr3AapYyLY8wlgdJJaX3D?=
 =?us-ascii?Q?1YrlPoEs3aTgC026A/cGMv4EqNYJgqYLPBXClYTL0ZesZ0pKV+nOGxztObu9?=
 =?us-ascii?Q?5v+S4qRbiZnmuN4FNgK3CqJe84raEkK5fZ3LSj0nGzAD/GWZa82KsREODL2o?=
 =?us-ascii?Q?ARQpmeUV6GT9RYkdm/MP3CT3zF96KoAn5O2GdJ9EAoghDR+b61wsMIyAEp/h?=
 =?us-ascii?Q?1oY9AL7WsARDJzkysGixZBc+5ZAM4YFr8L5QKnDKSkdZK1lLTZJiA3oDJgQp?=
 =?us-ascii?Q?3euQJBaLHyaJJIf9OiWqU/dc519a4P2x/3E6xGPrnoevRbgvMMbrxXcP/UbB?=
 =?us-ascii?Q?Bc+JOP8bGxtuPd8kiGVArgjXRP/scd66HfjLDheoHwJb73HNIlYnH3iI17hh?=
 =?us-ascii?Q?TX8Wxz+JPxP7XKwpEXmEgN9djKfee5Vml8CNT8xPUgyUgX9EAFlQ83CVIdbv?=
 =?us-ascii?Q?SsZ1xLq6vbybccIadexINZ2F0vkUnbosnlVThJ8NF3A6zy2hOrh9HXXx0QJ0?=
 =?us-ascii?Q?WtqqXktxbTbeWuvD+gv5jM0jZcIDFTh721dT0kDjkNX00yVT7JNztzy3dKSC?=
 =?us-ascii?Q?zzkx3K4geGkTGsUQkCEHLU7+2kfaE2VZPjLx0XC+n30Jb/J4ILWxw0Q82E/O?=
 =?us-ascii?Q?Im6sr8Ig+1+RICmPWxp7kHVTPjTlPjJekNjJb6UFHeXyC/gQHguslloTYkQ9?=
 =?us-ascii?Q?cOJ0Sqrnx6MOq5lgfolKNIGoxAYk0c3n9Cg+0pTN5B3A8izyKM53dQPbvQ3O?=
 =?us-ascii?Q?WEPPllNjSPITpbIuCWt5ZUxP39+yVmywHIlfwr9wb+tYIEJucd4uxLQf4EV5?=
 =?us-ascii?Q?u1qWSnEG3zvrQqxG+HuCS19nHq6ZYE6+c/UwgQI2uD6wxP+YExaDpk4NHOVK?=
 =?us-ascii?Q?TIdf9A0XDJ/YjQusnkAPLmHUXleMa+69Dcr4duh9slReu4Hz8+/mzCbm+lHs?=
 =?us-ascii?Q?um9s8wnqfq2QoqklA2A06Ybwoo1y1BW2yRi3emCovx5bHjZu38Yic3z9dfw2?=
 =?us-ascii?Q?G9V2EyMRATnMEhUjnmqdTF7JKSOtelzbApcls/j4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97efb7b2-7691-4196-ec61-08db6b1590ac
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 07:20:57.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AzbhRPnPMUUWXCWk83ioDMqoi3JwVNCreZHQeFzIOQY6kxt/7o7OMGY45TfhfnSM+XWsmFG55jr1S9No64tjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

This patch switchs to key/value "addr_nr_ns1=*, addr_nr_ns2=*" instead
of positional parameters addr_nr_ns1 and addr_nr_ns2 of do_transfer()
and run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 140 +++++++++---------
 1 file changed, 69 insertions(+), 71 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index bd23fba70361..6232dfed9082 100755
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
@@ -1982,7 +1980,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -1993,7 +1991,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2004,7 +2002,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2016,7 +2014,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 slow &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2115,7 +2113,7 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 
 		# It is not directly linked to the commit introducing this
 		# symbol but for the parent one which is linked anyway.
@@ -2223,7 +2221,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2234,7 +2232,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2245,7 +2243,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2256,7 +2254,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2269,7 +2267,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 slow
+		addr_nr_ns2=-1 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
@@ -2281,7 +2279,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -2 slow
+		addr_nr_ns2=-2 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
 	fi
@@ -2291,7 +2289,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 -1 0 slow
+		addr_nr_ns1=-1 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2303,7 +2301,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -1 -1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2316,7 +2314,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -1 -2 speed_10
+		addr_nr_ns1=-1 addr_nr_ns2=-2 run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
@@ -2329,7 +2327,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 -3 0 speed_10
+		addr_nr_ns1=-3 run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
@@ -2342,7 +2340,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 -3 0 speed_10
+		addr_nr_ns1=-3 run_tests $ns1 $ns2 10.0.1.1 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2355,7 +2353,7 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -2368,7 +2366,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 
 		if mptcp_lib_kversion_ge 5.18; then
@@ -2386,7 +2384,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 -8 -8 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-8 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
@@ -2399,7 +2397,7 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 -8 0 slow
+		addr_nr_ns1=-8 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
@@ -2410,7 +2408,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -9 slow
+		addr_nr_ns2=-9 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
 	fi
@@ -2420,7 +2418,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 -9 0 slow
+		addr_nr_ns1=-9 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2433,7 +2431,7 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 1 slow
+		addr_nr_ns2=1 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2441,7 +2439,7 @@ add_tests()
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 1 0 slow
+		addr_nr_ns1=1 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2450,7 +2448,7 @@ add_tests()
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 10.0.1.1 0 2 slow
+		addr_nr_ns2=2 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2458,7 +2456,7 @@ add_tests()
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 2 slow
+		addr_nr_ns2=2 run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 2 2 2
 	fi
 
@@ -2466,7 +2464,7 @@ add_tests()
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 dead:beef:1::1 2 0 slow
+		addr_nr_ns1=2 run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 	fi
@@ -2479,14 +2477,14 @@ ipv6_tests()
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
@@ -2496,7 +2494,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2506,7 +2504,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 -1 0 slow
+		addr_nr_ns1=-1 run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
@@ -2518,7 +2516,7 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 -1 -1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
@@ -2619,7 +2617,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2629,7 +2627,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2640,7 +2638,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2652,7 +2650,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 fullmesh_1 slow
+		addr_nr_ns2=fullmesh_1 run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 4 4 4
 	fi
 }
@@ -2665,7 +2663,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow nobackup
+		run_tests $ns1 $ns2 10.0.1.1 slow nobackup
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2676,7 +2674,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2688,7 +2686,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2697,7 +2695,7 @@ backup_tests()
 	if reset "mpc backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2706,7 +2704,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2714,7 +2712,7 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2723,7 +2721,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -2812,7 +2810,7 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 -1 0 slow
+		addr_nr_ns1=-1 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2828,7 +2826,7 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -1 -1 slow
+		addr_nr_ns1=-1 addr_nr_ns2=-1 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
@@ -2841,7 +2839,7 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 -8 -2 slow
+		addr_nr_ns1=-8 addr_nr_ns2=-2 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
@@ -3043,7 +3041,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 1 0 slow
+		addr_nr_ns1=1 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3055,7 +3053,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_1 slow
+		addr_nr_ns2=fullmesh_1 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 	fi
@@ -3067,7 +3065,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_2 slow
+		addr_nr_ns2=fullmesh_2 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
 	fi
@@ -3080,7 +3078,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_2 slow
+		addr_nr_ns2=fullmesh_2 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
 	fi
@@ -3091,7 +3089,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 1 slow fullmesh
+		addr_nr_ns2=1 run_tests $ns1 $ns2 10.0.1.1 slow fullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3102,7 +3100,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 fullmesh_1 slow nofullmesh
+		addr_nr_ns2=fullmesh_1 run_tests $ns1 $ns2 10.0.1.1 slow nofullmesh
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3113,7 +3111,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 1 slow backup,fullmesh
+		addr_nr_ns2=1 run_tests $ns1 $ns2 10.0.1.1 slow backup,fullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3125,7 +3123,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow nobackup,nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 slow nobackup,nofullmesh
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3135,14 +3133,14 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		test_linkfail=1024 run_tests $ns1 $ns2 10.0.1.1 0 fastclose_client
+		test_linkfail=1024 addr_nr_ns2=fastclose_client run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		test_linkfail=1024 run_tests $ns1 $ns2 10.0.1.1 0 fastclose_server
+		test_linkfail=1024 addr_nr_ns2=fastclose_server run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
@@ -3290,7 +3288,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 slow backup
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -3303,7 +3301,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 slow
+		addr_nr_ns2=-1 run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
 	fi
@@ -3313,7 +3311,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr 10.0.2.1 10
@@ -3335,7 +3333,7 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 speed_10 &
+		run_tests $ns1 $ns2 10.0.1.1 speed_10 &
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
@@ -3360,7 +3358,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3383,7 +3381,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		test_linkfail=4 run_tests $ns1 $ns2 10.0.1.1 0 0 speed_20 2>/dev/null &
+		test_linkfail=4 run_tests $ns1 $ns2 10.0.1.1 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-- 
2.35.3

