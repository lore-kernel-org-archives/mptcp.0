Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2172612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NID6a1l2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZW4EAtFoITxL+a/FqRv4OcnKNA+/eqHMo2v1IgN1nirEuhv4IvaZo4S/Wfi5weRseZTF9EKyzWpsxna6Ag79L+9VoBKx2w0BOnX4Aka8AUwMJ6GDJpIOhTtZgie26WGDaAyBH6IztlgHGLlpau3I8JjknlaSpm1b3r+VuI3F3OrZjeNicc6sGAaWZ3S6rooxOcrPQPhYXUoUmeyzkq2AamesbzkraLdDl2V/YGlx3lfVBGOyxKLDcGZ0aNUxrtk8LocW+2C4s1IfNO2tQzjJH1WrzuCVcCUoHZflwDUc/LmTdm6zlalTFaBa+U8kyWlGSMt6/ryPqzezXkTpWiDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Txjq8/0fP0unonnfGgO9aF6JgFqppQuwu1fvcU3sfZw=;
 b=g24IVzByVGWdnQlaaZLoP0XLTPmaCGDHzSpup5f41qj7AZRf7mG+PJljn1q7Io60Mrsg1IOFwD7jkoE4/XPSVDvTX5MfzvX+rXwOnVJBCthpcm8MJfQXJr+RM4FVpmhHkBcSd76fHj/NJEBgutxMFTu/EBE3aaPJl4OKKyThYtm9Wa7vnEWO4Vh4ujEhnBb8HvW6vauFzatPZiSY05+ibKf06Z34sCc9FjY8n+Lkei+CSg6JbStyKn10xWfxuPVc3l0xdhaDEDCZMVqcXlrji3xxZ7Z/oxbltwt/Y7AUxVBcXCHyCJLS1dqim8FKKO5j2AHrSmBaVxkcskFCisUDNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txjq8/0fP0unonnfGgO9aF6JgFqppQuwu1fvcU3sfZw=;
 b=NID6a1l2GKKpJqjJpsC/iDHK5KRNTSFvmo1pEfMrsLv9RrMCp5JqV5QMOOh2bf9ehQu4J//CsHeRw6b1PX3N33RF7c9//9s7WLrc0sUu66dSsiNCcQDAQL8peEhl1c9bmoPGXni1i1wiTqvrX37fpWgvxK06JkNuIo6zOQXQ5hAS3uT48t74fbHIvivk9OgJIFgS/jcE1unu9i7QK5/xzTqfZ5kpgV8VDaH+2Ux7jD9qDPJPe8bHerkz561pnVN1OOyHtpDjfB5pYgJYcr/HvThriUK2hW+JgPdlFogqAUO1niKniE1AMOXk76zEQlYYFixbDVxL4hPD6a1EPymRzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:37:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:37:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 13/21] mptcp: flush userspace pm addrs list
Date: Tue, 14 Nov 2023 14:35:10 +0800
Message-Id: <4d6fd8ce1a8b1fbe179675a53dee85b9f84b2cb8.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d2b857-63a8-49e6-587f-08dbe4dc1ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iIEFP/t2QaPVRTAdrVsnZxC0HJkl3OJPl46HncuF+/6zVuQ2dh7sfGDwXGpxKUms29U+dBXrOJxPXvxaWt3+S0ZWoMJl1CDs7+UX39zr1TmezCtRauCCMTgjTPMOUcXyLSC3xspQO6xFowfPhj4gPiJO6Qkg+HlslLxW7XpGGq1mauivR/Z3/qrSjBYc/hB49/M+VExbiRAxvuH2p97LNVjxtN2E9jQVyBiiiL7g7J6hPL7grSaNZh3sxdLBmugMaTj93sLGbysWvpkbxBNxCna9EdSM/Ba/EtG/TFWY1jRde5lH3tEGjsrFPsD2kysN/OoH/WMUPwF1yWXiOVK1GL1p0YNXovgbk/kSV9X24o6urQIRIpEMtImnixTEZ3pc1IvpDCtn3xe/anJykvR3yUpY0uXd8Vm0AONl9qevMQGIhHGHlaoye8MFTD/+kT95YifHn4b9ulQbNm67P+zd0rMMb7vaQR+VjuW9b5GVyvpB3Zwkik7MV5bnMg3N1uiL/fMDYMQBE65dMjFdFmlbS62XhrA7GOZ4KbEdClfUwPPmn0Up2DBT1rI20kZezHOL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(83380400001)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C0mznF/NQfXFjzpfKUprQcLVOMU+lheBeTuXq5jX7uFtVNtawoWbZCp/M8mU?=
 =?us-ascii?Q?wkA4vulc/G4bGdJ/osqMNzQha63k93fQUpCi0jVWCYsiQRJ9J8R+g3Jif9Xm?=
 =?us-ascii?Q?aHehalPGvLO92RX1gk4d9WFVB3PhUHFCF6FldsWYmHU8E92sIABMjeCulh9m?=
 =?us-ascii?Q?HtmHcpoALvo5ptjSxN2a41Ni/rac+CUgTL4zEHmazKsEofIV6N1rERlRhgEi?=
 =?us-ascii?Q?pQCOrXZFECdVPkAEeWEluvuYUVuq34DRxd5JwT/fGrf91mT+ekk9+lz/E1Tq?=
 =?us-ascii?Q?0nftxh+4+IOmZPJlHUmC6xYriqbWVWg80owugpbC8K3p3JKhY2yFdzOwyZfw?=
 =?us-ascii?Q?qzg7L74S7BuPZ+APnx7aCrULnsZipoagJNzy8JuX7BgW3vI8NVzNyKobnEca?=
 =?us-ascii?Q?BfWEtflI36nSOStcTcK1PbUvV9xayzzpL0lb+BS1cw3ZTsr0tqogngItDEpd?=
 =?us-ascii?Q?E/TP1c6+YksV+egjcByiCmN00sHJpLOd1XAYJbIJCpE+4EVFdp2EAPbFncNv?=
 =?us-ascii?Q?l6XmFUp8SGSEl1hd/PMrrHyoJmKwRAOwbUqxor8Hou31u07D+EUvSsC4ta1r?=
 =?us-ascii?Q?OFSlQQ3BU9EZK+G8Zu1bPnLChDuue+yLW6GQAtVYu12sOxwxATqQlFRyEQdG?=
 =?us-ascii?Q?w0s9JxU1/v8X6MOBeo9gTwLUAgcgTFrFHH9tjL3c6claDTJ/uctZIxKYkHzP?=
 =?us-ascii?Q?UQ1XvI8peQm/fjJvcq8st7ggncFXGbwrocc5nV/ZurHS31OFQm5KLB0jOMn2?=
 =?us-ascii?Q?vFLxELnU9kPIo8mePuh7ydbNqKQw8oAfiMQGMfp0xS0sxbrPkaucqGpf+ejM?=
 =?us-ascii?Q?OdPlZ3tuo7c8Klg0YylzEP8kEDcXXlN74DgqsnntW3UD+WwT47tVAa2aJvMj?=
 =?us-ascii?Q?cIczzEYyttnbUNx3k5APYyL8TVTW86RlUEH8kiq+twPgkOYkMMGna6wNwtlW?=
 =?us-ascii?Q?LPxsFd6+pY7d8INwgK9+oUmzQdi6FwS4845UNw2y5+O2RnmtuGDMlr5sF6QB?=
 =?us-ascii?Q?ujuboDewo9+7oEpAMpUV+MB5HOpFgevcKqGRqHliEGvoAYr35mjqxrfUrLLl?=
 =?us-ascii?Q?rmce+LGSU0pKYT1oVU3DV6BZj1CLGnM8KBN6+0JbkBoObQJGjoPl4KM5RIID?=
 =?us-ascii?Q?e5VlUCPk4FUKXG88wYbF6mbwsoq5bsKKiu+Mco5XEa+7NlThDdwwU6YS8nZ+?=
 =?us-ascii?Q?cPqlyMh6VDNjDBPHhA7p1ME4MzHSZ+vK/hVj5dQ4gAJ7HNzTraQEUcapRVTl?=
 =?us-ascii?Q?6/YopFOv4Y/pwklQIMIm3jnJSBf+WjvPe/g9IWBShmtsU6OcezlFXPqt73bn?=
 =?us-ascii?Q?4aFCnxtdkTxdkU8cAKecFtnv2N8WnwNthmgCTSMYQ+bomHNajWVznraKYvzQ?=
 =?us-ascii?Q?03DxxVO9JlC4QgOoZ2CfsS1acck8be9UbAwFhDJZoqhbx6jLV7B5wjN+gzYk?=
 =?us-ascii?Q?50ejQYl0iHZUArjIfeavAKkZ7mPjZ5sftsHlcFxQLC/p6k3Q1vHpXYxL3swR?=
 =?us-ascii?Q?gkCrohUsUi3AIDtqgJuinq+TXBYaoQ6VLiyAMZwsA2My2m7HRn4u/Y+XplBY?=
 =?us-ascii?Q?THUcmZjkKlIYIIWoCOnr9YB3C5mE+qPvtSu5TMiarcTZJ4b8KGDzgmmMnEDV?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d2b857-63a8-49e6-587f-08dbe4dc1ce4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:37:03.3018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfeFv/+Pyd7uZ8wWEX6A3UAsnPVNWYuE57hlLb2M8iM4+UFhVBCgjI3KG6IcobfSP2j5aRJ+iWksAs5gODZJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

This patch adds a new function mptcp_userspace_pm_flush_addrs_list()
to free the userspace local addresses list. Invoke it when flushing
addresses from netlink commands.

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

