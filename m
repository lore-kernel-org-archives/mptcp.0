Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2082.outbound.protection.outlook.com [40.107.7.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9172131A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezhO08B0crhN8yklL7cuguwCuwgDoWHFtk0YY1XOsrG9FyENYgVXECliIdOoRbPg6I+YakleffxUmQkwsxurDHml3nx/olqL3aBqNCL/YTHn49vMT1aLlhwJ8tZvP44lIBMf9MyclOMn8q8RiH0DOQEaQ9S1s8xdvuLRkXvX9OzhyYGY/ENHiFb/L2UI/WupNqr8RxPGV7AhXSwnNF827efEwczwFUFMjYyQ5oyaLmNoXn7OT0KNEnOytBT6WKaTtYFw+rG6+S0EfsQNi5QGAWu94CzPA36U5/aBCfxss4fOsjFBxappIwoq5bNfGMr/0X2wA4Cl/IhGzeFmpyQO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfiUlnaOL6tni4TgrPOu8dYkMi9w0/0Qpz4rQ/NlGbY=;
 b=njPmlLo7+kbL0GR8C1/8MJro+zoDyziEBDytqDYtnhQrTd+H+9JURqznlxISpM+9CcNQb5pS/2M2KZCGPL6GcUuY2ukjld/W7bhPWnO8H0RnhuxYTLEQWc16m9b28lNdus/jrvsDSbFxCYGVpck1zO5azZm7b0pgoqDTJSOujOFQdEO2NniLHVDXqI5wKocVpmSxrJ0VnvvW0SrqycreOhghDcOXxnD8s7ELtuABerqDOmJ/+XL44tLeWOwVAEsM5BZw/pWRAUhKeE6ZxnFMRLS4kdWi1BEneoc1QlOzNgHD13ahcUvGmAQ9VX7UKZ6XQ2dmiX034guF8dAttq4Zug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfiUlnaOL6tni4TgrPOu8dYkMi9w0/0Qpz4rQ/NlGbY=;
 b=AFtEIUgVXo/OGrBefvd/lH9LaJMYnmH9Yug5Fed690Zhkw7ScvxI7DEcj19mRYuIW005AL/WsAoTd659+v10vvWD4YpvXpfr/M3aIVCzAJvWLADJhzh4sI9t5HmM4bmU+0S40njvJjqIru4N+b5U4qfrEBiimTH0tWWYeeHr7nqW6z+zgZQsjv627MDn6iwWQP4xmtYPp9HxHdjOSSaJfhumIsy2cwhqcnBcEQCgCRmSKMg59iau/k4eUbq85hSTnxZKAfn5V5PfA2aCKqb8EpathFSv6BVWOS4P+pfs1LhTk1l0sxcLnzXrYbB6iEjGhwa1KZZtw0NPSvrOVzHrlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8136.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:06:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:06:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 28/30] selftests: mptcp: add mptcp_lib_make_file
Date: Tue, 19 Sep 2023 12:02:29 +0800
Message-Id: <8699cc3a83222a30a1c1173ca555ca58b277ad12.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: e97fc610-629b-4033-0add-08dbb8c5c04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jj80dok5qFZnBPRK4xKdeB4JqSMP4ZYa+XAfm5IQsWYx9Ec29XN5GUmoYllhk522+SQUBAuQH4LfaH0LoT2snFkYBCFIdJok066fzdaXpTX1fMt+ffaMyeAe1kcd+gWseaEOsa0vgSlUmA3IKWTkUhbymM73QhtB2ay3wfpsSsAVWTL+o2qrKLBII7UsHbr1T4SWkM8r/S0YHtUFV5VZJ/LSN480Ft8Hq3kNYGlBZZFo4fSsEdBjqcWrtA2LlLGu3gB0TOWoupF+HCWKiZ4D3UKxSqeCs9+CFmLQC5Klz7TySNGhtaK63Yk5uzqJRLOdtdthH/90OAZ8+UHI2eZ2e6xzI56WqQwt/Di/+byGk2ymp8J9ggmqe/YyPKLdkuaT21tCE63Gdan+ARd+84wptU0qwJYxAZhEzJzvc47YM9y8ruOpxnszoyHK8bTaPtxW6XDnOL16TJ8YsKcGeOrPsHfRW1kiSvNsVlpHATnwkvMDWOVOevZY+qFk82gYBCf/rj0o71q//dC/PuFJBputla2jj4KCxgLXjiQb+wLWhlao9JYIuApP0BUM6HHz+pYMTgZWWPVhwj0P1tRdZjM/gDD+lofFoPGWkIIuEKzC+Jw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(186009)(451199024)(1800799009)(6512007)(6506007)(6666004)(26005)(83380400001)(478600001)(6486002)(107886003)(2616005)(2906002)(4326008)(66476007)(66946007)(8676002)(66556008)(5660300002)(44832011)(8936002)(6916009)(41300700001)(316002)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nca8WhzXEFHscBXzRFwptacAepQ2d4TIolFk3JqIibc1ktnp6WMvdlJtyDmY?=
 =?us-ascii?Q?KhBn6yB+y+J1y/Lczl8pr5pWf0tcmBiYnw+6ks7NQ7GkRI7A8KGND0rP9qMM?=
 =?us-ascii?Q?WMoxPVEFjnHIWr8h4uV3YUQSqNeFvsrXv7E8FexvILAse/s8qaBhyPGUOuTY?=
 =?us-ascii?Q?on/EkhlCluCQf5aZBHgz6vDPCF+dYEVoVTkHyUTcneFL+KR5OLtCsqcoNbWW?=
 =?us-ascii?Q?0SFKsm1kNdq0YA8ccTE6AUQzPqvwx+oi0tXVeg8T1ACyYCZUZfCqfDr2RRwk?=
 =?us-ascii?Q?ENG+7b+e3KK1uR5Y8LfLAgwmPalubeNmDXgb0BdDu796wTkYOARBnfkll9os?=
 =?us-ascii?Q?s1Lf8vdpTrQTxtTTq1d88Sf7leNOhxqHltyGEbX5OaMBsGbtuTTEpD5r0iEz?=
 =?us-ascii?Q?ybyRGOHck8Jwt+UKrkPlpL01gADC1x1EvPbNWtr9Ac9GmOYDy6gqyWQrHDgo?=
 =?us-ascii?Q?PBo0JWvvn9+5FeaQSlL7tQSivpntNghljhVN5f+ockaTBT/N6dxNR52F5z8V?=
 =?us-ascii?Q?4h3AMitq68losjWKpd81Fg51B52+vUZTt81Odz0rakSfZ5akHLM0MxObcPPB?=
 =?us-ascii?Q?HCU8rGoRgtSTSak1UVC1Zy7BIXDSS5SuuCE2lnwqhDmFivcVcG/CwxweN0aK?=
 =?us-ascii?Q?n0GuYDk1iuZuGSDByTFf4SQMaIJqJ+Y53n1sgLGhZW3Li/a5ggcAIddVSJvu?=
 =?us-ascii?Q?xCWq/XNb6LPXUNxEvHKZRcZd5Q8DsAWXsyrfQnGJPCPgUjWCp0wK1vAmBZDo?=
 =?us-ascii?Q?ULhXLd2SFofx9UcHdBzkz497Ldwu52AyIu6rLMu/MezgVF590vzQVT6tp4VB?=
 =?us-ascii?Q?hqhu6tvXbgfX6Pl93qypJAGagk9wFwfKbovE2Hx5CQNFUZ8ogzQVSh1zAHgi?=
 =?us-ascii?Q?+WgiDtcRWQbGcq3LFfD1fxgoXAmnmH9e+tfulTtXNtlK9yBD8VNiQ03b774C?=
 =?us-ascii?Q?/GWxKtzq6xFr/LdclOlBc0Bf5sZ93C9QCaXFzXRIsQ9/ocFSEJoL+PkdrsIP?=
 =?us-ascii?Q?QW+Z4nwUqxAorif9UZ2IQUy2A+GTR7FYoH8fZxlEd+gNjc4KxJXuQfOeJ0Gr?=
 =?us-ascii?Q?1j/sXLMzEw/zaqIzcqXei4Ye+tF2W2oeXuFsd7VkzaLmhQBXqCM2pqA+Q5hE?=
 =?us-ascii?Q?UB9Of9Wrp9tAHRSIRA8sZ84yukcB2tV3YrSDZjfP+KZmbrvaA8Sz3b/UUiRy?=
 =?us-ascii?Q?7BG2cxzLRIHg4DGtt5pK3/xwA2qbZZGN5LXc6BnJfWLwreni8A+0iMNeifVp?=
 =?us-ascii?Q?bEYYctlu6f4m6SdEbr1NYFLwvYTkb5XUjdZtzKE2Ef/hqBm0Wa6MbjtPs28X?=
 =?us-ascii?Q?MwotROkN/3SRItpKUteT9lFxVjS8gCcRRpnqBYN0uE8i9KlYUdEyqbY+PMTt?=
 =?us-ascii?Q?eLXfbfcVXn/j8oT2hju+Sq+Q6X/0PmpTZMj0W54lgCwpGeE5u0MdLSXAtIdc?=
 =?us-ascii?Q?wmBzjhQkgvHav9CH7RaSycJK1jifBTCUeA/+SMcpSByST+8is9Y2/Jkjefer?=
 =?us-ascii?Q?3BX3RgBRbRvpedPHoMz7qaXHaI3M+O3Bu0t39NnzbZC2oa1p4XFWPQozw5Ft?=
 =?us-ascii?Q?TD4lGSwGVrReN/tBllQxiIpUen1A8fb9rBrmYsKV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97fc610-629b-4033-0add-08dbb8c5c04e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:06:08.0588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNMzPuNpGliDKueNAThn+SQ9EbNqHwpototgBUNHxzBkItn3HX5n3GqGHRAJm014SLjUTjdNiD65B7iPsbQs2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8136

make_file() helper in mptcp_sockopt.sh and userspace_pm.sh are the same.
Export it into mptcp_lib.sh and rename it as mptcp_lib_kill_wait(). Use
it in both mptcp_connect.sh and mptcp_join.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh       |  3 +--
 .../testing/selftests/net/mptcp/mptcp_join.sh  |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh |  9 +++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh       | 18 ++++--------------
 .../selftests/net/mptcp/userspace_pm.sh        | 12 +-----------
 5 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 3b971d1617d8..dc4a1dd3566d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -592,9 +592,8 @@ make_file()
 	ksize=$((SIZE / 1024))
 	rem=$((SIZE - (ksize * 1024)))
 
-	dd if=/dev/urandom of="$name" bs=1024 count=$ksize 2> /dev/null
+	mptcp_lib_make_file $name 1024 $ksize
 	dd if=/dev/urandom conv=notrunc of="$name" bs=1 count=$rem 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 
 	echo "Created $name (size $(du -b "$name")) containing data sent by $who"
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 26ea0919810f..f88168d66fdc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1155,8 +1155,7 @@ make_file()
 	local who=$2
 	local size=$3
 
-	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
+	mptcp_lib_make_file $name 1024 $size
 
 	print_info "Test file (size $size KB) for $who"
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 0f5e34c76bb4..7b0d03c40f89 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -344,3 +344,12 @@ mptcp_lib_get_counter() {
 
 	echo "${count}"
 }
+
+mptcp_lib_make_file() {
+	local name=$1
+	local bs=$2
+	local size=$3
+
+	dd if=/dev/urandom of="$name" bs=$bs count=$size 2> /dev/null
+	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index bfa744e350ef..39128fca99dd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -245,18 +245,6 @@ do_transfer()
 	return 1
 }
 
-make_file()
-{
-	local name=$1
-	local who=$2
-	local size=$3
-
-	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
-
-	echo "Created $name (size $size KB) containing data sent by $who"
-}
-
 do_mptcp_sockopt_tests()
 {
 	local lret=0
@@ -357,8 +345,10 @@ sout=$(mktemp)
 cin=$(mktemp)
 cout=$(mktemp)
 init
-make_file "$cin" "client" 1
-make_file "$sin" "server" 1
+mptcp_lib_make_file "$cin" 1024 1
+echo "Created $cin (size 1 KB) containing data sent by client"
+mptcp_lib_make_file "$sin" 1024 1
+echo "Created $sin (size 1 KB) containing data sent by server"
 trap cleanup EXIT
 
 run_tests $ns1 $ns2 10.0.1.1
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 98189b3f73dc..d5197d745171 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -150,22 +150,12 @@ print_title "Init"
 print_test "Created network namespaces ns1, ns2"
 test_pass
 
-make_file()
-{
-	# Store a chunk of data in a file to transmit over an MPTCP connection
-	local name=$1
-	local ksize=1
-
-	dd if=/dev/urandom of="$name" bs=2 count=$ksize 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
-}
-
 make_connection()
 {
 	if [ -z "$file" ]; then
 		file=$(mktemp)
 	fi
-	make_file "$file" "client"
+	mptcp_lib_make_file "$file" 2 1
 
 	local is_v6=$1
 	local app_port=$app4_port
-- 
2.35.3

