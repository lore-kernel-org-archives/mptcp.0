Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BCC18C1E
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="yYogN60c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC/fkeLDSSTGxJ4XWKtIdill8DG8TdR1uGW7dPCNDwJ2iBbhhQQkMsKZrkyTzsL8cFXKKibOzTqvpytT7CzY1BRpHIEYEG65qmggnVilxMflMHJcwr+aGC4zi0Bocwap7S/MEW1xcIT9sjCgrR8JT8n6Wn8MW6Zkx2a13tXOpDNA8zeyL+0k7U50gSY+lGYtKXKk2eihG2htmnV1DiUzeX27RfhqoKqHZOVz26BW+nsy6nVGfPwLVKlYS6AYv1gMLufrGW0KBZ2zzkEplyy06JU4snSx/Xc0NRUBgq1MK9SEjXDBNmYgwE+Ksy3iG6MvRbkq9di4NlOn0W36cyUFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK+LF24Y+TDfdsorWfCD+iDGr2VXor0DTl9wAL6tO+w=;
 b=jJV9jo2r1oXXenDNSsAmM3n4ClNW8u/1Ohei4opMFEmKwC5x+pidHIuTUn9C4bPSqa3QQ7LgQBqkLv6sD6xff9i9NhrFIVqBhWfVRm+ut006qM3ki818xlut8DlDz0dv3rjcRFS5GojlMamqw/VjGXqn5KNW6d44l43xoq1tvCwRHg1PTwFwHInki43ZZnJgG+/5MtrX0vRgeYExJX6TWDb62K0PLCzVsGx9ZULDEXoCup87SPTHyG/qEyuW+IQUbzjxL6OywMHlGuEy8bn+LVPY2lBTX54JQKefSfLH7XL6UnsPhSuMQagSd+L49Fqan3s5GqA1l9MsSKGkpL/FFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK+LF24Y+TDfdsorWfCD+iDGr2VXor0DTl9wAL6tO+w=;
 b=yYogN60cjpBTVMnk/g+KVd94ilrR9jpy4cD4aLwDa/HNo7mdR3cWq36ZTeJyBzr2yJrPl67GOP0xYQbVv0aaBfqA9f0M+DHTrTzJLN5K73BoAq/64vlEg+Ff4am2Esp21PZo13UW9Re4y8AqksWHE/mYhJp8yPF2iKKIN3Ip83JwSOJCUkdTnmNSoW+3QQ2wGVuW88R/etOq0ggjuoza3kWz5UMPL6vLUU+ez+Umw6Ko17PmTTq6uKhcIeblZdwgIzmZGP+AtqvzjFHrVqW9Zy7Pv4XYfFI/G46LqupJrBtT/l5h/efc5RKQKRG4OHKnzfx9NZSTf6ukd2wTWuHmHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:25:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:25:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 31/33] selftests: mptcp: export timeout_test to mptcp_lib
Date: Tue, 14 Nov 2023 18:22:01 +0800
Message-Id: <126683b5838f53014dff4883d3e3e94f9c895a99.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0048.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2dbe35-d34f-437c-253c-08dbe4fbffa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dtqdFlB6B8q/+dVe+y1I97qdlbXBw09yUHr+vRnYJKmZV0swManjldRSnaFhSotyZPk+fgIXSW8F4OS7+aZKZO09rtzEj75DdFhdn6uTl5/11ysYheY6MgigHXVHzgqI3LOZGU7EBrBhWs6i4C2PCMMh2Lk2sAXugp3qmmYPR6XppiUZaX5NM27aAdGFcgBD305NTrJypTAYYVSqQSZrPya9+UmMe2hdKrVkl6EroEQiEipUtjaD8CEyvxLJkHUbWWlMVg9WseSA3GsnGkJvZO5ZeuohnLI4GPNATKBpmf1GEOj2YTDEFyGYFpbDjHioyzaqkBzqlE3OjBiSKRzV0haORSs/BbOQVyENEnHoA+N/ynOSJzJvkPvDYJbBgXy+47CoXEzfXis8+GJdDk70eDydnoMKrPAolPBNKtPQu8MjB0mbdkE5T+zxuAX6+Bg7F2+DpW95bsLkQMiL//9sG4EPmbG+a9pTFZvfW7pUM4lif9kkaubQ0wTBeSz9eRBNMZ5Og1KG3if4LI4ABPoBMKFCtACpKK28IsSQ9kc0bk4740dU1gjqszBic2aap6X0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(316002)(6916009)(66476007)(66556008)(66946007)(478600001)(6486002)(38100700002)(44832011)(6512007)(2616005)(5660300002)(6666004)(6506007)(4326008)(8676002)(8936002)(26005)(107886003)(2906002)(83380400001)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gIFY2Y+yDkmVZbPDF4SpE7vrY0mTLHHmf1APKMbqSJKdc+wrylskKnAKsuaj?=
 =?us-ascii?Q?DHYVrJMb9txyOfm0fo2P++kddiwHU6RSs9f7Rcwz23uf4hsjTpkbmCQsw08h?=
 =?us-ascii?Q?/Rb54hQfLRHRftcEVUWIwohMgsp8NpAKscagUc5P+nr89p+1gk9CJaiIbJ4T?=
 =?us-ascii?Q?ugI3H26dBfR7kL0SuYOqjjldmJbYaQHNGuK5h9wRj9yT2XhL6cQRKq6fOh1A?=
 =?us-ascii?Q?ym5wzNfnH2RrqlwcTK6aoibhh8x6XYCHe/K6jtoEqV1AAVKAjrbdDbLOtkIN?=
 =?us-ascii?Q?Bckr/A6n+p57K4sSgJW44pWq6yCHeaXJpuGeZLo+u6s+z5N4ygD1ZNoT8rmH?=
 =?us-ascii?Q?+0BFzTG6PlliOYeHwraMl3T3xvw8pF/gx+cWH5Ei4WzphWTtODkN2X3GmRtj?=
 =?us-ascii?Q?5Y+MYZaoZwCArT2P17o9Kb3xDbTd7jFPTgkqMT0BdyIpGbpT3xUqZzcTT/8V?=
 =?us-ascii?Q?r4e6l25AJyiofeSMnJUIk6lJd622NReHAn+n2bzZPloWUaYwzWyg2EoHOaKl?=
 =?us-ascii?Q?xFHJw9xgiFrrhUBc+rOMNaoJsAAOM5TMX65HoKPi+3eNro8kvx+G8qCiHvqB?=
 =?us-ascii?Q?/UxL+8ot0OMbbFXP1xjKs+ZkRAEjdRtAV+OTCjV4x6NuWHKfUeWF4IRzTykz?=
 =?us-ascii?Q?TZatSnVsQc0y5UN8gFeaEBIjLPB/HS3HyYyvHzn+IpDZKWF4WHoM/Jg/93qJ?=
 =?us-ascii?Q?TVcbJWnDVPT2fQVstyBGSmu2BvQLlXcDYSPLOibmVo0gKblZjfli1XKZhT+e?=
 =?us-ascii?Q?wse2/t3T5j48qdJxbGYIjOQ4/2Z0tr1TSDHuveKpTs6FaC3uguVidWAWHwnc?=
 =?us-ascii?Q?n4RKbcVJBQ6l0YppRFMq1DxjkRo5FqPc8tBkHpPwjmaYt9jTmq/JnFDHPh7f?=
 =?us-ascii?Q?HBpnTy6KtCbIFOIulpnXfEjWgPWAaxIJyeb7yXpUy6X8HjxodbBDPqEECbaz?=
 =?us-ascii?Q?k4IwZOJlhsXy9abAyUubXL4G0+bYosShZqC5IM8wk7xVB2SSeof6FQIOrQln?=
 =?us-ascii?Q?7ap3XwVUFBiwe0IMr1QnJlcGs63otQVY0fBMMLB28bzYOFfBsI9zXTI32hKS?=
 =?us-ascii?Q?6Kikrp6MjJtqgUn/PhBx4WvM07ZhKkIoFROrVksYtLhCE0Xt8Bj2qdGm8ZiQ?=
 =?us-ascii?Q?4haemi7R7FsfHN32Ui9XMc4KNljmgGjDRG8zTRVYjSIob7CTSGd1HVdLoI6K?=
 =?us-ascii?Q?qsNjDECzwyKtVtEUjr8+DQdY60npdr/O+WEuYTrxNqt614WgWQjWaH+iK29n?=
 =?us-ascii?Q?uFxJ2uAg0CQ7bZC5ANHFETQWnzEsbuLzzhqEjAN961gzQZbSsxcA1wg6TX1v?=
 =?us-ascii?Q?colXPTSxfJylENb1DV+I9mmsgH6cgo9g9g8AQzcWKYHWM9cri8hhn0+weaYf?=
 =?us-ascii?Q?kuTjgQi/kp1bllQIqxJU7JVPrmNZnwg/z1riNpzDYHkra1AMPSOv8/B3B8gG?=
 =?us-ascii?Q?1h41JIqY7mVuS683tGQEx1eNvi6hRnag/FyOny2g3M+rFgui8kH9D19mcLiP?=
 =?us-ascii?Q?M2f/lPFRXlPKVh60ZBTyozlhG+PXBwRpntaxLzzswy/28FFeJL68+3UPruUI?=
 =?us-ascii?Q?hggA4tmUnHHHRoXkFlRUMyZF9aMyTpUt8K3jKJ3Q?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2dbe35-d34f-437c-253c-08dbe4fbffa4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:25:18.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukhA0yDJYgZv5Dr0qmCAfFuwS2rQJhylNiz4fO1UvuO+tkp/W+TdH3M8JjYp6rtbvZnjEcyBRwvXA8epQVervQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

Move the variables 'timeout_poll' and 'timeout_test' into mptcp_lib.sh
as public variables.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 2 --
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 --
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 --
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 3 +++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 --
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 --
 6 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index b5a17d2b6723..f646fede9872 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,8 +5,6 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
 
 flush_pids()
 {
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 59482d5476c2..683172e626b8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -9,8 +9,6 @@ optstring="S:R:d:e:l:r:h4cm:f:tC"
 final_ret=0
 cin_disconnect=""
 ksft_skip=4
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
 ipv6=true
 ethtool_random_on=true
 tc_delay="$((RANDOM%50))"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d36639e48027..3b92a0b78605 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -20,8 +20,6 @@ capout=""
 ksft_skip=4
 iptables="iptables"
 ip6tables="ip6tables"
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
 ip_mptcp=0
 check_invert=0
 validate_checksum=false
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index b5f3d5e0f118..5c32fa8e91f1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -26,6 +26,9 @@ TEST_COUNT=0
 capture=false
 checksum=false
 
+readonly timeout_poll=30
+timeout_test=$((timeout_poll * 2 + 1))
+
 MPTCP_LIB_SUBTESTS=()
 
 sin=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 8640dea7abca..2d5b6ade7df0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -4,8 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ksft_skip=4
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
 iptables="iptables"
 ip6tables="ip6tables"
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 67643ffc5c08..a598deaf890b 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -5,8 +5,6 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-timeout_poll=30
-timeout_test=$((timeout_poll * 2 + 1))
 bail=0
 slack=50
 large=""
-- 
2.35.3

