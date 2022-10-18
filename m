Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00083.outbound.protection.outlook.com [40.107.0.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A34A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 11:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgmFRkTQw3Y9LHdOXo/SddcDLRIZndz9yCEEetYioVCDrDPvajHaLLPz3Ku50hXGi+YuKADSFJx6j3wAFeAhBKBFtp7ut7XheuwNhGc9OE5A6olfkGIVY3edAROB+qCMNYIABzyMbR6C7mA57g9NL0+FCOBe8kq9U5jfeIu4K48orLhxUpj51Gj74wvXE/UM+qye4fWd4mDBbX5XVry1nqZbOSvIFreXEePqFdPgxPs05Y8AYwNjtFUwQjMtWYVwldcUSarsTxRmoOQMl2d1AzrUBAdMBJyrAYr4Zf9E9cIyHPKjujB+LQdTVef/oMbVcPZ1e/If844exrb3aY3iGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2L5XROpr2aTiw0L3E/rfk6ZA7n9H5J/dHBj+ifvV5xo=;
 b=iih9kMLqy6BJbZHu/Df26GpioMPSy0X8prIFSb6qgcBHsEIsBJuegioC9T2oZ01g/CcTIWAqnw9IvaZsYAEX4ym/Kelm2MAtMVtUmdpok1zV+XXmL6iJ3k68H9r5SAorzPnLFr/vpG4vRGvnMvy8FFtFTwRDnjM3W9WEf42624oAYWS5emdt4LS0RbOVoJuwRfLSoE11pmRvfwnX0L+QMtb9Gyb9AEXwvVv/gbIVyRVC27bk/k/U+kew/Y/jCQ8f2I3wrhgHQsnyvnCtQIui52yFyC19UjweZzCBAuMLTfkm5FUZvuB0TTwjhEJFwXZiDSgxrXNDyA671GDqKLQN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L5XROpr2aTiw0L3E/rfk6ZA7n9H5J/dHBj+ifvV5xo=;
 b=xCu8J5FxYkediFXbITjSBkTuIYViKCzUdvAh3LT/N8kvn3JrM1kn+sUrtDNmQyTixkPYzVL94KAYrThyXN5QKsMyVe1WsIOrp80O1aV1s+oxNgzZKorA1keaRPH88vTtStA6ATbI4ajUpXePadlvaaIwrRyCZNSUU0WR0hfTkLDxBbYxH0Y1P4w/78R4DYBID5yNqGUqo54qlh/ViAOc1mPeVREvXwTYg/Kwy1OdOu3iQ+v0RVfzzhRhbYdBbANnAUcldFjD4S9LhJJY5WSlx8FwbtsGccf4Nwdtm818qLeewjy1CGWPUJ2yBbw3CN4K3UrJblZeKH9tK9C8gUNMHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 11:43:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 11:43:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 3/6] mptcp: delay updating first_pending
Date: Tue, 18 Oct 2022 19:43:15 +0800
Message-Id: <20221018114318.23627-4-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221018114318.23627-1-geliang.tang@suse.com>
References: <20221018114318.23627-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: d93110ab-fe74-48a7-5dbd-08dab0fe0920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8MqnNDT3cRsodLvhbRGoPXu0aEYXRGcCxlLy/RxJh9GrnuYGLiduN2q3IMcVCfxmTC95TOxSzO7rqqt+dXwVzTduKkbtmDOUu403INdWZwGGoGs30np0Yhuyk5Fds/2y1hQoFjM5KsOVpLNX/PjKrydgpcAPUDYzIw0vxyCWuj+fvEd2KfOhWOcYqzr7K8srkuQ4o+jkNP2GG1jhrhYJhQlvZeCbnUr0XIdii3CJFOmGl3I+uYWCwy1/73JFOTGWlurVC77ApvCf/9oEfdWuU82nArdGrDyALUF7ZZTdaKbCViDQmLu8nXNw65kEa5n/KTC0j1ViHEcLiUwCgolxpBpY+OBFr4okABSAaiEAdMVBj/vFBScobY+525bsJAwEJDgaVsSAdsKNhbAFiVMv51PG5kuhTRR5ZUCIePtHZ+iIJkk0e3iprJLrOu2V6bMbZuPplOXzWYKAmCT12hTTWA68SyDDum32KZQaEAwtkR1j9Z44UjinB1ARpqqoUTiPC7lysz/WZghZhqnswenNNr981IAaWVmi4ATFEEvGiAdnoOsmt0uwo/SePP9+Vgw/E0GRHfKBMJkUNVbmR1N6JMpijcCng4BjNDJfU/YO3usJqKclBAOpiKn0scjiseTL+0rqgNkXozAJGGpd7o/PrdpV3D1t7MOfEdN+naVVFrGaYt6a55rf924ZnaYBmslOUGbGAnr7+9FnXSq1FlLPKudDyDOmuZoMGiZkVwlcHYjMY7RvHewy/dZlSxIvBiR4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(8936002)(5660300002)(44832011)(66476007)(4326008)(66946007)(38100700002)(8676002)(41300700001)(66556008)(86362001)(36756003)(186003)(2906002)(2616005)(1076003)(6666004)(478600001)(26005)(6512007)(107886003)(6506007)(6486002)(83380400001)(316002)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+CW3Aqb64QPW0wOezJm1ZJt3kOEj4VPO5fh6TZhVu/Dkbt1FGN6VCFPMoIQ?=
 =?us-ascii?Q?/b9pn9M7YXvqrCI95N7IV1D6sSR93uTB4f3G00arJhMWPa/DDNOl/51ATI6E?=
 =?us-ascii?Q?/P1sV6YFUy5AcwU7TyqPRcGcY5Khfh1TBSqLVl4iQpqKikSAGisr9YRlQZ7W?=
 =?us-ascii?Q?FPnQfK8wJeLUgSQhyhv5rHyQhPpWb20g84XjC0d/CjtuWMzLDF4uvi5iuRnp?=
 =?us-ascii?Q?d0KsDlDENH+l1VoHgmXBJPxULHV72PwtdYlC3qVd9Yti/QLPniv5u3gnpbJ8?=
 =?us-ascii?Q?1r18BkpGKulS6+wDscz/lS+6GaPoSXt5CPDkspi2RFc+LiNOxll7glLhqWvt?=
 =?us-ascii?Q?BLL61cajZiHpRFoEF5LKpoWb04DqzFh8B76TOpwzAiZTsEjrmyB4ic+Xce/p?=
 =?us-ascii?Q?Ir/4ryWzXcrmEw/Juj5JNkKyGUzGbHcaJ2Bm+VjJfZgMysqrJut1dVa9u5Fq?=
 =?us-ascii?Q?DoSdm0qS8glisSoBg9OmaWeweGhvDTJeZMx72NiW1+4WBcputzmulm2vlp8a?=
 =?us-ascii?Q?lHhR7GyKRi5gqrkHQwJumuBn2CcK2PrpntfW2S5cO9ZmjoYoNdOKvLu7/VU8?=
 =?us-ascii?Q?wgtKfLfM+LIoj4JvGA4myON2h5W52qmKgX0hWJMcCKX85gSy6BppjwIQyHd2?=
 =?us-ascii?Q?3I7E9mpnIODiVCj/nuovWnDDBQI3xntKNdYDlpFukrRm6HnBBJ8BUNGrkPFg?=
 =?us-ascii?Q?9FYLdPaoFX4e9lUElhR8nKJYH9Hxcmr1Jnw0/UpYzd/B6nJEdZQIQMBMZVYC?=
 =?us-ascii?Q?gMdjdPiMCoh0LmahcEO3nOyIpunIyyw0YbQhPDyWlebACEqcCH6pswss9UAN?=
 =?us-ascii?Q?1wgy1B9k1xdTGFubbTmJbjdwj+SmFdd3yUm1smW1aFSr3ymuFQIahz6XjK3g?=
 =?us-ascii?Q?QoHaq3zuXseHnRRKfadNvjATU+ZY3pPG8BOMEZ0gKGbo29WndnLeqh44erB0?=
 =?us-ascii?Q?oQLkGBL40Ohybmvk3G3akz1gJP3kR67CDZxtEa9aHpKKRXv2LsBx2tQDjggJ?=
 =?us-ascii?Q?qotK/2Q4J5M9TmHJr4WLc1TKpgEgNaWFpvXScMCWQWu8qvPBDRCj/jZorxUZ?=
 =?us-ascii?Q?3OM8/0h56XZZfMJO9U3NkCGKMcI1BkYsm6I0afZbsyHYP7aHZ93shMwPmYs2?=
 =?us-ascii?Q?V3fW6EiFKeq701acojDmp7WUXP86aCeE43qycbjDA3e2F4IRqWnL2ab8H/x1?=
 =?us-ascii?Q?0quKEqEcCqRiwmJQEwUUpNlEJMMpDsiT/OblnFqt/hyKr3kuPKCpWp+q5IBK?=
 =?us-ascii?Q?uw5lbaMKhDZcCM9MUL1hYtJrqHn7N9H8BfUkO2QJlrYWbKSjRNKjuVtYUnLY?=
 =?us-ascii?Q?U+Eexf+SfNzY+FfaPsOXIQKK8scIcR+hVg6CCTCl/LJ1kLwsKk0jLXSaf2IW?=
 =?us-ascii?Q?UnBKlo04vEMuThXxC4tfjVcvMhPEK6sXu+1XZs7ChhEHhgpppmR6Ded/IpAd?=
 =?us-ascii?Q?RB8RPRJYsJL+i9mfiRDNbcveV7V205s0+QNHfnL4cQ54v1ktye5MO1yuFuPG?=
 =?us-ascii?Q?YPoQEHYbLtgI7zi2jUPdHhwZkAM5YSngc3dyOaU1m9ZpUkAKVlO33Yx03MyD?=
 =?us-ascii?Q?449PjKbXwuQbUBVZYl4T1vYZtPfF84yaXeAwXZk1/ymBZwgmCpvAz75XbVG5?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93110ab-fe74-48a7-5dbd-08dab0fe0920
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:43:55.0612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHazItkXQpPyie1aCJplw5p4Ce2b/lTWRi6qW+SZMDWeFAXNU+ZRfHwyyzeG8bCRW7EJcPklp96dNqSkjU6XvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237

To support redundant package schedulers more easily, this patch refactors
the data sending loop in __subflow_push_pending(), to delay updating
first_pending until all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 30 +++++++++++++++++++++++++++---
 net/mptcp/protocol.h | 10 ++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 23184513489f..76e8cbd1c23a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1121,6 +1121,8 @@ struct mptcp_sendmsg_info {
 	u16 sent;
 	unsigned int flags;
 	bool data_lock_held;
+	struct mptcp_data_frag *first_pending;
+	bool update_first_pending;
 };
 
 static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
@@ -1508,6 +1510,14 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 		msk->snd_nxt = snd_nxt_new;
 }
 
+static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (info->update_first_pending)
+		WRITE_ONCE(msk->first_pending, info->first_pending);
+}
+
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1521,7 +1531,14 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0, err = 0;
 
-	while ((dfrag = mptcp_send_head(sk))) {
+	info->first_pending = NULL;
+	info->update_first_pending = false;
+
+	dfrag = mptcp_send_head(sk);
+	if (!dfrag)
+		goto out;
+
+	do {
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
@@ -1540,7 +1557,9 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		dfrag = mptcp_next_frag(sk, dfrag);
+		WRITE_ONCE(info->first_pending, dfrag);
+		info->update_first_pending = true;
 
 		if (msk->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
@@ -1549,7 +1568,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			goto out;
 		}
 		mptcp_set_timeout(sk);
-	}
+	} while (dfrag);
 	err = copied;
 
 out:
@@ -1582,6 +1601,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				release_sock(ssk);
 
 				if (ret <= 0) {
+					mptcp_update_dfrags(sk, &info);
 					if (ret == -EAGAIN)
 						goto again;
 					goto out;
@@ -1589,6 +1609,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_dfrags(sk, &info);
 	}
 
 out:
@@ -1617,6 +1638,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 		if (first) {
 			ret = __subflow_push_pending(sk, ssk, &info);
 			first = false;
+			mptcp_update_dfrags(sk, &info);
 			if (ret <= 0) {
 				if (ret == -EAGAIN)
 					goto again;
@@ -1641,6 +1663,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
+					mptcp_update_dfrags(sk, &info);
 					if (ret == -EAGAIN)
 						goto again;
 					goto out;
@@ -1648,6 +1671,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
+		mptcp_update_dfrags(sk, &info);
 	}
 
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8f48f881adf8..4b11a5174e36 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -360,6 +360,16 @@ static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
 						     list_next_entry(cur, list);
 }
 
+static inline struct mptcp_data_frag *mptcp_next_frag(struct sock *sk,
+						      struct mptcp_data_frag *cur)
+{
+	if (!cur)
+		return NULL;
+
+	return list_is_last(&cur->list, &mptcp_sk(sk)->rtx_queue) ? NULL :
+						     list_next_entry(cur, list);
+}
+
 static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-- 
2.35.3

