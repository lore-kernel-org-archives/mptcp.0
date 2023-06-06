Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2047.outbound.protection.outlook.com [40.107.15.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5623A28C07
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEJEkjCxqK9xN2FQU0UgVPUdiNilnnFZpDZc8a+eZzp27ORBNh1aJl4l20JDcC/8rs7LyPNPExx8kg0ePcD5QzuBSNHrRdjp7ImmDBKubz3x7Sagls38mK34jOPFHygBuTqedt7OwuS4oBuylAEV2EmCOYWVnUZhliR42LQMm9ffUnFtM693XqAL5wbQuj8dCJ3ps/EifvDQiKzORo8ML5EHouWcf+RBiNqZdpIoS/Uzs8zpX4F4spSeCNU/Vn1Kzq4ZuREvDQdluV3Svwx5BskIG0T5fKGaH2K9x/a5zuN5Z/Kj2ZdaJ74lP1wdUezg48t2+VjywMRwrtKoun8Jbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pQWyiwjjgeKPS87ddyLtx3+Np/qOSmdEelVgtqzPCk=;
 b=TLkEPzWSJxFhxXQPSrWqtqfa2FS8mzUZwBRJ3g9ogLufweY3EOKghtoHtoSsxAEp9NMt2w2GjPO/PtKaAW6Kxd/n+4csO2y3fy7tlR5/1N3DgwAT1IwhiEivzMPuR/XsKDCRbsGKhz/jLN2h+rSG2wekSsYlbwF6kV9t17oAaIhFauChdugjijTdCVb8K2pph+nonqUszI5q1+T4RrZYoAPQcYQmUKNjavw1wnBI7QseVv3F8MJNrh588UAq0ih6nH7V+rjevxt/NsWvRiL24WrdlkIFtIcDCzEeTxBEj0wowpHkWJEzGdoK+gJJwz/gFMJM54VluNCwMaOkXId90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pQWyiwjjgeKPS87ddyLtx3+Np/qOSmdEelVgtqzPCk=;
 b=g+EckcEbf4U6hI2fCvx8ae9QSj4OzrX3Av3wXjxMRSYhfQt7tZ3MJuVCFtzB7DTCsK9YRMLEgwX/tONscIwLvJPdseAIk0LerdCwLIAn+B0XuSXaNtAPuB7dtFpbBwlkvVINpKT+aObYLVGQLhUUZk+vL59O7eQ3TkTpzqh2ywiQGFA11zmvZ6RKtvaiB3SWq1gLItFYurtdTyn9Ufbz4F4OjcOnfXBlkvBPKg6ARNHAVf7TwrGRaMhL5U9AYANiUQ86PB2XQE/h4orRsp2WupBsq/SuMKVjhEdSy8F49DcIkKNSiBYa3SuIwlP2VzJTdzeLL3Y9AvS3aHQwsbrNxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:01:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:01:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 10/18] mptcp: rename __mptcp_set_timeout
Date: Tue,  6 Jun 2023 16:59:24 +0800
Message-Id: <80e910d037d3d6bf85214b5b4f5c327b54509ee1.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: d431fe36-4a81-48cb-5340-08db666ca84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c+lGSfPxn8u99GNSKdGe/sSO/5MovdzZZtQWUzZOf59PW+yFVrgLGWv51Yt3HuSXf0a+iXU5naOBzyefChOtnoOwsKJBf/UanUnF1lggJ4gTdLFYHHS9MlNSWZ7OsbDXDYVFaAaJ/RV5F2O8ylgg/VfZBUPhoW/Hoh2ezdSdnTYPTBdCxmWYZVTDJ15kyqGZRHsNR5nosfjimM/4mHzdaMcRWEw4TZdHW+Q/A3oR0g7XgzximXPZmuakH2Y7d5cILCE4QzUJZ62LTVS3kRACwJ+EEQYMv3IYzVI+kfAmJ+c5bykaMpBobsBewhI8HpzBSpcLdCO8c1IYZaEyswXtRXu9ViIUlBuWQnB0y92dXnJi4JVR6DwuO25LLjeIwL0XeVD4x5f1HS4YEDS4A8OuWqYoE4I2WgJ4kUmZQ6zA0E99tDjjb0Gr6QtAhbhH8xIbbPU+0S1o8UQZfaGPqb2m9eyaIXWGtUVROby6FVqbAW/9W3YAWgpqUG6TcasCNWBiYxPaX/C4XXowgGjISphVnvylwZNAfgdJMBSnRYWUz2sIKjEI2VZvrTRoKzJtZt2M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(6512007)(26005)(186003)(5660300002)(83380400001)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(6666004)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?baRorED24U7z/NoIVLfPMcPPS4RK71UPE6GUZGYQoIweP0GJk3trfS9ycVS0?=
 =?us-ascii?Q?bj0xcqcaXBc38pGjNeghuuxb4crnXfkE9+Rbo+YVP4nxVMrPvKm+fal7iYiU?=
 =?us-ascii?Q?PJkOfq8+OE/djN2vOgXaaKHd6LRbUw4dAWcOcxIxN4oXN6j9cVovujlvAK5T?=
 =?us-ascii?Q?Hbu2X9Ers2DOZ1PEtPiE63fPrtCK4p6HuIoUjc/AwY8jDxh7fcmPuE5fWc53?=
 =?us-ascii?Q?SzRfNKtidJVePvHxmol18ClvnEMVGTFK8OAi6o428hAXnBFnV6jCB4g+CHZJ?=
 =?us-ascii?Q?ApZxG/+GJg333v16d2g+cIIsbpnqvHEMX+V8ifzxhRNPH69DI+szB2SEiFVm?=
 =?us-ascii?Q?jJjdJE3rLe0uNFE8LxpGb+SycqKrFa39uzNSp67QxoNbTvMlRckmGd/WHLek?=
 =?us-ascii?Q?0E22mkP8ygni08iEPQXl0FTtTxhH3miJp6lkYAyWybfx5HF7WjS01HAfNYKZ?=
 =?us-ascii?Q?ik7k3Cu1YKyIntpW2782wH7iPZO3GJAn5lDVwzULvBGMs4NU9qRA9riqsH4X?=
 =?us-ascii?Q?u4PgBV7WVKnibgheOps1Ikufml1Epe5DJ5JdjgY8SaQx2VF9l76cJoSBh/0r?=
 =?us-ascii?Q?nQWt41lc9vG4dUf0y7U/+86GEOt+yT1o3FXOx/rMrZkwtogD/LlkSRbJ4S0K?=
 =?us-ascii?Q?5sFYKsDN0h+TrHxyE2ygvEv6hSCozaQTqFtIxWqCtN0/S+VrJpR2Ws0g/eIs?=
 =?us-ascii?Q?iI1YXkZ6D6Sn3EFdWZUht0u0whFzX2FVz6bnRgkyucJyT7frtbDld3vIVK7t?=
 =?us-ascii?Q?zwk52HcHQrmlQIXh8k6a3PXApfd5eJJEaxlFmaNZci+U2g5H+Re/lcO0Ylro?=
 =?us-ascii?Q?8/Mks2lmNWjiAFnBFWSMConPZBCTju5Ftu6Q9wmG8wxMQOPawGQASm15qaPa?=
 =?us-ascii?Q?dqoFEMMa+TX9NCJE86tBxTpIeMzY4LwqrKjRVXvMbeOQYQ5BRFm6iVO2vnM8?=
 =?us-ascii?Q?KU+85y03tko+HmOW4hZWB298OnKioGsQZA3GAVSxNKeYG6Fu+9CSTgPtIWRe?=
 =?us-ascii?Q?MKQMySzTVujdeyP6B26AKAphJkIdG7G5EyoDNB8msrMRkeRn81VgH7OEAihy?=
 =?us-ascii?Q?M6hZPd15mrjqfFAc3mLAqKr5+OZ/K74ffoazhBZXCy0unPsYbq3yEXry2W6v?=
 =?us-ascii?Q?pNSjfyWW8hsllryUdB9IVqS4i5FYpjD+FpRC9OX8+CNtxJQ9XX9z6MggbMT2?=
 =?us-ascii?Q?Zev0OZZ7Kj9t1lND9iCG/Lnf3CYvCUlqjuyvNSD1t3s0h2eusFzy8124Ol+p?=
 =?us-ascii?Q?RGBVtBq3e9mVV2QhDMwsa2FYIRf0MJn3Qf8eYKVYIH4+W3dlznfxJu6cP/2w?=
 =?us-ascii?Q?QihsuCmmVio1pAFJZoebKTwVV9WsPMwldnF3hBw5rK+IGEOX5krDHgbQ1YBR?=
 =?us-ascii?Q?GdS/0hLRodyRns14Ef2EsO2XLtejul+rZ4s7XX79xhDfn8Q1iy6pbZkV6Dkf?=
 =?us-ascii?Q?bUojDjeLzVY6IZeku7f58S2wEeipO/lIHb44SmmjDg85o5yZJBlatwwsk/B7?=
 =?us-ascii?Q?7ppe6S3fkCMtIomut9GT0McKnkKNM9M/k3Q+7o1fk0Ow+mIfwniwL+/Ggpb+?=
 =?us-ascii?Q?UqoB9se1mFSNGTgn4BFq+l0MAMNetFPC84RSX2Ks?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d431fe36-4a81-48cb-5340-08db666ca84a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:01:47.0679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv2LWtk1rX7evdgzJiqCC8l2Yixo49vj2vqim6dciMLLpdxv1B+pqA8zfIBWGUFVkL15fek7Se1gO2ccwGetIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

__mptcp_set_timeout() is needed to export in BPF context for bpf_burst
scheduler, but the "__" prefix cannot be used. So this patch renames it
to mptcp_set_timer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 27407b48f3ff..55c2be2b14f2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -485,7 +485,7 @@ static void mptcp_set_datafin_timeout(struct sock *sk)
 	mptcp_sk(sk)->timer_ival = TCP_RTO_MIN << retransmits;
 }
 
-static void __mptcp_set_timeout(struct sock *sk, long tout)
+void mptcp_set_timer(struct sock *sk, long tout)
 {
 	mptcp_sk(sk)->timer_ival = tout > 0 ? tout : TCP_RTO_MIN;
 }
@@ -505,7 +505,7 @@ static void mptcp_set_timeout(struct sock *sk)
 
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow)
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-	__mptcp_set_timeout(sk, tout);
+	mptcp_set_timer(sk, tout);
 }
 
 static inline bool tcp_can_send_ack(const struct sock *ssk)
@@ -1455,7 +1455,7 @@ struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 			send_info[subflow->backup].linger_time = linger_time;
 		}
 	}
-	__mptcp_set_timeout(sk, tout);
+	mptcp_set_timer(sk, tout);
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
-- 
2.35.3

