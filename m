Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBECB5467C
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="4h8SlnY6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhUMiPxZQWkKVJkoAzXe4whoeOTxJ1mu/LfIKvKnaX1bLqnuYVPDp5fIuYzH8obAyIGiiTb5VOPLKXTaD8Z9hpdUnWjKO8AemR1vVBeKhCxyvj0RtreOvGz2ZfHRpVPBpmf+FjznX7p4T+yoKwZiOVY1io7CjpijTdB8hIGz002ESr/cmK6MwGYKTZarVQuNj6qk5ueFWLTh4Rg1gYdbuwoCudbUk224hLH+MncpBQyV63EUEIA0oa3s/R3iaM1jYIKioygz4UXOFqfKFtFR05I7KsFs/bibhpNuq1VrocTTSXAVj2EjQ0c5AF/0b+JebkEW9JFhV1rPjz3s6Q2lHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcoHGtloDmXOYUr+nMHJF1Eks0Ah+zCbIHNO342A3Cg=;
 b=Le5mOwelycbz6omBuwUXqLw3S7eJokiTOt3gm9O6n5jVAEYoRej1xmzsqi+hINibRSZuE11sLFwxQkPkSYCiYHf8uBT2j+GcxaiFIhmDM3vNOITBAY9PW0bziF6EyU76A83KbeLErjQcvqCsNF1OxxBwuzLXECG6S97bBaTH1beIG7REVRx01KbAAhV/ootgw1n48nMx5zKy/kgsSCS7wPuU5RbN4V0jaFYJkEXI2JNekabFVA3nWm4vCTl8dUS/jn9ctcRDx/O09DHLBZqXIac5EIYsN7jKU37Q0oKGR6a9/EjSUpWahIoNh/r524oOiBV/p96yqYdqI/ho5k45EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcoHGtloDmXOYUr+nMHJF1Eks0Ah+zCbIHNO342A3Cg=;
 b=4h8SlnY6xyQ3HynPsG0ey2FDvicWmKL06psclWltDnOt1IesSeNaH8T0LgMxmOO29XNTFR24Oo+4QKlhJqir9AGg0rL+Yf1eOk4P939rck+cG3QyOq9NqfUCndU4uP3t4iXzrvT5kHUF7pDnigqULqMZKdR+2PtYO9PQi3/pi9jJIKKaZXjW4UWm6uf5t1TKy7C8LozAXiQUVKMxsav7DpmjXLjfQV1MNJ/rTk0pab/MPSICPuu3sHEUVR4aQBGkLkrUtMxGVAd7yYiR6L7VPnA0B+L26BchdXb+nIDx4nI9jjZrrLBDie8AhOtasuwbyIWITz8HhtrOLW1VOUgqcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:31:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:31:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 06/33] selftests: mptcp: export ret into mptcp_lib
Date: Wed, 22 Nov 2023 19:30:54 +0800
Message-Id: <c709a0184de5824f2ff4ee3e8522ac673c7bea86.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:405::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 4929f5d1-38c5-411c-3420-08dbeb4e9ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DQTQn3epE7zwv3mPGBBPo4k0wExJzvYtqE++D9gWcS8Vn3bWTRrEGLKrR8lHvLbW16uU3PVrX0CUSfceaUfD6W0ml7Ql26px6Ae2iYPb6UEovwgxw3+yFC2vnSJNMQ3qE8Ty3Yx3FfE04eYmmushy+JQM4Fy8TZDPtsJD5Km1Jv0gsv/MzEnZwb8N5CzOvD8+1pugzONIlvhnERVelChwxlUsd2P42+PgJLX6iXUXxJmBBY35zpbydT6DZIDIpcYFnd8OkdQmJaV1+vUyJyK+z9X9gBWbwOORbvBhuYa/CBRZgZ/kg5h7ns2tb+9CYg3a8SSHTLrjcMHyu/bM59kiCz/3gZlwv+4k8APNudyzZw7gPmRTPyJ8kKQtDVN/77yxgh6sMkUgIDxe49qUlKb6s5bvpgFxeSlcej3ksMwTEsDNsj3uu64p4yoBLeTGRZWhhT7aLO92HgiXJn08fy79TBczPbcBs1G+mS6T6qPv//MFydvKFkNNQU9aof66i3IwMxmHXCGNv76V2cyJJ4/wQiJzf6Pibau87JHpo8XpaQ6QaNZL73WLrPsqvQGXOVn3VoawLgtVqnnOxxBC5ra5bL6DDHgPwiOoRb8hAreRr8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(107886003)(26005)(6512007)(316002)(6486002)(478600001)(83380400001)(66556008)(6916009)(66946007)(66476007)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7w3687ZtGcgKZv3lc+pR3As5dXS5OxONRjgrMwxmeJuItXIa18mPPxiaMEKR?=
 =?us-ascii?Q?8d9KxcC+WkJm0rOrgeyrwguT2JA/QgX4JmajmNIp6Z3VkUdStX6n52ZCHa1q?=
 =?us-ascii?Q?TEZqirgombZo6o9FZB7yca0zGqWD9FsqHkb4yTfibt8zMx1Sz5YbTNh46fFm?=
 =?us-ascii?Q?1THGxboEEeJqbmVEZjQtxqAB6v863TwmUl/Ts7SnAl/4qfoNHK9bXTUsMaqP?=
 =?us-ascii?Q?RzbZ6maIndB1pljXITrxtFqy3aO4ICmr0LmROdDGWKTVdtggxEVeRQ6pBcIo?=
 =?us-ascii?Q?38/gg8WO5l5ZbYdsIZLEF+U2j9hcN1+qQL9tMATLIhJXnhnU2IsJkMzkKLLF?=
 =?us-ascii?Q?bRet348G8ModQs91WwLFeMIdLSv7tRmYQlcBD0wLYzTTtBpvLD37S9fultgM?=
 =?us-ascii?Q?IY5WsjwZdAipoijfq5Wa99axwos/6DCl5221o+32rN358RM/S6VQDvzMw/3X?=
 =?us-ascii?Q?8rrPmCX+sWHqUdXFvCphVorf6Jrdz6UBYoQHXi1yVQNlh5f7c2lwq0ZNbVaA?=
 =?us-ascii?Q?1xGmb+Y3+oHTU48eDQv1eehcmw8jLCf1DNvEfXozlxwaSx/V/ZcryJMY8fxy?=
 =?us-ascii?Q?v42lr3Qs8d6+zTrwUv1NBNMAoYQ1/po0i15+TyIzjN6Doe9BQ0pJzCg8AuFR?=
 =?us-ascii?Q?KZJjn297ixN7+BHtNd55rxkY+lawohcgpLFX1hK1WR5D3jgydqKTPixn7I0a?=
 =?us-ascii?Q?A+yzzviceq2F9swPzRy8Fox5JPkB8weL767pdhtc2Rse060J8eI5qmB3kVgb?=
 =?us-ascii?Q?Nav0ZBDilVZv5EuvLeNSWwJBkRQNppw27J6Rj4Si6NfKjdR/Z4cD5g8qurQo?=
 =?us-ascii?Q?S5NCe9JYfBSHA8kdgoL3A7XmJez2B2g6z06Vx33FsQnnEkrYoEYGNAcqqyep?=
 =?us-ascii?Q?aXpCcPyFON4qDTMrosPqgQpZguj3ys4l1m8eYediCV30y+pD98EabkGDXx07?=
 =?us-ascii?Q?v73h67i4XAG4sRJmLjoDarXPRzIa4kK7zvu1N+bgdXIxY0rYkglDwqWn+LhN?=
 =?us-ascii?Q?saKos8PwsHCfL+c7y4pPxV/3rI1j374NOYa0uCdKklwh1QrvMzSjqmSt8s2R?=
 =?us-ascii?Q?mySqp29i8GJZuAF4dEX0ex87smRqSK6MMezb1ve/72Ya57uOFe67wj4tOolP?=
 =?us-ascii?Q?3KJc4yVszVFdTTHqXA2tDOBsp3RErMgkYhHDeLIjqph1BCwNPX6DhEjetx8f?=
 =?us-ascii?Q?QfwI1LmOK+nFGdGWNIdY5xUrWCdB6DVJulw3jtk86HOv7LwXe0GqLvCj3I9h?=
 =?us-ascii?Q?gKPunl3Q8jhVBbTEcEsK7w218dnVtObqsfxjlP7wUbh0KQg4gYB/Ene9J4mZ?=
 =?us-ascii?Q?6eJiN2ZHLgsjBJTUf/qRYZMGpDOBDh8k/C4CLnN/9iWCiGnI++AEJ2QFZaFe?=
 =?us-ascii?Q?CnB2MqiB96hRBgifh8OERVtOMdcoGtzx7GfWyTO1G8RML0DOAKhwswRagUB9?=
 =?us-ascii?Q?qvr38EJrKYPuBy2IFeYwUfR3fFRDTaKmEhlnzQjgYUOcIAxLo4Ge+RZYMTF0?=
 =?us-ascii?Q?iNEy/S48Sx+fl8rYIYXUikJynnShHxIk/6XlVeApZ/Bw/oLyfA1gJkNnKyy9?=
 =?us-ascii?Q?I1oqePeuV+O68450kv6Aaoz6ZcT/vCXk6Y07ItBN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4929f5d1-38c5-411c-3420-08dbeb4e9ec2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:31:51.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SASxF5rMvriQAiJQ28nu86nIR46rDvIvYHqLkmov2WRekMqmWLkKiUbZ9y9SIrecr1xkrf1+JJVNAprEy/e4lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

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
index faaadb2f335c..a6b32104003b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,7 +12,6 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
-ret=0
 sin=""
 sinfail=""
 sout=""
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index bb22dc17b0f0..4ec23a697d00 100644
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
index c60143133277..108a7548a1ed 100755
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

