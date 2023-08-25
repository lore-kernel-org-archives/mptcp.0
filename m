Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5207E0
	for <mptcp@lists.linux.dev>; Fri, 25 Aug 2023 03:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUgsg17HW/ZeeVSr/LLKN1bRtT9aJjHVVGK9ywSyaum1n577O4foqG/nEx23LYp7AUl0fO29QHW6Uji3ZTO3bAUFtkCyFN46fSn597ybd7MAh7XSxNCerl6Ue/+qfsqINxS4Z9EefrETCFbbz2ajMaXT/gZnbOyNHaOG2jT6gGy8zN22G3nDYR3K1O+vdx3tApBKu2zppN9/dc70NWqo0p5bjSIgsLF9OfVPAcisLrx/cgpaNgCiD74++mfXf8k7fS0xBkPOgm2pEIVgtb35ioKIpwVK/zZsJq3CRcBBwA+1rbl9fTQL09VxvjPVxMth3p5V5CPg94+TL0JpWw5eNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXsHRragkRmbw1wFCLFqQWG1nQfgx5llBkTHJCQAhmw=;
 b=SU7+rImLe+Ok7EBmRw1pkzd8cvevmX6l98VsEX00S1B4nnWzG/iQGL7iUMNE7EcYX/Ub4FuuYly0+HoU/iJn++zomqWzh8kB2FZcS/+EWGWfSwi6SUCciTPxv/5ZkVUodVQyVLJA8OrZLoDVwVMimFFxLq7gGdcpa8O+wKKrhkJrHwk7uA/r7kuJ25meGzEzzOUzWv9Lk0Eeo555Ont1UgmWqUjxEw3Q/hRtjFm5dw8UmSmjzTZZlKyc2Pn0uuvczp1R1GvrbKIGmIbyzFmLGHTQ3CNwbqMwYcCv7eUGpYfwC77SRXa7VjT+dw+Ike+30NapZmhc4E1N29WU3zb7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXsHRragkRmbw1wFCLFqQWG1nQfgx5llBkTHJCQAhmw=;
 b=uDXmanR+YW34JDzp28Hg69raXaV41c6E/1m1pAQYHJ8hsJk8mxkPAP/KCeL/M+6CoxDFwt3DyA8S0NiX9U8iglqGRQ4CgSfkgGbybnxZ8oZJ3Tn+K7jbFnyCaahuLlh5UwAsopqfipkGm0gsAhf7UsfVBtYlh/sAtwVom7XYsMI8jPNam9qbcBBk3jFDRd4C0tgdXtMzx2Ni17SgnOREDs4S80ORe4Jg5RxIocig92XyFkO0/p7hCmm1lp83AOyN0r1942y6STatoITTHPFgImH8ejUl956t1xvK/CWw8mCC3jXXElFfwDm2yCKWnJp0XYj8ULdnr7yznx7QPJm2gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7091.eurprd04.prod.outlook.com (2603:10a6:208:197::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 03:50:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:50:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 01/10] selftests: mptcp: add evts_get_info helper
Date: Fri, 25 Aug 2023 11:50:19 +0800
Message-Id: <d95066b4d0fec548e336200a2f3d2a12072a4ccf.1692935143.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692935143.git.geliang.tang@suse.com>
References: <cover.1692935143.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0132.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bccf083-6bf6-476c-7c64-08dba51e66f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Im/DymHV0fNAJUiaVnesdcm6SDQC417favgF8GnGuCpo4vG9Ay/Pr7pKvaIPZz8JnWOTlMjofa0xbuJtioBOg8TD7Nv+KlrrBh0rx7wx9FSZIJ8kyJ0q7omx5diCB9HNDPT+b74mtzEJvGUiCJ9i2MDkffwJt+F4jKNUZV7sZxN8dr/21wRjpgBxRqR+h42hnPgBr2MpDCl57BhA2CEsuPt8WYcP0MO91eUojRB8yzs4PWcgRUW8G3GUGd7hpg1O0Pi+4Ae3aRSBf8y0Wc5JwYGqb5ml9imSsxttHZC+BW/47iRHWuGqeNcaFWhf/03FbC07/jReL+43zzByRKiFzZ2LLhYA4JGvdKaffn62+xo+7hI4w8iwLB+ccE2u4VytM0Mzss9go8iJCko2CsMtWax9/taaxSb3gxFeKlnVf+FmdZ1vS7FFMTJbRLOlyT9RsKICVFEuhV/LLG8W7E+H7wjQHQOW+EVvplNgwVorP4S78IqsvWAkhnSO7QOLmcfhLIyg7Az/uIeQH4jy6i2FYvqeNvaiq8L1ZhWTyzP7p9zp+CI5FTyhuam0oF/h9a9tKkakyw4+MesHgAOQP1O9cJ+/KOEK8B0fJs55zfcfNSw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(38100700002)(4326008)(8676002)(8936002)(41300700001)(6486002)(6506007)(316002)(36756003)(6916009)(66476007)(66556008)(66946007)(86362001)(6512007)(26005)(478600001)(44832011)(83380400001)(2906002)(2616005)(107886003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MHUAmJLNVrYfNL3MJRev990GLCC2/CkSLVuNZoAQgdcxhTp9EtRyX9il9Xin?=
 =?us-ascii?Q?Aef0ex5oqQ8ew8EOg1P313j9f2o98y1mggTPLOecT6Fg2GKvIDsrd85xAtee?=
 =?us-ascii?Q?6vqlSUmNU8/ZWJIPAHWdbY+bnrwN712rCu2jtGLaWmkQQDOrMurMclfqlThT?=
 =?us-ascii?Q?wICNBEvSZ2u45jmH62mQeKRydw6Hxl5CFrSpehL9qcYMHGv43UPxM1zuDVUd?=
 =?us-ascii?Q?NV7k0IQJrz0aOUDamMSrT9crNlhpvbLczxUjaBwpDQgSocrPvnXmfDwpmGH4?=
 =?us-ascii?Q?TvEbDtv329HhT9s1iKRL6DMPVUyBw+8kNT+YU7rGQWs02LYBmH+3Szl1hqoc?=
 =?us-ascii?Q?ypK/83+tOhyMPOtAC5niIyp4CUhWk/yZcJD3He7UmF1EH1jIvWjPp0diXW6a?=
 =?us-ascii?Q?0CTTX9QDw/uKQf8yQSj36M+tuQc79WVlDW9ZtxYGAQjd0HF/zjzamrHH74UJ?=
 =?us-ascii?Q?7UBjBcnzMTEVkoNOYrv0Em7a6Y/vjmAzyeMbkt837L7Sa/9ymlYNYOEmZ6Rn?=
 =?us-ascii?Q?EI0GKpwt7nIieHbsxU6wsdt3BUsiEobrB7f+InpL//CwP9gtuTdXv6n+7iV2?=
 =?us-ascii?Q?qyG06oo60rUK+z4TH6xdiIoXt8hrcIMNDP3r6zvaX+RzgmgcnhNOTs2h7qur?=
 =?us-ascii?Q?lRdxkWxds1LG4MAUi7RPxnLRGpx9zS+x/7gOj+iryN6rHyJRy/WPQTE6UYgc?=
 =?us-ascii?Q?wQR169oFPPoKSsMgfmQp0hsYQBbmEI5vCtpZ2w90yNyQaAMvUNSqIoZEVRsN?=
 =?us-ascii?Q?AnCGRHJtV0DB98lBsTpslN1NU2KhSVqO/7QG/qerXtLdsNi7ZmHbpTRZ0J4V?=
 =?us-ascii?Q?xaUUI5mRG3kNU7We+vo2ucWTroirLv8QJzvXOd/VqJEHziYo6dVDr9FqIT2B?=
 =?us-ascii?Q?8hToO9inURk0REfgPoyE/nEAnSqhcEzDwwbd6AY8tbRmUSjTYYuFrL7fbhEQ?=
 =?us-ascii?Q?F7RgWBq6/PWVjLQPVU33t+kOGVnkWlqaWey0vtGInTtlTkQi2wiVQPDijlvh?=
 =?us-ascii?Q?Dor/6BSwtfuFFoRLiIuqFwkDczaWjNVhcF/oVPFJhgG6W6iVpzjuaEfk4shz?=
 =?us-ascii?Q?8e1flSu1Q9NXDkFVHrRlnXj5zraIf3JBu/Y3koj97a/oVJnPGUXsUYXxNCuG?=
 =?us-ascii?Q?g1QE6RkVGh7ADYYF6zLYKx8bidLRMf+hz3r2fT1lsS1cva9Qy+8U934N8tfX?=
 =?us-ascii?Q?l2uOfeYPlPiJGEPbzpbEebyjhuZHmMXseCgX93AFv0Ge/QAmtrhhHrFGf6di?=
 =?us-ascii?Q?VNN1MRJDF8DYX/jEuwqa7CXUl2VgoOF8Yu9nkxlc30nT2PJOK3sgdkTyJcgP?=
 =?us-ascii?Q?NabVnoGksM8KsATVmn9YAwrY5jpXFCOirpXu5A5rjYIcRoX74nrhiAVXwqan?=
 =?us-ascii?Q?3nKe0XulPIXYXV597Es4dlSDJaEfhIEF9jfNreV45XcHPMRj9xPlgyEV6VB0?=
 =?us-ascii?Q?JRgh1QjuaJnzIK76cK/bKRRD28BF2hSUbqTuZc85qk3EJ64QWvCG2/OdH3kp?=
 =?us-ascii?Q?UncwfrKW+hCWzxMTiELTBhjWAb8Qho/v41cVGTz+CGQG3B5oPJu+QEeIClRp?=
 =?us-ascii?Q?N14HTEttqiKn0MtSvp4ZXcCS15Xbgw5kZXQAHTqP?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bccf083-6bf6-476c-7c64-08dba51e66f5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 03:50:20.1637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gLPy2hIyS4el1iJOODJholN8Op/4vgQBlYv6yX0k6PLLHh4URNgxpXSOpTowt4wjNAr6X6pC7M3N7QcMPSfQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7091

This patch adds a new helper get_info_value(), using 'sed' command to
parse the value of the given item name in the line with the given keyword,
to make chk_mptcp_info() and pedit_action_pkts() more readable.

Also add another helper evts_get_info() to use get_info_value() to parse
the output of 'pm_nl_ctl events' command, to make the userpsace pm
selftests more readable.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee1f89a872b3..8540a1ba5ef2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1850,6 +1850,12 @@ chk_subflow_nr()
 	fi
 }
 
+# $1: get value of this info $2: keyword in this line
+get_info_value()
+{
+	grep "${2}" | sed -n 's/.*\('${1}':\)\([0-9a-f:.]*\).*$/\2/p;q'
+}
+
 chk_mptcp_info()
 {
 	local info1=$1
@@ -1862,10 +1868,8 @@ chk_mptcp_info()
 
 	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
-	       sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
-	       sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(ss -N $ns1 -inmHM | get_info_value "$info1" "$info1")
+	cnt2=$(ss -N $ns2 -inmHM | get_info_value "$info2" "$info2")
 	# 'ss' only display active connections and counters that are not 0.
 	[ -z "$cnt1" ] && cnt1=0
 	[ -z "$cnt2" ] && cnt2=0
@@ -2794,6 +2798,12 @@ backup_tests()
 	fi
 }
 
+# $1: info name ; $2: evts_ns ; $3: event type
+evts_get_info()
+{
+	cat "${2}" | get_info_value "${1}" "^type:${3:-1},"
+}
+
 LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
 LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 
@@ -2828,13 +2838,13 @@ verify_listener_events()
 		return
 	fi
 
-	type=$(grep "type:$e_type," $evt | sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
-	family=$(grep "type:$e_type," $evt | sed -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
-	sport=$(grep "type:$e_type," $evt | sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	type=$(evts_get_info type "$evt" "$e_type")
+	family=$(evts_get_info family "$evt" "$e_type")
+	sport=$(evts_get_info sport "$evt" "$e_type")
 	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		saddr=$(evts_get_info saddr6 "$evt" "$e_type")
 	else
-		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+		saddr=$(evts_get_info saddr4 "$evt" "$e_type")
 	fi
 
 	if [ $type ] && [ $type = $e_type ] &&
@@ -3229,8 +3239,7 @@ fastclose_tests()
 pedit_action_pkts()
 {
 	tc -n $ns2 -j -s action show action pedit index 100 | \
-		grep "packets" | \
-		sed 's/.*"packets":\([0-9]\+\),.*/\1/'
+		get_info_value \"packets\" packets
 }
 
 fail_tests()
-- 
2.35.3

