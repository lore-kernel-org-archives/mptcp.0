Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1F4AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="4GU3+3JN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocrx87h2pCma6TT0oxMQs1t+mMHJZ2U3GSC5iM/87eUYgfmtmHule+431sJbLnYm0FhkZg/4TKOeOExOs92H1RPOyewD+vGDAxSwOWyfM1Ex71YHYSYO59PBIr1oZYBCBnLwUzFrilnBPnrNWw+3RuGRwUt386hzLTa5AlLf7V49vyqFwn65WJ6vcpmcT2B7o4LTBawwdZESNH/FORNFq2BUvKbpQFfMylctm+icf710t6ETe6vA/8NlmhbGSWwi9oznPMbcyJInHrFD50KTDR0FaR9iMNfGX88vk82VF26n3gVdgRoRgcskMsCtJJmAJ1qz9JjEUW29Td9bZuMUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRCZdrax6BmbwS4g1wBCUvMGj/SR7QZC84hoyhlIXw4=;
 b=XatG3m4d/DZxI4v0V/nggFboP9dkSUB1jrFrZvY8uJR/pEMAD5WLGW6856Tb2LT4pBvl+zx99Hg0aYEo3dlzGMifTddL6u9AcGsTsrZX+jymbJNpBcpP8pQXZhlx48exArGWMfjCcVjBaq0FGyC4TBF5BD0n8m/osy6DUDdZQABh5Ox8TGqIMS2N/iOI/OnrpV21U3uDVGKBiFhYfn6XQRXHw3X/NtN8QW31P7CDpRjkkIGGwODsNI5/qj0U7GQb7nB/dfb/GLTb2XFOL0jvmvwN/VnERofKET4jZOb6Cvk5RT9VhvrxgX3EZYvYUrfKg4qqQY33QIWWZHgrTymwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRCZdrax6BmbwS4g1wBCUvMGj/SR7QZC84hoyhlIXw4=;
 b=4GU3+3JNvdLVNMR5SKYyDY5GCOBokvN7KoITsrlncMzr+QbljwcZhFwbasjmyIpBZE+4hHVVpU2kBoS/GXu32XM/v5hAl2bOkQrMBLlpLUHFuSru8m7aPtETcfXH7ULo9bjyTmyJXMgMwC9U3PqdcL3CZzHcpblEIzbuJ72VUQe05OVs8Aa2gSAFjUL0HySTA4vPnp2VYuVCmbSr6ElEvtzS1Azet9aJ/KOYMsZ7H1WLS6ElTPizukWOavB4US3MkXwBtysVvEmnqW2ZrgZr36wlRNrZyxfbNtQxjdYp5kPQ1R2nubDw9XJIvY6bQCMUOo+iN4+twYqdb5LmBNc/Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:31:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:31:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 04/33] selftests: mptcp: capitalize ok/fail/skip
Date: Wed, 22 Nov 2023 19:30:52 +0800
Message-Id: <11b58a268d1425513e4f057643598a60d941604f.1700652422.git.geliang.tang@suse.com>
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
X-MS-Office365-Filtering-Correlation-Id: 118ba2aa-6eef-45fb-840a-08dbeb4e96d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B2uzVt5CFI0oTaKK8fZ+7+PD8qf+NuaZCqnURX8XajNf5maB3CPqmwguklKY3Zi8rLrf2P1rpKc7p1MqQEYCaLXhBYHHnjIQjXLYoEZKYnwtiePNApNzVg5FcMlqvSt4NY/PmhPTAO+ovzZ+01z/cK2nOOIjau7BAeyvDYwzwXhaMzt8T3wdB/k6W5GgcuZbLFqWDUuOJR9UwRAuLOdxZL5NlQSa980qn/nODbm8CzDqHaIRhPNG0ud29ulFwqEEIvT/hZka+eu0QDl59SQfPnZMaBu4/o67CK9rwcvyQ+XWgct8oI5z7q8BWPxxJ+B57hEQeA1MSoplgOVFTOw+1l18Pk8h+Yssg2JTJgXWBv8x9MEhbOcUbTscWa6gxclGbk7QEt7aA9S7V7CtERSwCST5p7CAZsLQN64CRoeVnIduRZhB8jqzycnOUSxBkhbsTLEfDQj8vDtqcy6Ow3KmgyX2jrZmLHFeo+G1FVJD1qtEA7KWyArIS/OvNgEUupkwxzqjofkwHh9kBkiaqQuFebmFwuJO+c6lnI8+Cs7L4QPI0miY2sytNDhqTMvtxmB+ViqKN1aFNVWnRJ+UhTd+8OhBeEVtNJ4X+D8pG86xoWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(107886003)(26005)(6512007)(6666004)(316002)(6486002)(478600001)(83380400001)(66556008)(6916009)(66946007)(66476007)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F4ErvBOmgKF/8Q1GB7o3cwyNaBbSHeQbllF0cuUTiAAla6kMV5cFcFQR3bJB?=
 =?us-ascii?Q?OPe351zwgZsoYv40UHG3E6Gtajl+l3WaIVhy9VoRBbz2olrgqkGuCfb/hrvF?=
 =?us-ascii?Q?nfLuLLiWAGqQvusvpD5RgTV6F1ImuKggAxrQ7n//fNnCR20OG21WArb09T7F?=
 =?us-ascii?Q?cjb823+X+hOhOH8E7PBQiM3R0ctcRjdyZx0hc2ZdfCp5Fv8ZI/WXmzY4oKJ6?=
 =?us-ascii?Q?45Qd7nnSEbwGuAz5ci1fEHVh/JjBzRpckvrBxFUk4S9TEg3oetlTWmmLXIwM?=
 =?us-ascii?Q?NOCn4zFiHVdX/ufnWCO993PPXl8WY/XNWr+vzuQNpxOUP3EA3wPyEF2H0HCN?=
 =?us-ascii?Q?hlCB25s40YDkndRmPupi+zCUicqrcAujsZbL0qF8MJk4SYHxKrUKGOkYbI/K?=
 =?us-ascii?Q?1pj2iNQVrbQju/k9zGZDAYgWntGa9wDJFz8f20csQJkkujnx7GLYZaVL6jqP?=
 =?us-ascii?Q?tH53ROiWRRa99Pnd5N1qwJGVntpn0FrzlRfI4R3FJ3biNH0zVSdFPMsZuNhM?=
 =?us-ascii?Q?Of+NOpv/zZ6bGleZY8HfOJnO3EJ/PWiqCUDkSBjKrUgFerZzLyaSZuth3S1Y?=
 =?us-ascii?Q?HtHooy/YaiMCaPQbJ2mMqLWEjx3coqx9Sl/yVqYAxSS4rtoEOFIIYeen/AKz?=
 =?us-ascii?Q?XV+A1CozAvMfvdLQm2NX4h8PmLz1ey6gfdTTN//v24Y9bi+0+V8kiZp6dJAg?=
 =?us-ascii?Q?9H1hap1e+NIpsH23PH+XAUs1i5GnYskhSmIdIGox0S/ahgsS3MH7URWl/CjT?=
 =?us-ascii?Q?F1HmxoKrjqgAvnz3y/w9DqWVpCUr132aEjRLkdvP0GkNpc36MLqxKPUPpRhi?=
 =?us-ascii?Q?OVYOQ/OqzHfA1rFuo2qUloMSAS2viLPOggzmBM1AAQ+fwHmZL3FbBtabpSaa?=
 =?us-ascii?Q?f9XCnMhwU2UY6EIpNRNKuP6LWhwFgH1eBftzpLaqZeLGoRjWHatAbcU7t4ep?=
 =?us-ascii?Q?eTof0+58wt5Pf3AuWjJ62Nh4pNANKAwMzESxYI7fkYEbqA7KtcxnhTc22buP?=
 =?us-ascii?Q?unrADGvfS2QK0itHnF52ncuCJzWxxnWMsP6wDfDTDT2DxVrNTTROePLLYjP9?=
 =?us-ascii?Q?xuxb5ZsQ2jyE5ANQGJTSBYwoJI6kYBA1M/6LB3WM9ZW/pFfvZUJXrzVqUZpz?=
 =?us-ascii?Q?XGNwvjIIaBNrTYkY0OYUrZ9EcMLXL5Et+9LTdoZxwFZhzswGiMVgja1hu2MH?=
 =?us-ascii?Q?asW7yfftqMnO1HvJVVE+f4opcTqxF0ZaXCmFSsgohkySw3KXr8xocTDtIab+?=
 =?us-ascii?Q?vGTU/CZvkWJFSscXWK0AzJIlU5PgDyVE6ktSXbOfp6ak1w2RcLkb97gDOqCd?=
 =?us-ascii?Q?S3L9UysumJkt7OSbdr7QrHdjOUCrqs4IpbwFGxEtwuD63m0nal00OlWHPAzP?=
 =?us-ascii?Q?jVe0oImJh0OFQNDiAV6ToMclrEjedUVo/TflmqB0MTOt63/mW7heiguAuNzB?=
 =?us-ascii?Q?r0GJwbjbuAdcN5PHzT/mtGOG+3Yxabul3o/Ar2B960+Gv0jMagqVWBQaeUXI?=
 =?us-ascii?Q?NH0iTRgN8pT0uvs4S0ovn35HjVYla6hmv7gpEP9sR04DBLL+zpjWKFCvr5jV?=
 =?us-ascii?Q?inXMU0bnmbVFXOtuYf2ILkpJ3vprA1FV5U7/KFRA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118ba2aa-6eef-45fb-840a-08dbeb4e96d0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:31:37.6346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlJI3J6CGdZdB9q3uVA4BMpWCEl3wUTG4ALTlbzobL19OkklNRnalnhvOjr44VFtIrSb6PyzoxneHElMQxpTCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

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
index ae326fd5340a..faaadb2f335c 100755
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
+	mptcp_lib_print_err "[ FAIL ]${1:+ ${*}}"
 }
 
 print_skip()
 {
-	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
+	mptcp_lib_print_warn "[ SKIP ]${1:+ ${*}}"
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

