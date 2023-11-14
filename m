Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE14612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MqS5QzSX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNWphbCiU5UOIWhOLUTLCIgtj9luiPrCnVGrb9JXtB+4IIo8+Wkx8Ef/oGh9qd/Jlb1BkDtXfrhUPtcv6Y7JINaHUBffn+5yqFpLg9d/hbHOnE5B5ljQ+BXmgz6zIy6mteVIDxQY2lL4mUGBCuB163QZlap2AwGaVVyOI/G7VDvjaelM6CV2lHexC7hMz78fZR1QBCfhINOUH17C58PN267wTYywGZY1zrZUHyKf2uT+csPixhl0Q21n9/E6C8Jjp+XfqPieK8w1KOwRehfYBUJh/lrzXcklHdOlpPKPCLNuswUIO5tjMj2xJ69W/6CWmeNCl+Q7K9lzMXRKWbwyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsNF9dD9s5fGwqBuTg4zevfjN1o9wPo4YwgVdroR6pQ=;
 b=TvvDCcy5aPm1Kk9zk9QyxeF7f3OEKCuS/2nO2LeI6ZtPP5pzQt2ByVch3Rm+7mARYGcU4TnsB1bj7LgKcl1H9Mc3f9V9Ji3x85bf/1BJ5eMnY+3ip/LOUcOOrq/LsL62dmrruUtgwF8U5ofWrCVnvqxdq2WiO2bT3buSmgLyZPYZDyjo13ZXCJN9q2RgWtbo28Z3wgiwILOPBrCDM6rIOkHGLAeVtSujY6ZUnPOC8SqbgKitoJKwU5zoYhBFUH9giiniPxM8P61fj0MV2HXmLvkxxQQOc0ABrJ3w4u+OhSRSojGlLQXWig5GshqbN7mPIduNbslwBpwtLziyYUwpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsNF9dD9s5fGwqBuTg4zevfjN1o9wPo4YwgVdroR6pQ=;
 b=MqS5QzSX+HKktBFIp02TaEJghSuqTx9jIhGY5LH6X6nMJGPPtz4qSHeinECEDGDDGccPSXBxShLRn2otE49irlz/fB7cbpyVKWJMkAbOfc1uBEmGvY9PsEDTZH/cFHilnYVataa8chXbQLnWL8qhj39D+x07Hv5gn1gvlebD6tE6RqHX/Ftx2BRcKKv1+HTqzaHzjClf+zwIknNFJG+wzXTKa3zWmyXOolXeEkTp7otzO6lD4zEnw4PGto/UXDUwl6SdljwtIpxmyQ+UZPpDeGRcTLdhGDI0TIFvMq7V7TocuflDy0SJkxK9wwv3TV43vEsleykIom9+bCW/2qSVkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:38:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:38:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 06/32] selftests: mptcp: export ret into mptcp_lib
Date: Tue, 14 Nov 2023 14:35:25 +0800
Message-Id: <b4db8cb2a5b88fdfe4bfacf4e0e4545b356750e1.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:404:a::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8cd5e6-2f3d-4f18-8618-08dbe4dc57ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2N8jfI98h/D2XzKfHnI7kTBMYAn0ooEwT49ce8ySKym2TO//jtqVnMjk/j6c20Oh72HYXUZjYa/T6PZ5u6GlPDCdvPfGL8HRB3NeAUFy0Ue+N7roQgFOjezA9P0nyoV8DLX1qSbeO/4i2LbQ5QkzpwncJPGCX0XnrhHvF8h5Gkk3vLFBKa6NybHJHcngTGgVXZTgjo2uCXblfyaG7oVxpSWoppvv4hF+erp9bULg7ZLsOlPq8Vp/dOvnDXNdqYu/mnXwNJCnBLLTxS8GyEGOUtKItUXCuitUWuD6uvy2YPFickCpmmVh6kCSFoQ+0+aQSRWP3RdMm2V0w6EgqqG3/kr4Oh7WTQD49dWHVJiai/u563RrM18fEs4bxNeygDsdNlZmOaP9+5LdVmBotKYpLzpvNQQfBIOr8rkuoDKgObPmqGp7bdSSp0XLfRKLUVXw0IWN8rn5oibT6vC9gk3pu2Xm0V28wUir9icbid/b0HQjR/G/b4BlontuEc2IvMmKLysj+b2Dl2lLrCp+TvMUOBTCZL2zgmi13t2o3IX6zmH240XP6X5yfXUcf85neBf9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?89I25zLB4oIIR8KGir22HdpMZKUR2ZvCUrnuo35UpB1dknN1HXLd9PMmWDQn?=
 =?us-ascii?Q?U/OZEhU+cMshuL0ttVXpNuOPUVJfAc9QvFgqPZXvdn8RKwHhpfBSSRT/2QN1?=
 =?us-ascii?Q?1eDNzZDgOm5Q1j5OE5h4MEl2xGtq1XYY3RSdfxDrGjbNMC5cHfMBSQ5Q6Zlj?=
 =?us-ascii?Q?yAzzvuytBT73C9Kp8zzjDY5SxjBoqFJo51QzRw2lkTMWjHpCy0PV0v6itGp+?=
 =?us-ascii?Q?B+K1R6l4bKpCJyqoi7uQejQBLhleRLgjlvF61BpdjcvZILCAQg/ugWZIg03u?=
 =?us-ascii?Q?bC/U49/6rBYQagHPDf9eI1hkWxmv3IFPIKeomK2TprgoX/SvoAlF0Om4mWSV?=
 =?us-ascii?Q?jo/Bhyvv9BVOmhJEulg5184NMTOS2YBFFfxoEfxn1ZA4LPiwdqwdoUqHxtyB?=
 =?us-ascii?Q?mFd2KBH+vAQGWqohI4Tm2Di9l4JVL1SncV2Z+z3YIJZIUNlL/oxNhxZK9bLR?=
 =?us-ascii?Q?kKIeWwm5ZYH+fYbvvuXHIrhRYSSEdZ1aQUbkL/tBA15puKUatSpZHohez2P0?=
 =?us-ascii?Q?n1hua95rvIRhgpdcGgvQFlJhbncF9jYmWZlkdo8B0vTThJowLKYaLGWCag68?=
 =?us-ascii?Q?Y5XlvjD58Zfh4CqN9LEpj2bmmA50mqb4Cp9JQC1cMXK9XU2Oa4hg/2k1xm4k?=
 =?us-ascii?Q?eTa64eylPxn5120m8BP9AHM1h/qTvbg9p/Ufk65xqvLIKJcp8nT1SzqGD7KM?=
 =?us-ascii?Q?++a1cb/VKiRINNgnpOj5zXVRQfpyH1FqgpOTxsmVpnPLg2wd99ig4Dx/RyTz?=
 =?us-ascii?Q?schui3wBx4vPEYFQA7Q0bJB+ttrFApj3GfmVGQ+B9gwUOMAa7LZWPE9WqV6T?=
 =?us-ascii?Q?glYGqv70QpE2M/RZbI02w1HcXqmcFznI8du/VZp/Bq+HFqY0yEcAjfMpNN3L?=
 =?us-ascii?Q?OgtrR/fxzKFH482YH18f5xIB2YV0Ms+JdTLtOJ18QaSJOMY/qFr4vIfwSK1P?=
 =?us-ascii?Q?E/0K3PS5poqq2/8w8adH2+TCnNxles2LjhvfaWc8+sd7mAdDlv97Wpnmn/uY?=
 =?us-ascii?Q?d193YlR9KMhQcqNwIWZdwmZ3HKYUZeRNMFsnjd1PLo1CtnaBVuJw7TzF4J3N?=
 =?us-ascii?Q?Sb2waZLmEHNtAMpZeM/Bpjw74VN6q2T6vC3YNTHgNyCSGUgZ4HZwq2TGMJ2+?=
 =?us-ascii?Q?6OU2qklG6t+uKGa53BESJokCCOnNL6ycnQMmDBeb+0cYJ/8avUg30ADmPbx8?=
 =?us-ascii?Q?oeTJJPY0JFo6HNeeUzdZWYaxh9KSKX5hJHaODNFqNk9Z89yRLPvu5i4VZCSO?=
 =?us-ascii?Q?57PQsqSyiyUtUMPImkpvNXW5W9lKfz6fk2jZ5d5oE/Pf3E7aa7DUOLLK+0uz?=
 =?us-ascii?Q?Vma2VHY/wxFGKKb7cKaXSaQm1HdHIKpccvPz5LNYRT9FOiSO4Dq4C57S0Pz/?=
 =?us-ascii?Q?Xz3MASQ8VI9kgbjX5QVfARHyCx/ieq9moJVP0wj1uT8ujj/Xvc8BS4GRrUWU?=
 =?us-ascii?Q?RoXI/MxaGLzA7Kr88Oe6QJaPg0uR0/Vi7DnLXyD0ki8W/0gKLYpegRjTCVmc?=
 =?us-ascii?Q?BrvObp+O7j4/hggSNSk675j3DhditfNrz/6sPckYxUNjau9J1GGRflCvrhGU?=
 =?us-ascii?Q?XDrAHeP4akhp51Q8y+VyTi/0qv9rgH0TBwEplW33?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8cd5e6-2f3d-4f18-8618-08dbe4dc57ce
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:38:42.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZI/RQTDxKih1QYgzIEMwR9711ekkLbIiQok9YPQHrAQJloODfQ/MeqmG9mFvQ5FLno8Cf8R0RYvgEMXc2+Stg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

The variable 'ret' has been defined in every script. This patch moves it
into mptcp_lib.sh as a public variable.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 -
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 1 -
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 -
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 1 -
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 -
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 -
 8 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index ab62737bd501..300aec419dd6 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -10,7 +10,6 @@ ksft_skip=4
 test_cnt=1
 timeout_poll=100
 timeout_test=$((timeout_poll * 2 + 1))
-ret=0
 
 flush_pids()
 {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 98f4e82789ba..5e28292e1889 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -6,7 +6,6 @@
 time_start=$(date +%s)
 
 optstring="S:R:d:e:l:r:h4cm:f:tC"
-ret=0
 final_ret=0
 sin=""
 sout=""
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c5cdb8b1643b..1ba49a668eb1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,7 +12,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ret=0
 sin=""
 sinfail=""
 sout=""
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 4f741725436c..88ea621e7df5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,8 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
 
+ret=0
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 75d8c648f9de..45e5b5810a6a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -3,7 +3,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ret=0
 sin=""
 sout=""
 cin=""
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index e995dfca52cc..75c7594dbd71 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ksft_skip=4
-ret=0
 
 usage() {
 	echo "Usage: $0 [ -h ]"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 23f5bc0aeaf2..3536c7160ce5 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -13,7 +13,6 @@ ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 test_cnt=1
-ret=0
 bail=0
 slack=50
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 0614611b7821..7de2ca99edbd 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -54,7 +54,6 @@ sec=$(date +%s)
 rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
-ret=0
 TEST_NAME=""
 
 _printf() {
-- 
2.35.3

