Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DAB846B
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="mSV71cUb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzVZTmWlHEgH3tFgdS3B0Mw9O2f99lQKVWsnIQLcblReahoW3OMysa7KrF0wmfRY/Rcqbo/+pZCJhO8bHn4TRnFvK1G6qrMXEZjw2FjJWh0RJ7uzCeZ6y9vEDfwucH2NRZrb2eZUOlKU4p2qFjZR3aXSO8WfNv0B4t2noE9Gv+gTynmBzv+hBqhaNKtMQMJ46PfEFFP9UbO/S2wMCjCXnBJ90OrriKYvvybDGsobrPq/xwEeIVH9Z00wj2750JLFRtwwQ7FJXXPAIpNbJQ74CpgcmjFJvR4SbPCE/RppUMShCExVHs2Prnhq582S3gBR0hTzS06ps9vMB/LSYB13KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNomTqTnplDcbjIKmVdkCBc+iTYZU0HZ8vQrrylw7CM=;
 b=PgWue6JTE1NChsFfVC4HqTvK/jVT6C1pWwt1WgqR8CZrRzvVyVTRSuH3z6dMEhj7gWID1NZUKnozeVoziGMLgv3UZQO9tFrjU5joahmpPY3m1XpXMLa2xvJPir7E/XK50Bk4IpL46lLcw+5sdqlMqO3WHTqDCvbQsDLpHuom9UxWgn8M3+88otxi/+e78xXj9aVGLBR24gCt+tiMvhJTUUtqYNrnESm4F0pmC/DkYZRedAmcfJmD/gEmS7bKS+rgLwQZeOkfiwcSDy+krOLL7zBBqEaPsfo6D2dspcxb7yhgdu+6EpUlZFMQDcky++HQ5hmFhuIegD9E0GZeGS3UhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNomTqTnplDcbjIKmVdkCBc+iTYZU0HZ8vQrrylw7CM=;
 b=mSV71cUbDzVhRP65gBp1cGS7qx4CLpSLPQtzBcWDokQTybjyepxHtzYusLDh4M9jSY4wWv2DZBmtGmnTde6CKea+9CsGzUGysJY4etGKZJi//wDo2cKg3FPng4r2W6kOZM5TZzobBKYyZo4gM6lWTKoIqu/eO7sXT8m8UXPFq3a2x0+Mn+dxZT75q0AvBHspMeEDDqy30J09o5bLJReDpelCR63I5bTF/p8EmYfOO2GVXak4DJF23jOt9LVMZ8bUZxULx4Gd5mA+D+VYFnKUlgVGePeJAgGKqjFTYc7uVcEFekFaXEonE+lUoZUgDQlHHkpMOa7vgmsa3MmKhO1GKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:36:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:36:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 04/12] mptcp: flush userspace pm addrs list
Date: Sat,  4 Nov 2023 16:35:39 +0800
Message-Id: <e9fd451e620a078adcb5da6dc6d10ebf926896aa.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 85663380-873e-417f-3c4d-08dbdd111c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Cik3mYHuF49BK9dbuP0skpjDAMhmX0UJSnJ+m3tS+i3WN6dhcOuPIKl+Jo7ZLtD0W/DNeHQo0RpEcOL8hL1aDsEkqC/96BgYcO1l52563MT9IYpGYEywIdHTj6tvAxcvCjzD8rcIT2gNvdgCFvmqxj9g5QnWDr14nqkhW9qARP+E4olQOvAxS5bTjAUp7pJpx1Nhfy6J3JJfJ0CbfNDNRNxPo++iWufBhNq33X7R2e6cv1hVM5k3KEwuuwN07XhwmkrqhKNqWtcui7ffFqWhqS8HlKVB7pPjBODVAvlhmaeJNTIIa1B3earezqhjptDQAnwz/8pEeuBXT8K0zokpWwBqUDRGcTD5VmykfURLHc7ai2143jefxIfMQN9NRsTJrWq4S3ZgTyjKpeVw92SmQgGN08xm3337jpO2Ago91fTv23D+U/9feFvnUi3yrGkOw7F0oQhWzThAzXNauITpHv7T037Y0TqwDpKOZj1zQqMU7OewvLT8OUKdPrlUuptZkZT1y1m3tJ/jexp6hEq6xXFwbN2jfdlECNL65bequwEfXiTX6RnmIiRUcY/H8Wynox7Zb5ScpTTZEymWy3VXkR8VDvxKlZ33hQMSIKyIXUk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(83380400001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vsdEaKbTCKfQqGuHjArfqborM9hrfcqGVow/Lu+Pj4t+gnYJ3mtgouLOu+k1?=
 =?us-ascii?Q?sfKQrwOLMcUBMJzYijPqkqWxD4O+hel8rtV6iPyWMU5VDM78R/GAv508bs9m?=
 =?us-ascii?Q?O0sjceuqCSx8XUbJjzr+BTlDVDf2XuGA/9x695f3LVsU5lAhTMdiyGT1NS9O?=
 =?us-ascii?Q?hpRr5zop+QM0OGrSxNzwKQytO11Lc7/O6HjArJNPNra2JiJaPA8LFuBE1B6O?=
 =?us-ascii?Q?0AWR9WJZ02HuEaJ+sqMdL13AUjrnLXypqAN86lvzlGE7PWtn5nGpK0WY1i6z?=
 =?us-ascii?Q?f5XfGo1lQoNYW1Av1xgwFE/OSJjwrPza/wOFDqaQZZo9/U6DVrTEQI/k5ENO?=
 =?us-ascii?Q?HMxK2xzNTwb44JnK+YY2UcJD1d6TDkWDOvzQFeT+p7XGUfpecIXHzJ0Z/YR7?=
 =?us-ascii?Q?uYrxFa9LCpU77TKwVy2AY3YASgisnLi7n2PBRyDYlNYTGWt5fq73m0OmW2bY?=
 =?us-ascii?Q?tI4jrLqgIDI3Bn+yfX9DOt2gXIO3xpLBFZXNns7JX6KtSAdQurOTuxyofGlM?=
 =?us-ascii?Q?/ZdgtSlRlCz14BHwv7hIpqEnSy5+VFF7NYF5VfrGJKTnQWuAsiqhrIyFHgdh?=
 =?us-ascii?Q?41N1PabCN1tWa762MRUulNKem873NaCiM7lHC7+jsgikQ9pDLoXM1MDUW+AF?=
 =?us-ascii?Q?f3WKhYDwM4tPkDwNKZq6OIejzGgLhV1fLL6Q7s2C5fhT6SigXYCZREMDwD/g?=
 =?us-ascii?Q?GXh8ihI5pNDaAo+n3FVbmpCrVEsuIYppKZXtEbyO68k4T0LstjhU+bkLzBPo?=
 =?us-ascii?Q?g1awRT2w9dqR91aKZkJgewChNAYhbIV6pQOCIfH1CMzaOxBatTU8tiEJjMWq?=
 =?us-ascii?Q?Mce+P3IbxTzXzTh3MY2hqnrBitDaCBJHzzd0JjrNrvm4E2Hg6oNqKGX9sT0O?=
 =?us-ascii?Q?eHLl5pJj9KCv41iOIy2mC9//6WhvW+C+tC8ublsBoWUZfl+IJVI6TZ/2Sx/b?=
 =?us-ascii?Q?QzRwyw18vBoy5t0LjWfu1UHOBQcxfDoEMx4JTsIiMDe6CMm648qeetrOC/i2?=
 =?us-ascii?Q?ee2Wc6WhVcyboN1VBM5a/KnEhn6r0DyXFZcLinYed7ia9/lDcoHZQZSpEEik?=
 =?us-ascii?Q?A9/HMRVTWbXyzaTEcAmx6s15FD6RHrr/v/az8OE09/WdFvLShT9zMrikPXGt?=
 =?us-ascii?Q?NDTos44tD+6QpIO+71C3peWOAkbtdYqdJ47zgFOEF5mZi1pEOeoKiYaNKCCu?=
 =?us-ascii?Q?G2ixYLFeMujEuWsb8A/pPIuVgz0g1QJpj9SPfkjyOP1vdfDXBwaoe3/uaYqI?=
 =?us-ascii?Q?svW1rq1zMTPdQKqE/Jayy7Sf3VxZjocuhf2ZcLmYfLyvBQjeYzS36NuSmN+M?=
 =?us-ascii?Q?7VAMN9kBqQpNaCex7cttHmCFC9EckBOb/wq0Gvw1VERczCGEFzcIPlSUiQdk?=
 =?us-ascii?Q?SUegUgml5dkInBAJSzct5RRy3+g5xRl963c7iVzlYb8WC+qhZFQCVTpwk0Kq?=
 =?us-ascii?Q?64r8v9Ia53rI3l79YxGLkwakm/K0N0B1SfY04hYl+RLkMCPEOFkoM+YERZ9d?=
 =?us-ascii?Q?6j+0kzypLMw6K3cjX4SvDDG60OLmwpKSqi9twWZfJJ7WITyAiRyF2gp7rejy?=
 =?us-ascii?Q?v7j2h3Ztj5tx0uoGDBoM/EZt8UCfhnGA2cw1LlOBOxEmKZ9XGPUku3+pWQ6q?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85663380-873e-417f-3c4d-08dbdd111c7c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:36:16.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQTozbUxZBo6mG7dIl7aXfHVMUeD0xILoNJAf++mL865QaacoG8uzmoC6f4S2p7U7bBVdWr0EPHLVg19tpCpWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

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
index 1dcf104d7a01..344362ec17fa 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1598,6 +1598,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 720d58ccab70..6602abcb00f4 100644
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
@@ -551,3 +553,26 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
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
index 953632ba7eb6..0014b6b542a4 100644
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

