Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507AB182B5
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 12:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btGrjgtY7aZx6keij/DRSVI5OLLuv4SGTMoCpIiAsSQPvoRiwS5ZwO7ArdahptkHLlNvrLmKvvZNvkQFWEfvNRO+VcjwTtad28BCj2jr/PEz2Rawr6bUpMtRZnaNx3AiDcDNCS06thftBzS3AVCCSIh0kiUMKzfubIQeqyuYaWSq8OHyt5YBctpViArdmQfzT6G9Apr7WknFVt02vRNeDYRauC9Pc0BcLsA6qv1dgQCOV8sBGQBgfTgS3m5g/JI/wY1icPJ+7o8jtEWcwQcqm8sNbyn01S0tTT2UgzheF5xJk7qij3fJPTkDFC5TVhljegB7DvTHTKkwm1kCkF9aGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHbq3KeL4VlNc9gcJ6JoSY+REQSAW3iFLXrKOq5SqIk=;
 b=nIEDE0oryNy30TFMPr4GsOCo35eFL+aVwK/Uh7Tqtk+9bKBonZhOJ8QLpOW4+w6CPkSiHv8MkRs3s+95iPqYpcNN3Ohm3C4EyQQM1d56oAG9zYaKLzgYvPgEaAbC+ragNRu76xxKsJ/SjRYebnx9HgLGTm80gOzn82CAfy4S13QMDv9DCoBrm2IEuYbqViqX+gjZJ1ycQWppjeMAgZyLYYqxxcr3zJ4uqauPBBcqfjAAPwy80Yhu/HqB1gfJ/uXCSpITwt+zDdeYklZqi06thc9u4q4oVPB/FDnuEnwcntAjTGkPQh9prezVVKYPcNBd1kSVkuQBNBvlkXs1NjXFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHbq3KeL4VlNc9gcJ6JoSY+REQSAW3iFLXrKOq5SqIk=;
 b=fsR2PlOmQ92z15Tx9la+OBzOMEm927rLm+3l6xnwHHZytAW+6KQ0hDwuZt3C4kS229GtCj32/ltLPavPive5X452OXJmxHp1qb967xjCXkUsB1PAXoMokNWoigVizkSynJwSR3MqbLdPkfUEu8EwxDTm6T3E8s/6LamaiKUqY0crfG+e3K+T3dFyTLhm9NRs24hqXUDef5eRNyEZraW4T8BHYGscPJ6N2sHLG+pgAgEwJvUxsdV1ip/DXJqkCp7I3Zg8QMcW5f3uvp6BuK48DzTX1B8LAoLvgsFve3jbjPqVERXg0KKF4yrDj6g1gnZgLDFkUqrVI8fnpEDbXlSRsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7420.eurprd04.prod.outlook.com (2603:10a6:102:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 12:31:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 12:31:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: remove id 0 subflow & address"
Date: Wed,  9 Aug 2023 20:31:20 +0800
Message-Id: <20230809123120.11764-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0231.apcprd06.prod.outlook.com
 (2603:1096:4:ac::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 62691998-2aef-4907-f630-08db98d48292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	StJx45uhzhsTIMsLU7s+jA7EsAW2nCDH9o2fliPvaJNF7ELiImnnhYR5fj0TnhOGlemSrMSlawcNxaO46PI1vYxsrUjRo39E4dxGwevGqImpD3C5PA4zkbjI6CxHgzZydRJnNzsF5lw6HHnqLWCRaCiNx4x7q1EtjJyxzgEprtNtKZl/nwKGMSkJgGOdg1RGEvl5/rQqBscUyxxEMOtbmHkvS482S469rzDaKl+G/AeFnC1t+bz2pIYaUhutxl1JKh69cbJkFND4gTGRdsO6z9PBtHy9VLgrxfXaeCnr2jx+MzHMmEMIwr1ynw7Hgy+vOjbp/YT0+rNoF8jGQy9ScnJPnZo80Q2tX6NlNRdYrLRk09GXzJ7p81efoCt3/L316C31sWNiw7P1mcZRc87UGRvdCvemlQMKMRA1K5tUfTx14gF1b/vGXq2yu6mr1sabNXw5K1u3XjtrB+Vj5DoWavr0w6mdPavY2+EOI6mrL4qjWKhqG+zLmi/TLM7mYDkY6zA6LAn67khHzdM1SVulDCdSbvKYyvkQzsW+RUUSE0eAyIcFsGCJ/HothPKTxCNLxab0FqmtkozdJKBWPIBKdOlQIF/eyeIFWW7TByXlL2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(186006)(1800799006)(6506007)(26005)(38100700002)(1076003)(478600001)(44832011)(5660300002)(8676002)(66476007)(66556008)(66946007)(4326008)(6916009)(6512007)(86362001)(316002)(8936002)(41300700001)(6486002)(6666004)(2616005)(107886003)(2906002)(36756003)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PxLL7OiGvwvX3zXYzJJWikShWpKPA7tzWFAOJqi+8qk4zEXR4LE6KlVxRG7G?=
 =?us-ascii?Q?+FFXCe9otFjKtYnBVVFzFU2lHqKuCPzyZbBPHOYv/W1iAtRQD3c5bKH6I7Hc?=
 =?us-ascii?Q?8ccKqW3pbgyfcjUU5BqEjpGQgi6jeDkJV+U/V1j45x8uNS3SLtSYNTr0pYcQ?=
 =?us-ascii?Q?pq4GpeCbHcEM11di7JBNxayqJq3nUF03RNTYqJEjNCXGGU1nz6Tgal2meebu?=
 =?us-ascii?Q?6X0e9GhLM7wfLBIOUvCljzSQ0jHFvtNahA6+9GKbG/dtAICws8OLDV4MT2g5?=
 =?us-ascii?Q?YwjhdP/z15koMPrKwuur6kt432UzOaujPPTnZHvDZeS8T3U0pPGN7gj4Gb1V?=
 =?us-ascii?Q?Lbb0PGA3gw39DDVUF0q6rOf9syXS2c1oQxAUIO1rLD9rsbTVNuPyjJa9xMXr?=
 =?us-ascii?Q?Nb7zaXKeWxvJ2NGgm8A2A0tfKCbXrjM+E6hI1IWni1shngMgvxpR8v9vcoZN?=
 =?us-ascii?Q?K/gvarwMKGsRXOYVl+TwrFUZV8JbImgBsGZNxa7C9U3GCvbbpCI5nCzlArPt?=
 =?us-ascii?Q?bePlJKIJK21QUFoM+7HJZinULAVr4guAG10g0f475lOW5n7bNCVn6I/nm48x?=
 =?us-ascii?Q?GM0pYPqruGITdkcjMx0+xrrHU1gPB60CQ/Bs9fbMzvy4RmYy6D9TExXkNDIu?=
 =?us-ascii?Q?FxQVv8xEWXCagAXvu0mSKagxc7KHqMM9CEZi6h3pmyVNQrhU9woBWJiZLEJd?=
 =?us-ascii?Q?BTvJo8yMZMnoxjHDR61KGPybZJU0MLzJz39dqp2eO64rcvNa5B/4VyMRrteh?=
 =?us-ascii?Q?rGbUZkwMNf8S0C3xGcviGD1/uz6YKQxbie2fnYpszB2nazYxVqLKqn2CG+K3?=
 =?us-ascii?Q?w8wYFj6hMKmjl4BIxPIMzvGRqmRn16h9+vhMHkNUEwruOZtvpYA0D24eoCI4?=
 =?us-ascii?Q?j1sp1VCA/W/xs/R/tL6X4V9d72BjozMIYnaqIJMCaTtQcnVNu+dPK+VFPN45?=
 =?us-ascii?Q?llcwru0kvM3y4WieUngJveCfqEiCQznCVN79XTPrgjZjJd3wSkN0pqqmxFvT?=
 =?us-ascii?Q?LwW9QXUJYBRHvSz22r+SOABvRZdh8jrKUvZVt7JGKlcYQNrEEGD3/V2EfFcp?=
 =?us-ascii?Q?yHDQpqoaTh1/+OV+N9vAoDeJ+BsRJVAUiZnFt4mW9Zjv1BX7UH8f8Lhu1ygq?=
 =?us-ascii?Q?17J3Hji2rizLzo4jw3PnfqwxAOdXCSdcB48qQITDlg3S39hjOITtD78WaEo0?=
 =?us-ascii?Q?o/OLU1/Z7WyUt8SxCMs/hFxjZGbYIqJJroEQVlNpjBPHvsjUl6nGD8TTKqu0?=
 =?us-ascii?Q?b1xb2UWOFSycxm69D5enRRx/PXd0gTFeIR7Z728vSDFvvRocVBDrrTwB2mBC?=
 =?us-ascii?Q?+psqEK43Aj3CzD7skM6MYpq6VuSa3YEbLyuYQswHJxR33N9F2khfM4QKM5Lu?=
 =?us-ascii?Q?+vPQNCUKD9DU5k1IReQpP16XsSTY9nADBAdm8QA1ObLU4yuEwohQulZZqeSb?=
 =?us-ascii?Q?bxLdxxC/LJhfHHy/2vspyTyAnTonWq4HfYvLO9cPGZYcnNOklT2CM+8enpIK?=
 =?us-ascii?Q?X+nD9L8mJrfYbHMeblG9RvskpKs87bgaUfmZ4KUXCnB48QPAIhxSvqYQ+ETY?=
 =?us-ascii?Q?UY3zYNf6wnWnPDGXRcrui+WYV44Qo873bdOSRSXa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62691998-2aef-4907-f630-08db98d48292
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 12:31:09.9194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MaCT66ADiwfqSwwTVny4HkAnrrmLJynOGuCftrQ2vdlxPcxuaSnPRJNe2wBeKe+b9HtSfptX5T7M+qvheZjGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7420

Remove redundant code, put two tests into one.

Patch for "userspace pm remove id 0 subflow & address" v2.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 72 +++++++++----------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2ced5b5c64ee..b00a1634dc09 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3339,7 +3339,13 @@ userspace_pm_rm_id_0_subflow_or_address_ns2()
 	local tk
 
 	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	ip netns exec $ns2 ./pm_nl_ctl "$1" token $tk id 0
+
+	if [ "$1" == "subflow" ]; then
+		ip netns exec $ns2 ./pm_nl_ctl dsf token $tk id 0
+	elif [ "$1" == "address" ]; then
+		ip netns exec $ns2 ./pm_nl_ctl rem token $tk id 0
+	fi
+
 	sleep 0.5
 }
 
@@ -3458,45 +3464,31 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
-	# userspace pm remove id 0 subflow
-	if reset_with_events "userspace pm remove id 0 subflow" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
-		set_userspace_pm $ns2
-		pm_nl_set_limits $ns1 0 2
-		speed=10 \
-			run_tests $ns1 $ns2 10.0.1.1 &
-		local tests_pid=$!
-		wait_mpj $ns2
-		userspace_pm_add_sf 10.0.1.2 0
-		userspace_pm_add_sf 10.0.3.2 20
-		chk_join_nr 2 2 2
-		chk_mptcp_info subflows 2 subflows 2
-		userspace_pm_rm_id_0_subflow_or_address_ns2 dsf
-		chk_mptcp_info subflows 1 subflows 1
-		chk_rm_nr 0 2
-		kill_events_pids
-		wait $tests_pid
-	fi
-
-	# userspace pm remove id 0 address
-	if reset_with_events "userspace pm remove id 0 address" &&
-	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
-		set_userspace_pm $ns2
-		pm_nl_set_limits $ns1 0 2
-		speed=10 \
-			run_tests $ns1 $ns2 10.0.1.1 &
-		local tests_pid=$!
-		wait_mpj $ns2
-		userspace_pm_add_sf 10.0.1.2 0
-		userspace_pm_add_sf 10.0.3.2 20
-		chk_join_nr 2 2 2
-		chk_mptcp_info subflows 2 subflows 2
-		userspace_pm_rm_id_0_subflow_or_address_ns2 rem
-		chk_mptcp_info subflows 1 subflows 1
-		chk_rm_nr 2 0
-		kill_events_pids
-		wait $tests_pid
-	fi
+	# userspace pm remove id 0 subflow & address
+	for type in "subflow" "address"; do
+		if reset_with_events "userspace pm remove id 0 $type" &&
+		   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+			set_userspace_pm $ns2
+			pm_nl_set_limits $ns1 0 2
+			speed=10 \
+				run_tests $ns1 $ns2 10.0.1.1 &
+			local tests_pid=$!
+			wait_mpj $ns2
+			userspace_pm_add_sf 10.0.1.2 0
+			userspace_pm_add_sf 10.0.3.2 20
+			chk_join_nr 2 2 2
+			chk_mptcp_info subflows 2 subflows 2
+			userspace_pm_rm_id_0_subflow_or_address_ns2 "$type"
+			chk_mptcp_info subflows 1 subflows 1
+			if [ "$type" == "subflow" ]; then
+				chk_rm_nr 0 2
+			elif [ "$type" == "address" ]; then
+				chk_rm_nr 2 0
+			fi
+			kill_events_pids
+			wait $tests_pid
+		fi
+	done
 }
 
 endpoint_tests()
-- 
2.35.3

