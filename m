Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C662F29
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="qKdJvehf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5M2yCiIzeKvbXgBqUKLaN+/emfpM/fsxecYJbMQPAqHFKTVDQSSVHCir0zqP6cKxMKz/1FxREHm5IZyvsKlExiDsXn5DAsuTSMemooD+NqbLt5l8ZqPTA2WrCmDbYenmb9HPJJxTCDeNZpkciAihWdaEPw8LtyCtJ33NUOdDGICLlA+mVh2QV1TFE7fZCo+0ni+degwwkZbazVwVmGi9qozFSqvPW+GLp6+WLAXHuCnTJL107QZrckZGlrFX3HDyAI0UUtYoQKy4bi3/UROsy/947J3E1u+G7pHUSO7Adra1xoDF5mybmpphHwCRXSX2tGT2hjHucodnki8jdbS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=FYUaYi/7T7ZZ9oodN5uaISKeo2JsJ4GsN47hnOF4zsxauTQJcQGEVOzcI5CViPiVSNLDcJmjAuskdt3qHGNpFeabqoC35AwqtjiDJBd1GzFOXh0Z5AYwY+RuBrPDExVyvMAMcDoaahI3GkNwqJ5tGbev0ta5n/XE8hZkEvP3K3RIRiUN+Cv0dBdFBSKmoJYyAGWcXufEiUOJe6WIsw330mti2Hoez28FSCWcY1o3hNgu+Vhar4rROpXnIv3vD62QICiy4hZQ0OBsonZl1TA73L6ZMh4fyV02sOb8lS9z5sIQqr2PNss6YsVwO8/D7wyhvQ4361EP1grDuCJ7LB1OoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=qKdJvehfhkoXAxuVvhDoypfhSkhpC2yTnI3j3C4aBwRf1/hBfAx6AEAsV/LV48E8O2AftcHU+OlCGTRk48mzAKLICrFZ4nMW4an9OOLrsAVP4Crol91S2SPqyAQhO7jKC0OSf9ylEh9qDCU2GSuh0xt1nxgiBSJBYedZ48uJCp1dRzrd97c6ClaVkRF/xQR5FTXU4WXSIafx+cQ82iY14rtfQ7u2LejzHn5lVXxTNUWFvNR3+ho2qxE5aTAieH6Dr2HAf3VWovLs4Nn6KZVlLyGMnpGsiV2ObQOBjQrzzC2+oHljRykVzTn7SrXG1KVVMIAlfJYnps8OcrqyGjq7yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:35:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:35:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 03/21] mptcp: use pernet id_bitmap in userspace pm
Date: Tue, 14 Nov 2023 14:35:00 +0800
Message-Id: <ab20eb4c8202078fd79e2623dc5f2dca507c654d.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ba1fab-569f-40c3-2a96-08dbe4dbf651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RzPARNrrASFKClf5//kRk13qjfzf3X9SQXsdyde0AYWYZTs81/rOMg3WaVgs33uKcG4XaI4iLeI0XOagYiZdUNW7oJX6OxGsMdgXive/3S7AYxNEoJ7vaRFofAuz1OQLDd91XBWHtovT+Slm4HtTjBkT5KBSnIXuOGCvL7o7AHe/sMc3LYdBOJ+9irq01Unh1NlXBpn2FCcoJyHmANw9pmVL20YkiyL3/9wYGJUpqGX/go7vrvXfZsSIY62D4OPcQlBYRRNeW4uBZzBDaZsT8JnaFi9n7aITAmax7xgUUkN98x1A2k7FNypNaFSh7gU9kMMkEsspBtexHhM4HkVVOXLLwpxlc1YqgNZDq1gSrmP13PPDbHdiXO1dcAAT76SZcuOkmwLq/5vU7bL5VGeXqJ6YTlBt2ZBOPUrbEaRCVUfvUL6nESBV/qirbOWyN8xtl6ZhfOoFyUN7HIdEwNQITvVWe9gexTavX+lrYpTDkg5HSVm1UAAW3RHlSPsNqwj3KXw/G/g+xvrOZQov00SsO//gM7dTOVBcF4eKHjh0np0uO6zGjBaSixJGnu7fOP+A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(83380400001)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IbNPvsWEqs050BlO4odQems82uOkgBIhI2gQNuvQXC1t6VFOmWL3gJVlKrUk?=
 =?us-ascii?Q?Fjbop1lr5xm3aDXQRtlDwECeYnR9kZbGErUbVjmTxpOYKKr7RpKwEmR6Ljz/?=
 =?us-ascii?Q?1+Pv8i8RBGT4qVDs3PVmRNB0QAQCZ8xggR1Q9c75wlhuQAPhpYG4oNdTTcUz?=
 =?us-ascii?Q?nc+S35F45aSbwqd+GMTaRshjOMFS9C4nGgq4n3vK3YiLM4FMBUh2GcU2pEjH?=
 =?us-ascii?Q?wLQqBxuOs5rnJAAM2UoPs188mZT+i0R3WiOoMKh0wqKahUcFAu9wZXvsP8yT?=
 =?us-ascii?Q?6y07Rm3O4Bd1vlWLMmnWUWzXe4zhKA+VcqA6yeOh3q1LQN9pO4JBMjxF5No0?=
 =?us-ascii?Q?mGjPfpbl2kJ9XXfuBOPAv+d8UkcQXcXjBMmIzjFfy3z+xR2cToaaRpm07EFt?=
 =?us-ascii?Q?ONqPNzr6NfzmhfnoTCh+ncRNqy5xJ3RyWrjPwuvm0tJxaoQ/46vSWzPsFIG3?=
 =?us-ascii?Q?WU1JDMO+noR6gs5UpCVl/eprpBqeEN20vNSlrhWwbmE0L0lJEStn3uvfkGiM?=
 =?us-ascii?Q?X9aRetNe+FufN4OEffVEI73HKxBCMjvN5jpq1xdOyGnkkDcnrllw9PApuwKM?=
 =?us-ascii?Q?D9BjOiPCHbElC7ncGob1faINx0agHC/wIfnBwJ7M/XYbb2A3Ob3HzDyUSvYg?=
 =?us-ascii?Q?cUUC8pLV/DJI0V3R43ptxljVh1cpRdgDx3vyR6ujYzjInutUaumPxlPiaFWA?=
 =?us-ascii?Q?on4ZaEjAkOIOWwFzRO0wvyPKDMk0WrqnJFTlLsSo7ImTseX0sRWSzoay67nu?=
 =?us-ascii?Q?5eSiNZwjLzS/R28tJpD2trlfLCOsKenXQpkJ586Sb9KxwXNG+VTfjngb/gu2?=
 =?us-ascii?Q?IFbia3HMreUChrTDT07dQnYh4MOWapM7R5UZTtlo3het1kK5/tNxKSCBd+Wi?=
 =?us-ascii?Q?yqcqswsDHzx8fPKFkv/VMTIoxFNFgnb5hQhKnlhBl964S0M9FLEAO4NloTSS?=
 =?us-ascii?Q?aP065q95kT06B4kaCUrvrU6oDMnPYnNP6VYDeoP5ZUa096NKFKqCqBMAnTw8?=
 =?us-ascii?Q?hySIRNaSdSrdB2jNL4aWMuuY7L0rQDVYDTTxYskDjB8BMmBSONFpXkWub5lR?=
 =?us-ascii?Q?GyRb61LAQJnNVpTim+skCSJwjuR8hG/QQjHc0nK6C+VLHzmDzotpE9ryVz5Y?=
 =?us-ascii?Q?ffMLxrklBUiS7dI/DfArY6+E/iBdZKHcmYqa6neLmC9ThKoQyB2Nef7ipahj?=
 =?us-ascii?Q?+bdwnsbAMV9Xs4e6ZSdtTs+k0d6YeC/r6JWOHd+sUKe7++tykSahGO/D8PQT?=
 =?us-ascii?Q?H8gZSFEaTpfY6Hj5WZl+dLyMTWCJEdZaK47gfH/WlAATlznHWf4PGaDAPwnv?=
 =?us-ascii?Q?nCU9ZBeJZQ9BqFIOWrcvQaqFYCuDEF9gZYln2RIfYEXY7bdDges2MKvvgfEG?=
 =?us-ascii?Q?ALMIGLjpzRxgS6OHo0fFHM3vg5DQb/nzyq56Ie97WnpqM1yjNrHBK45DjO9d?=
 =?us-ascii?Q?exRxQw1gI7GM8qK6XbfKzgkr5700MTG7OSf0RHD+483vfO1K8xjFLgXg3LQL?=
 =?us-ascii?Q?EImi8HzWydBitl+sIHiL0D+A8ty7tKxdpGhbgKbeFdx/UyfcMDAl6h+pV+xQ?=
 =?us-ascii?Q?HsGHjv1WIUwEhA7K29YWqNrYV89mcE1iu+5RAPaQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ba1fab-569f-40c3-2a96-08dbe4dbf651
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:35:58.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: se3zVOeuf7Q4TmRtWs88yyePerTLS4VjnWmxV+bpC+j86GOqU0Nw/6TpqDi0BQfb8XVuLCnha/f/tYfYQmpwDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

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

