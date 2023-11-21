Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103823C077
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aFc1VGXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABzJNTfrLpK7oZWAifrJlHQ5Vp0XvgKGcCOVOWetoShSJUbWPfaf0QZnY0DV/Zg5hqnzMcOxweeBkQnLsh6W0H9exc+iGkDmiDLcj+HpHvczkVaT2eySRJNeWJk9hqiYJHeaT3nm+IFWbhMQtt5KZVNb2mwy7MMZqz/It3omJI+jC2e8XsbaP2wIlHiXZbNinORkCCkOh6Uo8IUyLVrnZcAiDuy9/h2HzZHPo1wdLRWRI6g3kFYqsiSCdcYbTQM15nj9UAQwEIRRO0zqLRtyXKMP/UHi911W5xzAQvO6AVOC8d0DQkZ7knGwmDTlEQUYqYythVqLF4u4SJkZwZxXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MCqP+9ev3Zn9Zhu2iFrljXS/zRzUA1qKs+uUfko21U=;
 b=K8oWkxJk75G0GBHSC2Rf/tiQlluVihO7aAfYsHw7eshEb3q4uHfkvZvVOJJmIBFiVVmcME8tghWXV8KM1aM8d+Sut8QguckxRV7lTeM6D8POEiTEMpED/Rx7DB2lu27zhxVZfSXCDFRn2EOiEHuZi9Fe0QSawCOG/5tLa/mrAtgulAcjn+Itl71o3EayyOlu0RISuRUp2tAohZjTjaneBn5c7esIKvSv8GXNDaFAzlRmF61RCbT6MX42Mor5u377kUVkekycYSpSv4mp46PNfYmcdoqUKP5553i4xo5TuNJ23OlNBvROzfLoAnjttq6kAj1USRADFckQrb4wUlih4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MCqP+9ev3Zn9Zhu2iFrljXS/zRzUA1qKs+uUfko21U=;
 b=aFc1VGXWFXAXeESGxfANPwTP2Iqse5UeBBewtiyQ+un2KZpJK+0qgzXM2AXbTogrYMkQ1evs4Wix1JqKtwKNnXnLeUghahXrggVHjjxDw7PYwtfWdXLTxGWfWSecOHevEEifr8s+Hz97d1rhs8dyOkpSV2oU30mIzsFMa0j4dqzgJckkqZkhTyml4ywBgIpmrqAYfXc8ocSiJj3eoEqJ0c0rm9F/7U3YiaONEJg+ODxccW8B8rAL8MpK6Y2PZZuqTmjuRloBWj5+BYDd+uos40+IGFVNwjSwLkFFjlj0hmv3/E/mcAPGyte4AW+xlvEPxfEgo46Mzyci9LeplO42PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:54:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:54:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 10/28] selftests: mptcp: add mptcp_lib_check helper
Date: Tue, 21 Nov 2023 17:52:33 +0800
Message-Id: <a90248abbbe1ca43a73c5cafda4398b804964723.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 2450bcaa-16e9-4513-7bc1-08dbea77dd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T4mGAjFDZLmIrlxhhGUIPoMHTuEWzJ2pUr89+I2joQVKi2q4LMwOOXHNrsnE73v2ZxMHAFJHuJE4e63jfYXDQIOySe9Cnh/cXnCDQ2NS7p0hT/RYzXf4bmeJvSiRUpJ20iQcpeG6MfUPzM6VO9WWCCE8okVRM45ARz6ZHVMhmd1aV6zcmoHONKjoVckBlibFnZcy+kCi55EEYDvxkpKTAADZX/8InV3GDeHufJVhEgcVJD9eqbV8sL1lwLS45aqgcxewdTeaqX4saRhwduhpAYnP1NT/En6JHvz2vPJBRtoFWkonM3kjILoVUslDC1JCvCCs/qovjrJcIda0mayvwbOurLN6FDWlex/AlLGQ4hZoZQUVa7Bumo8I9Wsp10Zcc359OzhFjzbD9FoBo+MbVVzNjVIdGZs8H0EJFXfovsyGxCBYLGGgszN6ugsJVSTXfom/M14qpI5uy0bCOYQSD/dkdZatujVjp1YGnY3mRxVUS3YsWy0i5bLjsQ6DtvtugKPzMb4S3jUhEuY6HqDbfB0iTYKPPq/eueFYjc2Fn2GgXW9C4yC9qoxecG4EkMpB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(83380400001)(86362001)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pR56fH0VvfPtj8nj+arHuosjcnpwRx72cRx3yfFxnPSAGSJQECzmFFHX4BDP?=
 =?us-ascii?Q?MKDYTOb7So5NxTnRkDpxF6gnLy1Mrs1DiSKLzPfnNBKv/ta8CZnbaiOKJkyx?=
 =?us-ascii?Q?KMQSyeMf4Xy0cIH3ub/d6EiqI/5g4H/8B5ms1tyiKaWl2Xl7yEFm9QTPSJ/X?=
 =?us-ascii?Q?dG5hofiJdGYcF9k5ycLU0skquPHVQ+c6IeQrSNIXEb1pX/4Gq94GmNKYU+D7?=
 =?us-ascii?Q?DydRksZlFqpEjK3BcMyXhtLy7L1MqIS+iqn9MYep6qMxhr6avnmL/TGut30+?=
 =?us-ascii?Q?0Uac3AdLl5FvX36VP6WDaAFHKez10MlaOmU1QzI7YPSLYzJNtcT4PPliZqFp?=
 =?us-ascii?Q?wMrfAjw1S6muR+EHhHN4DkPc9ZRF7tMsGqRRzpAJj79+eoERaA9qqF40YriK?=
 =?us-ascii?Q?g8s4n5GUqb7UJGELFOtfYG8sAR8ZH/hdHrgC3O+IO5XBiDDYS0Pj+Zby/tuQ?=
 =?us-ascii?Q?LIdXf6qiRPnpdh03OXlSF9NY2NG0hOPkNoC4g0GO7g/7zt2HCE4ksG0RZ9lP?=
 =?us-ascii?Q?bj6rFGE8iqOiXDrKAN02is3SeF0h6LS4/S3Wyv/kVR7hiO1P1Gy0ImnJJbR9?=
 =?us-ascii?Q?/aP49UYFMAaLYZ5jRVBldCdSxOoeo2uvb4jc3pMVw4ED9M2V8P3ZHFY4gzqv?=
 =?us-ascii?Q?oEaxx0hGYVdfTCWQOMMwq4NCvc2ZAwSj9lne+w1/zpwdkyiA+Vp/dxTejzOe?=
 =?us-ascii?Q?UAeJ8XaOsbDI9CDDsFT2SEgWmcd2eM3FtN1ohZY3Kw5xrWnSnGkkU9TE4pFV?=
 =?us-ascii?Q?J/Z39OttB4DRW/KoA7zqmFLhzUeTpp9iNyQsg1zWBJM0E3yx9CGc7Yk8m/tK?=
 =?us-ascii?Q?sDH8moH9oHc7Cl9knNU3ZeUX5zOQzL33TJ1cqWAXv6DEbRM2KBrT7k71Nx3R?=
 =?us-ascii?Q?kGMOx3gAx3n3fF49N74Pvm4KNxK2HHfkOIc0B3omU4RNjlvjSKS4Q6k+MF5y?=
 =?us-ascii?Q?qs0rlKhWFmRAvZugb8xztkODLKgGwvM8ZtzGZK9hyidLu0jtBc0y0VGAVA4G?=
 =?us-ascii?Q?3wmGnei5RIgj8vHph726bXrovSqmVAhNxdkgrKItvarATHbLWTI5Ppl/2ecs?=
 =?us-ascii?Q?wbXkK2nGplaDTPwWSKzO8KSJKyn7ZF353rzb1zlwTGFxqvIFocnlE/5TwdT0?=
 =?us-ascii?Q?chhOOIfyY1amwjV7y5zmuMUiAWx6RRjaZvljwi1Ux2KS/n9XLZqSDH8BIDJE?=
 =?us-ascii?Q?cuCHzAEmr30AyqLkFutvdUT944MqZG3PtWkuyhA3SlRy5PgQaNsCZC0RAOYu?=
 =?us-ascii?Q?1LZi3wbKVWDE5K3iJQxOb7OhfBckBFaVE6qxdJSEhtkxxPegEdmMpANbDZWg?=
 =?us-ascii?Q?bXDX1rxZBm3s2/vSenLmKl33YhtndgbnooPiVkwGwdAhYCpq3DrW9EDgzu21?=
 =?us-ascii?Q?ushhixoFZWVccp3PIRLpRP3tUIJtCJhZjqR5FiavgdaAsRuDpTzlxEVg8Ujy?=
 =?us-ascii?Q?g1uqVB3d5pY+MQhbr6ObmFk0IuZ46h2kpP1Lf8L3DSHy8+RZTc+wYdovZ1aS?=
 =?us-ascii?Q?1Z+OoiYa+6eAVnBMjdKcvsmxm7WZ0aDjEVx+7zRv/tRcsPuG7lCDVBFHqz4A?=
 =?us-ascii?Q?wJLmrzbtaB1iXX6TOL9zveFdj+vuOV/gpZ+exMynWvYKLA5DtDb8rcF3L07J?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2450bcaa-16e9-4513-7bc1-08dbea77dd3b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:54:34.1315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9X1UvaSRKiZ07pa0Gmpy1WoQfT/L+ifh24f0IKxUqpdKoXzGN10jM/vA9FGpI+l6e93XfdaTA4P2Td8jeaLmxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

Extract the main part of check() in pm_netlink.sh to a new function
mptcp_lib_check() in mptcp_lib.sh. And use mptcp_lib_print_ok() and
_err() in it to print test results with colors.

This helper will be used in mptcp_john.sh later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 27 +++++++++++++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh | 29 +++++--------------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index cbaa55ab89b1..39bdfc6621d2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -300,7 +300,34 @@ mptcp_lib_wait_local_port_listen() {
 	done
 }
 
+mptcp_lib_err=$(mktemp)
+
+mptcp_lib_check()
+{
+	local cmd="$1"
+	local expected="$2"
+	local msg="$3"
+	local out=`$cmd 2>$mptcp_lib_err`
+	local cmd_ret=$?
+
+	printf "%-42s" "$msg"
+	if [ $cmd_ret -ne 0 ]; then
+		mptcp_lib_print_err "[ FAIL ] command execution '$cmd' stderr "
+		cat $mptcp_lib_err
+		ret=1
+		return $cmd_ret
+	elif [ "$out" = "$expected" ]; then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	else
+		mptcp_lib_print_err "[ FAIL ] expected '$expected' got '$out'"
+		ret=1
+		return 1
+	fi
+}
+
 mptcp_lib_cleanup()
 {
 	echo "cleanup"
+	rm -f $mptcp_lib_err
 }
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index fd413b4c8123..8d30d4a1db57 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -27,12 +27,10 @@ done
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
-err=$(mktemp)
 ret=0
 
 cleanup()
 {
-	rm -f $err
 	ip netns del $ns1
 	mptcp_lib_cleanup
 }
@@ -53,26 +51,15 @@ ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
-	local cmd="$1"
-	local expected="$2"
-	local msg="$3"
-	local out=`$cmd 2>$err`
-	local cmd_ret=$?
-
-	printf "%-50s" "$msg"
-	if [ $cmd_ret -ne 0 ]; then
-		echo "[FAIL] command execution '$cmd' stderr "
-		cat $err
-		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
-		ret=1
-	elif [ "$out" = "$expected" ]; then
-		echo "[ OK ]"
-		mptcp_lib_result_pass "${msg}"
+	# ${*} doesn't work here since there're spaces in some arguments.
+	mptcp_lib_check "${1}" "${2}" "${3}"
+	local rc=$?
+	if [ ${rc} -eq 0 ]; then
+		mptcp_lib_result_pass "${3}"
+	elif [ ${rc} -eq 1 ]; then
+		mptcp_lib_result_fail "${3} # different output"
 	else
-		echo -n "[FAIL] "
-		echo "expected '$expected' got '$out'"
-		mptcp_lib_result_fail "${msg} # different output"
-		ret=1
+		mptcp_lib_result_fail "${3} # error ${rc}"
 	fi
 }
 
-- 
2.35.3

