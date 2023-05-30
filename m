Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995B1DDD7
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhkviaky/YhOi/DW2Am5Xy+gC8yMF5zx+GgnJZEQ7BxVWfFBBT6v9kXrUomY0vNlMUvJ6S1kfK4PMSrLgfS4uXd/R3d0191+vuOtSW0+0BZMt352pGTfGeY46sipPFy+uqeGUVCCoNFx1Y4hf4BlNaf+XC4EzdcBYyiqd72FONXjh7Nv6thd5PPAcuNPrMBfA+Gl5E+buVPFqk6EC2tiwxwhN2X1sE9gHhZxyBTb+i6MQ1il5JuutHmvlh+Xqio4TziUJZl3+uCqbrdMZ9sKHVtvAzCvCvr/CXbFRGxxCWWccfg3wGJ57DFHo79dDwBJ3mq1nrIBRrI1XSHcVioVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=KkdzOqFj91PE67yX8p0Hro/0qRmiCRQKDfxHzKeJgLj19AnlVEoRKSE61vXiQoNiTJ5ZRLSAxj9bqoIPYp0oUbc63q8Il/ao6vXBOGNuNC23hmmKwbkk5C4kElnXfGLw9j127P+l6aD4TXXfuc+7fYyO4SZHf410cFvkqtP7WTAYuS9OvkL3h2L49qo6Re/TatVHicrR5uKABBh42kzky1APM3qhMNQ3gkRxhWxSdsYW/cXzo0qyTS9D/ucUczXxQW47MZqcz1hed+ZSv8uJb3/D9RJdbev/5Mxx36cEf+Grjo14hrDz5F7JbCjxhmzpqo25ue4/nSq/D9nbcCHYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ZSqvikR2fSxfDVOU5QIrHLufHY9vGgZNoWC4hWuxY=;
 b=vGop6VWDZ1ITXa/45AaaFHX4FWwNEubj9rTlAy4zxTA3S3J6/Us/9F2gXyFS0OUlR4BCoXKXXIcg4N7mgZrXJ4zU3qWcMMo4lz0ZVh5KMlzuibwiwLExHzO6F73dx66eKfvbkhAemEmHjot+2r7m765pE+7/dV7/n1XhzQeFyuUOxTURFPE/QQAb2dKnXWtTna9ltACX5nnsfCjQf9BSHWE3ucAye6nzJBULbWdfPuTBVkwi8H9wauXqm2zY0nlMnUyy8YoMz3glIM4hsNa2mMYRWH1itk4VLwGQ1J05z1LWYhuQczI5rGLtoBU2JUTbwqVSiZm+zYrN3xTFGdRwfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:15:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:15:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 01/15] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Tue, 30 May 2023 21:15:08 +0800
Message-Id: <c8b7a2ca10c1460694d04e2d3a691f96e22f227e.1685452367.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452367.git.geliang.tang@suse.com>
References: <cover.1685452367.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:3:18::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e26d27-0da0-4417-80ba-08db610ff95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8MiS7PINBLFIWdTnW0hlYn8/0BYM3MnqA8ng20+01C9lbact4fE5EyaFWiygQtJfCu4qeAzXy3IQdc1Qth8k8wESGGXYfLh5rZ7VtZSjI0CCzih4h0yMY4KTcTf3/hTCbmg0Bk1k+46g9CxFj0WWLNzGZT1W5GpF2F9lM0IFWBoJo54bB/YJaiN8OBD4VrdOrBYt4zqkkjuagGmCDD5mN0xX8iSMQY62aQEntGhEcTsJLOLHEizpw86f4oKdqaTqOQJs7rIEgCmA9wiXixPePXmc023Wg/tRw8cF1FivJa0d6dpFEM3Ea5ofdLeRHMTBIbBBcGVs8V/b21UdBHUYT27PAGCACFMMfaz2Wai0Qb12CFrhKWOcJFpmgcLMIenAcw44NnkVLFB1TBbclSWwHvMwqMbTGZulcVD01AZsbb1wJ5RQyL1z58CqGNvFSmY1WfsQlupfFsuyVC3JbrBUW4eAiEbaiwgmUkvEZmMeSLF9i4qAwS6nw6ghnF+0+D2fOECmQuqt3mfpm8FgNi420ZAUW3LjFx6nyss0qTWaPlnLfVO880K1ikNlt7Utfv+S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(2906002)(4744005)(186003)(6506007)(6512007)(107886003)(5660300002)(8676002)(2616005)(38100700002)(8936002)(83380400001)(26005)(6486002)(86362001)(41300700001)(316002)(6666004)(4326008)(66946007)(36756003)(44832011)(66476007)(66556008)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+BJNyJDSwSzEHuWnjVmitImn3rolhzdXMTa026Ks72hAdzDIRlMblABMoHIg?=
 =?us-ascii?Q?IyhzHuuzm/CZPW24XKtU5L+oaQRxMVZzT5WwWuAJcFucSYyzDp9RMTmpJMY+?=
 =?us-ascii?Q?8qX7HsHMTdKLc4AABBEQA7CJKVui304KGnsu0np51siOyj0fZiQTZ8fn+0Bb?=
 =?us-ascii?Q?J0mTOvPE+nOsoUpyF5ZvvClFc7HZ/y11BHls/dMM05iSNSbSXWohfbeIRycZ?=
 =?us-ascii?Q?VlzNbNSej0KwNdngCEgxloPDNJvw5AwoC3yUSPljBDTq7jvQa3FvAiP5gQJ3?=
 =?us-ascii?Q?ekfr5qb+eHhyZ1y2zy1g3OdbdChfnyZZL1WeAfDJ6dLBeZoMf6pZT0H29NXB?=
 =?us-ascii?Q?59Rg+/Q/p+qIe1ddgWvRzx+oq+o2xB7xLJtXzXHwLn7ZeeEZdmwlPdFmLiE2?=
 =?us-ascii?Q?f5g91NtyFJXPKsRQ52tZuDzBH3oTJ4uiC1vR+shG/6INsVd3yi+xCwZgmuz1?=
 =?us-ascii?Q?m3Sb3gcN6ZZjPdFJKzLdjhUKD9ubyv7uy7B6lp0C7kau6ASShd66EAQsV+TT?=
 =?us-ascii?Q?fAQhORprebTEe81VMl5eWkF9OTFrNO1iyE7BqaZlloV9SILuK6XffcRATQvX?=
 =?us-ascii?Q?/o8k19PCnR6LxjA9FFvtGrs+B4gV6HvQl/ioiZH2JxmUZUy3IdHHw91es4pc?=
 =?us-ascii?Q?Z+vbaJzx/tTMvqb9UoFZVuk+y19LxBlTb15U3uNLOgRuapP9q4gLEipXQnsm?=
 =?us-ascii?Q?dq+9YSDuxwn7kLnFBAVMpE08kMf8QKBwYpUl9fKZhqxro3WWyuMur3OTE2Sr?=
 =?us-ascii?Q?rniz/AlQLx87NKsNWj4AxCwXr0jf02mAzb/ox6IDNuBfloqyXjXqYQQNqpec?=
 =?us-ascii?Q?Un5u4fTXa4eLKXxnmbiJYSwv+xmMl1Lj0zgomZ/PNkNnM0jIhRXhvXz0WNzX?=
 =?us-ascii?Q?FBoY9N6nz2haK5wxsk4iIgoaUulrG3sRnB2EQvrYjqo+tYUEE1hkuDlzktLn?=
 =?us-ascii?Q?u1wUINzag0UFHkV/qQuTaoeZH8HxOU3UeDtE0Zk2jotY8xW2gZNT9VxKM3X0?=
 =?us-ascii?Q?LdZqgL+BdFScgWy9gzCKsoH/0X/0qt+vw1eS87Pk32IgTBCMERm89QTAcchg?=
 =?us-ascii?Q?f7ztml2dsqwpzws+WTs0hvbF/6zvH4hInIz1BMlO7PDOGUG5QaswKOH3MuzF?=
 =?us-ascii?Q?ByEJ/pN9K5TGmgK/u6g4ei7vWyViBYcjM3f5OzdT3WFDfEQRr2/ZMESPRpwY?=
 =?us-ascii?Q?kknpq/iOf1Yjjw/zZh4MzaM3Q8K814YaoWQwWbk9Uv7i+qpbhcfKWpgzCI6M?=
 =?us-ascii?Q?0Gih4l924qKepLDHXsVFPL3QjJLiKl5ZvnyVyp2/WfNmzuMRf/H+lrFKSNLD?=
 =?us-ascii?Q?yk9KWQBCc1C/5jbNaM2LY1Tnd/oXGfQmqXSDsvpBbyeWjo3T5OJn114zI2Ae?=
 =?us-ascii?Q?ZHVpC+jvgrduGF3eW+DmlGTJecBxlr+8A8G6DPFR6MfalIr3anYH0A4nwHAE?=
 =?us-ascii?Q?tJzrOMQSxvS1dAi4kmuJzTEx4wmmaxMlyInydNV+0itXgg633o/V6+azBUyN?=
 =?us-ascii?Q?zNBY8D4r1JiryxDuYgaO4x3vK7bnizHD0pkCXrD6hNQvzwokZOkdo2RlTkVn?=
 =?us-ascii?Q?PxvFlzNRp2X3bbrdWTwRWkKD3WRrGXRULaOr5rJ7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e26d27-0da0-4417-80ba-08db610ff95d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:15:44.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MA5JagAzdLWskuyv5lz3qJ3vzv4OTxrWgAVxwLagj5dSyXdvnzuG0Cc7PC9/LdEK7fpevDyTZhVZaTM6YABoaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

Use two tabs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 828b10ddabee..4bba29c99172 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,7 +100,7 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
-	bool	reinject;
+	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
-- 
2.35.3

