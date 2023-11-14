Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487FD612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d5ZdujB7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bus4O/KxOEQ6Iw3tptftu2vPDst7FZcDkY7gOC50L+PD/eseJPbV9/x+lhImOmROdkyiKS0iR8ZM73l3F8TYamYsJ99AdUH1utsazJA/eDqt8jm9ClERtuU1z+zoZ37/hdpWZc8lKvI6VLlz9NhbYZDWfGS7WSMIY0ejbP5CDMc8FYHHdxEvKP3inATK3Q6UcNg7wwI9c7jG9OtEwUDEc2C4crVfcJ8qAEU1NQNp2LkFf1tqvPOqQRi/92J5+RqLpYAHSewRcxtg3dnKuSd7s79Z827XY/Mp5MLBomY31NddrYYHuuSFmJ4Argm6N36SSeWxmJjFIDqcIgtAVLwpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwZMivfP9G1xPkclY8TbRyPXWCb+9EDTXSTndS6ksDA=;
 b=M05nsFvr7CYn8N2nzoPogNCjljA9avfMdsk7b3P767V2QF8iI+1kRwDbXjweZ7NmJEdWtFV4AOdveEUvCeWyQovNp/mN4BcTf2cCjLtZVncWJPBQos6DVl0eJyv56F+AFMucilMZ1n/ieimK4zxVuIXLidD2hRWvG1HM6wdAW9Q3U9VvOGBm/S3NLPwYAYstm7dXpGFuKTus4ZxoEBSno5MGRDZcpixVHgLR3ohpSmXJU8aQbtu22qmhzDv7h6na6XNuCDh1wOt0csjytzjUIS3CqzVI+znrn6KGTC2Yszd3oEpsmtSo9qWFpGZcwJjP852LkHTH+A1e1ySfV0KV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwZMivfP9G1xPkclY8TbRyPXWCb+9EDTXSTndS6ksDA=;
 b=d5ZdujB7elnB2qaWzHo9ZndUDliOEgHpoezgsEPpI6YfDWLBHv704rbuVdTcuGI9ei/P525YVYG9hdn1uGnAwqqUUhH+1UydbS3g2qXLGl5O+uEPzlmqnKuCR2bAcKvgG53gYBqZGCkkEUw8Hkp+e+HrJY7xTcdsvfadDi78UCBb/B2m/DIuZG7W/RdyAgbncC8Rdx1gaQYCKw+rS4zfTjxFuzSTzbrN1/HjPDsam2/vgkVHfNf3f/eLS++r7+rhJF7U0GkOc4wAdju+1Jlzsx25Jd/Xu9NswPQx0Fa8bxnv8LHwHeRpLHip8J9IShNnztkl7+mm2Ofevn12Tphpyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:38:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:38:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 04/32] selftests: mptcp: capitalize ok/fail/skip
Date: Tue, 14 Nov 2023 14:35:23 +0800
Message-Id: <95a9a4d7efb7f0bbcba7d73cc4159234653d9d4c.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb416ae-e49d-42b9-1e12-08dbe4dc4ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pl25m+Sxb9s5ihcizI9pJ6hHLSDclS/MJXe2/iiHLGpw749RYjHsIhvbD+Tx6BBeslW3jOLDA2TFZ1rtIFu2yIFGQH7rL5T07eJLgIMA+joFMkHh58UN4JZ0AEwtCrzGFfI8hdDragggu79re0+3p/KcFkNRVLYmnmB7/syj54Ct0MuAQX1L1d0mALnOMkGnm+zo24cu9WUBD1EMAGJhc9StMd4COgsBPvtRwvJLZRSCM4KQiNAjcI/Qr1vWW5VLJdHTVHvWgXmu2QB5lRR1aktzt5sR2a/YeNXROBs6ovW9hgvFCR0qWrtf59vofbLyI2WkOGx8qYZMC0VjviC8haMJNlNSDLjoH1hxH+593DJv3/qenFVaeZcy8c6aFoOdM8HHAQaEQ17ua3QAqsIkzCKb6K0Qnod1tsgLR/KznTE8SJ8X9FGaaIKVyeUzpFh2pwvQHl9Quak9YK9cMGbHoZyW/lheDv5vmrxJ3ihVFLXgdSo+jw/v1XZVKSZhzGVH5mTOGveHZ1TYC2T6vJ2mECXbJhZsP7B8DYVJ9CiE5bElL2Y0lniH+o5OO2tpPIFa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pzpGsbmNm7mMhcpHSMMv//LGtRnrjE+r/WS/i7rYbWJS+cRw9eRHIE+5L0ih?=
 =?us-ascii?Q?uge1pWFYxJWnW4C7SDWpmUzwKvPVGOxdqqzJFiBLCaFcf3WnqPE6nADzMUC2?=
 =?us-ascii?Q?Hs61xtKMOiWCCz/O2y1bX0TYEquE8FNDHZkxnci4v8NMpLg8PfcG39CXchzN?=
 =?us-ascii?Q?s7+tvsh0mZOlIvPfOqZ/v71sDhoBwjXBv1GGFepwXUlsotKkTHd7ZdIsyLHK?=
 =?us-ascii?Q?+mIlTYCKA2xYJ/AAFLGVuiJI2oeiQMllLIQgmiuJp6xIDYksrfRGCdPS8Uyq?=
 =?us-ascii?Q?hEhyVkkbMaWbPLgRm0+YeKadu1vv0sTKxmUR2wC77naG2/16spmJkdOXcEkn?=
 =?us-ascii?Q?QQWXlEa2tBqnxnMccwBj2MJoG8ahPYTkRIfoG8FJGLfIWZu6knPtf8HhY6Au?=
 =?us-ascii?Q?IBcXxJOwOPVdzN2bpkrRN4feEJeyjkUB2NkcIvijjzkZ95e54JXWQBZdKlWG?=
 =?us-ascii?Q?5Zv3hjxUI9Q2YWYbVGT2FrBJzXliXY/fzD2jRnX1HIJBdczHVXFtn6bloylF?=
 =?us-ascii?Q?lg0KKISPRh/va8eBa8msYSytqZfv7/3l89KbYr6QZsfMdqSfp3WLqcDcHrSO?=
 =?us-ascii?Q?5l8AmvsHtVoH2WoJN2eWRKPLKCP5woKQqUUc0nxMSdlRRrTxmDnyHSznfrVs?=
 =?us-ascii?Q?LppQu84I5M2N48mhihoC7pddnLMZUBeVNdesio6SFAO7uuFW43Swm02HcwJ9?=
 =?us-ascii?Q?C8BnlPooqvGf6qHtPGgXmcWn4YiPxm2XgrtDF0C/x2aL/G19PMhcrZJhjyaa?=
 =?us-ascii?Q?jXHqhMegceKKC/muSHTTOAd6Yh+2c5B24BImcEcfcSlvpuUum1clqvydpPR8?=
 =?us-ascii?Q?+8IcMV6G6DPPBZBXruEagWFdp7u66JBFc45kBJVLNhyhBFEmRtaRhs5oa7WL?=
 =?us-ascii?Q?3ELz50dv7veCZJQX0BD8sfoZp2vozlOFYGQHkHlCNQhgQHuzuy6MUCq+rI6l?=
 =?us-ascii?Q?qu9YnaM0o/txN8kp10+54DZQC6xsWnxD1axyuRoIo6JR6GrH9W1BVqEThUfu?=
 =?us-ascii?Q?U8HGAT/15vbgNNzyo3nzdmUOlDNdEkosQnS9vWkYTa86bHA35YgP6v8+iv7z?=
 =?us-ascii?Q?iL6x7GaDlPQ79akdjyGHUonQPUG9YEN614EOTmZaPwi1ln2hv7pyCT3bTQgd?=
 =?us-ascii?Q?MSePjVl0EXA3qrrqLW4U/s8pet3JEYIs1gHQohtQxMbNlserRkF0CS9Zhw1I?=
 =?us-ascii?Q?EBPN08Z4I+F1LNbil2xLfyt6TbgB/UiuQLuWciB82hQWsfK5v6Sn0S8EPtAd?=
 =?us-ascii?Q?wZ7dpMUKZ8+7c8DPUA+5sNcafiMgvytq4/s1cFqlibobgeDWblkvenUlJu7O?=
 =?us-ascii?Q?UZ2NyRECFGwE1q+eHI2Zzox9g47VBrsGY2a9WjmaKViCeD4+esLP28JsJh1w?=
 =?us-ascii?Q?9EqxymruXbIL0RqTexx2KFvz6cEeDxI14kmEklp96CfWLMNGEU+mWSVLzSGZ?=
 =?us-ascii?Q?bfo+iSmsmh1T4jxvVlwZi91tj8pkWpNADMEWD6UiPqfgh98CaHg/4OOb9Kfq?=
 =?us-ascii?Q?aEGdmvhg4tq2Gq1iBSfg+ul8EOPtIMieQYVgnXI+Cg8plVmfTzz1bVp11i11?=
 =?us-ascii?Q?+MpfdGEu5Q8H9LodVUaVUSJzfsQR5Hjnvy3S/Wsx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb416ae-e49d-42b9-1e12-08dbe4dc4ee0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:38:27.1770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpbFjgoCDux0zB5dl5CosqHlvCNBN3g4CeAIu/PIIcJ2hz325uPIWGfQiXsssFW1QiQzdujjKz1fuluLBT1dXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

Most scripts print uppercase [ OK ], [ FAIL ] and [ SKIP ] as test results,
but lowercase ones are used in diag.sh, mptcp_join.sh and simult_flows.sh.
To maintain consistency with other scripts, this patch capitalizes these
lowercase [ ok ], [ fail ] and [ skip ]:

    [ ok ]   -> [ OK ]   in diag.sh, mptcp_join.sh
    [ fail ] -> [ FAIL ] in diag.sh, mptcp_join.sh, simult_flows.sh
    [ skip ] -> [ SKIP ] in diag.sh, mptcp_join.sh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh         | 12 ++++++------
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |  6 +++---
 tools/testing/selftests/net/mptcp/simult_flows.sh |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index a678ee21973b..ab62737bd501 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -65,15 +65,15 @@ __chk_nr()
 	printf "%-50s" "$msg"
 	if [ $nr != $expected ]; then
 		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
-			echo "[ skip ] Feature probably not supported"
+			echo "[ SKIP ] Feature probably not supported"
 			mptcp_lib_result_skip "${msg}"
 		else
-			echo "[ fail ] expected $expected found $nr"
+			echo "[ FAIL ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
 			ret=$test_cnt
 		fi
 	else
-		echo "[  ok  ]"
+		echo "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
@@ -114,15 +114,15 @@ wait_msk_nr()
 
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
-		echo "[ fail ] timeout while expecting $expected max $max last $nr"
+		echo "[ FAIL ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
 		ret=$test_cnt
 	elif [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
+		echo "[ FAIL ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
 		ret=$test_cnt
 	else
-		echo "[  ok  ]"
+		echo "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 42f3e49db74e..c5cdb8b1643b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -216,17 +216,17 @@ print_info()
 
 print_ok()
 {
-	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
+	mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
 }
 
 print_fail()
 {
-	mptcp_lib_print_err "[fail]${1:+ ${*}}"
+	mptcp_lib_print_err "[FAIL]${1:+ ${*}}"
 }
 
 print_skip()
 {
-	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
+	mptcp_lib_print_warn "[SKIP]${1:+ ${*}}"
 }
 
 # [ $1: fail msg ]
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 436500c55e12..23f5bc0aeaf2 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -195,7 +195,7 @@ do_transfer()
 		return 0
 	fi
 
-	echo " [ fail ]"
+	echo " [ FAIL ]"
 	echo "client exit code $retc, server $rets" 1>&2
 	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
 	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
-- 
2.35.3

