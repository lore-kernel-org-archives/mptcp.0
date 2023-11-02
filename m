Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882AA125DE
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jUEmPxPV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSQ7rMtN4jfUBHHODIKDBgU07rfWJSFzH/fAOReie+LUXUK8qsV51YWsvUJZHb4kWCb74LWz18MqIcT2YBsQwUbQUfThmrwGDTE8hyiiMOwPumWPxWN/gi/rduDn/i41t4FjZT+qv47gWlHWCkzBD+3klQNPUm+02t9CwHdiwXeu83+P6Zn+mHLqWDpN6GGVzWEi4njmgjtXTAsirro6yYorryvXHt/oEBzTnmD/EapWwQYmeq5ET7RHkqJFnXfWbpNlSp2abkpfMRwTP/MWMdyMLI6/gpDyMLGHG3Fj4+a0YQLGv+lGJeNBVBn2mNkmN77LHr+Bwr9d1p9vtz8Iqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWIUFNR1l7bMsjwD4+3xAQdhrTrMhLH+LZ6pTPHZX/0=;
 b=jZTBFuFKbVGBBAf9094+kk1u0ndEdpUnMmQJQVnqqvc9fvKjNNwAPRbcBpIT9YQiNma/TH7lrwdRGB5rAam+RCqPEJhTRQYfr1t3o2k/OysJ/ZKfibs4gHsnh4ubBcwyjSCmbaynag7excaqQ9v4BOtnX25ZwL2UhrWFd+UW41aGa+sGza5dvPtfHzpl9SFzPBh3NEfJWci1Cg5TqRl/ktlcOHyVzUq7DUO2bxBFW1F6kZlrpenbLTiJjFL79AYTxWkj+1WK9As5O+LZueG3oSTWHLdZ8SNOfPQCvM2DQrMRVf6wlXZqm48MiTdnJm39OfLLtI/Uyzd1IucBYj715Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWIUFNR1l7bMsjwD4+3xAQdhrTrMhLH+LZ6pTPHZX/0=;
 b=jUEmPxPVqZd3+5D9fMr2K/V2sCL8cC3yLN/rIEpVBBK+mpI1kQmYvCYzvRu3m9KJKK+EchlUNRltrMhwwOq8jwoEeAniJ+YT60ZQKFudRRfh12jdHh3n1k1r7i+/RBftNXCwg+nCYKvIKDIHWfszH6kpN6IbJAcj9NH63iwd+tGjMtPGqU7+97QO3PbC3sV46ia1wHUaVzA1qvhn6ho+28yogZPkb+KUHk8PWS1ea4S6L7w4+oRS1c0k1i2P3QjA0R+Gi1wDiatmutVVerP1ytYCA2L+xovF6FtNelJzezM5SNPDPal155tpdAdOQZ8pU2PKWpvfh3K/FiOGpSrzuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7686.eurprd04.prod.outlook.com (2603:10a6:20b:290::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Thu, 2 Nov
 2023 10:06:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 10:06:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 2/6] selftests: mptcp: userspace: print colored results
Date: Thu,  2 Nov 2023 18:05:53 +0800
Message-Id: <c4ab687c91a7e6f4774beaa85cdb702117e3d790.1698919435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698919435.git.geliang.tang@suse.com>
References: <cover.1698919435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: b1725203-31f3-456f-9d00-08dbdb8b529c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z35TC14JajuRt4HiRzXL2T/NBMuivNuz+QiyzWfbLbx6nCfLofOv3S/gKjpEH+QR38MLYZklhGvzSRE3yyunYezLWVhAGXgQJtrx9fZpL6BGTW0j1MSlj2EBqbkkCRw1c3Z15jcDdpiFDXGcM3i3gpuA3Z3ViENwM39EM120zbIIixJVFlu5CxGUVzviLQEeTF6gEo8yw1idS1wkPCsnyc+X0riZHoeeqZzWW0JTteciDEJyG+MRpnwoTzsK2byttkIcXHzTWVbc74089NtbJL3fCGqTbbsX/rABSn2z1tKZUmCpCr1NvK1I03Xpp/rWjURdbjpo8niykCdbghS1rTtfQK7nnU2xi5j5CEDoZcHidUCvJRCV4/pGaUSDIfvt/zlcDf7Nk1Y+0fC82O6K4TtKgxj47B6HB95ovgVqK7MrOASWMWNKPIrtF1bch1h6XWTerdgOJz7ukAIsOsfcdDVJoH99/ETvpXkxNCMO0m7pLr5cfBD/j2hdCCQhq/9XO4cJ6vtog5zvf1EExHertJgTSj/K2pokfhYcbVQ/ZXg1U9tpV7hFP4MuOnIw7U7YsFkgVc3d4glbzFUaufYo3AqWtIt3gJmvcSLb6sO8rVY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(5660300002)(316002)(66946007)(54906003)(66556008)(6916009)(6512007)(66476007)(8936002)(8676002)(44832011)(41300700001)(4326008)(6486002)(2906002)(478600001)(86362001)(6506007)(6666004)(36756003)(2616005)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EZlOzVsHrWy1zd5pXiaL46k+M+5O8v3LlTskmqbVjBwDw1ROU3gQAtwLELO4?=
 =?us-ascii?Q?KC+ft3gU+vnojCWWXuI/RxZ8yqcKaMJuKSRYNd16oQSlETugU4u7SIn8V1QH?=
 =?us-ascii?Q?JTF8Oqq3Dym5CmrEGHW2iVsDGadABAn+Ju7LZkkvXAEojrNeELKkHqII5vsI?=
 =?us-ascii?Q?UfmDVZj6YW6KpNbALpiHAbP5pjoRU1rRGhtBZbLo4N/bjs1zdIl0RBDJh4ia?=
 =?us-ascii?Q?H8q1PPD+AJahamWfz0ddMmnwWC8MnPtcSiXMMeotTujkrASqfoocSxc6GNqX?=
 =?us-ascii?Q?NQdE9TMKVbHAZNFagVSu+NE9k4/DgF/z3tuqcEctkSaZLZXDuURrIhIBqFpU?=
 =?us-ascii?Q?cSCcJHGmqpdyT5CzlOaKyvtEbqJZ1O47f2bC0t5CX9XO7eHVRfinTXHxJwTi?=
 =?us-ascii?Q?Md7Y1p4js6/oNpnNOwa9pmt6fRBkno4Kn/xHFRRR6/HRfZbC2PtArx+c2F48?=
 =?us-ascii?Q?P21jUHksP6oLIqlYAHxJL8ORDIWviI6g2GZSIBTmmlsLgvxlSe2eeH4rVmlU?=
 =?us-ascii?Q?eIUzxTccZGM2ZGjnM5wDqDq5ppgGEuuzY8uMxe0xbe80USYKJH8orKc7xs24?=
 =?us-ascii?Q?fSTPHl2Q+C6KCXQvG+OB/Y3sqsdchx98P9xufm8KV/NvAcUWmcbvFKPwdyIC?=
 =?us-ascii?Q?VJSYN/QubbM//XhkieVq2HAOzVsjIzQnPAo+0pRIqmj4JS3zZZmF042eGrh3?=
 =?us-ascii?Q?UROzn4ZGnJGIk9g6GFvahAudlnOsjk/XUiX3NHABClH5QQQrVhywEDxoeGZ9?=
 =?us-ascii?Q?GalZf8Nt9gm/zORQPqUUySyIuR2drIFzbMjL32drOdPcT51o648Hn0dwdyoY?=
 =?us-ascii?Q?vfVTa3EDxk1mf6wWe4zWC3K9/ZxziVMpUBIVB4gXVIEf/RLfW5mI3TgOsaat?=
 =?us-ascii?Q?EmBgoR46x8nY3divlth8Dcuk2+T0UcMaRVr2wNT2q3tnyncocad2R7F9P0ZJ?=
 =?us-ascii?Q?XKou9US4EKZkKVRKIZLsQStrCei+xcteMj2BtULNfFVr7bH8zDsOqNT114Fu?=
 =?us-ascii?Q?AqH3DCCS9Iq4ty4uWbiUtNZTFwGMfjcepTyTqUjY/EkLr6KfLjySvqgFb0iq?=
 =?us-ascii?Q?BvqIhQSuqk0LQb9FTW09YgJxS9X2AeI18IQhhfUxlDIPkyn+k355hKDSoFPe?=
 =?us-ascii?Q?FVZdQXm4/2rC3VMFcI2P76/3yy9FtYsMARhvq0QDpis4BYgD+tXOlNPIiDB9?=
 =?us-ascii?Q?fqGlTQ9Jc/yy0BvhDBHx/Z0UaOQOTfEqaCX4xdSoKYmc8VZ7Ymy71yUgrmbv?=
 =?us-ascii?Q?oCSuluxhYlxbRWtEWHayUZHePaolXtan/K2xfpE0lNjMN9u7VxkQxBlUe3QW?=
 =?us-ascii?Q?Me8Lvp7hQU/AEQGceZo6gAryJIcT6jwZPkZ8PbdIoIaECiFnjvSk0gMR8DYv?=
 =?us-ascii?Q?SohBsP38FwMpSAw/oxw+YWj1CQxCQtsfoZpBPT0MnUN6Dohm+egKEQxQLcGC?=
 =?us-ascii?Q?XNB16FnfnFCCA2jta2gv20R/CRcp9q5rH6HvXu3Utmi2Fo9oUDEPmlS/CuAn?=
 =?us-ascii?Q?wBUAB/CcvtNnZ3mW/fwvIZyN8o/AF4QHayj9DLEWXemCZPkXfMxKrGFgb1f8?=
 =?us-ascii?Q?366JS0U9HRhIzhp5nM9G4+t8ymLShFVEOwHAnRDmfgFEtZ1PDNtnNXDe9qu9?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1725203-31f3-456f-9d00-08dbdb8b529c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:06:03.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmGr83HCVYQXYTXsGvk4TdGzBRxZhFs/j/MrShAqaNy0usFEh4XG962kyl5QgIKORX3Sy/8MhIXhq7+NKi6kQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7686

Use mptcp_lib_print_ok(), _warn() and _err() to instead print_results()
in test_pass(), _skip() and _fail() in userspace_pm.sh to print test
results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index bba42f165340..27ddbd8cf03f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -74,27 +74,22 @@ print_test()
 	_printf "%-63s" "${test_name}"
 }
 
-print_results()
-{
-	_printf "[%s]\n" "${1}"
-}
-
 test_pass()
 {
-	print_results " OK "
+	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
 	mptcp_lib_result_pass "${test_name}"
 }
 
 test_skip()
 {
-	print_results "SKIP"
+	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
 	mptcp_lib_result_skip "${test_name}"
 }
 
 # $1: msg
 test_fail()
 {
-	print_results "FAIL"
+	mptcp_lib_print_err "[fail]${1:+ ${*}}"
 	ret=1
 
 	if [ -n "${1}" ]; then
-- 
2.35.3

