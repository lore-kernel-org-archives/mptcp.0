Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCB27E0
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 03:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ds8NeKj6T0RbLI6s4eipv7QmZpEqovn6ydbBZpRZ3xNR0ixpLLSU3AR1TNm8p0XQ60I/J1nkuUeOdMm4BDVPoRddocBEOY7SRzInmaXVype4bq67R1culmiFcwIe7VBSrD44AisQOKkPzp165uy8WZ34AqBXfbsi/hWujNN7A7zI/G5jYnuOzdUcT/JBTcppMCeXUutzwo7wIQPdeyu17YvNrwdjDil4iLfKS11SndLnn4qOuIcKBic5AZ2bo/vIuTqPf/ot58p/nkslCV41vIGptWOPT4wUDQGvrM6ETlA27TcQZbyIjg+QxmsVZmHgG20nHxF9H2YVCeET3lSibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J89AejOMDs2H60owpt+b8LBOTNw4a/BoytvVX+nRSWU=;
 b=ir7GekbSTDh/4wBZMNPHNa2pAv7IMHzZnMsOvMruEQAmV2mXoZbB9me5L9otpOoCsZpDrUe6JOcnC1lvbcu2sKavII9TkswaAmJhXiYmWshRWru3eGiVMxwqedpI1O7dUF4RNe6NDv4iPJlK4WTFCHqW78cFKF2Pz4fJIAJ7R9TbFDxftwdnzIvsaEukjJoiPV21Zp/1Mz/6SOkBuc2up7s5lZDQl9ejo7+xbVKQplMpkTuAr+C5eMfttAinzqSlv8hGWJ6738Skuz8LA8bb7/sOXn18dpUa8ckV1zmzNhmqoZ1VhJ7rDXGPbZ93LfZ0KWIwVNBm57Q5vhWOg+EKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J89AejOMDs2H60owpt+b8LBOTNw4a/BoytvVX+nRSWU=;
 b=0QUL4Q55fVLJRXZPiAJqc7lymNYPC3HAAlq/dVC92FZdVKQLYi3vRuO4IF2vxfuoqYOE34zbltTQZnmC98YAcnuhBREO4aLd3MOWCjQwF9QuruLeYY949BSKV50Cv31ufW3B/3x75mJpBUg1k0KCLbdWLw1qxOz6n5lC1/jKfGbLVqXLyyHdo4r33seE+BSlHSp1yW6qt5SXXg4Fzd4oUtcTa37O3k7bcCXPnnMZuIQIbOVG5qrbD1mQVdJmNZkLONi0nL1k3rJ3fu3V6ypXOIpzrL40Q1vNphC7sawHdqc8Q3PRGk2ZYf1iPcUPTZF5dmeMz4kOrqe2BOQSMyhMaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 03:50:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:50:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 02/10] selftests: mptcp: update userspace pm add helpers
Date: Fri, 25 Aug 2023 11:50:20 +0800
Message-Id: <3e1ecc6bcf1f4379672f7f46ad6c3a5967d95844.1692935143.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692935143.git.geliang.tang@suse.com>
References: <cover.1692935143.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e08d128-1886-4adb-b55d-08dba51e6e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qt82fnkqczh/n1ryT33yREDQR80SzDcLGY5yUM17uza/lSy/JYoWRHrVUuylEDDa+okvbOdPK3qJtYTvM5hH1SvJhbDMfHOv1UNitY3lh+XBQWj7+DUiVxEqWe9MD8R1xQ5KQfj7FUsdvpHeRkcBfQunGTmhbjmTfTyKJZtCJk3WHjoSBLeTprCox8+btfizoo2AALsi+OzHkN7L91WOpl/Pb3bJ8UF1glulkGgLdtsNmCuzI7NJZHUxrpgRygY9ZP2FQ6VhuF5s8Y1jUU/yUFlmqL28mAPIzE3/NfbZSPvJiVMLUjXSXoc/nSNPst267PPbNFv/i1c0lEtW0gXDDJ14a84KKxsItAN69SfoCO7rZJYOjGA1VW9SwCWBNzQLyCKay6KkaBogBAhNVUh/ZG6pjVChqVcUw9I4MWFSGAI9KZB8ooIoCsNW/2N6IJAWqp9AP6H40CyFTRaUIXmxInE3L9nGg2J1ZIXExJPJRB8G61XynFKDMIQ0dVGu5Zq1P6DYd7G7EaXiEu3ABy1tEC72AB/LYyMNgBqmvFrNQ/3ygJZ/FFx8/qu8Co1y/P+RbFPki1p6BBuQXTBvIbfPvy+bD4DLvs7Z+OePbofeQMA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(38100700002)(4326008)(8676002)(8936002)(41300700001)(6486002)(6506007)(316002)(6666004)(36756003)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(26005)(478600001)(44832011)(83380400001)(2906002)(2616005)(107886003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mYs06GH9l28ReVuLSJap4ybu1f08au4pTX8himq/lm51u6kjNccehsPV/sTk?=
 =?us-ascii?Q?BKQAvm70XxReknAeYpzv3vFSqd/8gc01O72G9MNT2EAPADqmP8SgmoAGGCMZ?=
 =?us-ascii?Q?WttUWeDGGaJ28KAiuIwAuYuRDrZzXdG/E/WrPui4Vdrxs7hjWV3h2aRRpw0g?=
 =?us-ascii?Q?ki+qNPx3qxCEEI43GN1LoeuwxJ76x/MkMdWzGy6CLrzxLFMe8e5vPb9EHdyN?=
 =?us-ascii?Q?A5FzONNvoPp2hLVNIWkEj+ROYnKzCo1tZXJx3tENaXkWoX6XU3vEo2vAiXxp?=
 =?us-ascii?Q?hezO5VyIkwW5lSC89TqV8+qr/jBwgfGeoxaEODljNrH19ft8w/iL4JqCJ509?=
 =?us-ascii?Q?rUUFWzA9fXOF4jcrc8evJIKNBH/x9sbF9Rol8biGtmkFrQhOEwmTHGtDYv4f?=
 =?us-ascii?Q?HFVOmemRmbcbbVwBb3LB0kKny8Px/earz3/OFCwU3ppSOj2uJh/q2kFG0shX?=
 =?us-ascii?Q?BiglTOlg/JC9xuB2CGz5AzeX8s6hYGOxphbQ+7lO8AW0LqMDSJnartDWRJOn?=
 =?us-ascii?Q?upbWPjxEGq34rnsbmr9baLW5L9DYI3u1C//hLEIpkmXh5Cop6kbUYd0U8wxl?=
 =?us-ascii?Q?rAAw9RFVv2gGFEPoGHHYqtfoDKxYfLz1ghgxG+i6HKgOt9ftNGohc4YwE1yf?=
 =?us-ascii?Q?N+0ir2JPzn2ZOazd9uqsSaJKU69fkbyvQ/Oes/JdIHuUpokyr0NH1TGRbZOX?=
 =?us-ascii?Q?SN3o9PvL+F+1iXhYhoMTaSQjSOOPSFRKCMkiDAexSH4w0oHOohTpp+A+u6qp?=
 =?us-ascii?Q?7Zan0/RvqwdvKxyenbVcloKFhEOjjZo0IWYA8t6d6YnzRHLfunzkSs/TYcqn?=
 =?us-ascii?Q?3+vw2LbyJMT1sqK13NefVK5Eg/3s9UY5VLPt7upfDTRQiTUYTMgQ/NTMG3+W?=
 =?us-ascii?Q?7Tx2Nqx6T5P6zBdaJETD/tm/Kl0jOkWTdd+KEt5/kZ6W+qIw+xOG+R949p6n?=
 =?us-ascii?Q?XK4Kbc3e6KdhVXe9bf2F0R/BFv2ULfKmzzqNjZ0KvFYYUjcrvTw+cvle5ZxV?=
 =?us-ascii?Q?FwMu4Cun9pbSieyCHgqWSYnpMsFspJV32TQGHKBTCicxHX+gxhD5gOZno3Zh?=
 =?us-ascii?Q?rosN3AkFJIXSr1zGqCfPaXLS41JTLvD4nTcBJipVixUhAw4xZ5UTyqGPoiWc?=
 =?us-ascii?Q?A7CrnPdnQGT7TdYblRD2BMVpDjQzu3yYrYefkJxpKpnAv885LzA9eB3Hpu0B?=
 =?us-ascii?Q?Wsy02E5ovdivE5odyRKkwz1BIAeEK2kZ/dnBMfxAXpgz3puzBHDJ3M3mXKLo?=
 =?us-ascii?Q?HVPiaPKq6jdKl0GPrQhDGdwtoMwcs+zuLntJqYYF1ovIREM6rxKQ/NapB78K?=
 =?us-ascii?Q?TCXG/Hi0KSoKHJbO7ncnjMJr1rNtlLOod3KEbXxGJh+isQnW8g574ks778ff?=
 =?us-ascii?Q?+0VKmWoTEwRMfM0xpZE/xMGO3lL0kSpXsEYcePbObt4l2anq1lWxLCRc6bme?=
 =?us-ascii?Q?sORqtqTsXYyUxDG3PfsL/jFLP/1UlhhRhk8NyGucnydYWT4v4c+vN4Tj5wA0?=
 =?us-ascii?Q?6aoW6UmzhiylVnLHe2CCHnZfsHH6wwXtWactlsgsAlyP6U564qJt8FNEEqXh?=
 =?us-ascii?Q?Ld5BSyUBLa0fZluP3kUsbvO96DVyj595l/lodh2E?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e08d128-1886-4adb-b55d-08dba51e6e0b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 03:50:32.0623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kU35OalNJ8VAIef6cF72HHaAhOXNWYQmjO8X3Tbf63W1rDQe65xta4ypa5tQ1w/pAfDJTRW4RvHljUB/Krz7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

This patch adds a new argument namespace to userspace_pm_add_addr() and
userspace_pm_add_sf() to make these two helper more versatile.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 ++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8540a1ba5ef2..3e2745717913 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3264,15 +3264,16 @@ fail_tests()
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
+	tk=$(evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
 	sleep 1
 }
 
@@ -3297,16 +3298,18 @@ userspace_pm_rm_sf_addr_ns1()
 	wait_rm_sf $ns1 1
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
+	tk=$(evts_get_info token "$evts")
+	da=$(evts_get_info daddr4 "$evts")
+	dp=$(evts_get_info dport "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
 				rip $da rport $dp token $tk
 	sleep 1
 }
@@ -3413,7 +3416,7 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns1
-		userspace_pm_add_addr 10.0.2.1 10
+		userspace_pm_add_addr $ns1 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -3434,7 +3437,7 @@ userspace_tests()
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 		wait_mpj $ns2
-		userspace_pm_add_sf 10.0.3.2 20
+		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
-- 
2.35.3

