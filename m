Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E557DDAB
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wm7JyDNM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BH0O7uDsCykeVSmgFWEIohvWfmY50yJgyg9BFdmOkJWNbJPN/Z7wHirS54rPpgi2K42aC77bglH3/BA2l81CSoBqC1+dVnBoQmORgXSgjYGVhOc9Sd3Tzdbx/ETCcaIJY1o6vPT1UMrLvHtPltA9ygyS9z1H3thJLdKoD7ud9rf2fgBx7OsMC6hc/Ri/n15uFFrG2pS+AsxtPs4gA2ONQfcKQMhCOzm5V+8lfjg26pBcTakf9MQUcfHnhzcBH3LFMcBFEF9Rrg/QJ+YurUeRnlwpGpPZ39pLc6yxfX1dL0nYlTI67IO65lldcvcE4sB4AGUpUcFyv3XYmIQo1/+VbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=mQIA9KROA6P23Y80DaPowN/7DnUvMiBpbY9F1dTo6yzZVIj6TWgLOSg3PugrwA647aoR2VXap/Tf5x914ptUh1l31/BxC8Y930MgAB5u/2JFRmcg2iVQSFgr8XcqaNHXgGyUhadBDRiqCFLOoxROvKyoznLkTLgF/TZ3fvSmpSJnhGFMQ35hsSYmd9fKzxIle1B4GXXj+l9j3QkNXCbtHBCl8xy7dCGI8CjkAGTn7/SILGm0PMUkWaWJE/GjHHBkNzJ1wd/410ZYF2mZFXsEgtpJ7RU6ftcp+GkvOaJTh6ZQFWXN3jdKxyz8wklkES5yuYxXzjTJ6jVbMCT7NppkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=Wm7JyDNMmByjuZrO1PC7JQN89qnjC7U3jU73ETedvnuFfYrYkfZhIePXTd2id++9fEEL92vfKd723DkL2QAROJhxcMFTp8eP1gEcjFUKJwDCyi2WvmO4hxCIqmA7uvdxqkgSJhnOh+XT18Q5X51u3Tn7ag0H0yCUgVfd2byFJsxOulqiqYh43vd+CAG7oKlWZ/p3z+oeX1lfCcMf8ucl2w+7WGkv7wd/PsyrUOm1JmgbCnnduAD2GB0uZQPKce7EaIav+4nivIC+PDm5XXgwKXSZtW3kaOa/wnQ7TSF2b3H1o0578sRLbylcMeZLXhM+b2PX4upISVMeOnzRs96L7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:14:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:14:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 03/20] mptcp: use pernet id_bitmap in userspace pm
Date: Tue,  7 Nov 2023 16:14:09 +0800
Message-Id: <9a08b0b80acd9e3340df4ce56e949f8d307dbec3.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0223.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 386e9616-0c4e-4557-8a24-08dbdf699802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gnTLKQbjihbAz2bfGkECIpXnXGijybKR1+LGO+wZZYldK00FvcQUbKhrhnurjWlIo5gdZr+joBPvJBOo6nj0/wDTW+4Al6/FnVYQFxMeBW7aAeZgffIyrrEF0Jy6Q3Xf2QU/DPG+dl2KhClRpVq/oimE5+SpcPP94TEUHEkWJLF7Ncw0a+NpSbrGkmgFfb6WWgha3c3yyG34ZGQkrSCH83Wl/fHLpLrJY0XBbQJz6U50tK68PUUB82MyO1gaNKyuVScdR5SGpoEbkUacb0eI1Oy+PqIi+zTwLIuOlIePKeIYxZzcpbhFSaJME5mA0FWdIDbhKizkf+TR/WkQVvegGmTyww9syZBPsEr05RdiYSCIxy5H3XhBDoNbMzTYQoLQt91DQY87mh+Xj/oE2/8TDeCnL3eXeizOe9fGrniunU3ER4K88XeIf3JQNCYZEfHLkWfbhf0XzOSAZnloyXwVgxXFPjE3GXTE6tR/9buMQNKE0TPf40i1EZDabbDFnqI7nxPdg1RHZTjsAzOVzqFTPZYoXlVIucqMP/LS03awpd8lWy7tUG2+NKVusszNGzwl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vh4T+4yAEyLWJp4ECuYDQY0w7dR6hnV14E9AcSloDRCkzOIKgYzYbABxMHdU?=
 =?us-ascii?Q?Iuo12eH5BxJE1r5v9DiDPFP5DUmEivPxBezrE510UZk3liR07wwClY7dGNLw?=
 =?us-ascii?Q?QmIHDN7rASJ7oTEYMgdkb78iGpjvk8XkXp9IYNXp52MWXU+2EZhEHBrRli7O?=
 =?us-ascii?Q?Wu/ex1OmdHzzBk9knS+V1lrx/vK6TwulBPvHgCSOeVsn8ax6WO5Jfao1BC5J?=
 =?us-ascii?Q?Q2QSCLQI/MtIT6gmooGUj5oqE+ms3blSD65elHOVuQBQNzxDIgkAdUhp4BdM?=
 =?us-ascii?Q?CXLwlBP5sI/KD6atu3tc01cSGeNBSzp1wppkdn9P1Igu7uGJ4CbRlA3DlBco?=
 =?us-ascii?Q?s8LEm0wOB7ZasIKiMoHJZd1THmiyGukdeE2UBa03r3uTTUPxl1KR3pfdR5wA?=
 =?us-ascii?Q?C0gI56s8U1RG18TzssbaNzE08ess7XqV9nZfcpBqL2uwUVBj9Z0R8tS8NC7E?=
 =?us-ascii?Q?VZpHdIH4CWOsw1qKl+XrCrHabv2CSr0PborMDIf9D43xFRGXzKtuJ1Xjse8G?=
 =?us-ascii?Q?6r0y1HQjrnQdFYIzVQECue9hYoN/PlgIAchl2qwGiEI4xQdqsKrufT0RiuSI?=
 =?us-ascii?Q?pKCr/BYK3G4rO8xWA3UgxdNkGttb/tmrVGAbV3Y4GA8SrXYZqIKnrk2Evr0Y?=
 =?us-ascii?Q?ZxlGIeSvcJj/n3YAZ5UhQcBehL2nARGE+MxoYul1h4eCp/SEcp/ywbze4eHe?=
 =?us-ascii?Q?te3p7WJzi7QEIerRte5Zp0z+XrY34PtDioHwmC+kKy11++El7JiAOqFg4hyH?=
 =?us-ascii?Q?mfVRxxcUH4UF6vtqzZj2iajShx7PLWJF2WK+psFsk5RYr08i8/BHelKjjxrS?=
 =?us-ascii?Q?o58n0hFfff+42Y+0fLgEgsF/Q6zPqZ/NyZ9R0LmSPuyTS0p0/HcXSWxswpak?=
 =?us-ascii?Q?YKDuH+Qjgyh24uX5nFYGy76Cqh1hhpykfcPH8Kkq9VoSHN9Ztew0MhZoc9fc?=
 =?us-ascii?Q?xcvNYwgd3gsbVieUG29rNxOwox3yMOmWkeoedJ9ZFLP2kTkPt8RwZ9FJLHO7?=
 =?us-ascii?Q?LVIkFUjP7VD2oerARSc0EehsoWvOrtWcLG2ONAQOFEujyIikbX5DxeQuUen6?=
 =?us-ascii?Q?Vh9pXvSrG1MEjgz/sbB6MdrOPGquMK1YuU+x4RQ0kzBDmcMYRqdJW0/3VXqh?=
 =?us-ascii?Q?rIfVJ16ULTnPsBqr0j35/6ZSs0Jn0DV0WDYxCArQ4sbJYhh4nL73RW7D/mRu?=
 =?us-ascii?Q?Gu2EPHqQ/Z1pamio6iLJMs6jZHOEa2vqmtbFduD0ZCPrBz8aL5Ygaoj0mjoC?=
 =?us-ascii?Q?y1urY3cS2KMNbO5kAYgpQ5JKo94qKySTVPXCPiooNnze0rMf6Vjh9YxuqnyI?=
 =?us-ascii?Q?HTYUUA0N7JObMbr9OB15D9KuiwknLsEM/1+HMfY0w/KHPgYHE38pk+AVANpQ?=
 =?us-ascii?Q?EYtLpEM0TKrQLR36n2UDGvfYU39bKMfshIdIlUm22whqNu0cu1I6m4DSR6qe?=
 =?us-ascii?Q?xV5Ppma9AXMSBvWU4zJzgBlq7HSgEZV5biOushMwOnXqHtEdlN9j96gi6BZY?=
 =?us-ascii?Q?BJqKN/m3hR5vh3iXxYyFTihI5WhrHoXCBTWzGVYoNX/Exkh4LW/cEEu8irFx?=
 =?us-ascii?Q?eyxh45Lsvm6h8wNgfv+QHtRy5AdnzCIG+rk3VCG+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386e9616-0c4e-4557-8a24-08dbdf699802
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:14:41.9101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9AMwdw+1AgHgRdL/ek9sC4GvUk/8T8mdU6oVfd54R3hajEGCvc0Ldzkv/SWKzkSlfy3n6ZNLxRWZp5Gae2x6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

This patch uses pm_nl_get_pernet_from_msk() to get the pernet id_bitmap
instead of using a local bitmap when appending a new local address into
the userspace PM local address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..b3a606a5e182 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -28,7 +28,7 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
@@ -36,8 +36,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bool id_match = false;
 	int ret = -EINVAL;
 
-	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
@@ -50,7 +48,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		} else if (addr_match || id_match) {
 			break;
 		}
-		__set_bit(e->addr.id, id_bitmap);
 	}
 
 	if (!match && !addr_match && !id_match) {
@@ -65,9 +62,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 		*e = *entry;
 		if (!e->addr.id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
+			e->addr.id = find_next_zero_bit(pernet->id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
+		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-- 
2.35.3

