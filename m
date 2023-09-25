Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7C9125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ+IuJySxm1Q7SD2+6V1DAK5cVzlNLFQYX1XW3Uq0INRFUL1oS148JpKiEWZ9FVatYqnUlKhpFcThjaixdt3bK3W/0wGY6ovJXUh3TWtE1Rl93Oky4GijS5yWFQr0DWPf8tV5/B3sKbO849USsub90clZ2h5pUt0Vh29yoCqeYwmx4dKMB5KBgEh9RW4sliWWv5aFjYrXEs/Bi86sOvrOA236UqLKox6txCnCH7Gkkoci+HL8F1xB/Fbc26lexjcbrxgZkc/6HEnYMjoIzi+cjmtLb6i8jXHkA0CWCDw+E+wuZe7FjFOJbruA9Qgqmy7MX9ZnAHtB04O5aEXDPn3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfiUlnaOL6tni4TgrPOu8dYkMi9w0/0Qpz4rQ/NlGbY=;
 b=ZapMVwqvh9ppHbUG9m1ZSN5LQ9u0WymOUysrDEfVRapMomAq4ia4RhTY5BeZMIhNQOUlhpDy7Curvtdsyck2gXxdYsN27j/S7iibpQzALB1NsF4z3jyPrBKJ64P3vo4MFrNhmy0fhRZI6S0BKuduJndT79nvaRd13YV6mT16G8mkShxGgjcAwpQ/cF87ASxjUEAiglzcF03OcEbvshBP9hqLQ8fP0mTxWKccvo4j1C633nFJlkA2NxEaZnwyuvMCRb4okDdB21bqR794oYdd01kCDDLcXrZ/NSKuFuT27S7U1Am9NOYuekcLxM0f5dl6KUuWnubIx70orMCdXAg9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfiUlnaOL6tni4TgrPOu8dYkMi9w0/0Qpz4rQ/NlGbY=;
 b=N5HxsgPjug1tSUW0djlbAWEOyyljyXzWA5eOBr754JEZyPpCQAk07v1JbLehMdbDQjPNoOUmMuV23hIjSMw9GiAQrZppkJYDMUhaJEKjIU21pUsi8WyZc4wkJqzP9KCTVR8ZIHG1NZnSoGQ3q/8/UqAezYl6vSLgYPZtOTM/atVlZOIt/xA0S9dyeHSznGFpV+3T93w8d14IgP//Cg2UsBvMVuoSs+8XOErZhR5cK+8kIkVMPpZ2w57BLjWhZUQ+NbzLx8G+X/EO/K/ReS1kOzYpg0njZUsoXBQ3OwsUnyfsr1raGyWENtZaDD65osOEWuN0BZRIlUEo9Q1xpbBfSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9825.eurprd04.prod.outlook.com (2603:10a6:20b:672::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:44:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:44:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 27/29] selftests: mptcp: add mptcp_lib_make_file
Date: Mon, 25 Sep 2023 16:42:06 +0800
Message-Id: <5b20fc53613f849a9e9ef3ebb132e7494476762e.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f875e11-e804-43b7-0636-08dbbda3af48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N0lpEYKcjz+WnnyHV4tE9HdQyZ6dlfnrqyu5WvB/Ab12c3+1XLXdF3GEsVC0Bzwo5nfc2BHS5xWnKG+JfBfTXFpbcsky8bkJc4nWsuN61DpRODOoyBT28pWIx2TPmaS59zVzTOZnPVe/2Trla8ATbzLWiaGK7Zf8fglqFVFg5fsMMh3ScHFyfg6D9ryOrIaHsFfbcvYYzG+UnPZ8uS/T85c8nhwrbqDm9qautkYfoRsfWkhzKQQPfN5wt3u8C4Yiixcnb5BeoYKBiMVRAzMxShkCfoZPU+pt9jxesCuXPnbUQ6FlGLWeAURoNmlCo5L/r6f0FzEoGx73qXhMdkJgz451fkCvj4wfzJ/3CdA+t2mbzIXiLiPOnCc9agke1QR/D7MqrLIx8frQrfeAyMa/71GnEXCPsHjOW12EL1CV4rpuY1SXMifdkxHwVbsoKlvtMBDSIfccQCIL52ebgYR6G6EvQQPB4buHisQVYCpuGIqYd55KnTDCychB/jKrkOAUwzTfL5fE+NwrO9lTNvyuXMfVkVO4UpD/Mwnc3w0b9acfQu9vQrus2a3aaZLDPfAi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(6512007)(6506007)(6666004)(2616005)(26005)(86362001)(66556008)(66476007)(66946007)(478600001)(6486002)(38100700002)(107886003)(83380400001)(2906002)(6916009)(8676002)(36756003)(8936002)(4326008)(44832011)(5660300002)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c/Zp2POinY+2iSB4lAz+Fov39aZ8zP73rKgX1VomwIayzIiIgesHnFZmW3pV?=
 =?us-ascii?Q?G/ajafA69kc7NO5QVAqSdEk80yI1UKzR0T74SKmnCy6CWAnwO6xfQUnVwJkP?=
 =?us-ascii?Q?IKD8536Mh/w3bzKEkm3GvYKbuUQZg+cpJDw/OlHcs8eCi12M0E3x5XtbvvOt?=
 =?us-ascii?Q?BpZPDYs0dvgOLl+/PlR5YVgo5nBhNid7YJ67ZfXFqiRhNwIxp+BaC06KwVwC?=
 =?us-ascii?Q?LlQMpgqVTrz9XnnU6DrMVB+gnY6G+3egkvPSzH2VqkjXp8pyXw5Hls1wh33T?=
 =?us-ascii?Q?BDCCi0rc5O67mgs6s8kUImZwkF8xKNrMeahEs6tOcKx0klYkkazoeOkNLDOB?=
 =?us-ascii?Q?3zdW7cSQf9SJADWvXitmAXs9F4FDUkshNcm6B1y0q9siiiAGupLnAjw9cUjP?=
 =?us-ascii?Q?GEr7M1J8z5rPdf68JS7YMGEHbbUmlHJpCTbvhB8weIeOT3Z1SHsTS6ZZnrJC?=
 =?us-ascii?Q?mIaqSuH6mFy/Hd910H1dLwNy0SvuJjRMW3XsC0I+APWqx4sSDv3oWRPK8qDk?=
 =?us-ascii?Q?SfoYfKRNcqKY6+mEo4UmrCktiSV8w78z5Omuh5j3mRFLUGgsEgY67Z2IBRSD?=
 =?us-ascii?Q?Cz/ydPpfi/tj5LoDz5PGCbf8ENUvclhVKesUQ57RiiEGPUSUUS+jX/2DRM4D?=
 =?us-ascii?Q?XKlBqFDWCMoE3c859PK+EwdEXpjIkaeNDwKOwC2e8bh4MgacY1bpUuG1uCda?=
 =?us-ascii?Q?ZmrbndkKHHHF+lk+B0oAoo/omRyzT0h3NHi6yzJh+8bROd+h37WQzIH4wb1f?=
 =?us-ascii?Q?Jie+Q9ZgalVWHoN02K+/ojY8LrilqnAnsYHEFKgfNJUrZNiB8tRl+Ey/OZdA?=
 =?us-ascii?Q?8bciaKku6/gETS35ZfJNG+XpQxemEsCubAdvFMM47IEsHsHiNTegoEj2a+rS?=
 =?us-ascii?Q?a6SL3TPLVymB12yRAt2feid522PWl9kvOttHPtWDh3A5AbVBOHDTEwcnPV3I?=
 =?us-ascii?Q?FbPjc8RZ7iG2bFIa3J/vobzPHjW8JDrllq5ieH98usXdG3YOCPWaBj/gKwk7?=
 =?us-ascii?Q?1zytyAhv80iUl9kM0Oqp1WX0WxXZcw48RvaWyV52gpKny0TSLzWNWPtfrM+g?=
 =?us-ascii?Q?qpNUuk6ghgUz3m0wHGjDTrUVxcPUtm9dPZeesssrWlUXW1lbjc+AX54TpdNX?=
 =?us-ascii?Q?bhbYebwRcZGHfUnCfI1q3iUcv1ORRTRN9RvD0PRWHiVg0KCFnqLC4tZUZoU3?=
 =?us-ascii?Q?RAiNaWfvlY7F+usZPTMZEby2GEwJ/L8UCCeQLYjhSktIOlw0pVQ6oKpElOQM?=
 =?us-ascii?Q?EsMQsS1oicEus6WFnTm/GnJ7H267nNeJjwLudKH2/Ep83O70YDh+k6dkRCmH?=
 =?us-ascii?Q?MGb7ooGocig3V9x2cWftgDBQ0bLBSMT2DITbkjWClPyEG2Xt9QIpuFZxw+TW?=
 =?us-ascii?Q?t6HZALOOvVaz9iCV+zR2VttkH+baPC20raWX6q3CqcxlfHt8sMgXNXYNYcqS?=
 =?us-ascii?Q?mtIOCdp+ViPbLSzNql77mpMYo0KhqiiELg3Brow4+Z9IGfv7V4ViDe3aU1JA?=
 =?us-ascii?Q?It5C8jq//XHyXAjd/N86N1oKFwbZWhH2kib0bg6+4iIUNHOprmlW2gYXXoLG?=
 =?us-ascii?Q?dZqAJ2OvyGqev6wRYe49GcyIDOHf/kH+4xXf9Bk1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f875e11-e804-43b7-0636-08dbbda3af48
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:44:52.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voRs5YxfT0fq0irWDcB4MR2htiuZxuYrC7gEM8voyR41UrMQn5P/3zb1xbc3+dyea6TkKaF8BR8cw2Ld2AZ/2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9825

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

