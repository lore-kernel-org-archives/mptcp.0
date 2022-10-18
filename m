Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00066.outbound.protection.outlook.com [40.107.0.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111CB4A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 11:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFNv7V9ccGhBP8469fCxskxvEGSs6O4k0IFle4vEchVCCiqBBEoO5lh41xYEaavRVulqHPjMq3ziGPwb1PBMAqyRgI7O3Mav02SlMxe998zFkOtldJlF1tzup5+/A0287/9JjTAX5BFMzVxJd6QUUCBsMGV93Lnd+NiZHkbOGek2YVJppydNw5ufpKYFQaZDeirb2+xaRdRYv+/gZECuA2KQR4y7KxTzlh8Zza30IsNrn70xScIg6QFGeXxTI2/BAKE6ftvc+5XR0f+J1VXJkFjSfr67Y9rolPs2Gse6E4XCBx4HOnjitapkIWzMesxwhlpxAK5Z6JY2zYmqatD66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS9/9noUGuQEd7epvYBtZxwIjC2TmplO2G+Ecyb6YRk=;
 b=FQkslVMXTFFiK5L77VKr4tQVhOXaX6NEJb5u7UPzKRo1/CijePax1NQY1missI6gvmAVgoYwcqs1sCH93cWxcC2ry2MwkQg9MbllLMvoch0oOkc4Hszx7zYH7gJjbUDBAWl9rHygI4aeyXjBobYJKyGnOqgANbpEPrXlQlUevLPjiG0cLaheOoiM5s7Ahw1znFUgSKAuHh+f/VV8xyf5kQaiqWONqiT3gaxRG3nKFQvfyFCNtTwURLJgOGjUoB3WRq8xojGhXBnL2m0w7qgewJszwJXwHMlnHxtyvlzCsv+ho+zsFZGDjOEFK0RIOwE7EjoA6XI0rKq4Qup1edKmRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS9/9noUGuQEd7epvYBtZxwIjC2TmplO2G+Ecyb6YRk=;
 b=NNIn3InqJ+ZIPXhvmcUVlbF3Cw0OGbM6kReUP9tEEojy1Eg3sRmHaLz5L/3nyplrHUvbB4i1aN8SjHGbJoGo/13ioiidkdZWysMrq11SxO8THk785mx8VQ1TQSKj2K4yv0gJi3IzWqeGuz1fkQGV/ejvji6oHaGj1LI4T8VkLmKMFMKNy97wtwSPUWqRPZPSKzPVNvxxQw1n0Kmerq4UbKmaro4UTsBo/DOylc8YlTzhNGRh3H5KNgJ5AwRv47+/aYFoQWpce+Noi8bIUeW35RboVhuPYC000C+ymH02ABHKZIlCo5HgNZaZoWas/QWNnw2brfyFu7zV+BTnK07eZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 11:44:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 11:44:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 4/6] mptcp: delay updating already_sent
Date: Tue, 18 Oct 2022 19:43:16 +0800
Message-Id: <20221018114318.23627-5-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221018114318.23627-1-geliang.tang@suse.com>
References: <20221018114318.23627-1-geliang.tang@suse.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c51b30d-da26-4cd4-81df-08dab0fe0f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QcK5pkRfq3JEO+tG14AudpVEWNQ6P6Rr/fpmCLXbI21bMNNgM/63QbrGuJ7noZ+afubj+nh7xygzN8eNMJTFdmzOANCZGoxZb4jt2oK3U1C+yazpwFQ448rscV0OQKs2m47wzT3+GcV/lMaz7L+207T16NKxnyxw7VS1bcQGnl++RXKzxItkQLaTdIwAPV24jWaRF7Prsm/HLjZPszkObCRAaeBQ5q6posza/iUMR12PrpalwYlnavD6ByHBVaIFOD0+hT/lYy2p/wZz8I668HT0LTnss29HP018wNUeTTocSq06KtdNsk41VfTZHCQTrcMq53C+rcolxp8o4qZaEYjogma7KT+/+ITv3b/Gmu6ODtlcCREMP1b8jbksMf5OmJ8T7onJiGYLnSEKyBeAcEAoPcuNTLEWHpw425ek+qhQXFHHSS05voPXICUE/KIyg5qtGSaLdsarXe3BqmhQ5fZ/JPFVzMCIvcvON3DXoHZ3jUN2eh+Dzp6qVhmJqrhxqg1q0ySuoU+CxZdWyBAdO4Sc0h+z2Mg0lVffsaih0GWbF/N0NknB+jquSQ+S9UfvgWFV6h3b1zr5OJBINSUSeVbmIefk0KH4rWOcuQZtuXq1sugdGD76ueFZomItb40x9ztk+4NeVGe20hEHOn32gsr7+LhEb4Tvt/xF7kljISDGj5Q7OHEaAA5USe7rmFE0fNRrE2PS2dvFaE69xv8dME2dDcSDpoPiOGXqlEXwbKlweAcOD2fpIo8dImXUAbrN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(8936002)(5660300002)(44832011)(66476007)(4326008)(66946007)(38100700002)(8676002)(41300700001)(66556008)(86362001)(36756003)(186003)(2906002)(2616005)(1076003)(6666004)(478600001)(26005)(6512007)(107886003)(6506007)(6486002)(83380400001)(316002)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QZf8gRQ9hWpqvAwxO6+QTaWMmvqp90UDT35VCVXPEff6Ta3IsbgTDFKZK5gQ?=
 =?us-ascii?Q?fL2ISLC8FSgXEzTDlUxg2bC5MDSnolSabvbG4+EwvBpL1RCRafwPAYqAKclk?=
 =?us-ascii?Q?jvOj729VPQ2owjl47exynUpJX0Sdoy0fUl3eRlDX5i3bEAD0nWgjU1s3/KsM?=
 =?us-ascii?Q?LyIKT9u7ZgGaPHS52LAFzKhY8QUSwKgwvfASKLK51TIBHfa67naTobE2o7qy?=
 =?us-ascii?Q?35no9pBrU257np8avNBx+pRLEoBlcUQmuSad+sOOWT4BWGF0j+5EhHmyiQo7?=
 =?us-ascii?Q?o3do2VocYRDVzDkixrHzoPIvutxYdwMfTg6+fnITguEEMm3KdFM/ocoCxArL?=
 =?us-ascii?Q?F+kEDa1kO75R2vTgQEk2eLdJqvx/lHpVkiMHMyboNv/Q2GaGdWLwcRq7SsBB?=
 =?us-ascii?Q?4TEpKYwQiQRsiyly2B3XeTqdgiVoG7kxzOmH6fM5fxOcqeWTzOBYuXsQ6N7+?=
 =?us-ascii?Q?NwKx2YEHdGVjuoDvcadO+9JABtkTpuBKFLVg7NdSa7y7W4sMyIz/UG2YqUSV?=
 =?us-ascii?Q?CVRp/QmH3Ryjb+svrE4IuJ9eYe0jWRzx11LdNxEaAAJ7TSHMITp0FjXbFut1?=
 =?us-ascii?Q?CBAtahWZT7xmT7hixSyu56e+YndiTscq8z3xZTl1jLRGiN8Te9dHm7n4LX9h?=
 =?us-ascii?Q?h/lJUWveQL7AeuY6zreF7HIdLxiolQiWWTywJMjXwPuPfl5Va9xxR0+2wsYJ?=
 =?us-ascii?Q?V/MYL/Mlv7IsfQjYVg9RvxEgx5LgApRtC6xR9gweIqbwo/zVSQ1eF6j3PGFx?=
 =?us-ascii?Q?Ko/QATLMyOFXG9f4CvG2sqgb6cxofLONLWFvxGKcKYi283qe91yFk+N5q/vW?=
 =?us-ascii?Q?21HQcWCW9aHKoq2E6Q+yPZpWpiJOlgaHN7UCkWef+g7xWMTOXSdZI8t18Dun?=
 =?us-ascii?Q?MP7QTSBnIIv0uLxvtlqbzF5GqZ5FseCIUJMJTWjkTNWu3cRVpeoXJ6pr0j4j?=
 =?us-ascii?Q?rDvFkO7jH0ugfXfQBmAz/akZ2JZFrQvTLimsgWzVs+ehLiFzmkCkhL56itvi?=
 =?us-ascii?Q?HnEAZaJkyZXT2BeUl3QghnHhrRoLUWFnc7SYYurPHKhoBKxqkqYyNjv1dko+?=
 =?us-ascii?Q?8oC0YU34yLeftbfEe7WGy0vwQNZJi0IRpAHz8w5fdE5YCfBDwrOmpSiigaKt?=
 =?us-ascii?Q?YkBx5965u9zpYjTMQhB3DKvolEsfClgEy4+/Z/dsB62I3Hw2DhcumP8ccqbK?=
 =?us-ascii?Q?j4G0lR1I+Od3uieeI8dBmEAxUZmvyT4w5XdEu0bLSjDysdBZsdg9wnT1NLjn?=
 =?us-ascii?Q?HS1niObkd/6/R3Yrlvyhw0Fksh9i0qLNEPHRJhGAzFwp0V2yvpgnR7RAFsiC?=
 =?us-ascii?Q?Fuba6o6wo/rVjgIbe1TJLnIWZ8zcd56JM+xtvuxcGA+iuY6C5F236dpqHpc3?=
 =?us-ascii?Q?UqOOFt9XZCYcCiNH3Wan3U5N42UK4P3nA/X0FmJ+xKlTh1tT6ccDYFSMxEo2?=
 =?us-ascii?Q?F8SsM+KkU2RqBNeRslq8YmnmjkAYLcn6PS6vZOTTl+7mTN6rrVYzsErcqdZ2?=
 =?us-ascii?Q?4ZnRTwAQjB6rOLL1m2KQeASlVK9cmAvZN0KJKjOOlJQf4DuRtUucQBPxuzED?=
 =?us-ascii?Q?qflTmL3en0qsewZwD9YhlFLqi7d7U0K6CAdzNjvQqGWy+rsoMq95BdwYsiWx?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c51b30d-da26-4cd4-81df-08dab0fe0f18
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:44:05.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yx4alRbu2Uy6YhBAt+I8e5KPNz5aPB5945MeIS+Kod9BE9n42NDZnigtYPEmiR4UxbwW8AR9aAYm9JaehiMCFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237

This patch adds a new member info_sent in struct mptcp_data_frag, save
info->sent in it, to support delay updating already_sent of dfrag until
all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 29 ++++++++++++++++++++++-------
 net/mptcp/protocol.h |  2 ++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 76e8cbd1c23a..5fa2ab374a3d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1109,6 +1109,8 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
 	dfrag->already_sent = 0;
+	dfrag->info_sent = 0;
+	dfrag->update_already_sent = false;
 	dfrag->page = pfrag->page;
 
 	return dfrag;
@@ -1244,8 +1246,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
 
-	if (WARN_ON_ONCE(info->sent > info->limit ||
-			 info->limit > dfrag->data_len))
+	if (info->sent > info->limit || info->limit > dfrag->data_len)
 		return 0;
 
 	if (unlikely(!__tcp_can_send(ssk)))
@@ -1489,14 +1490,10 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 				   struct mptcp_data_frag *dfrag,
 				   u32 sent)
 {
-	u64 snd_nxt_new = dfrag->data_seq;
-
-	dfrag->already_sent += sent;
+	u64 snd_nxt_new = dfrag->data_seq + dfrag->already_sent + sent;
 
 	msk->snd_burst -= sent;
 
-	snd_nxt_new += dfrag->already_sent;
-
 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
 	 * is recovering after a failover. In that event, this re-sends
 	 * old segments.
@@ -1512,8 +1509,19 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
 {
+	struct mptcp_data_frag *dfrag = mptcp_send_head(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	if (!dfrag)
+		return;
+
+	do {
+		if (dfrag->update_already_sent) {
+			dfrag->already_sent = max(dfrag->already_sent, dfrag->info_sent);
+			dfrag->update_already_sent = false;
+		}
+	} while ((dfrag = mptcp_next_frag(sk, dfrag)));
+
 	if (info->update_first_pending)
 		WRITE_ONCE(msk->first_pending, info->first_pending);
 }
@@ -1548,15 +1556,22 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
 			if (ret <= 0) {
 				err = copied ? : ret;
+				if (copied) {
+					dfrag->info_sent = info->sent;
+					dfrag->update_already_sent = true;
+				}
 				goto out;
 			}
 
 			info->sent += ret;
+			info->limit -= ret;
 			copied += ret;
 			len -= ret;
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
+		dfrag->info_sent = info->sent;
+		dfrag->update_already_sent = true;
 		dfrag = mptcp_next_frag(sk, dfrag);
 		WRITE_ONCE(info->first_pending, dfrag);
 		info->update_first_pending = true;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4b11a5174e36..5d3e100f03eb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -243,6 +243,8 @@ struct mptcp_data_frag {
 	u16 offset;
 	u16 overhead;
 	u16 already_sent;
+	u16 info_sent;
+	bool update_already_sent;
 	struct page *page;
 };
 
-- 
2.35.3

