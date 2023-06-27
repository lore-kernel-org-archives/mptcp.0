Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC197FA
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6rIPZucCx8hWf35iOUo2rIl57ByuHSup8gBKjzG8EI2HZJxP2uCXt7noixGElcz52o2CG3PkJN3l2rkpJ/MuNg79ODya2BIF2PwUfHvrNkxw201JQG+chQH8OvB5mz/9utn3FgfJvFd1+oweepnJs33AS3rCNMrW+HPQNeGdIGyAbsk9U910WN+S9QiXrYGc1kKucTcBf7Oon6L+3e+tH74Z3m6pgnWPJJSa7vkasZOr5mWeNO5QuUJ5MjU/CRjjWvaVFGcJoE8OvARvP2uHxrFrvEq7BBQX28p6JJWsmfzzg2naL07NKUjPobvFbxzJA7/ZUS/qXm9noY1xhDECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH/BCo9b6Ymj3RYk1zs3W/CO/8hYS832oSxhpwKvazg=;
 b=PVbGqtn0zAaMv/lpZ64tIGehPFCOAf1MKVQISoxP1ebANt2og+erd9VCpuRIPpK04I6FXeWNN70PL85/8ql/+GTvogzH9VcmQ+XM09MqbrHN0MzoyUSRaK3Yta20ZY5B585jnA+DllEap7FadzqjYwiHlzbKjZvQFI+2Z+xE9vvptjX+/SA3qDNNNWqRpG4zdA+I3QhMxPSo9tA9PL9dZJLYwPHfZalGNTTUZx9BL7kHq2nJCQnDOjw7RahNdVHEpy7YQu518vz8+v1e74szHpBc5Y8Yj3bCGUsBWAihhpi+iDAkukh3FGUiQAKi1UJoju1ZyVtMkB2l/WLhWdojzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH/BCo9b6Ymj3RYk1zs3W/CO/8hYS832oSxhpwKvazg=;
 b=Tkfy1NrTAHt8N8OnQjNw3otFXNdWFbAnxkrDQbXwrDAYSkft8ape/kBJRLRQPUi5Ag12sRd4r3w55sBu6tFyP8uiDosaddeVuJxbybJN1WBIuWHMAPzBOebiWYTLft2J/wz0Muu7OBNnkUbEBRLZXFB0rXk0VUrMEPpB4+7zkZOHNcNeuqqaNj5jGGpOkhKTAO2rVNZYq6nfvY3AZwRC3kEwkeGwf3KX1YDo7hO5HhuUEo/s+/Ja0VnIzY0qD/o9F48bTvV1RgyA28NOk9J7HsYA+PiXLAU6ikYBMtMcpsPVFU8qOofIJx5WoV/zwPGwdrdl78q6qReAxhhnK4ryZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB9922.eurprd04.prod.outlook.com (2603:10a6:20b:67c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:07:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:07:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 08/11] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Tue, 27 Jun 2023 09:06:51 +0800
Message-Id: <d04d890adabe8e6c43cadfd3de3058b717f57232.1687827857.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687827857.git.geliang.tang@suse.com>
References: <cover.1687827857.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB9922:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afec71d-1bf3-4daa-d415-08db76aaf015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P4T04IlejU/I4pcVmxWpL5UOqeiISRikuMA1Y3aTf2hhaln0xYA4wOfmyFxGswBAa4G6xQNYBF+IUpKiwMfHA4Hgb1OzLbGKzD4o6B0EhgdZhiZT5GNRHi0PLWqzOLkl5RjTbwq4S0Zx80W5spFZMJjPSzbyg+YhKCC0huQ/Jd5ljNFi+3ckIgc1oRLgzjPTYxUpdd/5aY1W06QkuFnTwAX0/qBNc6iTZSLdAHKirlR0c1LrGebwQFALuShr4bzAGFR1IcoczT7iMlY59fw5qKIDuhlAtC3WH7Zs6LeiRYg9f87ac3N+sqW3qs/9jwdnTsTqDQQ4aLgVO3YIiszMmnlj3qGZQECC48cGcWG8GwepcIbqemoPugWs7EscL3+eYw8vWFlyDcO4FBNLAD8pgqmMUxq3EtE/KE7+NQEIAnro1rU9yKelvL0lxPyFBzqiUKYH7DfVcSgcVehdLld+Bshq+Nu2lOJxb9PpEzjHwwO38HoTn+OXBTNMu3Y3W3y31gZ/H8c6/pDhWe+dd+FTQwjASWnPaerRSMIgfE3hFXWjgrzm4s4yzIvaK/wbzQVc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(186003)(6486002)(107886003)(38100700002)(2616005)(6666004)(83380400001)(26005)(6512007)(6506007)(41300700001)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(6916009)(66476007)(44832011)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ollYFHntfwlvLupZ7CyaOIX3/QwL9cmbeiXtjzmGX5qFl+/+2PmUgylVuASN?=
 =?us-ascii?Q?y5Al12NS5FkWlmbBBHEqdJ3APIkostZ6iF2Huwbfl0hgWBG+a/K56sqpIi4U?=
 =?us-ascii?Q?F0JmTrL0SH/cOv7fEBmPcxmYqDlhl25OG/1SoxaVgNwTntRAvvIXObKwKjFA?=
 =?us-ascii?Q?IaNPb/pSZauCZNJOlAZN6G4zCzkvGMi4POAZPTg5CxhUernylG3d4hcdxDJI?=
 =?us-ascii?Q?V49tkWCX2RpBHKDOliXkSV12Go9u513xj0sPKYi0qNtDz8fB/Y02HfOPcMAo?=
 =?us-ascii?Q?GYB5Qg/gG2rJ1ac66U9ewxRHQTUohGVYsV+3BCKA3e7kXW/zTZSW9pXv82V0?=
 =?us-ascii?Q?EEJZ4f/ll2dWSEUIU3z1r7du8UYrFKU4tkrReE1zczz8HZzVicvr2L9UTNFe?=
 =?us-ascii?Q?8MDE16v4LzyvSdMokAaB42UDvPpZTWh/e3gkqfiJHhbalrzYeVukaGpWXMAe?=
 =?us-ascii?Q?6AObYvDkd3BVuUZZxTPmVWEWCjwd0SRp8UTrADzlvniVLvBNgDrWSF3XQ7fk?=
 =?us-ascii?Q?jnrdVUuKpuFdkQkG392Ba90Dk9vEuAAO+EPpYF1yOZ4QpMEcHa+a0/BPr/Kj?=
 =?us-ascii?Q?bCADFlikfq05HyGjQ5A9KtxuovRi3z1MCXy0ag/3Etg0KvZctM4oy7pQEz8S?=
 =?us-ascii?Q?ehDcXjsgcQ9yPEWwR6mApeBHsk0FM9s+kM6YrxHU6Kvvn2sziccoggWL3fIi?=
 =?us-ascii?Q?u6sVCNGqshA7Nc+dGh9tkPvO3re4kIH/44o1F1lGcIoLHOPm3fhsUurCA0h6?=
 =?us-ascii?Q?nUFouPgkVcuYODyMdS3q5GgWviKEh1kzaptb/1RQSSiQY8of7zC1fhgxICkD?=
 =?us-ascii?Q?xfJpAQgzHNRWkXa8SfJJQKMRr3tyNV1NTK0y6M1aF6qQtpP/Bq9k10cX7Urg?=
 =?us-ascii?Q?DfyqR62aIUBi4L/goT6i5PkZYn/I943Gtf9DawHPt8E/9zHuuyPXxel+FtE3?=
 =?us-ascii?Q?kuZDEEI0+gbAOBVhCtZ5/gQsjFSW3FkIKIQPXxgIQoYruUZAAsdMPwg0XG3E?=
 =?us-ascii?Q?TAD3ktre7XyImOyiKGVSwZvVaQCVPRkjd+xPSbUzmDowBQp5lI51Zmr1Yr1s?=
 =?us-ascii?Q?cygQ3vKpaMjI8BikUEUJyTNyDNqzn2r9/X5OROYkQybE/rI2dQ1IfYrSpWIP?=
 =?us-ascii?Q?jW/SSdFksSH4+ib7GCbhtR5cr9QkU+eYD2ra1/M6JIrFlAUo6ctweSQnkmAl?=
 =?us-ascii?Q?75xrzcpcp3RmW4W8Ge0t3mUs6tiZ0L2aMyN26cuzhKag03Qpq8sZGg9WbJfc?=
 =?us-ascii?Q?ixsb0or44tX2kuvM2aj3rMjG5aBz6ffxKp02tC9Tdo7GcrFm6jvdLq7ZwORn?=
 =?us-ascii?Q?Mn2qSz1Jw3DJeUT85VYtNcCM4ZolJlE5k4rcdBYd8HR0Lcfv08R1MraObbN+?=
 =?us-ascii?Q?4aygQx8SuDts4ufEls7eiaFL/1zQqTaFgd3etPV5bggjsH1LZqQmfRB7tkAW?=
 =?us-ascii?Q?lxAQCD+OA1rMNB5/JclowsCYcAW4JTLMHcU/UluO2UKjw4N/A7uuamHP/5TE?=
 =?us-ascii?Q?GgAAt1lI+ZpqzHaHYZs2acEI0oGa92l5ga5sC6O22ggYw+e8ceKovzxg9s/W?=
 =?us-ascii?Q?sPFXtoW8/oA+/FmYzN27MhEVLTh40uYCVM38Y0lT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afec71d-1bf3-4daa-d415-08db76aaf015
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:07:54.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mW2Xa1uEQreXn8ezTMQhSe2gTw4ZsBGJXTtFDY9twDN40mJ3TOrP7YZe1Xqb08JO+ZD3MT+iQHhSdx6kamvwZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9922

Update API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index e4caa2dd8c6f..3b6669d536df 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -7,25 +7,25 @@
 char _license[] SEC("license") = "GPL";
 
 SEC("struct_ops/mptcp_sched_first_init")
-void BPF_PROG(mptcp_sched_first_init, const struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_first_init, struct mptcp_sock *msk)
 {
 }
 
 SEC("struct_ops/mptcp_sched_first_release")
-void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
+void BPF_PROG(mptcp_sched_first_release, struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_first_data_init, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_first_data_init, struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
 {
 	mptcp_sched_data_set_contexts(msk, data);
 }
 
-int BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
-		   struct mptcp_sched_data *data)
+int BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk,
+		   const struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(data->contexts[0], true);
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, 0), true);
 	return 0;
 }
 
-- 
2.35.3

