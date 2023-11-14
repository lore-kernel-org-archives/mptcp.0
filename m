Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778816412
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fXzuYdMj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce6YuZrfXwKO/4e3hsmDyYjMo5eJb5iPe3R7Puf36NzdzVvs1150lUtmrlwBTkTJz13VZIo8/ZwNTVM8xmZC/D6381BFHQP6PcQog5zKwdycUWFpxQKdfQ3lwyn0VEa4IlSyy+vPo3G5ZG2aQ7rApy5exX60rQCXMbx4Gu7XstP21XUOTUNBmx8/aBaQV+oOyiq0sRwpZ+vh5smSBZ3wSaHTwnlCvsOEJ7+a6GKRLPguZ87m5ZGWRgXPkEcJwr130y6rWZh+GGrSfzHoWUZT472yNvWOHiJGLny1SCEArtKswgMqWx6Jud6cnJ5bGMcfwaja+wAf4nBXmCQU4A/4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwZMivfP9G1xPkclY8TbRyPXWCb+9EDTXSTndS6ksDA=;
 b=hSALHeNYQzS00NlqhlBD1UopqjKErLIpS2YHjUwVUI8L+iZ9KOJYMW45Ay2+9yANu8j9difHwcEu4M/ZFP9879D+1HcmtiFRZwU22PZF479wASFkmy0txLDNQd+7pjv72AT8ppOCpGBb+qiuQ/mmjMoo0cQ77G8gaPmuEg5GNASvv821i5GvVUYqTD5oaSljnuowXmbE2UpCYvoqsQHulp6E6zOQeXG8yhQ1QCo1AIvCg0HHW9AU/ub1IPgIX/UmpgOi/GrixQy2G13gw2SlG0PjRUxS1UPizhKxTLXPvqkDbt4Ogv21+/dsa00kz9BYQrEnhw5rUrfGF4HcOlz0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwZMivfP9G1xPkclY8TbRyPXWCb+9EDTXSTndS6ksDA=;
 b=fXzuYdMjo8IRrl76XnjO1Srb475LnPc1lxtzjioZlYk4/98XH28a6gZFDJi+qWC4gHW+jGd+/+DRKP++lhIWmqVdyOZWxovf+s/UlPCAEm8TatpiW6MF4hGQYPQoI4quBxqldR0z2lqWOiNKly+P6j5LeRxMpFt4e0Yvt4iGzmBKc2xocAL6E3mVnGlgH1kMcfigJKERiUAb5JNBff+SZGFxol8hD1KL9rLXAway4APdhAMFQxsBIBdILyayKgCj25QHUbT4Vti7soK/f8vyY9CUbeLlg6i7GgFxixV4KM1ZaLRwtwPQCVriotY9pZ0q4oKaaCM6UYu00sMMdnld3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:22:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:22:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 04/33] selftests: mptcp: capitalize ok/fail/skip
Date: Tue, 14 Nov 2023 18:21:34 +0800
Message-Id: <690f4c0028e1c6ef6d55ea8b9f9fd3324a3e57a5.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0186.apcprd04.prod.outlook.com
 (2603:1096:4:14::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f01f9b4-88f2-4e10-f786-08dbe4fb942a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nJlPaMbiCE3Yzm9A59Dmreb1+wX7LatIt4pJYJHCdLy/RngCNmCKPA0C8fNkEUvnGjNcOQAZtd3eB1Hfa4Vo86WF5eo95rPggX6n0wkW49Cjnf8VdIhGyOogmfj4zM2CC8eM/JnAujtQoVa1s+GliRxodrzjnURzuKp2q+xMv/tnCJGkVDe+7UQfU2//Rin8OOoJgbOgglmalwW7qpFM7/GGzWa4o3sNJfiPDVe/+nyJF3btfPo2tt88CbOfCTr8i0n7hybfR+sY0Zicu8VSo/SNcLOkEtR/HAZ/wsicOsSvvPdCpQaJhQ5cIDLfZO2ZZaoF1PDKZM87ejn8W2jzce7rYcfqK+g7x8KYi4BExaLlvV7QvSZ5kQyThOdwpSgurBpPR35Ot7tKLLfkYjoWdaWbl5YRYtZ5VJxXQd5sIqgPOELvju1arFPj1bByRW6VZIfyHKbLG/I6C5XHcWxNhmPYTzX1+7vcqgrQgsbyYPMfzBZdxjgE/7Z+uc9awYxLNlJELnYhjQpORNabwvahn3iF6rLi12OjcB0M80TejU2oquPfWP+LANvGrCydiojg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(44832011)(5660300002)(38100700002)(86362001)(41300700001)(2616005)(107886003)(6506007)(6666004)(6512007)(6486002)(478600001)(26005)(8676002)(8936002)(4326008)(83380400001)(66556008)(66476007)(6916009)(316002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HViAhWyx7A0fGafLQNodKr6E8n0SgAMcNQ/nnDZoQZf6WV2PuFkBqR3sWoGv?=
 =?us-ascii?Q?QhBMfbTzctjwgvVUZr9gKJ3OmWerjoi/BlVrqCT7IUiMR71Pqcgq1c4Oh7Z5?=
 =?us-ascii?Q?wKOw8NgwWrx12q7shxgFFZ7uqdssIEP6zBOFmTF/Jb8oh/ees5JaRxCFIb48?=
 =?us-ascii?Q?nyD8m/XhnngAkJ7CMW8wolUsrbkEbZJUvxBS5WSrEmFhTIVBG5/JGiSnQ4o0?=
 =?us-ascii?Q?95O53oXjgXzULMUkSDELZEvTwDU1cwjoK2HcImorSMFLm/g6fGtCFjsaR0PI?=
 =?us-ascii?Q?AM4FQ7KwIA6XHAQKJwXCslaCDz2AGf0NtALKq20tjn9Mt8ni5Neja3UIzmHg?=
 =?us-ascii?Q?+e4tL1P7W+mOWlEuiBZ9yBqd2aBU3baypTT3GjsYnjc90KdSoEZ6fOPC0oAN?=
 =?us-ascii?Q?5iB2MDPJrHns0bMi/UWFsI0uqbiJTy9RFeS+Sc+gmziqsZ3oAz8XgvfXiOSu?=
 =?us-ascii?Q?Rnt/j02cD6x+2JiUOMQhdIw5XJ0oXvG+5KH5UYkWPLuywJppESjcsYQOn9ZU?=
 =?us-ascii?Q?6cPmiGLqhyGhnq8wA0LTB506IQNxPGiWSnwa7Qf2+4tcklJHTUzCRezZGLMo?=
 =?us-ascii?Q?PHOYwP5F5dGmEAEgEkyLt+fgpFU+HX4264L5q57SQmFDNw7qF9DRe+it54FO?=
 =?us-ascii?Q?0Bx53GBM8nJ1LIMlp5zJBCw8asA7Bu9hzUyAdm9Hz5A8KG0+YLRWk1qHKkrQ?=
 =?us-ascii?Q?TjVxMvYtekd34rgJ6FoAsN6RFXBDks8XxYXodXM0Plo5pkzFfAp4UNQV9gG3?=
 =?us-ascii?Q?ILO+P8eO56CpG+F37guHxTEBOYeDzI/uDDuTo/6i82WHeY0p+jJSnVTYCRnr?=
 =?us-ascii?Q?PBFjiKOChhc0KdPVkI4Jlh+wVQh7A4cm5TfadM4Xt5KTANr1mngo9PukF0TP?=
 =?us-ascii?Q?k7K3iTo3QsJSRSkLl1Sb/DuWpvZQGsrOAI6s48/CECUWcMIDdKzgsglT9zNB?=
 =?us-ascii?Q?PST07VKHsqAyCFEdFAx2uCJeCEgaWM/xRRNvtgUYn5/a8+3OMPnlqoCaQeFN?=
 =?us-ascii?Q?HzXMFFnYxy2nKR/WRHXK8TQQGrAiWNNQv5AM57gTlEUvJyQGPILaR2sjMIAt?=
 =?us-ascii?Q?0azh4NfUGTIeMbUr5qgnXgMD2yG+FlKqCFot5SqfY/SRFym3XgUeJkoliIcC?=
 =?us-ascii?Q?gaE94viVl0ShnpjsF3vLh2gv6IAQ1RPA999zvoAGjD2wmJ4d6Jh5RQoYwqmU?=
 =?us-ascii?Q?RLdJDT7j7DzfgpDBO8Xs/YUIoXhi7V8oe3LLBNuCDuKI3IJMakoTYNtapshq?=
 =?us-ascii?Q?aOaG8tJTKjfdAX3z+sYNTTRZkSy/diTCzR2Wk9z2ZVGixkUlRTxaoinDcIig?=
 =?us-ascii?Q?dtXCKCchoX3+vu0vXtiKw0lgd3cwRKpHSWAeoWvX1uhg6d0qWF03SqxBAX7u?=
 =?us-ascii?Q?UyTFN12cnGObcLW4UX72PBwYTaWwslIFYkCDfgNGfngjaniFu92w2i3JR8ga?=
 =?us-ascii?Q?zFpzQY+B9kK1mFC45U7d0MEiT6qhhR+jd6jSqK/QMZKBZMs7nyuCpBMW5F5t?=
 =?us-ascii?Q?PEqbvumqil8DX8eGiT/iT6jaj9L9OEnUQ6PWVWkShtGax5HpPACrXUpqdsNT?=
 =?us-ascii?Q?L0sbc2kzW0gExcGa5pjXLXhWMPvq9ITjpRXG7w0a?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f01f9b4-88f2-4e10-f786-08dbe4fb942a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:22:18.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG79Ix00yavxhqZ/5Zjh+OtSPTvLeaKBc8Mq1TPuzWRGozdddahUG10NbQVYLqMZ/grEVUtNJBsjF/pt+QDvWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

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

