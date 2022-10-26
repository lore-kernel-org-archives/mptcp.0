Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140049.outbound.protection.outlook.com [40.107.14.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A68C7B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCTizEI4Gq+zw7ROoa79Zqe/z8QXem0fTifdETbfnEkm1iikji71iD55yLZA0hwNwyMDNPHX1OvweSJge7xDFbNwn995WIvt+pssGye/3TMfe7EUKH14n+sFQ0TNKbOvK+Bqz4onBAYrJEWDuL6QZE0SrsIKmMPUuyeWX/gj3Ib9prBU9smvlQP62DOKR0GYyqFWzkcxNB4fl5tQVzwW/iE7n7B+CGxKn9auzx1+ahpNU3Xz1xwReg/Mu91hwVHUtSuTsRzLIHeAzabKP5iPmD8xKsw7UC297AOgUWK9e5WLnJRozvp67DujxHpV+pUO7hRcOfgNIc86JYSYklCWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY9QF5iAszTFM/Lu7fkcGRgrUl4rViwkU7dZc8Hf2XA=;
 b=kamCjxKuDIeF2swybqrJj5aL696QhdQFoAacF+3638RYnLTuONTOyA47eGZbvjpylwtptHHHuEXJH0cyzAzuvJnR+KZyZkInq6fbg12HQyqE/+kkp/MDpgpitcO5fi12V8hUXco1bi0xntEC3KV5pzQYClSuYoaAHpaWK9yXATZfhNGRk/2rZwvHQWh0++v4hUfqODGYz/jlQ7SE4eL+SpV5BPCIReCiF9oxLfVo28gUWLl1Q91a0HbX7RIybECdNLIjhEY/+fmVp9iIg8UpxMZg9d0PsD2B78DUo5yDFo6UPN0HIZmCxoTLoU8hgTLiKYUDo5k2iDeGS0b+9yQ8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fY9QF5iAszTFM/Lu7fkcGRgrUl4rViwkU7dZc8Hf2XA=;
 b=J4HAMqY8/qhplBe4rlXpVYem50MD258gtisBO747Ra8v25ie2yHsQR5wa0VvdRmHtfJxJz+KtNHbj54qF6n7iCZl4DuPsZS4TzMAPXB+6iGI4C4rQ9Gr2pQNx+2ycDl0W52WgrTbxVL8rO3V53VxrZYGtCw9LBJGz8GmkZ9tfjH5YLdIjkIsF88YthOlsVUD/dMTC1cYwTMpbxqvV4oatAFg3/WQkSpgG+zqR6+ZXCd6Cx2HsqB3r73sVIwcuLWWkpV46hbMBEsUhOf/Dj9vslIA1VbVB45gqttb8wKzmRiwry4wemLnkShpiy5iAfhQi2spD1Y+9ZcfEj+4fjkDgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:05:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:05:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 04/15] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Wed, 26 Oct 2022 16:04:13 +0800
Message-Id: <82a3eb84087cf365b6d4e759ca016144e4002f79.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0003.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 440e55bd-ff98-4fbe-1abd-08dab728d4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fSTwR9z2xC9OJqcb1FZDW6+ou2mPJmiejNJwwV7F0feKGNEo2khSTMh0YCi1TZP9DT/BDWTnSfGZWeOr26zlTJHEoz0x7J32D6Sn48WWoTNnmtlc7EBbroK+rt+vFbD9wgaPqUnm+tTvRBWSfaS0ZwrUQkYVPQXqOn+iaEzTk4OdjRUMUjiRvzowpJ7szSlrqssY/4yAtJ0UXFrD/YkVnqgtbQ19fVlbYlKidGAN7t/S/9WbiN8f7d+RUmdmALO2hGoiFlKO/D1KmIu75jOOSgI7ythngjyATlZJN6lwdeNexJep0+efjh3Y6I79LgsOP4Gb93pXu1lgPvQ7JDsFm24mVS9HaGGZxuPM9uHnqKrkBwhdsUv85JaPcE8tWwXm5DhakB+1V2zAfXui8KZ2oVKQOfA1q0gQWM3NLvatgrpG8s5SL+hD70oRFL8O4lrf4MNZaTB6HQu1sxmzq6+ZjTwBQ63jivxvAxESvoHg4EzW/xyGnborqexk7NlTHK2QWmYL+ct0C+nhjUfAZo3GF1uNpmvWQuQFiH5rGo3QzDvhjViuVGlrJ7f8gYw8zi1j/jM9rdXlSP6hUZfRJexF8Cidc/RJEQTpLd0zOnuj9VGCJhgG/Ui01+j0G6crvjsrk6EWy5mS6FoqHQzFG8UNiNZRdGhX/EuXPpAxdc5qzeGQkIHUCHwmgLxhwD4UXNrba3EIsmJ5SpjuC4+heyx9EQMq4tEcC4afy+45gQa7vsj0Dp/orJn3BIEja8Y9vg+R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(8936002)(41300700001)(2906002)(66476007)(66946007)(66556008)(44832011)(4326008)(5660300002)(8676002)(86362001)(6916009)(107886003)(6486002)(6666004)(478600001)(6512007)(26005)(316002)(6506007)(36756003)(2616005)(186003)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rmU9tHutFXGHXHG179kbN0Bwgxn/G0ZIMktgWki++6gtv66dRbDbpEiMmqxj?=
 =?us-ascii?Q?yhLNUgvGKqmFt1zjsAhj5M1AEdfgAS6+ql/zbqzNgmbHVwOxSBkID5LSnCdv?=
 =?us-ascii?Q?oLEmwj4kom/09WxWrG7Vc5o/Jb5hzT2gdphY8gRUWom+VQsP5SPq2RDov3lv?=
 =?us-ascii?Q?uY9asrnrwq6BVQJzt3FYgchZ18838qV0I2d921t0cvP/WawlnzWrBQPL+Yrp?=
 =?us-ascii?Q?QNcoDYixoXeLs628pmJI4m7rIVbyhelhr3ZFyERvSrNLgT6M79wveoVygHE+?=
 =?us-ascii?Q?QfMDAtC30mAN5pvuRhpVAdIBKj8yY9pwHW5asdClaYJb+dIo0uwMzMdNrHJM?=
 =?us-ascii?Q?dsyO6xNnt21ILwx9iyYGV9jg3GP/BSz3r81QCTqgvHb84kXjDBkwfMrjaIaE?=
 =?us-ascii?Q?v+GaFZKymUMervtWBny0SBaDOBhXfE63AdW7vRsANlP7poLgWuhrkc0LtibJ?=
 =?us-ascii?Q?5U4Tm7LENmW9cE3LsOQSMzxOLorbWu4PNS/RndC2ZjSMkD2AA12YWuuuJbVF?=
 =?us-ascii?Q?yMAGJqh48Z7UlozEQbiDjI1TbnIZUwNdMNPQkc+D+R2C2vtF5mHtJ9+JysZY?=
 =?us-ascii?Q?6/Qhni71HVnG60v2reb+b0fAU4qAvCRwLPRUuHHShS3+1PSIzEjDlNMF4y+H?=
 =?us-ascii?Q?NdMcePOvLWEL3YV7J9ZDhd4/a5q6wqwha/tRst3c+qr/MT6Q0sFxtpH49r1S?=
 =?us-ascii?Q?1pfY+DS3KAOTKXBStbOaJGvWNLUtKkA8A6aoXlJKXiqtb5o9ZhnHyXoeGH3C?=
 =?us-ascii?Q?nsoEISeansy+uSBnbDl6AKvg2DCUk2sirjc11deirh3KVP/csXA1/B2+FfUK?=
 =?us-ascii?Q?o8gt+sGpb13Gba6zpeP1y5ze2SBudDYOksjNHdjRuhDH6rSf4uoXiciJQqCr?=
 =?us-ascii?Q?8rP/g6GSXCI/yIOyvnZS85paFglfL1LjEqTaeDWzwJPayjpRULoKAr/LOu5f?=
 =?us-ascii?Q?JKv/LgvwK/XJrT0YHxvUs4RGl5YPXL/t3lkuqmtKE+3uf55ifkwavZ62/c3b?=
 =?us-ascii?Q?CtWt4dQ4BovBWz8uTavnMq4Ei4m35n+oATfDTG+/Gw9npn8QHuPcjAHNf8Te?=
 =?us-ascii?Q?xgjxCXyZMMzfco+hjWjTN8psQ2uycGgtx3PQ0qNtVAC6g4hMJowZlhFeWnIr?=
 =?us-ascii?Q?z4eyWzY7/BkVIJDK0kNmOzC7CFuPtiU5fhzmjqWlTu6feqhx3+gsHptmtktN?=
 =?us-ascii?Q?b7RPGgsrXLWgsrNeztwoL1r1CG/bmYrGMxxNjQq61ia3MfU9yK0qmuQj2lO4?=
 =?us-ascii?Q?9JtJOEEnav39QHiMSIaRFLzXoj/Zp0WmYmc0WQHuW7AmAWrmku/t5w+JH/vQ?=
 =?us-ascii?Q?GazPDJmCHqnT4DuHfyPb4SNn+p+QZXS1ZRr/Sc+7dpN6N1mfMiqGl1GBE27L?=
 =?us-ascii?Q?7CRkbSzgHZlYgdpGByp/91WSicqMNyatDGplI31W/axFIXRNzG4LcOHJ/ANy?=
 =?us-ascii?Q?rVg1xaeSEOcU+RCxIP5byKCWVUP0/BQ6ZVvn4qkHaSLZ7k4GAMLeiWFnfHlE?=
 =?us-ascii?Q?2r3eG32r7UzIT0ugf4eOoKh4gNnHOEtMYcHtCBZhriMuyNd0CGZhiKsH+NHC?=
 =?us-ascii?Q?RFsMVbE67DU++j9I52crS/+BWMrF54XujWoQ/7hl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440e55bd-ff98-4fbe-1abd-08dab728d4ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:05:22.6792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ph9F9HMUIo15F5zUjAneXnbHKIo1UdiTKAiys1QW/EAgtZ44iz7hNt3QCE8+U31OKoq1y2y9YhbY+W59Sa3Ihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777

New api:
 - add new data_init
 - add an int return value for get_subflow

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 6 ++++--
 net/mptcp/sched.c   | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c25939b2af68..0f386d805957 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -105,8 +105,10 @@ struct mptcp_sched_data {
 };
 
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 5a910da1452b..0d7c73e9562e 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -33,7 +33,7 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_subflow)
+	if (!sched->data_init || !sched->get_subflow)
 		return -EINVAL;
 
 	spin_lock(&mptcp_sched_list_lock);
-- 
2.35.3

