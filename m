Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A51199B1
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="yUrCH1WT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XID18Cd2t4z4sn/0HCa7A9CL8JysOKqlJOP0F8+UNpMttUs2n2/Y8HpZiKKxyA06j6tOxDs/F+Dvm7Jhevo4/QoksD3mTbXDMDYIeOOO4aekT+jnlDpQbh/kXMohiXOguVtXvlw0731PRXl1pAFVAR4QcCkGAvrALHUbHBVqI5SglHQ9BVzBllJX50Hy2HA3xtr5D2ASRbcQ9M+VFYrVPV7IxzF8uHweg1YNKsGJlQno8WsM5V1RThKOt7GfDDjSFS1pZC1LPcidPe1Le+bvEJhpJwd4C4KmGNIwlIU16qddtuYHjXEgYRG7eznT1+LI3GyO8Ti3vBxXHaH5YVzl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTG/niNTY1MLHiDNHM+ZEfD/7NE6Luy3abc73BnGUEY=;
 b=V7lTV+ku1MS3c4TiRuIbIDW3WnUyy9pU7XsRT+/kQ4WYn+hnTvG4GnB5Sg6KcO0Mj/5CawNxt4uCx4DDEz3/QS1/hSL1XYrerJk3fYI9c4/S1leNVs3h1KWqxCPZ63uLz63qts+yQkhQY0iq4A+XlHnQyMKT9Vgc6YWKIQ1U+zYgMIwbqGEkMC7hqiEartM27Ec0qnFaWO5ns1OE1Od8/O/rKNDVgLB92n6oNZmHU+FTktF5f/JkD6VfLBsNhJZlPTLIcRem7HQg9Occy2liBbaQA7zhUl2G7pTFITZAMFp+fZ64RDyTzbw3Tc6NTNTmoUYribpb1pSHya29deUHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTG/niNTY1MLHiDNHM+ZEfD/7NE6Luy3abc73BnGUEY=;
 b=yUrCH1WTD+qLnEiCqpCrenB6opB3M9rpNz+mBcAyl1BAzH9G01ep0JRrzezvMpolzhUVJyZ+Bz10WjJyXRcIWYPGqcwQkbdjMs3GStvhRr11c6K17ray7m+z2qi6nvdaGOt+0iYqRmR0dZ5hW19rmf6Hey9sW2A6pQevymoFy+zvP+AjIr7N/CmkVNF1VBBJ8b5TrdTarvXaQAOYSFTnE2F6fe85zO3Ugi59LmFBTr5cPgI1s7Xicg6a1ezoHRCLTWNgqzqxHOoxJapFaB3902Pr0sgpPjbwBrJv6+SI1ZnHjsM35wjrUURucwGqHc+MVWNZdYsIIpjfCkU7nZMFVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:13:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:13:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 11/13] selftests: mptcp: export cin/cout/sin/sout vars
Date: Wed,  8 Nov 2023 22:11:52 +0800
Message-Id: <964198a17b9e442db1918d9e22b1db771eae5fbb.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0023.jpnprd01.prod.outlook.com (2603:1096:404::35)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 339c7e48-ba80-4e81-89f7-08dbe064daa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5HMUjHqUYG8b4YLH9Q8QQxEKFeogi5YRcZs4eZltay/AKf+gz5jo7XF+D8W2CdyS65R3ImWX3j9bKdmHy896Bxwp8G9tbL/6zqMJyCMXrDA30a75f8FeHGCaG4QcrVlGDgQ7uXQhK4wUcV9UbYtlsRAn//dxqXd+DxizPuZXEE6qDM4KoPEyrZDLZ+vCbau7KC/luJsV7BQy/IKCK8AVWBTPRMkLKqhMBGOPJi/dBZntrGQu+62owTZaSXZfLKFTMxQstXHDJ6MCrSyxn2pLd+weIY8DSgpwQY4a8CVPMS7TazZFN4dVVCDispL49QmgEESFE+Zo2F5cLb0tBfzbhX1wWzJTb1DldraNLDSccIUxAhh+LpoJ4yH6JCeJ/TnmJqiuodRdCA1XoJEZ365jlfTiwOiLVNTTfUjEk8oTGT4jw2o+wlCy6JJdR4xtTPI0JB9TXzOP4+LB4KR9UgDsSuEUIme76cMZSzJohdcLcAvizatcDTvaGWX07y6zeWWcHC7I1h9pOa15QMB/THqIJKIVVWHdWdi+KywdMJxvGb8PxYKNMfmnnv9YbgfDT6Re
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(107886003)(6666004)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nbXv9iEGmST/plcMqUMyx7/l7PFWVu/cRV2cFv7bOFzmmXsKar3bykGT/bAA?=
 =?us-ascii?Q?qJ3oi/pUdVpwlJgyDnLoQ3YEFl7l6r7pq2YfTCBHI8f6CoQDYGQ3Kw5hvRIM?=
 =?us-ascii?Q?wA4zwS3ydj2sQz08A12YZtvHCBXlAyHY+GnKSVsNvauJyPYMj+MYWYmxR9BY?=
 =?us-ascii?Q?akJF413SbYMr3pOeUZ7qa7H/QsEK9LeGQ8OBLUAEyiVMxsJ3ujG3pvYDCyst?=
 =?us-ascii?Q?Zpl+rxWuK0vz2r7kZCq+dDcDGIwKwskwfUSXOSnVmcn4/+1Rh6FgJYpk5csA?=
 =?us-ascii?Q?0LOf1IwhFKF8+NSS5yUnFBrwU+1fgYK5xLKn6WKPVA/GVBMVd6vkhDZqF6wX?=
 =?us-ascii?Q?pvXXkxwbdp/BkyoOSdE9+v4KbMxzonjASRpGSfZtAUMIId+g21rHhAs0jBLo?=
 =?us-ascii?Q?u4rbUX8ky+QISwXt/nnfMc3Zk28QmtOka5LWTb5QY6wOgd/XujZtTXx7Ifnh?=
 =?us-ascii?Q?Iwy9xFwuW4vDTDYoVVt91wAqOHjn7SQczBgrjJxJXA8kOcht4eje1akbjwes?=
 =?us-ascii?Q?f3NgGJJ+JIAE47hA1K74kfLJ51wNFToagUxtw1eHh0e0EFmlDMFQTgegL3WZ?=
 =?us-ascii?Q?aPBI6Tw0eiSu/UIACoOQmUghbFOB7vcChbQy5H9krtONuSa5eHSITArdfefb?=
 =?us-ascii?Q?mBT4WjSdGQpYocpMHZAVg/6TnYDdytcssRDPYjY7hxDlP4xOfGYtQO1BtkWn?=
 =?us-ascii?Q?zosVwyubRZLGnsdpEchXRbi11nRuaL676mmqpWb18nSKdcMGL4S6rnPh5VPx?=
 =?us-ascii?Q?A5AheRfBbet3vzvx3LthLoi08Le+4nQawK3PduXevsFbgmdLv+UOnJ+iY4os?=
 =?us-ascii?Q?3TGG7TOgagmhFwVn8tbHYf71JRkWHn4R14dk2AbyNNT2zxbnVTg/dQknUCtd?=
 =?us-ascii?Q?jasXjLTxFVJQDZ44erbgZAIg945QJP++4uCrmS34QjeOIWy9zJ9m+k0AacXk?=
 =?us-ascii?Q?Efo7CReGTP99qhnsd6wV8u7nMaKnYdDMaJNHdrFamEpnAJ1JNVlIObb8UXRz?=
 =?us-ascii?Q?xtXlZmNRVbzKTCYv8Cn9rU/MkyTiah/neHKTfy32cNiE3c8DhDoWBd6He4/V?=
 =?us-ascii?Q?uVrLo9FxchwLmpEXQnepU8mur9tOarRCLufbNlBizzd52di1EiNMDFfeA2Ln?=
 =?us-ascii?Q?RVEJjy30WzpcHPQxBG2XxBVQbKvphn237AtNCjnN16Mfzddj80Muqsu+G/7Y?=
 =?us-ascii?Q?rK5iLpH90yBL8O5lvEBedFjZY1xtJ4dy9wZSqwmsb44DpnOsXdy+IrPx8eA1?=
 =?us-ascii?Q?iwRGJrJvs7pSboYhjnOHOgCq0/dJm8J+Tnu8n4qH4AL0hzepcovrTZsh4EH2?=
 =?us-ascii?Q?/UNBb5KmxO60/xMKg1xiU0c7FFoPHBMtnepe6+pGPbGGoCz3/WG4qD8/gt7b?=
 =?us-ascii?Q?yK8g1gCil9jXO9bgJWdyWZ0VYNZFz2m2JZgOfOxrOzkUCHKtSCGJgQ6hb1UY?=
 =?us-ascii?Q?V6aBlEaFHb3M/M1qeEu1LzFdaMOrHQuQP4V/Uwfwb26VYqrdLWf5nRidFxB/?=
 =?us-ascii?Q?RoOLd3hQtZ6+yAJecfHraBdXHLWd2KIrDbvydWNyP0u8RCmG6YBAJH3ykrOP?=
 =?us-ascii?Q?bcDfo/PHubqUoIpXlKvQsZsEARwolT7xYEwfFejw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339c7e48-ba80-4e81-89f7-08dbe064daa1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:13:17.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xkZK1NfReX0GlyAdepjmEJjyOgZjqmfBNDnQflEuzvzLLtEVP3tDl2JpHiuSp2b4Ho3fBIqwBfIdN3mcX3/EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

Export cin, cout, sin and sout vars into mptcp_lib.sh as public vars.
Then they can be used in all test script unified.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 8 --------
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 8 --------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 5 +++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 8 --------
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 --
 5 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 91f0fb386bdd..da932176c85d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -8,11 +8,7 @@ time_start=$(date +%s)
 optstring="S:R:d:e:l:r:h4cm:f:tC"
 ret=0
 final_ret=0
-sin=""
-sout=""
 cin_disconnect=""
-cin=""
-cout=""
 ksft_skip=4
 capture=false
 timeout_poll=30
@@ -149,10 +145,6 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-sin=$(mktemp)
-sout=$(mktemp)
-cin=$(mktemp)
-cout=$(mktemp)
 capout=$(mktemp)
 cin_disconnect="$cin".disconnect
 cout_disconnect="$cout".disconnect
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e468be7becb4..4aac1bce8aec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -13,14 +13,10 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ret=0
-sin=""
 sinfail=""
-sout=""
-cin=""
 cinfail=""
 cinsent=""
 tmpfile=""
-cout=""
 capout=""
 ksft_skip=4
 iptables="iptables"
@@ -166,11 +162,7 @@ init() {
 
 	check_tools
 
-	sin=$(mktemp)
-	sout=$(mktemp)
-	cin=$(mktemp)
 	cinsent=$(mktemp)
-	cout=$(mktemp)
 	mptcp_lib_evts_init
 
 	trap cleanup EXIT
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index e200eaa2047c..53e69fc807a6 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -17,6 +17,11 @@ readonly AF_INET6=10
 
 MPTCP_LIB_SUBTESTS=()
 
+sin=$(mktemp)
+sout=$(mktemp)
+cin=$(mktemp)
+cout=$(mktemp)
+
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
    [ "${NO_COLOR:-}" != "1" ]; then
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ac907bd302a6..780ceb9314b9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -4,10 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ret=0
-sin=""
-sout=""
-cin=""
-cout=""
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
@@ -336,10 +332,6 @@ do_tcpinq_tests()
 	return $?
 }
 
-sin=$(mktemp)
-sout=$(mktemp)
-cin=$(mktemp)
-cout=$(mktemp)
 init
 make_file "$cin" "client" 1
 make_file "$sin" "server" 1
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 92b08750a16a..0a06b7f41650 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -50,8 +50,6 @@ setup()
 {
 	large=$(mktemp)
 	small=$(mktemp)
-	sout=$(mktemp)
-	cout=$(mktemp)
 	capout=$(mktemp)
 	size=$((2 * 2048 * 4096))
 
-- 
2.35.3

