Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EBD1FD6
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 05:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hjqs7LAVTf7G4QuAqtDTzP++G0vhroaR8Fz+CuSBHnLxP8dLQFQ9QkXk9bi8gHq2n6aX2rOy25Wa2kYG5Vf4Zr1Ux1sHtv7L1vX6Y8pxBVZQKeYP+NQcOyJM4DquLWXdgvCfOoY07ulaEaDmHBJi47z6ZMXP80AtcgaN4ydsafUJeIqm5f+hSvubo6iKic97R/8waKZ+6H5193qolOFo8BtZYljPFFobAZOKkCqXXZx3kLsl8aDuXYS5ohN+/BaH/6nbaUqWvcDgzY0UgtA7HudlG6oMKD+oPsCGH2hTi28yXOzswbi+8y3rdmEwIs71diWLvub2+FkKWqDRTHigbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xfYBOULAAaND3fEHyQYYm3zNDbHpcTFCPlre/tlbhc=;
 b=cxXAzHTk9oXhryWHsmkcM0Rg+ff9LhckZAejkJrXEEq08Y0cmrKOwXOZOjkqbgOoFrMCgKd7zC3IjJzmOH44ypcE66O8gUZsTLuNJkahLKRYVVKWyypIM7dXqDC69Aq55rXETj2G/vRV7ElJ6WKqttFsYeVBv7qW11HRmG5mLIgYqIQShzJ6I/7FmiXUsqlsqPvg8BmtwRgzYE36BMTxJL59gSgPbolzgKgHC3Nc4IrnSs/VfeEwpGiQAIXyAhoh1WfTDFr0Mmb7qSpMcX1Gjsy8z9+4VITUdmTn/kEe/TX01TLL8NCGMtSeovcdDdg9vPYHe3Q7ZXug7pxeJW7hQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xfYBOULAAaND3fEHyQYYm3zNDbHpcTFCPlre/tlbhc=;
 b=0I9GifXUT/Ug8v9Y7WTvWt+WolW9YtMG5Ed0wPmHh7w0XsSWhsqWiw8bo+dg4ZjUF5d1LbzycYCt224h6QD5NAHnS9kbAexDeAyOKROnQhx+i1zoWBRwiAUkGclfOgan8tMeIZBQA/QnepOPFvz80+Y6xecTCielqUtbxIA3lmgFbixFVpIRxHCYgQ2nlqt/6tYghx/jHD3bsuuu4dZvuK/cHz1tEdGUgLtNG3DJs2QAT8QfXo3wBjxT/2SmbwzgsO0q9tx1fMoQSJs0zk4BeJXwjXRTfzIwBLplqyn/q0h2X1HB701ImfNwdPhlGxiwHgHjhpCUGZ9zlA+K4cM90Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 05:32:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 05:32:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 3/8] selftests: mptcp: check subflow and addr infos
Date: Tue, 13 Jun 2023 13:31:10 +0800
Message-Id: <21838269dd56ba7e86bfc12994a0dad06b091c26.1686634037.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686634037.git.geliang.tang@suse.com>
References: <cover.1686634037.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0109.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 658a69f7-00c8-4dbb-ad81-08db6bcf8616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PIlH6feGZvlG4VbNQSoKwpxtEr9AIAUknCenYwR8nAXG1yotcraCv4z4nZ5Y+5Kf68tfYxwUIJAXYXmr4uMsegGfhIcVwTdyLLR3e2YoSHVTBPcRt6+zEbz+lX07fbskV4/bm67N+NdqIWiUgK83euD3t8NM6+qTSoLGbycuCzVuVGtadDAr/c7brK7UvtPCvXJecxOK3sYXUs2KcyTOKIOMFnCrZULABJ3+6U1ui3QcqKvcEs4WfhXWt0ukitm6/rWtWUN7jkC9OgDy13G5pftsqzuQO5jizUanjIqfM8pbDa7gCZtxdrTkNxz3UOVh7y83W5VOShSzqxqBz8MEv/aQa3pRuETdHoxC2AwWnv4cuQT+/RgA1AOF65BnYYMYuz0B3ndIYeVLahKiGmHluyuxS+Y3qwy8QFAfS47MmPq5TpNhfD0f+unD+Im4mvheIKLANhZbacI6PS+2cR+f1FP2jivu9MDoK5+SkpyDX9xY5/L22YHuoTVipFd4PwrqLy40KAkgMxy3zx9XxgBaHGWf5y2UrJu0zEvPFA6JFKXA4ywviLV1VPpqEDQXunmx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(36756003)(2906002)(44832011)(86362001)(2616005)(6486002)(6666004)(186003)(83380400001)(107886003)(6512007)(26005)(5660300002)(6506007)(478600001)(66476007)(66556008)(6916009)(41300700001)(316002)(4326008)(66946007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RNoTzKcsHkGWed4Bm48TNcU0UxnoyqCpYjeHOlK3cEzr2pkAVZ1+ZAil1yiN?=
 =?us-ascii?Q?mEJOAvciSUDg9VjMIV3Hloz9QqaVxzLHl0vXtWtgD/5NjbWyJ1BpruULGm22?=
 =?us-ascii?Q?MMTi23RuD+hxlRIQIfOfo69D7yP6H/g5LTpkZPSP5ajRBm3FcexDol6PQPHF?=
 =?us-ascii?Q?Dy+e/klcbh6Ze5tGqzdr2is9p7QCla05Gq4elCmXAJH664+nCJfzWT0mWvHC?=
 =?us-ascii?Q?7wdIR4nZiqN75Yuhi+yPI/KQh/UvaXD5ic+q/dKaowOKrAGJKD/AaP1Tp32Q?=
 =?us-ascii?Q?cSAB0SPdUua0SnSekYrNhSKkpkl1fHPqGlgWet6zww8cwX4UAwoHnoj5Yccj?=
 =?us-ascii?Q?Y+X9hIXzS14/DKpcC3zqlzxv4+jSK2SEVdZx1ZDzeNshUdWPcIHKH2LoNQL+?=
 =?us-ascii?Q?uwkjlx/UqnQNjWK2bJhpv1RyQ6tH7iGM8TVsaMaNjEmmGGLHev6ogcIwjJFq?=
 =?us-ascii?Q?1ibR7qU/xcvtlw8v6G/G4OLh1eS3fkUBi2OoOaEHNQp6PYlpDEYz1D1BSTMp?=
 =?us-ascii?Q?h6NL5VOCz19NtP/BlprS3QXmc3TxYjmzmG2vjBLqykMYWaPZ+z5clIIZxIpD?=
 =?us-ascii?Q?vRIj6RZLUPOscBsapJPF3cgBWhHISM5pVqr/dIlrVYV/B6eU24/AFtjIgSGa?=
 =?us-ascii?Q?cwUx/avMkHu+LO1P+LKdiJOEW+PAtCxZHtX69cSbN4QRUxrp3l8uD+gJhBJW?=
 =?us-ascii?Q?kDvDojs8Tl48w9XJtY7Pnq0Ats3Gqfz5Sb2kdkekldJEcnufmZrVsNAEBDOp?=
 =?us-ascii?Q?4vKcFvq+4egpeSnccJZAoNx1ffNbph03MTXsU20Z0qEiQ03gaRKqgVua1v8Y?=
 =?us-ascii?Q?yBLSEvyXsjBrYK2i0vqWgTjRzFmnQc9Na45FZiOEL6ZbId02USa2IzuUiOXo?=
 =?us-ascii?Q?p79b8dQA/bbm9eUYW3S75raGNtI0Gq9oU9XE8WJJu8uQisWNEZWLU/fPH+38?=
 =?us-ascii?Q?F91zwCT4HJbGz1SMooNWiZrCUPNcSQp90lkepsunploJxK+5ekdyDzNIr9zD?=
 =?us-ascii?Q?EoUXSftoCJvg/8/5br2CBO+0mH53jAuFut7B99Qg3dpTUOP9o4cgBQkBYWhk?=
 =?us-ascii?Q?ZYf05THyJzxkM/b6nTVjffIlBFU10P4z9Wxadb4Oc0ZrpUjDF58bQmMrlVKv?=
 =?us-ascii?Q?nmJt4sQVPhocHQcKTDdaAKhaH6Xg8e70+YF9Qn5FYNNbPu1eGd9H0Dq0UfMf?=
 =?us-ascii?Q?0i6xOWhR1JN5sdbUq84655Kwl8zrZbGiDhUEJ+k4KNnLSl7CM6oYuMfeRGzB?=
 =?us-ascii?Q?d47SO9ttU28hK/ZXWGgDtKmtB3/WpZm/qY8xHoGPRfnsMrws4xQr0SteAw/6?=
 =?us-ascii?Q?0HFa7ts8pKZ2EilY35sm7cIzBR3lpH3Qc649zXBM6o7V5SjC5E0JBXO0ySFh?=
 =?us-ascii?Q?6ytkWnErxqwOanfie4P1rPnl1b2VDAEDq/hZVD8EVefjqlyxlcfz3nVEqgRW?=
 =?us-ascii?Q?7bQhi5gKDIWRKMFANLS/blqeYo5kIdBxNmGIBoXS5NdpjD762Bqn8vlr++fd?=
 =?us-ascii?Q?/92qDVNxhvQBxuxZ2yAMFz+sYVoOpgt30zBA5Dl0Q77lZG5ey6tTXzlW5ZXs?=
 =?us-ascii?Q?tiHp7Jq0VYt4MqvhBvQQeaGJW1YLo/gIvjHzQMd8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658a69f7-00c8-4dbb-ad81-08db6bcf8616
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:32:05.8571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3KoYhDzHIeCVGufSIqwwrvhQz9z+VJ9l9BUwi+f2yB+tqu4y9ok8hoKZXkLxu071ZGnm0Fx9OpInmOzNerHAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504

This patch adds more arguments for chk_mptcp_info() to check subflows,
add_addr_signal and add_addr_accepted infos of different namespaces. And
invokes chk_mptcp_info() to check subflows infos of userspace PM tests
and endpoint tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 48 +++++++++++--------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3baa6ac3b03e..3811a6c3dc5d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1832,31 +1832,32 @@ chk_subflow_nr()
 
 chk_mptcp_info()
 {
-	local nr_info=$1
-	local info
+	local info1=$1
+	local nr1=$2
+	local info2=$3
+	local nr2=$4
 	local cnt1
 	local cnt2
 	local dump_stats
 
-	if [[ $nr_info = "subflows_"* ]]; then
-		info="subflows"
-		nr_info=${nr_info:9}
-	else
-		echo "[fail] unsupported argument: $nr_info"
-		fail_test
-		return 1
-	fi
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$nr1:$nr2"
 
-	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+	cnt1="$(ss -N $ns1 -inmHM)"
+	cnt2="$(ss -N $ns2 -inmHM)"
+	if [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; then
+		mptcp_lib_fail_if_expected_feature "$info1:$info2 SS counter"
+		echo "[skip]"
+		return
+	fi
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(echo "$cnt1" | grep "$info1:" |
+	     sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt1" ] && cnt1=0
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt2=$(echo "$cnt2" | grep "$info2:" |
+	     sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt2" ] && cnt2=0
-	if [ "$cnt1" != "$nr_info" ] || [ "$cnt2" != "$nr_info" ]; then
-		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+	if [ "$cnt1" != "$nr1" ] || [ "$cnt2" != "$nr2" ]; then
+		echo "[fail] got $cnt1:$cnt2 $info1:$info2 expected $nr1:$nr2"
 		fail_test
 		dump_stats=1
 	else
@@ -3332,8 +3333,11 @@ userspace_tests()
 		userspace_pm_add_addr 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
 		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3348,8 +3352,10 @@ userspace_tests()
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
 		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
 		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
 		chk_rm_nr 1 1
+		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3369,6 +3375,8 @@ endpoint_tests()
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
@@ -3389,17 +3397,17 @@ endpoint_tests()
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-		chk_mptcp_info subflows_1
+		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
 		chk_subflow_nr "" "after delete" 1
-		chk_mptcp_info subflows_0
+		chk_mptcp_info subflows 0 subflows 0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 2
-		chk_mptcp_info subflows_1
+		chk_mptcp_info subflows 1 subflows 1
 		kill_tests_wait
 	fi
 }
-- 
2.35.3

