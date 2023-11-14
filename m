Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB912F29
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TrowlnmZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM0kZlXsfbYwpYmZgowYDy7KAFo3fqGFBDfftTKAhYcNOX7qI6esFnzAbT73wb+tHxqxQ/QytAA4kgtCz2Qnnn2eOpRPYZgnC+7Dg5B2qnskCOnDXBZw6G04rtrshs6eLJ8HTxHi2a11j3WP0L8CobRUJEe9kyBzbbPI8ol8crWpUsNWd43SnuoIt7NfbqMxm6zK9LIkSLNUg14lmMmmDtXNueZVp9aT00C9uC1ORYn7oX7o8HBHQvQ7pfEokA/LAYYkJMCPEJTGim4K0R5jFaTf2EDzrSY3KlH4zGiEPTaoOUeCZ3oDFvAK8xzGPWLx7yZQgJ/g7xXX+dpSIweZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdUl1ixjV1bMwJiLktDaFUKI1bTI5vMYphE5VCSMZrE=;
 b=BOwZI1HRqFNZ7Im5CdmTQchBerLHhUuZ1PjV6uFQHOsZoiNmku/JFsq9NWlTIzab8OOYBUzGJcsnkKTiHFajSuDp9FVhpoav9D4udNJ/81POcgjGBxN5vgHcAwm1VRpSwWkDToZeIzl8iMp18BCTEgbxWJRDsbS+iuYkddmDf30eOAtJABVZ2AbT8bQqZYEEHkMrf5ZoHp6hUlG7qYsgQwKZMZ92xU0tmQXc5meHhp4cQSJ+7R0m3YUp51QSWdutliXElMssaaK4uxSqkAtjIWttoO3kKLHaulLrt3ib9k9kSxqu+XImUDd1tqmaL7+ZiujPzoiyoW8vucB9unP9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdUl1ixjV1bMwJiLktDaFUKI1bTI5vMYphE5VCSMZrE=;
 b=TrowlnmZb6zL4oovagZh9uuWPDUYXLH5iuAstbJ9rVieHpIvQXQ/u6b5m4u2Q5HoW70gQjUVNi/ISvQY7c9AlasOtRYoeCrwSGU2lJLgd2fI870eo6+pe4VXV2D0GZGCJCA2Zjub+GnqVKNvfIl0CM2vkdinzaeLuIvw1PoOu9o8ik1vTy5mLIKLJg83FWnrTeSUjY7p38Zhs0Zl5aioMp6RNt1phkcIP6znBKEkiI0MkIS1bCDdj05oAmsZXTQ5kAVFhS0OILqCYOkhdjrTI9E1SU8wWQjyjTf9lCNuHhapmFo2fr9h6mM9Nns5GUlDMhd3R55RtY+eiUzCugv5mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:41:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:41:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 29/32] selftests: mptcp: change timeout_poll to 30 in diag
Date: Tue, 14 Nov 2023 14:35:48 +0800
Message-Id: <7545490d4e23962c6355a8f3734f0b0e0484a0bb.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0063.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 9610c892-bb44-43bf-6a9e-08dbe4dcbfce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BSIf4aJX4l8GXblRo1mQBnhHBhp1HMnAsKa6wWC59C6zgVofY22lHK+RVWrLIbidF/R53PCwfzwf9mH5VbhTK20VI66e3zqj+2hgZL8j5osyWKtI/MW03ZFJrUQhnDm7h7g2GALIoxMQ5rdepWCG5IfJxRMtXKfIZWA5XJdpVKdSgOcukklXoWQLTyWcdQ+FqLc67KYwgG+HW6NNphDaI2GjGmvbst6hBZnYH1bzJayNj+RDQl72FkzcXkBAxtgRPju4A8a7987lzfcOdoI1y5hHFTREiti+3v7P7u4O8aRP/Y3Gh81oVxEsNKTXf3RP94uojMxsShc+1GbbpbkjwClf4ZuN6ND0G3m6yJWnd+CB9CL+Q10LM1m/CKp31XudtlSvMrEOpEAT5jUAyVlbzngZ/+H11harn7cXos2zWQ045cP+Fkgcoif6wWiMbxiIFyC55gJcnKIHe2TV2LvMaoC70ewaU6nssxZk22GkH4fj3WNXvKlVWINfGhtJJY77H0p78m2sGj5EK/Lgeg4gKwFHe64H+1b7aO+saeQb447DToeMgRFa3bo5IG+cOVzu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(4744005)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPO7Sj0ObAWnaA1wjNBXXgsFnX8A/Hj3yEXmCkTeqGYqbAfpQqJCAaMOXp5N?=
 =?us-ascii?Q?eWer+y6P6Gc/zDc24QSzk/hMb8U6n8k6BEbVfITyBfjxdgyuFCs7ks4S4+vf?=
 =?us-ascii?Q?jfgocZJ2L9mQYJqmydWEV99FX5rGpk0tKZHxg/CKN43pf3WPA1Vzd/l5APux?=
 =?us-ascii?Q?ab79hsOQ4t1Gokzt//rqUf6z5kilM6S0b4LoQOGbYSG4y6McYOg88yG1RIrh?=
 =?us-ascii?Q?BHP3mMq85uG296Z9ES+0sIzJvCRZJJQlcUERihQjSyfC+X60PIYkPq/aJZbz?=
 =?us-ascii?Q?fV97BMTnWEnCeYEVwixHDXgKCdJjF/ek3dLWvPZhICuyCcB2B84c7wpIqqtl?=
 =?us-ascii?Q?KCho+AUp+C/G2DwSe+NPfjbMn/whR0QQZmZkDU3miYqtD6EN5NVwTEilMJRQ?=
 =?us-ascii?Q?gD4tkcHXS20BlkKvvkB0Ioqlo1c7jm1SkOKk9EOHmVYz4NrcLGO0aizEDkkL?=
 =?us-ascii?Q?rJkvpT+XL8pTrHg8YUQIHf8EBSrDNl1LlunZx8wMXDndonqtc4PJhLznO1Tb?=
 =?us-ascii?Q?coQu1+TfwCTUqM1Y3Rilyo0G1C+lCYPpYo8uQjEvBbv/VSAvAst53z3npv9w?=
 =?us-ascii?Q?i8UeAiazf3IwQpIaH/dhvy/PqJ3DMs0PLQnAZTTnI7rCK3iFV1hd8pvWQ4N4?=
 =?us-ascii?Q?AqrIDeTBGL1Mw9FmQQY2g0dVUXx8ibn2DJdypCuUYpSh8naKPKlAF/kxqQj7?=
 =?us-ascii?Q?yWydKU1k/tMo+GLHC8aZuWYFdDmXtbBIzyUgw9/DDdLw5lQVsraigBygmBtW?=
 =?us-ascii?Q?Au/PHWsbCBNXalfZ1swP7bRWDJcstIUZ3IMPrMJ4DhNOxFvzpLhx3SkWoqk2?=
 =?us-ascii?Q?cpFyg2tVz1J7/5ZsiAGqiIexfp9brRfCDMGFw69VwEAQPs4ZDi3dipyrv7gy?=
 =?us-ascii?Q?cXtrZI63ZJ+Dm/0Girq2U4hu+WfGkklwdt4oJx/sodBHQttkzg5q1qssIbms?=
 =?us-ascii?Q?yawGzxyRTBzVoyyZS4JQsh3KnoRMvV7+wV7A4RoORQmrUW27Si4gBU6iUjRo?=
 =?us-ascii?Q?KTHLga2xKRODJ0s7b5VZ43Mv2MHpGCIpeYxsN2KRTKzi9BipkBVXVS9doGCt?=
 =?us-ascii?Q?p6NyfM30V0KMdNP5+wuXWTQ39qUovk+cBy1/MUoo2YSXiMINsi7Hf1aNXVQ5?=
 =?us-ascii?Q?iKFpW/gdMKWCeivVQfPqLBGRCje6IxaoEUSYSO3/sU1mDfrpExBV/sueGCnx?=
 =?us-ascii?Q?1XLmJ1v908RWW3MWtZMT49VzyP74JxQ4tYcSToWTYnw8sSte0n2x+4occG5C?=
 =?us-ascii?Q?Uy4gxD5S4STHd7RlmNeD0taXLLHX0vQWsRjCNemfK+99MvXpHs0Mxs2YpDMB?=
 =?us-ascii?Q?vtzPNyVuTDWk1yAEolU/JElfVC8mJTVMdP4kkI4CXWs10XAp5n+ELFaXRCkc?=
 =?us-ascii?Q?H5+1GwLGIDLfRBYFeSb99YNrnV4SweGw70SA5vyAjNbR0pzTxLpzTtAo9e9S?=
 =?us-ascii?Q?X8zfh3SG06kZ24lkSIw4CdaE35jrG+UwcGWfYY911ZY6109FEB/uc8wEVGY9?=
 =?us-ascii?Q?JWSdNOVHiPiotr8cEl1k7nSTp/leJAHgdIOvzE1gSQXc26daOuBHsbOW3OFo?=
 =?us-ascii?Q?8YVUD0AHqg7xw33GsgqCP4mLovTqeS7xRxp/aj/6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9610c892-bb44-43bf-6a9e-08dbe4dcbfce
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:41:36.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiGzjmIp4WIc9dkrF+fYZI4Oo9giMksR/bWQkMpZyQSpLjtFWwxGDYcld32KCg8crOvo7ve0Q6JYwd/1LZymjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

In most scripts timeout_poll is defined to 30, but in diag.sh,
it's 100. To maintain consistency with other scripts, this patch
changes it to 30.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index c7a7c0d2792c..b5a17d2b6723 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-timeout_poll=100
+timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 
 flush_pids()
-- 
2.35.3

