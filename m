Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A68171AF
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AqvDTDSx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfdE6fZAFu8yMrUCYdu0WnsO/X1itAtF5BgU/ObLlK3hNekew7FIyiHFLkDjEBQ2cX+XLEn7c/cyJWUfqM3NTHzVoymsCda47jUiTavb9wFyhULRJZtbKQJzlrH0koEibRarQbSWs1oq0E0jA2hxgn9LpfTTHni24vDMW7mCAm5roPNMGjcmt0tRWDaCTaRItknwRSO6TjQcQWpTzk6r9b29XdvKvQnCFCxZRBsqXavLxKFebaTpjjCuIHaXEyjgqXKC89BVBcJo7ERReBRRA1r8wXfBCuV+Qb8wWIHhAmjtE8EImX0VvL5PjqKyTs0NVTQpR0fHNBs309x9yBJGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=amytPnmSK89jWf4upZJ8zWkRJiBK5ZixN4pKZVTIBIWKtbK0vkKYyuzJZLOmPET03HKBEWK9p7KmQtI5ARQ+M3vE75qiN0RDEHKLwV/CQtye77/u1wmjRxIKCM+d5gsHJNz5LzS2XVKHn2Wr+shyavS1MbQW42/YdCnL7kEy8k/uj1oy6LN6nzyGVaCy+v2DVd8FmvJiNZhl7V87Dd/lGPSvBeTOEaj/Pky6YEtY2mnLGC3LFAIqhSva/AJqS5rfaA8KH8gWxcfBdyJlqPvFUg5vEwPmrNtHnDMAVqVBtYYDfwHEv3wJahHR2THsvf7jlZkax4BX+JQsDWer/Xz28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=AqvDTDSxpx+1WHPI3Od4UZU5MP+KXSTDNqLsGipqyCDJrBlLJvSe0ms4EMklcZC5/1r985BabIoEcz9gZSjA4c/2AIWrTOHEMRYzlW08KyvRKc5e+T8oBeA7MTJqDDelfv0pIM6chub32jwUC3qDC3pjXjIf9t5kEg7HmwE2fI88dk1fZ4H9bxhMMKKoPLGiDOoHtMTO/6pB78ScvSk2PRcgEu2rH3BNn8uhZVKSI3JVm3PR1Pb8JxY4P/kBduNDytUYKYq8PJMk+O7ztujKlepcabA0v79IRaB0oQkA30ocU5S9BFWS1RZATAQoHarCqW2U6u2srMrAhwUqVeRC4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8387.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:53:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:53:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 03/28] mptcp: use pernet id_bitmap in userspace pm
Date: Tue, 21 Nov 2023 17:52:26 +0800
Message-Id: <076e1b07f4d55e5d89fd4b38ba23ede690c480da.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: c83fef4a-97f1-48df-abf0-08dbea77c050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LTDESI4O57zdJw0WXBqU5tBFurtmuBJQ4WyH1O7mtBL9tr6YliGb6Vgp+0cs9RHyk/6BPfosO8MnLUaFd/uDW8XFW4SS7qaOLxKD1kwJiM+Tp+0BLDQMh66oj9ByHE7U9Y7NlaQkiRTWHAvzhxfxjezqyhKaCnwLfvRa2ql1arr0YF28etw6i4C2GWGj0oR94cWGSbvHegF/a5WrmYv2wJxLJLZ2vX5ICaMYGbHDRK7YzgkiyEHiKkZ1SRJdVqMXkW3MUzu5t9Tvyyp7qkSKCAmsQcJe540uUDWsV5u5CKm9OCLElxXb67NBrSvOUHrma+vJ9V0X2pvxQEKerAfX9O+Znm6ScfQ45n4anBgrGTu8MnVkNXIrzUPFo1pRqKE1x7ANiT/tvvlatNHy5IgJZhDiSLrpD/eerduD34J3kIKpruXOQnEtUy2GyIxDJvW7JYdKzEBSQkIbFIPpLif/WBIGbk0i3VPZRocgGO1azbgGti5iGYWqIeegcpVqyTu1joRe7HNW2mzi8Fyq5LrNyLjCFShLp3zEG58w68Ci6h6ErOlhbD3xh6wb2EKsaRMh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(478600001)(6506007)(26005)(6486002)(6512007)(6666004)(316002)(66476007)(66556008)(66946007)(6916009)(2616005)(107886003)(8936002)(38100700002)(4326008)(8676002)(2906002)(44832011)(5660300002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yvBBOxC1vcXCA2IE27ob0EvCLz0bgWzgIQlNwnopsYPPQaPSVznvIjJE3ynJ?=
 =?us-ascii?Q?lFIe5TPNQQgJlzbbToTMKDH7GzRck0JwdTObbsDeDF5GRgXauTAJH5JujcTN?=
 =?us-ascii?Q?R5a4ob6s746bzKueUGRn2NNeG8nADX3GDdMrgFcVpDd4KJ78Hc21ub82ziqH?=
 =?us-ascii?Q?Jox+H+QrdXnR+3CeLL8SD0LFJubj6yKPf1wiyeanCdXTIe0E8314HL/b7Gs+?=
 =?us-ascii?Q?1CFvJi1BLiTvZkqsl+UuC8uaUevZf7uxDPQAk05ZgAAfonCfwyIQTTabqyKE?=
 =?us-ascii?Q?UQWL7ug3HFw9RK01EQ+pRKVFg3zpRZNQ6aaX/sbWBeYQyqm0njOOcIwWXU3O?=
 =?us-ascii?Q?3RqI8FSVBRQo0gYXkpJA9NrfzmydJqsJ/+pIMizdxS+uNBLXBzjt1jD75y0F?=
 =?us-ascii?Q?iADsmOeFsNemr9xfxADgzgx/6MmDmMQKnTm8xlF06smndd8QGZlJ+qNCwewi?=
 =?us-ascii?Q?f+k4lUx+mnOXSNy4snztvvuhswwzBPRS8jmGGfsYdAAfcfn6JvKSO6JNA1lW?=
 =?us-ascii?Q?OQJfUu7Q+rzcnAsz+/kFX1lY2CAn3MPlO2BP5nSRVKFCkZWA6Wfb2JhvsUIW?=
 =?us-ascii?Q?HrEzTkdC4KSe0g4Aqhlg3IVRyPDz4cQ576z6jxZkAGJEx3gFMuhtPhrwXg90?=
 =?us-ascii?Q?8AHMZ39v6c3gP1nSeQpPcRTrWTGK6DYRd7knr9ucmFdBjnkGmT4T2bnWvWUz?=
 =?us-ascii?Q?skb+Uj3719+yoPinkB0lKu0wRj9HUYc4e6iqVXa07pqqCsrlBMmQ8qAkAgc5?=
 =?us-ascii?Q?nWTNf00FOh3/V4cHVZ9rfyJFRVCyzPe+T3l4l7tgbzdb4a+wa6PEBZUYhuNq?=
 =?us-ascii?Q?LSLtQPUEOLHNGFB+PuxKQynp1RP7YOuY6kV34cEBSES/SWQlQsFL8mRzfh7A?=
 =?us-ascii?Q?wVN4c4WAXDyEOoWijvBIP9GmyYfnBlM2gn2RRrqs3s6MmzKoHcYLYQbrkrsV?=
 =?us-ascii?Q?YjD/y3ORoxe8ANfS5AFTijEshcpdmvtgZLmdypP9LHVAXRbnhX9SB+im4Mp5?=
 =?us-ascii?Q?v3kl7i1KGOiAlkJz0egFIuKCZDsmBmWJRnAddDG2e8xGffiW64pVWItHmz9L?=
 =?us-ascii?Q?NsKxS2xbbMcHFXpBnEVeYG26cc8igv/fkFrP15Lj1kQ+nI1kz2DENPqeV2q1?=
 =?us-ascii?Q?HPrfqEzKOZMNwJlaD9nujBtClSrYvYeJPw9j2t7DiQ60/V778JznaHaPJBU2?=
 =?us-ascii?Q?lxPr3VndgXnYBiO9NnLfX/3lhJ4YFAk4O2YgLi32Kq44hso+jEsvc1Jl1YpK?=
 =?us-ascii?Q?U+s69RSlNBG28tvMd2jO/GZCE3h15q7yrMpsbBfQzgcnKKk3zPrGCiq+LAWa?=
 =?us-ascii?Q?Y8zJfSvXqu+F8GHoNAejVCod3ULTgjylQVXOOWtRY1p/QVp1CB5eganuf1te?=
 =?us-ascii?Q?GeShIsRaucNnYp0N076ByVlFQlXKiZhc4oZ2CUQ3WWa/x2wzbCVbHC80/v0p?=
 =?us-ascii?Q?64yTctdhPoG0FoYS+k0c6jpBsWbLEl7kHA9Pw3Bf/BeP5pQccLrYzfLEN/uX?=
 =?us-ascii?Q?HV1n3howocM5plu2AYyf3yGc8FPfdQb8QfbFaEMzDmZMYGBOQAZs0ulGClrx?=
 =?us-ascii?Q?ZMwMlEcxDZmTT2r9SMTR4BoqEfMEd6M2DnxArpgN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83fef4a-97f1-48df-abf0-08dbea77c050
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:53:45.2627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRZWQKG2TEKUwkG4kCQiSxC5HQgLhltCAayBn2b8l50mgOaFFG6TZ+f9CPdXuXPVV6B0tAlEnStZQ22MbvkOqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8387

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

