Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F715486
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ci9YIeb5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htzIRwQIodSThwoYCq4uec4wgKpo6OH3nT3VjIxkifrJVs4V1uOq9ImfsZQ1tPBIekJJEM3lHZyz2253/tktJuOv/l4nDs8WgmQyt7NBcDBf5FMDtWb0FYx8JNbO1Oy4UAdnupG03l8Cp+fC79m+WNsDbJ31SC6KCiINplVPlxy/4D2wt2iiwLB8PISoOmqT4oW+1iKhmOKElXEzkfHL0nZ67UatLdPjSyh9iAo+kI60OplqC0giShdIQnQ8p6SfEqTgzlH5IzHHPmlkDrfpAqu+4WWs/aw+WCGISqb30oJ3RSQtg0G/RujUismhWPULweKNsIjbL2eIwbSJkco+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/p+bGd5843Bu/ArKXILVAXfq6x6ovdULqO0fEG2qHw=;
 b=GOzBsu0sd6mm3wnt8SPSYEvg3EAnSNuwTQFZX/C/BUoYTjw0yjWc4dZW5uCl6RaD4e2ZddSa3ZI9lH37USmf5OMfjT4krFgBbnkDq6z820A0k3frUOLTJeBt6YXynCRQetbOMRYHew2Kpd0G1mIQlFAgv6l0UuNnvKFrtYY8853Zkg8rplBYQFUjBxwWpMhtU3btj+FaB872kKAxH0kKq9nIOshJIvstCRh96juBU1tVF95ublMTntYxYiMuYICMHy7CBw57+A6YUU4xucjzsGMowhR6+MktBIk73tI42nKixHpgCkIQY+gTF528MsKXDCDtZFupA2BaQ18FMksyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/p+bGd5843Bu/ArKXILVAXfq6x6ovdULqO0fEG2qHw=;
 b=ci9YIeb5mmAD2UtgZPK12AHGHL6kdrqoBWHmk2w3EerQ8HyXBaDLiRbhp5SpykEjF2FYR79LvnX59n1Ts4NP3HpOLF4Y+oUWiFzpVgTVLgLNNpGzuQUugOxCrbweT5duYHQHi4ExvnBnxdkYzXz0vz0q+NoFzzuog40D2lbqg0u9jkEMBGsX9WHFPoCIUsQeEhvwDwGc2eEFEm6YPflq/KZ/2Ji5AuvLvQL6mUbatkAexQWHBNlt/XYWcKO3GWxtH95YUKr9pabhdtnI3G9iRG03MvQENgmpYj4meXx5UKgjIoDBnl+U8GiMVxt6r2VOWikOlHV9mfDjs+xMvFPLuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:17:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:17:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 11/12] mptcp: add addresses_identically_equal helper
Date: Sat,  4 Nov 2023 22:16:25 +0800
Message-Id: <7dde14ce5b2ac991fef1313f4422fc8576ebd185.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699107275.git.geliang.tang@suse.com>
References: <cover.1699107275.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: cda24789-ec61-406e-b0ec-08dbdd40cd02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WlfOh6pvwJq/9CbcaDa4uczH7MA8aWuzgWy2I56Kc3XfDfdBprYkjb+Ye2gGnN9mFaMEq3q8AiuO1o8mhLXAL6tMlU+r+0LjJjkhEptx0d9r6peerK749/gjc7qO/ZfnvKDxCVKUf+eA/Bs8g/A0PBEPRZrV0Fhej6eKH7PagTxday3eQUgwUtLY7CEgJaoatZA+mjb2x7GDF5tVmi1AR8F2x1i14AMXID3OmOdkN90TkgdAJOylNCI1whYps0aVuE/dCB/jvANUDpJ8XMhrZ4TMNqKC6672lIV8aUDPWR+I34xXQUwYZ5KqyS2jU1hz/BduJ6dK/cF3jsVBChfTIdDmcnSaQwa5jfwZuraePrjxU1DQ9BqX/NZ8R6x4M1YuK0mgtbpxYMo26bTujEWs0YywU35m45EDf9asB8ZJE7PuVIwZUMeYae2su8pWFU5k9NvvPdXKReGnkkKeugCz5Vt4PgnH47tvMdolvVCLexUnczEAm9u+aZRZzX3pJEvdOt5a6+xKiiJRMpQv5VdjIzOeFOA3P6vWCkjTzV4f5SJ6BM0c161srWSUiXXILMc5MFclecf13QgQe7MkVXF0Q6k2fIjFJy1lIm+V6KvFB/Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(6666004)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2J+29tv7koYzKNWuX4rjgE7Keyic07ziegAxpQKnSQUjsz8Cw8FtxXseGL+1?=
 =?us-ascii?Q?NmtlWpnVQrarsNXMYveOZBZNPPDUKH2UxQLwGCUPJX6DYZ1pU0JM2gkzAMEZ?=
 =?us-ascii?Q?r3iGsNNx9TwsFYSRuazqSZHLbEvqJtFUtG/1cYNXejDKaRZ5i+H631+t3y3m?=
 =?us-ascii?Q?3kgN/VyjDZZj8k5spkZbOlKysTzIKTvtKsUcqkQEj/PBEXVPjG1dja7SD8SK?=
 =?us-ascii?Q?vGn7h/LLW4A+4BjmH5nNeuxKR6ycnlPkJTiV2Nxi6VE5ydEm3+VTqSW8OY51?=
 =?us-ascii?Q?DeRBlrqpHSNfvlLfpYfFCK2rxxQvggsJ1sdeBgkAih8ZRNjIYlzNKkRVUd2Q?=
 =?us-ascii?Q?DmWss/PgQGiC7YLqk9MH4xOOnS7fx9stLOspT/eFwx6lZ9iupdMpOmxt+DmM?=
 =?us-ascii?Q?aIRjwBTLQ1s+Nl9AjhVA466uIXk71OhtMyrJ/uri8sjnp+G1LoGNERB0pUWY?=
 =?us-ascii?Q?E38iQNyP8PpyPYD85+9OhgEVQAQ9agLsKR+VNmHiAj1Xfth/AH0alWMxL4b7?=
 =?us-ascii?Q?crKXP2WoqVQCwg7F4yErHVFk/CptGy7Fo7tIn/1UTEUFUZT/23WXXtEWIZjn?=
 =?us-ascii?Q?N6xFBE/ySian/MWR0aX2saEntPKKr9Wh/gFPfVPpLozY3y9OG3UrxjUWowfO?=
 =?us-ascii?Q?S8QBam+QsfO4B7+aSj1vmIyaUfTlTI+7ulr1YDi/dtO308IGBB1UAi8gLTCl?=
 =?us-ascii?Q?B91IgJUt25XMWcOGy4s/UwJe3afKTPaWvmgUFDfNIYcaN87kbESite2nZF4u?=
 =?us-ascii?Q?ph0xv4M/H2e3baUo2dplOl0GJ7SaE2qAa3OnN/GxoHoCyDmf7N1KSRXDgj70?=
 =?us-ascii?Q?v8feDnLk9z6VDe/aZf3Hv+aqqHgCbCTJmztnkT4DGFsauMJO4vfPgAWNZBhS?=
 =?us-ascii?Q?jMH16J9xPZ5/vgVY4GeZx1xvdQwnumOYcayYYt6J8sLSlkhva06rfBYEqfvO?=
 =?us-ascii?Q?Vq1PmstNj5RXH5LpJVS0C4O+lETwDn3Gc/zTHd6DZxX1HjGdOADJyLRfM6If?=
 =?us-ascii?Q?2SLX3sc9wmqRaubG3DxHGm0TChXfIGB9PwTlbKsDjJphrSPFykwhDicdCB+M?=
 =?us-ascii?Q?GDwuxL/+B7+kZi7SKcaWfgkndXrhSQb3hnyRVRFyqpGY8Q0I1XSEfWgLU/H/?=
 =?us-ascii?Q?oexRNPVh6F/0zruP9rkI+UJtnoxBdKoMhrhOBxTuwLe3z77s0/bVb1AqoIZM?=
 =?us-ascii?Q?s1rcjBsKth9QMc65JNfe0fuG5fCwVYGYpcSLKmubueX6dgb4ISfa/bXzjUX9?=
 =?us-ascii?Q?HrjkaZ4sTKNyfwE8CArGHk5yeeE5y0x8m8bC4B475S92tEuT22BJIe87d1GO?=
 =?us-ascii?Q?PKT6+Rr4Zo+sxcwhjFaRSEbUsAj/zHwDj25pbPnXC5u3HF/8EFCMW/ZWgMfq?=
 =?us-ascii?Q?KiTdb9VcIevqcsZwDltHNjhvWxrubrIUao4rXOu78ftUg1LSAczpqo8b/PQ+?=
 =?us-ascii?Q?fPRH5wJwH1GxMufpvjep5IecEmXJi3mV0cD4YmyoOMvAytQOrCaBdD3ewD7H?=
 =?us-ascii?Q?fMWrukL/1ea43gOM1gbZfrh73JgWQNsVGxb3c8zymCSCPlD5n7pgFQoWGOUK?=
 =?us-ascii?Q?QnXmYDivlb0dmVDLtzbSNCnPR2YXjZi5gNKcs4K2L6siRfL8UCDm0SWvsF4j?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda24789-ec61-406e-b0ec-08dbdd40cd02
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:17:39.3140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: al9jiMZ4aM58OB5cx4PURb+koJN8T9B4J58uN8deh15Xm+dBHztzYkS2/m8ByQAOVn7yYof7iuJYJ9dHwwuKRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

Similar to addresses_equal() helper, this patch adds a new helper
addresses_identically_equal() to test if the two given addresses
have both the same address and the same address id.

Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(),
and use the newly added helper instead of mptcp_addresses_equal()
in it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 25 +++++++++++++++++++------
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 48ff7ce20890..475534e51317 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -259,7 +259,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr, false) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6199908cc26d..a4fe051d74a9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -74,6 +74,18 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 	return a->port == b->port;
 }
 
+static bool addresses_identically_equal(const struct mptcp_addr_info *a,
+					const struct mptcp_addr_info *b,
+					bool use_port, bool check_id)
+{
+	if (!mptcp_addresses_equal(a, b, use_port))
+		return false;
+	if (!check_id)
+		return true;
+
+	return a->id == b->id;
+}
+
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
 {
 	addr->family = skc->skc_family;
@@ -198,14 +210,15 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+				const struct mptcp_addr_info *addr,
+				bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true))
+		if (addresses_identically_equal(&entry->addr, addr, true, check_id))
 			return entry;
 	}
 
@@ -285,12 +298,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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
@@ -305,7 +318,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr, false);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 089fbebd21d3..5f2c52c82cf7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -918,7 +918,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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

