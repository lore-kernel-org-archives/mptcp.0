Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135CD7B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcUNCfO7it77UoKA8EZpGJL1RHBvXzy5j4x0PIJz08AFVa6oYApquea6AKQgDCmpB7oYQaUSLgqZT5xweg16/2umhe7efTWvxsgZ3zdo2EI59SdEKeP3rgD3efAoULZF0Zl4AxHp/qNmtzE8X0Sk6O8+XkzIcfmTjx61nqv6fsYI2m1PrrplWmOv1j/4Ze/xwSblBtN0Dw2KiiZdk5++WRqrkzMX01enEe/JzaOXrky9lOTjhqmKG7gNNn1r4D2Exs1TeNxxzD7sZiwAD532DctgfSvn03umCAkspnyI8xQS0YpH77DIkonhr5E2lmY1BjiZ6hBh5DEAkS8Z7CDaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjQXIsJdjiY4r9nl0TaOY9x6sm5nIbmJf+7q5FvZUqE=;
 b=CUKqJIeWAcmcAMGIcgA0y/SNRPRYXcF0rDEgOKBoP7XnMp0PmEwzf4sHtLO7yoyuCpTtfvXwIGze/53WWYZl5vbgimqPH6nGkYEMe5synCXjH5w0NQdUzscKzeghEPJdi4lUVz0/fl4tgCfC3AixTw4fmTNSpeQarLr3RCdTreGW5W8X4CDPxMKgBoHorFdY37UBI1b39IwkfJacw/PlgUdP2wxvldKc2HJ2XgNQ3REnJjJxycbnEBdzWzMSrhB6XdDqEPGku8YHtmt8xT4ktjfbJmQq95a911l6g/gfvYt64hDc9oXwDypILB52yXUgCCe/D1Zk5wekTtYtTuIOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjQXIsJdjiY4r9nl0TaOY9x6sm5nIbmJf+7q5FvZUqE=;
 b=uc5BBYu2oLL+NV3QUfyARrypgQ20DtrnodTZbtYoqbmSomCOe8xrGfvw/bt9i6hXL0eDwFpPC3kdZKYDpO6ELlXZQd8y1Fi7TQqtkUWHls72Yw1j1NaOa1QzKrvSEizU4ocYMoeUHRxieQ1t1W2E00PzNQ7DK4/gaI/E94oJ+Yo2m8wSVEbRhD87dVaCO6C8ewsB8asKBdqECIA93G6/7wfm0zBFUiMC8jsCEojDhH/dnMsCXBvLf8O8Uq3cmcyBTD3cEYcQ4T2maU0q6+dSuRCr9tcYe+waE1A4GxBbKlRMfe1G182IGCk4ELjeky5n5AvSZk2/LyQP+UWUDe1zYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8245.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:02:48 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:02:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 13/19] mptcp: use get_send wrapper in mptcp_push_pending
Date: Fri, 21 Oct 2022 19:00:05 +0800
Message-Id: <c4ec2e6fb80e59f3a051196731de60e1fcc8c6b5.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0239.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::35) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ff7d0a-0f8e-459b-a292-08dab353c986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W98WVwnBq2n2iJ6J6LL+eHgDBwjBZVP+mX1Q/iYlVCmQRpU7TlhHG68S4N88ncwqdJ/DLDg1xC8474MBCRG3hBvHDsGtZsobyPQjEg5nA0GQZqmLcSHGpEHTAp5Uw1YLwyQxC5qfy/etndOE0ZxnNHo1jAppJwcNWsyX2bVTA1YBhjIF3DNBpQ16NmXOJWy7NHvyCeQAEymcx7ZYAhHIq8Y89RIkggmmRu1Kjs2neI/c6L5grE2ELBmagzbdpcLovepGCc0WjAy4DQz5R2AtaQf70HLlxVhCvB9EiGak6qcjiJyI7ZMgcGLdRs0pQk7Ie2M0T8AvpnDmMkIQuz4GtGEzX4bD/AHXpINYTRMFUXlmj0+2W2wbQEQJulcVbjmRqWTbA1g/gkD68RYjEMLcWchwWfshmUQjfNE+i4fxne31P7erYpTfohxdlRpxGw3DyR3ynYzgERM+ytt9t07atxNmK6RLp32ODGfX3mCh4drPqrIlcKzkXmpbCNgFn2lYUBdL78aUF504MjIWC/6AiMafzRGHW9gTMZykv7hE579fcP0kSq8rDx6Zjbufl+NCJMc4YAnJuY8/6OiZMlVt0RE/8a3Z9rHE8k1R/wlXVFN+yQZ1B8lsdhj0HpCP+6q69Lwe6wjrybUACvtgc69Xj0ejppK93v+4G863/BUxbiijhI5Fb/UomRXg4dvMt8DlyFWzuNAy16bqvmskNNMw/IGvV0lgQzqClua/2rBVFQ0qE7uaUCJ5sEytUqjL90Yw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199015)(83380400001)(186003)(6506007)(2906002)(44832011)(38100700002)(86362001)(2616005)(4326008)(107886003)(41300700001)(5660300002)(6666004)(6916009)(26005)(478600001)(8936002)(6512007)(66946007)(6486002)(66556008)(66476007)(316002)(8676002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fvJBrZu1ugwXH9y841uHS4te11BkspxzGL5mIeUVjogUtf17h+0KzJM7XjX/?=
 =?us-ascii?Q?HDdAcYpb4Q/woGshwJbgnlVdS3m3vc9sv+1DQ+TLW5/fBdlaimFV8gu3H96r?=
 =?us-ascii?Q?uZL0fpj/wtcmO9T31L1KrEHLgsGRu5ekzQnsGEXAfct9yEziK5xSqcHI/KRr?=
 =?us-ascii?Q?scBXsMhGTNpBP+D93BHYBSJ6qLgpdd+tKnGEySTWrjQMOQYdlPXEW07xJhU2?=
 =?us-ascii?Q?H1s9zNMZA8HxT8upYMEb8MrfAEiPSN1w2IWbv34spUBL00lDM4at4g4RyxFU?=
 =?us-ascii?Q?5MaEaAf3n9njLXI6fwAYmhhgI4AbleW4lhGkwn3gb0D7vg6dZ3D2x/rvgj0o?=
 =?us-ascii?Q?khU9kT+qQltbKiv1dS8Ykamz666tdzmqNJ1jhAMfCen8TCKEZ7ygWkw2OdAo?=
 =?us-ascii?Q?fZN4GtUsGPYlnu/Qn5JMDixt3kjf6nK6fLVfxW4pEoKd7mYwbJh1begzRAqn?=
 =?us-ascii?Q?g5P93vTtpkxCoM+AuAIO/gnSDKaaWVw48aDhmT7vd2bVzT8txJpnlrntwk/1?=
 =?us-ascii?Q?IICxcTYP2J5m7xM8p6Y+7KiEITu9r0CGKUcBSv46dMxGdGppjx6JmGCtFdwP?=
 =?us-ascii?Q?LD8f+kCwLGyX3fXOAImf+QmpCu0ftIv2gL1iECILu8SpRacIe+OlcHECViEe?=
 =?us-ascii?Q?PSwJTpBajmMWkVpCegP+tQA7J5QAfaYCN2QobV7v+6whfmsNhu4lMd0LGywQ?=
 =?us-ascii?Q?jKEugl+/Uyn6+yRbYWbrfU+knGevHPiWb4oOddzuBV6no8DBGr1wp324UfR9?=
 =?us-ascii?Q?K0DFTuACcBalkG/0uJJTM6owweQ/OZGyZr6lmaAIMncapAk7xyg3q7+kYJtr?=
 =?us-ascii?Q?tyF0pLPQqb92jK9/oJ08YYdzbjH2BCAKnCGtQDKG3HlEJzq2y6WfbHWmODbA?=
 =?us-ascii?Q?6pH4qiwK3fQCqJPL54gYecAYnw03Qn48jdmJ7Ex40AT0aIy6pMeZa8xjzttH?=
 =?us-ascii?Q?1nawrnHWL44/UWhZT2sy99kt+RR/CiNzAXIQJCMwLUPq68gi9PLC+bGqR2ll?=
 =?us-ascii?Q?dFsbGFaRp/Wcdm6bT/UQc5tbdNhcesuFRklqoSnKnUXyWNi1teUzchLv9QTY?=
 =?us-ascii?Q?PjemjnNcw/YbnQbYC++6/s8ENx7tNZ5grq+QJ/awrD6MB5QIALcMN8savoxN?=
 =?us-ascii?Q?ssW2noB20ijR6PUZ3H4VeZKST+kItwnft5NB0puIOgj0XXqIWZ9Zjsh0HtAN?=
 =?us-ascii?Q?cAWB4xd1fWO5wai59il+FPH51A2XV/Rx3/kqt00JBFXjIl7OLGj8yPaRScis?=
 =?us-ascii?Q?X0rBerQp32SUhI2XK0QFKUoyIlqXSUoMMBVeUhE2D0xG+BZ8YiU1ZqfrApdp?=
 =?us-ascii?Q?SAVwDJHEAGwk9aeRQVMGILUIlFYlich0hwnxnmUTyIGnEt9woY13M8DjnPFm?=
 =?us-ascii?Q?JbdPwjzX8RT10bohE+D5GwAoOr1x9OGq7Sk5FFIdPCd+4lFKXCuXit0TS4bS?=
 =?us-ascii?Q?Lx1kJmSDGAzo2zWQskPY/jhVFmZ2/TOZbFvcDgTo3pyWV2Iu6Bu1x2nLal0S?=
 =?us-ascii?Q?SGAMvw+mzIhHO6CmokZpPD/KP5W/Ma9il+MF6GDweO+unA7S/bDLB4kIK7/E?=
 =?us-ascii?Q?FullVsqkm1dB0Uv0XzLtSWeegDOWk5hlZkE++qv/K6PjOyupd4n5iHIe2kPc?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ff7d0a-0f8e-459b-a292-08dab353c986
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:02:48.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mp+j2fZg1W6UmYr4xjQwZKpVUQwR7Sr/A7N3yBcQ9GKhWJJxBszK/xSrviwO5ZLM1u1Xgp9igltdyjinafTgag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8245

This patch adds the multiple subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send() in
it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 52 ++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c55e0fff6a18..56c76cae93ba 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1563,36 +1563,42 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.flags = flags,
 	};
 	int ret = 0;
 
-	while (mptcp_send_head(sk)) {
-		prev_ssk = ssk;
-		ssk = mptcp_subflow_get_send(msk);
-
-		/* First check. If the ssk has changed since
-		 * the last round, release prev_ssk
-		 */
-		if (ssk != prev_ssk && prev_ssk)
-			mptcp_push_release(prev_ssk, &info);
-		if (!ssk)
-			goto out;
+again:
+	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				prev_ssk = ssk;
+				ssk = mptcp_subflow_tcp_sock(subflow);
 
-		/* Need to lock the new subflow only if different
-		 * from the previous one, otherwise we are still
-		 * helding the relevant lock
-		 */
-		if (ssk != prev_ssk)
-			lock_sock(ssk);
+				/* First check. If the ssk has changed since
+				 * the last round, release prev_ssk
+				 */
+				if (ssk != prev_ssk && prev_ssk)
+					mptcp_push_release(prev_ssk, &info);
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			mptcp_push_release(ssk, &info);
-			goto out;
+				/* Need to lock the new subflow only if different
+				 * from the previous one, otherwise we are still
+				 * helding the relevant lock
+				 */
+				if (ssk != prev_ssk)
+					lock_sock(ssk);
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						goto again;
+					mptcp_push_release(ssk, &info);
+					goto out;
+				}
+				msk->sched->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
-- 
2.35.3

