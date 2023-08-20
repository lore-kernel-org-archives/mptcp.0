Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B7566C
	for <mptcp@lists.linux.dev>; Sun, 20 Aug 2023 12:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjYnMFGyBIAdZS7fZh+iS9ECpeaiE4vKg/UxOjnaTtIOG5YvnpJdoc0QKohmRUl6r3bBwxrDqKp3qxMwATrlBuqmvv0G/gwillmLYxUWDe+B6bV2A4FVOdlH97zMxgUD9BvvpFkbK9Tx8Cd1Gyk5c7bqXgzzZZnnR/7Ky8JEneUCvJnYJSZ6XSUFu2YXnGKAAxB68YpIDRApgjYhv+w+MXrPV8j9X8jQHL1djkyQ95dNdO/BNDQAoPMjaVW2ymQ4UkcLpCpDjL0xeIrVZB/rLSiegwt/tGSM4BR5hV3kXzz8wesB66qwO0LVJHB14Vc6wr0cy5U982Jt6SXlVv9xuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yci0YSKuLiHq+3V8DMk9GweN5R9eST13FHVUzWHgFco=;
 b=dksq6yfnTSPQjbIkDE9kb5aIffNQicDljUxLyczddlZEKP23S3n3JF54IFpiC8J1FyaklP4nymzqlxmfKhN5/hAu/lqZqu3ivNOYS9LiixrVBu2mmmR7Njj8wfxnI6tUoziYy7Q/m8EZVMMK/DLQ1BfNDOzlWzZhDEkInkEgKLs+kjCL4gEJmGTvtUQkoCHqltA0Kk02tk+tJ1wetBBEYdWcCzOu75a+KmJTzndleE56j9GVyevi8gTbrdWR6MXNn9eDt0RRbzWn3BOcevw3kmzyF3qV/mnSHv2C/3V0yKGiSFU+j/Zob5NIDgiSIzoFFeC67frXIKhUMn0sphonYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yci0YSKuLiHq+3V8DMk9GweN5R9eST13FHVUzWHgFco=;
 b=B5xyw0ByPQJP//BbJF4bF9kQDrg5kYOce6h3oNSW3juAUU2b/cj6Yng3IizYllgzm2TaTmNYdtUYQ2fbGV3xk+CwP15W/15l+WS822OxZtYHERsDW3jOWLXzxdTyuHSeN51cMGjX711UIBpDe4IOYRrzvXIlJ08Xg2kBk/vE7cPjFUNAW1lm4C+0bLO9SVSCahs9nrbgiov+MzTQcHWHaWSxV7IXsyJfhIGWnsmLlfU+ZdE15YvosfISRaJfeiHviytPCwNQWlL8DQRgvV55EaThDo0abFAbvOtRd96dtmKm32DawxrdC9mWx2swz5tH+FMTHV1d252LXdNhZ1Tb5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9523.eurprd04.prod.outlook.com (2603:10a6:10:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 12:07:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Sun, 20 Aug 2023
 12:07:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 9/9] selftests: mptcp: simplify deny_join_id0_tests
Date: Sun, 20 Aug 2023 20:06:40 +0800
Message-Id: <32439b05aa5d0f5f3d2481e9a551a2c45f2ff15a.1692532859.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692532859.git.geliang.tang@suse.com>
References: <cover.1692532859.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0196.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: d95b1847-8946-4b5f-f448-08dba1761323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7rFK3eqfHxgJ4WaPnnBrKv+ho/y/njqfinQtX7gUXkdCV7QWIhfa66Ox5AFecVZe4PisKmPHfmhtAyEkHvrPGcWhT2q3NmaTLtnrgBC9EagnddiDeMu0F1gCGUL+7ycg4dK2PXrmPGXAH0TRwsvMwpxWaivv46Az0nqAaagq2X78X+5GyujK4ZkZI92kKe1Wnzyw6b3D2cvpulvA5j2II/CYSzZKi2vuQ1zhEQWLewIUc+XE4XkDAnVYdLJTJNvAPyllN2Y2e4eiMV+i/ykvi8nGQF2L9Zf0eXW/WNzKqFiEGiNM4TtOdAcbukmtBNTyxP7PbyCZtBm5O4Du5dK12dGr600x6LvTuBBIxKZpth6LZp+GSSqAnp8+pxcQAmAqnc3/Ba8ozHdHmxHksiDpjWEfSO5pRsLTfdpHLzESAlF7MvLTEdcCnNsAQAO+xgmecehz6ba1SXuTylNX/RlCWUMpsMJ4suIYiry5CzGT6XM7OMXNmJezahLtpoET1ft9nvFdv2hh6+1yhaqKMR3MZm2jMpSN3RKq+rye7VyRKJfrK/yP2WZRLnkk3dRc8Q33oR3CxMTNn181NDld1bNE202KNnfyKrToPmMxeYxIwck=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66476007)(66556008)(66946007)(6916009)(316002)(41300700001)(38100700002)(6486002)(6506007)(26005)(6666004)(6512007)(107886003)(2616005)(8676002)(5660300002)(2906002)(4326008)(44832011)(8936002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wb4pSUoSlgtzfN2ReeJTmtD9R1y83BOsQLMPBq3WOvUBc2l5ERZAubdqgIfu?=
 =?us-ascii?Q?ccsQyN3000J1qY+AJUgvSyxiDL1Xd1wSftha/BHDveZ6vOETSMoIeDYDi8/N?=
 =?us-ascii?Q?0svTxiZwK022lmGZkKwBJjyVBsi5Ou4ddCp6tM2j3DkohwOxhrwNBGJdcRUu?=
 =?us-ascii?Q?36dwhs/ald6WTsjJ8oANBegWa5EIvIseZm2SdYQ0kNvmW0H3M6St8p4vV5Uf?=
 =?us-ascii?Q?coP6PX0KlCK0YZoQLJnN7cidjN3idxT7wiPyvygzAm0iw89t2bYY6rK4DAQE?=
 =?us-ascii?Q?cZlaL3gpmPpmVRkXA9CQBuSBooelM4n4UiV2zRHrsKkqULtXAo+3dJ36DQbJ?=
 =?us-ascii?Q?7YP6cXp97knMIbi1CqWzrmJuEZ16rHCPK2RIHuzOUaSJ0Zk01GesAQKknQsu?=
 =?us-ascii?Q?i6iCUWAow5Cp2NrosGdP5BLaPkQdiFgHJS8G31mzbiyOvgDNnke8TZ6kh/td?=
 =?us-ascii?Q?I2mv6XcGLz84RJCMrdfCEphFAW/7bULrY5AniFYClneRC0zS6C1fEDQqZTtw?=
 =?us-ascii?Q?EyliLH1I/BtwLUgfFYJDR8DXCLsvEOFqj2XvGvXY+lsK/VwrQYkIfJuAOBIe?=
 =?us-ascii?Q?JCeURcyQeQMhZ/m80bXQyxO/tZYZ5OSd7PXekDrVB6MWxNfsPBRnyVjLLHHd?=
 =?us-ascii?Q?fXLiiv6GRLtiUgcgl3//GdifoeMWvACxB3+XDk6vzqS7gR5Y/GHlrZdnwXO0?=
 =?us-ascii?Q?t05UzCZ52DcNNTs9lpkw9zZ/Gp1cYBBNPZ0NcIKl8mKVanUDfrWtXN6XMo+d?=
 =?us-ascii?Q?Wy2YwZnVkH0IUgZgs5YDMQSGAuaF4oxfLW+BUJXcViUB58SQOY3kQUD1NHiy?=
 =?us-ascii?Q?VJfQmnNZAbuJjUKagKF2BPVudiGIpE2hVtMv0Cds0cZLX2SSZHBcs0SZxt/Y?=
 =?us-ascii?Q?oZ+I4ukMjPV9qcAs/AhMCc3+bdNrbazEGrfQLmHtDZNj9o/HfKIY1huDOhD5?=
 =?us-ascii?Q?8riQUDZdwxwxcOhv1+0e5WPCMZXowrhze9NPcSOBFYIf9X4JockMSSlUaeWv?=
 =?us-ascii?Q?iS/pDnJV+A4fNOG+wZmqllzecEmNMmvjBy4w+zwLtOWLDD+71tGRmQLSp4+j?=
 =?us-ascii?Q?rDQPwx+UUYlfPkcygCi881GMCp2318rjqwBnvtpY0Yim5Ypxo7k81XKzV/EO?=
 =?us-ascii?Q?2UpnVKsF3ABWkUV7pkmS4WPtjOu1njUE5e2938y4wXBxIw6EihU1ZZAevcrm?=
 =?us-ascii?Q?pEipuHo4UvoJYLEaElnlgq1fLPHL/HXNj2iPsQCRft0Pd2W0rLtu/v9NSdD5?=
 =?us-ascii?Q?fsVEASrCsVPVZYTeHBV9Q8SAdesEWrXGNxHfkxYe853k6VKYIo6i5Mh22u3w?=
 =?us-ascii?Q?JaYi1Tg3T6zrQvCgJXQFHZ5omXnoUev927OfFhY3fC3TgbYAYuDkna4ppI8w?=
 =?us-ascii?Q?HTAjObjvCMInuYxMAuaTwGMzA+aQNy5j7eHxsNophiv+DSL29U8aJoJvggYY?=
 =?us-ascii?Q?qWGgab7ewgMT5tvWjzyCITvbkC0FVnOi0B+BkHwJXjTb4ceQKWP7b+wVa+bR?=
 =?us-ascii?Q?yiqOiVRn4ze6sJzWl8OonBSy1W5U/WLfptSP47q3d7/uUsaBPpufatSrv/Mx?=
 =?us-ascii?Q?Ui4VmwPwu4/i7Z0vJcWAPD9zGAVvE6bnEdCMM+Q7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95b1847-8946-4b5f-f448-08dba1761323
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 12:07:50.4778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6qrTfq8VpC5hJHwzDb+CpnQVUQRl76Lqm+rV3BQaXj5PvqDiUThCJhSQQWT/Z6KnkGc5manabzIqlhKZlzq8vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9523

The six join id0 tests can be divided into three groups in sequence,
with two tests in each one. Both tests in one group are similar, only
different namespaces used. So a for-loop can be used to simplify these
tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 104 ++++++++----------
 1 file changed, 46 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index df9bc6e2ed09..18f063f7a388 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -383,11 +383,17 @@ reset_with_checksum()
 
 reset_with_allow_join_id0()
 {
-	local ns1_enable=$2
-	local ns2_enable=$3
+	local ns1_enable=0
+	local ns2_enable=0
 
 	reset "${1}" || return 1
 
+	if [ "${2}" == "ns1" ]; then
+		ns1_enable=1
+	elif [ "${2}" == "ns2" ]; then
+		ns2_enable=1
+	fi
+
 	ip netns exec $ns1 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
 }
@@ -3044,65 +3050,47 @@ checksum_tests()
 
 deny_join_id0_tests()
 {
-	# subflow allow join id0 ns1
-	if reset_with_allow_join_id0 "single subflow allow join id0 ns1" 1 0; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
-	fi
+	local ns
 
-	# subflow allow join id0 ns2
-	if reset_with_allow_join_id0 "single subflow allow join id0 ns2" 0 1; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
-
-	# signal address allow join id0 ns1
-	# ADD_ADDRs are not affected by allow_join_id0 value.
-	if reset_with_allow_join_id0 "signal address allow join id0 ns1" 1 0; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
-		chk_add_nr 1 1
-	fi
-
-	# signal address allow join id0 ns2
-	# ADD_ADDRs are not affected by allow_join_id0 value.
-	if reset_with_allow_join_id0 "signal address allow join id0 ns2" 0 1; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
-		chk_add_nr 1 1
-	fi
+	for ns in "ns1" "ns2"; do
+		# subflow allow join id0 ns1/ns2
+		if reset_with_allow_join_id0 "single subflow allow join id0 $ns" "$ns"; then
+			pm_nl_set_limits $ns1 1 1
+			pm_nl_set_limits $ns2 1 1
+			pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+			run_tests $ns1 $ns2 10.0.1.1
+			if [ "$ns" == "ns1" ]; then
+				chk_join_nr 1 1 1
+			elif [ "$ns" == "ns2" ]; then
+				chk_join_nr 0 0 0
+			fi
+		fi
 
-	# subflow and address allow join id0 ns1
-	if reset_with_allow_join_id0 "subflow and address allow join id0 1" 1 0; then
-		pm_nl_set_limits $ns1 2 2
-		pm_nl_set_limits $ns2 2 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 2 2 2
-	fi
+		# signal address allow join id0 ns1/ns2
+		# ADD_ADDRs are not affected by allow_join_id0 value.
+		if reset_with_allow_join_id0 "signal address allow join id0 $ns" "$ns"; then
+			pm_nl_set_limits $ns1 1 1
+			pm_nl_set_limits $ns2 1 1
+			pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+			run_tests $ns1 $ns2 10.0.1.1
+			chk_join_nr 1 1 1
+			chk_add_nr 1 1
+		fi
 
-	# subflow and address allow join id0 ns2
-	if reset_with_allow_join_id0 "subflow and address allow join id0 2" 0 1; then
-		pm_nl_set_limits $ns1 2 2
-		pm_nl_set_limits $ns2 2 2
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1
-	fi
+		# subflow and address allow join id0 ns1/ns2
+		if reset_with_allow_join_id0 "subflow & address allow join id0 $ns" "$ns"; then
+			pm_nl_set_limits $ns1 2 2
+			pm_nl_set_limits $ns2 2 2
+			pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+			pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+			run_tests $ns1 $ns2 10.0.1.1
+			if [ "$ns" == "ns1" ]; then
+				chk_join_nr 2 2 2
+			elif [ "$ns" == "ns2" ]; then
+				chk_join_nr 1 1 1
+			fi
+		fi
+	done
 }
 
 fullmesh_tests()
-- 
2.35.3

