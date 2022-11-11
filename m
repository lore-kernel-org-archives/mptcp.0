Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C6652
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 07:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0ZUUMnF4W8iKbYyz4/tx7LYKHWvviC3esi1sBUCS8AVvbHzzqkkr8Y8tL3RlbVzHIUuLwaHt/H4yGCDlXxDZgSDYl9qTSbVBnaetyHqmcTA87lor1aVQn03nXZ4jMbP6edlm60+l9hbslS6/h8kmTbX7v1ve7D6ItjpPYqnj63yNC3v0eUfyLl8AkxReBFa4/rVljKSuEpQA5tXgGOWmRIEJ5hprkLwbE3yuqIRhT0XACY/iwdz1N9s4CRwMJT5SBItO9Bn0zAldQ/DEwl3IB3p0u6xMfhhLxCyTMbdXoG3f5yzxJGV9nPd6yTsLJIp0aRGVUn6VEaE7gyN0ix4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=TLUBN7L47pAq/BSzYpFKa/3g7WQCA6IO1KQQRSx2kojkOIC0yisfiVE657pMfSnGw2RKuKSwo4ce3NfaM4tgeyWasCGKGcZNvsQBN/weHp2s/hZvAaXMrmBk6tlIZVp8zAa1hl26SMhedllCL4nmtmH4wY2u83UzO3Ve63xII2fOJ1ZKsER6+NhLdRBUSrsRwlK1q8V1VWmXNTJagh/ljF/Y194nBzL8/a0r1mqxUD2QHNmxKo1QXcYvUNBtiRw9ifjQCEQRip7/nCjqMfVL/wCUMl2HJjB/U+QHgncnu0F5+g/Bxr6ZZrVLkWeiqXpYQlOsOm0q6sNESmjMODcgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=Sf/BZRbPwBBCoD/Iy0RD6a6Or5nQxaWmKMRfqikT7Ya+Xkeju5+ZEGpUKsInrI9gCz1ViYS+MZzHzpyoP5sklTpEC9IteOnkGC+o80M6MqaHDvq+T3T6ttzyAIPyuHk5GkylWSCDmr0X3O1pc6G0vANqfy+Ggt8NjSmyAut6bhfon4CeUb/FmiVwzD2mDcDFAxY7vm8sycSHw27HGF52oARKYxJVq54eFo0wSF0FJujyIoBAMKK663T3VRLx9gwDBVQe2ZMNUCQ7LDTMilVncUiq2zgYRFljCTVHgKpHnf7j5ijKBYKvuqq3HSrOUWbdNbe1S++YscLhcc0JNRM4pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7521.eurprd04.prod.outlook.com (2603:10a6:20b:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 07:48:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 07:48:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 6/9] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Fri, 11 Nov 2022 15:48:01 +0800
Message-Id: <0be28f60c266629f8bd9ce0f54a26d45caa9db3f.1668151131.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668151131.git.geliang.tang@suse.com>
References: <cover.1668151131.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e72d1ba-2411-4a59-416e-08dac3b929cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7jVcg3LFaPPSc9zpkbSfnMUeKl7PYqbwTgohUJBR4dqMfJXXAKRb/0sfK6flZSYztf9TZpIun0ILojIwGkqh7k+3G8ByPRvp5AnKNseOD70oqt6kS/7LsvzcLcGMsYw1iREKp/3ofQlGFr4Apov4cZ5EVDMs5faaOvgXDm+fgkqr3VHbbKAmVXaL5YhnGoU2GqbYdgXpQYSgs51hcJxVIfQ+FRu5LZsXvleRDBC73gs5tOO9v56tcQrmfQhOnKovbNEWt9HJyINn9ZuEdCH8or03ZTfYwadziIBJQUfZKm8GR5FZReIHK4Jp8Ck//6JdnH5Bufa6F2thm+DThIoNPD6GsnKBFOfn+8IJcEg0Qj0wzcjqoijiBQN+1VRtIrQvPFUzYaYcwKsmdtxm9P23ciptfOFfoeav7K2PHjrUk2mYHV/ef+KVAFwJSW/QfmCAQpiwb2JK18gnbST1HoVixR9yAQLAjX6UxRtmrqWOl9Dw59iN4eTm6R3y4htJOmc5xiiJW75eOk5kQTmrY5kMoR3Xe3mbtZwBltANDDhct8rMp6hAQDsBElHGhPuUsIwoIh7fQv0jRZv9ZWZl8fQzR949rnA02eihU+9kNIuZC/WemXGOVfOKY7ysxMXDrWDTETQ/y4zQsCMVhE+OAJIw7fJRHVcrFZMQneMbMe+cTXEB2m+/Cnkc3Bo+Dnr/FAJ2+XS0rFPru+elLYg9mkeFIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(2906002)(86362001)(38100700002)(186003)(44832011)(4326008)(8936002)(6666004)(5660300002)(107886003)(478600001)(4744005)(6512007)(66946007)(41300700001)(26005)(2616005)(66476007)(8676002)(6486002)(6506007)(316002)(6916009)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kEVSdyWEnEKACIlGzJvX2TV/pGBNYqL9MGSYwW/GxPPMX8fVD8stKBrNtaUC?=
 =?us-ascii?Q?l0fhoQldXP0KXIfwsfI45+4Rmt0ZpES0eciNhnLsMKqHEtDsdjSND3TyOx9G?=
 =?us-ascii?Q?t9IDWttWedjquoJ2f4obdl/Wbidr5rmOPOe2SOPJ2sx/cUblsORuHwyqBdFK?=
 =?us-ascii?Q?nWnuJNo4NU+ZX8U1vDow7HFYCaRDOEf4LOFJ63CvC47YqJM5O1abJ9TYLdnf?=
 =?us-ascii?Q?jMXpH1XEbrVWKGjSnxcN9NADdKXQg9LftJ+3GuQ6ZYv2MsOjqxEfuqoTEkNA?=
 =?us-ascii?Q?O2QZuTBn/w/B627DB/1LJ0yxYeG0s8gKYQn3+RIXrOzrvTwr7P4PKN2UECTo?=
 =?us-ascii?Q?jGXbHjk38i1haMYPc96mnCmpFo+UCKbGIPGJXaWK6Ufx8GqH6R130izY4KoC?=
 =?us-ascii?Q?kld695vphEB156Txf2vzxc3KBTzsqw5mYa4yReMMAUQDJWnu0zRXyIL0PQsK?=
 =?us-ascii?Q?dBUv8aPG4aG2avmqGPKgfuIpr8Um4T4ePesH6WgA0wU0FNm6OQ/QNnh0Kk3J?=
 =?us-ascii?Q?+9Qfc2WgAeOocj09TxUf8wTOVHwr5N190i6f8MIwAdF2IDTaNAUvtMe1CQMp?=
 =?us-ascii?Q?pD5H8oobu8SXWV/Iz8T/7pquuQ7wYI3aqOv13i9KsybmOHFgDH/SHR+O9q6u?=
 =?us-ascii?Q?2WKvYa/y7ubmT/MXn4QTGu6neFuVkfLUs4akmMO8inbSqDWIaI9sbEjULRut?=
 =?us-ascii?Q?Iw/hre9Pavy/eoez4evJdYOD4RclPdT+x2//M1QO3c/wsV5osbOU0ckmgzZF?=
 =?us-ascii?Q?6ioXdN90BoOOOM2MKtNsB4s5Kb6bw56nrd692LfrQMUlV7hex0Ir9+uBOiS8?=
 =?us-ascii?Q?JoO0ApcYM9GRbvN8gy9MvKjyltQ3GPCMpLfsOiBu3AURJCiTj+kT1qwBMH15?=
 =?us-ascii?Q?AI4LMkM4jCGhavTNpNbrVPIHRF4PXUVDK3GGREj4p3D2AWekENn4rIr9tVDh?=
 =?us-ascii?Q?W1dexMG6+BKS16yTWWmNo2e6qAiFZ3NfC+nuWLdPts5n2MuwWN2P3+RAyouB?=
 =?us-ascii?Q?n0MXtMskuDdwwiwW5lOQVI4XH45/p1uICp9fx/4jyYdeu+QncKXS4OWvELfJ?=
 =?us-ascii?Q?cMXYj0iWluEN2gjTDZ/axZ2p7BHGMx8UWtHFQOy1i+aNcSNcxwEF4S8ANPeN?=
 =?us-ascii?Q?o38KggqO+fmsd2w70LspXVVArGH512G7aW+HStEAi7Zkrh4uyD/+vSfc3tx9?=
 =?us-ascii?Q?dby7gJEH3GM/bsGImDX8wzibaFGJhWX5awtPRveyf8xC0shESLa0XaeLYC6U?=
 =?us-ascii?Q?lb+zsOXFYsyjEcExtizwN9Ng60CL4d8fPHRukRfAqGIhGsNj0CcXbedx1hbG?=
 =?us-ascii?Q?ZuViTirumHXAVR/sRcDAjLhs4fIYnLLB3Qz0ms+7Nu3JMQdIoOQ2g9VfKyx8?=
 =?us-ascii?Q?LU12Xe57T5utbgylucACBug99iR1eSdWogfaQvbBJ/qu5/RN3N080yvnQ2CF?=
 =?us-ascii?Q?E6P3l+x5SceoEreTKYhR5pXjlKSr+lbZeuKrL2IJAP+29+nKFnK98O/WaSa/?=
 =?us-ascii?Q?FRMCCmZL2S1kCiRM7jIv2eV31yRQTdopfrqZ1tC9mZnlW7DqQnuZb1BktBdi?=
 =?us-ascii?Q?thycLknpwM8SxSNR9gaMBechLZ/7ARZup6MRMqkiJ9TQl061as24jYmIwwCe?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e72d1ba-2411-4a59-416e-08dac3b929cd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 07:48:46.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMi36PiSHGcvoFFg7etGae1addqJhChp5rkDCKrIa2q2RQkAZAXmf7C1WU5gOsta680rjdA74w8Ss/RRJbvh9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7521

Add mptcp_sched_data_set_contexts in kfunc_set.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0a768898990f..03decb05755f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -164,6 +164,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-- 
2.35.3

