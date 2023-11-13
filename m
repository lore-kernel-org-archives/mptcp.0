Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111908475
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="x0fmYuxR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQPFXje9bJCMboYKveu75imSVt3saT2rbajQVcehiygU/iRek0OvFcNzqknkvQ8PKCAVpUoaiERFqVZNjbYZkv9QSEU2EmymFhpC42MMN+wl8E5djbPy4B7ZWWVu9z15kqZj0C4MwUSDODKtO+ZuqosZ8dQJPBedH4Bqd9h+XQ4CahpSgVTbY3WSojSiW/WJLWf9L/P4o8hiX/WNu7ES8Vl+5MqqdTrU92pYIefZlONDIhEDokbiQjSc+SivVnxVaP2PxKZa7uzaD/2PgX8n60uqPK2uYRCYSxR2h/reNWWRUpZYicMZcmMGkJV8yZrxok1zE/wdo+Ns+hkdKxWA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFu5NR5fYWXwtw4Q2nfrmDukq9pre3TiGE1SzTkbt14=;
 b=PdwYhVobbs1lGDTdwvn7pPnKAWeQzndhSk0EH/mh3TA2MJ3fyz2Fo2JcOzOB5m0+JROApwCkdADN0rEavcW/hgSHoekbfDza4mNlrMXxKs4zgMc6ZNGD7Cmbw1jzIllM39Bn/iTCu6XYsjdju5KczvsQO4ca9r1s3njjmI1N+orI6HNTtmsBXIaAgarSddC/EiKmgc9psx+xudddz2OVFvu7p+pRXsbXYpgh0aHy/rf6RrIxLLpzNgafzEQ+aSEhuvgaH7CQNcFakFWcnnU+j9jq76yP57cwtH43iFWjPZ3H3wFv77VptawNRqfWgZPp+T9tCCzE6iQ0d2iECOpN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFu5NR5fYWXwtw4Q2nfrmDukq9pre3TiGE1SzTkbt14=;
 b=x0fmYuxR4U0qVLs9s81If0jIEenSO+24bl3u5Twro05AHPoppC6VOq2ith4KXknEMqFAHuEbpZoE2ehpAiTxJT4rMyjMFPOHnor5vPOPhPKhwQYe4k142aL5XV9AN4qS1VXIbSssEqxj/s8iM3nr9UAQtb7Hn2Zeq5KxKL2WNJQNixr+XmJ7QR+CzKlbyeV5aRB/gjfcflmg1ZM1M96KvtdxOIdVPEJ1uxsl9IfQsuNmqsG6xkxJ2x1AyNqyySY6DLgxqrIC7ZhGJrxfVtb88zbFzuBuVql6kqHn4dj9JI9kIRnUAhxarNh6Wo43IJgxIoHT1IrJxs2cVpqBCRxitA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:49:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:49:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 04/22] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Mon, 13 Nov 2023 10:48:48 +0800
Message-Id: <45fc254ae01436317fae9ca6b09ea79f313e70c4.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c99b55-bbba-43c7-9343-08dbe3f3247f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jwutRd4Dd+mHDj/x3UIBZJ9ppjbN+O2oIGkRs0jqFkQq0MoAD9olKPDvGK9FXXfPd6V7j01zCJLkobRGtJlcyABYjtu+tpEoa5qUCu9/c5BQn3dO+tGVo5YrjEk8qwN12VHZMvk9ATizak7mQylYqgqBUND5ffP23r59MvtQy00eU0UvjAQnOfM/aNGAaNJRJbuvtlaYz4Ea6ea+kbhCaB7SKnMdl8zudGq4FoR5GZ/+Kduo+N959SomqkVU2UOB3rXnPDwvqtau7VKtg+fyIASIDlkEk/Cs3frDDpb2/UD9pD2DZsyKSeMfvd8ZaVivrL2GK/Rx0bPhmgFdlq/HmOCnizqkmzKYX3PR97NzoVYXeUP7ZgpiyUhG53kmRC/vOKJd2XJaOX1zKHy1MZ+Oi7FqJ/s5upVPPoF19KK3utSM2SAVnWS/8ogkcOxLLD+tSV4HJzURA5cKSRagMCOaJ3uJCh2znIdSuWMcFKOf5cSPYb100j9ZPJUqdVUpV7fMlhAZ7/NpMW9kS8WoIkaixUMLRyRliToHiEpRG0rQ/bR05JZKNG12AXN0bcsSt4oh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TZKUyXr5w2q99t/am/0jjdtEcPq7xXMODJFYPK3COBb4pMEVWC0Q3SNqEfD0?=
 =?us-ascii?Q?ch947r5iWQTDHgq0Ps8OjvNll4/vOuaTsWAB7aitVM9C9n3MaZCSO7Jx8jJi?=
 =?us-ascii?Q?iVfrSEsRLjWIcER32ZvrMx/B/nI9/O5Li5qDRCbAEDgzIFjMylW2382hcKgd?=
 =?us-ascii?Q?o16moAvescO7/WKgkr7suUDGZgIoulmvpcUFY2BcdEM8CNtjZdGOaKcfTsWP?=
 =?us-ascii?Q?wUr/UGxhDwLJhJbld0R2zLSuQgBHU3QPPJOs05P0FfZZpPdv9FVe2/xgGlJk?=
 =?us-ascii?Q?wPNl3tE8aLXROx5ggSaUq+LI3xQE4HX8bG0iclPerFGTKX9zyX8LrwpeAmz7?=
 =?us-ascii?Q?6gpo4X8refJw7/BTomj0+CD9U22ZI29/lcT66z4tVtfflg+4D5zX19PYweXV?=
 =?us-ascii?Q?HTfaoHcAbyRWG9SW5zRJ4f8N6PgSN/s4bC7sF0wKga8V1bshJ5j7SE0lj4Xe?=
 =?us-ascii?Q?xFnPud+lj05InV29ameSqsoaKC9ffECruUZLba0VPfObtWG5dRV/Tte/brSa?=
 =?us-ascii?Q?YZAhnLjIexDqJUnK+nOJFngS8SFKGokUimYW3lIPXGMzK2zn/6x5pCvVsQwQ?=
 =?us-ascii?Q?mvjcRSu7P58vXTz2RrXLBLzIDCNfWetoezTcBB4B/UNxGawdJkRJRUlMo6fj?=
 =?us-ascii?Q?KK7aWOAXRKoWk8sV2mrq0//S97r0+A6rrRMNT2IgNNzsajfaHmGiWiPYnTOk?=
 =?us-ascii?Q?MgmAed6tanhdGfTmWKC30rawGwhfl/b0g6yhc8Ej2cyQfsB7VpxsHprCuGms?=
 =?us-ascii?Q?7evTmf5bq1groGuqX74UMU2qvu4xkpS0G8osOjfnknfEoIFOw+F2UbunNpz7?=
 =?us-ascii?Q?wvzW97LtmUCVgC301eDAnMC54+NLDcLLtaKGRqC2ZHVdwz5gBE9km0yjgYbK?=
 =?us-ascii?Q?zG0zfxVGh/FQZxhzWqG2Ojnh3ZKpN6EZF2d3pQ6UpvLqbHb+D4NZlA0QF2zs?=
 =?us-ascii?Q?IdmxKfUW5LUL5oa2xRZlc5KrpogjyLiZfK67nviWbZ+pEuDpz8t7YZUeCzet?=
 =?us-ascii?Q?81vrpE+SvAalkilXlRevVn5jGPyyNJlR36cDsZiMcEyOP1ZXFhsIGD1Ry0I0?=
 =?us-ascii?Q?Vn5x8Rq1NUOrf1oZE3lI/BYvIZGprI2SMHecP1sRcYl08dKKFGrJgL1YthuH?=
 =?us-ascii?Q?V3q8sVvrYKc48Y9p6zQUTWQPKHtTwGua+qWUyazKFH+YZ5Ynpo00dKqETf3B?=
 =?us-ascii?Q?RYj1b7UI4fZYN+6EyxFwcYA7Q7m/Qooe/Z8/5CltdCI9QrpnDWRizIrr6FV/?=
 =?us-ascii?Q?pCWH7d/E8c92LFd7OclfR4M4YX3CqUuM4MaT7n3Oj3KVpvhGNnlY3Fi0KKJI?=
 =?us-ascii?Q?NcQGCIUr0+aBK6cBnjrtBhEw3n2ta8P15EIcCa54gxJb72L0jygCixEYCkKI?=
 =?us-ascii?Q?6Zb86E5AnlDos4m6pA0E0bQmBR04u8RqFmYodKYrfKsdFtNPClyp4EVkE9cB?=
 =?us-ascii?Q?22slHtNWFKZuRao3Z8OIGUDoMnLP9ctxpaHypW+X1VwRFqDhAFkXnrBwiHh1?=
 =?us-ascii?Q?MS4FVKyxZaFTcv35vi8YVOvaVnhHADEaHK2ANHWTmsSD2lSphbxfBKIiaOP/?=
 =?us-ascii?Q?30EUJyI5d0m9GV1hovxkAHXCt8Ut5bhRJYtSOoGy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c99b55-bbba-43c7-9343-08dbe3f3247f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:49:23.3046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akajsNOX5hM4CXcsdp5JR6vt4ajVQbVMnlyPn+BYyYR0qLd/TZ6UJloKUeJaybn/z0C7qBvZw1yHbfsLG87jQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b3a606a5e182..6999296cd5db 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,6 +25,18 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -107,15 +119,10 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -247,7 +254,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -284,13 +291,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-- 
2.35.3

