Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACB37F
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYwh9ER0AGg8qijdM46feUuS4WQZ2yKqLYs//5L1wFVBg3pW147xYDwUsaEBm3QeI4QS9iNES/eZOnI7dWond2hElH73yuxoeLlGn1TawvpHq4vcYexicrBv9Ds6ckKOvKt0isq6UkSZ8VfPs0PpBRsa2//7Y9fGPgotz2Uph/rBIrQN+STBVwFrOHW4xFTH3gx3d9wDl3I2E7U6PcS/gCt4d+4bphjLSapCw0Lu8C6Q5cgvoP0ZwM43ZMYlye9A4KeJbViGP/dzixtIr9y2h7G6bGNoqrCatkyZG5COLs3PKkv/a8x/8nwFm3hvWHiRJXvBj6sqDlL7wAE9swMP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLVtp6IWJFS6apXb0Wc6XnFsdPuOu2F4y4I7AL9lwtU=;
 b=CwKfnDizTJG1iiyNt/OqwQXE3AVSMPSTlquudVparbss/a0TxjvAaNZtKV8vlZFcZdd2ZSLWrTtcjIwvdNDpw/8zLx7hcdDZ/49OGzDMEjnfjXS4HB7WnIRra2V64lHaIEIXFFDbgWX7k+dQpDxb3niqxq9dNVblvw/uRwL9P48hCC5CU2nmTBUXw+eBMIOoUQGMC02zCHuUkgflB1Kw+zrTvuEwjBbhxt9PIhehUCHGP9FHiclZYo1AcuDhAWhYaQ8opNgYAh7NAyRaMqJ43m1+0md1Oi/xyxd2FkPNJ6ZVX3OzF2nubmBBGc9fWlrdudujLsP1NYNz0NcEWNkStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLVtp6IWJFS6apXb0Wc6XnFsdPuOu2F4y4I7AL9lwtU=;
 b=TRPZrBlHtPsSo7/+HTpEfba2wLxtM72JTtH/eGFBUTKTDnPpkCP0cOGPTPiEgusjm65nT6/K+BGTokCY7T39nPXe1ug9UW+a1tUqofVBHfv3/Cwr5Qm8LtVKQdgoqDEPtVIUw7NLqFWNdmAxlvhnD7urXDQjZtN/Q2rp5LpPhR46KXk1oyWQsmYIjUeJ+1bqGPAw27knj20vSuUHs0cY8syeIVXP1yGa0Hkbdln3Cp8IcWuWbVbLuQ+pPxMUoNsv0smDQLVE+i6TkVeEwlErns2sX1CIQL7H0pDpVaZkzsIGdJFqCg2kdicEpLIjmFbxPQOs28SaJxf1wyy70J7xnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:23:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:23:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 11/23] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Wed, 14 Jun 2023 10:20:58 +0800
Message-Id: <d04855df3b192321df80577a49ece80e7f9bd456.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab17747-8cc0-4ba5-cb56-08db6c7e5048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TXGYmPOJ61h0IIpPwTiSTrHbAc+CNzxoyrpeNLLUKO5P5YE1JQnXDN4w1CrvklrTC+ApQmrzBjHjfH1ZwLTtJv42J3MaJB+ArYG+ng39m/1HDUuwasVQUvoqHyGG1aOcSPXorhNqAaIA16bB9urwyRimHu2moCSyeFN0bKRbS7W+QeiJIJkh1IPLuCMkMVO+HOPE+Sp42Mfn6HcWagaAOdr/q7pkJW4gn8UXVoPD94bW+dmkbq0dTFll3wSmLnQt2eXqnCW5gWqGnFk967h3ADZrlZizh3Oyp97VnoIbPNphI7FUVjNCUjBcuDah+JFcEKv/OsJzbVK9MPjzyMgMHr0javUZZ8MRg03XYPHoKnqQnbRn1MLyCcIJo3+ycfc6+mdJXQ/OCADysm/186DUFC3HNR82rEOmCVIvWuvKZQhAh6FNTB+a0/WyiUMlv9+6lk0KzCeTkALE/2Gg8NFc2QK5MiMnSHlS9ucOnCAikpEw+rlQcFxQNl+cwY193rD+2dl5tnr4OznrwZLJ5zT6EqdvZMkgq/ZiLBuogIpVatwYC9CDOPQAcwyw01PJVk5b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HJsp6oQQYsag9MufNnOpaMYpSu2MxyRuEYkDGX8czIUmnznvgDpvSauM/ZnF?=
 =?us-ascii?Q?ZQ0T3Sn/XCnomeR3JkIC3d1C1jR1n2eVbBPGqZti42K29rTLr+tnVmz/ATGo?=
 =?us-ascii?Q?MMB5P2xezDBBN6tWpkR3sKgUnlcxnwahtmJS2yCYdKGecRTod32BRMM2bfez?=
 =?us-ascii?Q?rwyEyDuV8ybTUyYfqxP/Ika4MFahyBh8+I60BOZGuC3xFYoZLbHQmsyFn+UV?=
 =?us-ascii?Q?uviYE+fm8zNIoc+oxqjN/WuwYHwU5ebHeC9nlP+wqUCVCzwIRTgzQy0/2ggk?=
 =?us-ascii?Q?JY4bmpDk9cuxw/9lCQo8jNS//1HBc3SLIy3saG19eP0CEZRCNxY/dh2v7SaC?=
 =?us-ascii?Q?LMa0iWjuAOJptN80D0QmCQgW+ng4Iw3Ut1r0jSsun8rPzN9fCQu/KLgZpD/t?=
 =?us-ascii?Q?OKKjfd6zSics7w3ABMnbOkAw2N6U7SRBQjdxeXG9k6eW48THgoG72SR5OcYQ?=
 =?us-ascii?Q?tqWinK8/x1DviHx3CMXXVctsCty5Iohn47vhs63xqssEbg9PqmaxEftvVygP?=
 =?us-ascii?Q?shZiWlyCnGriW30i6Nk3O781dm8Cl6eBATZvzXCyB/EhzlhE1x1AYYEKWtMQ?=
 =?us-ascii?Q?FFu3a6ELEyhvprHXT5d1yeGUbYd7Ne+D1QH11bGUsXx7Gn7ZvnaR72WmgWg/?=
 =?us-ascii?Q?gG2k8kV+1I//SuUcOBfgXqhuQSS5nsHVRKuIP24q0i+BdPJMz1L2mft38tyU?=
 =?us-ascii?Q?TSiTHX1WYfkLhNu0xQVlXxZpcPj1fXsvDEiBUgSlUQssuPalM43GkXbVUUXJ?=
 =?us-ascii?Q?rlLvK/dF3XTRk5PgLYh9HEWrv1cJJORPdm4yeyUtbLxy3fAfeT/2NDUFtAJF?=
 =?us-ascii?Q?lL31lSiG6jREetGRpq8lgV5yg+vt7F+OsqFjJtwy/Afm1OPk6iGaWZQDCIZJ?=
 =?us-ascii?Q?M0NXrBQieu+5nd/mfFmHyNeug3iVcI8QiARRrnsPSw4Rw8wsfjtE3/DTmt7J?=
 =?us-ascii?Q?0quVMT1kzFc3mVM04XdJUxaNAZvwafwnjGoZpr0MCNPFZ2hggfTHN9jQ5q+9?=
 =?us-ascii?Q?tZowUXdjpis8VMJGQCfJ9LlgkMcNMh4/3aljw+1otxhnvtAkCORjWvdY9P+5?=
 =?us-ascii?Q?XPqXiIG1bW52JWeSbcoMl9HMTzuJopD6GMsnwjLW0aNZ8TvBSBoblJCBWkXY?=
 =?us-ascii?Q?uJFIbfE8/eDb1Xh3t66uxE3WMXV5k0Ll99uaIf2C9TLoqt4YOzk8Do9ALiAU?=
 =?us-ascii?Q?oyP+8dSCodZmtavBIjp6zsrvhJW5EJuhsfxySFNmJsh1YEGG2vPt9mZeo0TV?=
 =?us-ascii?Q?I+y1U3nm1+MRfU2OMmVfmYB3wr9zbPJxn+sRPlHc3IKdQq6zcUepejXOYYL7?=
 =?us-ascii?Q?uOyoR947joAxkprWBidHgT1qCoPENq8WRKYrAof38Ej0qeXgt4jBI7gHrpEa?=
 =?us-ascii?Q?Zsv+jDGwgx9+Ns5wr9REkz0I5vtRXDYz/nbmOsgC7dolj6asynSxj3oupz+I?=
 =?us-ascii?Q?upL9W31nnHi9FAX96AVqHUzTPZo/DXDumdh7q5Z3F7mvdKbrUTRBq11Nc91G?=
 =?us-ascii?Q?xdhpIOk8TSWAlVCnQBcX4bNNjAKksC90jrfx2vzNT5B30tAiKlbC29+EF4bs?=
 =?us-ascii?Q?H8J2yJa9FN2yMMvWukGxlvpkxYNkELYaMzQyQDPY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab17747-8cc0-4ba5-cb56-08db6c7e5048
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:23:17.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EE26Ek8Io40elr1BkQgP/PXmWCt8/IGV7JXRiGIchjREwDN1uRAEJwiLIuLYAmTQJOObv4qJOckTm+NDxwJuQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

Use two tabs before reinject.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 72c618037386..60b9ad35112b 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -239,8 +239,8 @@ struct mptcp_subflow_context {
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
-	bool	reinject;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
+	bool		reinject;
+	__u8		subflows;
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_ops {
@@ -262,6 +262,7 @@ struct mptcp_sock {
 	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_data sched_data;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
 
@@ -269,5 +270,7 @@ extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
 extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data) __ksym;
+extern struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos) __ksym;
 
 #endif
-- 
2.35.3

