Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C00D51B
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 22:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZA8m2J5/vHVBynCXZKqroTv2uib2Zw0HbIkn2xLwmaUIop0rQwuvTtZodg7KkKzcN4vH27qVMHaqx0EwDOqYyb37Hwl0g/hwr2FVmWy8WILA0J230Xwaiu0r9lyfGbaEHXLWX4JetVwQJ1LZt1A//BByUgTyTR+Hve1tLvLMm1jSlUTLje08yRbGFVxsbu4xhtG5d+nsyybb1WQayE8uUPpNnemiJeq6XquA6flZ+M1hrR2/S7MgosGfxDrd4uoKNr/kyZylUY4dBqvsrn8k8lezvJZM8tIjolRO15ZTEMFkZF3GynecUvyaW1xjEoJCtAa9QQX/6WWhEDyWpAX1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wcUromDpNFCzzR59fhr61+4IzOQ7NOLZR44wSt5+7Y=;
 b=OVWDAcDLtf9TLkI/ek4gDI9XbwvvmfC8vmw9oxCSI++vZLec7+dt2jaEDtJPgwc4qWT6O3RItYfnAB5wBvnajDavfF0wT5JklxxTKKxyO7+iUKzdBMjKie9a66D0xQZfk3uZvkvvvrIsabmaLoFMiWv9IDP88mYtNLEphIVGVOPovybpZlPRHI4q5/tKYu7L6zABJZsy9ZeHG9028FrKtpyX0uyaPxqv5kignyYjQZM9wFMVclAB0XWYzLXR61ikUlVELjLKEjFs32xJ5HBJbLBXPqHCGpxEL4ZiESDw4xcW3mcpnmaK4RDUFqvO63+/HNyVpn+i1fyCAgv/y14bww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wcUromDpNFCzzR59fhr61+4IzOQ7NOLZR44wSt5+7Y=;
 b=YceQ4/Ypll1FZzk10v75wWuGZ/5s5IyFcVK0+NYYKkTxDDFe4e8TyU67CfhCAeOSeuRjR8Ynd9tlB2YiqHmN9j32HGn32wrzWuOLbCKTpHvYL7RWlkRiFniyHe1dzI6ehPgcWt8X8NIvkrjXiKX3tHKXewqWNd82For42spTb1Aht/HMQzaBq7gTB6exdILhRQ2UVDjZ7dNPxC3Q3DV6v8U8bCDRzptoRckg0UbSgDhjKBPLlT6agl4pW++prOk5nwAOnhGAVeKJ3xzBEW865NK/QUYxdU3+f+WrU3yTkVCJQNKWMfcfbdjmjlbTX/B56tYHPOXopFVV25ZQWpUXng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7192.eurprd04.prod.outlook.com (2603:10a6:20b:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 18 Nov
 2022 22:12:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 22:12:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add sched_data_set_contexts helper"
Date: Sat, 19 Nov 2022 06:12:51 +0800
Message-Id: <20221118221251.4330-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ece1f0-b727-430c-484d-08dac9b1f9ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9+lok9+lsJeMug7laKoMBmzVEcwspAyH/nnQoF7+FSHTL9o85Tim7ELneGOEEXgfpvCeVu6iu+YY9O8+JW7TSLNOWGxaHuFJJbDVUSs+UDS4+NEiylYix9lvMQ8RyGW98OvZ/k+9Cu6jsai3939zSgcZJdGzjCCa3ovu+9tY7gOyoSG5cIZyzrO+phpcbw3vg2qBV6J11B/ug+DftIK9kA3+nJF86p/DAp9tq3CXx4zLLsTUcYKzVzTb0HsrnqP9msO65ABI5ipJFxpSw7t9McHciSeS5YiWgAhfZc/Qarw5tzfUd867XWRntQMrLJMzVUafcZXJwB1PYWb8gDncvPaxI6tBQJT0mL2y0iYeXQZEZe7fzXgJDE1HUAJ9br2ciQfoNzoH62peY+DpamlhM+eSH3KmIRi3maUDl/wI8F1+9bTilJyxyYXu/bRAOctGLRBI27ZR9qqQtHj9pmqzCdJia894f5GqhGpj4M9SBfgBlaJK6DWLmLEivQ7McwKjrzDgfKWkvj+gA3GiDB7V41HLo+b15KZJSUTzgxJGjFvW9KNNm7nsanL6NAWdY/97/6rmzmzXzeBbqhpBNulM+xrLKxsD8ESNfiHx4p2+E3yrN7ZU7HemCJPMiqk+F3bmQwGVha0LYo23syydtLykYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199015)(186003)(5660300002)(4744005)(1076003)(6506007)(316002)(2616005)(26005)(44832011)(8676002)(6512007)(6916009)(66946007)(4326008)(8936002)(66556008)(66476007)(36756003)(38100700002)(41300700001)(86362001)(83380400001)(2906002)(6666004)(107886003)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?koCfkyNDMYM54BrlLagSO3/AzIwINbnm9nRyBwsU+LRbF3SuykzbGHKebpmC?=
 =?us-ascii?Q?GJLOLExUU9GfBbpdbyKU2bSw+vji/yCu00FjCq4Gq8fCx8USPJJgg8DmZAwI?=
 =?us-ascii?Q?buNBYxSBawozFgTc8DH5fyAsQ8TcrdSWBXvjew0oEY0WMqGnK3aQJ1RZyI85?=
 =?us-ascii?Q?xY0LgjEfGk22fYoisJUtpoIaBjoxGRQMWIbzlmqFMfzAMQqYcB8qVpXMhsdD?=
 =?us-ascii?Q?I4IbguwvmkI+2CWb3qXxwuWX5bgRNhDvsBWevxIEeI5mB3WnJwPzEG3A0R22?=
 =?us-ascii?Q?M61TIbpY8IXzwUoCHT0ZGOIdcIER4Ydlsj/olJeX2tbXYRkqiBLkj2Fnvoru?=
 =?us-ascii?Q?9uR4nwk/MAVP1HCXE/wnykoyCvn9xoXunV8QYIXvLSKND4V6+gmLiuE6fM9f?=
 =?us-ascii?Q?8N6nFLw5gWUAIy7HIvg4FEfHYOpfDv4wDMSTwwdzO3yGirffzg77rGWKCgXh?=
 =?us-ascii?Q?M4/xk4c4Kof47Tb5VN+GI2yMoVLg7oj80v4UbLhcSBJx2KDViSsCD8hQ2GLu?=
 =?us-ascii?Q?Jm5U4o0VmwSFSns9wNLJ/+61XABUW+2bJeGFliFxlOlXTq4LZNyD9euXJxSx?=
 =?us-ascii?Q?Z/W4amWmzH0QaVex8jiQLYNU20C2bFvgqObayogxLBIrmrWejXHMEx/jyhXR?=
 =?us-ascii?Q?O4xsWM/XkPpIR80Ho/yFOydg1byYdn7hAcpCzGS+ZmsgyqAmyqkAaaPx8LWk?=
 =?us-ascii?Q?CfMuDEw+dHtVkX/xA4wRAnR3tvHuObW7lid+AfiGLujslBW90ZMXK6Bc7mEF?=
 =?us-ascii?Q?/yJOkN4nTeDIHGUsCsSGcYrb2rmeJCmzX2aEOQX25yFMumYmVVWaJ4c10QMR?=
 =?us-ascii?Q?F6NyS7FyPhJG2+pIOFUeE3a1vugmN7hR3t4AD0JPfCs3W64XqO04GCK6yJTW?=
 =?us-ascii?Q?H0So6r4nNAHctjt6yCzIMHepDIgqONyh/GPTqw5eYo5/g6MvjC79EyRWCYYb?=
 =?us-ascii?Q?krRW4EFr+Y8MWjVoVfvpDui/cdVD70EB3njdbRKxneraow7WKam90BiJphkD?=
 =?us-ascii?Q?pBHvs3bwQj7jjksWW4CAxDqeJAPbuloEa5U5PGEP1aySZs3LHqWqnL/qkACj?=
 =?us-ascii?Q?gltiNgL++xs7C6HYPEwBmqCH0seTwolVi3N3SzCvWstl/IRtswjrBpds8RUF?=
 =?us-ascii?Q?3Aw+xj+3iTB/t9I0kWcF0M55NzK2p23DPdrpAP+/vCatyMQFlW9RB6WX3pOj?=
 =?us-ascii?Q?SC1uIus/sC/5j7NCreSEgFrIFTZQUyMjxbvRNN099yd58tUH2imhTRI1kCyi?=
 =?us-ascii?Q?o8loQvKTnOP3YTMB3x4mcobrg3O859HQaYdjQ6OyYsklSV+qM4FalNKLrTg8?=
 =?us-ascii?Q?6pThpsi8Lu8RLqplL7+AhrurYAJl1IkKOOm6VQCP4EhoeItM5fo4NjYcfn+A?=
 =?us-ascii?Q?1ZJlHBYAbU/ZWQJ6wB7Rs9Rn9A76BfoQaMjPgaJz1WAHJFETe2UsKLaIL5cz?=
 =?us-ascii?Q?yU/NJYczVVIXm4EMyo4Gn13ZAvyH65XNQkz205UoiXzpeviIKCDYWKtSSt1F?=
 =?us-ascii?Q?YHFkGNZ5OS/WF+wbQ3n6WOeo5VPNud85ZgzzyKF9phH1fA9/YnumfX/W6k/U?=
 =?us-ascii?Q?OTJPg7HLobs7B7NUGBze9mGu3iYq7QhOT9qTd95Et0baYvcX9Lt9ZOvFPWGF?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ece1f0-b727-430c-484d-08dac9b1f9ab
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 22:12:26.3055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXUByD6XV0kvgZCHwnbrXFvSo4i+IhQpnd2y7YSiFAlwMoMlwVz+KNPqG0bXIcEDNH7OPaN4NPmvRWACsgjtSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7192

Fix this warning when compiling with W=1:

 $ make W=1 net/mptcp/sched.o
 net/mptcp/sched.c:97:6: warning: symbol
'mptcp_sched_data_set_contexts' was not declared. Should it be static?

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b2fb7e41807f..224f03a899c5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -655,6 +655,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
+void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+				   struct mptcp_sched_data *data);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
-- 
2.35.3

