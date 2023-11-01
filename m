Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55380A
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 04:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bEb1rHQm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luGtpT3O4sj/jjisSDfxnCK6oxSOb2GkI8Sqmt6G9x+B2v1SOI5LFJNnp2/SDxAWjnKPIBwrffdnhOBRrLCUQwIqbnDkTjg58n07dgP/8NRvYIoUUns+CTeZQ9ut0eRflaY81h+NxT2LjVvyqhBEqQaLorh63F2HKaX9dacCViyDQNlvteQzK/seXa5xa95whxd8xJNVNHOAtcGrAfFEXK0+Qpw8m0dUvotDKrbYFzObNuuI5qZeTOlfKVwu/p5XIW2p+CotBAaAdZR3tXsmjt6o/zMmL4IO12d8QTMgb2tQ17eHWQ6cJXTcaNWxZA8MJTmijVfiVuSNRAMr8ENZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWIUFNR1l7bMsjwD4+3xAQdhrTrMhLH+LZ6pTPHZX/0=;
 b=DkLCfCs5A9pzYhZd/I55EphWGyy6WrrCvIsdHs7A+dO0IMdZnkDuPoklkJTGHfiKmBLX3y7q7SUWZ/XoPlrGXQRG7GDtARtNxnEO3uv+OIAzqsjMA9egTLsWa8aC+gh+nIYUVa54guKc0PdGiXzHrjHRP4fyeV6Y2HrNsUvBJq0SeRLy+yeE5iWxG84mt1TlDU/LgoUhbiLvl2ere1JrkRNrKIwDQXm48Syf4lFjUhBsR3N3OHkw9nLOItB8wbZyyGryaoikduakxaXPgeqEh9RmkJ0N4tzt4jms3aHe6cZqybCO/NVR105+7hJjWgA+mt2wIYeDwOGrRK9xsqNXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWIUFNR1l7bMsjwD4+3xAQdhrTrMhLH+LZ6pTPHZX/0=;
 b=bEb1rHQmZsMKla6jM1Q239bB/UakSU3Xen+u0/Sd2F6UqRi98yCzl3NN8X2Gm2fGASG6MH9KcrDlId/Vds+LhZ0Tg3zHInNSOaH9X++9iOP/XASSQu26qn7ii6PNBIq17EoKo292GYINj+t3O2ierpE33Um3LMeUOVj5hMUta0IqNGwCP78dc+DWXKz9eavAOxBQcxF/hENOIrG/UBKLyeeABG3O0sgP13TIUqQCdrl/LLN97OtAjMwFxXDkM4NVo5/qnHXjRdYpe+9AotvR/DPUzxbhC8uj8OcCh4IR1jVeJ+Jg0gxXtp5rTkBXyuirTLFU0OOnrmoHu5IXcX0MDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Wed, 1 Nov
 2023 04:38:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Wed, 1 Nov 2023
 04:38:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next 2/9] selftests: mptcp: userspace: print colored results
Date: Wed,  1 Nov 2023 12:38:17 +0800
Message-Id: <a77c4bf3d4310c748ffc2331295a6b14b8560894.1698813419.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698813419.git.geliang.tang@suse.com>
References: <cover.1698813419.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2baca4aa-0025-4a18-2aa7-08dbda9466dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zhadLnr/KhQm585vscpP6kkrRv8OGPFIiGGFL2GevzUNFjigjm40Jp1oZPseL9+7U2b0i+Df9yuAFwvM23Y9mNRhpGeNa4deEXelTid/OAskLVrIcjzZSL39eQ0iyfywFoIcaQevcsRX107kfroQI05CxsLNh6z2ezFunLc2ixWsG0J6UiJlQFf3sZ0z75AozIWRnsfKUedxFoV2eVKKt6sGSP9oZJ+1kiY29hKoJdrC2RvsGGdUJ2/9ohUA6C9xncDDSzpvR7h2K800pR9fxjQgSrWN89NDv9Z/715nWp/xyJcnfd78sKo+QDhO/JBiYVyAqpTBbiCTXzUMOHWs8p5GAwTlmW5TEEsOe93ni7qbd6HrkDYxUv94mU71vhx0rmq+/RZ170gd5Wy4nxJ2LM6cSecQLNWEluc+RO7MlycoAsGGD1yodXbrH/cSswdoZWWCwdDkx5bUaTjGKYuBLCAEY5wGv+T3W3/163/c0iDpsX/7sDqSj5oY9VrRONYs8voH3fVNRYFzV3OYx3OgdyaESvKC8iTD6KT+dcGu0knd8Irw27Txj1tVSMwB94U4ZJregy7/7kczYf06/PAj20liO/NqkWI/owsc0T4nLTw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(44832011)(38100700002)(66556008)(66946007)(66476007)(54906003)(36756003)(2906002)(6916009)(41300700001)(316002)(8676002)(8936002)(83380400001)(4326008)(6512007)(26005)(86362001)(5660300002)(2616005)(6666004)(478600001)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?67wWuB2+ByEcLqsdWrIgNoHHjzAKw2Sw+tuHHnn6yGE5eA//7UuV2BSah4lC?=
 =?us-ascii?Q?kW8yRs8qSwjbDifeon4rk69cfWey4DVvMglmWsoxOtzm5iRRwdcHPqkA4F1g?=
 =?us-ascii?Q?ht7P8lFw48FOnoeqRNkGLp70d9cE/TnmsVpjBHy2XXP858kfnErS9K6/hIYY?=
 =?us-ascii?Q?CabvFQq+RIRDvfR8f23z6tGU07Q93hBpxUtorPzGH5gVbC3cKa2OBzQqPxfR?=
 =?us-ascii?Q?pOnuHETILvSPi4je+pXQYQSCR6uINSqb4gUFYnJzuKyvRM6sStouQb1/O7Yg?=
 =?us-ascii?Q?BsJ++GooAgHxza1I9Q8TOatAoyoEsK2kraPUhC0wWM7Bdk5XZRvd9v01Mk9n?=
 =?us-ascii?Q?N404Npc+6pJsxFfhvuujyDmA3Gbu53RRta7/ErrU8F4nE7OkuaLwoN6yOvXQ?=
 =?us-ascii?Q?e9MQDpFvK8d2rgfLd32z6EbPsfGEL5NL56ZlKX1yNjYiK1det1dXGjT8Jj/O?=
 =?us-ascii?Q?7T6Zn0R7Q2sFDyFytNFhd5em0k6cUT12qa4aARpsfG7CHvEn5GqVBRS7LFce?=
 =?us-ascii?Q?Y5JmK0Id6prAck+lzaX5HLeI6qIIaRitwEedDb2QMbdW44zx9w/i+Cu5Uc/P?=
 =?us-ascii?Q?A2zbhjRAEnSl1hR0QmUcrc+/j9dX5yQrGAihkZkKGkfwY6HPxnUxgHBo6R5E?=
 =?us-ascii?Q?biu9Z38JC8Ib6t+ayciZWHq3NEHsffKZwNbfV/bxq3xs88i9ROau9wTbx2xc?=
 =?us-ascii?Q?8fjJuVSwqiP45HbFXKWE0FU0MECnG1seW/44elI8HpfYxWpc/0NdW48Pp9ZB?=
 =?us-ascii?Q?EqGlUdR2RLrl6sC0v9uen8pXkS/sAmi5ot8snHSUd0/fHXs14rC1uNyCFQBe?=
 =?us-ascii?Q?qWbyKK35dkuUR27GCnrb7aMTcXuZBOdSJGFvV0DhwrNYRL9k3mvTlf0rFhk1?=
 =?us-ascii?Q?CA6FWx6rwxvcPlFxWf3508mMkK4vI4rUGzdJ5+wf65dnC4KkGIrwPF3/GoVJ?=
 =?us-ascii?Q?RDvYbJjuPWJz9/w4dW1Rg11cDkou7odAkz1tr0kBOoFhxhJcyRNNCujmTJ1Q?=
 =?us-ascii?Q?bok6unl7MSsSjoN39mFm5Iqv/bAayROI78O2oW9og8t9MiWnQmI4w67Hxh91?=
 =?us-ascii?Q?fzw2QXaclEcOlFJvfoCl1+qLteby7gEXJW8q9cEToV7+eYsiw9EVbkeIdjvN?=
 =?us-ascii?Q?53MOmDNWacE+WfRZvk25muEi1sX4bp4+xn78ifAcVzXVwzsoUPMgcaI4M4rB?=
 =?us-ascii?Q?Srv4lb+xCgqUz1x0ZJcPo5SAfMol2qPjrgN3zQOESfkcqJ7C+oowFIsvQprY?=
 =?us-ascii?Q?7rISE1OiHOndFhCp2hXmAxRyZ92VoIWQ+Ofgq4Pjj10vC1n8Gn5ZNjBjQsTt?=
 =?us-ascii?Q?LieUu2z38M3ACq51BaruW3tsh7gg6StP42kQ6Kl8+kbhuv/MSrxCVC+7OIT7?=
 =?us-ascii?Q?ns4pkZMeRvEmXk4E2cTjcBuKYfElrqsc/vFm30RQCGYvmCc7aMwkYoLjfoVU?=
 =?us-ascii?Q?aolb/imdrzP5wGCGwPm7aoiKHpjqZVdr8D68nNe2QzWAhAtHHokgvIa7LpZr?=
 =?us-ascii?Q?wznmdQoNIo2trVUJnBU8/qWFAacMfLq/CE+s5gAmUo8A02AN+wEol3Sad87J?=
 =?us-ascii?Q?HWlTzNB9axZju11FUm2nT3gxc+kd4QbGljdUScdt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baca4aa-0025-4a18-2aa7-08dbda9466dd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 04:38:31.9954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1HvQ1/yXd1EhTq/9vE8qThc9DFJuEa1B8MIfRptb33+4OPhJYD55gbFnBkpeaRhiHwSqXns6IFYThUCL0Hhfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070

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

