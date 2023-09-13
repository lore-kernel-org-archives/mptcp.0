Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75EA45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:04:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5ejoDvvB/PkplYVydyoKl8LEaT4HRZLypEH6ovbShai7bMYnW4pvX1aILvl1zf+H1q8KYPJVUwE8hYj1LJ3U0+Yzor594Umb6lvxsFTotLzCvwCZtfC1+xbVUIOzA/U0NtJ2Hrq+LHfBFQQlo7zESS6Z8O3AY/1ccAWb4fY6xo7Mw2a7k54UApD/8n61mymNQ/vE6450SjJ6Ra00pRg9ruqhDEEb8oW+7Sn+oY3flRwBfuDgu0NrZ8V1vaNChYQ/nAPBp6tHsJz8KKss+O+iaJ5+2FolK0aMBgX8hpWiaeROOD0R/8KSgfqhFJnxyygiMLxwWxSbhShawKPIXBpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkiAjHaHSi0NFslKIBsEM1skG/zeI16py3Vc0mPVlfk=;
 b=CtIs/xg1Yq5JyZQGVOoaJa84jOugpLZ2rJ/FhjDKW/D9n461yGNTmz8l56ur9qrmamVa+NbJqnddfvsiAFdMua5uCRNQCNzMAPSVVkHXkGyCktoj5GbCFup7x15A/wpxVqbM+AY2O07b+QfDTdAOAjexLk/9wLIMPYi/XuVuO1vwCBnyc/NfF5QgLG/tGqvY13uQePNdGYcml6MUX/C/MZWt5eOjb0WbaYGNNNiJ8T/8InNhzlCtnJ0cpqy2rlw4QkdOqgRpj4JStBFs+SPtELrfZ6PimssQMj3aEYcLQsEJzJ9u4sQ15LFPQhlb/OkF+tr4EGuqHp7nGS28Y5moPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkiAjHaHSi0NFslKIBsEM1skG/zeI16py3Vc0mPVlfk=;
 b=OX9JYWJh3tKnClUt4gV/1xnErrXRvqflVKRiJ3zUFX5fh695agPiOQB/KbORUMNVAV9dyCltttxFaXr9P+BswWmdVGhwExto2GbfZaIM3q526xRks4Y0k7+eyA6VpYb3RDCRKu1D05vyHoGerehvRy0qV9jXUhfiAVnm8x2W38sDQp4N9RwtmE+CS78zL7uKC8mDNhVRdPrm/BLn3x/UkRL468ssWqwLTCFSTGdqHHAtyPxUSuhSlPwxV9uHqG7Zd11kqhJ3kJVECGbSggIe62iyEhhfiRgQ6qJL1HR/xROYislbDewz/6QSOX/fgL/E0/kODDoDzSHKCXixWHY5Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:04:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:04:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 03/13] mptcp: add netlink pm addr entry refcont
Date: Wed, 13 Sep 2023 14:04:51 +0800
Message-Id: <0d3e10949c918bb714ad6dcd382de8809388dc7a.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694584681.git.geliang.tang@suse.com>
References: <cover.1694584681.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 8740f46b-cc26-4ae3-aa51-08dbb41f5260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6Q6SuPXaCRx6ssaz4YbzRqyf/OXFWCrpO+8YEIh/+rGLwpIIVwnNQVVhvCJK2mnb8Dq1mLplyX67gTmQ8YDcatM+Bmqm6eUYrqjESlRVz9oCHvdugLzBjzfsBGLw1HtZPX1i29OkKkS+FePRterN6O1IjhgqQramH68F3LR5XElsSlwmL00+9kQ8QJMn9ujDAQJb4rTHhpcrTBeJMSc/U+r9HuDop9vR3av1wOjjvMp4ygpZI+UgFQIFFYIPrpgf8BEXNKlR5xe8gUmwiX0D9rVxKuL6fZj2oBSK9AWPrTlEyYENrsUodZMEcwjUJs5RSf2gUG7ZrVJ7tSWG2c/pE4ra+/QnGpX0CbNi3dMn1EKPvW9Kn2IgzmOlqF2S8hUAAP/KcivWk4IzoqZwWLrShrjv6cUzcvtBC5Gwu5KZuQt+HEyzkXafo4Hw4OLmE0RZns6Rkx75L85LTtBMwBuYzp3V0UVbEQEc09AV2cOmyJUgxObFbgL0z4vOWRjZflfmGoAEyIwT557WNxmuzb/cmjTf5NgMp/HPURMqmZsR8z20RaaKlyNXlL9LuvNYbFSRO3Lq6i/zrLvUjfWqkBV6sX0XCln3Mso/ejI8E0fMJYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(6666004)(38100700002)(86362001)(36756003)(2906002)(26005)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fC/7XMKBoMoMcKa5VSRK6ix4bIHhLewSnNCrFl6n60Xq6sQVl+9igFCsLoRn?=
 =?us-ascii?Q?Jtw0RZzhXYlp3QervZB0qEzYaSgrxuHhyt8tkUmgk6+rjtEWr6P6H/z7s84y?=
 =?us-ascii?Q?LAHXCFGEoFmdxUZfMELmhNuXChNfkylIVKe354jaZa/f5Kd5qon2qI/Yr8bM?=
 =?us-ascii?Q?ipUaIEs+Dkfvfp7C/2lWCzSkl7xOEuT7zsfNPL+BcIzEJivVTUoTDLTuPG7i?=
 =?us-ascii?Q?W7iGZFMT8oCNix08VZLvBBaXQA5HMZo11lCj3056WiON0EtjNFJVHOLLMpTW?=
 =?us-ascii?Q?54xN/5d+jjbMYlyyV38LSeZV9A1RSwIDjZ9oS1eq4/UwTy1GVBthKXLhhpt8?=
 =?us-ascii?Q?l3Of9IDxlO1qr5fuZRQLAEdQDQuln7RSD1GYpOgCNbb34xAfQaHbD9xCvSAE?=
 =?us-ascii?Q?eZXmp9XNhzv1pKszLB/pH6gB9OBK6sFerPNnvZC5uTwaQHK17ig/MKD4+pTY?=
 =?us-ascii?Q?3LSm4lVoAwqqKJy7jdaljqtykO4a74L8HsFJTt4AW+Ah9ioFkT4K+0ZzoKsG?=
 =?us-ascii?Q?Z9JSdyBYxBwYO73FBQ+sKkmH8pHBNGpe3Lw7UVkbFC0922L19sU0QM3WDvYj?=
 =?us-ascii?Q?+QD2QVxvRUwXPiZXSguMLhU6c86RZeZV6QFlcWa9RnovunRLEEOJKrcy0pK/?=
 =?us-ascii?Q?+igTsu5YAb8bLeb6wuFGrsbFqN3hxaEiGgFKRee3vF3cHHvO4glsfKy+C8l6?=
 =?us-ascii?Q?JGuVLHHElveSe/QnT7NwTzD00c14obbt9XOaTfaHsm7gcC0xx2HXwRV/4idb?=
 =?us-ascii?Q?BsAgHhfFXH0tbRq7sVQ8+Nn+7hNVlJ9e2i6ycECN/nzEMBUnNqRi8shcsNPu?=
 =?us-ascii?Q?aJd4fuj+rYdVHB/DyANS9g/SvfrubKeN7EoiYF0eL2P8cVUMCl2zMz/ik45k?=
 =?us-ascii?Q?Sh8252nPRX4Rgj8oIAcYpjlo4b85VeGpwFQkUZOQjoOzxRdyQAc7+ZOryY0r?=
 =?us-ascii?Q?M3ozmjbYO5/I5JkaoyqDqfNP+AK2UgH302eBzBbmBWATNLlnmXWT2R888bJR?=
 =?us-ascii?Q?EpE6ZT0GpRr2buKAmzaRhvmkp7C4f6XsAtOfFTFnrnaGh9qbYGNSQCZo8UT1?=
 =?us-ascii?Q?uMjKyIe7R5p3cE188nDUqXUlH7s5bu7QbrXzT0uQ5pCznd7FqO6sg/vqjcnS?=
 =?us-ascii?Q?4tjPluFRtdKn3lLMtitDEQN6X8wh5nnf4jtaSX/Rg7/P4qv8vbRwLhWqxWya?=
 =?us-ascii?Q?E9jElzXLqpkPrj6sUJM/AwLN0tzyRql0RV+AOHH5avIDxPJnuDNYDNkjSxHD?=
 =?us-ascii?Q?ojuPwqBIEfV0YTD5i3XQtqcifMOTussnN0vVJDNELo7gjZuY2PFcjaLb642A?=
 =?us-ascii?Q?lzJl7wMpE2S2qlq8ZuU02HBTzwSCi9jFLK9U7AvbsdxjJC8Bw0PlBZMNopR3?=
 =?us-ascii?Q?i7xCCvppss+cAbiD6w0zxzHppaYUJGEUFyNtyq7g1ZzuMZ6oqInQ58iNWUi9?=
 =?us-ascii?Q?jXpMivyKvh6qolnkMFutd0V4hyJrSSSCpN/26I6Qc+XoXVe9KV8sOcuJbGOD?=
 =?us-ascii?Q?bjCocpjR3oI9mTeo2g+HrPb6Mxu9YRfepRtlOmAhNdeC0aCfp+hn0I5GLNZg?=
 =?us-ascii?Q?8FU2KDIqiILID8DNflp4u80nYK4rS3wMrFv520ZJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8740f46b-cc26-4ae3-aa51-08dbb41f5260
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:04:42.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RysKa05a4Q0Ym8wplymsFaJvnNrcIQez6q3Dw84PH5WxBqufhorutqJEjFKaGanHzZ1ZmRibtblwy1XQUI7bEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

This patch adds netlink PM address entry refcont. Init refcont of
every address entry to 1, and init subflows of it to 0.

Increase both values in mptcp_pm_create_subflow_or_signal_addr() and
fill_local_addresses_vec(), and decrease refcont in
__mptcp_pm_release_addr_entry() according its subflows value.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9661f3812682..09e632f72366 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -603,8 +603,12 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			continue;
 
 		spin_unlock_bh(&msk->pm.lock);
-		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+		for (i = 0; i < nr; i++) {
+			if (refcount_inc_not_zero(&local->refcnt)) {
+				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+				local->subflows++;
+			}
+		}
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -644,9 +648,11 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
 			continue;
 
-		if (msk->pm.subflows < subflows_max) {
+		if (msk->pm.subflows < subflows_max &&
+		    refcount_inc_not_zero(&entry->refcnt)) {
 			msk->pm.subflows++;
 			addrs[i++] = entry->addr;
+			entry->subflows++;
 		}
 	}
 	rcu_read_unlock();
@@ -895,6 +901,16 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 /* caller must ensure the RCU grace period is already elapsed */
 static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 {
+	int i;
+
+	for (i = 0; i < entry->subflows; i++) {
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			pr_debug("netlink refcount error: refcnt=%d, subflows=%d",
+				 refcount_read(&entry->refcnt), entry->subflows);
+			return;
+		}
+	}
+
 	if (entry->lsk)
 		sock_release(entry->lsk);
 	kfree(entry);
@@ -1087,6 +1103,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
+	entry->subflows = 0;
+	refcount_set(&entry->refcnt, 1);
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -1337,6 +1355,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	*entry = addr;
+	refcount_set(&entry->refcnt, 1);
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
-- 
2.35.3

