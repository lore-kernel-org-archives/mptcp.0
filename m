Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F7F1FD6
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 05:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgwXYvQet6T0HD/YtDc+FX81FcbVbN1gB5m7QUyVwEbySTC3gH9yLWGjT40AMejMABWWySQqqu/2q9cORyxugAdJR98s4JkfIfzGeEoCsqh4xMUwYbEYi9+G4EmMz+f3sFuKKFBOkzZUvtP76Sa0PdqSaC7WqQdafLQ8BhvgAlfdXeY2oqhqQvOa9w1agmxpDAtRD7AjZtbsaGjMdxTEdZC7Bv2/UycmdXI6W7CKUJksvX/v7WP2FWAaQX9E5MEwhYT4/AqFh3mY0wM9IXe9C7MAocLKZmTaOYagUrNpAtvl/tdVqu7cSebtzoleYE6cFDmcs1c1yoGs8xHi22oALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcZWCY/fbXoVGBbZNNwge90JtegL8LSJiEtTdd+w/+0=;
 b=Z2Rn/L22dhlhuJc4ogDKtv5fBzbllyK8jh55Ifs0k3QpeoEhBP2BZ4BOPwxcvBUYrezhaaqg8kamScJdMl/tY4S4O03VAAbo8R55BCrCQP0kBsQkVpymZqf68pFW4jvoZWK1CpHg/W20rh7mzWTC3SvfzBeWiAhybXM7quMPSSGPLPBkPEcqWT3PC1dLU6pzly5yqndRXiR6fRHPJ8InfvTLAkVYK8uvh0KNaiX4JjtgdclkT+kFSGt3djCvuJ9b6UGqus/xFG2jfsDFORzzG05xUU4QHZkK6imPP5T1t44+Ti9Dgr1N+tEg+KCFJhJTIYKnt7RD0Ntd7b/Vdk2rSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcZWCY/fbXoVGBbZNNwge90JtegL8LSJiEtTdd+w/+0=;
 b=OtiW0/rP5VBD9AXRmbwVT0FloW91WtQLbCplijyS/W49B7lpgWndTypKy/FXGqFV88BEBeWK4vRpsD0DD88dL+aUp+esQNVwWU1WifuOr5Pr+mko3ie+1VHcR4dJFTJ4/W5G1XFT8MDFi/Wm1Qfe5zPAuX2gcp2tpsIqJwaJAuP/oZRWXVfO82PzyAt/7R+A8Hkv2Hk0oJS2RaDdUjWNrjppqKI1zuGzfPk4vv0IEXr8OBC3zRFU+urtWUdJg4wSKziMjruVWdONvMVC6JAlLUnv8SUAolbwTJVNxVnryySbGiJQgiO6OdVhI3b9Cn/L01fc2uY/PdGl+r1nfIe9nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 05:31:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 05:31:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 1/8] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Tue, 13 Jun 2023 13:31:08 +0800
Message-Id: <24890736639a3378d4999e5b58518180d00bdf27.1686634037.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686634037.git.geliang.tang@suse.com>
References: <cover.1686634037.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0146.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: e63ec57f-6abe-43ec-5635-08db6bcf78e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N6nRu/GB4Ag8HpX/7e4EjPLiIXzgNkcSzxL5IyFAva2RtmnJbfLVNNNoOTvpLgm1mHu/qWw2EzlfmEAnV+GMuCYeGDbRJxsPTKcxiHyYl/3cK5BYMwAMJRomjFtuc8BOY9HPz4fi3UZujP2Pge7UeJCOz7IM5MxJgG97GR+HRPF2YxeWnEuK3XMVCwNV0M1+sL5N+T1iPDjyyFu0vPDfXRrxtn313UrLthuECRtMLXsByftPXM31r1MIlIUewKIp7fiyeJZTGg4NaAPGegWRhCcAAyK6xsBlrCGXcLCe1p46Jh+NfH3+SEYEKSED9x9TIVad1Q4o/4tKvB+o5oy3Gd4hQobFi+YLbItV8EKG1T42jiGWa+K/r58R/77LHigO8PgdpDSIEkzAbv8qYdvnekcoXDqed6yU9fWyJaxKCVPck7sXhbGmPNAnnwMrLkiJIHMquQCcj0w6jnjznWG3pq1FUgzZM+vGuEIubNx7R/mt/pUUQonx5shWHEMshQWSXMhpiIBnsy3IDwZcIaIE1heoKkN0gJYHQ5mRW0zgOfBEVoKH1sEqEANYoWVemygU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(36756003)(2906002)(44832011)(86362001)(2616005)(6486002)(6666004)(186003)(83380400001)(107886003)(6512007)(26005)(5660300002)(6506007)(478600001)(66476007)(66556008)(6916009)(41300700001)(316002)(4326008)(66946007)(38100700002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?66iv5uURx2zvyVEUO3U0La2s7dMBXYjWgXx4SopQBqBauHfpWjEneUalcsKs?=
 =?us-ascii?Q?B+cKnwLCK5oOkECmTLDV17Wv5UbUyiWlGJqsVAtbbJ/dlkW1MhVLwLPRuJuU?=
 =?us-ascii?Q?D/Xk35sEGgn03MbXNsJAezXXRupNDmRC1OKcHEXZrj+Y80UYKZVDUzRFyDTR?=
 =?us-ascii?Q?2Rc4grrxeZgse170uxsvI6oDbHqTeTXNJY1MOE/yKjajRDKZIn20eaTYG4fc?=
 =?us-ascii?Q?ILK0rf0FR9smgXtVZIWyowKB6UdjJDDTFc7lhI/NbQpI+MEvO56CIb5IPr3H?=
 =?us-ascii?Q?abEoiVblMO5gNalqzh9k+244P+onPfWWanDiEOTDVznKuYRYgBmMUxOvRUvA?=
 =?us-ascii?Q?w9voS3tyHG4tkMPCUMq9zvCzghQo5yDDmrlsNEB7Bu38D42dk6jikiSKPdFB?=
 =?us-ascii?Q?8HDueRAqhw4mnI9VOftMFlrI4TPDYpMmK5P9lV29pu52GI267Lya1OCkENzJ?=
 =?us-ascii?Q?GA7fPvpxs7zXUwLkVCTh4Se50fyEIyKRr2uD/CWRg9g9PCCG1tvHs39HYOFY?=
 =?us-ascii?Q?h4K7GMbo2eNgVXptOs3CFB+QrbeFu4ksoKhFpYr1XPubBuxAt/U//io+Syoc?=
 =?us-ascii?Q?9vdzCU8ZU56YMnIu9iu7EU/WB9ehIfGa/s67MgkamwZJtuG4B3VBPJ43WAWJ?=
 =?us-ascii?Q?TqYhF1ulLm8sitjQ8+pjvKSYzraqOGt2HOqC69gB0nzMn4nXxfFRrqB1Nvxz?=
 =?us-ascii?Q?dlLebK239rpJhQztwABiJ3CdlA1kRRnYQ0K2H9W2urIXbQ7p5beuZ0b1s+ab?=
 =?us-ascii?Q?AFfwJJl5wnbOd0Oa1e3nmXhboVTg5CuvoOputg9SezEpNdtC9k3Fa0BqBkjT?=
 =?us-ascii?Q?jAMA1IN4mwAziufpEKHe2EkndxDxE5HR9U57jIKXllgD2HEV2ErEy93j1jSu?=
 =?us-ascii?Q?z3jqpp/lmY1SgiOWg2DY7WyKpd0tOziby0Dp9BVU8ipuVnVlhDXu8oNX+yTl?=
 =?us-ascii?Q?RWeYs1Cz91LFfz1zOSWtFOQuQk9cncuR19UApqSAnC5lJUy8knHrVl3jowJH?=
 =?us-ascii?Q?uz5NGLN84C58LGV7piyfIM4luk5KN6HFzBq5z4BkD0aMoCNuEl+Zy3ZFcQMU?=
 =?us-ascii?Q?Ea0VwcRR6WoNswkaNVpcze2SbEwMIBMt5kzIBAW4mIqsrOH4iz5s+QeNFVO7?=
 =?us-ascii?Q?XTzPsHEQ7oomO78gY1my98gsg8MtC2kWJM5kKlMz12r9l4fdYjVnSHIY+XVB?=
 =?us-ascii?Q?lr1Wb1IZhn/fubElQ70cchwRJrle9PoCl5Ag767auIYRCcvgDd9OZ/TmOMkv?=
 =?us-ascii?Q?AlR2vQwSk4iDbGkP0j0tVX/WZpNStJrlmGhCZfytmXwvyoij5rjGmKEEYkB9?=
 =?us-ascii?Q?7VgkIfUWHaYRXdylnp662INHmouDCbLM6l758FkMKK9fkOIccTw92XzTymiC?=
 =?us-ascii?Q?feirzyw2RHZpb3If2750ySPG6qAaDsM8t5apMkFAAJEAmbaY4wLdFHyFruiz?=
 =?us-ascii?Q?IFgYijnZqyw26xi5Na4khrcrzJJ1/F4AUgazHkzmrY47tz0AjAy2qbFK5ETj?=
 =?us-ascii?Q?2tXImZ3HUi65+XtCmLkybJj4SyyQ9yt4iNssrhD1e5YNLdJUngLuVtJ2vn6/?=
 =?us-ascii?Q?NgT3MMIcS7KyXndtPI2S1Bq9LGrwCjWhabQ32S+R?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63ec57f-6abe-43ec-5635-08db6bcf78e9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:31:43.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7ao88Bz5keja7lU//o0N0phpnpvBf0eZ4bP4x79ex0vWhctl+SefEiAiCb/vB8DSFKkG2QtuNCzcTsBij3H0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry. We
can reduce the scope, e.g. in mptcp_pm_alloc_anno_list(), we only access
"entry->addr", we can then restrict to the pointer to "addr" then.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ba1406e601e4..724b652876cf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -341,7 +341,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -349,7 +349,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -366,7 +366,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -573,7 +573,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 47a883a16c11..b5a8aa4c1ebd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -193,7 +193,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d2e59cf33f57..3ba62f1154d3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -833,7 +833,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.35.3

