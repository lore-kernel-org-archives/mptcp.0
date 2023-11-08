Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C3171CF
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="oc9/oR6I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUHqOF5Gd7hxEePv73swGMIhQ7zCZDP+9PPKonfVjEDwbxWV17bJCYnyTWLbkGHmd2fbR4Uj7pCzhJnR2sSxgXlB3rCiGydIyRil/IVUdt6Tky/JFsor9015DjBDkjAfiqYRs7Q6lqDu20pFE6/zullh5SgI+Ay7cQam6g5KUXVoLjJ9DWNdNij6FeEyGFdRmOA5BzMUtHu/NAnxbRDQHMqLalyHGDsYkOXWiEJwDFnovoK3YYRBMRCMDSq9fK9y9Ak0X8J1jBac/ryg23MoR89I3fmNdVZF67tlhMvV/mZQdsIaxt1LlYW8RjqAjgbQzYFsKZL1Xd7iWJgF/is5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTthkCzIMnah0chDOTUoCvMSB0ROLYlygZu6oySuiEE=;
 b=JoPEk0ZtJO91oDIAeQt+YzHQREJACvJKCg+T/+OIT2v8NymOVB54FY0E2Mz7Ewfmq1rep2Ud1+FW6qOrC2ZEUxKdOmBowk40hiqllYjHLoYLOJI+9Rri83Lv/K7aLgpm2BUa05dUS4aAfzFswI1ao+imFlu/HXV6fD5Z7qCeLG1a+dDPuQC9Yv+XQK5hNZrfmT5GU3bs7aXWSYd7RcaikjQIxHhper5khW6+73JaM1J3SQtxpq+iZ0Q5oIPw429JwLDyq9HhX0k+BE5V7pQ+xMjffh+g4/fDV0Ouu6/B62VIyUA4TyXiruCY/z3ulIPqqoHsCb5puWcosEW2GNq3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTthkCzIMnah0chDOTUoCvMSB0ROLYlygZu6oySuiEE=;
 b=oc9/oR6Ils9nq0bKNN9jpuFugry9lFWQdG/rsvdhVDVUO50PZaCneiFi1hasPlCV0hWUMv2Kmc3GS6o/izE7TW2yRva6yU2YIz2K0gtk4Tuk2QjP2rEH8Nkanig9jGb6Qja89mu+Jo2q1bZs8/WagkUWsiq5Lvx2UOU21FW8q+LUOOe/ge0Z2p5D77+0U1aFzDAw3uXsuGMbJWkbd+iO9z5QrWsG1BnmGEAQoGySsuWti1WMpAFq5oIEhfJW3DQq7SG2amJQqV167D1fQI77ajlvMm0eyYpt+CcmzGvm6r0FjZXNcdKZjZyYMPS/98AEQqlCuFgJnMYyNme5tvzVOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 8 Nov
 2023 14:13:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 14:13:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 10/13] selftests: mptcp: add mptcp_lib_init_ns helper
Date: Wed,  8 Nov 2023 22:11:51 +0800
Message-Id: <81c3771b575c088185f90fc76d9e2f69648a377d.1699452144.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699452144.git.geliang.tang@suse.com>
References: <cover.1699452144.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0013.jpnprd01.prod.outlook.com (2603:1096:404::25)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ca209e7-ce8e-4772-44ef-08dbe064d525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9RvxVy24+t1+ZB/S+tWzvPlAY2FEhTKzIlnMTU+UrC3m9AjYmfYUUQvXPyoI+UVdOgLPKYPQtIXKFhZ4VY9j9zWOeWq3Yesp8MfUNlzaC0bi1QptYIYpgj95hIFIr0TKMH4mzpj5fk3TZMOnhMSOPXvBvoqY8FVvanNL83LdPxyoxns54/ms1RQHVOWZspPDtGDiD0HBfwUsddvGgJrTEgvqVziEUmcKHK/R/3i80X5O5cx2c44p1kv2+p+8q28fDAGrOhv5sT+Y4F9NjV5qYUQlri3FY6o1Oy3QsepdIvUCudt2u8NYuuTcJpAyI1/uX6AbiFNeLi9lrTVEEkGwh7UhJNZw932oyqlQrG/6dIHZCKZSEECnqyflQ92R7exX4ac9a1VX7OI0+zfASaL1Z1VPT777Be2blj/niFgf7Ljwg6PCV1U01yjaRqbyoYifiXNWCFS5d4EnY4KH37eKI6155CXd+okYFwQecObzkyfpYLh3TmatU4o6n7tQSkq3AHOQnYjvRcY1U9wVOhDLQn90ih7CzJBMHHmU946i4Z4AfWXwHnib49scALaacXoT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(366004)(396003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(478600001)(6512007)(107886003)(6666004)(6506007)(83380400001)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(6916009)(8936002)(8676002)(6486002)(316002)(66946007)(2616005)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NQNT7BBXVbK3VTOXe0dq1S5gmsBmaCUf1QbIJmuy463EFX18AqH8ma5p2gPy?=
 =?us-ascii?Q?X/Afk+yu6xJ4k+fGrFGXFLsk63ZRMkPT8Kg5Gv2kIn0uDhZq9CDLDmJ1+Lvt?=
 =?us-ascii?Q?1CogOQ6f8YFbtMC6qLrjxTFEEI1MLDlyGL6xwf10iWJ4CCW4iWCOX9otgmqL?=
 =?us-ascii?Q?pVW8DiGNV6Ga8WQsKjEodBMDXE0YyFw3lQc3uHYYxgTLL1wv9vWlC92y+mbN?=
 =?us-ascii?Q?3JnuFb/OiOs0UVUar7+DSw5NpHu6TFyOKQtpeoI+7Wn1dzCfTeCCJbcICWsy?=
 =?us-ascii?Q?6ibVtPlvQBp6Gc7WzL0h68g9K5XY9ZRUtixZV7XCaN8+eYRAMzRmbLUW8ixf?=
 =?us-ascii?Q?yeFT7FmtLBbDagOHcPgIRcMosqTvD4GKuCxVbnhMG4GY7W+EwG4UGg6zgJil?=
 =?us-ascii?Q?aCMN382MskEKkYfm7Af5Syy4wISxEsavR77Q+1WY2o8VzOGpMs3nOlxoQHrM?=
 =?us-ascii?Q?HKjtznv+6vH+w284M8CGm3lGB22j60xfK0dwHyQrrwBayj3t6/saYNJD8DZj?=
 =?us-ascii?Q?3ugt9zPAWkSrjKvGm3zuB01RpZMeaM9tJvfEXT3jrgpMZdRrHbeMwXvU7Dc3?=
 =?us-ascii?Q?Mbaqkfh/XR6UQ07gcl6hvnaaxwTwxwtJrY1E1Iw/gCdftQtuxhrbgOOZRb/E?=
 =?us-ascii?Q?78H1rf8gYGemld7Evx7KCdV6WvFQE2Ku6hT/yuKCNaB6ErUZfAMJmGIQu5Gu?=
 =?us-ascii?Q?JN1TipeaYZ48ZsuscQ/KozniWKq07oeCbBWW6ffwteZVkqstxJyaSU2Whq20?=
 =?us-ascii?Q?IV8oSuBo+y81YEaSblNxY1BCmHOfKdFBasKnGpHBymRLStRNg5FUzx3fc/o0?=
 =?us-ascii?Q?5YW6fV6ARQSPAaqBildn2S6tsWCjfMJ4KbIbqH8Pu2LdgseESmOQxTDhhPOA?=
 =?us-ascii?Q?Mk37Jg5JmmnyTWhpMM5hcRdvp+EY9dv7tcliHgP+/PMjvUPVl+t4tkgdUhre?=
 =?us-ascii?Q?0Cv7haOyiv0QnvaeAkmjPMwcoSOtpxwk3WKLSG+0aesVZXD6T2LdFIjeh78I?=
 =?us-ascii?Q?MKxilOjgbpOc10gmRQ9+Fe540Tkr/A8uVqIhvOKVglUV82NvK32kFOFbufW5?=
 =?us-ascii?Q?gj9u9c3sJbdXDtPAy0YS4mjFpY43Ebpe0LkQTcpJTUrxiSZpqM620TCQvjK/?=
 =?us-ascii?Q?HPgO4dfSvNO8DUB8t7adis/W0Sp4iR4yRX1wLph/fWPiCM4qm+QqTKSklbYL?=
 =?us-ascii?Q?sqnIF1r//Xcf164jZrwler0tql8xa3aMXpxw1VraorjVVSZPereJy+9WZD+a?=
 =?us-ascii?Q?dMOd3lQvJ26WozBaUhlqcCjpGiLV1HFr/K90nua1L6BLfvPJOdBdRbnwYjly?=
 =?us-ascii?Q?/40akQo3iORCfNvuBFMq9sVOfEhxOOyeVzOOpkOAT/5HQl13HShlnYvNruqF?=
 =?us-ascii?Q?6zk85R/2MCBe6ka6NaPqZ1pcr61PjdW/WBPgvxTK0l8Tb3Zm/uvtPoxzrRcw?=
 =?us-ascii?Q?NAx+W0dTV9usnKCGB/c2/YfsRX8EUKjP1tsB095yTYyG2Y8iPxR/yDMZFj1W?=
 =?us-ascii?Q?niH3aNjhCkWLy5RiZZKzhXw26g5WhE9g+JPRhiii+EKB+ROCm3jBvdP569Hn?=
 =?us-ascii?Q?5Hezs09kKt1Zlv2J4PH3EuRLAo3oRf32yf/cb8lq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca209e7-ce8e-4772-44ef-08dbe064d525
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:13:08.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: np1krP0hFV0aQRrLpf6lcYfrjnK5zHgamQoUluG3IByL8X3K4UmtRmpZvSE4s0uXcT6NPAs/mikLpX+eUph6qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

Add a new helper mptcp_lib_init_ns in mptcp_lib.sh to init all namespaces
ns1, ns2, ns3 and ns4. Then every test script can invoke mptcp_lib_init_ns
and use all namespaces.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh      |  4 +---
 .../selftests/net/mptcp/mptcp_connect.sh       |  7 +------
 .../testing/selftests/net/mptcp/mptcp_join.sh  |  9 +--------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 18 ++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh       |  6 +-----
 .../testing/selftests/net/mptcp/pm_netlink.sh  |  4 +---
 .../selftests/net/mptcp/simult_flows.sh        |  6 +-----
 .../selftests/net/mptcp/userspace_pm.sh        |  5 +----
 8 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 697afb205374..e28dce8f6f94 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -3,9 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+mptcp_lib_init_ns
 ksft_skip=4
 TEST_COUNT=0
 timeout_poll=30
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 74a94efe85f5..91f0fb386bdd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -121,12 +121,7 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
-ns4="ns4-$rndh"
+mptcp_lib_init_ns
 
 TEST_COUNT=0
 TEST_GROUP=""
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 20e582d39653..e468be7becb4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -22,8 +22,6 @@ cinsent=""
 tmpfile=""
 cout=""
 capout=""
-ns1=""
-ns2=""
 ksft_skip=4
 iptables="iptables"
 ip6tables="ip6tables"
@@ -79,12 +77,7 @@ init_partial()
 {
 	capout=$(mktemp)
 
-	local sec rndh
-	sec=$(date +%s)
-	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-
-	ns1="ns1-$rndh"
-	ns2="ns2-$rndh"
+	mptcp_lib_init_ns
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1617e1bd6785..e200eaa2047c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -452,3 +452,21 @@ mptcp_lib_verify_listener_events() {
 
 	mptcp_lib_check_expected "type" "family" "saddr" "sport"
 }
+
+rndh=""
+ns1=""
+ns2=""
+ns3=""
+ns4=""
+
+mptcp_lib_init_ns() {
+	local sec
+
+	sec=$(date +%s)
+	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
+
+	ns1="ns1-$rndh"
+	ns2="ns2-$rndh"
+	ns3="ns3-$rndh"
+	ns4="ns4-$rndh"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index b965c12470b5..ac907bd302a6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -14,11 +14,7 @@ timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
 ip6tables="ip6tables"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
+mptcp_lib_init_ns
 
 add_mark_rules()
 {
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 853dbd2eef41..0b6e56be1207 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -24,9 +24,7 @@ while getopts "$optstring" option;do
 	esac
 done
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
+mptcp_lib_init_ns
 err=$(mktemp)
 
 cleanup()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 938844477fe4..92b08750a16a 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -3,11 +3,7 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-sec=$(date +%s)
-rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
-ns3="ns3-$rndh"
+mptcp_lib_init_ns
 capture=false
 ksft_skip=4
 timeout_poll=30
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index fba15905b890..263a3ac9a3ee 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -44,10 +44,7 @@ app6_port=50004
 client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
-sec=$(date +%s)
-rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
-ns1="ns1-$rndh"
-ns2="ns2-$rndh"
+mptcp_lib_init_ns
 ret=0
 TEST_NAME=""
 TEST_COUNT=0
-- 
2.35.3

