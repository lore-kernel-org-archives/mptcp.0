Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427DC8C0
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="tmpsQ/qm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDD1d6S/GaPcw81yNHNZ0pgfihWGoQ2iikfDa9FVobLtmbKzi1AJXz+Tv6VLaAab/mGbqkQMf51RGfxL+4OmRBbQUJ7Qbsi+HhXjRsUomVo9FJPVxNxnhbiqZFvtO4mOLi2TFhyAX3pj/p6TdK1B4BRYoQZJyUSgn+S3ijMUN8Uwba+X6Y1/k2dNQwnEAH90l9lekKl/MvxwfV5GmuUMGX1jZSJ7PiKbucVh1aAKq6ckEHmFZrD41f4vrwSjuYG7Xgd/MhS2YGTF7Tpj2cjKFANygHJpJyx6DPZEoqNk7qJy5bYZ4f/MhqC8cLmq4NT1mLe0G13l3y1648HfIsFC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1C+mGleUJvXIa3Wci6uvGa1nefJUd2Vo8WcldczX+lA=;
 b=jDfFlyLNg3PGM3ZXvt20gMQCXQJfRqzs/OjV2abI/j3f4WaPAT6GEH1ffm/2Us7jQN/vLsKaPnJK/Zz+Dvg5POtL0lsAF3zo/xiemn9rENn1B6wSrilUgbzrh1Xav2+LC1Ye37oJ2jfAreMQtxRFF4UAUv88csLahaknNhS7eGtG7y30pKk9SM/nOrfnPA9H2EH0VPctrDPDmpYj5UIiTTJU87FjxpexU/W/pnPUM9KpNhrBbo3T/J5RqsGNwqQ29Kl66EaToROvzl1pwU1xtdTdC9MBoRn2TZJDnvSMSjXvzINamn1zFr96ErOygGjNGyN2coi+TQTg+S/9l8Q/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C+mGleUJvXIa3Wci6uvGa1nefJUd2Vo8WcldczX+lA=;
 b=tmpsQ/qmlRD6d/KkNBjaeZrBPbqJGZgb6SHs0pcOjZe5pfZo4KA0rD4hSAnCLJDgc8IzBVzDbFKxATjl2ceV82gKhtm0kX6gVTKK6Ij4WqvHGBBS00o2ynDlydTnhrni7CD2UNyNvG7l6oDmFYaUW5I2R97Mj40OzLQhCwTTnXghrJOXOaxHVz+NuTAMTuz6b25kbaXTn6i2rQKQJgJvAdG7/twL+df1ODgDH6v+0kQaOeGF/PhZIWbZOkoa7DAFkvGDPkMyviK0J0BYHKa1q/eHyRphxDXyxqHSDTmNLIm66i1nCONI5pDilq+LYUbIDeQvkJY6EWkDT6FsVcHQ2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 09:56:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:56:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 23/28] mptcp: add check_id for lookup_anno_list_by_saddr
Date: Tue, 21 Nov 2023 17:52:46 +0800
Message-Id: <b0dbf5abb3b3dfe96144958123e9005dd50f16d3.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c32883d-5644-45d5-d1fc-08dbea7811f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CT3HebCLEcNMupO2jKr9d7a7meBV0ibEkDLBp/fygIa171xR6B9Ix5K3BrWCebKk1h3DVLsnqnEk57/XuUabDs7KacOYeCwK8r9tjE1x8ee6WbS7+tiumfLrjMAMNdI30iNXCEhGqyzAzQ2MQSjlAFPZL96Yvh0vD5VdQrG43GW+OY2WfRwKvINpVCKEOel4dHR5Ek4FIeG9QzNiOsm00s+gfDMEVrfd/xta/gxCSbomqVQJcBXX9l+90iMgxOzGp70oG+qwCuvEDAdsryedf/XJqvb9FUxJC6teXLu89QowYNw5EKm9BNVMI4Y/hDPrbxvQAfubF23wV2Q+Gkof057nWsXgQftNFNbvauskUZFlLAT60mUTe9lh/cFVbdgLgoS6B+PxkLTpXsLS6mm5mdIk2N3gWh6aK2xA30Ymwgshn+pKvIImvOOEvmvufFgKa3hqXmotTlF0ElB+NrFc4gxaFqbcYONbAWvJ7uAbFmKK3Aw0h8roFIQWr3VvTtoZ/SRmtfujaUOtjxV4EiGl7nm17aroPXoNASzibsrn1Wudf2EGuY4rKTIAd+fv7YdL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6666004)(478600001)(2616005)(6506007)(6486002)(26005)(6916009)(316002)(66946007)(66476007)(66556008)(107886003)(6512007)(38100700002)(8936002)(4326008)(8676002)(44832011)(5660300002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HELW1jbaopuM7xxHnyc3uoxComw+lSJMbG6m0r2OUfLsScJ1aH+hQBdlaYJa?=
 =?us-ascii?Q?gB+Yos+AS00bLlMUFFDOczFEd9snujJSsBwZ52C92zMtP8IMIkeNag2nOWUM?=
 =?us-ascii?Q?dJSwCmB87fjt87iUJSUuy7/EidbTaM3YjpBJuPuHptjk0NtLxTYEVuaJJU/M?=
 =?us-ascii?Q?KWXkEcqWsCTUjYe1FRQBr010UpycemNeUYKV2GDt+N/sdOd9MyHHD53D5Ei6?=
 =?us-ascii?Q?pLyzKLh8lMJeEQ+QQAoGq1beT24qAHpCnCWGxychOzzodq6LmtDQ7ILJ6xwQ?=
 =?us-ascii?Q?QTKEkwxN/tpJGFTVIbUK0xeUCo1ivcXtFOICxtKbu/Jp7Y5zKBY23VmnsxlN?=
 =?us-ascii?Q?yEvO5Ec9IN6NBGelJv9YSWF+b0SVedU7d0I2d38uC+SIhq+3a99Ff+5wxNPh?=
 =?us-ascii?Q?27YgMu1Rn5UCG6VPOnZcti97fllZNfAxrh6yI1ll7vuSQ7HAqVgjLoBUtXQL?=
 =?us-ascii?Q?/rkX05N+wvBphMqxCY+NVqUL2htti0YtQS3dx+/YcNl+XhDEgskleY/y//nG?=
 =?us-ascii?Q?AarAtSQF8ZCWV64P3/w7CiY7pSKs5dqagNyLEScDJwHlV0kbOQ1ZmG7LbMae?=
 =?us-ascii?Q?sLIC6RoyCI/I482TPEL9rNRrbpfRu2yPiUClGh0jqCkt/OLdWhpxpplPZ2VK?=
 =?us-ascii?Q?HzuT2HepiwdvcXROgQs5aO3dq93hwvJBlv9vXGvKkWJWzAOgwgjzbt6pHE+P?=
 =?us-ascii?Q?uLqL3oYJq6m8AiK3VSGJwnUBX+5W0eN+tPNIQnHWfdh1Ebx38qVFBMG7syOL?=
 =?us-ascii?Q?XNpiVOpkdaILoYlaHInTFs35f5eDY+tFEgDw6OfTO7++QcsmB0SgutiF6HXv?=
 =?us-ascii?Q?HPDCegboACs3RCP0xovboUwkx7gxAVnfeJyFcLAxr8DVM/VjMpgX/YqRTpZ4?=
 =?us-ascii?Q?2R4KJRUQCEm2mpqx7z45qIazlpKlcxxBiJNFfbs32z2njT4WcalTzcosmvIs?=
 =?us-ascii?Q?9JXilEKyFr1I6bWcaiwcM8ZLmsEUQbjtgjPDS47goqrZJda4HlTNHwcdDyDg?=
 =?us-ascii?Q?i3Zm9pomBariquJtsjy0bF6/215HNlj5VqO/uo7OZzhVvGbjGWEfKqx61WqK?=
 =?us-ascii?Q?/K+FhSbOz6XKz+aVFAq9EF6cOM4jUO9MukdMeOGgJoahmUA8Ccgr+6owwzaC?=
 =?us-ascii?Q?1QgtU7MDjtSjBjNcU+Vshwnjj8/X+TPyx9+f5nZk2flqeG/m66ebn8U2VtCY?=
 =?us-ascii?Q?uTYnlSfmkSbHzvDFmXPKSvXkW50lYel2w4jHs3KvAiTPuKyvsoAXP87lGXfp?=
 =?us-ascii?Q?6l6EnsvGoRhFqVJweAJ7xAMgWxfn9r3oenS2VCvD5ipnXoKd3bwHEgOKJ35u?=
 =?us-ascii?Q?8KrkwCLlTej+2cSWXO2C1sCrI6lOhb2d8cuujkuqNdPgqLQrHWlpcX9HfR74?=
 =?us-ascii?Q?522/RPUKX9JcxoPSJ88uCQcblCi6rtuG7++v1yKVMnU5tLaHsoiCdCbkl1JA?=
 =?us-ascii?Q?3iOXcMQmEbdMGX2Pe/cpVRdM+ucdCqILFLn42vLoGIYt5iegejaZBl4JvbhU?=
 =?us-ascii?Q?U+4ed5g7SWzXp2iNHz13K/BL66iSiyiTtU0MBsLZVsIhoX12gFlQwRq/rWl+?=
 =?us-ascii?Q?/I/D7kIQPdgphkTC+ijeRjOLg2pc1yuQEPdCK7k7ncvdGdAhmy26jrjGTg7S?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c32883d-5644-45d5-d1fc-08dbea7811f1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:56:02.5847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53wa+6id9/NldIYb7KoLUXjxVdASL484eqJdeLWbOY6hodM8ED8OujKzitKHyTnchH86IFx1ZZf5BOWW24qfUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667

Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(), and
pass it to mptcp_addresses_equal(). Then in mptcp_pm_del_add_timer(),
the input parameter check_id can be passed as the new parameter into
mptcp_lookup_anno_list_by_saddr(). After this, this condition:

        (!check_id || entry->addr.id == addr->id)

can be dropped, only test if 'entry' is NULL is enough.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 13 +++++++------
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 77a0e859076c..d5ae2e775059 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -259,7 +259,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr, false) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6ad8bb2f32e9..c141ac8ba1ef 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -203,14 +203,15 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+				const struct mptcp_addr_info *addr,
+				bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true, false))
+		if (mptcp_addresses_equal(&entry->addr, addr, true, check_id))
 			return entry;
 	}
 
@@ -290,12 +291,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	entry = mptcp_lookup_anno_list_by_saddr(msk, addr, check_id);
+	if (entry)
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry)
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
 	return entry;
@@ -310,7 +311,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr, false);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d132a8d91d10..d40e29419c04 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -920,7 +920,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
+				const struct mptcp_addr_info *addr,
+				bool check_id);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
-- 
2.35.3

