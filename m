Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B19653
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOHaAMEv5Tl2TQkcBnmshunL+18lhpH8A+/PtRmS9zClJ9t8QzdvqRUzDFZMmidjYQE0VkD2lFtm+OyjhgV1Fde4ieXEAx6xjVdasJNRHL14I63Mq54zw3M5bqYFMn+dbTqZ9fn5rgc5dsGFDJSsqEg/EDuDWxlF+h/IB3cXlbbOwF9Fnlp5NtfPWUEy0Id2U2qEWxGD+1AVCDKVd0cV/1upCqE1X+9GU8uyOBBx0aPFvAprGcE6K4WYcho5KFQxxru7YCq+NFzTqCtoiA0CFDlPaqWUO0mzbKtxMwrU8+T2opvKI1vXZ2mrbLM8ByktVJLHb+S7J0QpMpe++2M7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbY6l5z29I2ZvyBRHz7xvWbDR+PfhcmGG6gZ6gC2l8Y=;
 b=gEL6/tApnfSNf6d04nXvaBxrgPGLm/4kTm/Q2djFqx+d4ACCHjI/ZMInrUsqvg/imOV02PlzEUYkMQG+cLbKTMca3H9hqazyk4W2GNmz7H5KmGV1jS07RQExMwd6EGNmvm46MqK0jkB8KM/vW4a9WTaPpwWABSOYR4vbcAPUwngI158v8Wibw7t0LQgOawAuKjfTynzoaZls8TVtLsSntd6K0rxl22AWExDw5cXe0og4EkyfHbPxT7/iaXahLjE5yuAS1dg7gEpV+cQqXzB+zQnLIh81J88bvqdwqFUS/qqAQnwFebmUy3sc2Td4F/q0UdGQRc/Ky5o4jSbj5r1dNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbY6l5z29I2ZvyBRHz7xvWbDR+PfhcmGG6gZ6gC2l8Y=;
 b=t07ZAhxigoMMO4S73Dcd0ndj+zTKjcilRQR5LHn1is5d7CgZrzxXga4bpkmm8Zz5zVQA5tJAEp4z5KY5cCA/c0GcIOCfqmY6UVPomn8yZjTZuqK22QQqvEZb0rqxKsAGju+XmkF6Pq6Hnn2GEpWCZUmMNgo3b3HRP6OaV5bQzIzfdlVZUVE8LW3zwngb93nSvxqLXEMYbmWxP2S/qvrdbiBOHbqdav+B8SXYs9vA6orJWmlWUqQ+jrwhr3z+NbYTTniwI/ur8ixmj/gMivcpgC82OpvRac8Mqyd8mULeislvr6RA8xjeHfNidOm+1u3Jmdpy3vikNahB8bT0QhIH+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 08:40:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:40:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 09/19] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Wed,  7 Jun 2023 16:38:24 +0800
Message-Id: <ce9a9fad25e27eb9575f8ac9897614e722678f4e.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0158.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 411ebbe0-29c9-4f6d-9a21-08db6732d715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wrHbyEL1axEcNSSX4130zJ69kdptNvIyf1Hy4xYVCF7qPg/pVToD5pEw4XnOjDbji7JXP/2+Xp3Sb25h/qYECvxdlQpwyBXY7ZxK6hj2nPrTXcXzohOySTpDmIFpIVuPGAiR2aJkyThTak8/pKKCookCSJ94vhY72Od4nNkW3zPxtWWOnLdO6CIQ8KKMmXWWrhyWovMNkvtxRKIjAOqekuVZqdaSYjxBEoGlorMMfkYFV4+A9j6gdolzyKSeNw4xBg2ZSKqxLBNIEmcgof39rpHTfy9r3nupGm0RVu9QPSRA+HMkNbEpDAUZAUyEeL0502Z84NYYNPmQFmrmD1YsRwD0mP3hUmXd6KzZTV2LYtd88pkNUbbs0/z2N1tt+Hybk86OtPOeQg/NL09aIhoX54d6K6y29PQcnabyvx8oa0V1k0T6uUMfHpjaLjkcNTFj0DtNhMXFLuqYuske2K3D7kiuAz5EOGfyW5EzA3TrTKuP9zj8urgbPUxjENjvZTkWqQj/5HH/PDYXfcWdjyGWCJDbvcm//HS+YJuSdaeSH2ScneekmP9joehhYWD/WlCh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(44832011)(86362001)(6916009)(4326008)(2906002)(5660300002)(4744005)(41300700001)(316002)(66556008)(66476007)(66946007)(38100700002)(8676002)(8936002)(478600001)(6486002)(186003)(6512007)(26005)(6506007)(2616005)(36756003)(107886003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gytluf7I0VW/J2oUrwijZ4OA3jiaQRCXL3Mgyv+WN2+Rhl3MHQQC623p9ehY?=
 =?us-ascii?Q?uoai5HU7xqy6TmsdtNWTlpza0jX9GdoNs51QAV2Thfv2uuUkdKwpwoitVRHD?=
 =?us-ascii?Q?cFoKHJqTHTkWtrgNMK1WLrRmjtbGH9HtlIrzalnc9zCH+0u2Zsp4eAy+wR+Q?=
 =?us-ascii?Q?3cK1lqeT03KYPHIQU811E7BxDwwPMO1osQ2StZhlUx5xuUitheUGwRzpGNjn?=
 =?us-ascii?Q?2GWyLwqPF110WfCmzETkKBrreHmKtM5XIakaJ8NS9wDkSWchgoosgx/9bIY4?=
 =?us-ascii?Q?y8WoGCkBbC3rD0MEVJyi4rBPskiAK7Nr7mGjMY96o1+XZfUdC2PlrtgrrgC0?=
 =?us-ascii?Q?mmDH7iAha79hl0zgIDjuzvmaiYzI6HEAgR64LSP/K0vRHn7gPca1U3vNxCmx?=
 =?us-ascii?Q?B4zr0Ky3QbDQnU+8oV0Y9vslg4f7yPkIfQ24UcdDymkao1YqGNlXuJcNJgUZ?=
 =?us-ascii?Q?Vab9Y864K2XcFOneeLbe/ssu2MrJMbFC67S3x6L16QPHpPHMKVMDE83vTiWa?=
 =?us-ascii?Q?wV+leCJCOqgniN820TGD81x+dkIltsF8T0wbxeCjF0Zwt/TP9diyzyTN4Jg6?=
 =?us-ascii?Q?ePFKm3X4AsEmprV/0V8UL2cIPZKr/PVSXBHfzo/6CQM+8H5t6hF3aUBRSKr9?=
 =?us-ascii?Q?D8UiiyeZkVI1uWkQK9OfdPV73hMv9hl9aRzTw5IQQUGOdzEl5Wu8F5FioCRD?=
 =?us-ascii?Q?bdkD6NW5uM/VyS0VQeGYGg2A4FnmCTdLy0NsGRpTxJEOAhk3407W4S7h/fsQ?=
 =?us-ascii?Q?YgjCXRYnVfMTNBlKITEFO7yFOO+jUMqptw4tnGJVjDkNEai+DnaT2GtK4V6z?=
 =?us-ascii?Q?ie3fNXLbCh9a44Lti5J7wK0MOewr3vyWg238Jc8zvay9Yu5lCxAg6V9TM19D?=
 =?us-ascii?Q?hwLXwzC/O6K2YzyXdM1b1yU8hx4yCvlomCEbIBWqwSxXeniZKtPV0ht98RLQ?=
 =?us-ascii?Q?ZfRQI0o+IP8EAK4QobtPKQSNZ7EPnErUAQeLcdYXFtZIpmvIy+Bbv6x8/RjG?=
 =?us-ascii?Q?ux81DLUOcF5nLDILEykVMVT+gn+6ZOSXid/GfSNcQAUreh2ofoxX9upx2Oxi?=
 =?us-ascii?Q?mBODWaBKVDjEpZSBAf0Bhx6F8WbA/E8Mly2cJrvsk90DcBlGMM/ki51Ooxso?=
 =?us-ascii?Q?X0L5bKUZduo/Wwt6RnucWD5Yv4tGcsOCN0rpHkPCQ+tYXMNq4HoOu7C4ptFP?=
 =?us-ascii?Q?mqkN5S+JOQJrVQMphcXr6U7xjlZ9EQJ/9igtyN6cEzZfYo9o72SQNNNKXxa3?=
 =?us-ascii?Q?9G6IaUaU+GfiUnyQzQMVv93uEOjEjcwwhfozXVs5zgBBtEqLaeXeA0p3rrMR?=
 =?us-ascii?Q?e4yWh9ZJ/0fZLx8HrLh4UkM6VrZuBEiAl3/Q0MKly06Ex5FiBS4NJYNsIk9q?=
 =?us-ascii?Q?6Sya/Uh7qxq5dxl+1RVgfP8oSkG3eMhdfV8vaKXI3yZd9ywoSAy2euOpbCfv?=
 =?us-ascii?Q?Bi+gP2KKkjND+9BbmvpPlaRJy+5gxKrcZxH7Hvt6hXLImemAlhlVdAHTog87?=
 =?us-ascii?Q?MNiAWeIAYJWmEDQKCppjltaJBEwqQs9k9IT9Hl5NOTljrqulvJUj4aaB7QVO?=
 =?us-ascii?Q?h97oFIA3z4B25RycBwHU2bcEofsbs2JX9OYoc6J3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411ebbe0-29c9-4f6d-9a21-08db6732d715
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:40:25.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OAmEOGa7p3SBsJYDky2xnxaG85Bghkv/sNqP7H1GkuhPA1MJiQppbt+asHap/qpyyrHfaicm3tkgzMCB8usag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777

Use two tabs before reinject.

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

