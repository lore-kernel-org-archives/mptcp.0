Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E7E802
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 04:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/57DJBzmQfnCt9Hq1bEJxcT2plFBTHcQHjc3oLgywuvtwH+/RK08tMzzqOQTTNb7JcXDgHSL0dshzD/f+CO2bQgUOsSPl+gVgkAsA0C46hdCd6Xv+Nb97Klh4jWDK9Zfz0ysR0Nx+bglo3nkmbADeApIjxJLwbRcyyS1OqXS8o3NIZOld84/5QeFd8xZTeUIGSJo8fKOmYcnabuYtMaNL5CxSdAqVgY93jWdvyP6pSKhtCjsLfIlWgSLk24vu0AVfpsDqd+ZMKQYxsaEdR0pkA6zBpq+oH+QLZrjxNcDAxNJZipJsvehOCN+bsA1d20pEhOqElj+LG2VVTAOkVSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCIvd1pv+d1ui5i0WKF+4/oNiIB9EahlPifx4aR7ZF8=;
 b=cXeGw1GHH4h+UHk66GTGavfUU56aewEFbOkSjpJCHc1rxLlqbbTo4KKc50dS23QtomUsTpvLO16s1G9puDsoSgPBmxWfYNGQwpeMbO245nqTbROZNaH141uWnzLhpSA/HVaDGLVqnH1jeLs9IFeCUGOmkkOa2qVh46wXN5OHZLhLEcg7XzxmVC40ZRJUmsw7JsudyuaVuT8nrQrPvT9kU5SEJuAxyRjwSVipLh/Ai8nnYlpz0jprfwdnHI2I9wCHI3pjVnCS4L3Bdm0BC23JX/obqdNC/SZN+Frfl3D7V/6+4MTdmFqlpZ06k2sVbWH00XJE0REoEUeKDTrR8+av7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCIvd1pv+d1ui5i0WKF+4/oNiIB9EahlPifx4aR7ZF8=;
 b=oEkdSak5JFQDPw6J7BZeusKjNCLCz8DV9vz66++iBM0OyFxr1tnXu9fbSzWLKFKi1xKSU6vqknDXKKHb009hWIV69WVyMRy+j3xtcW5KAW7jOMc7zxKHDNwAWtoqO3riSGlZkZ395ns6/61my0m0Bcid7V5bKLCJrQU9EZfIN9c5Q+qLZ3p7BvV02NFY/ymRDJE6EibphMjPaZnBtfpYOiMlISmliuhoY7t8Rmk3J4rlbEXJ3a2sauTj49LSklR72jpbIgvQ2PsGaKk5dJ4dXJJneK7XxqQs0LXGztbd8eN2p5F1d6H4CEWvkk4msHOmMNkaYTcjsPyO8NDrGIAcmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Fri, 9 Dec
 2022 04:59:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 04:59:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: use msk_owned_by_me helper
Date: Fri,  9 Dec 2022 12:59:25 +0800
Message-Id: <20221209045925.20408-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: cd29cf23-b720-4e4a-a57d-08dad9a224f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UXaGM4LhQPmfQvP1dQlAJx3NvF7/LeCwN8kyb8idJWmPBBd39G8GELTCqUg7mjLjxWrAdRCUH+exjtvpRT2qyE3GZ9HNBewr6tH2iJZieVdXeix1A/P3RwtZ851HMdUKLQXnGsz+H+9IUhoxZPL+SotrueQTDfaLd5T/UJ44djp9lVSoD0yt6HXjqjayC1mlgKfCKNpXAOH2HtFIc76OfFCMB95yHOkuvsThtSOTb8LYDFJGUswb25DK2cEXp/iIeQYUAEir/SLUGlAmsE7WEpf4gE1qL3kiK1UEdamhrxdphfOutVY94fGsl4GfxnRIwZ6gsgd/1+6BH9pHU4Sdu8aDFh6XXH2wnnUltiuyVUoi6Khae4yK9lC9Zbm7k23NgywUZJudTVg7QwaCKBYHvxyMet1a78v8+pHx+/RvkLP1CPp8Tx/XobduoJ8KdOPSWueoHXpJwtq1nJlavT2x23lbDgvDKKy3kudFpdmZUUIU7/Y+D2X3qd2EHd7Ffyqx+pKqZlr4mBXoEqYBHp1T8TKHAUHPCiE7M1GbAk0ePMTixwyt7F5/hDFSFHWSHCFxsFMxSszokC3TFkudngX+vNXEM4TxOcU6yjh4kdJGTNNMaxVKKruHP0XPDpHbdbBxn3PibNYUh+8FEhD0LoU5fg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(107886003)(86362001)(6916009)(66946007)(66556008)(41300700001)(8936002)(316002)(8676002)(4326008)(2906002)(44832011)(5660300002)(6512007)(83380400001)(1076003)(6486002)(38100700002)(186003)(2616005)(66476007)(6506007)(26005)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yKb261pmLMBTZH+613qfwy4xeE0Ztyh9d48PPc5uLv8H8BP7kC0iIx3qBimy?=
 =?us-ascii?Q?Y9sCn2C9TSYLCCqN7w+jDwVBo4ET8+2gmvAg4gIoI27vWfxALNS9QeChurB5?=
 =?us-ascii?Q?ZdeNwgTwSWNKaP+2ZnruRepjMgjgVqxhmxaaAakDMQSfzOZW0/bkYYvGk9q9?=
 =?us-ascii?Q?cM02Kv7Zi6vFpN5m8FKJct81OjScenjqmUrw+eXah/zzcy5/Anr+YJCO/QJv?=
 =?us-ascii?Q?qiVNWcYOiGnBg35jF3qwfNbh+OMfTZpp8hxL2Stmy4gagodT9toHXgOaNSq7?=
 =?us-ascii?Q?bVkgYQKsUMUzU05jtCQFKpcX7mkzDMP+shrbcA+Wbb5mkAr+hJ2CkGYz8P28?=
 =?us-ascii?Q?HxGlK5MySdIbaSOHd6VYOHNxe3RvQUolr2Nj5BP+aF6h4dhtRD3bwK8idsK0?=
 =?us-ascii?Q?oegPlsIClAHds4nRwJlVF961JtybsatFSRBLa1lFEXdGJ49aG2R1Ia+84LJU?=
 =?us-ascii?Q?xQWK0UtgcRAB2dD6n6lW/FjlwHJRu45+td9K7qzMKFdPlASUcfAvleMEUSFH?=
 =?us-ascii?Q?mhObkBYHVGz/0S60XQjVVyhXRRtPkZL0Kc62fllqbJBggDVUvgt8W9EIwTlb?=
 =?us-ascii?Q?R7qv5I8PsBAwMta7Mc3dhO7YNKS/Ry8nOHcJDbpJyC81NBb9q8WUnZVVquYc?=
 =?us-ascii?Q?8Yz10Pypt9WKC+yKWzvlzaJCRaml7DaeU+7hOmpcrFyDE2xdaKNyM+jaaQD3?=
 =?us-ascii?Q?FaB0f3Yob356hmntjHGb8OjOx2ps6b21U4iQEstTlDHyiRdZCq1xkySP65aI?=
 =?us-ascii?Q?LW6MJe67UHvDOpOP5NtRmzwJz6JuaqIb/Igu0Tn42fRoVqus9BHn0a8AHhD7?=
 =?us-ascii?Q?f658cgJsU51O3/BZ/WVtsX416IJfdVAYlH7DQt3uvn334Z1AZ60lWsKP+h3l?=
 =?us-ascii?Q?T8SpqU56dvIzgxC96j/W2DYJyt6wTC5Bgg7LL733UIinZmPtDqyQpp1lzitS?=
 =?us-ascii?Q?tE4QUJ11heSQE+tzMzwMLJDd0027d9ot2A/n+1gpluxFP6GsuEXyNYRPirtb?=
 =?us-ascii?Q?hpbXZka78EIs3rFOEZs1hwylAOkWJ/002b+HZU6fRXZ4na7zhWuFWKvzN4g3?=
 =?us-ascii?Q?OUcF1r6jO/C9bV6e3sm9dIibQWRKeyc4u7XuWkEVxjDDWE06aRoPJqkhXo/Q?=
 =?us-ascii?Q?WXsSEA7p6dsuST1EzAOZ+N4opKBUgtUrGPWTw5TLqLPEjCbVXalS/0Fy1nQA?=
 =?us-ascii?Q?WOwuFxDTOq7ncfhqIJbo8pJDef8XIJ2LIrjFcxyGVA6m+9NgIKrH7aWF8vES?=
 =?us-ascii?Q?nugutxXxv1v5kbWUYgr4iXFWj4RBaffONSXrL539b1Wp4JCrq2jViC3rjI53?=
 =?us-ascii?Q?8m0+SiniN7nlo8/M0x0OnlsiCa807NHnwGKLF33jV/h0WX/Nt+pJRGUhXMLE?=
 =?us-ascii?Q?/RPTjgKR/A83K8UryRnIqXi7s1J6AovOlj43qN36IQ7OcFESCedGByDzAWhz?=
 =?us-ascii?Q?kREzEIzzGA2G+Orxh8T9fWwN3u2w6uSbWZEYVGcS6yFLMFBtIJJULNeI9Cn2?=
 =?us-ascii?Q?kk9e3B28ycQKsXYHAdj54tu4699sESad9AsIYULkOJSiiCb+8ftvz2nI0F9V?=
 =?us-ascii?Q?p0ViJl/RQPb8peF7AE2aZcGRXzcuY4MZdzW4qbHWotyva+JVN8/8xTVB4i8e?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd29cf23-b720-4e4a-a57d-08dad9a224f7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 04:59:25.6516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLSOxlC6WgdwacQ+RdCTJK3OJbSq95I6B10I0vxV7GrIpixUSv7vjzJqocP6ltVB/iZjzBolT4nW8NbWmnQabg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8198

The helper msk_owned_by_me() is defined in protocol.h, so use it instead
of sock_owned_by_me().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 9 ++++-----
 net/mptcp/sockopt.c  | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d03bdcda33e..c8d5fa039b71 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -923,9 +923,8 @@ static void mptcp_check_for_eof(struct mptcp_sock *msk)
 static struct sock *mptcp_subflow_recv_lookup(const struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
 
-	sock_owned_by_me(sk);
+	msk_owned_by_me(msk);
 
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->data_avail))
@@ -1408,7 +1407,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	sock_owned_by_me(sk);
+	msk_owned_by_me(msk);
 
 	if (__mptcp_check_fallback(msk)) {
 		if (!msk->first)
@@ -1896,7 +1895,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	u32 time, advmss = 1;
 	u64 rtt_us, mstamp;
 
-	sock_owned_by_me(sk);
+	msk_owned_by_me(msk);
 
 	if (copied <= 0)
 		return;
@@ -2223,7 +2222,7 @@ static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	sock_owned_by_me((const struct sock *)msk);
+	msk_owned_by_me(msk);
 
 	if (__mptcp_check_fallback(msk))
 		return NULL;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index d4b1e6ec1b36..582ed93bcc8a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -18,7 +18,7 @@
 
 static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
 {
-	sock_owned_by_me((const struct sock *)msk);
+	msk_owned_by_me(msk);
 
 	if (likely(!__mptcp_check_fallback(msk)))
 		return NULL;
-- 
2.35.3

