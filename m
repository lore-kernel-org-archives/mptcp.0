Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4867472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="4BI8I2Tc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK5U7cq+yufx72i6R95/CXl7g9wVhJ2sNFEIeI+RDcYBQk40D5ggjpUyJUfavxYF3sNUU+u71ytA2HuHECMEXRtutZV7iGA1Iz++x/9w5mVF8/xlrsLE5wyJ6pbpabCtbmRxj1yNb/tv+Z9qMRPna2x59WN9A7PnJs4kNxnzlZD9WC5BqHHPRbj82hWaP7nTRT5/nXaCG81E0DZABqrcXQm4UJybQoNP+5yb0Mn40ZwtSFMgwNqgxoAIESw+J59T+RyX67zefefrHLCNZPj3uI8O9tpFanYIKK6tD1nFowcp2tuWTolB/utHBaNjMbm3v6mRWk71ieu3sPjYK72RsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWIUFNR1l7bMsjwD4+3xAQdhrTrMhLH+LZ6pTPHZX/0=;
 b=UeOGfO54wmCZPYirDMKYB6NqfvQ/wLv8BSt+Rki8nRJR/4vfFbA39eLDalKyiUcAvAcnRaz0ObrrkNAdFcw3oleTpEQX/bSm1NmGlq/G0tgP/FVaOCygSqr4/OgMpqzWgFXW69JffyPRpOPovjEewIjx2UyzHwISBRvNSWXTUsTVOjtAyJCzRGtjf32tzuZ7RNt5yliyobZLmUpxdHdafS5n7ePvl0og/6VdGa/0kjMQk6d08QD3SJSGoeFhXS5Nsiw3+eFsFfLKzMs9JWTdUO+oXM7ox6tvO8Z762KiV9+Fjivj6P1mMu/0lySNok3MYZWZWRcPu1hkboFehcmCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWIUFNR1l7bMsjwD4+3xAQdhrTrMhLH+LZ6pTPHZX/0=;
 b=4BI8I2TcAiiAuv4YjrISFU5efyu7rWEocUhwulR14AnXAHdsz6Wl5F9NKKeDILwVkbFvWixo2qD9tfjT9auHfw0+hGhC48W7KNqh92zcpopCaD88RfaMIqDKUBho9ISsGMnir95cENDFXbbgFFfMyAfUaleCOBZWq6B+bCGXCsLn3oE8EkZyjkpSSnyAcKAZCMW+eMhEpo69z/fSeQaoYmlL0HCVJLR95uHZpRZL+fu3tdJMH1QJytqgvzYV1s8rUxdeuyYSMv1s3T/vQwbndTWHsG+kUUUiA9PjNf8LtVjNU922oljLcYoL+BoH61oIXeJcKprajHor0o41Tti6gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Sat, 4 Nov
 2023 08:37:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:37:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v4 08/12] selftests: mptcp: userspace: print colored results
Date: Sat,  4 Nov 2023 16:35:56 +0800
Message-Id: <6eb7551dd938022e6a27fe2ffad00bece6823d9f.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086300.git.geliang.tang@suse.com>
References: <cover.1699086300.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: c5276d45-a2a3-4666-775f-08dbdd115236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i7hotXT8eFQrCs7BYyKySJvLGMWv7ytuJmKDAVrFYXv3cN7HdIwbSrJbFnLF69dXXmD1/PSjMcLHLuWOYJ8Lwc2BddeifMoCbr8q/K3vIMd9LMs5icZsw7Wp5W58s9jg8eqc3whFJOilwr6laFPOrIOzs/O0WhJcqdoP/OBfWehvFEzQmwxl233hvWBfN4BZOmzDopWFRDTUIYyLL2wsM+Wh7wCI1n2cfD8RBUJ951vRh8R1y0R/uInOsJ9x4mCWmC6jLPPI9t2YSG87TWHmurAze+2K2i8YHOsu6BhCwtioutPOJM+BeBv5tGqyFS2EbB/kCcuil6YamyIExoZ5AkqEJt5syXGaOL1jva9Fg1SsRp1UxFjUz4n/wvoFc5kLwpFxiOIr0pzGRTOQnAZkNXpavJ3fgDp8F6fQaZwCXTLd/RzwmARwOkzeCIKLMkM1H6zMYnYhOdZtywjKJRuaSvJhuaWOONzgrvJHlbXWCabf3JwOxwmjTfni/KZl7pb6gw9TiA+QUgGR7rMVX8tb0nhk0efmf/5Gq3KBosJya3rwKCClM8lpaPRPnlBAVDPHQHs3GvaOW89LfSegOSOCyejXnClq3oS/jgbvNJg8VZk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(86362001)(2906002)(6506007)(6512007)(6486002)(44832011)(478600001)(41300700001)(6666004)(8676002)(8936002)(54906003)(26005)(83380400001)(2616005)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4c+tWuLiKRmXOpZaawjGQROBJy3NVI4RYs2RFywDP/tTdA/Z5LfZaSYKCzRO?=
 =?us-ascii?Q?w91OZ9SvyudSRU3QHQ7lxak8yqgsKIsQ0ieSv5KDdXWlPn52u7+X32f5uypN?=
 =?us-ascii?Q?Qu1k/rtoxHHaF5T6R3T+kuvnQp8U3vlULRKCCYH7iO3CitQlbwIGH046NsGM?=
 =?us-ascii?Q?KKz0CF5EBwEUeHuVt0qgVSWsHVgvTssySwajILBr19Ct3F63G3wxgwMz82SL?=
 =?us-ascii?Q?J7/quwwm+oo/21KNarzoZ9HKL5h9sNvBD3u4JMow5nrbrnUzy3BdFvJihYIj?=
 =?us-ascii?Q?ocNm1PJPlBwtRHWrwFNh+e/ZXXkoG8RGul/HRPe+CqpCdlp19CrlSTLc1rkO?=
 =?us-ascii?Q?Oo9ZB4+7AJOjjH9wGsvx1Wisoa5o5BgYT33hgcqrWAuUCma/YOQGyce7a84E?=
 =?us-ascii?Q?UrZLy0adOeFn9JiNu1iJpHUL5Z+7WVqxYkkaOiGMxHnIa/r0Dq8v7SMd40wn?=
 =?us-ascii?Q?kV9zahYN/mAAJlYc3uT4oMzSr8/GFb+oF/MwIFOXylwz4ZRamEl+8DTWYfT7?=
 =?us-ascii?Q?6fG19m3DF975NEni2R7bVMjVXB3To4qumOfNNSdFQ9Vge0mUdAGPzzt7nrjD?=
 =?us-ascii?Q?JV7l+f1sFOZuLqxibgRn8mnN9YgI6i2SroN9ZPqZlzjs5ym/glY30PipIH4N?=
 =?us-ascii?Q?r2JmW8xWZ42wBMQQJAq+eeYzSKT14fh3hi/SgDH5eRlSmojzoEXcBuqeA0Ps?=
 =?us-ascii?Q?FFqOTG1icGCTLnPfnS6agPmwTR1psh5pLKOB1o0Y1QfN+M9taoaYb8wb/S+n?=
 =?us-ascii?Q?GOld4RUsAggtB+kM2Hj1BgF2eYm2jtLxhtrbxWR8ky1iH5Mu7jLdyczdbofG?=
 =?us-ascii?Q?oyai2D0kgl0trVMnxMd6DCMw/6AKztdCIKkqvd3D4AElegetQmGvnoFmGVEQ?=
 =?us-ascii?Q?ltUNGg7p6R8sZk5TN1FfavbF7Tyzv0NBZKvdefQ/19RJBWVEodUTuLX0vxsN?=
 =?us-ascii?Q?BAUlHWTmI0vHUT6r6yYldTe+KE1b2qBB/nWIkBKYusls/JT1KJrf/w3GHWbm?=
 =?us-ascii?Q?gvIhTPkS3jtTAE7F4eZj/+PcQvTyeT5VIg+Sp1jynqhyL9/vGCqHp86Dq0Tk?=
 =?us-ascii?Q?7/HBaEXzdE2n2b6yuUYs7QiHju5/eNU7xqG3SUp0zoXjMOLnkRtnpjdLrK+V?=
 =?us-ascii?Q?kcrzWTlAlAzQqBoRqGDn5CAB9bh0/HgPDQyABKJM2qK2STpDK7zxmlTn2oSo?=
 =?us-ascii?Q?24kX+VQBBAvg+3nTIQY/3eHE5FwLy1zG3exiD5j/w7g21bbucfWlul9AIKJR?=
 =?us-ascii?Q?2CpmGofSHjqYyQ0VxVEgdB42IbZp3neJKAJH9YhpjXX+NFrydWZ0woKi38ty?=
 =?us-ascii?Q?xyrLwr+h1xVD7vUqFtVeqzaPzS4iLIdo0eT8SCP7irYwGVGyTfewlfQ836vq?=
 =?us-ascii?Q?MMAseAXhW/eTjyCBfEftAFQHJXjd70xUa0pKxg+Hao1lpRiFtCxSd4FV70MS?=
 =?us-ascii?Q?QKXpTqF1PdMa+QV678oZFtIKAAIDe9vsHzsIAdhsE4UxAHn5RNSGpDe38Sjn?=
 =?us-ascii?Q?n5YfJ4eJ/fazgoHfao3WzOM3Dvwz3ClcNhWm4pLYWNEf2s59DIpi8Suj/P/2?=
 =?us-ascii?Q?zV71kyzBfrEvvWmBe3QcOr+5aIRgu2lQkrzNXUL+vSQukKqhvHI+Oc6Qs+xe?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5276d45-a2a3-4666-775f-08dbdd115236
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:37:46.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Fbzu0KzPHlbk4v0kIJEQzPgf2Vd6dEnb/slr7Ao/r8I1XmQ+hly7ZW3uFlA8oOuWsA3bAw8A8Zg1mVShxfWGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

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

