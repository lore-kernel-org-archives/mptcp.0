Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548C35888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="uvI1i5HO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLrJubnR3LKR2252wTA43df8/kKCy7iH0KPnVGsF+eiM55B12JoXqYyQpMtrDgdriiFwbdmWjUWOfSRg8BdOuZ1u50TXv/IjcPJFIPbPJPW7X/qFJGzbveIVHF4S3gEpiC5qnt9mL31pGdECfJk9HBFTumAKX095Sr0tomiBcMiJXOE8kPnTlJzGYvknlJ9C5h2k/kh1JnO0JqQTWj0awaThNWW5EF2sG0Fy31CLLEq6Biuno+Tln1/zpipaiKYUQ/qqfWhaTe8ocwgLbGzrzaN5Oua3t0Wc3MmFm7w6l9xvhiDIg8h5+v78ovsr0ilTdQ5pbcsE+1P0HEGgPjgvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IijtOLKGKGDy0WN1gPP6T05HZT4cd7RaI7v8dZRk410=;
 b=UL4fsHV+Y+xtaKEhws9pItpouT0nAX17qXQPeRKaCzhTmGj4RXuVKUIro4T6aPX+ryAdv1uo2Nm7fS12MWKcXnvOVhXRJhCwfeQU0zoNetu1BWDDAPY18QfToMpY3S0V3KRrQ50W79HmF5Ds/9jrYfxPV/LSU88xvHVYX5IjbC19915Msw9b55CKQ+91o7KpcVaRftNgbhmPqDtwlG9kDiwgwC6rUd+gbDdPgIyd3/hExUF2L0ajrEol5UmwtVSgDJcvQ9SzOebw43cdOh/p757MuDIiG3cIK1WXMzK2S8w22bPjRJxjkhPNBsORF35mDcKjztdUh6l6gZhXu2JxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IijtOLKGKGDy0WN1gPP6T05HZT4cd7RaI7v8dZRk410=;
 b=uvI1i5HO6KuLSTIgRYV7b4tfqEizV0Nx7BAO9iJ6/9/EziGu7dy5RRHhRaCihjxWnzUO0Au90CuC8G7cy+pbDX5xShbZm4NucVX9arCTQ9um7r3+uSISih27/vE9PHb9rHV8OWv6FtwY85F70O8llJ3Xw+68qYG7DejeWgfazL2Nfne7jUlW/lhzlfCRBqsDYgzm/a6nwBpl0KK7bmo7qiA8MMlEt+bxrlKgJcL0tzylNZ8z84XgcW8hLAyfgHnc3Dom3ycwS62+zkdUBSdonwzgS/tSq4cE3m2Qc6bD7x6UV0Qt7tihwCGhRGCjcYUQAZNOvwXGewjtFLJ0ByHO0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:14:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:14:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: join: check CURRESTAB counters
Date: Tue, 28 Nov 2023 22:14:06 +0800
Message-Id: <0b59f639265bcd844b1d51597ffd5e172127732a.1701180777.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180777.git.geliang.tang@suse.com>
References: <cover.1701180777.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f5ea20-6dce-4e2c-74fd-08dbf01c4e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kTwQryDBfx08CCUh+y2HBhCkaE2XjMki/c1TQenplwbCki9bRApkVAYPzw4Ja6Dkr9+B+w2f/vM/8x7z8Fv6ZK1GUbNy+mxEeXPgrv4Prg/I6z5UycHhE1CiYqaSAYrumb9/K/pyG459gN8dPR74M/ijxRqmzT/EmbqlJ+6Hsj8devjV1725xINsK3Z/gs2RPT3gLTgHRXW6Ytv23DcWxpcgq/igNoqkG0t6Uw9yGiOmfIMpVziDmNLK615df2CXl0eYKpFy1DjSY/LUiuoAsFAMQBIsIfgRwR4AlZ5/RdAiot+P/epOctRZpGZfTiZjFBVu8KZzdZXqITI8hJpqsYi2IAFnP06NmAN/KgiblRcOhmbl9ZF49mHgRA0hG/tKSjDgMdv2TCpduJiUDftd2DRkxtgU4HF8VGiySphcz9+FcKhFf+px8ah7bi0p66P9yJmVJ6a/uWdEWlJ4PBKug+jJGfU9xOnwGQuykQ9Ka3XkjxJDfxyBNGvgUnznjNENn0IwHpzmysl5Tb/GJl9U2nL7eiW4cIdM1ESiEgoZ4Kvta1fKlYWldTds1n3+92Ra
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6486002)(38100700002)(478600001)(41300700001)(4326008)(8936002)(36756003)(8676002)(86362001)(6916009)(66556008)(66476007)(66946007)(107886003)(26005)(316002)(2616005)(83380400001)(6506007)(6666004)(6512007)(44832011)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HUHPFoLDfcaQVSdCjljqFseVYThgYvqEm/8uwozcqsjtFDqDqVxqFxY8IEKb?=
 =?us-ascii?Q?/o+QBkstgsPD0SXbEFXJfP+NSyXaYbh3EkKCK559Qdh7UbDlYbh5dTxlSVDf?=
 =?us-ascii?Q?yn2wykd+Gpygm572wXz4eiVFTIRV4y9rRJX/C89hBHX8ECt7NAFC+YeJnqFf?=
 =?us-ascii?Q?hG7hTcr7ww2G1CMdK4V9SsUtaOuwzQU1s94AgMoFwmBS+4dRegnNg+zY/Wka?=
 =?us-ascii?Q?3iY74tEnHuDOqHvkmeY3nZxeK2yrRWfKIU2zbIh0EPTUHAOX1WPN9mEfBvgC?=
 =?us-ascii?Q?zELgkDWCQXPkqxSNeBYv7OwjeNHsJkfk+ofcxx0tS7QUMrTp9gk+9TDlMwdJ?=
 =?us-ascii?Q?LS+65ClvFRxd29lry0Z0pr4BCrY1twr0bzaQTYsMAMtDTbawQ4pdam6v7gJI?=
 =?us-ascii?Q?AEkM2Bw8QQR7epcF4O+YL+D4LR3MUbKG4maR0qY2XE7IarqSCurrhCSV7Bz/?=
 =?us-ascii?Q?9Skf2mUBGzpKue5lupRxnX/8lARGvXmuKTT5z2K8sOV95+B/xUx8XoYmg2t3?=
 =?us-ascii?Q?QDuDQk1LPxm+tUY79WGEAegulrd5USufxd1Kn/1l9UHDSIrY535hoAwQs/kR?=
 =?us-ascii?Q?TbJNLSjcL7s7lL3FmLSDCNYZbMPnHokSR27Ft4N1dDz8I8SD74+qx0Jo5zJJ?=
 =?us-ascii?Q?IZ4OTExb8vnErRuPgoASeAsEDeyzcwLkD0KUmWd5qg8DKeMozexEqBoBMudN?=
 =?us-ascii?Q?Dw/WlJ3hFIkHQD9eBhYwZ5Nfs+9j0zGkMyOq7H6U186e1xTBKv3FSKQhEF6H?=
 =?us-ascii?Q?9sW2yZQTD8EFlLxlopt67yQsCUmwVdLRNkWLGmfp3ALb0ZdRe/4ECBhVsRsh?=
 =?us-ascii?Q?365Q+QP4k2NNktwSwSojaJY+G84mY9aqoeoJN9Dw6dj7EogCdtDnFIU0DZgj?=
 =?us-ascii?Q?vq+heMONAO8prsn/egJ5V34wIIdcBXCzgKGu4M/F0+0jURSTnj858/DkhsN2?=
 =?us-ascii?Q?z/cBmjNa8cZiPyW6er2oGQjvyoWpGmZTt7glwFPj8yGQF28YDe6l6PXr0pUB?=
 =?us-ascii?Q?n7bTYyPnlKQZTUUKWqVcx4y79lg/ns0FYeFIHlc1iG8OcEiSgcxrANY/hSHA?=
 =?us-ascii?Q?gy5R+Ld2galyHQptG6zm7Q944LBa/zTK0Ej71+vyzhqFlzvKf6VKQvS7x0Lr?=
 =?us-ascii?Q?cHGSw0S2korlZMblYZOFv93QbxcQGeAz1OAmuXxIpND1X45q/XG0ah9xtpyT?=
 =?us-ascii?Q?TUCKtz2e0x5lp1H/ehCxB2clU5/S4Gu9y1UIDY3pZHvBPVOFn0s+vIEjgYSI?=
 =?us-ascii?Q?Qy5q0tzDENjgZoFrTzXzEzbkFX1FPeveTSPsE/yiIYenPEDlJb8fUmdxUX0D?=
 =?us-ascii?Q?hLW2uXA6dJLmsU7ms7zViWxnEJSKZ8G0N3bLV6GY78pSLxewTCIIN29xpS3w?=
 =?us-ascii?Q?jgXFJr7d5T91DRntd+IYCAuF5NbXy1EaP+8uR+z70jL65dRhina68twFL8Ta?=
 =?us-ascii?Q?u7kABZ2TTp5dP2s9/bwDhd5UE0/qX4O76KwLwnEcI6qXJs5Ph0CIyTmqgYBK?=
 =?us-ascii?Q?GnH2geytEdRvH1lCvr3aO9tpQIjJUzX8/RZwq31c6EpO2sXJW6A8RbslGNyb?=
 =?us-ascii?Q?tSlzpmerjt7YWX5bwn2R1E8pF032rWAqgu/r8lzP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f5ea20-6dce-4e2c-74fd-08dbf01c4e76
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:14:17.2884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2V0Z3+h0X7zDEG2N+xeEZtGwIItkMGdH1hdTMjceJIuratD/8fALGrH1EYuVuVw2O91QYwc9539zO4LHP33JNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9952

This patch adds a new helper chk_cestab_nr() to check the current
established connections counter MIB_CURRESTAB. Set the newly added
variables cestab_ns1 and cestab_ns2 to indicate how many connections
are expected in ns1 or ns2. These checks are embedded in add_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 58 +++++++++++++++++--
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 947b60cc2512..10beaa6ec626 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -36,6 +36,8 @@ unset FAILING_LINKS
 unset test_linkfail
 unset addr_nr_ns1
 unset addr_nr_ns2
+unset cestab_ns1
+unset cestab_ns2
 unset sflags
 unset fastclose
 unset fullmesh
@@ -905,6 +907,46 @@ pm_nl_set_endpoint()
 	fi
 }
 
+chk_cestab_nr()
+{
+	local ns=$1
+	local cestab=$2
+	local count
+
+	print_check "current establish"
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$cestab" ]; then
+		fail_test "got $count current establish[s] expected $cestab"
+	else
+		print_ok
+	fi
+}
+
+check_cestab()
+{
+	local cestab_ns1=${cestab_ns1:-0}
+	local cestab_ns2=${cestab_ns2:-0}
+
+	if ! mptcp_lib_kallsyms_has "register_ftrace_function"; then
+		return
+	fi
+
+	if [ $cestab_ns1 -gt 0 ]; then
+		if mptcp_lib_is_v6 $3; then
+			sleep 2
+		fi
+		chk_cestab_nr $1 $cestab_ns1
+	fi
+	if [ $cestab_ns2 -gt 0 ]; then
+		if mptcp_lib_is_v6 $3; then
+			sleep 2
+		fi
+		chk_cestab_nr $2 $cestab_ns2
+	fi
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -1018,6 +1060,7 @@ do_transfer()
 	local cpid=$!
 
 	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
+	check_cestab $listener_ns $connector_ns $connect_addr
 
 	wait $cpid
 	local retc=$?
@@ -2406,47 +2449,52 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		addr_nr_ns2=1 speed=slow \
+		addr_nr_ns2=1 speed=slow cestab_ns2=2 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
+		chk_cestab_nr $ns2 0
 	fi
 
 	# add signal address
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=1 speed=slow \
+		addr_nr_ns1=1 speed=slow cestab_ns1=2 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_cestab_nr $ns1 0
 	fi
 
 	# add multiple subflows
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 speed=slow \
+		addr_nr_ns2=2 speed=slow cestab_ns2=3 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
+		chk_cestab_nr $ns2 0
 	fi
 
 	# add multiple subflows IPv6
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 speed=slow \
+		addr_nr_ns2=2 speed=slow cestab_ns2=3 \
 			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
+		chk_cestab_nr $ns2 0
 	fi
 
 	# add multiple addresses IPv6
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		addr_nr_ns1=2 speed=slow \
+		addr_nr_ns1=2 speed=slow cestab_ns1=3 \
 			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
+		chk_cestab_nr $ns1 0
 	fi
 }
 
-- 
2.35.3

