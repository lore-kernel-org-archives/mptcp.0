Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10042.outbound.protection.outlook.com [40.107.1.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD833D9
	for <mptcp@lists.linux.dev>; Sun,  2 Oct 2022 14:25:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5Hk+n6AWmT+ZVslgK+hWbPrE1YGDyCFAQu9ueyIHgYTSJI9+liTnyk6wwGDqwIyekAsrqW4tjFLJsO7ky3XHwK61iRPXtP7v7laI67oNpk+9+kdyAAMal8ul/dNyNMLpHXv//Q8ipCk5OFYLWQE+g3+ARyLH44462DX3jvpfadTgGRmeOf2KN+UxDIcYUPxo/I16lh8ILu7Aqu1NEKyheGAmlnxxNjLuieafNhBg9roDZCEaFThbs3jj8Zg5JN+HHf+ocRr3byiesGsZGaMeft/bwOVszQqQ4Gb+L43/GNexuxiJwL6FfXCJW7JnR6wIz2LjTw1dMy0Ls03n/9ouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlfLFQ/0WvsjjE3Sg8I/7t77IyqkUvNdF7TCe8ix2wo=;
 b=OYBTd/QgcqkXg9x6MDEqvgVDM6SZ1qweuGD8Nlvct5THT73O+gp2L3qDmvx9XOxQk2aKBjFESVgjrQMyz1ZCpp07asOUl0o5kVPUp7spjMPALg+Z8NEx1SMUgIFdzOJM84My95ajXuRDQUbfmaHhn9SiXfP7eQMQd8DyGnuorjIFkmsqZ2zVUKDr0TyLEkOUFtYh/38UOkMk+sNJJ4rUsrONczR3hbupu2xP/mnwrziC/KfTh1LpdCH5h6PZgL1gk8Cr0Ie73yxrgH5N0rE1roMmjeqrXBesUBJQ/ig1Pip66C1ghLTXqv537ew7wuE9L/LpmzfRM8UyoaX4o0cngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlfLFQ/0WvsjjE3Sg8I/7t77IyqkUvNdF7TCe8ix2wo=;
 b=qKJ0Q7auhqxO12zew5x7s876kN+Ilu0Sjg7QjYhNKEsQ6PaBD6XpuyPRg9XWiVekEAjl3Fg9Blne4DgReDi8+E3LTQx/0Dycv6LvnMVhpaA6QJONaDBStLL0fSj9Np6W7qdirtZoDp+ugdBJey1Uo2jUUQ8BnmYzr/i+et1viSDRpSGfpUhDa9yoAdVc6iPSOMKNGuAeNRfmqGNuuYjHItfFzU5PSe84iOKFuT4O/SuGit4vf/1f55FYwwxn0XpWEbYlA3w6z+iZZkf/Kr2FVbnx5gZq+DAhqv4L5ZfKlSDhy9grFkt6MqTqnmp0jfqpX5GFlKcjrCIYaRZ/Scewmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:25:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:25:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 09/11] mptcp: simplify subflow_push_pending
Date: Sun,  2 Oct 2022 22:25:17 +0800
Message-Id: <d6960daa861daa0997247e85d7d5adddb86ee52a.1664720538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664720538.git.geliang.tang@suse.com>
References: <cover.1664720538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0108.apcprd02.prod.outlook.com
 (2603:1096:4:92::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e946498-6d8d-4515-b4bd-08daa4820458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WLwXsOVh7YsKql4TvbTZAhrjmFYfV/q4Xesp7O1g8VoqiW9DUXSr9D8WzUqBtgdg8VqGXlejo7tIDuezfNi4xka0zARmPIpcW04QI+5MgZI6BWx2TZsydkRMnBwPTOG7IJqBdzSCOKgE59U/TKm09t2Jmvvv2bFHzQdsSjAHYR6KIPYsKvgt7WQZsx7tZ8jt2GLBlWke72QZm4y7AG25/1mek84VYbPk1vuM1+7RRzgUmP04A/qcxHOZSz/oL9/qyhtzfueSRI3hkUNJD9B2uWk051bcnp3nxRs4RUCKjhZBSNFLJY7jiyzyt+l5kB8f/tXI0+JS1UW/QK03YUI5zlUrOEMDXCAWEhU67VkULF99KBg70MQ3WXIuG9EgERf2I27t0VxD0IN1mPDXkAwuj2h+qv8fyBPC8ZlvKTl1rBtixxEGDX+lYpV2kESQlYh6+43B+/LLflHRtwqYkidMGaheim6rvTXCj9UpP8ZkO9w5ytIB7IZ/Dz70AUh8s+Cy+OWGMu1EEl4puF0lrC4TtKGmmxF5IsqNgjTM9ZVDiiOFyzXwedOp6BQVe104x1HDG9XO77p2Sp38SEBqpMynVcXM56KpW/DdCjWP7zj05yDKIU1yNareTKBGx6HF8wcyS3iCrhQ3LpwspzM1QvI2+vh9pyUFLzkTrTe117j3LHZo/C7zDNsl6XeQcvpAijzE37ijo9QUhyyhPyogyjKX4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39850400004)(346002)(451199015)(186003)(86362001)(2616005)(83380400001)(66476007)(38100700002)(66556008)(66946007)(478600001)(5660300002)(8676002)(4326008)(44832011)(2906002)(8936002)(316002)(6486002)(107886003)(26005)(6666004)(6512007)(6506007)(36756003)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RM1bsMjqLmwAboS9MPkKhxoh93UcS2+Ixp1C1kQmFm7tzGMgqlPJxnQ5HdSq?=
 =?us-ascii?Q?kWiARzpdBPOVvZwG9+cmFWKx/7mrnd70G/B5sybCBg0TpcXRyMHBSqZUEGtI?=
 =?us-ascii?Q?lojZu/34LnZGbpizmPCldbheI/wIzNl/W0dIL+jjIT28ebYWGZnAQRhh/67T?=
 =?us-ascii?Q?C/ZgQyTKXvtSHpLAZIBLl6ACAQb09E5wC9AP4IxN0wKnFCn4+NBKJXOMErfF?=
 =?us-ascii?Q?JLjEGfkF69TLeFZiiTAH0sTf60qbVNn1+DwvOboelXT2QoHhXYJ/kcjwq4rN?=
 =?us-ascii?Q?ZTlOkphaYAgdKIsODUkQpmJkVIbAnaWx87PL4+e9mm9hkoJqliKsFMw2bQNo?=
 =?us-ascii?Q?/y4yQp8HZOnndce7/YmcZeHWVFnbNLIYhUdZ/xwhGjDOCC/Omv3uMpqjQBPy?=
 =?us-ascii?Q?MRPJCkTMIoYniifvKpIGFL9n6rc7lWWNGK5ptz8hw3OrlyNNLxUwOxTimEva?=
 =?us-ascii?Q?OHcl+eUYO0toRHAR9b6FtGWQvY6r4KkW7424sjectrJoukd+BV4CW0QqL+Ht?=
 =?us-ascii?Q?XRmMxR0lPdhXX6yjmZlaSLQvvAuaVpQJdNXlUVhip1PM/tHBxMg1ethcCD2W?=
 =?us-ascii?Q?zZwf5uOURrCEgbtTiCLRfYDhctP9VJ3Ynjegs8RcWeUrjRSHIhTaDgAurIwg?=
 =?us-ascii?Q?K/lWd2k2dnKfJs+BGTyWAfBmltUM5LmlmN/WaXSMP35Rb/g244n0+dtEzaoZ?=
 =?us-ascii?Q?3SyMYF+QHqY+SfXpP7g+DaB0FLZuqm8guj2yxdzbOiTVbYGYVUVjvDDu6Li6?=
 =?us-ascii?Q?zPx6HKTjaRYVGWHQ99s8PiwOa6gexsdjdT3l6FpYAmJJGtgssD6lvHjauFs8?=
 =?us-ascii?Q?ODo+4SDobzkSra9LV3ljMQ29DMNjw70C2PuQ1A4YSmlX/8HxRuFC022rye+e?=
 =?us-ascii?Q?C8Iv+yNYU6KiRGCQFMpTcAyLm1stkukc9pCwbIQJgxu7q7jqczaboa51l9HX?=
 =?us-ascii?Q?XG5WmYVyq8fRDDppYauMkOSSTJKRXEGrUBX2tafHXKHzHOVz0TcGkwdwXjOy?=
 =?us-ascii?Q?4zUAqb1a4/2nOdQw/z79nU0mW9hZJ3L7MnM0WvvmfSBTH93PCiTqXPTLPMxz?=
 =?us-ascii?Q?G4i7sdnerjdfItf8WbO5WjhRCBy4dRl87HiYZ9B1y9ZR/zcXiMiJmw0hNuHA?=
 =?us-ascii?Q?r/nOeuoJIhs/J0S5OXdqVi+SYWfu+byM7Pgo79L80I8Y4alZqXthH9jnYlDH?=
 =?us-ascii?Q?IuTbivLsLk+RQzapaWirfjRVbhwANlupwtiWmT30NfR9HykVR4dv8tyZnuW6?=
 =?us-ascii?Q?21ixpAZe6CfV74mYcKSwcJpy4fLbtwcTtanGGxn1FDT9WTyWXfukj64AIftD?=
 =?us-ascii?Q?pBP6pivfMTJiozwgUHK/IlBruui+R43ObanOeBTDZEVIp+FUeaL6iB69wqvR?=
 =?us-ascii?Q?J28o+8LhruXaquuyN87Meui1xi5WXo0KTFhrrqAl/OujXKWVx2pIECVAOyYH?=
 =?us-ascii?Q?ok6wYYvZ4KGfLmjwZY870rdntC0X0c3aQzA93sSjT1joN/nDNkRBPtgpzJ1D?=
 =?us-ascii?Q?hbcGzXJywewyACD6V7i3D6h3fgU9eknW8MTVl3p87MPB/qRuAxwdpvqaQqlk?=
 =?us-ascii?Q?W1UpKR/Q/KkiPVmlNOASoOXe/65x1tiwr6/3YH/D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e946498-6d8d-4515-b4bd-08daa4820458
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:25:55.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwN8mKb8yp24SpS6pNXLWla0sA0xKz6q+6NE+0YNrJDsDGMfq1KGPChPHO+pp21kKRZ6ERIwc7mR9kMJ+BNemg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

This patch simplifies __mptcp_subflow_push_pending() by invoking
__subflow_push_pending() helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c036a788fc27..439af075b144 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1596,10 +1596,9 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct mptcp_data_frag *dfrag;
 	bool first = ssk_first;
 	struct sock *xmit_ssk;
-	int len, copied = 0;
+	int copied = 0;
 
 	info.flags = 0;
 	while (mptcp_send_head(sk)) {
@@ -1615,33 +1614,9 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			goto out;
 		}
 
-		while ((dfrag = mptcp_send_head(sk))) {
-			info.sent = dfrag->already_sent;
-			info.limit = dfrag->data_len;
-			len = dfrag->data_len - dfrag->already_sent;
-			while (len > 0) {
-				int ret = 0;
-
-				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-				if (ret <= 0)
-					goto out;
-
-				info.sent += ret;
-				copied += ret;
-				len -= ret;
-				first = false;
-
-				mptcp_update_post_push(msk, dfrag, ret);
-			}
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-
-			if (msk->snd_burst <= 0 ||
-			    !sk_stream_memory_free(ssk) ||
-			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-				goto out;
-			}
-			mptcp_set_timeout(sk);
-		}
+		copied = __subflow_push_pending(sk, ssk, &info);
+		if (!copied)
+			break;
 	}
 
 out:
@@ -1649,8 +1624,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	 * not going to flush it via release_sock()
 	 */
 	if (copied) {
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
 		if (!mptcp_timer_pending(sk))
 			mptcp_reset_timer(sk);
 
-- 
2.35.3

