Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED347F6
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1YsFdmcAM3HpLXmKOsUqSOB3j8ldvKHyE2tLohHjG6pwWpQxb3E1T2PU6tsL5UeqXHemqaXpfLF/TQTzEEXDcOl/YyCKwRbSNG6wZ2o7QIlT7Gs6X8MpeUZi5sWmqpzzWP4NWQA84F35offm+88FrEOUCTe96b8GrDH8dIB7L5/Uq5kXNGsRSj6ue7Zr3mklokwrwY6uaLB8PBFAdloqpO0Cw8Jdget6Tlx7B0laFoMrk9MUVdsGv6EfK5B2xCLHB7s/BEp1/ki0ExFWbL/D/FR1w7APgT3aFeMlQm3R2DYFfdiluKmXuJ5xnLVqzkc9V8fdirSSYHAl6lkwjvG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGR/15dBZKYN8S5yrVJEJhiBff0uJ0vG0lkIkbECBJA=;
 b=QzMsnH5tnS8cYrXYGthc8jqYeIyFzZw1b65ycz+vGyxSUsZ8ZyTRIJAcviA7nRtH6laP0Lzv1wHgK5kTpuOePFlhgeloHxtrsEWNkPvWG7HsE32nYRnYDPGG4F7S9d6lQOMIorSsFOu99aY1YaSdGIc5oQyCvl2aFIpLH80NlKWo9Z+0Oh5geIqazCiZEC35Rx1VeLiPzUQAGVLCE7D6HKMrPOP/3xww+xiUhRR/8/MOEFKek5C3kDdyCqknHcYWAXq3oUtQp1QhCcauAvXlR6lVz3W/Kkcd4N51I2tohkAqPF8KlNxEWuwpSfsRa/V/Ly/vPdk37+RLfOKNzvSZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGR/15dBZKYN8S5yrVJEJhiBff0uJ0vG0lkIkbECBJA=;
 b=PpWYTdEAAvqwTeRr+Qn5ue3ILmqW36hjvSGs9fPCubMk187ra697k9Zvx/KX8+MtbITP2pVCHLG0/M8UYaF57jo9VMIZ9hKzIuR81542uuPK+rgUANyPTPI1SxU/+QRN2rT9v3ogHMA0XjbBjAIhSKkEJ9lHYqtDqTr6Oe3Qhtt2Kqwa4h5cXvQeOQdQ6ORKhh1pmX703bxCDLV7zrKLP8oJnJTNuNDV4AR4BVtlfH0YzOLInCnkQ4Na2BBlNScuMvG0qkAK2qI6kY/uOpU7f1pc4viVCZalaWBR8Yo1e/0QoJUjx9OMf/39Muj+3hOy80RZ/x8WTKYM5pp0WaLpAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:18:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 12:18:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 06/11] mptcp: multi subflows push_pending
Date: Thu,  6 Oct 2022 20:17:54 +0800
Message-Id: <599d7f22f8c154fc6ba013e5b90e3017bb60fce6.1665058388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
References: <cover.1665058388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd51469-ebea-4dd4-07bd-08daa794db97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dopB18HioaHqaYhCH4DFKGAG1VGQEtrrGuwz47wyF48WdfBzPnxNoZqw5QQC+dun+qPlLO3PseiCJyaW8MPEgeGvHGhlLcBqjda9I/wom4iurntr10gm6+Mmihmq+jgTVHFAuLpxBiYcNWqiSCxZNCLYxisH415h6XQKX/F/egg3SCH2DklqrRclm+6gg1AkkggnPvMru8Wg96APmsAfx1OnN8tHOtTML8u5dR9hLZk1gUrjIvn9xM2/oIhXvrRi6HWtNvfh3xTnrLe3kQNxDEWRj3K0apdwPCLXBVyG34MEBc3+4K7+fSIEylxsEVdBe0pWp2K8fv6+j3ODbONGAJc141mnZkR2giBC+YQY/dtUcH11GwR47gjo8FkKd94CNlVEsBUcmYNuwHdIz0hetDa9i9DEYZIwd3SdIBFGEh7IxjPmknFuvXJWTK9+VCgox/+PxfaNqdjWVNkD5wxoOdFVicALCS/70JGEfUMNXEGvR7A6UkgyZvq6OOIwqWLTQwklweywWNuG+IpFkJGFzLPZee8FNhDfonyijPBFzBqHX2occm9buVKyI5LkaHMjCui3PusHY6TApPozzUfIXRxmSPg9d7T+r76Oq9UC4XMckCIOXDSpULsBkMQWTybQXPcJZxDfTXwNneSJozPPR9v5nOipXhLGW/vOjVCIr4F/C12Yih+GLalVESReYvHi+wk+CwSeahNrlS0OMvMT2jp7YMgcYSVQkVxq6aBp2RQRXFc+ag86DNFZ3ETt5fOB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(6916009)(41300700001)(316002)(478600001)(6486002)(38100700002)(36756003)(2906002)(8936002)(5660300002)(66946007)(8676002)(66556008)(4326008)(66476007)(44832011)(6512007)(83380400001)(6506007)(26005)(6666004)(2616005)(107886003)(86362001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JWo83Ypfcd1RgStcMbiOc97a9H6TyvAQJESdHnXfhKr0PGmyPQAmbN6CBOdd?=
 =?us-ascii?Q?QonZkAjGVFinM7jI/jm4S1dOuyodNKiHSPIsMbXjQU1qTby+RPcsWv5aIvF+?=
 =?us-ascii?Q?fUhfZFirqih7baHoQHluDddTm0Vxtr4w3B0sqWPvXyQJJMtMdRW7xYrYztMV?=
 =?us-ascii?Q?XdCzn0yN9fLC1Qwb3oDMbJxj6+OUbJGiMEsn7JzL2P9vdTobGRDMNCaC7RLA?=
 =?us-ascii?Q?jt69maIBl4cOduWjSktZFTA/l5HbyTiGlHf70dGdhRG/xG8U4voCtvov5UHN?=
 =?us-ascii?Q?XQ91M1koOlF4YA34FWzEjMW89mpgEfx9GWcuRsBc81VRNRJ79Tv4U4jRdPID?=
 =?us-ascii?Q?bLb9Ro2yw5jog1G+PyjU72b0JwDU0yqmVW2zyTNkjcUxlQ/beOEeQr0z98Fa?=
 =?us-ascii?Q?t0eJVpe8suMdRHDFi0XjINp5l67uKlldWOMATAHt+MZA/f5D0B9kOfOrY0J+?=
 =?us-ascii?Q?gewq64I/5XsaG3/bNkRq/2oIyRGmArDMD+5DM0cQ7WabhKaYdZd3C7HU6mpi?=
 =?us-ascii?Q?t6P2KACce/DRj8XLgZsZ1iZHLTYntLO/J1627YlxlmatOtjD4jcli5fQd2ds?=
 =?us-ascii?Q?O4oj6pWf0E7Nn5urOdzmnSoQ2jBEFATHTHQeAPOMvZTOr6YdVoZZ1mNrCk/v?=
 =?us-ascii?Q?Kxv+dRmTac7oIELXZYljkiANYPBlPZV+GLMUQU5JiAu7UdaEvGxG0aOygTMh?=
 =?us-ascii?Q?fQ7nhp7E3ZkRS/6S0nDRVuUCbgxMdJH9zLY47Bm/vQRNBN0QWwyGyRNewrMT?=
 =?us-ascii?Q?t8fn4wJBABdZDB/HDSaVH4SP2i5uBCFIie3i5SwWHm0KORMdF08+WDmL46Bm?=
 =?us-ascii?Q?6/5AzpLNcXIQbs3o6LSZ7BtMTCbZCaL+a7izKBd8thB8R02QzjVoEqKtcy8Y?=
 =?us-ascii?Q?ct0hsh0jSqk1zSvjiKsRT/ZJsZuetZxIFbO4bHJLCE0Xe43pGu9sRmhe/TWf?=
 =?us-ascii?Q?GSb+zmoDzfnlk/JUvZeYUTZTjmDfgSoltQlQ6LQN+zKBA5brwrfz7uYMOUR+?=
 =?us-ascii?Q?1iYTcT2Bf3JFcC3l5c6SYHO3YE0cb09KXmOqHWeI85TeFOBRx0JB5oThzcrm?=
 =?us-ascii?Q?P0bd+BlthJJi7SmkIlZI8xe8J7iz4mhJ+sElwGZ2Ju2m8pNmfjPqacXHX09/?=
 =?us-ascii?Q?kVSNE2vYd7oOLUB/AB5Im3QlldUKJGJR3+4TeX6n0Cemj29yyjZag0wNN9r9?=
 =?us-ascii?Q?diyG7J1QdrtxPQnCpgoQmrF349ixaXMW48Oylp9vNLI84uGNwk/+ERD/AdbJ?=
 =?us-ascii?Q?Lfl/NalV4DmtVcpXKO8y4kP65kWI1F5UZ9Vd53T1WtiHQn6ysdZw2l6w45Us?=
 =?us-ascii?Q?i5HtNHujyqbFsH8xv3uX2VCqP+k2FoqWtbzNtqm8Jr77dsFpA0qfBWlhbupr?=
 =?us-ascii?Q?yfHJ9WMnt4uE9TxSVg/lkFFKftabgbhOIhV2VKth5A2q+Y/8mP8T+wb/sYu3?=
 =?us-ascii?Q?F9icYvUEJfB0K7HaI6evM5Kf3DonQ6ozJ5HwIwdwuQh4xPTcsseRtlTGkNJs?=
 =?us-ascii?Q?bHdZleDp5jWT/gEqtnlTgS5RMwgH6N7QXu16SV030+d6jHacqKEC97NfJgsZ?=
 =?us-ascii?Q?RvGGgqw7prH4y1vvvOjhU6PF9NkkRk661M3nZ6ZLqws/KSihtn2u7m9ODofF?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd51469-ebea-4dd4-07bd-08daa794db97
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:18:21.0421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+zAm1yDjYIBaKiEUUzb70SPJS573jMMxdkrijuH/jW/uf9zC+tKbA3eWPrTuBFlaR+FdxDR6lIyKazMeFxjGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8450

This patch adds the multiple subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send() in
it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 29905214103e..fdb879e09a32 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1561,22 +1561,31 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
-	struct sock *ssk;
 	int ret = 0;
 
 again:
-	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
-		lock_sock(ssk);
-		ret = __subflow_push_pending(sk, ssk, &info);
-		release_sock(ssk);
+	while (mptcp_send_head(sk) && !mptcp_sched_get_send(msk)) {
+		struct mptcp_subflow_context *subflow;
+		struct mptcp_sendmsg_info info = {
+			.flags = flags,
+		};
 
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				goto again;
-			goto out;
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+				lock_sock(ssk);
+				ret = __subflow_push_pending(sk, ssk, &info);
+				release_sock(ssk);
+
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						goto again;
+					goto out;
+				}
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
 	}
 
-- 
2.35.3

