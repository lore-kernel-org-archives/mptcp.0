Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F525584FB
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RoUcMYUR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmNnZNN5RwYk+0xKVcjN66pzRS9aUMTqNz/wuOBhiaHCHeUndjQry81ZAoMGm73cGSxH9ZH+RHEMbOnsL0Fy0peKCqbXeyKwLabJDiXk4Fxbqa6c2hiXa+YQPrKZK70hoooGZS1s7snaT9pD+BXsTtO0LHDoKaPVfPvRJlXzXnP8lyh3pB639ahOE4m6maHfqOhxW5fsd4T4rl/wWjNAb9GK90okKcv9UTdPr6QrbV77pJZNLfeo8cnLKGGNJWTxdC6kuKYpzjau8ICcbwkxtZ5jMYgmrU8DgNwhxrDMZnW4VNXRhx6ZyplsH1HFkRvPCxGRX70kOLcRlRnDz2OxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P/My++4Ew84cg3VAoBU3wvbsMYWACD8uXgvo36a9II=;
 b=XCSl2x3k3kz9si09KWyW32I0fE0Re9wNfLSK6ZTrp34C/gcCi43QM5ZHPNWHQNy7VF+Lla8MU0UDrV6DWMZnpE6huaZY227WM1/IUrrdzPqodcInItqMZjMLtoLk3K5vUSkbL1lnXC6B5/SxLS1/5koEIxfwdSRCkPlADzII6HrM9yqol6Mg4dxSsaLpspDHbW08nCGXIcMKULLsBkfFvmUb+PUmOMoLOSoeFBuXyoMIK8GdLg/B9X2wqQ8h8Xss1wmbrwrVP+Hjkp7N6XTnS4z1E/3dWtppJpE98fjwOQWaxdcfRNKT0cWBamhmQlohbVEqDHbw9qkU5DFgEF+1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P/My++4Ew84cg3VAoBU3wvbsMYWACD8uXgvo36a9II=;
 b=RoUcMYURxmThnTmx0K/x0Hy2rCqC4OaowjHcptBw1QAS62MH8R925TG0o7ldBB6ZivfxSHP62mtJCNFREt9S885abMo6F3LS914PdQhNCIBghKgmSSnIZcJ5zU8uxCcbpaaOracsRxZ5IFrv2jIE3WchXrC8EA8cVu6nxiF29BTz6md1nCm6vpGgEG9EcCONMr2Pd15L7NZ6cHMl/c8xWlmhOxrYwN6NSV+oKgVNPW0pHJTad8bY3EMFeclFJFp/vXqf6TqKHgbXp/xOCLhUasb7//ihIDIjTnp6vgviYBl9OAP8/TE6aJlwjq0kSvYapKrbDHKsw4A6cEgygR8K3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:24:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:24:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 23/32] selftests: mptcp: flush userspace addrs list
Date: Tue, 28 Nov 2023 22:22:16 +0800
Message-Id: <522effa606f2173fb6fa78755b44b7da75d61296.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0178.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: df4f22c5-ece0-47a2-372c-08dbf01dc22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xpgjaQaTOvz/b8zbtObtFVXEs+qxAO7i5nrqkvdXndooaWCkxtUACyD+LRSvaK8Uz6195fiLSly1eARB+e8q29tiTlywlcCsWA7MInBM5MLxXwYK2E5xLoQJ/iCydbPiLvTbavHuydxa+SaU/7bdxQx/qvxLLHvcGTNE0QmRjnIqEaBLd3HdRwhSbUPpo/E+JJD1VY7P+/r/NkG3ICv+dgCCWg6DzrUvtGE/VqiCkbYun9vY2TNHI47ORttfGixjsvpksT5FX4W1m++EiO1pB8sN5mPzUCRLK5aehQeeg05fBaijJ06jjdAjYeAfwAr49s7tVYDohjMlUwjQ1rVNgr70k2mRlO3GrQnEleUUj5syWY7HCxbcf4gfv8cqB9rSfsEqXr2zEvzifaLWWibwEDR21n/p1nOb/I5wfvCER0CiaNYqH+HvguofgiGNdlhJgkgaXwbgTtWBRNpRJ47t8Q2QF3E6AeMn+yDWnZbIx+1L6ZsfWKxtYSdGA+Du3rIW6xfZIgcjd7wUtnPeWGo8e+6Y7kIFhLQCKMxnvACRaxlpHp/qZkuq2cHRiIpihP1X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(36756003)(83380400001)(86362001)(316002)(66946007)(6916009)(66556008)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WD6SVz8SZkuzcYD7fk1Mj1/rKlIULCDfDJrnWQ58Zhk2ho56wlSicLZJLdJV?=
 =?us-ascii?Q?Q2m1i56pYtzUZS0lA/MbT8shkBjw9PWnFDM3CFwU57uy2AnC33QmPR082TdM?=
 =?us-ascii?Q?l9LpFa1wbPHz1EZN5FS095dWi9T8zHGSn+c4GWfzyT1Ph786DZIj3fuc8l92?=
 =?us-ascii?Q?sFpf7YwT6f3BP/s5Dj4krSr5yu5woWXCLJM0a5YbwCGjr1XLCvBTgomtemi5?=
 =?us-ascii?Q?KqS89ZQWUdH5FKZGC5Z/+6JzBtzhr7kFyAupBeLh+Sdw//hg7db9b4EKXXE1?=
 =?us-ascii?Q?d4914kYMsGiYMGmZDl0oTGH3NcOWQ+4lq+6TAPCMk1xNthoNO6U6mTtRyyfp?=
 =?us-ascii?Q?OdVmwiTbB8c/4efhYichtbrVMujEAWsYShtAWvvk4hg46B/OXGrbMagjr3bJ?=
 =?us-ascii?Q?UXF3KXlPP8+hrOzKRaqXM/9UgaOI08JamzTcm2M1XB5ded/wis5W/oWGzRvQ?=
 =?us-ascii?Q?aEN7MPschS9YVK6CLxCfCyPDWiRwr4yYzgN9euaDyJkayoASouiQk1/9O/r4?=
 =?us-ascii?Q?wJqNZmDYL7gsxAwfqMil7TFEkt0mb9vzls7kMk/pUAUVZkAvA5a7+PAD1KxW?=
 =?us-ascii?Q?IOpOAphgXrJVtBHT1I2MUV0Lkod5izvlUDHwp2tRCemSI/JUmfTPzJ/7qKHo?=
 =?us-ascii?Q?Q3d686pOZInCl9eCbpuceHP3CAXIzh9z6r6DDuNBJRwkL+JZrNplkuCwiZVZ?=
 =?us-ascii?Q?mgPW3UFZHhQ9BuJZOhUEBTGe4Gemc8ig5DXS/M0Au5DVnytOMNKrBzWkDhLR?=
 =?us-ascii?Q?vNEXuHdFDBcvv0MqCbj+6aY0eV/y9FaXnnOvfFxT63ArrXkLFYnQ/APov5Zy?=
 =?us-ascii?Q?Qji5McmtT5xAE2qRiVTZFeE5DwLDMoCPcloxYqx8SE+wVS1IS6Cj58hZ8ekM?=
 =?us-ascii?Q?/PKhz+5xyBCabfZRKAr0qv7zAh/5ZiUXdfLDSUu4QD2316lCGzjEGS7+BwDA?=
 =?us-ascii?Q?XDCZseDP1ayyQZp4CC2RnYnSrjhyQbe/EBlyfzI57ciWHJLwnfHS/sfgs3qt?=
 =?us-ascii?Q?sG5INrfH42bxzCXPjtxG64Z1jlOk/gzYXsMGNR2jYOEOo/wVO76Wnlr3Hm2B?=
 =?us-ascii?Q?/y5ZuMqPcrofYvOt9ZYnxQ3g7u+eu+hoWhB6D/2GLJWKml0lodficRcxRLAc?=
 =?us-ascii?Q?tIClz+/eZh3nr2LFuamW0m6cOhGyKunLz8PbtHMyG2lHKBQLFdtb09QIxB8t?=
 =?us-ascii?Q?b8NaFHITcnshlbR4FUh5DeaZChDeLTK/oWvTpN0DrH8A8QbPQ/yW5aevkzx3?=
 =?us-ascii?Q?Htgzbv5ADRDro392Vp6M8fp6h2lV1ld392P8jsc5IislMbsh5vE1yWVWWc8K?=
 =?us-ascii?Q?ofJsmgbQQKtggonQJY8k+dRzbhjcU2GcA5iuiG7LVeEHuu/q/OzdPL1ZAHq3?=
 =?us-ascii?Q?6/YKgzsJoGuveui+vaFWGP6O2vze4ttJgvoDHGe4D/vwSvVansJMXd9Xp5Yv?=
 =?us-ascii?Q?0tcofJBCZ6SN+bVpgY9kfJwq6vb6vcN3CoiCczUjYzJLhWLtXvIBsjzsYHdN?=
 =?us-ascii?Q?Upgm3zoB9n2B5As41P46u+Ue29VCs0UCvkzkddNUOr4ev5myY7DKNnKZEozG?=
 =?us-ascii?Q?ta7wSmkYvIJspuo4+e2kt8V9utLuyyZWNxHJCu3x?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4f22c5-ece0-47a2-372c-08dbf01dc22e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:24:40.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVKhvNwxHvMpqEv3e/FMhdxFbUvfvljB2HqnHajis0Ybg8sytLkFjDRk7/ZxHrdB+I0NNWcx3JNORfX3lHe/0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

This patch tests newly added flush command for the userspace PM. Add flush
commands into userspace pm dump address and subflow tests. And use dump
commands to check if the userspace pm local address list is empty after
addresses flushing.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ce5b5b71e508..a2baae49a451 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3513,8 +3513,8 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
-	# userspace pm dump address
-	if reset_with_events "userspace pm dump address" &&
+	# userspace pm dump & flush address
+	if reset_with_events "userspace pm dump & flush address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
@@ -3532,12 +3532,18 @@ userspace_tests()
 		[ $ip_mptcp -eq 1 ] && dump="10.0.2.1 id 10 signal "
 		mptcp_lib_check_output "pm_nl_show_endpoints $ns1" \
 				       "$dump" "      dump addrs signal"
+		pm_nl_flush_endpoint $ns1
+		mptcp_lib_check_output "pm_nl_show_endpoints $ns1" \
+				       "" "      dump addrs after flush"
+		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
 
-	# userspace pm dump subflow
-	if reset_with_events "userspace pm dump subflow" &&
+	# userspace pm dump & flush subflow
+	if reset_with_events "userspace pm dump & flush subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
@@ -3555,6 +3561,12 @@ userspace_tests()
 		[ $ip_mptcp -eq 1 ] && dump="10.0.3.2 id 20 subflow "
 		mptcp_lib_check_output "pm_nl_show_endpoints $ns2" \
 				       "$dump" "      dump addrs subflow"
+		pm_nl_flush_endpoint $ns2
+		mptcp_lib_check_output "pm_nl_show_endpoints $ns2" \
+				       "" "      dump addrs after flush"
+		chk_rm_nr 1 1
+		chk_mptcp_info subflows 0 subflows 0
+		chk_subflows_total 1 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.35.3

