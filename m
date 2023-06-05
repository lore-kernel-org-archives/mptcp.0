Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2085.outbound.protection.outlook.com [40.107.15.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20A11C97
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 08:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY63vOxp+pi9aKdPSTSQXObdOc9PxyHORXOsyLwVLpu+NCubu2vkmwkTkKKsdXJLdOEwi9qA3YYiKj67n7nRXprW0ZGkjdzp3ILV/sRtErIUgG1zA7YYQRNcl0rweihIQewRrYtYCN0K00dRwgSZOgWjYmYHo6Fdkdu4ip2cNE/m0r8q5QygTmeH3GKCFD9NMIs4CQGz+pmi77FxJ1axj5O5Y9atoRhce1Tt5gBOrXgS/xLdFSDAaOmXKTbUk9yI7wot/vUNAC6ZrmL9PS6V/UKtEM8A/phabASOXrlsJoktFLgB4Ajm2icfls6mdfNl5c04QLptkKNkWKmCNTZrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcZWCY/fbXoVGBbZNNwge90JtegL8LSJiEtTdd+w/+0=;
 b=Q6uwIFOg1JBVXIKhJFaeM46coTTb5S2VJL3Nqykqo6gB/XGAmtGYxK+IO2svvexVvFYHsaqGTJsQlZTvx4VZpc4LnmzkA91qNKmEPMH4UsSceWz/J1K44qHFJ+H5OkQ1RCnPZxpxsCUMROfn7rGyEE5DVkvJGndTl4Rp29QCR9gd6SmPQ5D0fcxLw1n68tPPJrAhSiDU2wtlKh/P4/chu+jmbZEdeJOjFpTYh/rr0xzG1xyEfcErnNLaM2RtzEJFkthobnZIAR9rMzcNCUymWei1l1Kv3CNFnAELTguka+pqwPB15l7tMDhRT3mfKt8qAZ6M5ByrEJs+ETDou3eixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcZWCY/fbXoVGBbZNNwge90JtegL8LSJiEtTdd+w/+0=;
 b=Z/isDLm2nqGs4rnnsK7svGay//1CQDStMkXX0aqQGRekxmGYUax2eIbvOaT5PBYVVCvM4T3X+kPLPnZE7PClfX0TNImh2CE8sAPkgHjDvqdGrfpoeEI2iTbOIvq3sG8vMKednxDNHjvgksHRb+6MY2zuQ9cmwgJgOzyyquyN24RrPGtV5pzxDPxGtv4TYZOhB4bwRJPEfh2cGnTKZgssi7lQqcoFROJm2xVt+u1cVRZwKjBUAPcTE2leRMvxIOoTeq2MXukaK/DF7ewQZqjXrNRGRpyHrFY3UdxE3wzhAWZEs1VW1rSZ7EpVEJMygTPFdazTUsRGT5yBme5kdOf3pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 08:18:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:18:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 1/5] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Mon,  5 Jun 2023 16:18:04 +0800
Message-Id: <9c68244d529bbd12e58f7a8a5021377725e5c0fb.1685952776.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685952776.git.geliang.tang@suse.com>
References: <cover.1685952776.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: d216d299-54ed-490a-9aae-08db659d67b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yvqi8/c8FJQwId6g1nfXFpG8jlgwDfi5AB3a2R7JTL/pQPrXD3Oo/xuaLpd+RN9+gWSyi1dAS8ZMs05HgNlagdZ4Tj18wPO1I+qLV4hzQTuaOIhyE+zFh5P5X8xpfL36S+QFLXGdbbYaKVUR9XlDc0a3wEj1y9+jf5KZHVcQ+xF/1QqSVE4/b9fBKQLoE8F2VACr+Z7AX/UhY6wNQtWQ8d7fqF8VhDc37QcD93lghnIgjtX9l7FyBU9IltN4J6Jco5xnRtyMsDhEiqYFAdWbtFxlaQMP4KlrrHboIvZznsINO/xVorpya43Sv4uRpGypM+VpV3R/Reic9a/YaqjcOjMjJjmV0iW+NhQ5xZTeEN6bYgzjUadu7SLZ86kAPiHSSFvhJDNze+BdjJKs2cOd1qufmN8rOq5GeVne0WHAWUjF/rYYsv+brTfIMHR9op1CTAc0dX5xmdwNLlceV0e8U0jp2QK4zGjF7AkrYY4AVoMIdUoWjjsrnqiRNYp8N5OUczpj5x0z2t2/qcnopsBUBtcJgVXOwyQZGgOsPt/Gm+ZnoaCiPn2xPj5z6ugODL0y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(478600001)(6916009)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(6666004)(6486002)(107886003)(6512007)(26005)(6506007)(86362001)(44832011)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cmcae0WiRAJr4f/FqHkx7PgwmEIT2PaYhBIjGssojuETt2TeMqAtXzUWSan+?=
 =?us-ascii?Q?L9AgbhAovIR2g43zOnqmLwDJ7/hHwprb8JkQCFm7guf0JfEHGriuhVtzVyxC?=
 =?us-ascii?Q?yTObTVj6v56E9sNOPSWacCuUcAxqZdhgFo/dffJhwTOwkQg6bty8+X2PfIRf?=
 =?us-ascii?Q?a4o7PBIsbkqZP+/0vzc+WY9mkgFbiqWf1Go1eos93pcGq9Ophk64JpNOBZhR?=
 =?us-ascii?Q?zy4yUvRmV/ghhqYabvm7YOlkC5Bhf6pcuEMRZYtrBDpV4iPD0olhBb01Uz3S?=
 =?us-ascii?Q?YD+6aYg4qm6k9z/wiUBH6Y12up27y9tnOoRlZBgv57khoRwq3ceOoqMYj2g2?=
 =?us-ascii?Q?8pLreF9Fu/HW5rCci+fTdM7rIsz+ISd0+WilJVulPD3JLj8+YLgrWwizaRBy?=
 =?us-ascii?Q?AjBQYSQx1535J3N5PbXlq5h4RUlzbGJq/urjBEhhzVLcXX8rHQDo/8UEQ4ED?=
 =?us-ascii?Q?0+7G+nQdWpQMK+8lfqG1TAOud88nYbuVUvyxWCT0sxA6F7rlYKXgSGKRaHfK?=
 =?us-ascii?Q?RCBbf6P/4tm/0kGQoVTgTHscZMSek1kEUgliIN7ySolDt+F0eeopuvd2hRG5?=
 =?us-ascii?Q?hrCmPmMAScJBj8Wu3wV8xg208XQ1hiBRpGBPOfFL+kDGePUTCqCQVZy3v6nn?=
 =?us-ascii?Q?9rrJfrAFsZ7I8G91KgDcFdYB2OSZZKKGoq3XIAGMAFvntcRz/fcgzgsDeFEn?=
 =?us-ascii?Q?zHPQgzVeTl10kEmn25vXGOgTl33mVlz2SsXh6iNu17ggytVOXAJe1FBtC+UD?=
 =?us-ascii?Q?oEz6G6HIQBSnFGjVo5BEeWcKzMUN30063zQD4DicWeZOIUbFNQMgTfz9EO/S?=
 =?us-ascii?Q?GpOBuhIvaUG71Lt2606EvdnEELyv2z3qcd64hxrVeXhNYCj/U3JiI80iWh55?=
 =?us-ascii?Q?6WtJgC/197gFY5BUYgasrs/x/S409BSGK+/FFGLEtDXUTle0fWEbo9Brwa6W?=
 =?us-ascii?Q?y44W1b9caEfiZ83XS4xnZJuFJpWWJvzH4wrjGVVaUujTRWt+nd5IVVfM27EV?=
 =?us-ascii?Q?nirV4zA6p6w7atdyrtuTdS1awT5KZuVihR8c1hnzOPxQJDzTuIHv6yFsc54Z?=
 =?us-ascii?Q?/XvwXDFnmJz6WXvUncCfmKu+J8bVSyNbKxSsTYcwURdlCaszha/1paBUazNZ?=
 =?us-ascii?Q?PAdNAyRIa5w1aouRU35N97Rf1VZxk+OTL92RcvOyiKEbK7rmwJjOUdPAZD4U?=
 =?us-ascii?Q?m+WjPfwO/9epvFSYeh5GccS8/uOEm7lMEc9AcWRjDz6qutczK81CE//WPHfn?=
 =?us-ascii?Q?w2NTN9BK9uOWz8tZvXyJR/a+QcZly6YwsRURl1iMN/xc288sY1f9/3cUr0Qu?=
 =?us-ascii?Q?+SHdDnBIiL3yZk0gbDiDjWz+WxXJvBToBvuuTny4x1qmDv+jVRhWU/qPRPn+?=
 =?us-ascii?Q?1NU7+EKHbjfS3FcN3BmrHDtx2Jq0ICZ1B9qgE8ADmeruXRsKPLHlCaRBxytG?=
 =?us-ascii?Q?iep5bQ5q/MFbPQQFBasUwMTwF/rgQo9HZnGykbdMGyx3HIUbpbUaZiGWaCpM?=
 =?us-ascii?Q?Dg6og7tQyONAo5+hs9ySsPUmgrqdF3kCr9wW6W1TfSTFV6In/iMu53ygFU2O?=
 =?us-ascii?Q?/WNRmAp7MLjyRj76sUX6mDbIH/vvK4opQzaViSgM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d216d299-54ed-490a-9aae-08db659d67b0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 08:18:12.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvVg8lKVPJAoZKXO2I0aw4c2zGq5a0poftj3ThtyiGADJZZlKI+ls9hiG6OwQsDNpxyNxFYV7eKGw2hDqReBsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8799

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

