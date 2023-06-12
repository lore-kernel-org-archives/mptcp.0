Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FE520F9
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 07:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdU9ohFSGubJcPmo1Qn6nogmjyfCXC5GVaEaHEGkaPdbWQhSVkYOK31at7Kfk2nTyzXzZ7Lo66qs9NoHT0hMKIU4gjGueVo74GwvdKduQM4DN6kNfD8iH7y+0yciVf+SFZnzP7xJVjJH+FlzvhxpvdMNmzlqCH/YL7e3n045EUu0+nDNx6Dqz0owUX+x+CT8KsxbeaNO2i1vIcN6LagBUkJg67BwpCbhrJ/7+zb7AWaTZu1FMcMa8rRFrZHkrKIN9yeLrAw/hu+jNf53CbWi4uxnV6KVRfdFAhpyMmfuVfBnMJgoQGSoD2muoz6s344xqUv4vVhzs4svQpqR2BLqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs+9REDUwlNeblWv464YmDZfJWAd1UgJW677a77ak1s=;
 b=QRoOBp+RcUGi5wceLP7saWIOzXLDLupn+iQWBJBYuAIig52DtL9WsGsYJAKVVryrIRBnaESFwf+oa/9oElAlrHrVb8g5JigeqqnVPQtb49wed30WiJig+aZ2TNrM8oYotAWdtD/gQJfKu4DMlNpJmLzPDMT8UwadbMxUdgLZwQMD8pTpMRXukzI3g7W/CeVMh25m9YRa1k9e6Oca2KRVTYTEV3QyV4tXB9tNUfFiPW65r93PpuO8ItjUFCzaNWsWGAcIQZ8RSCXKBFyk9xGsb5DXTIQVF5aghsPBiArVkvxpcR57UVBFScyvxipf7/smf/v3nd5GFCEFm+ihzRySUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs+9REDUwlNeblWv464YmDZfJWAd1UgJW677a77ak1s=;
 b=TcW/Y5cf1wU7ddi222ErF1LzS5V4vgHl2zaWMhe1euYQjm2GmgmYR8/66AX1uORoAUslkLS4oLHN6DCGdgUK0ismyxBxe1psT3+8z0ItIbNEztw1Y4HYQkeNU4/rsE6ySRdP28AfJ2ugA6unWQhqmvP2KNc53QtYeDNFCtL4Yfd+qM33MZFBwTIUXjmwA33GyCYtU/8ZSi3RTTj6mGkV5bcH2cJD34yLAwieBXHWRVRBkca1R524j8l7GZbr23CFs4FlBGobUI5X7TS3F18vjuHURK4tHTSnzY8iQxBJW6QCu5xinbOOYuZfcP74XELBsA1TC/E2fYFkPLFp9hG7rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 07:21:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 07:21:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 6/7] selftests: mptcp: drop sflags parameter
Date: Mon, 12 Jun 2023 15:19:45 +0800
Message-Id: <1884a60092597d345750b9e2bcb68e4b74fd090e.1686554287.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686554287.git.geliang.tang@suse.com>
References: <cover.1686554287.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0166.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fdb45ef-3910-4e76-61ef-08db6b159637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WXQcKyob8TM5hBGZSbBMmS0Hel9L3p9JFu+Ugp+poCc4EzYnyc/s8Ok/JazPl8MgJYoTZbHCnc+C9lHaMhy4C8T6swG+vb0KcDzedWOup3M3ifDblHXyGmxwshmW5ppp0dCu3RsIZFSzQFcYca1uni+AxPPIm9kid/UMRnWcjolxG3dadPYUySsyuvRRerWyO6Nc3emtKbkO6jaevIrwfS502QszcXMrXHwDKCD3bP9EToAtylQtyJ4jLcQyqCjSkF+G0Y7ortA981qhl96O9kss6L/vMFE43Cx4HnXGmR67xHw2XvvQJZQOhw0kDZ34cwthQkbnGQiXi8XNbxREqdrG40iss9sVBoXWEZnzDcAoOwJiu+kjFvbS5wUuNZkWo7hwfYtbGLoGdeA+qLxQC1d88moS/ImUY2an7cMAm48eceRa9NY+Aon1z73Gs0aqBUFPa7p0uGsQX0a0ON95IUy9Ha27Zyb9OzR4TEHwY+S5guvha6le4TU/nmUGD+/y5dGLCTnt87/QcHnpFmVdhl94B64n3cQcXyEY8rZICMUVE3ZqWf6SY6/NfuFjmMGp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(36756003)(44832011)(2906002)(8676002)(8936002)(6486002)(478600001)(6916009)(5660300002)(41300700001)(316002)(38100700002)(66476007)(4326008)(86362001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w0DMxLrkAX8N+tCpjg7NPYzwcVIYM721IegARX59fWmR7gdpHKcbGezRAs1n?=
 =?us-ascii?Q?IKcY3IbYmtR4bpqwyY5DiOQ13MwEPfwrnlYC3Yi/dpm6B99fztDr6WlysvsY?=
 =?us-ascii?Q?uurEXqeNCqIHqzta3Pl1lA5zYJFyD02kwwkv4c75ruwCsDNG6fYgQ3lp++1K?=
 =?us-ascii?Q?KqPhuJCP+U6rUY2AhPLoqHx3LEm+JYxYAvUX21ckWOmfQS7g89xvFmlHd7oL?=
 =?us-ascii?Q?Hy0VYYg6xsyk7YG37xXCpOo76/V3uqN7sqMYagbwTU6jTYgaFOGbLkEz3Nld?=
 =?us-ascii?Q?Z01JCngjw52s9HFd0Euep+nPnaVi54j+QguwrN94APsBekHNXATikecR6bQV?=
 =?us-ascii?Q?j/mWcqF+AKtoG7ajnqRlO8RUCgp2ppsrRqGGENTEN4WiqNg72RhJr2T3lHq1?=
 =?us-ascii?Q?yFmrgfB6R1NScH+rDZ3CXEvWL2CuhfuaWyLDYLSbcolu4k4Z+IH+oJkFy47C?=
 =?us-ascii?Q?LR0yTiTtYwVehR7L4rKyJ+6iA1o8uHjtTAE0Cqf62iw87QpcqIlK0/Vlb8CW?=
 =?us-ascii?Q?pfdvHYzDEcXbbkLkCZp2MZT/J4kjwBBdVuMdIwnJRIsOyVZIqhNI4bu68Zqq?=
 =?us-ascii?Q?EtB0KgvLh/th4jf2imTiNSShr0BzkWRPWyyCI+vBoLwi6LBRKTlBKzcNAlzh?=
 =?us-ascii?Q?BhIEtaiGikg9n7d95cSluiot+MH2NdmeJC7VzNzr4L8Gpf+uKQl/3vI4F4s7?=
 =?us-ascii?Q?nrnNaIXqa7G3RMRmv8zejyd9kzqyQC5DqH1Yru+HHdvpcv+IAB4i2/Yj/Rbb?=
 =?us-ascii?Q?cixDS8MMDr4zH2LZpSUTNMpsLfM1dQnRSPJUaZ/KR5LZ0zS9EehiHyJLlLGP?=
 =?us-ascii?Q?lq74tspr4SyWnuvgBi65q4KIRAhzfrzXIjveKYvaUqNzFY6TCdauwxMVTrIO?=
 =?us-ascii?Q?JR+wnjCVowAouCBuk3SeGylCsDoNyB/yIE60Ttg11CESMrMyS0jZnIfu1V9I?=
 =?us-ascii?Q?4Jz2n31lB4CaAKEc59yp0F/AHQrNHEN2hHbFYjB+hWpEsiOyLXhI8go311Ib?=
 =?us-ascii?Q?N9628DFZ6s4sY7fsMzFLqiRbM/Xbf8T/wY/t2fv6I5WxUgH7xAgWuz9801QQ?=
 =?us-ascii?Q?YtbYdSf9vPYOU5UF7vnVEoNRPirhaCEs9MJD5VuplXbHGHteh9i1cFGsZwKF?=
 =?us-ascii?Q?izVlniYsLz21j4BBmgYf3sQA61RGBPYjzwfz1Awm49VkEDYS59SmQNJmxS+D?=
 =?us-ascii?Q?/y9dgENdd1M5VNGixbxYbtkuHJ+Bp7q8+1e3QVqissJsF8rWAAn7XhZapaJL?=
 =?us-ascii?Q?mvz52svm00FCANwK/j53RVLtZBjWcKj8ejvdy7lBGcf0ZkNNvK+W6D+F0i75?=
 =?us-ascii?Q?kJu60v0ggCBcrSABEkUzDLXdnH1OJM00r6c3Ul171eRwUpKP4z7E9BzHsoVv?=
 =?us-ascii?Q?29dp0ii82/L5y8EHYLkKjpHft1DHVgau7DRKyKe1yhErp9hQy6DFTSLh0aEK?=
 =?us-ascii?Q?8avbFQ3d8qny4VEgUOQcDqMgzmrW9kFK/cyDXVe5Ob0EMb0jfxavPKKVskDC?=
 =?us-ascii?Q?dtsQs5zJIS4k0hpeYMVX65MV5/qakk2KPyh9nxQ1NFmCPkMsUjFZDEU3d9/z?=
 =?us-ascii?Q?1hlqvCUenAiv2BcsXrprzPPqstN+FLZaWFn3aXQv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdb45ef-3910-4e76-61ef-08db6b159637
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 07:21:06.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+IrYhDvB47EiQhMQHzFZnbzm/2TTb7THRD8ekNLMc+OCkODj4GDm9aPfGyHDz+367VV9bZsQFvvO+e5ZbWd9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

This patch switchs to key/value "sflags=*" instead of positional parameter
sflags of do_transfer() and run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6232dfed9082..68025ef698b8 100755
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
@@ -2663,7 +2661,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 slow nobackup
+		sflags=nobackup run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
 	fi
@@ -2674,7 +2672,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2686,7 +2684,7 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
@@ -2712,7 +2710,7 @@ backup_tests()
 	if reset "mpc switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2721,7 +2719,7 @@ backup_tests()
 	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
@@ -3089,7 +3087,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=1 run_tests $ns1 $ns2 10.0.1.1 slow fullmesh
+		addr_nr_ns2=1 sflags=fullmesh run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3100,7 +3098,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=fullmesh_1 run_tests $ns1 $ns2 10.0.1.1 slow nofullmesh
+		addr_nr_ns2=fullmesh_1 sflags=nofullmesh run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
 	fi
@@ -3111,7 +3109,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=1 run_tests $ns1 $ns2 10.0.1.1 slow backup,fullmesh
+		addr_nr_ns2=1 sflags=backup,fullmesh run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3123,7 +3121,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 slow nobackup,nofullmesh
+		sflags=nobackup,nofullmesh run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
@@ -3288,7 +3286,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 slow backup
+		sflags=backup run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
-- 
2.35.3

