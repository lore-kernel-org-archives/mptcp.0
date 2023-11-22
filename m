Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5433A4AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZtIxfVW+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDxHaqwJxX0YWkXBzCEVpJGZDJbXBFZjNTJUGuEpb+BxzvBMUaqIeWfT1SBp/rhZLpoLhW9pyrG6cXQEPjeCUXvo98JS/M5wO3cZPwXJtgBj/Q/eSAqYTvZ2tB9vhG7HzxKUNX5SL1o1kZK2UVS58kAIGS/nm5T1nMyQN2/3lxb7+AGXU0TY320KUzPWLOlM3twr8RWqiF3ojQD0SmlIejlQZoqdtwQrszdGcFUzOno9qvhjCckPLBoIJXnU3Sn3uOml6B0MJub75qnhbDUCxaV8ei88OQ2RSkdNlHo1UTLROCaUfmMqBSq6ySdQIhl0gqNjcS2V2pRoYruEkrfHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oJUm5/XW5RWrBTHLH6gmLAnZQOlxQLI41btQj7K25c=;
 b=heXPwMj3Dj8dd8CB4p4fym36tnDX6m5e9JS//xexNE+cmANVYng2mdpTq05dCUVk/mPj31CGn2jwyJNsp7/73stTkbSv6KQ1UcZZmjLfBGuK2ylFONa6OmPQTcf248KU4yWJquSMDWUrbTF7NCBjpbEolUuOnTX0/GD6OeOTSlE2ZT2g0uJDTCGDBCaXIt9S7D+JTUGBsD6wBEgm7gUdHxcHiKsMuSuBBbb+CCDnQb5PlVEnpYP/8yuKGTa2yJKP/57xPfaA80qhHhZNIbqK1oZy1p6Uu41KUxT28rII0hIDtMOJxAx/WpBkBOWN4DDYXlEc0cnJVurH+ifMm8oXhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oJUm5/XW5RWrBTHLH6gmLAnZQOlxQLI41btQj7K25c=;
 b=ZtIxfVW+5p3ff3Xx24yXrlDoRpKg+4rt9IIxPq9nPDsHom7e3etQRFccaq7vukBb+qK48GyLlmcI0oAdopXwWia+s7jPcv6NH+hfCeJH/PtViLinROuh0K4QjNYJ4QLqFxTn8N974z/C4r6ht5Mgef62MjFSJeuJzJcbjt6kSjsDbyxi+48ACDCuaNwbMpl6RSR9rb05l+w1G7mfQ5lXeLioi3dbMqfgAm5U73Hlbq9CoqpQpX93JiZUkdQr/rlCKcWbO4w4z5ec1tj6cn0A7EIQSHvmK+uF0c7Q5wgrVkYG9O3xshgHQ65nvdB5ni7Mz1au2aWsisQQMj23XnOxZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:31:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:31:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v4 03/33] selftests: mptcp: userspace: print colored output
Date: Wed, 22 Nov 2023 19:30:51 +0800
Message-Id: <82489cd44a1cfdae0e12d1c08008c65ed55ff0a5.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0024.jpnprd01.prod.outlook.com (2603:1096:405::36)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 57385423-a2f0-4526-32f4-08dbeb4e924c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8bWtfI14y2XAr4Eb9v8cXqTGx8JSbxwuWK6MVxu0ULV/9UAEbG/4KA4MQA1UZp7JJSRx76CXYwbNGl7t9xyBDaKIUh9R0F44DgxFetO2LXINhtg3h+PyCwtysrs8BDls/uTqu+TQcXp29zDNWnq1SK8T+wajYxMu1pVcm0zmgy7enOGopykp5X1gk996Y07w26P56HQbgaBaG/h7zIdHwpV3z5/nNx/c7Nzsi5InshMk94jCuNNjivCzeDbMXQ9zEMevMZ24Xpvuf7hgQ+GRPPBpuq3YjYlldcJzdwtIrmobbOb/HSa7+bXYtdWDnOm7uWW84yOaDjVseVonLR8IlB7ZX2Yym1jB1wo5kA1TCJTsL840u17i8lIfGtAnkAcEOUAtxt2aMSPczQ9kbRb0Bsp3rkJhMYWUMX8EIPIQj3Kw+VrdmcbtckTP+6T+wOl5t1w3ygqNaMntl1CIozSFqM6XAkOBDNoeFoOr5wsG0I6ePymYhJoJ6OSdT5otusmKuueHf+u5vojtb1EIEs/7riHEypbuuqAOaAhfQP6Li/gJAEopBbpHpLH++uB8EwbeK5mc6T3UFbL88nJyKjLISxIDY42J4+5nQ7bNU+uPVWY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(26005)(6512007)(6666004)(316002)(6486002)(478600001)(83380400001)(66556008)(6916009)(66946007)(66476007)(54906003)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z/wSa4CyFL0Zn7OekfebG0jfvuOksb/s39/TxuKWv4B8WWA5NHzZwteaym21?=
 =?us-ascii?Q?AmLzphdnUtstQ7izU6l2Tdy7OknKVeMXI1J1ENDrpCMP3gtICresGqs2Xbvm?=
 =?us-ascii?Q?oO/DphJwYW43rR8CgSxwIKNmU9qyDg1hp4liYfoKSladPZRXMb8GAUZFKXDw?=
 =?us-ascii?Q?/qW9QnWFaIHosG62aJDVmTU6nc7+3om1v2MiOqjOzb9zAMbQwZNs1OnHUYTm?=
 =?us-ascii?Q?6qAXIV7pEgIecwY9dwiRyYFHfgDgiH2SnbG3OOe5FuG5JSCKBLAz3uT9auHN?=
 =?us-ascii?Q?HEMrdL9T20tsvAco419B5TqtBjFCOoSUriHnLqeTicOob5IfqAp28by+Xi4r?=
 =?us-ascii?Q?B9nea4NlbWtlRZL/5oQw2TyHOCitOof0qT2avh8KSOwZPleaoSt92VVtYVgQ?=
 =?us-ascii?Q?bGKsgQfeGExuI+CzRMM1rOyyMJXgFQDHSvWOL2rzXtAYLQxSaL9n94GMWHVc?=
 =?us-ascii?Q?Qd+jgGXXICnZO4cD1vX3rkPcOFklhm+hzwtO+re9pgrKPbFCH+waRtALDeD3?=
 =?us-ascii?Q?LTB4oHMiimvwugw3V/1vdOxe3VuQvqOS6S07WVkPLakY9KUSL1v9eEbnUr0V?=
 =?us-ascii?Q?fRPwqrhbL0QtaukEjDTX0J7M3ZnMTr3JNL3SoXOQcT4S60eLBq0mWLMMu1Hp?=
 =?us-ascii?Q?REKY5r2ZpLorhwMaGbZy8I4EDFdU1KwDVdQRvDYUISk7QvvMPkLiLvRqxB29?=
 =?us-ascii?Q?7Javpaor08YOdlMkv4TaqQWuLmnPl8xdbHQezHgD2Q9gRonG2rDZcln2/d5e?=
 =?us-ascii?Q?P2XaTNYN1p8m4TJN/Fyllcf6mcoxqJZz8ewiO7OKzEtTlHfjvQAXGxmfy+b7?=
 =?us-ascii?Q?WB58jfbU9SZwyYoBKP9BrsVuTSLlwfyATCNc0pg26m4tRF6jz6zUwpFwEx0z?=
 =?us-ascii?Q?xd4dTk889t8WrccM9Vtp6Jw9fdVW56/W8j895vpYUKKB4oDpmA6yp2eABdTx?=
 =?us-ascii?Q?oQD10vr4lQb+wTEEdth33y7uguU82jGx7qtwFzDYAN/aAmwfKOdtlV0Hu0Ot?=
 =?us-ascii?Q?wXfNUod0cvSmy02fEvURi3Fy1SevX2JpseWByFiyXVPR4LrhfuXozJAPcLvi?=
 =?us-ascii?Q?zdva8PTWbCWoAEhUkLxuleUPFtAyM1u369NvHE4KDnrHOGwdD39I9BSyyOJV?=
 =?us-ascii?Q?62dNs6xBC2fWu6uQGX8UV+c2ebmv/mj8q5/YricXIIweEVx/ytBackJko/LB?=
 =?us-ascii?Q?tvolrm3GE17oIXuijSz391rph2JDZ6SzPKS35wDfXmis16TwhUmeL0B29+fO?=
 =?us-ascii?Q?Qmdo8gv8aLt8oM2AORMtVYTAsGnvAtWGKlo0QTB0vTUR98C8cnT0ou/dYseO?=
 =?us-ascii?Q?VMTr9IvMYgtIAJ4kzEfQrK15KS1+gACPTDdpyAahHbjYyZPl1b3b9rHpXdMQ?=
 =?us-ascii?Q?nYUtDbVWkWQ9ZfVG2wzQz8K8gZQNm/fWFGViln/kHSnUjqOmrzP6NoRMUEsY?=
 =?us-ascii?Q?Cqx0w71/rMdvEuV3fK2DeHKpJcGRKY3BhD2rhicHKxx44D1ck7kLhqIuKjWn?=
 =?us-ascii?Q?12NoVcoa9hADznzIi1lTr2mYY26uIhXWUpW14ueHwlWYH85ZRutoAxvXmmyG?=
 =?us-ascii?Q?zld/12S6pLF01w6R2uWOZXsyY9hMA/P9AJL2wyYp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57385423-a2f0-4526-32f4-08dbeb4e924c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:31:30.1121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kBluNWX2t9C/dUxVj5nUaWY9iS590VqpcRYEabKc7d3DLGUyFtJax5MdebSSnwveNntEbUdofpbkcApXCgQfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

The helper mptcp_lib_verify_listener_events() will be added latter in
mptcp_lib.sh, and be used by mptcp_join.sh and userspace_pm.sh. The
former prints colored output while the latter is not. It makes sense
to unify them.

Use mptcp_lib_print_ok(), _warn() and _err() to instead print_results()
in test_pass(), _skip() and _fail(), and use mptcp_lib_print_info() to
instead _printf() in print_title() to print test results with colors
in userspace_pm.sh.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f1d5cd4ab95a..c60143133277 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -63,7 +63,7 @@ _printf() {
 
 print_title()
 {
-	_printf "INFO: %s\n" "${1}"
+	mptcp_lib_print_info "INFO: ${1}"
 }
 
 # $1: test name
@@ -74,27 +74,22 @@ print_test()
 	_printf "%-63s" "${TEST_NAME}"
 }
 
-print_results()
-{
-	_printf "[%s]\n" "${1}"
-}
-
 test_pass()
 {
-	print_results " OK "
+	mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
 	mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_skip()
 {
-	print_results "SKIP"
+	mptcp_lib_print_warn "[ SKIP ]${1:+ ${*}}"
 	mptcp_lib_result_skip "${TEST_NAME}"
 }
 
 # $1: msg
 test_fail()
 {
-	print_results "FAIL"
+	mptcp_lib_print_err "[ FAIL ]${1:+ ${*}}"
 	ret=1
 
 	if [ -n "${1}" ]; then
-- 
2.35.3

