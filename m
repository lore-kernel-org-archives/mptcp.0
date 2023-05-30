Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66C134C8
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFBIdzrISjRlaUKjcktnPjJzxsSp45DWBAkQ+Ch3r7bC+Ai3hZmt/KTWVqlodwGM3HWxGYUi/omWT6V2Dsd7iF1/R/g+tSv/UhsDeVu79Sj2nBA4Nf7FwbI7FXUGCgZSv4CpD/XyrtPvBPbLrTvDxje/MFTzD5H9f29XdTGW9exLGz2yQ5s/RQfCLvFGWXxn6okHHBDpL+A0shrbE6SAo5FzPDfGPZCikSaMuydJZ2AK5vKoJwfmkM0clSAr75RbIBcZjNnnqzXGovpEJHbAZRdAx13cm3nOtBGW61+5IHb8fpHiPm/8TpCh9vkcuQW++VMAsjpPzL+Nl6xt/OySoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXTXQMiHPhtZVCcCcRwGPBXr0oxl0P4zJ9v5DnpZxvE=;
 b=QZZI8MNHxTM8N9rbmE0t9VLLXzl2O0kTTL3URDE+s0KzRMxgoHk3id6uS2YxWugl4IrqN/Ak+GU3Sa8OgET6Dz+ANHDVEdeK7UjkPWcaQxSxH+j3JAmAxYMQLABtP4EyPfLQ6DWL5rz+d3R2kQYyljdQaxVmVy4d3rL3wbE/fDNI4sM9WZlLgNbBVl7NQQhaDYjZRJzxOR89ql5sIaEqbh29zgYKgRl45lcwdK2gf8sabzdL4xWfVJg4sxC7h7S7fly2ovmznpyv5IxRzoC/A9KLJZFQhf24Rta1SIF4ZDEg1oxu4hvjjRJ04HjotoqComKNdvxwISIS0/QQWdChIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXTXQMiHPhtZVCcCcRwGPBXr0oxl0P4zJ9v5DnpZxvE=;
 b=SvaSRz6weQzHgjU199RfBd51pwnbuyBV6t1EWGPVU12wztXyMczYNxJKlmMbiDhHWdOIw4TZiQbhItHgJV5BBiVOoiqIam8Wj0yDj4impOdC89C/A9tWmQ5dYsQBEHHJqo+9M0fJQjpGyHqQ65MIGI25pW/TNwYib6OyScrByI5mkr2jCyT2fRAnUPCQi4WuKPkkbq72yIj6ru6/Lv4YHz6665RwFhdggycBLshpvmLiLwDQYKfgSIF/wWs5JCmxvRU0kIWG2xK9DpMULl7jfAlx1+MdfEteHpW7Td0GELC3nU8gyMupoAZwOEIi0n8gIptLfzDz5hZno/ne/nP5/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:18:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:18:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 08/15] mptcp: add two wrappers for bpf_burst
Date: Tue, 30 May 2023 21:17:28 +0800
Message-Id: <19e30aeefcbaf8f53f3d79e6e8c2cd02e7ef4db0.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: db56ecd0-acc4-4e51-f540-08db61106d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3+WlfpVEYZDhKJt1x98v+h8u0NekTWL06dJMiLqU1gAhxYTHzc64Ari5VpyKvZuOvu6pZNmro69AeFvO1SuEBQvzqxV5X8SQIzgSBqJFxwjNlI2f+uF1x9mn/eIYeQiZcHumpzPz4j2Yx8/6CQE6u96Mv3w50oCmzSnC3wR9Y8YL+ckaK5hJdO8hjaN0Vu67nI6h4gOT9/gVuFHXZ6FY2XHB9NIpIk9+pCLRL4SKDuyccty5lXFgBGEiCIzKI20m60IZStrwLBhZjqjCKRbytzvDrOGAqeMXoVxW2h9KD8uaMgWWZ2zZHSjghAaan6c97nv3RQSeTeqDLUlgSbTUbNZFYh8SQLNGxkfh0rE0kEKwXoUpnd5LDQgausm/LU2Ytt474P8VEhPr49cNMLAPAR9aVIpHlckX8Ehn8p7q7knaP/ytt9xcmnloGr5N3QlD5ZN3gBnwhX99gY3xeykRPQTzXfoIdtvl3LQVZSd0zt3tlLX6A0XaZ1H5o6JyONc2ijqxcStUNpIGiqWD5WNpmuFojVCVaSNRlM6axQ5tfgRgyLsUR+3Pp0ntnHyJb0BT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(478600001)(8936002)(8676002)(44832011)(5660300002)(2906002)(36756003)(86362001)(66556008)(4326008)(66946007)(6916009)(66476007)(316002)(38100700002)(41300700001)(26005)(107886003)(186003)(6506007)(6512007)(2616005)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ANfuK/b5pamABmaYNjOHJrw9y3334QgqfNut/CLZEz9f6kVKVe1K/ovKK+e9?=
 =?us-ascii?Q?Oc7KzkNWz9+WG6WEtEby6CBAfB8Rrbw8zX+DiU2yHCRA2sIWQscz/hN9TPeV?=
 =?us-ascii?Q?+99Vqgtn0sMN0MhDR8EKkerXs0jd+tbBDmwaVe4kxTD6jPtC6+Zr9q1EW33G?=
 =?us-ascii?Q?NYTx6SHMC7IleGZJ6HK9cWTAatVQF8K5t1NzSc3Cr7R5AzUkHQdXhUvhMdKs?=
 =?us-ascii?Q?u8VCv3lWdmSmniKJXgtbL9wK3Q+9ZJwqDIb2Us5Ksb713AI+JaqMP8Pmqylo?=
 =?us-ascii?Q?mRkf8quAOZ5TLvrQSm+JWUuGLxu5+WY1uMhIl+OEiVFNMXn1rkxVRCR/mreb?=
 =?us-ascii?Q?VU/PH9JSw9fpjXB6FyudzukWJMKrZsj+NQwBXahfWJ6yt7Oskj5VAoJ0iEhs?=
 =?us-ascii?Q?jdxvXuWZYqMy2Ysy+R/mBpfzNa4t7mmguTTIwSsB6D6M6CGdUDQ7fYLFb9Cp?=
 =?us-ascii?Q?R4KDrdQvfhz/YKOiAa8mePzUVosnHf7e7UbG/TquAz3zehwP0kebzAv9BhCN?=
 =?us-ascii?Q?QEebDKsevMOt54LUl94L4wsjh6cFraeVif/obbL4JZvbtEH+I1y4znUbprc2?=
 =?us-ascii?Q?cLMAX1V7O8Lhp2hjGkXeH5cvPh4CMSniuqGJF0oo45eeeCKDuu5Z/8Iu8Hu4?=
 =?us-ascii?Q?f8lGcj+w/UIYoZb30fPwSqDXT2ayHucu4nLpQ68M/+bvUxAwqu7iVOfvC1pt?=
 =?us-ascii?Q?egN7dPukfvd2I0WXfafY/yaKpxZluv+r7IAb+AeANtRB3s5D7ugK66la1TIv?=
 =?us-ascii?Q?GseRKyKjjy7dcW7/1+QyX2eT5S6E91bNX0zrCA0z1Fwd/sBd/trv4t8z1D2L?=
 =?us-ascii?Q?VZQQbC9PlhdZv93U2p7EY2U50RzeAglolbLVGypt7rbfowYA51drbaQDPbbI?=
 =?us-ascii?Q?pFMnsY1y9Ze/Tk1A//sHwCqPH0KJVdqFSuykyKdi3jRzeHwO3rashu3zoekn?=
 =?us-ascii?Q?sKcwmHjAHYxbvvV2HEj3fjiYJFs4aPhL+l8iwBNMieFz69e/N5fitzUWP2LK?=
 =?us-ascii?Q?GNAIIAS8G7PzWaiG8k6Mv2yjuub/tQOXZZ0BV0IPpf9FcH7K7tv+Qf/lMwb7?=
 =?us-ascii?Q?rO/Pj40vsxKZEbHe4vk3czCf1Ffu0fA3qZ1tnfdd4R1AVkQvRtHhTjkUSgbn?=
 =?us-ascii?Q?UmByMmLKhr7matHioT162r6DhnZSyKGKrPmqGgtQpX25pjKTQ3MmXiHwEtvf?=
 =?us-ascii?Q?ASE639j2Og1XKDMJQifuI/6+1kPLmL3V/hcMeGA2ysmrPpuH8oVxGp2tKdG/?=
 =?us-ascii?Q?A8pRJUZvpL5aP59sDSEk3KTr61iePoqwAxKj3qBNctZESFL4y3Im4cvlXjhp?=
 =?us-ascii?Q?K7refSjFd9rLuSIxe0apHQX/47FsR5dyUUCLs4mVUQix8shipEQrWKnwbg14?=
 =?us-ascii?Q?/EVRNYqQfNQiGWWp89ing7aQxa48o/vFbm5HQJ3UgxtjO+ua1qWejv3vlI7k?=
 =?us-ascii?Q?caqdLu/kVfFS2JZOC9Z1Ut8QJAFMH4p9ulk/eYzYjgelUqSZu6HFywX9qKX5?=
 =?us-ascii?Q?tDxWxz6IX73PzY4FhRz3ARY4lxyI6YkzA/Hb3gQh4tV4GjJ4x+tl6ACCDPYR?=
 =?us-ascii?Q?d2mutHcWbRZQ5ff2J6PE3dyPuq3fqxqaTjz3FZz1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db56ecd0-acc4-4e51-f540-08db61106d52
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:18:58.8149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVtv69a6hy4raQOAbydw2xpGbzanSiZ0oYmZ1qn7ZczMCWYVloCq6bqTQKOHroY3Ua8aDaxtPHg4XZjsMHVJnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916

sk_stream_memory_free() and tcp_rtx_and_write_queues_empty() are needed
to export into the BPF context for bpf_burst scheduler. But these two
functions are inline ones. So this patch added two wrappers for them,
and export the wrappers in the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 02e22bb49eb0..c8fd0915fa0b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1408,6 +1408,13 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 	return __mptcp_subflow_active(subflow);
 }
 
+bool mptcp_stream_memory_free(struct mptcp_subflow_context *subflow)
+{
+	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	return sk_stream_memory_free(ssk);
+}
+
 #define SSK_MODE_ACTIVE	0
 #define SSK_MODE_BACKUP	1
 #define SSK_MODE_MAX	2
@@ -2273,6 +2280,11 @@ static void mptcp_timeout_timer(struct timer_list *t)
 	sock_put(sk);
 }
 
+bool mptcp_rtx_and_write_queues_empty(const struct sock *sk)
+{
+	return tcp_rtx_and_write_queues_empty(sk);
+}
+
 /* Find an idle subflow.  Return NULL if there is unacked data at tcp
  * level.
  *
-- 
2.35.3

