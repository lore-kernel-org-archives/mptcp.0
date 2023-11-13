Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985048475
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="h8oFD7UY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0sYVm/8+RO4ZKHyn40ZuAJU9AblaBxwRsFmw/tiJg7PciXv4VjgtODcCeIS1qeUbPKynMx06B1WSTFXjnep95rpShzO25ISI70l+cxEEDgP/WTdZ5oLFuuzD7bAzuhDuuvDI87cCzxplsIU0rP7ihPpWBksEf/ANl6ZvMCUYF/hnFxkeDp8Hx8pZdCRFtd6kOcxCXGZjXni4MylEjxWGnEs2VnOeqpR8BS0hUEdiYbArC03ZLJLG7qkcIS25+TbhsVrzeYIFK6ediSfB+mbzmC/IcTXZ2xYpTcivwPHw5WN01QKq9lGYOE8tJHKDamuSqmSVMR3d7PQ6Ral7tQLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A78lMGeTuTDbl2a73tPye1obMa/0rVmMqd2I+JxJsAM=;
 b=Y8TdfENtn7l0oigI1gWZuPXPuWGHMfwFy37lNw/xrA+bkkAqreV7wQ0pljW0PrSd67oGi/Z3ru0Kl6Hizb3VGUS/oUiQUxm2r/yt4Z2PjJxTFhjJLj7nMTihgb5UJ/UpyCk5W39H5neDeNa9c8whHLg9jmmqXJ76bw/0vZm/ulSfk4Gla+XvAlfYXe1PopEPK0kSlxC4QxX2F9SLNJTLB0oeP8izL/af36Ss/5lJVv4kQPqeowRB/AMtLb4jBt+lrOLZxz6V8Q5kqa5qeMGOyO2EVJmplQHrEvGE7szvY9I9ihqFR+AK8oqWt5seZTiLUJS5laqw7mHo5MvW+SIWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A78lMGeTuTDbl2a73tPye1obMa/0rVmMqd2I+JxJsAM=;
 b=h8oFD7UYmxPzFp7i5VgNae/kesjTi/MaW2Lh2LRFgDqoHVOcCzZgKQSqZzU3cl8ex5sopiW7FD4gLgipo6nmcFE55MrhfcUY14L7k68xd0cPtksMhQuaoWutKwK6jFlCJU4S6yaKDc4CNO5rjUS7h2voYgJkG6ZcPbxzfUyPti2mKb0MLb/TFbAVy5mDJR5sOBzemZr9us0NoyfYAyxFer+iR/CPlHatYzFaaDKiX0grLbWOSayUDbYujXdebPO4/slJxeFeW56vVQYk0BA210ptbCm0RFssAXv1Ty4utreNHoNqXYeQF1qolZwmfFbKEX/Mo+mD4K0oHxNaQ+u3zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:50:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:50:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 11/22] selftests: mptcp: add mptcp_lib_check helper
Date: Mon, 13 Nov 2023 10:48:55 +0800
Message-Id: <c71249a4d7813feb91f6ce752195c727dcd3c675.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: eea9c71a-ffb7-43cd-39ec-08dbe3f33b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VrpPYFQVQ9zqCwFsIYZJrRSsa2y6c9DoBpeTtrWbOWjAsvy3sn5fK8qhn/TphOqgZfd5iG4JSBntyalBsPPnS32FQa9WLEODU4mJd/7yOTWNg5k3j+I4YuNO/O/M5G9EL+JMXCcuNADqvPQrmeM0j8mgb0UWgSsKdjkbaBWrRgmHLWLTDgCGzMzQI7UkpHe+34sx/rWlpp/20ramJjB2pzzw+6+nCxQqJI7PMB5cVPBuMu/kQm08ef3RkzuQEX9z91Jn7XNdPNEdFWWlSVr/8iOqsU/kPyeTeBKPZBOvMaDnqkIbsDcowGrIXZw2Wdow+m6Na08W/jAGxAayoljJEB1Ey04Ygox2dWjz5XVuCYvsYL3jUQcQowbTCnuP9ejKEQIhtM9yjRzu87517dOlULHICuKhebcZ+4q7Wdm5Pg3/rLlo3eo0QF6Y+chOqlTixC9oBdQGia4D7Mt4Sh6LUORqTA8Qosu32ayb0f2YStUqGfsMmvYTR1Bbt8TcMKRWD3MLyCRPb9QOeG1mBThyLtCsTlmcm7GVOwbwukIX5JjYzqA4DgVEEebeJPrT3trT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oqu4R1SD/YsXVWtQoOLMS4r/jEDkvMJP28NrP2kB7EVM0DP517eMov65t/tP?=
 =?us-ascii?Q?jmaPj1SP4ZTokl3q7OYiHEWnFJKRWfPkqG75lJhHjfNu5F5gX30OmH5eRPkc?=
 =?us-ascii?Q?nWuD5alZlEOyU9wpIeMVqXxTtaNWflLVJftR6RESt9h/DJqj770oo9jYFB5n?=
 =?us-ascii?Q?f2H5x/PpWU1ucORMzcVJBlG/iN5X9jCXf5edQqSh+RjCUuMt0TKl46aaCx4r?=
 =?us-ascii?Q?XZ7e00zICLNbQvdF/k6RL+yjI8FsFwGN2Kshodu13kQPGC2gRk73RUWKV5FD?=
 =?us-ascii?Q?x6Cs85EP20nQHV65DtWEGbM/u7NoGY8RLNfw9l46Fa3ToODTPgvIR/L0UUQ8?=
 =?us-ascii?Q?1Hglryphp3mkQUQ4WSjecCeVDFYwf561KlBl7niVxNArwUkNr30W0a+uaJc9?=
 =?us-ascii?Q?EiF7m52+P98So09S/IIHY3W/sddwvFOVJvgwEO/E8LJ/aAmWiRNP/ZIRdFqb?=
 =?us-ascii?Q?yffC7ZgrUYeKL23PG/+iT6S1mJTQM4QpmuwwcRvHJekZrkbcpqeFLO4JE+yL?=
 =?us-ascii?Q?c6wc95YzwExZQrGgTd/a10Ty36mNEoS2s/EHAyl4v1Hdc30areTUFDxkmodp?=
 =?us-ascii?Q?qHpfGenRW9KTp0NQQDK/9AJxPPYLc6ycRh6t1uVrh3ZdhPZLK3zcA6PsMPb9?=
 =?us-ascii?Q?l4zv0DaiCzJB1Bk9eb3IVNavPQvMps38KP8IJtuf8zDZQdQ3ObtoaNYcrST5?=
 =?us-ascii?Q?uUlt7ZZ3pBj/pZUDg8eHhdvnbKwcO5YTrkQGzj8zWtTwfDj4GYTrevS1Jtxw?=
 =?us-ascii?Q?blC+EDJhC6GZ9azAe7ogdSAyhEnVBg74bc1mUWYFHOFmLsGvyJkt8ca8Vt4K?=
 =?us-ascii?Q?iH1f3cqK9IBPaO5ZSuPQWtNRDkHfg1XMVdB/ZWLfl7pqvS/adIS9eRiy4ik+?=
 =?us-ascii?Q?rMP9CJFLf7AZhtpEdNG9nfjRQa/0iTM2O6iH4US9U9k6EEWeJ5hrPXd/U8A9?=
 =?us-ascii?Q?TOXhhC48gMrMBs0oT2GKSGZj7A8M57RAMEiKAyxI6Yqwjegu5aVlOuZ3ytbT?=
 =?us-ascii?Q?xAb7gi2VoqAMsWyBU6oO4xCDsGc+DdVzhJF7v9tMUA94sZB0QMVk0STu1bqn?=
 =?us-ascii?Q?gcCa6VhW2c0g/9pOgKqxAAg+seJ8yrLtwYLnbwHfqBKt/AUPWKFasiAc7kyt?=
 =?us-ascii?Q?pBTKNf6klfX6XaspM3JaCJdo/9W0j+ulMpPVhJi6303jqs/Ly643Rk4FdFqa?=
 =?us-ascii?Q?6G262PdSlYJ9KpyHj2nWjel0TCVfpX4arUkTUb7fkxF2+P9ux84gG/kFHWDG?=
 =?us-ascii?Q?W9sbzyLcfRcrLwB51WcPtQwiieqqDACe9HvdXqVZIH5c0WntOiIHW0eg/HMW?=
 =?us-ascii?Q?hsyFgN2NfD8N0/SWelYe3DIF8zy0wUvc/K835TNHq+nDSLTXy1uRuqbKQadb?=
 =?us-ascii?Q?/sI5CNaZj0mXdxdYilCLkvO/Ln1qJoYcMWUfFyJqcjClIC5jL4pEqo9ANlNl?=
 =?us-ascii?Q?tvdNpmb2IqjWs8LA0CxXqQB3sIs29JdMwI2JA2hkrfK/5ZcO808p/x4Gl1dY?=
 =?us-ascii?Q?T+yh9mFeJXWrYEOVUuC5O8eQf2lQWaj2qrcio9/oQhN31oRWzk5p8FXX6ext?=
 =?us-ascii?Q?vfEbHEczg0gDgisLnNNp9C0/MDraI5huzj5aesJG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea9c71a-ffb7-43cd-39ec-08dbe3f33b47
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:50:01.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3PN1Cl3dkeN6Brkx25QdQBarCYOq39FOC1ozoAw3Tu+vuUKi4Y18ZaNo75KQiEmu9ySkSAnT4+aqZv/oPeK1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

Extract the main part of check() in pm_netlink.sh to a new function
mptcp_lib_check() in mptcp_lib.sh. It will be used in mptcp_john.sh later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 27 ++++++++++++++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh | 28 ++++++-------------
 2 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index cbaa55ab89b1..466fde97d3f4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -300,7 +300,34 @@ mptcp_lib_wait_local_port_listen() {
 	done
 }
 
+mptcp_lib_err=$(mktemp)
+
+mptcp_lib_check()
+{
+	local cmd="$1"
+	local expected="$2"
+	local msg="$3"
+	local out=`$cmd 2>$mptcp_lib_err`
+	local cmd_ret=$?
+
+	printf "%-42s" "$msg"
+	if [ $cmd_ret -ne 0 ]; then
+		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
+		cat $mptcp_lib_err
+		ret=1
+		return $cmd_ret
+	elif [ "$out" = "$expected" ]; then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	else
+		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
+		ret=1
+		return 1
+	fi
+}
+
 mptcp_lib_cleanup()
 {
 	echo "cleanup"
+	rm -f $mptcp_lib_err
 }
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 85b2c9145601..8d30d4a1db57 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -27,12 +27,10 @@ done
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
-err=$(mktemp)
 ret=0
 
 cleanup()
 {
-	rm -f $err
 	ip netns del $ns1
 	mptcp_lib_cleanup
 }
@@ -53,25 +51,15 @@ ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
-	local cmd="$1"
-	local expected="$2"
-	local msg="$3"
-	local out=`$cmd 2>$err`
-	local cmd_ret=$?
-
-	printf "%-50s" "$msg"
-	if [ $cmd_ret -ne 0 ]; then
-		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
-		cat $err
-		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
-		ret=1
-	elif [ "$out" = "$expected" ]; then
-		mptcp_lib_print_ok "[ OK ]"
-		mptcp_lib_result_pass "${msg}"
+	# ${*} doesn't work here since there're spaces in some arguments.
+	mptcp_lib_check "${1}" "${2}" "${3}"
+	local rc=$?
+	if [ ${rc} -eq 0 ]; then
+		mptcp_lib_result_pass "${3}"
+	elif [ ${rc} -eq 1 ]; then
+		mptcp_lib_result_fail "${3} # different output"
 	else
-		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
-		mptcp_lib_result_fail "${msg} # different output"
-		ret=1
+		mptcp_lib_result_fail "${3} # error ${rc}"
 	fi
 }
 
-- 
2.35.3

