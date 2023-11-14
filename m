Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F344407
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="wya2eHO/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lqnz3Iqcziimm51VXaRgfhj/nQtcetCQUQ3Eos/QDL7ULGafEzYsLKUtAEzRTi/5FeElilnQNw6GH4Mmo59ZrDgO04h1SJqc/CkIzBaggLBvTFpoB3qhAn4OAl+QopmRnflD642eG0Wv56QBWhBodboz4HABbJUI5e7oay0RboezeV60DmHDBWHY/fv8EsFwszQZGg0EfCQx/x/0e/XOCp7swC8PVEFBZ/Is6zlqFwDMoFX2RCfjulrck6SeXbLCo1gRFXDgkacWkoyiTPyQLG19oL1nM/iODOr7MMXf6C57k/OU25rhGigS92Mz2P2uU9sAz//ZXNS99+YqwwL25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOedQMCJLoY0vY50UsLWLwEw9Hhz9n2QNv2Fy1tl0WM=;
 b=l3mEMCrNfHwVbJWwZZZTPNwE/0cJkkTKDc6T0XfrVrNPHyceQRO9cGuXaeEsWheFC+ohG0yy4bNsDLjJMFonwPnjD1XviJo+ivdPRuTackI4IOKRqmTAFEuZhy1Pw5PvaLg2giGkUQbw8JxkG/epRp1/ZaC/EQ2gwVQ9/KLCb1jMNX7D+QgxvSXjtKBe6lk8uPstjs2nT4jX1XNG303pCoj9k6iw8F0ODh05UNGafKSZs37zYpZUd3x1bmyYXZ/WUoJ4cLBdSmVlf07GBx4CBRzrWik9qsIeDrAkIzQTC4zFRLW+8UZMftmIcLnxpJ1nqogHDCHEQNGOtfyWt799TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOedQMCJLoY0vY50UsLWLwEw9Hhz9n2QNv2Fy1tl0WM=;
 b=wya2eHO/1QyBPerLNPhY0E7OcanbAtTVeEs3u76j10gszsikAPcEFQhgFVBMIvsi9iZmXMTiqrrmkFLi8579n5lFZeLGBHrYBh/Cdr7wCcZxsUaBPIs7onHTF4wthG5w74k3AGzeKCTb6dI2jBtapSbwTEWbxDKHJiqWE5jHwN9D6/qMXJ9BpHkkVUejnyBKaSczCyIF+hBhMee6zat2fuUvO2rI/RrpCsD02dwb4TU9vMv8QCX7TwNAiuP+3SM1cmPctYt7f3LuhcYcVoiJkzdrAJDI1HWzRZ09jtHLFWWjb6Ppm6kvJxQ+HzZwNMx6oGYPkL59t8CyM4Nqo96oFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:36:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:36:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 10/21] selftests: mptcp: add mptcp_lib_check helper
Date: Tue, 14 Nov 2023 14:35:07 +0800
Message-Id: <1aa2b3103c84bed5800c77d18e7ff8fd78ce034c.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0194.apcprd04.prod.outlook.com
 (2603:1096:4:14::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 326e4a06-ce16-4ad3-385f-08dbe4dc0fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X7AJjSV6+SrF7UtFvbL5fJlTnw/A/m9kLna/H4u8Kok9R8tg4d9oykvWV8pnQ2wD7ExybOsO5ilREiKnEnwpA03+O1NoWs6InU5NoNfN2HVKWISB9ESIDawaHyHXz6QdecSHKzn4p98NMN5fYPOb/o+VhMFp+2qK/12pxKQrAgBpOrNiQbbj0oPtPX8spZ0zRkHOzgRzyh2nDrWyKCUtuGrgZWDWiu1N6rGsy639DkqOgLYF1pVKoA84qR04hOCiy1DTTd5UjJmqqvLRIHSUeb8v2gnwjvhGlkvdG/H0CYZunTbn3eH+j8cpH3lvF7aXOrP3WueVo6lKPYsLZFdaV1Ld2oOtd6/7QyKRIt95Hnzf0ZuaRrpesy1knpfm47k6KfZDFggU3SynTnN6SJxdco9OsV5bvbsW5rzRmb1Dn5+7GDnOr4xbEKya+k8IB2Mrr8O/oApMWtsPlMzZ7AYZeiDO6lGJVZsWLAmbUXFaTEu7HRbZ/jghFcKLSmZcr4uJkwdBdup3B8d2/JHMx0yZZkuMPiea31MG8sZEd2peK9js5qD6rg8OevMkftVNNr0N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(83380400001)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LAAm2wFYkA8JPfpzuS/dtCFVw0tn8pV+/GXGocZqcPROcYNqZWMCkWl8RGtD?=
 =?us-ascii?Q?tJjzO5R6AUyyyRPWdFS7QiQ1f/nlS2p6pMF7eguWz7oMz/HT4+ZocQTEry74?=
 =?us-ascii?Q?prPWfZof6sUfz1oDayGIlIWtSXN3ysSox6oUauURnSi1+8yDE27tzdvHCO14?=
 =?us-ascii?Q?EYDLSVwGQMfsgZMY8Ae5q3eE2xt2womLjeatAPSQ6gjv/iAieFGwvxGwYbUm?=
 =?us-ascii?Q?fWHZVVrpg28KUnbq/FbE7YhF7Wa5F0KhBMpY0DKbnqD1ow/NOi4pjHkUODzU?=
 =?us-ascii?Q?efyepnfDgtci0ub37zImGJPm4gkrvU3+I2t2WxGfnwDBLvws/TUbWBiSFgm+?=
 =?us-ascii?Q?kYo6jGST13kCvMqBTC/pH7A4rEka51E2YWJtlTLdfzPkt3QmHpcAYjJjl7WZ?=
 =?us-ascii?Q?9rcp0IDy5ZJiF2c7RIJCns+aInQalJUA+cUYBBz0F/Rq9E5KbSOAh26z7NjV?=
 =?us-ascii?Q?Y/lqIqDSq/LwKbu4REQVW8d6K0UrWF6N2X3526sqI8WQpGZtRAqelZ6gsXRX?=
 =?us-ascii?Q?Kd2UU38tte3DUjn45eOFnARONq6RyWILCzHrIHML9CiC7PFKvHJne29l6jKa?=
 =?us-ascii?Q?z44X6MI2xSYQ3qs3wURFjoFysqSJCtLSh7aAearDn/zzJNEp538ITw9IDbCz?=
 =?us-ascii?Q?mnttGa9Lco/PtH/IAXOWSXIW5TkOsqHFikonDHfBpSlMJZDB974Uaf5GxeN6?=
 =?us-ascii?Q?HhZ7KxQnLZVdQbiq/6zXPbISJZq0UH2Smt+3zPgP62/UcPtWgh5V6RgYo7CX?=
 =?us-ascii?Q?PY2t7lo5QEuG+/eQ0UaAVOb0ZwIHZAXuvDuPB6D8hfoLdlQ7ZemLSlgPhRYt?=
 =?us-ascii?Q?KzonjPtoM2K8yP4g8MIBUNKoN2cdlxakWdedc4FGyr7jXcq1Klb/H1W2VZmB?=
 =?us-ascii?Q?Lmbx3Wi1nWRbiiJp7GgHoROJ4I2+hsnELeOh1I8dAN8rKXL4KijuPE13Y+4Y?=
 =?us-ascii?Q?GcVaJ/vxZ+xdC7NxVhAClKYkBr9wAbaVcbNK6k1gqpUAgbcfdthz45wssEDf?=
 =?us-ascii?Q?RvHQFOAjtW0gt11rFnkau/kXy/3H5P2lenSTqmtFTgwWUVXUtabZfd1Ig5bx?=
 =?us-ascii?Q?na3BXBAU75wwi/u9nOOdRkHx/sFFkhSDO9+dKjJ6yc+Nyr8sq0Rpb/Tk5x8N?=
 =?us-ascii?Q?BZNiNSb08HerGmHTssVY2BPXZQZbMRkNU1V5wDzI6si0QS3bOKFz6RdMPKzw?=
 =?us-ascii?Q?yH2cCINbuqe9Pb1laPvthQUCLgXKrpJG9KDqzsgl2zeUevJdb50HbhLDG45a?=
 =?us-ascii?Q?RfCbM9qGDLhJIRsjAjh4t38IdLqTsyLkqGvYZwtz3d9b7kj4qt5fXOsGOwwH?=
 =?us-ascii?Q?IBSK/R6GFWxaqSNMlczBvPjNCzoOJqnSgTtpPsR+ggUwfTA2hXKqAOulkLGU?=
 =?us-ascii?Q?keGLK9nT6HFbM2v4TFr+2YugtcrgDvIn1/dUcXXsZNDnxnJGza4cXhSClSo3?=
 =?us-ascii?Q?+nSs4XcjqasyeK/fhEGQAhDOA2dDKS22RzMcJu333U8dOpdsxVkZnd6In4bu?=
 =?us-ascii?Q?Dt7RrVXO/ihlh9Jizqfn4dzjFa0tuPr6fCk7I9tJZU003EdCuWGOSUWlStNK?=
 =?us-ascii?Q?q1W/c6ujJZsL2YnYipnQpfA+l5l6yP8amce8kcFMCVZ/+8LZ8yI5ZVaLUMTm?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326e4a06-ce16-4ad3-385f-08dbe4dc0fcc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:36:41.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6XFaYQZ0It1NWKdJ7OO5Y5mvjm9JpoYlTL27iCFt2M1o00yW8Ev09GN9kmK7nZzHKwZDwbbeA/I38WD3VVsGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

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
index cbaa55ab89b1..466fde97d3f4 100644
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
+		mptcp_lib_print_err "[FAIL] command execution '$cmd' stderr "
+		cat $mptcp_lib_err
+		ret=1
+		return $cmd_ret
+	elif [ "$out" = "$expected" ]; then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	else
+		mptcp_lib_print_err "[FAIL] expected '$expected' got '$out'"
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

