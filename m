Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E335C7C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdF1tSBfhoi8FzuGgVU8cQdZPrAj5UatzDeeAAQXe0nLNY5Z71K99QS1UmJ+BxntOnkgGhyzff1WeW8KMTNUb1TDbLFhtG+/n+8gsnUYK58NZRRlVhEbtSWGflxK8nHH/V5IbEqkplPQiqnAG45zyDG2wEwIH2G2NiPqjSVG6OS9nRxQLGbTJ82OPLq/hrFr6etUkxVOCzeaBDCxH7Thu+NeNletJvnlN+XKOw6uVFQxsC3IxViceQsa+zjQvEJuR8PWP+1YclJPZiYPEz1q8I8FzfInk/OvPmH1VhxXsOMFNJtotUjVJAvijvR7GlTCKFH8xJq1H/QCV4NAfVoZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY35CjR36XFstY8WAoatp8oyi4y3eRT9l9RxjIh7eD4=;
 b=mAmDwrgWWBHuFV5gSMOmbrljEEVVuUY0S2eCVku9m+vaQ6RbWTeqSVrU4LvrzPVzcCb4bE7+EpYsnFRU75XhNyaQVycncS3zbH+7spl0E+IO7h+gLs5lMtPSN0SAwPGcSfpgMzpxqFMQQ5iEVfN3Gp7cL9GDXDWvOhBEyZ+xxSDV5kiex5q1b20kmFLeCxsgNqSqj2gpuru3QPJMTDIhgHp2AH7J5l2SsP/CXE68BJilXRWS+KyvyXa2P92gl2IJ1SvWznLHiEYAfY+IQNdFgVBVRXxQOB1ng4xE0iIFO/PlrQ7vz7E4ZkkZXy/HyxCykeBy3+hqQlY9gpoujxDT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY35CjR36XFstY8WAoatp8oyi4y3eRT9l9RxjIh7eD4=;
 b=kzA7W1JuXu6iDF9nI023U+rxUSHss6zoiYWkAslGU9phSU3hEPvOz72Rrbbe0qwEJuFmS5m8BFTmZ98xZi6uhuSc+NXLvL/Ez87ARvcO8fScWAlPvC0nvhmP3p5568t7lwqCv4rNzRuTJcCIJfEsjYYOmnWvVoxuU794QZKIFTRQ+TDWEuUeoO/J+WgI+DSw40U/xOCn2GwLmsR26RGdPBvBg9JigEYTXrhn8n6YkyAEUUQK1mOSMTR5G3bmAgBcjSdY2TDxHczYz1LR1occzw0uaymOuUJ55w5jXHh1Wqi+HEXEMHlQWhvfZQPbwRYiTx/Mg39eevrSlQ1cGcZfLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7153.eurprd04.prod.outlook.com (2603:10a6:208:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 11:43:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:43:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 5/7] mptcp: delay updating already_sent
Date: Wed, 16 Nov 2022 19:43:06 +0800
Message-Id: <863432f61618b8625948918365524c9bfa9f9aed.1668598782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668598782.git.geliang.tang@suse.com>
References: <cover.1668598782.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 14791222-4aca-47ad-f0c8-08dac7c7c9a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UNd4FmAUd0NMCxCEze89mtk5P8T22LZRi/e1jfqlcIKpGLG3Dv2tRLUHXhuFRSlY+VaVZ/Fc3HTQHx9YrLQqG/yoSVtk4xyCM3cbYuHIGOXLAGKXqWVY0ewAOh7j1lU9cAFLbSCga3EChblCKgcKXUQ7sXmIafhiY0LGorBHZcoMuukvfqNUwx8lPkqsh61q+8B3BYLd2gGlmh+lyYxLHS2+OYVfO9x1QCIYhY+ruKZ2Cu0sK008zPmFGuJJqi0ENc/dfUxqT1m3QxZ0pFhvoD5Ycfu4oCmzFGpGhJAWrB6WE+pyDdbVAsnznQGQgfd1DZxtnryKi3rOsiAXDGPgcUg1RA7qO+7E+b42hmC1nDOssI/O5bOoFUb6cko1ZRrpSC8T/WcZ/ZTnBUER3CncFGuzPMEWefELw9EM09uK7aOF3J2bqyWIeKbDP5vwlcqVFaI9cnf79swHv9cd2FzjhkmTxPbylJe1QUoOTPK+JvYrYQc1zRyGVi5CN2Pse7HcW9/KmBioChf5ex/5BdKdG6+sHBXjAuiC5mDq8DrUOgIKU2LNi/L5enTyZSvR7Uo0OdTiPh7qbWSMCIMJI2I67qXX7QUt0B6XxwnUUO0N0pMzYgqfuRIAF6el26vkRDal9CTTor12LFWTlYYQ3+0ReNksn2/TZ8OEW8hkQM1/P5L8YWQj3nRoGF6C+Jws6TYOVPeZ/ld9ajJZjt8YwCWG8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(86362001)(83380400001)(38100700002)(478600001)(6486002)(6506007)(66556008)(107886003)(6666004)(8676002)(41300700001)(66946007)(4326008)(5660300002)(66476007)(316002)(6916009)(2616005)(186003)(6512007)(26005)(44832011)(8936002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LyYY+m5d/PMS0LRQt1pP/LabMgi3U9dlEY36Aw77cqRI/Ve7Qa9dMLyvjwB8?=
 =?us-ascii?Q?3pNx9hkT2++f/AhyaqrhVLfVX7ZvWppoE/pNIQ8YTWDblGGue+Oed18I8A9/?=
 =?us-ascii?Q?06X5Yf7OEKy5rOYthw8whQHvXLNxTwNgElluntmibJxTs9RwmuS/Hxg6kl6o?=
 =?us-ascii?Q?Q3z750hROmE2A9VBW2KqdhWpaY55QsgcvFSms3/mS3OPCrYs2NSnwYZaLxpr?=
 =?us-ascii?Q?2yyGMUR6a+B+G1/qQUmPItJN4GCT0hxQVq1eT+QYbo7Dem5aciqhdd1Pmmny?=
 =?us-ascii?Q?Es0cuw5VXW84eDozaUEc1+ZpLoziOyVMYymlM9H/Va0TRU3YY6qTQgl9GbEx?=
 =?us-ascii?Q?sKXb1Q08ocepl+WU+IIwBF8A9/4Nb6unOhWuttDaWlcFeyx+lxHFPL9s3hW1?=
 =?us-ascii?Q?qY6Z2PxXQnkoewtvpA9eqbX2U9sCaODhMKn0xt4RoNSToVXEZmmXzaSwE9LG?=
 =?us-ascii?Q?LH7jG3DeFMmkLA6Qz0iscwtmJhN1av+NP6bNvgZYJ6TRRFZN6BgWAiaELBfw?=
 =?us-ascii?Q?j2u0OP3Ov6qXdKAtlYMp1b0pgmmx2idzSwIq3quYloHW78YgxskvZE6DbiYw?=
 =?us-ascii?Q?oLCjPYepqc+XriPbAzNIEK580nQR4ejD8qiEUOTRwsH+FqUxHf+SGAvkIU6O?=
 =?us-ascii?Q?aCokQKDj7i8FAXNygGgyRtyxqwkCu+V+1mfi1gPERLA/vxvpL82PcF6HlYKa?=
 =?us-ascii?Q?ylaOJ3fK970aVotS5X3RwQTDOCnwTORepjHczAy+xXdWs8iiaO6VS4wQ6w/z?=
 =?us-ascii?Q?kqkHWjnKT2C6moF7pGZvT+aGhxsNA7yVwRQux8F2HaG05eqscbYKUB9oCKe5?=
 =?us-ascii?Q?KTDDiYf4pSUdfSq4O+mpGp2bX/nyo8ewLfBbQ8G3/SGJmwK4PAQYQ9WlZsql?=
 =?us-ascii?Q?ZvA6L8Sfv3/rtaPEKaI5RkiaKhAW+6K/Do2afGu+N0WuRqU8JJiBEmhVx6Zx?=
 =?us-ascii?Q?vrHYcAcgiUPS9cdkpEt5ozX6jzkve7kRnjEsghIHN3iILUKRCnvMf7fjC9/P?=
 =?us-ascii?Q?OTg5LdJuVBSfprwElfOAYYxV3Wxsa33VgfK7EPIyzucNz3HL8J9n2yjApBCq?=
 =?us-ascii?Q?SEFXUw+oHJ6j0yieVywp7XZlrmaPr7Rqj4b3rnyI1n8RwxQm2J80aMqA0nbW?=
 =?us-ascii?Q?N+8/3OkNcdDtAUPPax4kaY7+yHAVBi2aMYWP/4hzun3oxCRVKuUhoyYNzMm1?=
 =?us-ascii?Q?zy+VFHUOO/5UGutoGB4H8nOQL0NCziKtEJQ9UGRfLKZmJJIhDlBrs9qe/rTe?=
 =?us-ascii?Q?u8z/OYq9XuPMJKsVY6mFrHvwInmpn3CIHbEouJBvW+23Rlr0Tp1chjf9hMUl?=
 =?us-ascii?Q?ceWOoo/tYhVks/if9H4wMsa7IxzcUw9w47nvnz+76RZtZymCJCUEVdY7tbvt?=
 =?us-ascii?Q?mmJdvaueiyHmVjmOkw6++CWdcAEwA2Bh/e891Rn8ud4HXY1ZScgLkhYafKLy?=
 =?us-ascii?Q?ncavIU4qOJ30WnO+Mf41FbsIEN5KdehuSiZoJGZB3YKnMvYXIYMpPY54NxBp?=
 =?us-ascii?Q?rqW1DETvqK4EeXhtk3RdA25oGjW28JCM0GVVF0weQVjlrR3HtxHCXdSxvD1f?=
 =?us-ascii?Q?DlQHdyfOnbw/t03rUY70vI3b2d6jyn5XDowQXzHFpnMUDRrqX7ZkttCjDtnh?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14791222-4aca-47ad-f0c8-08dac7c7c9a6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:43:32.2864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHZVdz6tb1YBnQH4Nf8VMjWPIT2TnLm9azBTKj5ARdXJ0UepcZA2R9vythbANWmD96IFzNb5fHBRcs3gysjNsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7153

This patch adds a new member sent in struct mptcp_data_frag, save
info->sent in it, to support delay updating already_sent of dfrags
until all data is sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 18 ++++++++++++++++--
 net/mptcp/protocol.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4c249d1b9ec6..a1007751bd4d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1099,6 +1099,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->data_seq = msk->write_seq;
 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
+	dfrag->sent = 0;
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
 
@@ -1484,11 +1485,11 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 {
 	u64 snd_nxt_new = dfrag->data_seq;
 
-	dfrag->already_sent += sent;
+	dfrag->sent += sent;
 
 	msk->snd_burst -= sent;
 
-	snd_nxt_new += dfrag->already_sent;
+	snd_nxt_new += dfrag->sent;
 
 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
 	 * is recovering after a failover. In that event, this re-sends
@@ -1513,6 +1514,18 @@ static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_inf
 
 static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
 {
+	struct mptcp_data_frag *dfrag = mptcp_send_head(sk);
+
+	if (!dfrag)
+		return;
+
+	do {
+		if (dfrag->sent) {
+			dfrag->already_sent = max(dfrag->already_sent, dfrag->sent);
+			dfrag->sent = 0;
+		}
+	} while ((dfrag = mptcp_next_frag(sk, dfrag)));
+
 	mptcp_update_first_pending(sk, info);
 }
 
@@ -1539,6 +1552,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
+		dfrag->sent = info->sent;
 		while (len > 0) {
 			int ret = 0;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cdce0c092c3c..cdadb39a03da 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -250,6 +250,7 @@ struct mptcp_data_frag {
 	u16 data_len;
 	u16 offset;
 	u16 overhead;
+	u16 sent;
 	u16 already_sent;
 	struct page *page;
 };
-- 
2.35.3

