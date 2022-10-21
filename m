Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150088.outbound.protection.outlook.com [40.107.15.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805DA7B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:02:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQTv3lU88yOJGTe8pMArQHN4FjH4ADqL1hDIHBlOxRVW6h9dFWyHLoytVZul/m21epthXzOXj/q4X2e59IZ90vyWtXX7nk/52skjdezHIBgZDfCSu8EzvMBJf+r380sCIASMTGC2c+1Mcul7AfDdnTGC6uC67jwwweU2ogatKZ+464TpQG6FyTe5KGgmtX69QY88FWdRKFgvoRGCVmCWUiC42Urc7V+uDC0CVrT6Imv1UaA8BW4mQ5RVCQKEiHsq+wcmgwr88iJCbMVJFNRSwJYCa426v6aSyqF2JKpy77NHr4PocX4l1pJcPZ5XZ8PIKjiPAzLDP8fhfbcY5OMttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=GizqaUAi3k7AYk2X8KAtPYrUr6J+QR1rVOyBNw+fJEH89Q89j6KsNeumJJCL4Ea9Y86wT2dShUee9JuMilYDgrs/hk/Cp+2cDjpL+8Ssqce8uN3ZWS2RsDO241JOeL/GYDgvuVVJzRjZUbWV46ZjpmhkvJs9BxqdYLm2bEOcyqqwJjmSjfQgDdYOC9SQrOi9QgIu+E/5zeSoEs7bQpdBGueU0r5l9tj2AR/YeleZF0DuEa5Bl+6PNZy+rwT9WqOOdRAHMfklyBDqA/P9RYMRqUy+9I5YgwcG/UI+CKhGFIyVWRdLqfMKin/fkXU+HRxLNjRLUVrynbz5CN3Or1Y3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=Vrj3pXCEfpSw0Nsn+zzX8yKGiCnVW9WioFoBDdgVXtIBz4WBHNZgds19OKeZRkbLld2P3hKwC1v4KpehLx1SMO9bK6ip9y/IaDB0tmMBTaTyyHacXXrAoqT8GmT7nJhE4nFSRfaEScqbYZiT4sm2eihNTjgf8hZBZG21t/wInvcKLIG/M0jYwJe3MVIkzliJ+SBKz0EpzGyWYhiNDxl5eDH+QRJ/QcNMRzn0IdduujEUACO9OktEeqdZLt0kUdGIxoElNZuuJbrM7jmnayt7ouUaagI93LM6HavkYLGx9giKqzaPbNfNeth5SGdh0Q/MVIY9z06tgV/CeWY4vZqfew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM8PR04MB7281.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:02:07 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:02:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 09/19] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Fri, 21 Oct 2022 19:00:01 +0800
Message-Id: <61a0479fa257aeca966e332ea3cbc7d55d031029.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:15::16) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM8PR04MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f20b87-4bbf-4042-3440-08dab353b1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IW6ULM4O+4nCD+gG56fK3Kr+6cD2jVsihMywOPc3Ekct+Oq40z6ujrEZ2pXDmUk2D1sK3zadib36q8VuPBXT9kY0YrHQFx7bT8DLVhZ0XsNR1jsPqeB0PvDfWMkTn1WNfoRmDJGQBl6l6/gdKTSOGp2um6nzXqzBrZzKOjHvZZhjS0j6/cdE5/8YJIXgnxvb/OQHrMwYYvkv3gqHBJH9O8nnFBe88pSGwhkN3dPsPHGX5qBIIWK8G317koIV3CRSaFfqIyTWhEmRn6Y6CaDqEptCGP3uNygd3H+2TE44/htC5hWm8lEVehdJLL7HGbsfvzjOQyAAj4oeICMXvthwzeJmAXB2dkRrpVAvDW5RmAu7LEfqNgVSI7zMpHunt0pjpaxDP3sXHCD/usy3d9yQ+MVrPddEaZEzECR1TbhTb4kY9sKGsMeG2/Wg/Q5DsiQW8MtMGcr6O1SzFS0uRrHfqPo/EviuRDw13txFxTL7ayqWwfZZBDtdhjXUoMjpja6pCcU8bDUjswFqlnyVuAFf4lMQkStZupDq7aFCXRbbVXs4yzEw3yqLh1UdvrkEg2tFzWUmzciEeXAsKLC4W3FBT0P8RhiU/Nu4DUPwooCJEAwdBy9yk3vVpthjHlUDD90/icwdvCIGurcMwCL8FzTFT1Jdppo8DNPoPBxiRvXv4O6ohW4qtb9Cy3Dk+YIg0gsrMwvhnkBFzNseRTHUUMQwXDTGrnaYYUgfgmMI+BtVRw5tvk0hQDfD4CKr8DO5DB3o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(2906002)(186003)(2616005)(6486002)(26005)(478600001)(8676002)(66476007)(66556008)(66946007)(4326008)(6666004)(44832011)(83380400001)(6916009)(38100700002)(8936002)(107886003)(86362001)(36756003)(6506007)(6512007)(41300700001)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AMTyTATlgI7G7IJLWd+DgUVVC+yeoOIn1UylcG08VgN+rkukA0saCJzS60dg?=
 =?us-ascii?Q?qmYWnxSSgqig7Rxbcx92iXzHOlFppJtuuf9ci77g1RGejucDlCLIhMpRpSID?=
 =?us-ascii?Q?ue+tNcKAiCqOpF+hgFcK8NrrYjYXOjtPuhRbZIPTxa3KY4VBCWs97g0SSSAE?=
 =?us-ascii?Q?ejvY1SktXTEvLZ7k+VPJ2wxHq+gZVCuHWkmern2Z66E1q9lAu7ca3dPrmj/R?=
 =?us-ascii?Q?gQ8xCawh2ZmV0fyXwEdnUNdpZ+mQX7jEtAdAb/ILR0ne7cHZkxBl2fi+JBg9?=
 =?us-ascii?Q?9PrDs0juOLRg77buGWl3Sl+kynuP5DUvOv0OrWWjrMULucoqKVcfBM0X9Pxm?=
 =?us-ascii?Q?HkeQ8gUSA/7+CWNGg0Yw6+HmhqQETagl3y+IQE/VPm4k/90DZOQa7A3c9ZTq?=
 =?us-ascii?Q?clHkOQh3/C8T74WYMOQSktJCaxhVqI2JXeU35VTFkau/S8Up6N+6EdgwLogf?=
 =?us-ascii?Q?JphuCMGJC+/TBJZyUioSvWvxcvXLc0fKq4O8sFwd/oHfoCOayBvKWyh/b+Vx?=
 =?us-ascii?Q?7R2TN57QSXTwWN5tyx18qoEYv1JUJWYMRPjBQhmCC/aA2EAfGw5b24GhxJgy?=
 =?us-ascii?Q?PpuaqT3TBb/RqTiEhjwWoINcWKgs2YiNplndJq15DfRz706sEuObKi/rwHwz?=
 =?us-ascii?Q?bXp7aPeqAy00HvIiRC8uBzgbG7EjF1MU/KBT34zYMvumXB6MKX6OBEkNOoCw?=
 =?us-ascii?Q?SbFJJxsBC8NGR51FzrjMj/zeraYJhBcpLq/xf/napPYk3lpEgP9xULmADGzI?=
 =?us-ascii?Q?Ij/aq+0+NOylf18d4sexylhT4Yu7hBIH+uwnWAYxKp5T2nBL2Ko5dsmz+0Z8?=
 =?us-ascii?Q?4y2eFBYE3oJrlbZKgbQvm9nZcqFI7MRi4yYXuZEsIqiI4OkFn+6ODBy9TSP8?=
 =?us-ascii?Q?5T0x20L8L4amQVB4wVNOCMtkLo0Sva+oZY9ldZmNzs3wDU4U4h5/e7AugWS6?=
 =?us-ascii?Q?jjZDLjJ84tFAgGYNW0t0ncsgLLhFsb/bUtfqQrfkY+hEyaqClg77sCU3lCfS?=
 =?us-ascii?Q?g5WhRTl7e4jODr6n5AsfFmfsgRQOmZbvsr0lNvQ618wDEQOdMkDYLrKDhtz8?=
 =?us-ascii?Q?axCiKRkd9ngX67FdByEy/5LJ3R7XVnnXSl4n/jZuqk8M4PSu74o/PPWyJEL1?=
 =?us-ascii?Q?ClppyJLx6Eu6PZuGhEdLZG0Qdgnt8oh5l+SP3ohnkhUz+5nKHTFCZzJLVSm2?=
 =?us-ascii?Q?P8ioKRbA6YGUGh194HV+rCFUYu/LxORCI3E4q7a55gkEtlM6yNqlQ/aMMf9e?=
 =?us-ascii?Q?HBe/nDk+hDsjpzx/7+OnYnbabQBeuo7hf+/4m2059n1HvZioLDg1f/Nz6I/4?=
 =?us-ascii?Q?WwC80iGtRswHmogJtJipZeUIYQNkcESub4NH44ZDIpVr4/ND6oIXtE8DBU9T?=
 =?us-ascii?Q?Ir5FjYd0d2eRQ5hU179Rd1yxAW5m7UtFLDtc8ieiqdMVrRpBJinz8Ey5jR98?=
 =?us-ascii?Q?51L6zPeB5TgbTOziUr6QvPeECKG5qdfv8znfZaAh6UUBAW6GvPEKiDYwPKPE?=
 =?us-ascii?Q?ZFEAudq99P5pQAyFIyz2/bM2eOXFOwuer7/i+NBYufHpwGl5XTkOmDXhxHWG?=
 =?us-ascii?Q?c06Wq/IvR55hh7IHEi6cIL1mtRK590yXpBHytLK7hXR8l8yARA9SjrFLz052?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f20b87-4bbf-4042-3440-08dab353b1a1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:02:07.1854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67L04OXKxd1g6XBwx4M2p8jxA0OOUXhqIihkoi3lnpGEzxSFValPr+p9h0G0Z97e3TcRnAoajauqB7hj6BdQWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7281

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index fcd733e88b02..e4caa2dd8c6f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -16,16 +16,24 @@ void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_first_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	mptcp_subflow_set_scheduled(data->contexts[0], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops first = {
 	.init		= (void *)mptcp_sched_first_init,
 	.release	= (void *)mptcp_sched_first_release,
+	.data_init	= (void *)bpf_first_data_init,
 	.get_subflow	= (void *)bpf_first_get_subflow,
 	.name		= "bpf_first",
 };
-- 
2.35.3

