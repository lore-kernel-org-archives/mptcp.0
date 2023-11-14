Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892318C1E
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5yByXrrD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHxJylhIbI236YhESvpETeuJHHS32j0TVe7samyTwTvXRcvDt6NLQ4VAgWv0i5FiXrJcE06VFcFWFQIsNFJqzRqOpnQdbwCpzNtm8SYdsOfZeugeSSllbHQAIcQ7mfMLI1RV5L2dCtqqYiup0leYTeu3WKoi7R+17uR5KnBufWowyJmjdtmYglkATnL8eTtwiTL8c77+eHIjdaDfxTN9mW5Cb5AHMRg1fU7ZzED7ZTbHQHaWyl4gumkOgHOHqcbJn+F4YeO6tL3z1WzhyHYV2I/3qvrooVnpxopsThAZGlTyQF3FzZD7xCDKWHWC3c43+BCABicRQ3SHURqVm7gaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsNF9dD9s5fGwqBuTg4zevfjN1o9wPo4YwgVdroR6pQ=;
 b=co0WIVA6ucHHYkZC8uZEI4h80ueBJncHCViqKzG6ZkmMQAsNzIWJrBAfqmYOwKKBkvjZiROQHHWNppXz6JC0Io3I0EBE8Cn5U3aheifrVdQAL1rgwUjXwvUiUQBm6TQhSpn+Ipv/5QSUDLlKfF1CIS1M5kC80bOzOP9+Mer+9JpfFDuodia1uFOnXMPbpZELarRCWt84uganbKkYjcA2+JmrWF3IOTjBZvT0jMRBjmg3nCH66Ki6hW3NCPiOxBTk5mXfFiLW4815vC3CJsmqn6WyTaDf+6C41HWKeqLNPTe86VD120cEP4EdB4QI6X1hyTBGkVtUWhz6Dnuz4XtFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsNF9dD9s5fGwqBuTg4zevfjN1o9wPo4YwgVdroR6pQ=;
 b=5yByXrrDl5SP5RC4oOsvvJAr6Psnttg1R0cx+ZBFWoL++oRv5XhzzLnohZ+BUrwsIERqogeMKccliOPDM0prhOckqbnctmK7j1mVgEF6i0u1kdJE4Cf92iiaHrcyzYfWSF7lvaaQEK+lkH8L5zYxDJDE0oXDHHtacrCzrvPHCENQuOBIyuv7LsTFOWfRQONlixmOI6nh44XWOYk1wuUOap02TtmyI+D2RMuC7IxQxsy6gS4AzdU1KRoTCKOJawtrxhsCk78AGOz2V/ogQxweVSwA4ZqWlmfjGB/S5g+4+nEsx6bymDErktf6qb5VxazLhruadl7fRbMiTK29yURGnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:22:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:22:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 06/33] selftests: mptcp: export ret into mptcp_lib
Date: Tue, 14 Nov 2023 18:21:36 +0800
Message-Id: <3b265d8fa4eb6e4dc5e627ed7796571cdd391fe6.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0187.apcprd06.prod.outlook.com (2603:1096:4:1::19)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: e86b540a-be3c-4a7d-aec9-08dbe4fb9b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lzt/aeRcWG/O/170kD/kefH7v99UBV2Jf6Tm5Uu7k6fGClWwkG74XRCtyIs/InVQRdqvKpmDWCq75Zd0EieCp0DzE3uYSobkKMWpvrzHw0jTDDAsq/7uQIFPe05ExaFqlybAXSkfP2JexnjsIfnSG8zfdJyXI1a0KDFwRvJlz7rMQ6HxvaoamufuR2Rk2SSXx/Szp3d4ZVHyK7dZ27Eag8nWONXALetJPLE6yGY6mRsSEd66aZyPp2mA3LoVUOXR3Bcmec66r94AjCqIN5cbs2tTZ8ig33eH8q8QlXI1C9QVIU0YdiAF4TQae98ZiihWtrQlhKOadP0pz2UGUmhfhYNay9Au9BAyfjHO6nN6zOA38YhxO36b9p9hvdoJsMiInLR7/04Ml6yC8JM7IaEoXA1vsJkCax8gRQPMOGJPgZQAJrvbKEDNtNa+JPlbYhP2eu+Ph0bYE8XrnByWM1Nc+yubdoFvfyOW5V2PMpJTZgkFHSa3SGJ5UW4Yn9kBb20T2Vx7Hxt6ad0jFnJkeuUtg9D6DG61rsOaW1F35ZcYdNGF2Ws10SJ6zHuQcte95ngy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?acvgkgHiZdmVz2I5QENuTVum7uJxp7deBz2a+M+GORE4W3K1BwGk+Az45Y/N?=
 =?us-ascii?Q?L+nJKhxskB4EQApljimw5KH0gDL1agj17eTNIwO4LlpZ0Ujss0zTCMBVHqli?=
 =?us-ascii?Q?hysGRR5oUDUiLFVN6x2O/zMDrlgQiiFRxJLnuNDFQMs7kdrCVnN89sD2z0hX?=
 =?us-ascii?Q?QkGwJDLu0QvLvn4sWlK76RZkm27F580jyF9wgIgofh3J+W280qrnxRgB88FW?=
 =?us-ascii?Q?mOhe64TPPM2fmIw+TwZ9rmwtZHS9zU9O80EttPtt+3XjJ/6uf+SmKIzgGf27?=
 =?us-ascii?Q?5FRWpIb2gT7eEW5eJp7rcrIXeNg2SXW1ZJtB6+9gz6CHHECbTNMMhTok63Ap?=
 =?us-ascii?Q?2sZ1iQ+rqIEs0/2oP0oDj96r/VslsbFhB58cLTgivkzHuDPoB40cBVMOWXzz?=
 =?us-ascii?Q?t/RBkOMNIn244+dSjHf3poEEgGIxknECct9WaeTjE51r792q4bObWmEQNoPz?=
 =?us-ascii?Q?FDOqivpHlvkrCXn5XPj41MLfm/yfFKVC9H9TQDYGFEF1h1NUk/wPHU504w4X?=
 =?us-ascii?Q?fVlX5tK3oox6mmIBgpGhN7hHZlTmfcqy3q4aFgXd/oenfYehxsmlz8r5wm/o?=
 =?us-ascii?Q?S6tgY0AI3A24SKk8zjTtO7zgIiyZ5/2fyiuaYT63TvR2HNTNOpXvwXKdP5MC?=
 =?us-ascii?Q?7P05fgTlx1CRedtR4nYVFCTVn+5wkA61cmToSWjGcfn5C+63Gj52j03AcyAF?=
 =?us-ascii?Q?trfDe674sD8fJcgVxNEzAPiblnbsB72xyeCUEHdXOeToOItH8BvNDMFsadeu?=
 =?us-ascii?Q?26Az1Bb8D+n7mRgo3RBk9INUn4Tbvdlq02+VM/lfyWMqOvscot2zZpGCrbLu?=
 =?us-ascii?Q?DPDRPOfHEzWJ1mwI+pyHFp9TMndp56XUaa+jak2X7qyBhgd5EIOqwi1N+4e8?=
 =?us-ascii?Q?Ne92pn4jnl8ILjeXJx48mMULQu4Uq4l//vTAnoIvYfuUujH9uhWAEWNOspNs?=
 =?us-ascii?Q?16Z/5hApP+TY3qJMjG87T5MdH641mYs5Zxxgm1vREd4wORiGoSCSlsbotgGN?=
 =?us-ascii?Q?Awn6sJ3oKGoTwdiSUoqWHvzrUYP191+eulbmqA7iLEUeVkhZtv9hRcwHfrGB?=
 =?us-ascii?Q?ofmLVWv2TgmmK5qDlkXGcqHeJZI4RYtmsv+5W9cg1F7Z88etiipnHjvsgQ4y?=
 =?us-ascii?Q?n6VQc+WokMyjRf77aobw7t7z2GEZbv49tbGq+ThQWgoMsWF9MiK8K8aAscMp?=
 =?us-ascii?Q?S6zaN8xSPy4J79h5lJY4lyatNWH+IUAKmTT8s4HhtSTlbu6b1FBCNM8cX/tR?=
 =?us-ascii?Q?wXbcAijcVNsqLRZ4ZhHzaFXPN7qXHG2jBVDrN7n/+jcliPUAqt31g5qEA9eT?=
 =?us-ascii?Q?TPBkIp1F6rk+8O2r6q6agBsS4OdiEbt4uDv2ONRlprgm8zSHbeXWqzzxLTqy?=
 =?us-ascii?Q?2XWA6uUBsyFfoHqP38fOawwQ5ntJURZym1/f3fosTnL91p/dc/6hYtTmH3f+?=
 =?us-ascii?Q?BbjWpgCCFDuP6fDQ7ycPkFuerkFJoskObLSs4hYJlawDiFwegIO4pS6HwNMF?=
 =?us-ascii?Q?ZIsti8BwfcdlQrM4D4PheBhwaxIFcqbTQboPypkFFwr9PUioBUhr2fwwMCMg?=
 =?us-ascii?Q?W8DSyCT4lpBOnKYPeWfhwSsWriesd8gLaRmD99SGuibs2eaIb/cywxaEebBQ?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86b540a-be3c-4a7d-aec9-08dbe4fb9b81
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:22:30.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+0s47PoBTIy9vc5Cfu9qjnZskwHGds1nBFn/iBnhOpukwVo/HaqNXjTLH0Xumsxs62a0oitNMblfDEDhqH3Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

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

