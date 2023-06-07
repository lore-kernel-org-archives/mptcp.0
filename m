Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32AD7488
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 11:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8W5da9aMauA9rjhYs49utfidZXLKMKcDLYIcHVMx4f6amCJs355r02QOafS+iDu5jw8IOW/OD8Y4x/vFDkb1GfcaoAcoIznmlDKB9DxXkntGkx0j1CafxEkgS9uehNBmleiWYVKHbWARVnabJeM8Uor4oo7MjmbdfcI3etcsuwC1+imeXP5920eo+VvBIL1UMNSHhP4ALm8906R5gNLSTcZ93qk+RBrI5TUZ35l9pN/qssvW5DNUopsaWdyuXv/tQUR1GloFGORAAcRZ97Mjt/ewv2KabQpnZJtRFOMcJdeYEJh1Lz6ay6huXs0P1fmqJ/LXI+BZsa9CkjMkrzbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vJ2KBwwyX+MlF3ESDqEaGXsQOYjtg/O0Y10li2uKFw=;
 b=OzO3bg3xcTkuBCZeFKFCcTQc7Wqqm5IFry+C+LjqdRGh3chbldBa+P1Qw3klwNgrDrp3DIaqjakAlf8/wv6i4STBECAWLFvY7+fn0TSjEJXJ6jqgRczDCk6OhW9nPgzef7YaioGf7R8ptwWmtGcxk/nDgVRtNgBPAwGiZcSnzg3kTNtkT2nShyOwxRy2LR5CWcitrPO8aCbAY6rqj0carDRi0MgQOe3sOcPldMGCkUSSDD+NCQ+SBx/K8ZSxoviq6be/KbKFICQejRia5mBDftYljFihiObKDUvs2jtpOKsNhPJcf5hDGsfXQjh5Xrcon9mVutxT6QmNTX8CUK6D2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vJ2KBwwyX+MlF3ESDqEaGXsQOYjtg/O0Y10li2uKFw=;
 b=4vAttNu4M0mMxmSLtNF33sHWswlRnFubBmkdkB1dCGxDQhXEgfzU3IRpS/dpDOjPy1FZPiRJFYR5NR3lUMCLFyf4+abhUSMb2EmrMNVuWLV6HC0nlcH66ArpNyHskauDsOvVyD/1NBioDCzUh5FWzoKwT87LMxlOY5mapPAPLjsX7UAgjAlDJtgo9ByIlH8wAcGDMksOTNyDGvf9ANxfD3PsdqrerxBErBe99N80H/dbKp/RrXltl3oL+vJjU0s6iezp3yV33Gvbo4gwKtomLF59J6Nd6sl0sGXeoqYApEdrS4bATQK5CnbWL1Ixp9BN4oFoYCsFh/5ggWXIYqnNgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8281.eurprd04.prod.outlook.com (2603:10a6:10:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 11:45:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 11:45:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 3/7] selftests: mptcp: check subflows infos
Date: Wed,  7 Jun 2023 19:44:22 +0800
Message-Id: <82ed5b57d2fba7c1a5ef35de4f390ad7409c3c40.1686138130.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686138130.git.geliang.tang@suse.com>
References: <cover.1686138130.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 40813c1a-4adb-4658-03be-08db674cb654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T6ijHUKHLApz2NYrDv16818JkmhrK0P9pxK2wPV838WJGrT75fBmP5xSU3+ScV1Ve72vw0ac9z9dD3izeGQiqZFF5jJ5rkUmWTu6w4dbnDdlMlUmxXw/8NxcQBvZfhsfUt1FIAI5CNAGPYMsUjdx2VS0is+H4pVOSguvROYVy37NydoAcOG3GPDrci/XcFND7MpsEMPZb4C60gMli0fi9tqpcxl0wywysqj5zhv3uohAof9PlFgOzGNMNp0DXmhyq9qLLDBtYndC+QanuAy45G0ZF67Etsv6qfptBQqDlqF+0QagD6pdcNh81sudg1lewFn1VylIJLPy6hVfB1TJiJ4m9QCn/9zy7I5phZ+06l3GXfzxm7W2u9TiVxHki1t8j4QLECnLu+QSSvakcukUedQnU8jvvimG5QBskJdZvdS97uos2aMTzVtbUla0/+VKIG4gZ0Z7hyEJ4G+p+4kjzNGLHahaZGdJdzf89tzv6gS3yveWIu7/vedvDeorb8UzCvhEx5ADvlDGI4dAqwRMUbspchoZ/pY2hL+CxwRInLAuKlxLcLb9Ej3XP3XTPSiy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(107886003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(4326008)(44832011)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XhJQVkUSsIn+s25EJgvZL6NfXwh7mDjGmygiN93UWaxVgxGGmb3CRmcH6ADl?=
 =?us-ascii?Q?brCyJ9UJDTmTtztjFxsD470Q55XmU1ly0R+tcK6qPqEe9kBstARhl8JrZyMX?=
 =?us-ascii?Q?lzUORgCn78L4AORcHYPVtcBLLX1tvpYACnmptb5WMpsYchkE0sS9g+6kF9Xk?=
 =?us-ascii?Q?biwJL5la+3gPRz44FEQRdwgi06jIr7ese3Mbd/f1qRL3ZrsmJSEa8a6RXDzS?=
 =?us-ascii?Q?dFGrztvx77b+iyjkHO+3cjc8WPDbW28VM6f5EfvAnB6cEibIElziQBGiaV6K?=
 =?us-ascii?Q?UnrQk+zuuIqoGIGRWto8iRLAft4r5JdmGOeJrFHD+nkBr8uUo/tpo7M9L30p?=
 =?us-ascii?Q?AD6ad/Wkgl5L+24rh5bnPp/wK6ZdZWYUxxhhOoG9j4kavSGLHgPyIqKPS6Lv?=
 =?us-ascii?Q?+mfYhyA+TyS/mbOaClSKFOXkfkIPI2r0Xs283OwaEs0N89eFkWzu7h1b6i8b?=
 =?us-ascii?Q?3x2ESCL0GLVei+1ET12PESss8Mt9km8ilk/3RQS4t1xmjc1mqALKtpbRYe6a?=
 =?us-ascii?Q?Cerc1BiRlncFGpVOeuLXphujuaHraI+/ApkyA/63DIfoghToRcVnA8dQsW4m?=
 =?us-ascii?Q?fGwdutyURDl7FtihEBMFLnDnlXcHMLaFtuSd5sjBc6msS2dLNbCtbqb8toe7?=
 =?us-ascii?Q?1npAx8m1ZTn52K0EUJPuIq9juGZt6oVAooplGd8CuN420deyQV1i4tRtKk0K?=
 =?us-ascii?Q?AAioQ+UDrukSiFQFN9+0OqxTEBUFF3ps9Al0pCJQwp54tIhxTofeLz1B+pu7?=
 =?us-ascii?Q?Ym/fLmCWn8ouh8iKH1qYyPZfoVylGCKsMzfJlGoB3vl9rbm/k4a6CD4kKdas?=
 =?us-ascii?Q?9qAUV1B6W2pVmD5Jyzd/bfgZVi+a8ON6ud9Iluze4X9kg0V7hh8GyXHrWj8p?=
 =?us-ascii?Q?9EHzZdgPwVvZD1ngVWKnlR1zKk2C50WONlo5JjBJDrz1xZbpNBhIAWKocHR9?=
 =?us-ascii?Q?XI0XbCuCyL9wZgKq9pQUjAe5ujYsjj2iPewfKTjbL0r5HNYgAXTa1Bv+/DrM?=
 =?us-ascii?Q?39Ki4tQ2Lhs1LF2r7jA0ncMLBLQWKoXzTywX7+2bXfCrGMuZF6e7SgW6pVQv?=
 =?us-ascii?Q?OC4ipkfWOnJA0v5lec0+BAFrYbKmQCDyxk8QE96sNKVD4Q24ig5DraoZg7NQ?=
 =?us-ascii?Q?jAyVuE68lGBQxyVtQ720IQISPuyrIihCliQq2SBwOxFvJ+SQezIDRzzymAYo?=
 =?us-ascii?Q?ipjlcTgArSmZWbMzv7o3FAFQSaLbGwOla596vmPQ3Ay5Cfw0cWFWVx0qt7gK?=
 =?us-ascii?Q?LxGm7KCdNZ8EG0JPKp+LnoXZfZjuLUi7O30dYbdjbOBr2i+zdCvsHfTC/ItJ?=
 =?us-ascii?Q?Kx78Ip/LGeYFDMHvS313vTaNeg5Y86BhdGHMt1wlmO9g8qdNjhcVTDJpGGz2?=
 =?us-ascii?Q?ji1o8H0X4SA69lsNE6TOsNzkMnnmRL7drMcPQEI0jnO8tpN3x8NgS5ssW3f5?=
 =?us-ascii?Q?0n0CHiCyFY6LBmdk5SrBzZ3gfOuua5uPfYvr+8i5XXTBMXpeTzeZbPo08tpk?=
 =?us-ascii?Q?wn5VPd5CPOmRhXjTmJLov/S/vxtVngrS29X53/l7iT04L/JDa76nRGL3IgdV?=
 =?us-ascii?Q?jE8wrWJPubt7+KZrOqGjlBIgbRtVeUTmA+GEMYNc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40813c1a-4adb-4658-03be-08db674cb654
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 11:45:38.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FB23CUUSyZJTfb+syHsqVBBvdnU8JyuNPAmOTDbYobV6HM6clCPjisJBycCTbGIBllAIIXuhgL1dF33KoMnciQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8281

This patch adds more arguments for chk_mptcp_info() to check subflows
info of different namespaces. And invokes chk_mptcp_info() to check
subflows infos of userspace PM tests and endpoint tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 39 +++++++++++--------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6684a60dad50..119a309bf96f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1812,31 +1812,31 @@ chk_subflow_nr()
 
 chk_mptcp_info()
 {
-	local nr_info=$1
-	local info
+	local info1=$1
+	local nr1=$2
+	local info2=$3
+	local nr2=$4
 	local cnt1
 	local cnt2
 	local dump_stats
 
-	if [[ $nr_info = "subflows_"* ]]; then
-		info="subflows"
-		nr_info=${nr_info:9}
-	else
-		echo "[fail] unsupported argument: $nr_info"
+	if [ $info1 != "subflows" ] ||
+	   [ $info2 != "subflows" ]; then
+		echo "[fail] unsupported argument: $info1:$info2"
 		fail_test
 		return 1
 	fi
 
-	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$nr1:$nr2"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
+		sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt1" ] && cnt1=0
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
+		sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt2" ] && cnt2=0
-	if [ "$cnt1" != "$nr_info" ] || [ "$cnt2" != "$nr_info" ]; then
-		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+	if [ "$cnt1" != "$nr1" ] || [ "$cnt2" != "$nr2" ]; then
+		echo "[fail] got $cnt1:$cnt2 $info1:$info2 expected $nr1:$nr2"
 		fail_test
 		dump_stats=1
 	else
@@ -3307,9 +3307,11 @@ userspace_tests()
 		sleep 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
 		userspace_pm_rm_addr 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3325,9 +3327,11 @@ userspace_tests()
 		userspace_pm_add_sf 10.0.3.2 20
 		sleep 1
 		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
 		userspace_pm_rm_sf 10.0.3.2 20
 		wait_rm_addr $ns2 1
 		chk_rm_nr 1 1
+		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3347,6 +3351,7 @@ endpoint_tests()
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
@@ -3367,17 +3372,17 @@ endpoint_tests()
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-		chk_mptcp_info subflows_1
+		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
 		chk_subflow_nr "" "after delete" 1
-		chk_mptcp_info subflows_0
+		chk_mptcp_info subflows 0 subflows 0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 2
-		chk_mptcp_info subflows_1
+		chk_mptcp_info subflows 1 subflows 1
 		kill_tests_wait
 	fi
 }
-- 
2.35.3

