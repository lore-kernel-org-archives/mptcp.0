Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7818C39
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jvH3LCym"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWV0KICl71AaRRkQ6pnX/DQeNoL47UNd83muZvKOMMFMzVopjatDJsNP60vwPVBPnxYDcJvuHJcwZQxzGRgkfjHZQpRSeLHtt/D8ot+pwtu3f64SA67dAVQIgpHs5L1Vs6Cul0Oj6raJ4IX/cRlsQZsazBLynMxd5YXoqoEl8J9i5M4AK7sRSslpvtzjt948A6BG6uOcvL2y4V7J5brMZSu5DPiNxDiGXGprUgl/jBgYIFQGvaFVxbb4LLEj8kN7E8XDab0LSBBtfigTq/ZUJdGVIZhZ9Lf5jG3VgjT+xHJfjgmG10KbBuzqIInvf0fYGXIATqoeNtp6RUbcUH7tGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8m77eV8DDR0uu667W9SK/G4HwI8JJypZSmaCgAF2eg=;
 b=VIEYiY5MOI8VYX29EiPxXA/RWNq1TkmptIEhDdkkOtcVy2AtjoDZV25ZjQHccOI/us88rU0ouQoFgL1LMhpbWTrVSGrxwBsZGeikuU3ht2a/yv55QLk7tbF+1hzzfK1uoG/qjTFhE1QcBgSeph6coLEy7dnwS5y1MG86akRMqVCUmo7Whi0D80exUYUeJov88Pyea+5aw6AZYy+uitMQnuZ8PyDjdcJrIOuAGrWUX5ksHehhrdVJp04YqBYT2drMBl16/DgeH0IfiTf77ZwvJRrIRSNM4UOY1R3oRVvxWW8Cnxeve6/AL4YzYeLPaWR3kqilcEZoQ+YwHndcDBdvPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8m77eV8DDR0uu667W9SK/G4HwI8JJypZSmaCgAF2eg=;
 b=jvH3LCymalsHu+HALjd1gCvTFcfy+PfncknAq1O+MAeHvX8ChvT9u4qe4rZZMrIeee/RD+NqnyTNWo6wx6gK7R/lUKUvvBIgWBjnD8AxiYmnBVOvynk8g+v3tDZMNEl6lVHbC2+hZTZIEMPqnvHhYvCX2XXadVGPg/BmKaXqiLn/GW2na27OFr4LABDtXg6Ehfu/Lk2SI55KZg/CQUyYbEB5bSVA71aAdGBA4982olVMuMoWDhgXoRTDyuRSgjM4k4DM9yZjoqDLKMDRy/sLlK7HodYkgB3SJah7hdxqF94xlH11a1j5qvXKBMEVVO8ndnFprHSSKujTZ4tzCvglKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:22:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:22:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 09/33] selftests: mptcp: add mptcp_lib_verify_listener_events
Date: Tue, 14 Nov 2023 18:21:39 +0800
Message-Id: <18f05c1078f16a5be31d9ad666bc1a10365a74e3.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2a2af4-f0ac-4f2e-14db-08dbe4fba7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CGLrnNxvLvJyEjNbT29MYOHrAK+/72vdfTx9Dbgtb2xiOURNqxbJSEaVOpfCtEJ/alnTydQ1iCz1zhY3Z0O1wBcurF4H6tIJlWjxp0yqa8FziSUJkAT5+cKrEVJF7D/XKRcRM/aJCqTTdMllBRiugvlB4A6WS7nRLPRk6bTexUEnYeeMizyB5fd51SWmLVSYW84MDCfDL5RMOlVWq9UIjyzq8ZGkev2/n+8CU0qohMio99XgrEzwfA5AG7nByTbIRL6az3xfiR8Gp1kyBPwJlfZ2BCQCt0wLs8HWNcbE8gbNg1+zt6XuRh7S8Q5gcdNXSLZvWSDJE102/wHAd368MLoZc3FsDYk+VXucL7+q6jn+9Ap890YxdQ0bamQIdBdYdUQL4aG/54knlOqLJBmN9vwd+RBs011xaHDuvTJB+BI07vg6+Sd60D1mbPmVBdNHWPwNVD2FjnWkS3jRSjD+en5hN10bmny9DoTVymvl14pJ/hnsVaHrL0FrCtaO3egfrDgkiuuyCIWrjTc2lV9cSgm52rHdrfuKjIl5kwCB2OEdV5j8uPLdHbxsT5zNalGD7qPsePDrod3vfwJ0fac0UVzoxQMcRV1J4flgUkCM2FdM6rNldrDds7mBdvsUzRoH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003)(2013699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wa1AREKsGXbnyMETNaO0C+lDT9OyBkrL+T90xoI27qKGQEBxxLs4GpLPowsy?=
 =?us-ascii?Q?e6hJ56Za1om9UdyDbO/SGhjNfdXcTGbNTSTmDYpFaaPqCjpcGen3pQJOpfpK?=
 =?us-ascii?Q?6nAB7C5pYLxTduIdh54GAohUQF/XCwIt7gA1w+G/WueG5p9KwvwnlMGg01f+?=
 =?us-ascii?Q?x+3T2GW2K30uqBgj1S3Ss/iprNOtW7ClqjjVIz4x5/JDCbE4Wc0c2efyRDk+?=
 =?us-ascii?Q?PWqEXnomd3xtNMYTO5G/bfizk/SE5SELibqm0Cqd6/h0tkebdPGkfkf05CT6?=
 =?us-ascii?Q?3OdgG6AwOXm04Mggn9rDJbBDPoAv8f9iFaokVGAEva4bM3f8ORvYi2RdsDvf?=
 =?us-ascii?Q?i3rbMa8pUSqHKYALG78KM03BvfBIx9Gi00RY3eWmx9265/3cpj5/LWHLk8o+?=
 =?us-ascii?Q?I9qOOUrZJvjRYvtPlLxRabH0TXYBKT8QgAf95aEVDy12HaKxtfvcn3mNVLrF?=
 =?us-ascii?Q?GYeE4D06ucurApxkD2FIgptXCs7wyECOKB7wvb/v2qmTesWeqLniERQ7MYoG?=
 =?us-ascii?Q?+e6/GGw/gGwlj7VDESMBlcbvszGN/iFPnbWrb/UrNy1f3qdTmwJc1BPi2kh1?=
 =?us-ascii?Q?w3yZ57WqOSUOyY+9SsW+8I5/QN7/TFbnafTMI5W9OT5Joqxuxr8YUpsQW7N0?=
 =?us-ascii?Q?kZHOtlYMLpVuQMlAZg5kSMdtEFv9s+XoZ6qdmGO9spmvpOF5o0vghaRE92bN?=
 =?us-ascii?Q?HtGo+ZRhB2vuMQ3B+ZhBJ0pfZQy8IUmOrzyuAHNdZriPWNkL1eZs4NyIIDwY?=
 =?us-ascii?Q?XYG2n0DgMj8tCsKHJYF/h6NGKkz8cEAaR3FNDRaZViKxyL4FoBZ4MLArghV3?=
 =?us-ascii?Q?3dtZ0RDgRXCFK1EfVRxnJ9ZXu9Tda/R6tehysHDWNNP48+rUIs2pOhlfC0Zk?=
 =?us-ascii?Q?A9Z4Mm87tY4VcvafsodLWjKQs29cPlAwSHZMAhnnEZhoimQDxEtRE+3e8sGm?=
 =?us-ascii?Q?8Mq7+NmYULsc7KRCFPq+Y9MlApAFK44R3UNqojCjbcFU/BlWUs4F1cioH7V3?=
 =?us-ascii?Q?h+qzaTrvhHzb/fRUC4XYopJjuzmMC2IEHdZrWZRVRYTlKeKdPiH6qpgPjaUt?=
 =?us-ascii?Q?rwOKqZJCEAjy9KLTFRqNwa21IEfq8ZLUyml5mEBJt1Vuqq2CF/hZk8xt7Jbz?=
 =?us-ascii?Q?QZ3pYW9MDPaM4O/87i1XLAPXLpkwacbocTLYjHGDmdxCBhcUUe0NnjgOEZIZ?=
 =?us-ascii?Q?RPlx4/yr+N6YosItgg8SPPFpU4RJ2f+B0Ax44zuEII+R7ZDmugis0AslzHmQ?=
 =?us-ascii?Q?pIPrf4OkdHy0ROho6fWAWk4UjzNJBycTiilWcA9EGXivGITy+Kv+RRnauInW?=
 =?us-ascii?Q?xaRefKZ4AmNV6dOj3dq1KWlZYYHaPKBtChgeNPtuZctdsbP9DyYSIsS3ITCs?=
 =?us-ascii?Q?iI7DVMnAUECXjqL7laIYaqTx+eYwJcYNS9mZxd5UAnzE+rc4BS46MzAASl3k?=
 =?us-ascii?Q?zmLssVW/2ECd+cyxqD8LH6kGrQg5Fb5ItFZM4Ylw/subAEkD7xRlNn0eggDD?=
 =?us-ascii?Q?G7Fi49tZvzTlgECrojcqv6kTOiJgLceLzYOgZnHgSSiw0hz9iL39zZyCDiAs?=
 =?us-ascii?Q?VhwW/WabE+a5udfITZQhzjOB+Ck/NdrdKzrq4giVnU6l5RdLU3HSgGDVU+Cs?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2a2af4-f0ac-4f2e-14db-08dbe4fba7bc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:22:50.7751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xgok0xxOmJEVcnqZB92+gZ7CRiu1nROIW5HD6EEY9CjQSlgKvvrEHKSi3cxICM66l4yKCkQFOfG6Pfs9T3lR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

To avoid duplicated code in different MPTCP selftests, we can add and use
helpers defined in mptcp_lib.sh.

The helper verify_listener_events() is defined both in mptcp_join.sh and
userspace_pm.sh, export it into mptcp_lib.sh and rename it with mptcp_lib_
prefix. Use this new helper in both scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 ++-------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 23 ++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 30 ++++---------------
 3 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1c3df7831855..9ad8c600e58f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2779,15 +2779,10 @@ backup_tests()
 
 verify_listener_events()
 {
-	local evt=$1
 	local e_type=$2
 	local e_family=$3
 	local e_saddr=$4
 	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
 	local name
 
 	if [ $e_type = $MPTCP_LIB_LISTENER_CREATED ]; then
@@ -2805,23 +2800,8 @@ verify_listener_events()
 		return
 	fi
 
-	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
-	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
-	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
-	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
-	fi
-
-	if [ $type ] && [ $type = $e_type ] &&
-	   [ $family ] && [ $family = $e_family ] &&
-	   [ $saddr ] && [ $saddr = $e_saddr ] &&
-	   [ $sport ] && [ $sport = $e_sport ]; then
-		print_ok
-		return 0
-	fi
-	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
+	mptcp_lib_verify_listener_events ${*}
+	[ $? -eq 1 ] && fail_test "$e_type $e_family $e_saddr $e_sport"
 }
 
 add_addr_ports_tests()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index accd3a62832e..7a6b85100c98 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -443,6 +443,29 @@ mptcp_lib_check_expected()
 	return 1
 }
 
+mptcp_lib_verify_listener_events() {
+	local evt=$1
+	local e_type=$2
+	local e_family=$3
+	local e_saddr=$4
+	local e_sport=$5
+	local type
+	local family
+	local saddr
+	local sport
+
+	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
+	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
+	if [ $family ] && [ $family = $AF_INET6 ]; then
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
+	else
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
+	fi
+	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
+
+	mptcp_lib_check_expected "type" "family" "saddr" "sport"
+}
+
 mptcp_lib_cleanup()
 {
 	echo "cleanup"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 2e9fba4e07ac..5e1d282ad3a3 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -839,32 +839,12 @@ test_prio()
 
 verify_listener_events()
 {
-	local evt=$1
-	local e_type=$2
-	local e_family=$3
-	local e_saddr=$4
-	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
-
-	if [ $e_type = $LISTENER_CREATED ]; then
-		print_test "CREATE_LISTENER $e_saddr:$e_sport"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
-		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
-	fi
-
-	type=$(mptcp_lib_evts_get_info type $evt $e_type)
-	family=$(mptcp_lib_evts_get_info family $evt $e_type)
-	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
+	mptcp_lib_verify_listener_events ${*}
+	if [ $? -eq 0 ]; then
+		mptcp_lib_result_pass "${TEST_NAME}"
 	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
+		test_fail
 	fi
-
-	check_expected "type" "family" "saddr" "sport"
 }
 
 test_listener()
@@ -880,6 +860,7 @@ test_listener()
 	# Capture events on the network namespace running the client
 	:>$client_evts
 
+	print_test "Listener event LISTENER_CREATED 10.0.2.2:$client4_port"
 	# Attempt to add a listener at 10.0.2.2:<subflow-port>
 	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
 		$client4_port &
@@ -899,6 +880,7 @@ test_listener()
 		rport $client4_port token $server4_token
 	sleep 0.5
 
+	print_test "Listener event LISTENER_CLOSED 10.0.2.2:$client4_port"
 	# Delete the listener from the client ns, if one was created
 	mptcp_lib_kill_wait $listener_pid
 
-- 
2.35.3

