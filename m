Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2056.outbound.protection.outlook.com [40.107.105.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE134CD8
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/80jOaSP17vmnRAOCC8ABY9sNUx2VTfi3utWKWE+bmXQtHsGTzHfnOZc14DrXxfAa9SADSEcjY3Gr612oASpMfCW31rQulI4/ghvWmqZhQqDiRYjQfbRLylQcG6lmbJC7OCv4Lebk5go5Dg4SUrmEBt8CQ82yA8ONS24C5WAP2uh6UhRQDyiIv1XLw8uekyXMvcN0ZBjnCuhmC5hlae2MrsFGydeRMQ8rqjmmaXjEwZBgs6qOIhFRvFfUZZt7MvD1C3Zc3KOvn/YxebdUkvWmyp9e6f0R1ZGpVg9oSbfXoJym76v2bgtkDFtQDAgbT8j2Ghy/yqNnwszE4Cy2f/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpKTSE9FxJceNojrpbeUuR3KarLL0hCiQCrYnuj6QgA=;
 b=M/+8KIPiFLVo36C3P6atat4MXX9AF54LNDAmsHTjkkCm/U8J72bBZBhFc2EWUjsazfp5fRGjBe+wNftIgSyOfBrwBSInEhgMVLlBiDxMPIy5A4NaBJ8qcddtyGmbkCmERYII06L/opM2CBtQOb4JleJrpJtiKxOClG/XxcaVQjh2M4wmuC2RKeYdmgTM3kLXdxZPkCTzl26jzkNofNW0S9zakKbLc0Y2XBn/OvM1uJDKMO/5s4t+kR2K9ClYOgFQKQjyy9iPDrwhKQdOr3x7fyrwOAs3TqYv0zK+zMXOYqBBYJFT84UM1s3YD6xiRp3lxuLYofsvjZv4zvi3bSAkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpKTSE9FxJceNojrpbeUuR3KarLL0hCiQCrYnuj6QgA=;
 b=e9M2xZbk3hDOXAa8Wy3S6wWn4u5Q38wmxzlpiKKgV1tG16m1VBXJU3rximEzmwOW6uUs850bhUMjQhTwghVZOtQj4gPzbfN4ylix6pF0drTtlhRW7Tqinpd1yt/ZQj3ocKJsmxWx83Q1wRlihen0CvLeTvw+XvwQY+qRDGZUedztqShMbQRj7SZHdGuiHghQwQbAXTnVo/0BrXiP9Sssto1JR05/nWSsuEuTt9bx/45eMcHWcxWWxejiDZqEwji85BBDa41BddO3wDFiP7bd3MbxHxW75KacCNksEkAtkTqw0N8pDGagDc6Qk05uRWX7StTjAX+fU4og/xx1qiLZDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:04:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:04:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 16/30] mptcp: userspace pm remove id 0 address
Date: Tue, 19 Sep 2023 12:02:17 +0800
Message-Id: <47bca92c35edfdcc16669ebf81c2743ba1cd43f9.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0281.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a923e6-ddbc-4ff5-6e29-08dbb8c57843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WrswLOAbBxYFQvvjnSvn480zNhZalHRStfy3GnVF2xmAABp8JZcQTA/qCafZljw4ilctIeyLxQF3YhyLxJgBO6xZFproYeMM722pt95tq07dtOg5+WneOZNmYlQ+zdJyaTDoLQ2qo2HIvxnI90C2/Lm2OYRazStIDYu5sT6+teDFoDiQ+LjZmnT67C6h57zXwyp07W+V0LURgwUBaksw8ZfJYeEwY66Ae7Ue/MT8wSvG+pzlW4brzEJYVMEtZbrf36q6LuCz5UCHMry6+9+M8BnQyRteyFz8875RgXh5bL0TUPU145gd6G+11BK+kqbTnej/dQ73hX0APyO0rxUFaZRvmfhQ6M32UU9JA3H8PznHCEjSm/8cl+IP1GnDvBiqd1gyGV0iNA29+8TsJZrdG273MNqQAh7SF+0LVB68PZ1jBLfY5RpAGNSQ7tXjj9tskrO95hmKjpKfZ/7zi9lIYyBEbQpim163geN9O9BPMjmmHqUzJKAJTE5+UIr5D088IjMgyBLwrt/4ngnv75jbyLpJ/7tkNQWFb51BtcF6WYcVd7WMrBw/1G67s/XKkdrHMLubmla7uU7SX0JzLM7Uf64ek7+kGW42lladwnNYly0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(966005)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xUs7xDUlRmEaXo4/YXitCbgADyp2n1GfwTob5WNjAJ6A4af6S4PdjPkqzhUo?=
 =?us-ascii?Q?WTolEhOXBwHzVB8wFbHHqb6Pq+glBpPNFD3rXX4KMYetWmt46fadtXYiZJSN?=
 =?us-ascii?Q?GFsUm3GH7QBx6MJkMXekRGp96xSzUIq2Mn1u9UJQg851fIEUOHl8QhaA0pY9?=
 =?us-ascii?Q?4njiOfqsARAII8bS9tS7GslO4PisyDwJU0eudHH477EoGiwDDAwZ9St4LAbx?=
 =?us-ascii?Q?o+9HXvx6RhlZm4Pk3zDGvFAccuBrZGbYPPuX2pzvVKZwnSaL5mYsmPqItM5z?=
 =?us-ascii?Q?oc8NW04XQet8jmUOVlIXG4YjiBOB50PmfgDVkuRC5PD3Q8PKB81CSaZ9+cKf?=
 =?us-ascii?Q?euugDCwSZZbFX60BZO9GyvaE+wkx68Bcv6My3ciDKIzSK+auYY2gXJ9rqo72?=
 =?us-ascii?Q?fzZx7MzetVpvju7Cbpea4e84vGKrxJ1uppFpuVSBxA0pDrslPJAT1Cxr+H1f?=
 =?us-ascii?Q?FPvraCFQT04rWk/SOfJujCVqbB8SwIDyHiLTEJM54HDXPidUjMEp2p/bCxDX?=
 =?us-ascii?Q?LS8xlVEckdgLiyNaGCxS+QI1vBRH9pPJ26eh7SGuiMPo5rbFtdplDLMgqwi+?=
 =?us-ascii?Q?5t4D3FYzH1arbMQZWBnuDsfj/ZTkUBoVna3Tp0Ao/bHEXH06raLCITcQTU7X?=
 =?us-ascii?Q?ICrF7bjhiJgwuImNdEMaXr3l527L6+p9kKohyp/qRAvbur4SG0pMoPLWycsC?=
 =?us-ascii?Q?1Rs6s0SZulDqhiqpiEfTYB8zwfIjsW3LVVY/872PDzPAEn9QAs3GcI3G81Fp?=
 =?us-ascii?Q?l56NDjgAanYj5Ma8FfGbX6QL3X59fq7vz9QVqTzBdnZD4eyRNW4SOC8xw9+e?=
 =?us-ascii?Q?JhvlfvJFqv6QQbpjgQ0CVC5zQJiSLTp0br+8MdZWZZqNs3cEc+4DZZ1TC1z9?=
 =?us-ascii?Q?EpITTIY8KE4rwLk2ln9rLhJUI5hWRTZN80KQ1/u8MWcG+FTXEa9oXXOR34Et?=
 =?us-ascii?Q?nN5oZbJgDEWs901PWB6XQpwgKzMDL6y35gCo5Mjq10a+MY7UpDtY5mFSbNnX?=
 =?us-ascii?Q?1Iy5bhGNDOCVQcyBrHaa5P0BoEx/4ybLd0n5LecIlDSNBQ9d9RQHrRuiYsqN?=
 =?us-ascii?Q?BSFNHKGMtYCU2TOt8GkwYe7xJQcsPyQTET0+dV2zW6jxYIMCReA2ZtooemGK?=
 =?us-ascii?Q?DePK1liJLPSHYvuUgrLKUAVIt8mG4WnOavkzsCVkJIgBHVzuVdxlsrNjuWOR?=
 =?us-ascii?Q?aBn/vwOSc5+uFziT/vSdYLbypV2GeZu1zrB5Z57iow8iQ7SLaBcfQnVZlsrG?=
 =?us-ascii?Q?JcYLTBkPQMr7oKjG8CvA9lAukRPZuPcmu2kR645+1q67A8x5JzGB05qXOJq/?=
 =?us-ascii?Q?wG67tnJ4pauq3Mn31qtDghJlog0W2zPjEQ2NNV4mX46KvB5IQ7GbJBiWHjRT?=
 =?us-ascii?Q?nZfjAQbEPdO5CxQDDTIwRW8J4e62fHrSzc4dl1+CPeJYZXBAFeCNaS/1vw4S?=
 =?us-ascii?Q?6IXhYTaUK6YkpzKQ2eWIue+igjQy1aBxblexqxzTUOEpLDXp9StZAMIzLGrk?=
 =?us-ascii?Q?rjngJlwPePoD8UWzFP6SJ0KK85cTld+AjlBzGpXug9stfiexBPchZG7elBJD?=
 =?us-ascii?Q?5zckWrUv076gA2HDAf7nnDMyvhiD/JVUJIDFwdd8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a923e6-ddbc-4ff5-6e29-08dbb8c57843
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:04:06.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cncPofNyQAHW7NzBIjX525WhGzYv/QwbxGH9LpBwFZGRHJhxpR50S1WLZxpNoCMrjPi+TQ9zI5wJpiqv/hu23g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

This patch adds the ability to send RM_ADDR for local ID 0. Check
whether id 0 address is removed, if not, put id 0 into a removing
list, pass it to mptcp_pm_remove_addr() to remove id 0 address.

There is no reason not to allow the userspace to remove the initial
address (ID 0). This special case was not taken into account not
letting the userspace to delete all addresses as announced.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d8dac3eda7dc..c1dac6d0a28e 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -211,6 +211,38 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
+						  struct genl_info *info)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	bool has_id_0 = false;
+	int err = -EINVAL;
+
+	lock_sock(sk);
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->remote_id == 0) {
+			has_id_0 = true;
+			break;
+		}
+	}
+	if (!has_id_0) {
+		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		goto out;
+	}
+
+	list.ids[list.nr++] = 0;
+	mptcp_pm_remove_addr(msk, &list);
+	err = 0;
+out:
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+	sock_put(sk);
+	return err;
+}
+
 int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -245,6 +277,9 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0)
+		return mptcp_userspace_remove_id_zero_address(msk, info);
+
 	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-- 
2.35.3

