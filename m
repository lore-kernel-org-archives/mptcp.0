Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A3EBE
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J18n0300oaB204cTe18Jll2prhYaGye/C6V29ZouyvOqjWyvEXoY1Cg9pD0D0NhezNGBxv2fcOJ2tn1FiKZRiXNCdsw6xnWPgYd4dhHRWVAEWCXlydOjAsnlSQLkJSDmd9Iyf9MB7JRv7OS2K1sV0uH7qbWfldp0+yuRnksKdjknyGgNor55m3t3Qal2D/1F0gusv7o6nhx7MjmfvKyxMcGGeWmLbCKciAkpmdQ4MdA93FcFmAzvtjZSenkqdIw52iBK3m7E7iJ0vwo6R1eIqiXTBatEQ2CQhBeXcmmKJSWRXXWLb+dm+clkCSFOjJErFDVSDBtYooiGOdhnpK8INw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc/gPL1cFO2KN2cjntnDk1m/Vfm4dXxUgLhH44IWpic=;
 b=DHee5cxg/AJ9JNpuKiV5b3Bz9ZHZNyt+MWCPDpQLFjILiZlKcMpd8dUfqlDQCY0CHEyOdMMP1DzYTd+hsqiYJkiR8GvtY3dYZhPqsM7q8+L25t9yQYZFaeXjUYDIQG2O1OBhS6GzvaXhbd9b60U2twHR1u7nub7Fl9//uu2RmuAARps+X+Vu20kR57GpEm0Mw+yaGvKdSJdSJkpbKJwfOCwudpqvKXdL7a/KlVXWYIwWniACltX42t4Pzzvp4/ggP7ZKDJrIo6ihNBAMCPZupJ54igAubE+zmvvFYT6AeI9eB9eu2TuKTp4i75EBdwF3VsCeWwRQNrnj4uidZKGgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc/gPL1cFO2KN2cjntnDk1m/Vfm4dXxUgLhH44IWpic=;
 b=pgWshJlqBwrGVcfrPntIFXDJxE93J9cySKJoqKEKyCRNyNXFUDcDdxqZEz8CrYTQDQ508xl9r6qeWfmzhHm+19zY7D6B0rJK5g/ubo4tDgJ2UdgJPW8Rp+L37LQgWG0W7ktf76MG9oMuZEPo6uvqrbIwgOGXQkoYFtBzKrUhTk2C9YREgRINsXUlm52qAvcg55rkDyjSJlnS0O3fREWGa+YX7JtIJKpu0u6MDJX0TFFkx67Jp8LzfrSpiQ1Fla4UFqbKckNPUAaYORWKmRvr2FYmBBKypVDHbBOizWTZy095rfTVzsXhC6wAHxCT+Y1D/f4f6U5WYooNenL77YLJHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:02:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:02:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 02/30] mptcp: use mptcp_check_fallback helper
Date: Tue, 19 Sep 2023 12:02:03 +0800
Message-Id: <8db2c70c0f516ff32e5c1cb669b39e5a0b01ae01.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: b431835d-358e-4a11-2eb8-08dbb8c532cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gdRvTgxyTxgAQ09hsH3epH5bYvMRVHmWBLCtCYGwPuJhkF/tUYJ6rgk+VpQmXLNAGE1sJD5IKbshwOl0+UPpEASsawITFGxkZaa2jasfyfMje4KsZSBegujTxsmAVw5QJuqhUmbX93M9ladwoX+lOaskzb6igRzU/xF8FUQgrf+U1APsdhfByghm+3MxwpjtNM4y/MW7dU8otUHVQOqA5gBQoz8lqDpI2d0GKufavWDw/TVwsCpIH0CDlmTC+JQWJgja4kj5s/w0sAzGgYx45lnpKtCuSc0eItaQMVJLzg+DpXTxxd+8Q3JltlQQVgHB4T0Ogm3BZmBkSzlUlmc39Rwfjnif+1oMFgbp3BxWn90qNwn5Iv5MqOmf6Z4+mAzGoBCq2qBKPfFCb3584domxjuJrENkjQCwdP+oUNuvDrRvE0/llXbDcjdpnHA4POEYnvmTVA3SdhtLM3VTXOq4uxJv4wvaj9h7Rmb4AGzrSO8ETyblWIqAggtWD0ntbqlVUc5tIStDaglVsoYyOBkPQQhxEXaJIbg4z3eEjsFy9USuwBgGi3CTBOENE/TyQguv1CiIw07mg995KIBH3uaLQzzuME4GGcX5W1cOdZ6H660=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o4ztJ853vGUTp+Js39Fv7od9GmGlpmBYxt3pdaq66aC3Q6BhIV51K22xzVaf?=
 =?us-ascii?Q?ZcO50dHbaRhclcp3uH/gKepEKQCbh7lSzfxltDkmBzptn3COIJ15r8t3GJ8l?=
 =?us-ascii?Q?k5Dd3ggqL4jfwYQBZ4YvqiZX5OTrOy476aWXF/wGphobwFc+TUTVnsu6KJSa?=
 =?us-ascii?Q?Wn7PevDuEwqivLRqfVAHGjqLX9w1WQu/ic4m8yoBUiFLFSWPllZpzRGXVsCc?=
 =?us-ascii?Q?dTaRnP2BEeP9hyejriggRzBr/8veXL29fXpp/HPgQSHIqHkqEM8Y8BCkXWjr?=
 =?us-ascii?Q?6/ptX2rr6KJ3lbnG6M4ei/PFkBOSpejnbRRtrogYVR/bxkRGtjZmH0NWuYKr?=
 =?us-ascii?Q?Mo/5i44GF0kXLdYrwOOcnwWWi21EuS2W7CRDZqizMYNATv5sHdn7omtXnyeh?=
 =?us-ascii?Q?xNKvF7TNgR89dGxAwjcx4yyMLmuHOjR9vdx5YSWRmldyUiuLrzmY5Gr9kGC8?=
 =?us-ascii?Q?F2JhU7g8NDU10pOgYofZjW5HWdeSe19BKN3oSZbGBxs+CFSvvSC2jVV+WWPb?=
 =?us-ascii?Q?RkRauYCPZG/wkaOynSl+EbPZUCUkkXTVexHMYYd0qy35Fxb45nc/8r6GrkTM?=
 =?us-ascii?Q?Gw/2E6a/zQKBwXUisSackObaz9vnQIUTA6mfb+t74S1lTbE2x7naPsUApq6X?=
 =?us-ascii?Q?gVuh5WwbNDXSA8QtK4zf53LrUcq/TbALrsb2x0wcNF3DShpJdm5Wx5YUhgdw?=
 =?us-ascii?Q?4K042nEYCZuEBGTbsuoO0ROULEG1giMaG/GuT0Fb9ZR39jLOOffBNEY36O/o?=
 =?us-ascii?Q?kJzGSZ4EjBBtulmI5YwdId52aU/h/Ia0lagMgpR7+RrkQGA5qTUcUMw1W1lo?=
 =?us-ascii?Q?nYTQLImMtojexHP/v57+++OU0IRWHtYoxwo2yNKEvyBQ6Ev44JsbVyDr+N3R?=
 =?us-ascii?Q?+GUzbPnf7zZIscf4sK0MHRiLHDm2em3b8EXYEjghkptMSKbuxuPfTz2MThtj?=
 =?us-ascii?Q?uMFLmQs6AazXMWenjsRPdUj7Ns7FsEiELfrbAhQKsxi6LawTSuGjigdCYk9T?=
 =?us-ascii?Q?pi7PQkDfbnF9x8YQ7eDwoZeDNWjC87uGQCZlFi1D4iKTYTVj8FosqjFT/7XK?=
 =?us-ascii?Q?w1fnnIbtPoIpOQfO1FLCEC1wr/f+laMtXNaR8x9tZNezRfkOh0UTtcg3wV5x?=
 =?us-ascii?Q?gyDfFy+ZmvCCF0jl2sT/xtrUOaMcDYld2uXzy7RG/eLA4obFtxn50aHaBnhW?=
 =?us-ascii?Q?aQHqJU7GZc530LCKfaVkGKdL43FXpDq0IYosOR/OsA/iguRzFLFckH3vE5Hh?=
 =?us-ascii?Q?etcSm8XZtVjGTP3fGKFTGP0r7+gUZdYu/+KxTyTTIrHwvRajjAosWpv1bofz?=
 =?us-ascii?Q?X+8sUbnt1/KUfZe3bSNsXbmk78w/bTdORBTTkPjs1cR7yeDRhUOCLvtBEt2p?=
 =?us-ascii?Q?HoLDpY2vgPvRFquteTG+KPJo7S8WdcXK32eTQ5DBUTcMLDfov578KZBjvVnF?=
 =?us-ascii?Q?APlX/CFZ4CRgMgpbyqCIjIIZR4a9V15s+UdpySJeoghT2EPCE4CV9HkCSw9M?=
 =?us-ascii?Q?9wGs6CMcTc31mTCAlVgsErHnSoAHWs2Sk5vkiPQeeBLj90AnRld2uVuhr9mQ?=
 =?us-ascii?Q?Y5Vq8IRtYpRUEGEZ4Gkyo8EbXcoQMydBUVLlA295?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b431835d-358e-4a11-2eb8-08dbb8c532cd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:02:10.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fZ3tZeJTWWnJW/5aAt0H978GPGRG2gAwp1LOErX0o8fqEFFtILZM4Ol61oFf4fxADJtqIGtBYbc9/vm0HQiBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

Use __mptcp_check_fallback() helper defined in net/mptcp/protocol.h,
instead of open-coding it in both __mptcp_do_fallback() and
mptcp_diag_fill_info().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 2 +-
 net/mptcp/sockopt.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f67cb5596e41..fc041763dcb0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1024,7 +1024,7 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 
 static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 {
-	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags)) {
+	if (__mptcp_check_fallback(msk)) {
 		pr_debug("TCP fallback already done (msk=%p)", msk);
 		return;
 	}
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8260202c0066..1ae9fb6fabf1 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -915,7 +915,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 			mptcp_pm_get_local_addr_max(msk);
 	}
 
-	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags))
+	if (__mptcp_check_fallback(msk))
 		flags |= MPTCP_INFO_FLAG_FALLBACK;
 	if (READ_ONCE(msk->can_ack))
 		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
-- 
2.35.3

