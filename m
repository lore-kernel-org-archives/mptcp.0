Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2041.outbound.protection.outlook.com [40.107.15.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527852573
	for <mptcp@lists.linux.dev>; Sun, 20 Aug 2023 12:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCnBbIXUjooYDGG5/IE5PMOfCh7twOc3ckgzZG8zq2KOOn01NbeRSHNjp6ntawnDuG1bAZSLcaxZTrw4KtQAbb0se7Sn+UN7moGc61BFulL9ndhwcZFEml+xAHCUvowW8ypvqZogJMFUrUGtwmWXMT72KzPgUsc+FiwpkdI8qV5Z3r0r00hnui73OZjplNIxvZVazL688Ao2QB9tnOH6kIMRG7cT+rxfqDyM2KT7tE1cqO62H7fQRuhnP7ezbYyUtHMYdv3xrtwqlBHVGhdjxA2FEWiFQ5tcDnf2z3t/HYEk0GYOAuGusoM4zGN1g9ZC1wve4bD/TknGhD9dCuAjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWldUGZCI47TqFRqxAyRalhqPtx+CHt1ZEbaepdd53A=;
 b=JHIWYI4bog8lvEGDP1B1QVL1YTjFs5LBMrkzJ++J/Iu0Et07JcMSbo5F96+pI3dHsUpmv5Iwn3c+kckLYl1CApsK1jVEDeGC5Y78o+AotJTbnPFM2bbx6Ss9H8bnx4Xi9kxutZ1XVrKHHeQiA3a5avw/4A6b46UoONZ/OoEanpSl9uTdIjOpntBjeEFjd7y5Tgq7Ld57V9ECK4xUFgg/0RKY1Jx3lim+gGS9hA12Fe1n3yN86v9sK0MxErM07zFZbW9yDEYsArhpt1wpxcc3aU73RhCkkfyCzuNVV0X+gsw7gHiBlU9vfjfQpk5akigxf5oAY+R3Oj19xmq8laX5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWldUGZCI47TqFRqxAyRalhqPtx+CHt1ZEbaepdd53A=;
 b=pm9iZf5d9aqq7ACX3kZLTu7qXAqOIAE79ZQCeBlI02d2G7TK0EsSt9+1K5890R4QDpgL01LoZdb99OrElP3QRDVYssD1utzv5NPdzah6VSF5LUxnkO3CikRh7+Swg2wMPc45/DumYAvuLMpbZmNjo+JBvkp99BvcsB2468/+JMz3PlrS4JZ8rOn+lfDcopadsyFihJTGNkFUJxwLtrnritOyIZCEezr+QayoJha3q5LqJ00EmU7eGSyATl1SWSggDkqgfgnSauuMKi19j6n6S+ETi2vbMhep+SpdBXwcYh+GM3Gks9xhQt/ZmZz+QwapYf6B72fmrxGlAg7b3ER1/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9523.eurprd04.prod.outlook.com (2603:10a6:10:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 12:06:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Sun, 20 Aug 2023
 12:06:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 3/9] selftests: mptcp: userspace pm remove id 0 subflow
Date: Sun, 20 Aug 2023 20:06:34 +0800
Message-Id: <e6831f22bb2f2f3918ebd820eb3365f4eea4fbcb.1692532859.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692532859.git.geliang.tang@suse.com>
References: <cover.1692532859.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8d700b-0478-49dd-68b0-08dba175ecb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HHLG31qExrjVKVw4QmyG3450qN14bENFFZBbiLDN8NytRVA7P3V2NDXH4SX1HmN7jqMr/wDYTCgvnGTQLOw1zRhL2dcXcvyPPwbpCe6/4tJq0sz9Z9V9vJQNM99Wbhx7lMhDbw6uAyMd6sUbkFstSq8odD9xdnd8gNKYpdHRo1DEJIOptP/exBr3O/zC8UkaOrY7HqfolKeWMqjw71p8dXAHsLaPpAo3LM5zIYTzVTXenecVdxE1xOMCh0lYBDK9r0n0QqTC4C+X+9dLsI110kzomi32O+og7ZZdjEJXmOSYLKq7qiBrpGo6DxF2gxwMFwwhH2mbebAJL2XDOY3kxwCID+GtH28B0BbvIoLgGof5LbwhvJlSpcx7Y3YrE8mT28w5Hh4iz8pi2jvF2FHuLK/DCznGcF7h3cjgwpOYNLR24uNEugkjfFQwFwAeyf5t/j/gqpzE0+z6Zw2YVO+6VC4c0Cg0T3ie7UOs7hoR0GV7OlM+Ssh8REdjYzTyLcxh3y8mFEBK4jKQwFAQU986lU/otfaf7ksrS4SuIKCfHP1BdK302tfHSpf91sSEUHr+1k/v6nPKn8qdm/rJzMZG1C4RbohCFIVYmY9ljtVbVGg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66476007)(66556008)(66946007)(6916009)(316002)(41300700001)(38100700002)(6486002)(6506007)(26005)(6666004)(6512007)(107886003)(2616005)(8676002)(5660300002)(2906002)(4326008)(44832011)(8936002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ypZNJDOfPXMnikfPDGvLNn2qHRzGf30qulnss6sO4LR4kBQ+LpavoTzqCaGX?=
 =?us-ascii?Q?9gzMwY5zd6DNJ0Vo90Tq+pN1+InXWshrIb8MKZdNBFIVDhiV6Ocz/Sbjgp1z?=
 =?us-ascii?Q?M9GtfEYnqR/iINko17z22O79f3LujqpjJ1lNHhKIdbwROM7U536t3RroDLGJ?=
 =?us-ascii?Q?TVI7qsymNku3OJB1Wliw2XtscJSrgsUnbmRLQjI46lXISfoon3sC1v3ELgHW?=
 =?us-ascii?Q?ECa3+Dzonqp4f09Mrv7eNfi2D/CQboogAlXD2nrCtob3NCB6V8qIZJrwNC+D?=
 =?us-ascii?Q?AjrGIpllMbPEBXYRX5twGBLR54ki27ly0G+DSwpV1RTrE5UMkvZ7dhK4Apr1?=
 =?us-ascii?Q?8+SC8ZYwhrXVzZTNr0wDBkoYwwM5DE793zEZmkj9Z2jgUlzlu3J+X86MfOgP?=
 =?us-ascii?Q?ASeQ57Y3iJfln8ahtlhG5LESeXfNwUKYsSiUWB3E3YnAweSZFjS966I1USt8?=
 =?us-ascii?Q?LlMavnYEOlsRLabRoo2repVYFe2EMe2EBIp8nH5A8RwVPQ5ES5jbEDveRHFe?=
 =?us-ascii?Q?TriTRt9/4y4URKa1tF+Ln3MgYcSO/9U45ynKA3eX2REpq9b1PgKihWXqIaCf?=
 =?us-ascii?Q?KUfYTNE6T1w72lv5JS0qfy9Ppy0F0L/P4q9/8igS+arRYsxboFMzmHQqN3RL?=
 =?us-ascii?Q?bl2TW1qX33I4MgqR7rq4wrHlh0d78o34elAN/omMM0WKTou5ZW8KsmXaDQ9c?=
 =?us-ascii?Q?h2MEBiICMyRNW+lL8wKN+wblUsqAqQjTDSMuZ3RVlWTGaV6utwnjHsCXfBaD?=
 =?us-ascii?Q?SAG9L2KYVdExEOzvtfQt3Ha7Kwsk/twwkEr6jeRWR/cbKJgdzSbVx4wON/+x?=
 =?us-ascii?Q?KVpIOEAvTPP7Hot+RNRz0aFYX5bO7zAV8DwpZQ9AeYIjy7Bz/v6N9qjVf/Aj?=
 =?us-ascii?Q?ht9pj+2zQWXTrBXvpmWbelLRwflvJ8wgdtp8yqkzzhgY1ILH6Gdjxus9KBp+?=
 =?us-ascii?Q?SkHvf2mc6/lyWVirb9YlS0rYbcClasiYbh9LAp/FVbNbbMUL2C/bTeYWND2C?=
 =?us-ascii?Q?dO3fRLmV2o4Q7RAFlHFOCJ3PL6klf2O1ad1+MhPMZHOXz6NZyYHVM89/+Gj7?=
 =?us-ascii?Q?DCjQuKkHJK2FhqH0Yo/MOH8DwEOVL05e5od2qdqDTCoJaUwMTOUehy+Gklyo?=
 =?us-ascii?Q?Zfqpxy5foI4c2ugUBNwJjzc+d3LCZx9qZrN/20jF7hFirR3kOoya3ZCIzLCE?=
 =?us-ascii?Q?Q1yDoJjXXhz2BlF7ke9BYzEP87bD+dte7XOAZe66wjLEqD7lL7BbzxE+ZPHV?=
 =?us-ascii?Q?hZRWIqnDRGchyPFZPiw8XAlK2EtFTV2K1YY8LzMXePTDpSgCW6M9SSY1Yde/?=
 =?us-ascii?Q?QxIgmDf4v70imgksDFwMWMdfm70CUhVfRmA/Hq6BzYzJxj/Vn7VTAiYogn7o?=
 =?us-ascii?Q?8id4xR2rEkL9s7bnA2L5NYLqcraKtommPuEO9j/rhv0rrqQ5v62mdX5YbTfX?=
 =?us-ascii?Q?BzQc55vgQHwxd54/lAGINGJFmKWlUvSNQktJSBHzyAlYY+/GQXRWzu07GPDt?=
 =?us-ascii?Q?+nqh7LFwsWg2pBwJ7P5JcxRJ1iDjHPfW+wdu6oqms/Z5PrTfupXOKylp7ysJ?=
 =?us-ascii?Q?agxEuvQJ76jeLDEesuoxSJpbq48CLAaUfC6IjNXR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8d700b-0478-49dd-68b0-08dba175ecb0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 12:06:45.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zybAA9uPl0Q9Igt6VG+R5BX8ihauIpIGrNTziXeIYKmT+jkNwVf2UJZkON4M5tfSHoZE5ep2FUGMJ9GapOzIUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9523

This patch adds a selftest for userpsace PM to remove id 0 subflow. Use
userspace_pm_add_sf() to add a subflow, and pass initial ip address to
userspace_pm_rm_sf() to remove id 0 subflow.

Add a new helper chk_all_subflows(), in it use 'ss' command

        ss -ti | grep -c tcp-ulp-mptcp

to get the "correct" amount of subflows, including the initial
subflow.

When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
false, then tcp_disconnect is invoked. This will send a MP_RST to close
a subflow on the peer too. So chk_rst_nr() is added in this test, and
chk_all_subflows after closing the initial subflow is '1 1', not '2 1'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0e7966cd2d39..0ca1ae7acb68 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1883,6 +1883,31 @@ chk_mptcp_info()
 	fi
 }
 
+# $1: subflows in ns1 ; $2: subflows in ns2
+# number of all subflows, including the initial subflow.
+chk_all_subflows()
+{
+	local cnt1
+	local cnt2
+
+	print_check "all subflows $1:$2"
+
+	cnt1=$(ss -N $ns1 -ti | grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti | grep -c tcp-ulp-mptcp)
+
+	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
+		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
+		dump_stats=1
+	else
+		print_ok
+	fi
+
+	if [ "$dump_stats" = 1 ]; then
+		ss -N $ns1 -ti
+		ss -N $ns2 -ti
+	fi
+}
+
 chk_link_usage()
 {
 	local ns=$1
@@ -3439,6 +3464,28 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 subflow
+	if reset_with_events "userspace pm remove id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		userspace_pm_rm_sf $ns2 1 10.0.1.2
+		chk_rm_nr 0 1
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

