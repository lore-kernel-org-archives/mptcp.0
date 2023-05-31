Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2063.outbound.protection.outlook.com [40.107.247.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17F1FBA
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 08:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xzz7Ai6XEc8aqiU6FmC4uHz7DqHWPlu85zfcmhe4coQ+mVhvwUGTUPtI73GLg6mBbkC7y331IYd9w8TdXyx0ZCjnlMtIpv5EQaW0V84A7mw5TNvktj2uRiFBkthh7phFjD91/wZOzeJusc5u80P3Ci/wKD6mbjiP55xPqbR9A3F7qxvcGPC6XezT91+3dAPW15kW8FOpXvU7EzTwepJlo+/vvCIL9SHkMHmx7DudEmZzXZTSY86BwI4+iklO0hcbeGLyKvHvegB9VuLCPL+/FU7iqYyf4ouNjkg+yPfKJ3bIkNXXmFHu1le7dC/yC4UTNN8O8+nU0HFuMaYZcmZYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+HnqeaNIWUHLgDkCLRS60vjUwIHs0u27ARU6CB9XXQ=;
 b=QWBpkO4Qaf3TuRdCFulOkI4ssfE6FYKV10+lO0o/nAOJR0dnvDWucFPN6CzpT/CM+gDzNgrWtjjOc4g62OIFceY5L+h4odN6Kyp00Ah0MMwg6bs7OZehlH751LrAwZkxd61zZuZThfR4nxKPqA/GRoB3OpkgkUg9Pg5HWtjNOcxcT2GUrhQrjVK/KbBYjg6UD4mqnPTsoXYC0jloOtK/oi+zZCYrqM9URJDvMq2+Pz9F6Nfhuso1FNhltn2Fko55uoJdnArFZP1uCJoK4ITZygnggILWs/1GQH7zKCwGVcuAaCOsZRFDsiIHN+hesGNJOn9AcMFy/yymnf/lS48fwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+HnqeaNIWUHLgDkCLRS60vjUwIHs0u27ARU6CB9XXQ=;
 b=ruvR2YQ4wSecdQtP7BmmbyW/V/0HrkxiiUvkJKfOMVBqmtKS4vC6twktBqHSaRAtHefZNGyq9Blp+783KB6CZHNoGDppanffiq5LXyYv1AJF81rR+VvjZHn50aCaTnAMQmYNlH6euNrry82ccbpjdYnwbVUQnMMCdADnh7SqLXdnmlyCbNN8T0xlGd5ayILv03LgxdmsV/dkwixwgog60UCNWuB36pNLtbZ24uMAdJQU5Ef3E0NC2hItTaqGlrTu+ypl6q6KVXBkHXESzCepAGXdXJgtTW5TEaxI22L5aEDN4po15tqxO7KlyYHXtPc00f/dZPXFixixp05t8zjWow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7902.eurprd04.prod.outlook.com (2603:10a6:102:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:59:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 08:59:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 6/7] selftests: mptcp: pass fastclose to sflags
Date: Wed, 31 May 2023 16:58:55 +0800
Message-Id: <e6dd9db43a773734a8660efcaaa7814af1b64bbb.1685523463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685523463.git.geliang.tang@suse.com>
References: <cover.1685523463.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 823e16bb-eee1-4a26-c1b2-08db61b5645b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GfpvtQsyyCYMvylhNkULZFW25GUMEM/8Q7C6GYtPEHRGxL/1aA5AMGdxtdKYfAbidybkdah88DQEqa7PEIVD2/J2BWg+XZavwwW+Kv5nZerZs+l/NA4MCEfx0Zl/1lzYKTPsk+kWF8Kh+BB1vLDLxUybgGzO/IT9UDHbs9x++cAhstB+SZEuIXg/3053+5JVb3jWfMxwvSebRIQrqECzgLIKXHW3tJm4ObLRoOirWFJDj+ByuzVK0SA50Utmrgcp5mqWD6mPSk55twHJYvp5o4gcEY4fdl+MEOYRKtqEnlsKMK2In42gNmbdaizA7ctUEJFMN1d0NDFkMVchztxoEUwP8Vurikoehi3wUgqv7ImrliKfixfArPqqy4HIUNQQKm8iUTFWyAPcYBe0S+kTTOOt00uDZU4m3VOB0JgDqztCOk/ZIi8hFyJUQEWWZbT1CkkJ22VU9TNbof8/Wce443zYRCP3V8mBaTO/D+Fz5iLst92lTAJRjeME5mV0FJ66gsPdzTZJJRppLu6ZK/P6qmvLDoXeMEoIe6vfDDX8dNKHPN5pKfWpqKxi18IEQ9Hx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(107886003)(2616005)(38100700002)(186003)(41300700001)(83380400001)(26005)(6506007)(6486002)(6512007)(478600001)(4326008)(6916009)(66476007)(66946007)(316002)(5660300002)(66556008)(8676002)(8936002)(44832011)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MXKHuUxBoNldPGV7cN84T39w5BNaymx2qP5XlaV2pC0frqVe/PMfc01mqgpp?=
 =?us-ascii?Q?9OVogssNNVgKv0qb7Tg46VUF8fjGgGIazOjbWcDF5gChyIbrFNLAfeMvD+Hy?=
 =?us-ascii?Q?6Yl3Nxx1eMsTiLlgktCi7tbSaRqOFKcGxXFt3R6HhTzZ2xZrOQaQW97bORde?=
 =?us-ascii?Q?b87m5mzH2Tbqr2Uj7lzC+pSCAhf8J7WaiWgwFvl68PJm3i9C9hgk+YnBjkIP?=
 =?us-ascii?Q?Lau4sUGIUOkF+/oSOLnIIFhBYOIuHj7gZf3yA+qvRVxdYvHHAuXGLlk5OeG5?=
 =?us-ascii?Q?dwnrCFfVJ9e0UvVs47IUpOIXL8WhLSl70EfL1btF5aZ0eFMa2KHGC2XpciIO?=
 =?us-ascii?Q?CGCmBgycxK0VfrkbDxKqrotGQWkpbWF+Sp61jv1mEXCfI9nbJ+nd27606LkJ?=
 =?us-ascii?Q?xm1yHGCl6HuwSonDetRQRCv0ZBeorOGmq7x1VdF9Qg+hGzHDDfA/QrR5dGCI?=
 =?us-ascii?Q?SZI/DegZBEra44GErOOub9EFbng9OzXTbvC++JOduO6TMf3DETHdiUPE93Ff?=
 =?us-ascii?Q?bDQfEo1qD0ObE/rw88hwGC+Qi9ArSYqlsRQs+dKCo6cLmPekL0U5KE1Ns7vQ?=
 =?us-ascii?Q?pbD1hf8y6UPY0YnFvS+ozmiP6MJoQ0UQd14aRz+hUvjaw5WK2URa57Q94GPN?=
 =?us-ascii?Q?wmC3AbJbWBSAFeyrOOrVge0YWPvtjW5zILzQ1vI2CN+bdohv8Ei0ADzBNBBO?=
 =?us-ascii?Q?FA2Iv8YU6hmcYvO7lhuxv1cLtzfn3n6GlquTlh0ZJaYa0zq+YyzVJsLi0SBB?=
 =?us-ascii?Q?C2MBVf27YeRWoxQmXAUrk+Kxy5kRQKRcg5vsQW/0u7oZKZFDHoN/lUVeBZp2?=
 =?us-ascii?Q?NpMtoE+nr/BtTrOEPd7W89bgtQuuQgN4KYEMcyRkUkArYJMqOCWxLU4UZiMH?=
 =?us-ascii?Q?u3vRClly6Nxrg+QR5ni21WXYLSxxl6f0MUYxeiH67Y1aXW5lVMQVddCrIOuQ?=
 =?us-ascii?Q?re5+xZbvz2HlixyiMCF+egtLkjK+EwRZLe13jnUXNdnSEUxEIi+g5AiOV09k?=
 =?us-ascii?Q?No5zWnoZuNetQo7HXTxazGY0biREODtUna0i6riipo4jsA4riyxBoGLKShtM?=
 =?us-ascii?Q?T9isKBNCe3Tm5UgD5/OS/nd3qz+pFWrnMI9YMImGo+Hy0zsobcse6AxC0asY?=
 =?us-ascii?Q?Fr38C50lvaHa65tkWaYGeSDhNTRhOKN4+yJFETgsdd/eU0jUIkUHfWgQSP86?=
 =?us-ascii?Q?mEncyEnL6OO4sG3+t0MUs3GVV8cT1n7+ymoSejhJENxVkWKMzkFPbCOvWR+8?=
 =?us-ascii?Q?qh3/3+KZvPHkq1+wVfNPeVF9So7JZnPJ/wp4DetCl0jlvhOabmTmCBOLjrHW?=
 =?us-ascii?Q?KEPO1dIPp1RNiFeA5hWH3Ed8AjiRebCkgusn7rug6ea7eRrqaxynV271T+mj?=
 =?us-ascii?Q?Q+EUSo0+XlnxbThrXa8UNxy1KnfqYuzYhHO/h0UnwKL8KuQQnqWinK7m4EAe?=
 =?us-ascii?Q?tLu+w4nJBgix1mjTqgoIyXmr4wh8vgXh15b3+PEwj9uYkkuv0LoKE1QhpXt0?=
 =?us-ascii?Q?+8bf4NdZ503EMJr4PETjCchPN1EtlgDDY/0PlB4RhbR/5BfbuUnY2viSGnYb?=
 =?us-ascii?Q?rg5gFvxgpON0jvMjhgm4PkBaY3nPl4jD1cs5ki1h?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823e16bb-eee1-4a26-c1b2-08db61b5645b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:59:50.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9tiSjsH7AmPhCF+LDPYesYDckRM38tsF0maCqTC5gsU/Yo4jPNgsxPc66jWPRHyXZsTiBafYiq4LMxd+S98HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7902

Pass fastclose flag to the sflags argument instead of addr_nr_ns2.
Then addr_nr_ns1 and addr_nr_ns2 can be removed in the next commit.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 60cdc36d280f..e91ce69e983b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -853,7 +853,7 @@ do_transfer()
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
-	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
+	if [[ "${sflags}" = "fastclose_"* ]]; then
 		if [ ${test_link_fail} -le 1 ]; then
 			echo "fastclose tests need test_link_fail argument"
 			fail_test
@@ -862,7 +862,7 @@ do_transfer()
 
 		# disconnect
 		trunc_size=${test_link_fail}
-		local side=${addr_nr_ns2:10}
+		local side=${sflags:10}
 
 		if [ ${side} = "client" ]; then
 			extra_cl_args="-f ${test_link_fail}"
@@ -875,8 +875,9 @@ do_transfer()
 			fail_test
 			return 1
 		fi
-		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		sflags=0
+	fi
+	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
@@ -3131,14 +3132,14 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
+		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
+		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
-- 
2.35.3

