Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0908E361
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 05:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPJupA2CqQ+lJty7/36OpvYXY7mP4OIZpkLbDuvlpgV2dQQOLR72jQDy37Pf+FOS9UibGSXxnW3CNqu7DE/tMu8utYXLj2qyTqocrgXbBB8TLJXY1Ul/GEQxEJlP2igM354zazTja9DwUpgYtPuzJFNJpKpzrLvFzBmpMl/dICv1Pl+LipiZ3mbLpdHObhnOr7B1GXk5uV+tbLXMZTNPuvNxvT4SCoqWyrj1lvD/+gQMJ+EYD6dMXBAjpmlDIAZvF7rHyJWeO+51c9hLfP6z6UbmBjZLfLKHkqxiTEwET7dtx32ht1OTTeYFQr4DpG1+1Li7Qbg/KwptGnf74i8yVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0O8nae5dXn0DEF4UImTg0JO/ncix0rY1KGUUxzyqFXo=;
 b=iLketWpmLQRl++3subQpGZeDGDfpuL3yY4Dm5avwlrEuJoLOCp/76FJjv+7673JALF3nhu1cCY8He+Qb+73hbNNuL3kwx3rcNMByDH0MhKFp9B5WQjHZNZ9WYCom04JtqFncgsSjrq+MZQvDQdDT/D6xjVT9+i91cItfI0axOo5rixg7S+0NHXQUJhc6We18OinC82oJpRNE+8ml9d6mnjtqBiVogS+3OfYeegUwl6kBAZrWiIEuG9t9VDHhJain4oa2pjAnoW+IXcO6wvpaMJo3v70UQHnmyNao83OMKYGIttgPel3MQlVEmq5S+lweDB/FWV1rxkZzgOmxrGcpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O8nae5dXn0DEF4UImTg0JO/ncix0rY1KGUUxzyqFXo=;
 b=N8LgTLNqdc4HBpB9lp6Dmoyx3Mr+6rd4y2gvontodjrC/YI2MYiZAD55MrhJvTSOQ5pdfyZQDCYAqjJ1lKOXT6D6jq7LyAfk5PP5Z7frytyaks+uiTXzCexCnPN08r2Ax7t2tzqUFZWtBbxLYvL/Q4RS6sEs7hI5HGjo6JYeSZBlhIi+6WNZZVkYUxwmA6XlAICSuSZEuPGoFvPlCBAJVDeG5abEp8hpKdoDu0j060qplwiBdER9djfozDxowuyiPyFs3JwSyMBR0yePocjEkPKVSJ+BYiI6QqamehcpCRpzmsYw5mmhUm/5Mbw/qnQIgKOlfKAsBt1L5ozRDa2xTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 05:32:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 05:32:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 7/8] selftests: mptcp: drop sflags parameter
Date: Tue, 13 Jun 2023 13:31:14 +0800
Message-Id: <656ea6b3d4032aa6e964578b1e2c4aa60cdacccc.1686634037.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686634037.git.geliang.tang@suse.com>
References: <cover.1686634037.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0161.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 2829fb60-f46b-40e3-9fa2-08db6bcf9dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pEMUfYZSZmLBM8GY+dGIGKzdV0cy8VN8XyXdh+sDZzl5V7rAs6K1I9R9sJVuGiFUR1bH0ZpxcPZ0c/aVsIcpbRufp/p5DCHA/c24KpzWQgSjWc3Awa1Cx33FqCooJ4BsIV3Q33PuD7O+2BS8m6qKFUfEtfpISx3hJCRNm6bWG3ec8869yMMjZqP1rQg2BGsndnAgf13FDp0stDcJi6C3ekbwoufiOMUFep9sZgg+B3owMFZ5A2xTkRIEDP0EhsjtkKy2LduQs95M/SE0kawLgWJpMWQ7cU2ldzK8/28mPFplglz7013hRGJ2v0uOWfjtoKqZgAGydj/xYBBpDBe2iIVbMA8hzHcJp+9WbVpTYMKqe1+DZJ2UhHT0m08hOPQaUVbVLocPkF9UlpdHPU5xbXe3Fc0ot2wzxQgUbj2z+hCPkHx33MmQU3bPgnF9wRVTMLxJL7qh2Ug6PcRLPCXJD6fAxn1g9b1vRbU0gs0LlE2bdCOW+CGSCXZoOSdYH28FyYz2eZxBUQpJk4qVonCP7zxaJzRnD1TNzQasmZYuBlcH/vImNsi/D64NrUACYgkv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(36756003)(2906002)(44832011)(86362001)(2616005)(6486002)(6666004)(186003)(83380400001)(107886003)(6512007)(26005)(5660300002)(6506007)(478600001)(66476007)(66556008)(6916009)(41300700001)(316002)(4326008)(66946007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OEd2CLOVelunCZcNgj8bTXNmbCefDmq+VmfEVTDYLZBKAXqJT9PQICtsiVNs?=
 =?us-ascii?Q?R/4wRP1t+8IbCGtKjOumEZZGfX9Ui4KKQiwP2qOCPHmBWx8MtfKI54/38ca1?=
 =?us-ascii?Q?uZ5FfIFx30jskYteJPk/ieAtngPSMU3zxNruDQ/4Q6ocgT/YN0ngY8GWYQ/s?=
 =?us-ascii?Q?yJZNPLehkzK1PnAR67flhNON9LoPBEY7057BmLd586leLJKeYgXywhGosoZR?=
 =?us-ascii?Q?m/lVGfh2f+io/wgO7LW6BTfBwBFPktVMavAA1woS9ciTwo09tmP1vamO8W7f?=
 =?us-ascii?Q?tTDtCDnRRhDmx7s1wpZw8Hg5nQs8RUCH8qqCB6b/8ps8f5D4+FLlKMbVNFPV?=
 =?us-ascii?Q?jv1idVDzJVzPZ13q28Rvr8wpiBVyeuiaOz7YHZpvXb+fs2KBxebpdzlJ+YqW?=
 =?us-ascii?Q?Jji43AK2oDweyT00hjWUUrsHUY1FVNYIKHqk6j+ifd3S0CdX+Y/7a1EnZZwz?=
 =?us-ascii?Q?bmIfBVWejKTfaxPePkGldY3nUHthSf2zc2GtNE3I/VtuMpdHJNoPA9E53IFb?=
 =?us-ascii?Q?OeheKPoPH5qFRh1rkvCZ86WfxXTRvv46FpmccpN2gsxItXJxebg+n5/bvdYP?=
 =?us-ascii?Q?KT4p7HdqIaYAnBq2uufObZrsXP51xsu+C8WIQfSI4YhnC3ND9+SetPpoBQIp?=
 =?us-ascii?Q?PEb9q6BVFfx+oQUZ1hFGtMp43Zr/LaxAyAIWYjrC0sv0mkJWmTKSpir/1C54?=
 =?us-ascii?Q?k2OSpt5ZL5GrF7aV0C3F5iCH3gE1rf8qbVEQg28pSI+iEPRoHEkYOlZ5fvRB?=
 =?us-ascii?Q?yMDQ9WNFiv+/bi7b2xEbWFqnCC1rf1rulOsZKKY3vWP6Sc5K0KnJ75pZLMaS?=
 =?us-ascii?Q?Zor9+9ZEB0J22aA5bhfg7e4YDsXa5+xIfr5e3qBpgmBgEJa7YdQoISglbg5T?=
 =?us-ascii?Q?N7O9xPgmLAaujf5cdSpbm5SeBm5rIGnvmqpitvSF3HjPRfcQe9ogMNC/e3Ko?=
 =?us-ascii?Q?76S4JV+/ed4cHZTQAFm8SzDwpOKScBlt6jzU4RpV8Wv4XBZGUO9L7kktDc9g?=
 =?us-ascii?Q?vOzCLeXTVRVV4iAKbdatLNHyZ9bJN7Hayt0La3dokDOF69UVCrH6Kyb/DOur?=
 =?us-ascii?Q?1bBIsy+2DfzlWGIw4l2kNkL5zjudGJyjzHFacwRP1DblPo+3IHM3ptf1nGcN?=
 =?us-ascii?Q?mPAW1LaAy1+33UOW6uki9Rk/X5Y9WsG+nH3voHNVOWI0fAyk58sr48wkYFoW?=
 =?us-ascii?Q?yHtNcgKqyNIzgv0Qik5SJrH1U+gzrrDubfuY7It4fQ09kxf8vbfJXWjl/Rp+?=
 =?us-ascii?Q?1RlwjRL0X6mLvCUl7p8f/VZflc4QDA302JzHPyqvVg2hn1gO/HFpECeEVm3I?=
 =?us-ascii?Q?kxbKOEd3vkecV11bKcIGTF0UY1diHjP9uACTWhDumn9mK4aLYrL7OSMABk5U?=
 =?us-ascii?Q?xSO24vQikMnY4EEvTj2F5M3dmwR4PUArLXwzdJG5C6PCIGMnRjdnBwYHIAkS?=
 =?us-ascii?Q?CUEYuUJ646z73gsiwYvfz7Kib93xDrgBwxSRwFAQ6b+6pAimXbQhGe8JyGzV?=
 =?us-ascii?Q?t2obdfJllyM4biI/RI8mFogPTwrCPKADviloLj656wHGYu0lej/BeZT8p102?=
 =?us-ascii?Q?kz6FedRc3IHZ3qNVPmTy9JLAgfj9+4SH7dXlsyNR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2829fb60-f46b-40e3-9fa2-08db6bcf9dbb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:32:45.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aahv5OxyfI8qhhd0/OzEawEhCSu9aS0Q+iItPXruqBNDmtqxsF4f4ozbtisEari6A8Et3I3rjbreFLYeBAIvlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504

run_tests() accepts too many optional parameters. Before this modification,
it was required to set all of then when only the last one had to be changed.
That's not clear to see all these 0 and it makes the maintenance harder:

      run_tests $ns1 $ns2 10.0.1.1 1 2 3 slow

Instead, the parameter can be set as an env var with a limited scope:

      foo=1 bar=2 next=3 \
            run_tests $ns1 $ns2 10.0.1.1 slow

This patch switches to key/value "sflags=*" instead of positional parameter
sflags of do_transfer() and run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 39 +++++++++++--------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f9bf4733ca41..49d0fa5496a2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -53,6 +53,7 @@ export FAILING_LINKS=""
 export test_linkfail=0
 export addr_nr_ns1=0
 export addr_nr_ns2=0
+export sflags=""
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -829,7 +830,6 @@ do_transfer()
 	local srv_proto="$4"
 	local connect_addr="$5"
 	local speed="$6"
-	local sflags="${7}"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
@@ -1147,7 +1147,6 @@ run_tests()
 	local connector_ns="$2"
 	local connect_addr="$3"
 	local speed="${4:-fast}"
-	local sflags="${5:-""}"
 
 	local size
 
@@ -1191,8 +1190,7 @@ run_tests()
 		make_file "$sinfail" "server" $size
 	fi
 
-	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${speed} ${sflags}
+	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} ${speed}
 }
 
 dump_stats()
@@ -2693,7 +2691,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 slow nobackup
+		sflags=nobackup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2704,7 +2703,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2716,7 +2716,8 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2742,7 +2743,8 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2751,7 +2753,8 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -3126,8 +3129,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow fullmesh
+		addr_nr_ns2=1 sflags=fullmesh \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3138,8 +3141,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=fullmesh_1 \
-			run_tests $ns1 $ns2 10.0.1.1 slow nofullmesh
+		addr_nr_ns2=fullmesh_1 sflags=nofullmesh \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3150,8 +3153,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=1 run_tests \
-			$ns1 $ns2 10.0.1.1 slow backup,fullmesh
+		addr_nr_ns2=1 sflags=backup,fullmesh \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3163,7 +3166,8 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 slow nobackup,nofullmesh
+		sflags=nobackup,nofullmesh \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3338,7 +3342,8 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup \
+			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
-- 
2.35.3

