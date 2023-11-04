Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF688196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZNi9wOn1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2u09vvdQTnNXkRtm5prBe8KELAvhDqI28sF0LB5nMC4ddnAMoz/M4Xpdr6O3b8iO//yYP4ddx2uYwLYlj+K9qkSfmUR8surzWipiIkzQt5TwOWQkEhsAak0FE/fVwkDk1P1Ou+T45OmIXImQTpSas0TdJQuWJP75Ayt+ZJ8rFJkR7ZnAEPWXe5ryj0AOId7gyrY9pg8UxmQ37foRbeMhU6O+7jN7wNcPyEEF/a+wvEWWF28b0tLoYNsFDaYqizguG6A9fcjVWU5EGOXFQHk6J6yNZ9lb6jljHmq5ISJ5IgSt2OKvzNEgsbMu4nrif+ktGhO91boXKLvFG3YyP+/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q43EAhfsY99oF0rZ9IZTikvKCXGZzcvmapxc0beqX4=;
 b=SZRWnlKKR6e8zMZofkF9odCCJdss31ln2sUAEIRAkh9XLvtmEOgdfhBhxxdSzgP8NemNotPPCdOmGp49pPH0JRuNRhbHMJENXCdunU+IHGSHr/Y1HONdW9o5+Igv6VPTYLSR+X09iPD2LjbQJPCZBm9TP9mWCHIfge/0j1kLZjwizzfEwlj+8CcsK76ot6FW+g4KWt7e9/qynFxFUkUB4hBGvVMgxsHsL5IH3PfUfzkfrvhczDG8EnoEGCLMaagbpCdYv6yEYjvkOwVLAFay/QFQc854yTmXGA5E4i2CjahMRPxgrKixvorXan4kEq6uZVjQDOggBhNxmP5Osy7BjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q43EAhfsY99oF0rZ9IZTikvKCXGZzcvmapxc0beqX4=;
 b=ZNi9wOn17aZqVZPZ0iFm76YklBGM6qGpZOky2HBO36fzYyiJUBYe7dgOOffwQw35cmhQ2c1XuUCzUmfpWQ61jd6NEo/rgCAzS0uTaBJOgdIuSvLv2Ov7Jr7axc1Vnu8M0hli1ZgaQ7AZFssxb9eP2VRfnY91X8y/OEswtCHa33VnCLhsROpEn+rJ6zrZ/qi+u7MHqQVccQRBmDp3IRtji4ZG5X+0PDhq1D++xKSgMlsfIrRj24lQaQkP4vDVFRTG6DjzD7djjYfujJaqBifVRbVe8iNN7Ifpr5jX1NdDoTQZ8iwlDwtJHthOexD9q+ufSXR/hSlzYuWVMLwuTyj17g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:27:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:27:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 06/12] mptcp: flush userspace pm addrs list
Date: Sat,  4 Nov 2023 08:26:17 +0800
Message-Id: <24abdc6ee9d125b52ae18d4bab317fc36b1d358a.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: abe0da39-2496-41f8-b132-08dbdcccce8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CFxv0hyUlkofF9b/f386dt3EBFPJpUPCk9EQ/SLfdjih0TJ74Q+Z+n8QCn00B+ZWoKn6n9oVFcfRJ0uKm1/Z++x8SKoKfVDiyysgZMuG31/P3obNnxoCca7Ttlj6jaY0Jur0eF1SEfWCISh9XjWSoMGK7tQaZFCz8/3b29gC1/5xrZxrdXKSDxG+9j7cmfX3ihBheKfaDM9Mcm/zRC3G7cRcZMzLpwe2icQ+eJ2n8J+Jk5Oybi3/U54SEdMkSlZvz90wWU9LVpW0dcW8B0dHlRw20gYvFCzxCSrMiQFpgHkt3UicxiOIU+SYcKyybSL4fwk8KSkzvvYqijpD2OwcQmOhGo5QYNdBv8DDo7YjM3wrUTQRDQ5EMitlnD0Sm8XSWcRhyH5mHARUzv7HJLfVj3zfBkEfx5rb2GEpP3Ex3wP2ELOj5g5c/15dUrd9eOR8tpaKCiMo4KDHmbmZAFbzfw9Eahbs2KTOQN8hV7Jijgo3TJMyAWbu68asemh8WkhPh1gMSs/CffFg3OkPdPKoUnbptbadfvgOekkSyGXGzgUWreRwUbvJpSxgGG97xK61b1ep2H5Dk4gVOJvaiE6BEMINf7FLpgAouLi8+QjZ0aU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PKLTvWIUCut+/x+yDeLOBv+3u7IVXPN/YyrDNrDKzPSje8O5ydv+2Mu/6lsS?=
 =?us-ascii?Q?SMchxkjDhpbA3J9AMkYlAKYr0m5ks0znfbrbsRjgNxyUedGcXEzj6P6EsVJc?=
 =?us-ascii?Q?fys54OEkwSZ5d8BS64r7WYrB0Hzgibr0MQxOx2PPPtsdoHtrJjKoE+ULQ5R7?=
 =?us-ascii?Q?l7OHxRjxH5I48QcxlOfCrviTf5h62iz2K5hrMcQ/LnNrWiGjWRVFrJuXolcD?=
 =?us-ascii?Q?1m+EwnGqipGpXe+F7ogXbDBgewajurxyCtT6ZIunCxYKNlVvdtZcQCaqLL4H?=
 =?us-ascii?Q?OqCpJZw/ArVzMnepw2YaFuCRKDu7WnjGEUR98bfrXnUX4DCAo6zk6n9iLMi1?=
 =?us-ascii?Q?fqNr6RauRcuIiB++rJYzScFG+/YWlX8v+Y2ZuHpC3IBsrYq8+iwy+I3HU/A3?=
 =?us-ascii?Q?G2VV/REaMAenSgwrEPONQ/5p3nW/LwvGqK75tSRdUVPReOTs+FxMx/1ZMsgj?=
 =?us-ascii?Q?u5H2CjhRykjWRtyDThUrQMtb1018Bx9BBvd91/pDyEMy/0dRIdut+gJg4g6t?=
 =?us-ascii?Q?Gr+voityIrSMJzwk9CtnCyF3pn/bDgBN9Ae8lYR/80Jzu8XyfLSm0UGSn/hr?=
 =?us-ascii?Q?hJMBDaYfdBZQYyuRqu5dLYEHJh/S+CX5TyIgd0zwPT6m5D7c3Z+MqKLSbBZo?=
 =?us-ascii?Q?OTAS7bjlOAlaO9ldMrkW3wJrWOj6QiBMmKDqE3/Zko8dwRr6JI0Ve/4uPDOL?=
 =?us-ascii?Q?63b59ZhtrDtif1MDEyGpl1veALrW3OFeU5R5+711TOUPUdTWBKMpeBBeEfSt?=
 =?us-ascii?Q?DLX/aaCwCdfeXFYxlbHZiKFquUsC5JVG8dbXIIEaDZB8UFJy1WkCMB3ya3L5?=
 =?us-ascii?Q?ApQJRZOn16NFFdOTJ537215+a4DgLbDK7EOy5Eure3S+6wZ5meiYCqLcsISh?=
 =?us-ascii?Q?/T1Ac3KEueFQZEzQMpylRQGR4gJ0NJJUtcIWkjS1/TwiDfxlPn5s+CzHKJBm?=
 =?us-ascii?Q?IyE78GS/Sy1sN4EBDeAQg9MrHR9txQyJfSciIHFCbxP7J5dUjuq5usJ0OZoj?=
 =?us-ascii?Q?VBpQiOY4pagHa3bS4xjqnnd/HB9Xou4E1Yj2KX12wZit+5wbc2AiQLuKD/tx?=
 =?us-ascii?Q?1J2fZ6ocmvZg2cIJnv4uwLa6kcsIXlT9aqgHUY6eEgzbXjgoCF+7vjz+tFup?=
 =?us-ascii?Q?GGJF1dziKsjoxvoMihjpyjF5JejI9QcLLIzsnWa7NQ7qNKJBpPX2Fmw6UPpn?=
 =?us-ascii?Q?0KnTaGjeM+viVya6PIQwuoJPxrB6BtRcYULMhKZ1V46mp4Ru8OsPL0bm1DMl?=
 =?us-ascii?Q?V5wRawAMPBBu5Y1isUmabOLRyU6aoVqo8AOA/slvsw8R1beIPCXZ8K75fkDx?=
 =?us-ascii?Q?6vRLoZnGg7/Vg36J4fIDgeSP25fStb1EQL6hwmKChwKIUbX34CHlqk3LpUtk?=
 =?us-ascii?Q?XBvCycqNzx0h+UIwMD+alZStUGavSJ9Kd4MSADHbF3C3PXyK6FtaT9HPk+IX?=
 =?us-ascii?Q?KaFko0VkpUZ0UCN3h7d1lCnYT7utcc+kPNH4C26j4mtkJwu++AQ4DXT39VI0?=
 =?us-ascii?Q?1KIVDwom06SjIa1Y1OXxKhj6q/fz3hW6ICERJ/KrW6QqFPh6qcOgjEB0HHXW?=
 =?us-ascii?Q?4yUHIf59/VY96Qg3MVAj34ZgVQBx62ZRJHAaQYMV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe0da39-2496-41f8-b132-08dbdcccce8c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:27:20.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auZ2DP/oqDzSBFoWeZj4hZ2y34vjXd1Gu5JnwB5Hd3pjDHp92XT0sQeZlZPou/EXm0xDjOBUi4N1DCG/ZoG7hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

This patch adds a new function mptcp_userspace_pm_flush_addrs_list() to
free the userspace local addresses list. Invoke it when flushing addresses
from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 ++
 net/mptcp/pm_userspace.c | 26 ++++++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 29 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d6594fa80cbd..72c7b929c229 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1635,6 +1635,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 86f3809c0b28..1302680388c2 100644
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
@@ -558,3 +560,27 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+void mptcp_userspace_pm_flush_addrs_list(struct net *net)
+{
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+		unsigned long *id_bitmap;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			mptcp_pm_pernet_lock(msk);
+			id_bitmap = mptcp_pm_get_id_bitmap(msk);
+			bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+			mptcp_pm_pernet_unlock(msk);
+			mptcp_userspace_pm_free_local_addr_list(msk);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2d9e8a78625c..9b00eb38b2c8 100644
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

