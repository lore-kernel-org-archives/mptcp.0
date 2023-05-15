Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F681381
	for <mptcp@lists.linux.dev>; Mon, 15 May 2023 02:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0VrptJJ/tuVk5B9/ygqqFM51k2NtKf16L2DJgWWJGtaFm6DMPExeFod/A4/NyDZEPfbVS97r/lwr9PYLI9PKBsOGYkQ48OCrhD2V3ap4pXrz8prRtYJE6S+kBt7sWhh6UIw2QGL3GMyl+L1D9cRo9qIkU3ILKlSvWFauOw2p6zxj+LhylpfcUpjVHBrDIsbUmmjmGsLhmo4pHssEX7Zz+ZoMowHelJa9A+f7T8Jn6qx3LP2ciUaQZgWBqrPJgUipy9pQFTd42xaTWaJOVDYl5VkLU2vSomRHEF0kYgPsM68eQM5ZVKU8q6oiWuOTKiUqP25gh9KXgf0lE9PZI9G8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP3sziXMgvHO+2QK1/CBdB2g7dTMaOdrwFPepGbCGUg=;
 b=XyZyO4BVnG/aeB284OsUYazUwmggjSWyOgJnpQc2NMnkMlMPGJm5j8EEbXjKfg03t9PLbc+Wg2vK5OQ7UmfkvgTcRUEE01w1jWMPvWJj/y33T6JtdYknK1lFxtnxmMSTzNIC0z2DllYc1lc/WASD92T0MR+IBTW6YLieaPPJCkslB9+V4WnwqSUOi6ega+MlJcV/hfB3fxkUx4QBIe+TyL6DrbDu/w670Boh4JuF7Z6KOB2iTkCIBcC6PRDN4eSjTAeerB0R4yBJby+zonzJfbsu+qKqqV5gs5ckANxzwsPzortyp4ACY0Hy9MY5PQLEHSPOSegBYCcFaFHOpXaDfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP3sziXMgvHO+2QK1/CBdB2g7dTMaOdrwFPepGbCGUg=;
 b=Ggvs6kZX59Row0KJcwmh3TL01ZppRnQvp13jdkYRZzbKn6WsYYY0Qg+r4d2vxd9gttJ182CQZAtnItifhVI/8VhWEg9INIroNDnW/Z3lywt/2V+H7/p8KRUuQEzTAlBWaT6005ZT2o1xuz0FOO58iqKXvUOQGB6zmbb55MWcJU36V+0QrSYsbi9O3uJKU/gxzuAUV1WiE/kf3CBCHm8mgml1K5KJNj0lVuNwnYihOEqB905FRbOKNlZwvkpF2uGpL2dviNrO479xvPb5j0W2shc8dfAaiqlfjFTLnXyW95UJtnQMfuTRjYNbb2wCWAzqo5U7seZlmgu6oGM0fYpMMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9361.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 02:12:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Mon, 15 May 2023
 02:12:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 5/7] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Mon, 15 May 2023 10:10:56 +0800
Message-Id: <a17d195ea580824a5b315a9a2a67f041e62d9fb6.1684116357.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684116357.git.geliang.tang@suse.com>
References: <cover.1684116357.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:404:15::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9361:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1dbc6c-169c-427d-f959-08db54e9c9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mhu/k6LcHLoFkkf7KAdXyskCHoqNypyMxoWzLdbddjIawQQqB/CCsAIxaPKOueLlfuhHdd9ahoX/AWoKxOtGG9nkacXNKozZrknakand5S+3Dqy0+Ij0fcx8TQ3psxBMaK8z+zP44Ez96cbnxe+3QtiGI/jbd7kJhoD/tb6ue82NwT7HoH1h05fKjczxqsDBmhy7zPQfMZ1Q3CKEY5tCvcmDIDjJlcrf+KWJ9PvEHrMNmqQhUq/eua3r83YF4QzKCkY/5AujleBZRJ7EhzM/hWgnlalcRUFhEScGostl2PyhLJ1XQWXWW6AsWWa5oke/00NwtbEKiBAMz0UKMgo8fvhAqQdc7uKtNfQ+Jby0te+rBeCQ83FJN9vW7WrrZd54tBGxcbJAlOcyFVFc13soDfNVxzy/G2v0Ornc0DwrrV+sHyDLQrvzesWN8uGevppFqMZHcgEMWsj4WnQ5RK+/4jPeDwOa6csSFGjb7ANsPxWXtwNJgGDg69dYK1HKBJbVRaYDGGO+jSBc8YBQrvAsrftN8WhtCe8S7qBu6uLaAKtEhQj4BGeCPsj8TAonebU7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(26005)(6486002)(6512007)(6506007)(107886003)(478600001)(6666004)(186003)(5660300002)(44832011)(86362001)(8676002)(8936002)(2906002)(36756003)(41300700001)(4326008)(6916009)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8iSh4jhEUb69VdUQBErEfYzOiK1HY1hac+dNAM3OZF6W758+ZRnJdq6jRSX4?=
 =?us-ascii?Q?jocmOa76WCG1Ev0P4oBSwRyJuaYsabpDBWRyftRtFYsg5WJdSx+88axrfqF8?=
 =?us-ascii?Q?ox2gRSoprau2arJYVFdnR7Njqhpstat2/CwlUf40BM9XBM3X4LN9aZ+qmzMV?=
 =?us-ascii?Q?VpTDcmYy2qET8VHhwyVirSly4S/ufDgiklztQI/mYZwqMrkrMyt3Tg/iWZ5H?=
 =?us-ascii?Q?qfFjvfczax3Wyj4LLpHfKDkSGJ++UJ6qdAvHqr9txbCG5egkqmDay+yJF2sU?=
 =?us-ascii?Q?kXtCb4Qa7mjzq/nSnyBdi4BfJCu9tPVvc/bX7wcJ7MLP78LkF+Hh10gGRlix?=
 =?us-ascii?Q?W478qkTcJ+jQ314VydcdSMTf8OmTG/UkwlFfFMxJf79QzUF7FmTj8T90iBDf?=
 =?us-ascii?Q?2yWWwE6e3FjG0aV6iNtcjOac9vY7AZhKgiXGyAiKWmmDc0gW97H6vixhbes/?=
 =?us-ascii?Q?fv+3czXIIgBPjVOuhjzWBsW9fMjCMsDyqX7oRup07HOEKLV+S/PxF3xoIf31?=
 =?us-ascii?Q?D2PoFLy2DM355Hkm+b2n/94L24bTRpmDMwh5Tz9lB+vBIL3Ncrtmg2MnNt8v?=
 =?us-ascii?Q?Xea0TmNGjlS87P5mVoaBLEE+NDLFQzREYWPxh6F48A/aV/axlfSugcON49/f?=
 =?us-ascii?Q?nEQP4pYDonJX3xrlADV4eMgL1UhFNRr2DC8tBP0YHYFBd1mUBCoxZjPlNxQv?=
 =?us-ascii?Q?7k0EsUzVgFB9EFkm/G9Yxc+AbmqpZEQUZfamYxIQ59cWUjbmPZLtNlMm0XV+?=
 =?us-ascii?Q?3r/UhQP59AbNx1hrihTsONNvPosc6jv9ZwAp/JR7ANS1f7GQU7+Asc5e1Y3o?=
 =?us-ascii?Q?LNE46fKnk/rDS1rop8Cm99qQR4qoYkVaEDurfomQfkiYxSwzez3czkUAsltQ?=
 =?us-ascii?Q?d5oJK4c2IWNgsHPP4oJutK6I7jldAzfU00gwfc3Z0hvp9k3fr9SPFpWVrJQF?=
 =?us-ascii?Q?Rq8hqranNblXeEvLn1Y00ExWAkMCV9jRTM+Wm8IEaF8nZTAHss33Ee9wuWp/?=
 =?us-ascii?Q?fJsamUqf28NkHdqRPzSQe8ME+NfObrSGbu5gUNF+JKP1STyXz0o5YD+GaR1V?=
 =?us-ascii?Q?mKTTcTK1yVliDdFOMh6bIIwCgRrwYq+lW5pZJW+hrzUufFkj0wBQZfAgPF7a?=
 =?us-ascii?Q?Zg6XKSafTxoKpysIRwxe1N25vD+SWGJmJjpk936s9qA1xoibkD9ppA7R+6MN?=
 =?us-ascii?Q?t3nI9bqjVVPUhHhg4JkBXiY0yeBwzCFNNxh3p31auLYyI94hYw5AXUhgVQcF?=
 =?us-ascii?Q?lRhyRQXMkfMTF8Or6opqgHNpo4c2KWqD4+K0Xj4eJxZ+QTfQnjiLaNXEzYqw?=
 =?us-ascii?Q?dm140B4OHuPSus8/Wl8z9LSYYpu9WX38BzIOoeuDqS/GSzYKyQR6lQ7mhg2v?=
 =?us-ascii?Q?uimIofV+hGJCwl3J/9S9g4v2m/W/RHmUvXyAn2GNqvBMjri5Zex1LgIv+Juu?=
 =?us-ascii?Q?G+YyJhnXQy/f42DcCB7cPRsOFpeif4Rcu2S3N68FeAYoiNZo6V+hPLr8UwQL?=
 =?us-ascii?Q?00BzF04cVFZmiLUsbRcP26GKnyoQLHhun5Vub8kFRDFEOFC4Zu+ZMcs5ipPW?=
 =?us-ascii?Q?oaxV2lTMVmzIvOm2fh9gTW/MIxiPp3OtyACwmfnZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1dbc6c-169c-427d-f959-08db54e9c9d7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 02:12:09.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzD3l5CzuF0bItMC7eAIG5W6l4yJ/E48EIoxXejG5O1HYvpW5cwP1alar8U+sZ0QaHCUbKljzhotKJO5Uub7fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9361

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry. We
can reduce the scope, e.g. in mptcp_pm_alloc_anno_list(), we only access
"entry->addr", we can then restrict to the pointer to "addr" then.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0b34b57fc8bc..ac68c8a5b8ae 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -342,7 +342,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -350,7 +350,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -367,7 +367,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -574,7 +574,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index febf3cf0e935..f0799cfb45c6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -191,7 +191,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -338,7 +338,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	spin_lock_bh(&msk->pm.lock);
-	if (!mptcp_pm_alloc_anno_list(msk, &local)) {
+	if (!mptcp_pm_alloc_anno_list(msk, &local.addr)) {
 		GENL_SET_ERR_MSG(info, "cannot alloc address list");
 		err = -EINVAL;
 		goto anno_list_err;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bfa7d93a1c1a..c08d05f48372 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -822,7 +822,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
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

