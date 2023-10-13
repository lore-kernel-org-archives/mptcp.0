Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A564D5692
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="mGsx3CXe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1vvfQ7mDkbSxI02rzrksZAGTJpzETeUif8Jyj+aRGIpqpIE5WsmPS6D/aOBlMo6iEiILsY5s8VQaWTkOiF+BiUNNrFuNsyTJgLxNzVPIyf4rA/lU+rhpV55FhtZLU379M3nvYJ0DHcdMjx5o7TYCt7j6n+6pUEZe46xlD0a+RqMY3chwbHIYZFItYjmKU0tSKEXni+yOvqo1rsiE6YkuiKWHvNk4BdpyemIWE2oPdR8NFG9huzOBjJZ5I+8au4hyjGa/Ko4iyOpD7tXvKlU3P5hXpsZQQKQQ1M2UrbApniIgXBjapT0tJ5AXW0cq9meRVMvG6PcUtObawWpnv1Arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YF2Io7e4wkf1aI9oNFbJOMGDZLmSNC4olmc7Nhu6OE=;
 b=ckDv/pc/GaPxAdTAzgpXjP1a5e1oFntzsWZiFSA5HJLowo1t+WbXodfravbMxmJBD7nDNf6hjLtRzxjgAeWPXpAcv6JG0FI7LPTfwOUi2tCnEEbZ5vTgHmz8nEIbBIZDjdYJkgL9nPARlsw/l9tQALFPCTKMAwhdfzR/JuLF37A94NeoRaFirx5rYRLQnqE5w1fmvpfKQ7LTWnDyF4YNVYlEhsQOZu3kj8Za9eiGyB0M08R8VnlL7PWl9dBvEHj7FV129Ac5hWcYYK818nvNHXcfJhQJsyKsPI2Kr4Lr6o/E7KSm9A/1aFzClicIZZ39IaxteWVwRt3gSh4pvOHw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YF2Io7e4wkf1aI9oNFbJOMGDZLmSNC4olmc7Nhu6OE=;
 b=mGsx3CXe1rzfT4Z5awC0XbSvDT0to7wQ8wVHaoMrQA9+EbKXVW8f7koK+Xk6RAgPZbtXu6ZvrNFuhuTILzSDE7zIopl84wrQI8+T2ApP4nHVb5pYgEaRPuEZHwXKVfqcFtwpKqd5zyHyJGTzkOGqmxCHO3OkzK1EitihT7ZCY6DAKQGrtMuZjNci2yxViaT/AzR1JUIg5pP6gP4/rklGVrhc073BYXzhYKeDlNsnBCIrdhPLCwKRybpXDcWRT906nc6iY+urlACUlY2TS6jBmo+a20qRgfZ+6DCJdUVeScnH2uDPYTF1npLt/YDK3HLvVsCVPH7jtOuIauwQruD8Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8566.eurprd04.prod.outlook.com (2603:10a6:10:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 07:43:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:43:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 5/7] selftests: mptcp: add mptcp_lib_make_file
Date: Fri, 13 Oct 2023 15:44:35 +0800
Message-Id: <985c9a3186e32bb08bd3d617c9a0c7653dda112c.1697182955.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697182955.git.geliang.tang@suse.com>
References: <cover.1697182955.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: a78e9a6a-2a06-489e-1152-08dbcbc026f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vdgh8z4GaKNCaGpQR5pwq3S9U/SAEKKi6olCECkUdn5nKNDShKJK5PmXjzTPmpTty534TiZiRxfCJosQuOml8BFPJtN1cQi2na0hFfydJkuJiHvhgShuepYnW739dWh7OSUZmZaq+Mg7L3ODrm+BOLCPZKwtofNV6kNaUjARroBNscaurn4fAUbMHXj60k65aggmsvngnUwXpII8QCavtyrMHfSJfDzkf4blwENYvmFdQd5MJzemZ1AzhVzyFZzgJ8oiArMdy+VwQ49Om+t+KKhKyra57Ns6iuuwOK4CtnNTFs1qGTigzWH5m8Oo1PCkk/U3+YaPunOvp32iLo3r4dpHZ+JCa7/yMPF7C/YqCVpL+QeRP7ZeWOVSMVpMktPuIe76Gq4kGpSWA2GT9vSauIW6WM2lgUowhTpqoBrFu9+L71BKanwBFvVb9l4ZmtfnOnUxYcbgOLmhTZfBqGcRJNapQvsVZg/mbKGrlY2lO/7HKKa2cGJd5uyLY4fTP0t+nN7LsUL2pWIwMULjrnGIY0ZoluY8RKZiR43wG0+SHkoVGfCVUjzdYRUe/dWsCECZyo1jOyeczssJVBZygwQO8lzc+78ekmWSHul72octrRE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(6486002)(6666004)(38100700002)(316002)(107886003)(66946007)(6916009)(41300700001)(2616005)(66476007)(66556008)(5660300002)(83380400001)(44832011)(8676002)(4326008)(8936002)(6506007)(6512007)(478600001)(2906002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LPPiWfcC/6iXjBJmoYte/xjebiXfC3RM1ClDst49jmdaCHFweWv0imRzlu/W?=
 =?us-ascii?Q?k9seM262EbUjcKr/buQI7hY5z4qGE5qDhhYawkBU1vOInmi99rpWjigaVby3?=
 =?us-ascii?Q?XAovQl7RX1vcn9HmR4fo1S7TOXxqfakhXy7S9Xcxlfr8Hdb1WQfaffNleDHK?=
 =?us-ascii?Q?Htf8JUFRTzFwM8UwJo5sM/ZTmi3u65PGtBHql0fHNYg9QI1S01sWDx03QVUp?=
 =?us-ascii?Q?kVCvL58hJO6fic1+qZcif+jVH02NUqlSf37hRmQPAwI6CxVk2vDZsZ6Umy2U?=
 =?us-ascii?Q?F0Y8XA1/IVErWOTJ8KcMzGVcgjxnrGnhHIzUFjQGpLG8XitZXtR6JutMh+7u?=
 =?us-ascii?Q?RiUl6a+mudABTalXHsrVTiwZGkSC1T+2TVJvffDGncR0koQWqwUTRmK+MpXr?=
 =?us-ascii?Q?OJej7WGKTFS/t7uVZCtzWlzR4LnMaI0RrUPA0J0u9+lS2CTzX/9zPT7WESVu?=
 =?us-ascii?Q?O4BriScWZRLn3IJfNJA5hmMLYClxiubP+YJ+WcwonSa5K/NkFaNlzfHWksmG?=
 =?us-ascii?Q?meeBBwJeZiiKwUS75zo2s6wR6Rw/8qmrDoqFq4+YVHc5Y7aNLh4LdHCDKsas?=
 =?us-ascii?Q?U0N84YV0V8Fc/Ee0xiUYsc9CCudct840PeidwkpFAQLLSV0elsLmpjGpjRV2?=
 =?us-ascii?Q?ujHOE5ZfZBzxor3NIlN1rynzwipMf+ZqDPm2I2w+vWqxPo9YdMTCjNIdZouk?=
 =?us-ascii?Q?BVLj5wBu6UeIMvmGkJ/1Fd9vbT8nJnOJukqKhTl3FrL8KQ5oDqZVd5lwaLbU?=
 =?us-ascii?Q?fkZwdqnVDCqXan6ziZc5S1gyHf4+KWgvWp0sLaUEET4mgm117HXLFh7jxwTe?=
 =?us-ascii?Q?cck9zUXEl9Hi8rK967beZt9SDgBApNjUG3gRiBAjNG5WjT4Ztsej83jPFCjm?=
 =?us-ascii?Q?MsYVBm341JgFJ7/JLcgDMEBd3IwSjivPythZhrZF1hqnrI5RuE8vumwdtaxh?=
 =?us-ascii?Q?TvsiKWhHaWZIvl1IomsTYIA0+MmMHgIcKf7f6y0TZi31bLNpKtbFl2TyT8cZ?=
 =?us-ascii?Q?eY15eyHG1Y3FIEIQWEvSIJQQ2emAPuM52zQbcciEPXPv/vt/ivRT1DjS0s5T?=
 =?us-ascii?Q?5kGmirb477dAtwlvVRLFQ93GD1AMkYu8o62FMDTcsXZyi72BW7rEmDNAJHEO?=
 =?us-ascii?Q?Z3zFwBwY26IoUTdmaLVFqelcaEyHTidG3BE1TDveGDPXDFR+yHgweAcJbBx/?=
 =?us-ascii?Q?4mzNsx13pZXUacV7qseYN/4kXRfXBZ1mToa9Ndbwprjs5WOwXxi3OqNX94A1?=
 =?us-ascii?Q?5FmcwhS415iV/8VthgvaBDAtLyR6EMsTPXPh2Zat6dCi90xqBDYjUMv2KRzh?=
 =?us-ascii?Q?23bgfG1GrTpfSf61cveEIVJkd7zu1a0oGU//J0891gdxdYLHY0oJX3OZkClG?=
 =?us-ascii?Q?YUwV0+X5TRq1HRIrr32zNvqxQr6pyI6ZFl0KYpi8nuCw9OKqbBpzNUu3cWG+?=
 =?us-ascii?Q?QUASad1/VIZQ3TsutOdQ9sltsMAnNRsgfWVEmIC6sn7y4iYIGgr6SzCZnQYH?=
 =?us-ascii?Q?OjwvhYUnVgBjtE+JbEZCHfiukrQLe/AadAhr4HuMQt4MxUzpLF9qVtURQTWH?=
 =?us-ascii?Q?u2VTWBgauEqsgc6caVXchiofUseNLRd97noDNlLcZ4bH5Pp85gT9uN/ju6zF?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78e9a6a-2a06-489e-1152-08dbcbc026f3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:43:55.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jfGMlDDuA9n6E72sSXRT6SPo+C4F21MmVWA0L+9ikN3Fn7nMPoex4r2bainhNdCgPdoTg83e41IdiFyV+bgig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8566

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

make_file() helper in mptcp_sockopt.sh and userspace_pm.sh are the same.
Export it into mptcp_lib.sh and rename it as mptcp_lib_kill_wait(). Use
it in both mptcp_connect.sh and mptcp_join.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  3 +--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  9 +++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  3 +--
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 12 +-----------
 5 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index f00942cc23c7..409520f5b2a1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -592,9 +592,8 @@ make_file()
 	ksize=$((SIZE / 1024))
 	rem=$((SIZE - (ksize * 1024)))
 
-	dd if=/dev/urandom of="$name" bs=1024 count=$ksize 2> /dev/null
+	mptcp_lib_make_file $name 1024 $ksize
 	dd if=/dev/urandom conv=notrunc of="$name" oflag=append bs=1 count=$rem 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 
 	echo "Created $name (size $(du -b "$name")) containing data sent by $who"
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7bfced890e50..9d8b8011cff4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1171,8 +1171,7 @@ make_file()
 	local who=$2
 	local size=$3
 
-	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
+	mptcp_lib_make_file $name 1024 $size
 
 	print_info "Test file (size $size KB) for $who"
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 0e30c7bf24c2..6318752497f4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -247,3 +247,12 @@ mptcp_lib_get_counter() {
 
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
index bfa744e350ef..755ae0f5ac4b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -251,8 +251,7 @@ make_file()
 	local who=$2
 	local size=$3
 
-	dd if=/dev/urandom of="$name" bs=1024 count=$size 2> /dev/null
-	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
+	mptcp_lib_make_file $name $bs $size
 
 	echo "Created $name (size $size KB) containing data sent by $who"
 }
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f4e352494f05..f9156f544ebf 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -164,22 +164,12 @@ print_title "Init"
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

