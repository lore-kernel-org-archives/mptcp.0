Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A9320F
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XpTRglQx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlqaLjwHT/2otzec8rVgtmQZfcBwlR6C44AUzKMf3UsrAO2xhcrQTNJ0GS0++uXOJJ7cItOd65bJzFPk8MEZWIeY91YhZSZyBgQIZ6bXoM44l2DJOogINcvwLk2Qv+9vpF3U6CCrsKyuy3ZtUocgYq6QDPrDX8XEZwn4PJYFs/gvGTzbpgdI1rQAzUe2FGDu+4h9cFatZDmGchxgnMCi/ieMVi+BohiV3LxfS1Z6U3Zzh+ilZ9eJ2apl4DgqNgkULUz2z6AyRKwS/qjXwm8TSc0YDAGiixd0UKvJRtSO8qBBKq425kAjZHz3NvbsLQW8jZKGbst/Bi5MVizks9e8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+pLfFetXjuYnBXKMt49PdHXoDBsdRVDlUyVuIUsOuE=;
 b=jtDT6ywATDpC0FeL/xkAqbvXC6WkxtOt6dy+KnEyqe6LVTzvcJS7occq4hGW1UHpmpX5JPgfOOwwYJNAfEeZ1eY5Ep5bPJrigmfPtwIedcrn1TqkT/sygKrq9Ch6mMowaGJhX5CpyKWom837lY/eP6/i2Dnook1vhjPMKW4UNomrw7c5gjAhn+cOuwhi2o/yzsOREtPEt0yW7Tio4qp1Ui+4m3v+VeVZd8uIbo2/pGG79B5uPP4rmdFeiEOBG/nnaw8MPk+PyEiunP6vu96r7DsdB2oAUVb41Exo+Q64KgaBNekNCAAeMP6sMQnKv3cKTWZIlgHCu6tTQsw0lC9Ubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+pLfFetXjuYnBXKMt49PdHXoDBsdRVDlUyVuIUsOuE=;
 b=XpTRglQx8ctwXR8I+gr6JBqwxnkmHMH70nGkPV7aPPoWR51F5L4lQaDRyorWJOsuTdmpYvujmoyTqXXDF2UW19Z3x5gJVFZ9my4FWSsNSQlaRkVjkiM/MOEj8NnHVA7hOh1Sq6cqREe8L0mX80ICmAuBILAIe0rK88qqNSnBX2kMpeWfq3l+2vdzzQq3C6fJihA6+IwpG9ezC9iuplQZQhS6OxmP03qtuEIjw6G33h81X7nwKkhOmS6271ZQ94Yew2d8kzmzVNbcK+h9igTdzvOsqWLnHL2mScioXOtiWim+Xo9E01/SnTVjkW18e3B8WpbnJfqDEl1ZPHjMVDR8Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:51:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:51:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 12/22] mptcp: flush userspace pm addrs list
Date: Wed,  8 Nov 2023 14:49:42 +0800
Message-Id: <80ccfc81befa60bfa271810ea00e8e987c455d1c.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cb6876-b5cd-48c7-a633-08dbe0271522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d/HFixtttEpvpu+O888v/26dk+5fuPgP+gxqxmuHqQAJPVDWdjuz0q3WwDhVQJ3s+HLoxLboSwGKFHhUVn1eQQEhlIGUGs5+IMIfjTC4hpcU/J/9KvrpMC4w6rCymsB/58UFYh23FI45pUz/3WzjVsSyI4q0oTf939pVB25zD6dH+N9165aqNmD58Xlk0hVPboRzId/OSbA9JAP/5qQSaBFlBX2pYRkaRfQGe9UXk+kaTR5DGLxG9cATJbilXX6xojR1LjM4WcyKS3MaZ5nCiFOmKJfFZy3vfZTIGWe8BqlC2i2Ql04W1/TM8zU7w6ZMh+8B/egljAfTNkE7xHLeWcCghJgZFxQnYT5jGT4WmkLBYoUjAa9pohF8Bj+jvuF+wQSf3NEmwlsYrMpjnQW2gfka7GG1JULDy0mT7Y5EmVlm6AqwCxn7GBDTcNcpS6VjYJkLcyzFREPvpx5LWGzuifR2GX8CF6fVRpAN002HGuJWEefKvChM1WoPzFqCm0hsZAcIHY2e+vPyLDgGbCzY6XL/YlLU9mLXuAVcoiTzcnM9v0P7KUNEUtePHrPqAGKCF2gHqS7eBChIB5pmYLTdabnrvVNDsIzRR3CBDdw8T74=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(83380400001)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KHU4q+NVfaFgJ6X/0tojxN8AUHp5pK2vEP2QYisVrxxHgT6wbwOya6t1hrPM?=
 =?us-ascii?Q?bNlYHIef3zTGsakiYs4AALAyAUIFDU8bPjTDT9lt176SmNxOBiQhIDVUAoz4?=
 =?us-ascii?Q?R8PuT3jGmWaSSFcx86QLPcMKFMfLfvhoEKUy3D5R819OFkSKwjnkskDlGF28?=
 =?us-ascii?Q?iHyqCjza0ZH2NeI7Ui9khDDHo0JvGW2h/IP8D/JRkBHkPR8/mjbJPdSu0DK4?=
 =?us-ascii?Q?KHeoypqLTAwXswKcpLpziB+zU9hU6CBDA2KILJiRLl0XlGcQ4JsavJLjFYnG?=
 =?us-ascii?Q?oIwdwXpOOgVg42CuKcqgcfTALm7Ll/xJN9bp/jzyAtUv68to506xBCR9p01C?=
 =?us-ascii?Q?NJepIEYmK15R6OAmJRGtROIh9/xC+zNTg2jMnkYUBQp+S5RnHRKvBuheLEii?=
 =?us-ascii?Q?FfJhaDlFFfpw7Sauyz7AoRrby/CdORuM+K4HH5HmZer0aNhZC7tG2r1SJPWu?=
 =?us-ascii?Q?A90dR1kyUVp8q1lptiL+gTX17D1tt3kLpOUlMvjPlJwI9Z9KFsRvrRKlpVTr?=
 =?us-ascii?Q?Cu+9Z+uN953X+nClELh568ewRFBVMh02Uci/Y0nFfVkXOmExVCh0MIqFTVZF?=
 =?us-ascii?Q?O6Y1tBjz3qEV6jjSauzjr+RYNSFAxjHmjKbBZSO3psY6dqUiBagnkezbsV1r?=
 =?us-ascii?Q?Cbd3QuTD3tsOWFGGFTD5qCLJ+oLivPYFS0wYqyMcWdD4rvHwN/NerF+XF8A4?=
 =?us-ascii?Q?jYwjEClSFI28TduXqksjf+ALNEQWoRomVJH5VDv7fL12lJtFBgJ3C/8qfvju?=
 =?us-ascii?Q?d0XKxgB1Su4Ae7NDTIIo07diQ0TOK0oaJHwkg8YvTUN93ct/CU8UFYBtBHbW?=
 =?us-ascii?Q?8kbroScBy1YgswuqblkmBIyjgLt/EXHpV/g1SvArwwyMUzflYffN5NF/d/Fg?=
 =?us-ascii?Q?O6SYoBOZveKdoneMgyrx2ArJAfuaJzGwTWQwvlFicB6v78JFa+lktqR7AWfY?=
 =?us-ascii?Q?4r7SSaIJZoeBex7GjKye47d4VzhYwzw/Pw6yfgf4BTiILzemiTcq7t1gyiBA?=
 =?us-ascii?Q?gvE3M4c4TtQ3R6s/ZN/32UYBZ8uIIIai7nalgM0C4Vb48Iy8GC/hxo1coq27?=
 =?us-ascii?Q?nBDChqOSgMz+vAYe1B8g+AMH7P243+vGGW4zmWha4KC9BBv9v84drolUk+hL?=
 =?us-ascii?Q?/3pfkEC8IPO03mJ0reqc5GycwbrKfR/yiUyaPNOHERyEIFaEv6Le1iFaT47y?=
 =?us-ascii?Q?sQ2yYlcrO+fB3bprig8dzAFbbzQh0Xka7IsdTcWIh3rDRRp2fO4oSao+yGJS?=
 =?us-ascii?Q?fsjQEKIx+vF0or/JtW4ekfyPBVgKVbwBShbJgG1++TttucPUW+sGsEbZZNhk?=
 =?us-ascii?Q?/XnRqymutYSuUC91BkpanY4Bn0R/3hOPdGSH9hroSoG/iLZap6yGhUVwmiOM?=
 =?us-ascii?Q?8MgFFcKXIHdvCekbrvAlcmtVsHqlS5wMVFHFhGK8D/ga7yFeQHE9ecGJkHGt?=
 =?us-ascii?Q?s/g+4yo1f8hIe3ouQcUHpACBM+SkCRKEVad12pzu8gqFOd5jQUG6U15gHFNd?=
 =?us-ascii?Q?PZ2VZqvvewcVlfS/E40FjEgi81DXokP0vI4WY2R30wZRGF8QH/SAHGxdHkLK?=
 =?us-ascii?Q?XoTpGB8czv3e4JCDF1o9uEcaSA5I0rO5IwZCBSC0KIZhyn6t4EjPwWHS/kGY?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cb6876-b5cd-48c7-a633-08dbe0271522
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:51:06.8756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9s/O7Q74nvJlNUu9dMLIW4p7jX892PYHB4CwffTzf7ZGFfzMfF/nGrWD2Cg8307Gbw6fb0grhn09vaxWdM/hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

This patch adds a new function mptcp_userspace_pm_flush_addrs_list() to
free the userspace local addresses list. Invoke it when flushing addresses
from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 ++
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 28 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 08b4211fbcbd..b7e4c8d21078 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1565,6 +1565,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 70f6a510e3b4..abcdc95e7bde 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -20,6 +20,8 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
 
+	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sock_kfree_s(sk, entry, sizeof(*entry));
 	}
@@ -580,3 +582,26 @@ __userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
 
 	return entry;
 }
+
+void mptcp_userspace_pm_flush_addrs_list(struct net *net)
+{
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&pernet->lock);
+			bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+			spin_unlock_bh(&pernet->lock);
+			mptcp_userspace_pm_free_local_addr_list(msk);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 76981adcac22..089fbebd21d3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -944,6 +944,7 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_flush_addrs_list(struct net *net);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

