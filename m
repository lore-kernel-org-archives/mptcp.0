Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F07612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SOPaJhND"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkkQyBZjrDNN7b6HAlj9mAD4SdOlEkrQRaJmoSSrbnYHPLMODpvXmkxT/S3cX6jDsjYJdcnZR1/5LT5KwkcWySeTLnVdr0DybbSPUSJbMDPyRCYnj/8MdiF2aoHkRvjC9qr8a1N4YUfdaArZW1HVJQD7FYaTeNZTmWc8t3DTymxBjAw2sLJsxWQZtdrRyhj+7cPPW8f0s8zmBGW3gGvBYrGO9wpsJ0VPi4U860QglezhYobPwkbInQs5npwg2B11TVQ4FFELBgHlsV6cFXnGIh8Z24tvkm/ZSKdaMjzZ7AB2REirEB7lUGpcBr8oaQ9h09L4VA1qQeVPrtCnsJQl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zegY6h/fmqcRrg/93R+5oej5y1CXdTsZnW37dwfOeEA=;
 b=Sksz4w3a1SfsCyHJEPMU5RpQxFX8XD5PE4GvzYFSmt1KNF6uBGvlISoO0OveoP24q2spzc9P2r5sTlitxWjFDfTQEscp+pznzH3CxML3isd4wgzI4MmbfLvCZYsufWB2x0gYM8A81KUlq2eRiuPiPPYcMVAhQ+WX8OnUr0KElJX5jQoHmrQmH/ijL0XnCMOM1HKEDQ0hinMbyT5oLyru9nlEnaJYCuYv1aCChRZQTSTKsbbFvCrFPVK1/WjSpp5kvo8G3QAEiKdNCdejuVuXPf12Fe9kcp7MZ0toYhu73HSfEIGOfqyZczu5i/FK1zGcSZXK9Y4+/F4MzSYB/Ef6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zegY6h/fmqcRrg/93R+5oej5y1CXdTsZnW37dwfOeEA=;
 b=SOPaJhNDV+j9Uk96GKoJDbocY34x3fq36VNEvuydtys6EHhZbIe8VINDYdAUoPhhRrSy30D+4du/x8mclh79WKz+VGnXGodghyWUgXppxJHUWzJknNRucO2PE8OFdOBZnm5bZ/t0ymCv8wYpphWH6FKc3rbc4s6wqmmFN4cZzq7myfvWCE2UVt/d2LvGLvnaVZrmHtSLgrS5NO155ximdBPvlHPnetkTIKz5bGcfgdPUMT3iTlI1/iS5DrgI4ZsL5bDwyO9syRdTgV7a2hHPfMG7LZd946NeITj/NCq3s31Wb0DrSMdE83IbDOiW0Wk5bXaE1eL2JxLNUXrkurZE6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:38:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:38:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 02/32] selftests: mptcp: capitalize test_name
Date: Tue, 14 Nov 2023 14:35:21 +0800
Message-Id: <ea0be7c9670f426ec1cfb5f4d351301d8ec46e85.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 19320109-dda9-4f50-8134-08dbe4dc4701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	or2r/DafmZR2Qr302zgI3gsDtk/Aay8P0HzBOXk0/dy31avoNzdglVf5y3b+ojyWWvG7e2rYyAxJaeHEocy6OMhOaEfXgHm//uULxUPeFEsbAGDGiYYMgqGaciHCIfVRePVJ2bB12NiflIw4voJjzsOIrvmPLKAoN3nV9S/el0zCnWmWo2mWEPDA0tmuqJat7CLXx5/P1X/8g5FF7B3eS/efV6h4dx6gYd+lT3s3C4oxBgsxx6iVtWEUAzXPlcpJ5bZ4YzgXeDcQh1vBzXb0aFS+GlCkIfAt1FTlKfRwM/kTuyxsJvfmNOKniCaScKnY3NVe9AO98L9k7znBYVF9QlM0DPpWiQhCnNiWl1AxjV94kQKt1ATBfx7r0Eldob+7gkxU3fxl+840w0NS8nJ9svAkE9m8VxrAk9ME/uy/2lhMCdfcOL4gSpcMLFhuaia7l3RkYdiFvtXkfoy8ZxwQCoB+yNVzy4P87SsZdcoWAFGvtYkhY9xGELCIxmywdLoikFtURmKZy86TqsdB3WijegHEHqVIqs5FGJEbHNwNROwqLhFxic2O1wprzV9ER3bV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kq4VAuTJblKZy4mUQTRaL32ab5AW9Ui9+anbvxoh9PZXuami0GNhvIbbXCYP?=
 =?us-ascii?Q?xmzv3ci5wQPqQjCQYVLygOacBPWIkndg9NYtaCf5d4QnJaqNKfyP6KDG5BMA?=
 =?us-ascii?Q?+TXGrAU4xBQwHIxbLxha/+AbN5yKXhgItii0B2nyvrhZPhTu7cYbwnF0ttD4?=
 =?us-ascii?Q?8vyQBRPTSqouaavxIgQtUNm773K75BamgHEXHtC64IGiql0l2YYYo0sUUr0w?=
 =?us-ascii?Q?giWiUv1Iqhw4WsiY1FLAk/Y/dLpbO2FQq6vZNuahAunzKhhrveMmVgshbhE0?=
 =?us-ascii?Q?ygch+Gr8YvSepnR+nUnFRDYuMHNHAk7JFssyW9nAV3g791jU/2DGfHpwc3EW?=
 =?us-ascii?Q?fqYMvbjBTquAbDvV8iB2LRsGclEsiyBhJb5jxLh4afuJtYuHrfJlOaCNSWr2?=
 =?us-ascii?Q?4PJclqbda2xqMq3dtk1GAc1y9Qx3lWuFU2OGPtzHVvTmH4G/EuBGTSWycZW0?=
 =?us-ascii?Q?6WLq3RVDuC97nO3ynDHzj19gbTG0RvDO01SoIYW518IUllvxIavrw9lyTho5?=
 =?us-ascii?Q?wK13Mi79bKB+NiNklHVWkECJ8A7r6/2gCKOHnXhTycnR9Z8yciprSZuKDtDT?=
 =?us-ascii?Q?WiL8UNm2q7NonM//F3jzfahInlilLsFgPfeb/7ZuTKIwXYGf+U9N7tck+NCx?=
 =?us-ascii?Q?y5jFeTXwTeyJjSU0vX+tiajpy6RTPubDhFFrApRX33aYmtJenj6+qWKthq1O?=
 =?us-ascii?Q?H4OqGZo5Syz8LqFL9IQ6OzBSjXpLsOl3VFSa/GZYm5fyPp8cW5vS7h8gYgYK?=
 =?us-ascii?Q?qEnWD0QL6GuHkW6B0uf+XVkhZHY56uWvLvn7TABomGoI6grAlpZtRosEizNk?=
 =?us-ascii?Q?drIQMoR3JFCDBGIfQ5nOX6S3e3BiVkO6XMqJMPf+2zaGW7rrBcOyRDVgDvly?=
 =?us-ascii?Q?ROJDLvJ0v58CoPkXcUQRKCPwkuvMCu8UHzYtFWKVKVMJDpjWezSalNSW2P3A?=
 =?us-ascii?Q?jf5GyUl5u5aV+y2oDKvSBVO0rHv/uvMdOOFOtYZFQ9t2f6wwK/DFDRoc+oGs?=
 =?us-ascii?Q?J/h+HDtbVtUi8r3UsM2VDhgYALFh3rDxHHpyN4coR4dp3SkCWCpJ+hQ+PeQp?=
 =?us-ascii?Q?Edsgvsv8H85lECM57v4WzfcadY9nVh3YsNsexeBJmDlxtNLfzTkxqMvAhYt9?=
 =?us-ascii?Q?dEREa7uB4CFnxFYpSLKTiQ+xAVK5iK6Xj+r0txoPfaZsbbS9BEgpoOO4hyEq?=
 =?us-ascii?Q?/vRMHTIbfgY0ofmTxtghhOqT0O0UCY+qWRIOrf72yfHCOi1zIq+yWO6BVxtc?=
 =?us-ascii?Q?UP+YB2YtyNuNYDWf9A7IFdr0n77uFsmAs+ld6scinmQ1soiy4a43R3la9E5L?=
 =?us-ascii?Q?r9XM90CSIcsakI6He2W9RLHJ6ErdGhis2T6uc+Uv1Ws21Y946KfQNMh7+kNp?=
 =?us-ascii?Q?a2/ygXeFjPbty6vG4CoqMCrNzd0Gi/tLPMuOn2BM3/qHlShBL8rj12Zy4Qvl?=
 =?us-ascii?Q?hyFmrVEhF6Iig+KrCku3YoJYlQJaiEzRlMXJeixTs7FmCnTmHYSQnXNM9RZr?=
 =?us-ascii?Q?6UXvbvST40YosWhioppHq238NSYkKHIeQPPfbEc0qhqFIngCLR7kiwDIp9N4?=
 =?us-ascii?Q?HMLMvlcfUm+x/++QlOrjsbRLJdKJgHrYrqtX/t5k?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19320109-dda9-4f50-8134-08dbe4dc4701
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:38:13.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+bXZKkzq+za0Ch1cVKuqmwL7H+O34n9qxqrdKYLMVX3etkQGsAvLUCzVvH/n7ayp/zb5S7hV7SB/ksmGR466Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

Most scripts use uppercase variable TEST_NAME, but lowercase one are
used in userspace_pm.sh. To maintain consistency with other scripts,
this patch renames variable test_name to TEST_NAME:

    test_name -> TEST_NAME   in userspace_pm.sh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 55ed3ea0a691..f1d5cd4ab95a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -55,7 +55,7 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 ret=0
-test_name=""
+TEST_NAME=""
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -69,9 +69,9 @@ print_title()
 # $1: test name
 print_test()
 {
-	test_name="${1}"
+	TEST_NAME="${1}"
 
-	_printf "%-63s" "${test_name}"
+	_printf "%-63s" "${TEST_NAME}"
 }
 
 print_results()
@@ -82,13 +82,13 @@ print_results()
 test_pass()
 {
 	print_results " OK "
-	mptcp_lib_result_pass "${test_name}"
+	mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_skip()
 {
 	print_results "SKIP"
-	mptcp_lib_result_skip "${test_name}"
+	mptcp_lib_result_skip "${TEST_NAME}"
 }
 
 # $1: msg
@@ -101,7 +101,7 @@ test_fail()
 		_printf "\t%s\n" "${1}"
 	fi
 
-	mptcp_lib_result_fail "${test_name}"
+	mptcp_lib_result_fail "${TEST_NAME}"
 }
 
 # This function is used in the cleanup trap
-- 
2.35.3

