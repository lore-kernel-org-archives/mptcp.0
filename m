Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2915D0
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 05:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKE88R7wwHPpXiFqrhT994n3sECaCewj+maQ1UZoITNdIVrHyOZ6c5OdU2mWHro40qtPUEIh2NNL+SBCeteEFCI+/vhRjPx4O4EBFZM7b62M5v4b0pjNSq0eIz7rlhPtXYN+8kBUWdD1tn30jYzSN2p7OT7SnCB5b8nZUFJ1MaMMPWnnHvfSgTWh58FFb/kmC17YOFBEFSJdZaD1ggXWuIVKIB1SGD3YR14ztMWSsf1amV1LxyZO9Cr3aMK6BKpIh68pW71s6mYAd7pknqvu5ynVrxsWgs6CDCNKrfJ1onJpAoCmtLyUUJhh2gTzdKizLBfYtgjB9OiLIfPWD1EjIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCV0AEWEtidxTEvBQUI1wBNDYg/Myr+Hzq8yss6HBH4=;
 b=nUU0eQPPpsBKa3ROdqiOsraMgwxZpslI+YvGA+ErGW0W4zOWi7+GN10rQoT+hE3uKAmgRD5Ml6h9luRbqFjyEazVi7lNDJ2sZ2V1FRYSAFPJrGSdBcc5LCu3dKE6eObrjf/W7ksYNjA37+fxh/GEOrpyIZg4hMAcduO9LHZi+qF+A3eAbYY8IIi3OA36oGMU6ERtbq21gq6jIfWaa244Sgwqmnr6TP4EstFPD4mD/bP52iVxulqM/Z9bxfjVkjQoojqi4hEXrVR491kjXkaEves2i6nfKloV5I4dXaf1LMtCNjSj0BhVpicTDZvZigwYiTbFhL8k+QEIHeNZ+7DqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCV0AEWEtidxTEvBQUI1wBNDYg/Myr+Hzq8yss6HBH4=;
 b=joyOObhiL32U5VPEKiyC9vmz7zY7og8znM2a4uxA2FVOYywNNaZ6M0gbHmaGlmPAoQMvQjeJXx8TiQ2yTt5f0AfDE1gr4jnmWBmOn6rNwpSQEW5uKAgKP+h7JAic1thGNO7Co3uotrSRT4NXyVjm2hE8yT7GkpKXJFNcaW4wxeuIgc7/AFjV+dLUBc1mh1mFIXc2etPv7w96SunkyUHsZPMFyaM5yU8N2JZJ3HPncmgi1wp/EsF9CaDBX1cfd5LBxru4VNl3cCBQcOKftocVTwEs0uZtautxwsY+LsYanx6BPcAAv0Q5UYTIZfZ1nBWjDh6HBRoCWP8vdTBH3IsA0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 05:09:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Sat, 6 May 2023
 05:09:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 03/12] mptcp: export remove_anno_list_by_saddr
Date: Sat,  6 May 2023 13:08:51 +0800
Message-Id: <d2d224042e8c131c49e8b476bd2b4539a60c6989.1683349666.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683349666.git.geliang.tang@suse.com>
References: <cover.1683349666.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: eef0d19e-276f-4482-d5bc-08db4df00a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3ie4qr/3oqqs+jwFRrqHPkQzB1Rw5veYi7Xd0KD7mkOdlisX04v48rJHkr0Un9y4KHIs/rwYzd/pHpPgZz9iX586K1Wr02AEiRskaWr8ezIDs76s9SZxxMPXE408oPyKWB6CvO5WSLMk0BC25zMz1NFMs13mvBG4WPggI/8SK01rPLTiTpfe/vBPhB4YdYzZVGyi0iwmFBmxaK7o/lsOVVpDX9Jk0VPv/kgtGzsHDsueEd7ys9AP6EgSi0/4pMA5Ww7paWK0IuRjUrIH7XN7aFXtY+2ibNCQYnJ9Yg1mKTuZ1AYwPHoyt5L/LDmw9yYIzqrMocrdpi0AZwntJBACqwPiIn2RFK/KPsKIPUAKRfMKQwY3rnGcV0tSbEkiPfXr+njjAyafqWm4+uJZjxdt25kkCMI1oyNf+/1v7I2fsqFYn3o4W8ijEglGVpDB2IGuH9gd0P6bSWwS4w5vQnRYMiFVQfQTspa5VYSgJdWOqJnyIVhFEuCWlPWaEdA1IEvmBNe+gzqGEouguZWI/R9tRpHKA9meToKHxi39mJb+rp/HwG11zstaVs9+uqLfygV7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(41300700001)(44832011)(66556008)(66946007)(66476007)(6916009)(2906002)(4326008)(8676002)(316002)(8936002)(478600001)(6486002)(6666004)(83380400001)(107886003)(6512007)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?prc9Nmg98ei6domvGvGz8ZHOxnlOcHK9dwqeCZQgad9qRHHzxs3Rf4l6so4k?=
 =?us-ascii?Q?Wnya80911acAwcrzByk9ukZOb6PXl6f0SYTGWMdf2CdDwnUFw7fwllBYFptm?=
 =?us-ascii?Q?JNE9dSQaSOgfBg/6uizDFYMOlq6164lK/MpWFystnDGXNgX3FgOTab0qx1Uh?=
 =?us-ascii?Q?aZjw7pIobIanoT+KmNiJGj3h9G+rUjXfTHvJl14EuIf/NWf1NWM35AXDugZ/?=
 =?us-ascii?Q?OJvbIIJh2KXNnBP97BR9GLokz4v1nWWCIcmONm8xWwycuzwecpNg7sVKiUW+?=
 =?us-ascii?Q?YUI+qAVFLETNXr3mWWNv4Iw+ZipJuGnQty+UY+w2gXFBP+YIpCqG1xNjAAxG?=
 =?us-ascii?Q?vXnTEzkvzFm0FY/wRYPwucNlpfTWhohLS6DY5tBNrgk39Z74I9wDOsgQPOV+?=
 =?us-ascii?Q?GVG1/P3V/Jhab0kOPDmBxetrf4Y3tAhB6XmwOJJ7FBRJ06rR2eTvlRM0nA+e?=
 =?us-ascii?Q?E8RPz+qzzt+VofOE3hfjh1sYgVojeQPiKd7/VCweFaccq7Z+uwrbV4OugrA/?=
 =?us-ascii?Q?c4PZYJv5USYEBlfbDwf1cJ8ceMtVeJ0I/AcEbemCmcvyJ/FZ9MlI5FnVXQjH?=
 =?us-ascii?Q?ympaMAcbpAGYxNS3yYN9zx1c0Wo/lsl9PWejR2z8e5XF/iasTzieIo3CLQiF?=
 =?us-ascii?Q?mkDIyMkxuJC1X4aTZKKY9GYt4Xj8JLrhrxUzO4U2+ws6LRjuDt1uulkJC/4W?=
 =?us-ascii?Q?/PyBk8CUNwSlOtvmEvrFMoppIW1uF10gyhlvq9dNpCS3YsVKI49Xf1o+44+d?=
 =?us-ascii?Q?o1vWvO65Y7AaoSzOD35yJCmtIoiErYdujeYmCO04GMM33Dhe0za6fle2g8j5?=
 =?us-ascii?Q?ioD98VqefgaZiHN7+qxblgfQw4STmfFLOnWRcAHx9A2ldENWbwbg/OTYr7+r?=
 =?us-ascii?Q?IdY/9ZJnx0mANhQC6HieGVMdNJ3LTQ6uszGPnwQJ99NJKlbfKrPFgfu60BMg?=
 =?us-ascii?Q?z/3biL5M9AAJBtN0NA1U2LNjBAjDM2sYOJdzfKN+UWyAmuO6sI7YY5OHNj8p?=
 =?us-ascii?Q?h5Y9ZYBLZnKGMatWZEIY/3LKXQRj5Pdl/qtzTleh1sIuoNfli0CIm7XZZXoA?=
 =?us-ascii?Q?WEaGWnHqqewr9uWnH3uEbTZlpuIYz51i3uzOYMJf/s0wTa9fr8RRlfULQxp1?=
 =?us-ascii?Q?4HVd9CAzh5eyFMs4Jo4m9/mnwiaBov+UsBKI5Nr/KzVasp3AiQUjJOOYQFhM?=
 =?us-ascii?Q?Xd8SP3c0h1FxyEzGjSJZkXkm/pzLais4wc3O9eUFTRlti3i/wu5E0jNxEg2F?=
 =?us-ascii?Q?VYsrnVqs5Z8MgCsbhazhk0HkK6pE01SMzXxj54jBVBGlK6wLRp00vpjChuej?=
 =?us-ascii?Q?hCO75XEtUOVkhNN7a/roUxmFIenRu08QiVEAl4vsWHGmdIgYees2XtRcWuE1?=
 =?us-ascii?Q?y8IZw4oqQ3dFS/6b8rzcqo6GtHqRNX6uMWfUwLwXTTRFFtoa2a6n8ues+kPD?=
 =?us-ascii?Q?fL3LqdukuZWVQ0imxoDJBDOH813m7cldHjJrHnQpEHU+Yf+FdIMrNHyR5v7E?=
 =?us-ascii?Q?+nmcVyoPPPIayCvE9R750gvbGmdptW/Bsdsn3kpqlGzUvsxCf9A3cpagW7pb?=
 =?us-ascii?Q?VK6tHoNOTfenFRqqu8BVBO9uFN9172w+rSMt1czb?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef0d19e-276f-4482-d5bc-08db4df00a80
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 05:09:16.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NEAnvypYqwA9ebRdFKoAmGkk7NlWHYQ4KDrId8++v1BWZmIEZVS4FlSj1avLDgJXXBqLRsYLD8qaF2UqT/elg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

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

