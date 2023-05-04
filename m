Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF86A2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cfy0KrKzQIXVZXhLcSbbSK2XmgM8lzrsi/Gv7DBGO6QGoMMT3x025gic7JMemxA18I6wNcEFIe5zl9hjE1/YAImdlPzPxX7U+nTNYU72FXLYiXBQbldMjrZKCxZY7PDUYoCpKcqC6IbxDpNKEVhIFYQ6Kr3YCIU2wdGB1dZt/Bu2pgLMeu/st7c7NaYmYHcjiqkpfh1mnxJbQGg8T0EA+QNoQSm+tZKDY0G5PufzcxSVRczBEjTjdFgHcvxo77vxcijUwvUtzMYW8R/OmeWuLMhi9Nar+T19/wKG5nlm1IwsWZexajuJp3KWxmv0qnJ1eVdYyZ7iT2cIzZz9k8NBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCV0AEWEtidxTEvBQUI1wBNDYg/Myr+Hzq8yss6HBH4=;
 b=K/SspLjXMaBihUjFJuYECHY9shwVdmbkBQHChZGusD2Ai1F4up0d+9EJS7p7CDERHwBOeaV0F9XaN/cHPVI3AZaCTOwWFx5pGRG7bng37l1vg4tMz+RSjJPNuf4ij4TRrEvzqZ9pyXpenCZ4ReEJ9Brqrl+He6NJXAS4rAf4Vix2pcw931V0ySqrvmvtQb3AV0Xyp1zidqyO+GksrYKZNSwyE6w1SDWrS/bQgmCWCvyTGH6KcVL8VO76LkNN3kvsOp3J1+0wfofPSshgtCG3wzd2rXtAwnYy/riZq2eQDO0XF0RIKOwWE3hUEZSl29PUus64D59pEIeZj2Z15zlUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCV0AEWEtidxTEvBQUI1wBNDYg/Myr+Hzq8yss6HBH4=;
 b=ZZFzwAGmW4ujMj9UG9ZmVBpPStfLRjyfFGCYXqzJf0ns6r2WnDDgEzKLtBC32+2PFWtRPj4Ik0XrM3BtCJgxKFahlSAqubHUG0BZZ/pBps9LmatYICOBVWJd/0S1GD91SGrAYasJZwqk5arS3hK5ZyiNftzw83fDOc/R5MJEw5ge0m3UfuJ2GMFxqKWCH+BSlhNoN4DhIHM2ZogD2O8MXyA68dAKoGERSGC/xppwKzwVZK52W7EyaE6HXLztk8RdW0xRStg4wKuL4vrfQX2PuFaDjcF+vnKQ+ceo7w+N81OG3ZHOt729DwFs1I8VdBSG7S6lD8fG6Kdp6aMAOrTY4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8908.eurprd04.prod.outlook.com (2603:10a6:20b:40b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:20:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:20:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 03/12] mptcp: export remove_anno_list_by_saddr
Date: Thu,  4 May 2023 18:20:08 +0800
Message-Id: <4689f74984878f9713147a72dbd6f61f6b3bbfde.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
References: <cover.1683195386.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a244d5-efcd-483d-91bd-08db4c8935b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FZrPF0LR6Eylu0By5KqbHaoUiJvq2St7SSbx+mHnsXQ4LBagNpnausETetXYKbdyhEKdsKHW9Qn4ruaWY5qqqd073raTS7MCOcADfq3FOXRpEtalxHTPjQwGFXDPqLonMkkKVJf3tB2MSumPyzc8ns2cRqloKd4upPsgemu5PVWollAeqO3ntWXesvlnPIyuPBmzm7sam4h4Z0v5PBqtB7RoYOv2fZyJytgWBgAz2iQM/qQekfCZIAg/OyjEsRS+eknBKYkyt8l04f112JjHPptG1XO+r+GdXpzh97J4BHIdOLOmlEzo72G+hFoW/EtHA1OFny25K0vDZ8gLPfYHdNAHxjCAh5yu/gS1UCgd/8MgDKofYwYpNb5EaDxEiVtgSXZ+efl7KkuWfEmAREANKk22+cyHdDyDrZueyigjmCIyyNIzfCozf0dSHfzSvyc23XtNyYHMusX06yK+xJINXkDuP7+LwchQHq3/SCHfQndY2a2iorbbSZfFTrit7WYawWfLuZnZxuIPAzKKC6GQ0mOZWPE4nmxQmy1DeRjuHJjCyid8kfRp8dS0GqWcfVHn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(44832011)(5660300002)(8676002)(478600001)(38100700002)(8936002)(2616005)(6916009)(86362001)(6512007)(6506007)(26005)(6666004)(66476007)(66556008)(66946007)(107886003)(83380400001)(6486002)(4326008)(36756003)(316002)(186003)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u3HIMbl0LyUnlWxHBZG5yuJf3UWv/c7IETKNZGiv+4976wzUCME7L1o9MRG6?=
 =?us-ascii?Q?4rrIsiS59dFlcQZq0/B+DZxvA+1a3hmPomJysZ/ihOeYWlQBcyDS+LyCRil5?=
 =?us-ascii?Q?bkYLQXd59+efQtC8TLjO/vRf6ePknkpgXtayRO6cGjtrJht/AQoncQZ8EAFB?=
 =?us-ascii?Q?p67KUoWPRDg35IDNd/65msyAJ5mbE3CYT/Iu3e/3exw3Z0b9FoeIrFya+6gD?=
 =?us-ascii?Q?fcg4cpS8dESypo5fiCJdxH3ZiwN/1KWP6Lswkws/BcQJikWamxzFZjl8KCsU?=
 =?us-ascii?Q?5DIAGYZX+qDI0M51q8LvDAFfMDmWtVGXgBdOVA7IkA4jd3GsrjU2MM5Osu3B?=
 =?us-ascii?Q?BQRVm7KQs2Du2/ydgAPMMN6BFeKVLtKAi0OT6kztRYlufwewwJXXmZXOIVwf?=
 =?us-ascii?Q?yExRrvVZf2n9ZmUdDEEyIo5MDb8jb9o2NxmjGZKBwFz8drx9cQVVF60hSRpi?=
 =?us-ascii?Q?9A+WYZNHz+EYDqn3MpawBpddv5BhwOiAaSuWaVfwDb4wHChowOCHddTGF/cg?=
 =?us-ascii?Q?kGPrLePUwEMs2V06SLBBjpkAKEyv3melyz/i9sHzN8DuSMOINAuKSfUcre5J?=
 =?us-ascii?Q?plA3lR3iqqVUK14x/bH0Kla4/MHtYbVVfhf5VKlxaLf5TjYRSQ/fs4BX73EP?=
 =?us-ascii?Q?8Lo8tF4Tz0T3P+IoSOAUzd4JVPrJ9UELiVXQuRPHuSKxglNzNmCNsob4+Gpx?=
 =?us-ascii?Q?zUJJ1rFCWJs1wyc/ROfYeQuunmNZCQKvF3ebp5ony7BvQYHLPnFWyR2HSYqB?=
 =?us-ascii?Q?aM7VnH5e3w2R/Z6z79R5LWl2WJ7gfXNfsZEjh8lmulElhUb4SEnrZWFaRfy9?=
 =?us-ascii?Q?nxzGTXfsEOv4ofAhxOk4iUZnE9bghQ4JDK8T76vx3RXePeNoS7IqED5gjmYR?=
 =?us-ascii?Q?Ru4JkKIctW0Eb2VVxzaMj/fDhI4i5RLcl2SHc+n5IABP+pjxkfZdmsjkwoIG?=
 =?us-ascii?Q?FGRTA+zW2EGgdGF1l0CTPnPtYWYRwP1zERLE2jI7lYA6BW63ko7SIpO7dPLp?=
 =?us-ascii?Q?buQJueJAVBsouIP+0GfN76SfqbVRAHHdpJh/Xrx7inWSQ0whPBgxKhfznU9M?=
 =?us-ascii?Q?bCSVti6A+WTh8FD/euYamb6nF33rTFsIB1r0btR4UcV3m7KpOIM6ob9qImm6?=
 =?us-ascii?Q?5xfut+HwJJ7Sw+oLWnB/3Y8RMINnspyvJ5THXeYIIQ+D1epEsz8GHOEKFHMW?=
 =?us-ascii?Q?Zrx7b/7WjqZhi5YTPoE7G2BpMDzSw9p9Kd35M9P54o8yQeagmEjI0H2sxr7G?=
 =?us-ascii?Q?nR8IuGy5/t9eTryYtz+0mLOX3yCq64Z2a1ucyd6jV+J9teSh0lLh6i7AxZCT?=
 =?us-ascii?Q?dYQhKt4l92C/GDo2UJWVyt5UOZ1T3foSW0hBkaFLRTW4hu/zZUhgtgYYiiZR?=
 =?us-ascii?Q?nFd4sQIznYoLiZVPu6HENR8d+YF2eUnPewBGLBQ41eBYcNe4V3JzgCDSSbGd?=
 =?us-ascii?Q?ntjJm2paz1l65DTr4J4XMfuKL9+bboHCrii/CK9q1cUpOzQB9e2+8u4nikZH?=
 =?us-ascii?Q?6j0FZ1DIdA/gwDzSOOAbQ3DlmQBOPDaSF68tbZ+H0wff3w3Gd4qyVVrLGLxS?=
 =?us-ascii?Q?/C4x/8PvWCNPJNy1Cp9F/0yyszTHZOGTpQSdndhL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a244d5-efcd-483d-91bd-08db4c8935b7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:20:40.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3FDliqzq+rQSLgeCX/H0/buekmYnT8lYIpx2ZhYIfyegyVrVFe5Tjj0ApWDnuRzCI3tXLXTWrTOhbImcHkGcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8908

Rename remove_anno_list_by_saddr() with "mptcp_pm_" prefix and export it
in protocol.h.

This function will be re-used in the userspace PM code in the following
commit.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 10 +++++-----
 net/mptcp/protocol.h   |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 784145e6a314..0b34b57fc8bc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1399,8 +1399,8 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return 0;
 }
 
-static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				      const struct mptcp_addr_info *addr)
+bool mptcp_pm_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+					const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -1423,7 +1423,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = addr->id;
 
-	ret = remove_anno_list_by_saddr(msk, addr);
+	ret = mptcp_pm_remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
@@ -1561,7 +1561,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		if (mptcp_pm_remove_anno_list_by_saddr(msk, &entry->addr) &&
 		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
@@ -1584,7 +1584,7 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		    slist.nr < MPTCP_RM_IDS_MAX)
 			slist.ids[slist.nr++] = entry->addr.id;
 
-		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		if (mptcp_pm_remove_anno_list_by_saddr(msk, &entry->addr) &&
 		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1a2772902e9d..bfa7d93a1c1a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -831,6 +831,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
+bool mptcp_pm_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+					const struct mptcp_addr_info *addr);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
-- 
2.35.3

