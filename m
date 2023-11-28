Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0835888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JhVq2G4m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7o3gGp4zhLovjEplRLqnJcWkhh4atW7TQV3cqiPCXCM+zbm/TrI4J388j7U1WWOA6lkSCgTJshxMvUHXFVz/0toqQXCnySxK6kUVh/tlVBAY9Acx8Y4TLFq2XYrweGWqujdQ/CCVm9WmgZeatip3aRP3NXS2EsVzxXApvA5Hns43l587ofH0aN+lPDgw0ilDSvn+3qmQFTm1giIZPezLxj6zcyprrgcKh9XqyWzvm27fQLWyKsex9tgXf+hbK1RvNf0EAixxM4/iepb63z2oirTh+8BtPrPcZX/mKdVmci7lOwkeUhpS4vpJqOU6bWVzPHs7Xij9BqszJXI5Mq9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=fuStmismz4dr6BAoDL0eQQvqW2eW+J/900no9jPdrF1bIAjhaYB53embYjZcjOLogTP4gePmMGa+Nq5+Yux8RiOyqB1bZ+JED1MzalEIQMninVQLaGbOm8l/qFAk2j18XYiU5b3pe9oU4jfaMt47IGA+rxJVU4Wkm/AUZ2SsmXH1EG7JCGu0nNa7JOUDJatg4JmRuSImO0u9byyCVfKw/cVRxIuzEwzQhF+6XofKUM+3CSLzIuagKOTLwSiV22dmEU9mGCGJJwy0WW5E9s+jJ/XdzHbfaOh46YR6oKMjajm4TSJZZ6ltjlrGHt4SLaYmrcp0Id4qIGULu3jy1epgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=JhVq2G4mD+7CsVUe0gm7dnFjMnDJJkTIJJyaAmwnmJ7DsgPrAALUQ+7PXkgzAsTdYgVGim5fYz/9azevBBrJw+wTuvl648K4rX0HPl5UH4OCIGQYJc0W1u7EwIa/FPg/zWuaOUN4Wv6fGJv4gh+FMGRmsLx13tVUFoLyynXZVDP60LbkDgw9wXp+KClJP9n4KH64IwQ1xwGTzLRV5dxFe8GgsDQhTXGx+N9PBXQ9h7gpzlnv74eUMr5efPp8jDH7jn5HWHH+vAE63Hnr2PeDzDg7GRF+7cl5yjDj/a6PP5d3+4rwxqsiY+CuC33WGE36zCF3wU9NdHHU+fgE2VU/Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:22:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:22:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 06/32] mptcp: dump addrs in userspace pm list
Date: Tue, 28 Nov 2023 22:21:59 +0800
Message-Id: <781c84bd56315a08ca30027b5522959a66b5777b.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 1474aee3-6e54-487a-5633-08dbf01d7583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B82kkVzZhc4nHC0eoyWEMl2AKq71sFfsE/rrc8C/pe9FUSAegtQ9Sp7tOMlmNvFRgSR9LZGCL3SUAnvklZkM4pwm0apHULO0d3UEGioJQSf3PpAEAG982JGBOC7Y34FQYjAlj14kySZYWJt6fHON2V2Cp40CRllTHPQQL7bQlRIMhTJ09eTrjXdAqTaXOGkwhPCyZtiomy93slWuxO2QZHWCSOdvS/otjWJgviHQIIYgN7N9GsFva7mBSUPkudPHwKMiu09/PkGNwXxbABdcknC8cayownZYydNqjgyqiAk58rlXHU8BA9hzUESyaqhOhMF+AntLRcUKdzYV7ics1msk6YRP5kPB19KYTW/BS7SJu/dLw9TwME8zYhtrNsWkM3xvuAuyukiCN20JELLCvpdx50mWwhLrOPmLzBGQfOz7JnlXEdK/KLt4UEaFB63n6q6MKAxx/RWzpx+Y5HklZcipkDFPZzumSciOJnYTO7WwnQElHVNcM0wQi0syy3FsrdMqADq/A7K87FvIXFYKosbdYbnjWelbxq/yIVIzZd0tYVuQDAUEozezs0HoZQ/z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(36756003)(5660300002)(86362001)(26005)(6666004)(6512007)(83380400001)(107886003)(2616005)(6506007)(38100700002)(478600001)(6486002)(44832011)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RyaHAunWfC+bPGWK/dAIuFU3Iis6W8TxnHIH7a7ea4PxdmC83JJsdCBRKx+M?=
 =?us-ascii?Q?KAxcqrWnE9BPjdpKmn0Wy/OXYtvoAjm5WO0jesgjbbIw3WJFT2DnxH1Y1hWD?=
 =?us-ascii?Q?MqknykGclb9Urmd20Ji/OWtmmmEbloDE5GCSfzHv4FPu+oNcL1bfHjc4sngp?=
 =?us-ascii?Q?9nU3NMc+9BmCeWPjLnGCeJc4gjszlKw8lemdWrBpD/F1qEKwg0M8ointoT+1?=
 =?us-ascii?Q?1aVoMBok1jmGrwwWFgUGoDQZs6ZhPceQoF8z6/ue7n6dtHbn7L3QW0NyBoBo?=
 =?us-ascii?Q?b9EJ5vh6xXzkYes6hfN/mOMmFgTECkfa6VF3wKuZg6pafOppYMQrWkXgT7nZ?=
 =?us-ascii?Q?H8u0SAqKD+F9lRzs/vsFq4Qy99nEGdB6rTmCBWYAyPuEUHFDVGt2pl5Vns5i?=
 =?us-ascii?Q?kIcnTYz7x50X+0Na3hgwZ7woV1WEMj0STTYZpeF1cQqCJregxQA0MZN7ZGCa?=
 =?us-ascii?Q?196ynkL2ZIWu8kMAiVH2vUnPdnl+SLRJlkSSbXOJNe8gIwZbkH0xkmnkaMCE?=
 =?us-ascii?Q?xQDa7HyxB6QJ9yTUTaqf5YZI4ezYt2eg8JVTZYwd3L0UFbX3x4d/qskN09pN?=
 =?us-ascii?Q?9TXloPx+7Xdet86bxAsuDJohiBZwTRQr8oYsza7oaRX8aTqHkZjsgTMVpaE3?=
 =?us-ascii?Q?8ixj9a1m19g6NKdsFXxlIbktAddINKNuIrrqG4mo+DNpiYKGTa4lbn3oiQIp?=
 =?us-ascii?Q?eY7qXivZM5wAYKh8AOoObrzMuKBjt1VzAWr2UmXV4v73cowB5CPqsHmxNnco?=
 =?us-ascii?Q?dXziHp/+mHxrOg3MsyXY1A0cw11ZU5vhwYYKjNtc8R7z5GK0Hkzi78yoRIvW?=
 =?us-ascii?Q?F2VyElueYMMOubqkeAE9Onor4Gn9JTTm/ChpZ1avzWB+AkevsjrcHrzs3+XK?=
 =?us-ascii?Q?P79CKdS5sVFKA5aW4OaBjwaeaX7NvU/W2Jmg+qkPJVbRwTFO/bA7m+Bo2jVz?=
 =?us-ascii?Q?ukHw1mkQnEoKiqDLUlfbMszUVogwtQNQfWwqk6xWpaHcpFcfZbBEUUTPxY8t?=
 =?us-ascii?Q?YmPBwA2noruRUUF7yiY8wXB9nMeYQ1z+dvO/niPLQLLrynFxd9ZAvU9ncn57?=
 =?us-ascii?Q?cwe4iE9KCGAdXr68+iY6AsiCuxEg065uSnPtUVmYpGMkU3ud3qJjt934AQXE?=
 =?us-ascii?Q?xarIBIke+ZWgRNCRJEivyEwJCB8RBK9VlRTx2j0Hwyyssc+sDrbDAMrXEhrF?=
 =?us-ascii?Q?hzesvvEH1eCZC1IMRcVbNt42/+Iu8gsMlQIYYjw3MYgzZPxGQiKZZ4DaLa3T?=
 =?us-ascii?Q?B/NZucYyYvyAF2Y3/jZ7m7AGyUQNoUXeT6x94SXli2QXY2PPnUehXvBgcgZn?=
 =?us-ascii?Q?wWOqAWgjDeQ8J3QH7xw8WShH7apKg88m/VehoIGNwoyP3Ea8xjnXL6pMHy93?=
 =?us-ascii?Q?lqvGjQT768CrSwUm4+M9lUtUr0T6EXLXGi/uG9pDVrrB1rEa1KddihBiqbRz?=
 =?us-ascii?Q?C5bR5asENeqpJ8NRvfYUJ2yEzVcsOpOxXnf1Om5DDKn8pQ5jVh2P1+3dE268?=
 =?us-ascii?Q?9Iwb5c9EEDMgUL+F9qPjcNi8bsy4bBiGvjWu/zsklVacE87N4HWxeVm00Yd1?=
 =?us-ascii?Q?zTlVr/h4Vyb6vsVwFsU6f/pS5tzHu0gU8Jo+eBM4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1474aee3-6e54-487a-5633-08dbf01d7583
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:22:32.1367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84zgmgPc5maIXSXWNa5TPpHYVHi35oylL+MOQTpsvJcPla8pxtff6Nj3yqzG1kWryR54jNp8jAMKIkZ0yAZDBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

This patch adds a new function __userspace_pm_lookup_addr_by_id() to lookup
the address entry by the given id in the userspace local addresses list.
Invoke it when dumping addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  9 +++++++--
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4cb52df57ba5..08b4211fbcbd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1673,8 +1673,13 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, pernet->id_bitmap)) {
 			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
-				break;
+			if (!entry) {
+				spin_unlock_bh(&pernet->lock);
+				entry = __userspace_pm_lookup_addr_by_id(net, i);
+				spin_lock_bh(&pernet->lock);
+				if (!entry)
+					break;
+			}
 
 			if (entry->addr.id <= id)
 				continue;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6999296cd5db..5e45e36ce1d3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -549,3 +549,28 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry = NULL;
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&msk->pm.lock);
+			entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+			spin_unlock_bh(&msk->pm.lock);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return entry;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 88f5b422f941..c30e59278080 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1021,6 +1021,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

