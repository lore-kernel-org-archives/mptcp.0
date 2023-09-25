Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E3125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw43WZwwjpBFanL0+IagidjaeM0ZTThNv+SFcaFtfxlGqwKLCpXqWTjF5mDYXEgVmobjP3EzojIbjBN+04N8EESyj0fxrFG6uwPV+Bt7Mr/uiuDrbAadrKS5ic7ec2mqiHOcWnmNQTrgLx5+C/hwKDWtvHauwpI6MqtBmQ8Fo0NhowTDcNXKrA88gJmwADwazEEMKKad1KS/g5p6m+/e7FOvwicmax3QnxdWC7heWTRsl2HU9nFwj8ptLAqoCG6U2nHxY/FubqXC6hylX8FgTqh3AHyg2L+rPXBwacvlfPVZTvsuZb+KrmLv/pRLLODYmS4fmhj4uEBKLPia53cz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dldh0QL60dVm0Zv3FutnsN/7YDz8pwJ6WGJ4JYinY0=;
 b=dOMZVLhjtJDkIwsF+EqjRIBhzFPXshbATgQS0HJf8uST+QiEAByhsp9zGbWL7PmszNh/3Mlf+YUSD99ET7cVA74lukGpegQ84jSl5yRzGI8hndzAFfdRIBMibODal20poPRvzMoDfzoLeQKzdZcpb/tqwUxhqfU2HbpXQ2YgqMqH2dc7Dx+8eVpxsDlghhF0cOiNNzH0CWMpZbpJkYJOM+1nYBWPurXQPckRTqiVb8CXDS2rhtNPqalA94depAR0diqYtIcRVhaeYbroLjA2g0M4G2UooYauxNXyaxQQpZW5Ov+YynNceV6yW5xBHci0BDpyWooqAZCGApddcUcT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dldh0QL60dVm0Zv3FutnsN/7YDz8pwJ6WGJ4JYinY0=;
 b=bFTulrVda1W7m2dOlL/4IR9Qcacyx+T1VUtKJ+qv+SuRXVoyoyZWdIOioLhQubmd9WzcO06bxlNLYRDUTHVZXZyJ06kF50LehD/fc5sGAirY8nOd6y196GzOvAw6yqNJQocxr0t40Mzo/8Ga4MkE7bbl0fzkuvT9s2RpNpjvAkgXTryyxSapZCRl20HL7eRxrGA/75zhB8BA42nPYiDPQI4JqSv7KhT8tSqR7WEQRKL4qWhQFMIqwkc+Q5IlJlmMol4Gmi++NleSJmJ5Za9MW0JerH5D5yD35h69QvimPbGSZkClSNSWtRnGcCEfiX+40tT19tduqCeKZZVyGzuGJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:42:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:42:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 11/29] selftests: mptcp: update userspace pm test helpers
Date: Mon, 25 Sep 2023 16:41:50 +0800
Message-Id: <b710fb0a444af95d66de887fe535d889ac53d119.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PU1PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:803:16::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b023268-9a1b-4145-1d53-08dbbda36052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R3GRkeY6sBjtZ+WSUKB9aTj8r8Zi+MMJzK9x0raz1yqBu4IXmz+WRY2/qvDUy0zlBo8kRjVh+t9nYv/2qHQGHQb92VxcqzxIh/FdyAiIGr61f/X5VmoHN7UNUGI7TwMPlNUqZatbn01EZTkuY0TEufzEcvCuYyjcQzOsQQmF97y7QLxu/PWA4UhCVwB+g4pX2XDo4vyW55fpcFjvAt7271QqLxjGjmXvXSh8Jlo/WOnsbZz6/oHxnr12/B9Ce5PT+Lxtmq+df7ygz6/ZCpsQH5Jy1QlsnzefKE+iyXgysA5UbgS6xbGuJ6lRqSuZw5pPNP2iOTDO4KLH523GN3iIo/pVlQLf0MaUA9fdQk/TLTatR+ma0JO5PjRgyiDjVSRjB89LGVstUjIlHrM93sNYTAHcaXp3oiIopQ1nw02piHq7tLoLoQR+R0IpVBg1mUXTBlP6pRN7uhW7ibVGDA99gG2gZsMPpotvCRpRhHuL7dOYqne8jlSFTgcVFND4IZAfR7JFla7r33ueKKXmz1Fd0AKHe15/C2crJxX2izWyLq5kqQPhspgzqk8YkG1n9hCJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6666004)(6506007)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(26005)(44832011)(2906002)(8936002)(8676002)(4326008)(41300700001)(66556008)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gOpxB9fOCNyevMx8YyQkISZQtt5fndyHJnOxeMwMNcjCxN2IqGC3Z5dAZEUa?=
 =?us-ascii?Q?EA4BPJdKqljqTVelCaM6IVK4izrXyubTF/OiHeVT4tegAI7iWjiogXnpqSHQ?=
 =?us-ascii?Q?CyXUWJW25HZ4HK4WzVPFvFtzfLXlgvCDwpc2deUhdvGRhZ/ACH6uS1bTh4FZ?=
 =?us-ascii?Q?pYWVnfVk2PL9ZTtQPwj5EqVP7vWvTX/PgtAXxav7PllcOfwc54yIRV4qPg+t?=
 =?us-ascii?Q?vi1kMuQ4AN09FdQBZE5sfHELjbYajxcWJ2SAMQRINTGX8JJfdpAzXe30kR0q?=
 =?us-ascii?Q?6od/nZcBALzw/tBjqd3pmOqE5pBvf2UYaH+DNAu7v5m9Zz8eYO29LLPCxAog?=
 =?us-ascii?Q?xsWLT/+gOSuE400TNFa9DrqeTrQouIVe/Snkcu1hegLMc9j1kxVNgvSJvddq?=
 =?us-ascii?Q?iuPHjxPymp6lEyXarai9N1+dFYioUh4R6sdgrW4UwhqhedR71XZKdMJXPjng?=
 =?us-ascii?Q?JvP+gfC1iew7FO2hb2+2Ubpg3710mJiP9z+qdNXGYcTYJxmGZ0ptYHd2J3yM?=
 =?us-ascii?Q?Fg1GwT7IWjtRqh0XitfvwAmgrB4JbXYIXItA4Druahlnv13aDtwPgGH1FpM0?=
 =?us-ascii?Q?KNXoEgyAF5txuGCjFD8sosAUwxXdXKp6nzLFLTD/AEW2EFuJNZocsQYwAdT7?=
 =?us-ascii?Q?HSYDiiT7e+sryl3zCspajgAYjAwRo0U3epVsxgSq/CibdeTcO9L8yMjmvIOP?=
 =?us-ascii?Q?9i4QSYDlCuaZg/rPbMaEJaMGdPkZS+ELeTlpR08MLmq7jE8GWzhoIooS862Q?=
 =?us-ascii?Q?yHedJxFZcO4rybCqCd0T9SWFGeGn77qOHo4ypLN0mptAbjl/Wf0HySDqmBun?=
 =?us-ascii?Q?kO0iGzlQXLha1u08eoSSQ2wTwk+0+EdT2VXSxlONfm4kSWG3aFl34fUEtfDb?=
 =?us-ascii?Q?rLwzEbxZZON9J56k+VCq1TcXTF5i0I6ZacoKjdw5wfC8HUmjiORY3qcEVs5r?=
 =?us-ascii?Q?tHYtcc/qmbafxVUQ3W57G1lgjGE0SAOdloG0MnwhmuD6x5XuDdpztimpanJe?=
 =?us-ascii?Q?Cjy5W869JxSgx/OFWw4QtAXUFVC1raDbIzSh0eCyAqN6ybnS/d0affSg9dv7?=
 =?us-ascii?Q?gDvWsFjg78dBCLn+/yO6F2T2jGzrKR2eXhzML9u8KWqdIvePmac3QsvzkBc8?=
 =?us-ascii?Q?t71Yq0DQRtfDuNefaJ4VjGgnNXgYHfbPBYdGQrmcnDVBwjL21GWFWvpLLu0B?=
 =?us-ascii?Q?RflvMd81lOsH4cCvMZFKQucotWyAmc5kcoRl/1ujztya/dcFH3uRQNshxOaW?=
 =?us-ascii?Q?CxqBihkClmVTw+M3mnWwuPE0t6MyCII/uUagQ6x/poKLraYKtXb71K+Doqrz?=
 =?us-ascii?Q?gDz2az5ysrtuBrEwz7eOW4VycZ65vxQ1T/cOrY8yzvcF0nrvAYVYElDNFquP?=
 =?us-ascii?Q?Bam2K0BHN4YIp8UBAqmBrBlE2rzSowduLSms9w4Rno9C2q61wYq6AJdAse/r?=
 =?us-ascii?Q?BxWlffvq/F0bFdbFdP+GYdZok3ltzwU/szyQOBoqZW3NH244y8/iCDtk3r3V?=
 =?us-ascii?Q?uKHqFW1+9zhY6GrqEXBm6xHw3nrS8yz3SHDNqjptsuU4RWw4J0X4n+CjiJyI?=
 =?us-ascii?Q?yiB1a/k35UF55yspAfycXD5WyBI4KPGYcZUDKV/R?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b023268-9a1b-4145-1d53-08dbbda36052
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:42:39.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xplNmGKHTgeCBxDT+fyfjVjZTM7X3e50C+ODMBbj8S+ppGQF+j8SQCWWABYybZOanuTzMMEIeSry9xyxpu2rLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

This patch adds a new argument namespace to userspace_pm_add_addr() and
userspace_pm_add_sf() to make these two helper more versatile.

Add two more versatile helpers for userspace pm remove subflow or address:
userspace_pm_rm_addr() and userspace_pm_rm_sf(). The original test helpers
userspace_pm_rm_sf_addr_ns1() and userspace_pm_rm_sf_addr_ns2() can be
replaced by these new helpers.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 89 +++++++++----------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  2 +
 .../selftests/net/mptcp/userspace_pm.sh       |  1 -
 3 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3e24ab7bc221..25c2948391f5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3285,69 +3285,66 @@ fail_tests()
 	fi
 }
 
+# $1: ns ; $2: addr ; $3: id
 userspace_pm_add_addr()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
 	local tk
 
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns1 ./pm_nl_ctl ann $addr token $tk id $id
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns1()
+# $1: ns ; $2: id
+userspace_pm_rm_addr()
 {
-	local addr=$1
-	local id=$2
-	local tk sp da dp
-
-	tk=$(grep "type:1," "$evts_ns1" |
-	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	sp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	da=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-	dp=$(grep "type:10" "$evts_ns1" |
-	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
-				lport $sp rip $da rport $dp token $tk
-	wait_rm_addr $ns1 1
-	wait_rm_sf $ns1 1
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl rem token $tk id $2
+	wait_rm_addr $1 1
 }
 
+# $1: ns ; $2: addr ; $3: id
 userspace_pm_add_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
 	local tk da dp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	ip netns exec $ns2 ./pm_nl_ctl csf lip $addr lid $id \
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+	da=$(mptcp_lib_evts_get_info daddr4 "$evts")
+	dp=$(mptcp_lib_evts_get_info dport "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
 				rip $da rport $dp token $tk
 	sleep 1
 }
 
-userspace_pm_rm_sf_addr_ns2()
+# $1: ns ; $2: addr $3: event type
+userspace_pm_rm_sf()
 {
-	local addr=$1
-	local id=$2
+	local evts=$evts_ns1
+	local t=${3:-1}
+	local ip=4
 	local tk da dp sp
 
-	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-	sp=$(grep "type:10" "$evts_ns2" |
-	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
-	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	if is_v6 $2; then ip=6; fi
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
+	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
+	sp=$(mptcp_lib_evts_get_info sport "$evts" $t)
+
+	ip netns exec $1 ./pm_nl_ctl dsf lip $2 lport $sp \
 				rip $da rport $dp token $tk
-	wait_rm_addr $ns2 1
-	wait_rm_sf $ns2 1
+	wait_rm_sf $1 1
 }
 
 userspace_tests()
@@ -3434,13 +3431,14 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
-		userspace_pm_add_addr 10.0.2.1 10
+		userspace_pm_add_addr $ns1 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
+		userspace_pm_rm_addr $ns1 10
+		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3457,11 +3455,12 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
-		userspace_pm_add_sf 10.0.3.2 20
+		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
+		userspace_pm_rm_addr $ns2 20
+		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index def35395a254..bb95dd967eb3 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,8 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
+SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 2413059a42e5..283c62deb628 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -25,7 +25,6 @@ fi
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
 REMOVED=7          # MPTCP_EVENT_REMOVED
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
 SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
 LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
 LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-- 
2.35.3

