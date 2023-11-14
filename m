Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BE7612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CTDeJfii"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYdzSkeD1o49Xzrxf0NIzpU+lMEn3cr+xRNM0T+gnP0pOmnNOs34u0FPyDazDAh6br6UT91s0of9a/i9kbgQGQy/oAtxMoWTASurJN8Lf0BXd+67bNYAQz5nHwgIW1/VrQlqwR8hDDNMow8YaElW/1HLc+RngyzYnDpi4BfQog7VvOny/vr7LomfjOfNFtLxyVuPtWcXMhHfO7m3waIuFcSbBuldwyvhLWjJ4pZ1Eu/GJ/i7jTGc4r/KvI9n8VlMSm+Pj9IeiLUek8WbK0ZJIvDsXfuCNXXZkCsDA8zW3JE+VC+Z/DB/xtNC74Fz+nx6p6m2OWwwi39itdg12kNO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/gQyUaHUhRxW9N3xngLMLuBruOs0x9K+AgcCwzAmQk=;
 b=ZrHa3wEXJnnXrSR/nYSHHV2igKCLZGkjlyyt6BtBqNIan6FV05rmNG5KapRBzXSu8RN+DG/FWD3azZlksBfXqEWs9Pw7ndp2X0LURgOOyNRPcR7JMdjtXmZFLw8AMDwIj9P5Sfj2zrqPuvSe3Lw9ghLlHquvjnY2Egn4WPF6ZXslO6B8XgyUCIX9f++2PVkBb4Bv2TLT8Suc80xJ+hZtJlbmAksU3rKAU7oTfK4sj+NLQ4g2c6vLxjWJ1KQsOAzeb60Yof4qyXccAB/CnLD+wYDtpcaOzfPshRyq5CWhOvCkVdz/ZyGmv/w965Vomft2BTv6K8y1sTZwE4d7Q/NSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/gQyUaHUhRxW9N3xngLMLuBruOs0x9K+AgcCwzAmQk=;
 b=CTDeJfiiH/yqJ3dly4vH+rv3VroSyNgsOaWSQK/t7kiW2BXTLepvPyjD/dTiCXYtacYVuT63bSexwo9nkKa82nh08wezeoZ/dF2urP0K+vz9U6blDXX+H86fXhoDykQhxNSFGSryI1P2bt7GRy1vh/NCu4ygghXT4mOzhRFRBN8eSbW4v210MLucUZCZ6qc8ZxVb7MUbBTRk2sjuBqEMKdHwAzCtmzyCXRXBnMelCJjtuPmW7zWYwAP/eyrbCF3rlhFtKxMP+mc0FFKuR89yourHAEgzR9ejQFrQZ00eYUyhx6bGvA3GLkbJ1d8gjuMl/1tawrVXyuJaunkj2PFE8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:40:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:40:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 21/32] selftests: mptcp: simult_flows: print out test counter
Date: Tue, 14 Nov 2023 14:35:40 +0800
Message-Id: <e06093e041c0e377455ab63df90e5c766c02751e.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0058.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 767091e6-c5be-45de-8bef-08dbe4dc9a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BXQ/u4lpEAyvwhv8jm+wsqSadjFNFfj05K1sGDNNN1EsBdIwwsNx9ZpdFdRGFD4186GJ7zU13oQGdZcufGdprO3tGq0tRK0iaE2RuA6gZQGkS8O0VWa5CpuR4IO9RAAVR68Ln5xIOUUIEoNCWZ9s6wvPcy8jqtxhM5izTfkpTSPh914dRNE7MeGfDObognWtKf+8LTcJu2agN6EAXAGNatn0k2OtUwy2ghqY+K49VoA1ZdzUrEkIQaxbhB8ox3v7Alaw2E5pHg1iCkjl4HEkF+LniKj6nmK8DLpuBRWMguuo3yZdMq8qwyYappPo32OgX3ejhBqbHUNAE5QcgK5JcSga97WSnyNQWcnqYHEFm+KwzZn3lQwcsEQVvLc/E2rmCJ2sGmkrcPQaiXjkWiabr0ge4lz9sG7z0I2ztkURy8kboHwgnfeYpMAP5fNibSCcIpWbfohIO5xf3DRZWL7zEuR7iPI5YoVLPIS58O6aT1FwBebWCzyNoen9UsoijytS/JTuMh8S4Z8Qbpa+aBRq8LOJzPPQ7aWQ/m//KJmvvFwfqc6R9jqp6sWTxnHwY5iW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tekQhjRIE0RC1QtQcKsUBqn5A/465tgaEHxccMrWzg56gzIUjQJ+ECOJ1Gc7?=
 =?us-ascii?Q?bJVb9gik9QGCyph2AJ5z3ApHT1tsyVO7CK9PrG3VSd2Bttwcllxln58sTdLS?=
 =?us-ascii?Q?NE0jwmERviGPymbdqIYx+XYaUMYcnuRWzWgfrbLqsUqKR6+Mxj173WEHJrJu?=
 =?us-ascii?Q?HrBPStGhPOulcrQ1DoCqJbOaKF/fSiMO4XWPRBhcuorTkUCHti0c2QtXmUzy?=
 =?us-ascii?Q?KL92CRTf4A9ktEH/btf5cfH9UKuV9iujz4AcKkxDlpi9Z2spX9xATXDIeCe7?=
 =?us-ascii?Q?5qoS92kvstulm20x3yzvFXkL2EGIGnFrGwYjBCVIvmUSXQ/OgO87vi5Xh8ML?=
 =?us-ascii?Q?64FY4q2FAh85HqdkY6Po2F9aXCr+tZGVhCWTWMwqPvyAlyI5jET3uamP8NVt?=
 =?us-ascii?Q?iQj/QfmYx03bo0xdmeo3HfaUpeKOToYUHy9Xk5R4n4FNbIC8/x2zADfJOE0G?=
 =?us-ascii?Q?5a4RhuRVY2/cc3St1wq0f2eiC1L3mk/O2nYzduUSE9iW+MFBU0n7LCQXT7ql?=
 =?us-ascii?Q?0P86e3HwqKs0Bc9Tp/AueBX2XGrhda0fzypVebtRxrfv3mtQshJheJbNQO72?=
 =?us-ascii?Q?8+zqUwbsSpiXgdrLSoscGAtccSwdSj9MxF6kFliCuHYYGZxdsirJZUWbFgOG?=
 =?us-ascii?Q?fL7dP9XDY167xORXjOUpdGWdqpS03ipPybcSnX+DfnthAtntJtWMx+y6HwFf?=
 =?us-ascii?Q?6idl4YOV0DeMevUMr6DesK82eswQyjJxU2QqY1a5gX+KRst4C2rQAeH20CBe?=
 =?us-ascii?Q?2ZaoKd5yId+IvkoAnRRps4k8auf8Uok8Cqv2FnoYxqRxt7ElCDus2XU2/G0j?=
 =?us-ascii?Q?lYkk+P6xTu+iTUZTYf3g4ZQO2pseL5+VR4bmgQphe0el9nDz+H8i+RZ1M0Cy?=
 =?us-ascii?Q?7PUW5s5GXmC6CagSiws/7g1cg03EtXGKZEg3etr4yGZyWu1QedC22fJnHsdz?=
 =?us-ascii?Q?uAZFAsSxIzNdxiDX59WdVykA0D+mJux6+pmnVppQ2rw23u+glJD2T1q38QY/?=
 =?us-ascii?Q?HRPV2OcjUrpGxPw/F+yBkzGwQSV9ijztEqrDIt1cQIm6PtTUVQlOrKHdwHDx?=
 =?us-ascii?Q?TtPLgS3XtF55sZofBrs/wRy776Q+WXkg/MzGLv5SQAWDcs97k4sf917V+M3d?=
 =?us-ascii?Q?AV1ECNzeyQTysKxqaphQtAoFYsJumyBU+Q2esgbF7jpIc0fKvEcIgsVgDxOm?=
 =?us-ascii?Q?n/fmsh6dTGyd5eCVWnQJIlDee+RK6k7wYn1gYvb9qyCjVRc7RIub9+cX0BZN?=
 =?us-ascii?Q?yMlAlAKf+bPq9t5CNmlTuNp7ZBUiAGcHeVy/7drGwUdLcNhIS4Htkh1RpyEy?=
 =?us-ascii?Q?iQnRsZfTzDn69eR74duA6UqNAMdjNSUAIe3rkWWdKhxxl8m+HMhLllim7Ytx?=
 =?us-ascii?Q?afszWLRw3Ax6H8nzUe580UF3PjQLrwdkRYwq8W8GfyJ0MP4SQhWwFSUMpzCO?=
 =?us-ascii?Q?zJqFNABNkYQac9NeD41RHgrl2wxxmhsfeq1m6DJA7kM7giGW71JZzGfiWHOQ?=
 =?us-ascii?Q?zOeqwvkORDN/fp+1XRbwE7hh6RBc0B0pIHI6rQh9RUAsD80jsJSm4B4seQ9x?=
 =?us-ascii?Q?3FPC6csRDCMHtgk/zbmSNTJm5e5Nk4HY6bxmxbH7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767091e6-c5be-45de-8bef-08dbe4dc9a92
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:40:34.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwRRA0U7NsXs0gEqq+a2/k7YxcKTyshCEkjlJZSka2KRq3IbY3qwN3PJdOcQC7qGuw33Z2BVgswHQGNXlCR4Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

This patch prints out TEST_COUNT for every tests in script simult_flows.sh.

The output looks like:

 01 balanced bwidth                          7411 max 8456       [ OK ]
 02 balanced bwidth - reverse direction      7380 max 8456       [ OK ]
 03 balanced bwidth with unbalanced delay    7434 max 8456       [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 6a4568d8f596..a9e14698c179 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -8,7 +8,7 @@ capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-TEST_COUNT=1
+TEST_COUNT=0
 bail=0
 slack=50
 
@@ -227,7 +227,7 @@ run_test()
 	# completion (see mptcp_connect): 200ms on each side, add some slack
 	time=$((time + 400 + slack))
 
-	printf "%-60s" "$msg"
+	printf "%02u %-60s" "$((TEST_COUNT+1))" "$msg"
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
@@ -236,7 +236,7 @@ run_test()
 		[ $bail -eq 0 ] || exit $ret
 	fi
 
-	printf "%-60s" "$msg - reverse direction"
+	printf "%02u %-60s" "$((TEST_COUNT+1))" "$msg - reverse direction"
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-- 
2.35.3

