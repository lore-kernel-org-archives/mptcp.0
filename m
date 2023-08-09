Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136B6AAB
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 07:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoFuTab6Zy53+/1EozL4oBasonsbTiRte8OuiCApXSNUahmR/BKKb2oq+38RdJ7nFDVczvWgVolV4JXaY+RYKB1HUNVbZWEBMsjKpWjCuX4g9zL1E3VnJIjkqO5G/12LTvTvrqghN9eyOuA11LozMqSa4v7llbR0O1pTfbJBJOl2ebw8CAC1W2Lc/y0lzhv8QeyBkrBF2TbgCEobqYFTyCg37W0QzHNvNGUvvm25NMch+TN2gD9xvAuD56ds3iZ3W4IJ9EEIBbKZayUmSzQogA8oEAhOtsEPcdMNdCjozZgpLMHEGWpCXAmp7CEvee87xsirlI3tGiWBt52j1RKIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJD0orX1Jt0aJHK510OdiPswP8EX95pwWPCsAI/6nsU=;
 b=l4C+VsyklnmpqRBa+yGCJFdsUughlgvLIBrJFKPIkBD8MMtHdHNVbSR+osxDaMPAxXyFiPPwCDoY9uEQ1w7tRqn0mRrOow03LfaYmgmvDaxiGVvV/0D8L/TP5RzC56c/pme8xI/zBfjzv4pOrNEM0uafPRNxMsIcvY0sU23ssoLW0oP+n1zXlxcjGwsH4vtyT3L1zV3A27AkHtkyd2btFAcBxM1mUj4wJP5+IXjWG8BM04KGsK1nWnzpOXUZATJEP4cIVv0PwOOwLqUVOlEgVClp1YF9Kb0jj/eJspKzQXkx1qcK2dObM/Yo+uvbEg/MEslzQCoLA9j3OpVIbQC7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJD0orX1Jt0aJHK510OdiPswP8EX95pwWPCsAI/6nsU=;
 b=rXMR97LSz3Fq5ZKCkNgprgMGulK8CYfQOE4hNBySiz8B9XQ7mEAHwJB5yowDg9G+QCbNig0MfX1E2I7mIaPZ++5kUd5ER7bqP5LhIg34RScqVl/zLDHiYFrsmSbxrShpsx5PHzEeqW7wBlDKu1sBEgewNGm4SVfbi9eeenaJ67HV3IHfdgl2yItGOfo7bBY9u2MFoNj8ppaEXnkpUOFJ43Nm9MRyVZATa8siyYUHxcZNht2znn4MVcCPPoAT46Ae+Dx1dE6E0+TWSeofwBuu0i0xmMoKNmFbMRWCz3mgymiMKa0hg5hTjsabMkEtaNoYCSUG2Gye4zqKi8MNIN9R9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6850.eurprd04.prod.outlook.com (2603:10a6:208:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 07:06:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 07:06:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/4] userspace pm remove id 0 subflow & address
Date: Wed,  9 Aug 2023 15:06:35 +0800
Message-Id: <cover.1691564649.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0290.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 49be429b-e843-4ee0-e38f-08db98a728a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f7ibPJnwnE92kL+8cQ42UIix0CEDrdC8ZfxE3/p7aXfv3wqTfLCMB3d/oU79QHwUBdr3ReHLR13hqvu2TxeTLSFi1Y9QqsOs24bIzxyKANtV3n+m9FeomS6Y2g79Jx+HgG4qDKoSBntGvphTRBjmhBvtCfm73X+rw5REniJWnxoG0OIFRZ+Iq708Asms/7A8REQBmGZqO5VQZUv2gpweM04gdEb/x+Shjjr0bZ/yJsjp879icDjT+Zr20ZMGHJktCzX6TNTjNYvrawR07GImW7fOh4lEunoOgytMr92ZSDdISGepPmy8Tc1cHL2ETNvCRj2GF1p8A+54ZqXfW0qsYL57ya7JFiqSbqllHgcWn2xIKFg6R8BQ7olj/KHTLfLWUehBC+3t5R+SjCauOhkDXJbxtVo1MAza2cwuocX6Slwint5N9pj7aHjNXuYGzVbGmCSMh9guJGya9SXnmK/AQS3lvPgmo4ifT9RAenpP/kAeJjWSTJw8uhlCCGFETTHFRprHwPCK4Dcrx7vPDspF7Pbem6Qf9JrL0zViyfGLKHno1reY8RSn908FqL4gdYSC7L4BfH/dGtQ4NCR0OuuTaJGqqGSu9zMGgmFXtniXWlq5KoC+nzPA4sclKtdKT2sCyL1OOuJ84zfVK4FkbD6Vnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(186006)(451199021)(1800799006)(6506007)(38100700002)(26005)(107886003)(2616005)(83380400001)(2906002)(36756003)(4744005)(5660300002)(44832011)(478600001)(86362001)(966005)(6512007)(6486002)(41300700001)(316002)(8936002)(8676002)(4326008)(66946007)(6916009)(66556008)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ZeXo6YKcV6wcuCu3Fiv1D3q0PgBntxcDVwk9Pj9gktFhrHKY9SSdrIA5qCS?=
 =?us-ascii?Q?5qIbQucTIZT2wpXRnI77UXrD0VOOk1WalREQFmrmJBK6q5jbgyrMKezf2fRm?=
 =?us-ascii?Q?sGg02j8RtHJQfYOTrUcJupkNTwJ1r88adEROo7xLAokfK/PJb6az1G9bWh1o?=
 =?us-ascii?Q?lasD9R8bHlZGoPhbWZfPuhXz1ueNPv8EhqFnHq52k/Sd9opBlxZ1k+D45Bpr?=
 =?us-ascii?Q?oI8fDBXhUQQYknIPi15a6l3sW7C+2MCReWpRze8wHtlmwYnrSJwL4bRsHn9k?=
 =?us-ascii?Q?Sl7E8yM+uKhibdMbD7iReAJRjw0B0ayv0MDbHh36dMjyZQbLejmno77z39Of?=
 =?us-ascii?Q?E9SkumOWc2usedXqqDKE7a6sgDe5NtYeGQktXzJOthmKGqlp8j5UloH8/XDF?=
 =?us-ascii?Q?uXabN6F4WsnCBj9DvRKgL6l+6u8pOWgXPLc5EDPIY+OiDZ+7qhOObfwk9jsx?=
 =?us-ascii?Q?NHYKGh/6gMlwQGNXIVqpqyLsqpEt6SnqTB0IOUoqfAYRa1RDdse91xAd6x92?=
 =?us-ascii?Q?f5o6XuALnwCNOw25oOCbNASkNXFJRU1J93h9Bx9rM9FWMAaPCeJlj0NKg2Vi?=
 =?us-ascii?Q?gGhYvcOdsMXNm6NQJZ/Wxl8Kl8rEJSWQ03hHeCPxZtH8ygeWM5cwqTmP65Rf?=
 =?us-ascii?Q?LUgy7oKYFdkTbHfAE4ai2grVLLjMsvN7/AzcTki2EncTz+GOusTWoIxfkqOJ?=
 =?us-ascii?Q?6EqGnIaL2bTryv1NAADjKNJL91bYqK40i0/lhlwPs7KPCOhV46NNP789VJA6?=
 =?us-ascii?Q?x+FM32C7XEuhSaGpSkYUWJ0XRDPmEWxbzuKixM0JRuVjKVoBf6AB/g5/VHlQ?=
 =?us-ascii?Q?/BnHEq+dA+C6r8p1eTwYLK1Y5+HHsVV8l1yKEIRfG44qN2r951afEiVtHRPS?=
 =?us-ascii?Q?jizXhSvnzgydvjDYFY+iw+K/tvCiS/BuuKTNdLrs0H4PLe2R5hjLiqSFy1HF?=
 =?us-ascii?Q?xhHPwLRMNbZcwyRIIz3sSbRULCG/3fvvRSyfvvkXB71gkny3tAgsM04OTMLb?=
 =?us-ascii?Q?SfV+1EwpEfn4TLTFFRSyKXWw+KQQpdfHHjBhGyqwVLZ1J7AvYCuqQk0aQq5g?=
 =?us-ascii?Q?JsRsgAax2GQ+Z+TpKjQ4pmzwn2GSgYgiejVZnj3hyv4WmMhPu04Gq/R1akn5?=
 =?us-ascii?Q?NZG/Ug0raOPzX1DAAU4Qx1iC96ycxZ6zWl1CPpVanwcALvHa5V6jhOJwPm8W?=
 =?us-ascii?Q?2I76Akthw7qmvT+XOJtx9Lp77VGU8w6mDYvun9cPbnUa2kh6ljsT6zq/APPX?=
 =?us-ascii?Q?PDQjCjGCSaDCgBHmhvtbfgv/zlGRRzzVJFJKV2L7/1dA5XifCBfyFtz0KzCZ?=
 =?us-ascii?Q?64X+YFOunef9b1dmhmwKonIv4wGKA4z1ZqneRfur1GswF/y8t7fVNpK3Fd2y?=
 =?us-ascii?Q?1icPNWUIJNkMOU/hwVcV+0CQ8KwwxsTxHYl7bBEdKlIr8Wdd2ltbiir2QTn3?=
 =?us-ascii?Q?gcN6Q5Bs8Fo9LnS8nOaaBSabHZXu+ugLYIwGtZCGINZZiZRYOG/VSJbDsRYl?=
 =?us-ascii?Q?y8uCvNhpWGgFZcSVE6wI+mR+oH5GD4X1h43VJNuktk3BwmgiRinKyMn3ldK6?=
 =?us-ascii?Q?C0Xc610ptDlHLpLeL6C6CrqJ2ZCV1O40GCtdMCfW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49be429b-e843-4ee0-e38f-08db98a728a4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:06:31.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YcsmQnMLhYxYzM7P/nl/VulBIQ39hvuYiYeTLrc+rBxPklp/qXzWe+a4M8zSx7yhO+jXahSmh+0CnM6TeWObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6850

v2:
 - fix CI errors.

This patchset addresses #379 and #391, add the abilities to remove id 0
subflow and address for userspace PM. And a selftest.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391

Geliang Tang (4):
  mptcp: allow creating id 0 subflow
  mptcp: remove id 0 subflow & address
  selftests: mptcp: add id argument for dsf
  selftests: mptcp: remove id 0 subflow & address

 net/mptcp/pm_userspace.c                      | 46 ++++++++++++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 49 +++++++++++++++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 32 +++++++++++-
 3 files changed, 119 insertions(+), 8 deletions(-)

-- 
2.35.3

