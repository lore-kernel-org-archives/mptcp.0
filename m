Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D982813
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STLdRW5iYLnDZP5Hvq2/0X0YUh/+5EPeDZFONurMfS0bV3AE3hSlHPzrf2/ZcbDJXJ3PPNh1GQACFk2sKXh9vpYNSsYw/6gtubxWK9PMRwoxvS3PtIVuTP7/ogdYvajnXZYupG85uQRYMT89CTK995b/OfEvHP7SJ5s96ndjjYzjbOiM7tBvpGbuzguKZAs96CC8dS2IWA30liKULtDxWaHPQjKH0vrjhIXZbctDuvifYz5WC6DZ9IQXGAUweHqWd++FDfl2CNG5/6FohSvwLidS0E54YZc64Iw7SzQjF2fZVF6bgcugJjfWFG4n/reBxs9WxPIn8SRAa/Ls1EnO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAAXpxTwQ1Zi08PGAKLlb0QSz/kVoLq/lZtYIFLzxNM=;
 b=eSIVEHCMvTj/M/ePpFQnFXufnz7noUMxcwVYTW544UoiWIF4DS3S/ss4u0Jg3p8qkbDS70FftZ4myC5R/nmjG9fudnlUA/WLWU9b6pcz4YZ5ObTXVgScEJhevhwa7FMGr9Ab0XMxZBBB+Uv5uvvTq9hKU8afaWqtNUYpQzqTFXJNPvKHqazqK+4cNjbqhagxpMSYybJ8ssDWvJGZBoW+Di+gn3Y/fFqZmBdsXSp6kZdltDuAKt697YyDLRa+cMZYv/2m+PE//AyNE5MFumZDbxuGBZSnyPcqnY+t0xrIdn8dAnrJW7U34TE2l3NNrOgmArtreS0tvesR981C/Vpupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAAXpxTwQ1Zi08PGAKLlb0QSz/kVoLq/lZtYIFLzxNM=;
 b=C7EwWVMkSGOFndtKB53gwe78A6mgqPPIc27aXM5HlXPTPN+NH09RXhYR07qjq/4SVpqMDOFkjOEO8+h63QtffxYqv4oCcSgiMHbXb9zSOcHMoNDQkHJZdXoo2IkVRNRHIzziwvTz5gR8Vn57oHRtFgmmoLBOXHdu/CH8nwY+wLDaK2RlqAH0R6RAYkZsoDRIDhqIQtSVkuwnmHJ6AR4GpIhACnw5RImV/q+b/SByqOFEKIa0IKXZwaLL4U5irTTDSOoMEhYpplhf2HFwGBmel7KA6CGKsDUm82uFWPUPGKLIfggv47OQYjr2a/iabNnCmvhCKmR0Sj0gJNLs3LihvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:46:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:46:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 08/18] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Tue,  6 Jun 2023 14:45:07 +0800
Message-Id: <630d69f631295955c7c3b146135387c019bbae74.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d880caf-0ab2-48e8-9d5d-08db6659b333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qcSOjR2tacTdgF8Ocqh2v/btjdrxwny9cgGXNk3A4jRBTl10VUdvcoFIDHDvE3IPX9SSHC8gKU0I8ja8MI7m0AL9Sb/JmPZpyg9Sv/WaKeE1szRNpTfCO9toORcJ2RXTN5G3YREX+/q5JmwO8mkKCnEKbDCdFzT6D0kH17F266BhsbUhC6xwntU/tGsTPXEq4byWZTn0ae/ZCxxD7H2LZJSgaioDNlpI+PDhIBOFv0UeJFMnAnYpzwlpLfPtZLM8EQbzg2EZeo8VHhpdWwmKe1h0OHmUOV9R6qiGVCSI941QlKfQPdLBNnqN2ZVvj3GkWrMGa2cNi5eORm0CriwtxTKEcDC/22lvHu8mNc/PENcfri2cDKMyGB1gjB7BQuYYIAB8+F1Kn4vH1FFmu2noyMugo9KMa6fh2FUbvvccwXcs+t/lXt3Y8ffGJMwUewhTd1aOd3+QgdFxtCM8WYeLpn4T3eZ/GDfJj8ye3VRZ2wJTNlscg9TDnpWzY2IToD9yse1lqorLYv2owLjTHx10A0Bv1Ghl15BpYlK+NI+KNhsleH/dxOklM0ShCInjK/6/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(2906002)(478600001)(8936002)(5660300002)(8676002)(4326008)(44832011)(36756003)(4744005)(86362001)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(83380400001)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(107886003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MMi3+SuZ2VudlSTek50etaj7w0V0Ptlo6XNNz6Zz94l4KuXmRvPhC4xFUFwl?=
 =?us-ascii?Q?GjnZ7G+qUsioVu06tftYQHBhQjzx1iqhZObwVsoeGXbFaaf/W6e0e74RCiPR?=
 =?us-ascii?Q?7BKjnOmAlXD+c47ne21m4n5GEhTDw3uBaYOV1poB9vT+s9LsoPNzW7ZS8Hia?=
 =?us-ascii?Q?nT79C16HgjOu03WQ5yi6tg76RwoDdza3+gwDLO5ETaEcb45fXApefginxPih?=
 =?us-ascii?Q?WmuIjFkgrehAeT0Cl5vNJPFKzThtboVnhsqJln6kiW1JZaZ3PgQ3uFTQ5wAI?=
 =?us-ascii?Q?2M6moDFUzjmoYG/BZ9qSJElHRNzr/AznDhEiu3GbTZPr3GfN2Nhb/9LdoaL/?=
 =?us-ascii?Q?9/nzUtRYEzgxTCjpU8xul28eJN4a8vGZNGlqeV9gzhy7PSsLHEg4GN1CSL3Z?=
 =?us-ascii?Q?FK9kR9CVNr+MP5d1+htpmWQiil4wmA1CL7vb9Mo1PwjBxKftyqN7J7NkL65a?=
 =?us-ascii?Q?bdEDprLk66nJ3/jjgzzAyeZIyCSB+WdbK4BNtfoRQaO+t9eguAKvZMHfuRw7?=
 =?us-ascii?Q?ZgW/6Ksf8vIUV16H918D84DTVmfqxYIF+OF1R+9fkeUdM4XICi/2Ahgs+Sbc?=
 =?us-ascii?Q?uEPSzzs8brdS9MFV+V1gE0wMmPcvYcjB6RvrKLqQueo5muc5H7zqisLlCq2F?=
 =?us-ascii?Q?EJUQG081SIF5XFHqjBFdGX1JIkiqXm4p/ydTp3W8C9Mm+ktRxmNSyWAxvblm?=
 =?us-ascii?Q?8Ws6hLqeH7ChAFix5pD2gO29itmOWrjDHZh8/oGiCWmiudZHpAfHeoSlzZau?=
 =?us-ascii?Q?JQksAsQ4tDbyXX9aa8lkfGBfYyPjmU5drzK6MrfPmKfvIqCHnm6aq2kFKzcL?=
 =?us-ascii?Q?lrBymJXgQIdPE5FgFJMYom/KNevItWTRokEgrQYCfWDSRicpYGSGxv494BYt?=
 =?us-ascii?Q?MMGLc2COkZxSwZ12Sfurhy4fK4A8sHzjMdJjE2rjwIzUFkO2o55WqEGEW+bo?=
 =?us-ascii?Q?cme3DWec9afR8U+T51qYK3FFGbPTv7Fc2xb2wq6nsvGh1UBtGFuIbB0HVOcD?=
 =?us-ascii?Q?bBZzJ6R+2VY67GJYLnhbgxEgk5hikH/XcuC8ZtJbXeUeh5gV6VofaznZEv/J?=
 =?us-ascii?Q?qRm2AuKD25wOkli4b5Zsc9ao20Ts9XpVpz4wAH8VmO47Hu2iNZKeNby5nATO?=
 =?us-ascii?Q?y4BJRr20kM/WY1y3qvSTDwjEOhso1xJONLfp+TH4qo+AozxtztakNJ5ytHx+?=
 =?us-ascii?Q?zJHWp9qEd3c92AoHwUouRYPJrxwSRFeRptdNZAcs5Lc0ZxbWbZSScvB2UUBX?=
 =?us-ascii?Q?Gdo8TofyTU/Sf5lNO/o//Lm8/Si5wjR5sVYP6efxVn9SSsA7y91Rxn7PxvQ8?=
 =?us-ascii?Q?QCKjdRJ2Wk9IyV/K2ZTLxpSTNdI3JAPHdGlbPIVx0OpyVzIhIXaugv2Wv0/N?=
 =?us-ascii?Q?L0hNffSbDiyqo3Mkx8GfIqGLRIbtwJo93zSc857SOJ/gOSf+CYoQqZIiSj/M?=
 =?us-ascii?Q?TSIQjcgUz+rFwfKfahO7NcIkP/divJOGj7oxdgLEAtqZvUd9ZeYhdZOP33IP?=
 =?us-ascii?Q?4ec4n0HZpLYNxfi3F4Uid2oUH3GBNZG4FJAk4zgyRqTO2XH/zjuCLBYc564H?=
 =?us-ascii?Q?tgfvJNV7F4sfC/eNHYlfki+zKb77TjJzdoTo2WeL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d880caf-0ab2-48e8-9d5d-08db6659b333
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:46:04.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYXUJqUBrrOY0JH9XM02zWxtZ1ofbdVb+4C30u4fq7yGePAL1bD1wPS+1PxI99EGGnoLB+HAp3wkCmFgMCqFGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

Use two tabs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 72c618037386..fcb023a749ad 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -239,7 +239,7 @@ struct mptcp_subflow_context {
 } __attribute__((preserve_access_index));
 
 struct mptcp_sched_data {
-	bool	reinject;
+	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 } __attribute__((preserve_access_index));
 
-- 
2.35.3

