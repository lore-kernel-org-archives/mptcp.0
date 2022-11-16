Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150043.outbound.protection.outlook.com [40.107.15.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F007C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKxB3yWmbnMphnlsVSFQOiMwzKsyBgengo6/lVa+J/IZBUwftrOB5SH5OeGoEU9ONfJ8vGj8RDvGssN9qSk0ycjuLmb8hUP0/5ce9DQJbMDhy6DBBWqQNEgfFTmE9EyCsCPBkOBF9TS9VpS1Qo+ajknBf31Vp8UmP5aGTx0s3JCoah8GQb9GtHp5y6FNLorrEalFgJPAlH3VISOn/uWLH7WQEwan5Q/wBp7v+gs15quRSFpFIGhRYwkwBMj7FeTYNJA+kUQN4OfN90h6kiGz5u34OHhai+zjvEppEyzKsPHfpkvqnx7rAhFht1pARZNpqps91d47vKhk6L4oWAyupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWVoBgbqICvnHyTOKHD9U8AxgUnegZuHdpJ4yDiYJyE=;
 b=H7Vcnz9v23pxbWmS4dnMGLfSGiCyZXHoz3Jv7NZZcxk62QZOtDjroDKfZ0ewMVHAaqAC90JHegISQ+yoe7wzL7LlHmMg24XiszXq3CVnuVOtrC4sAxG0+3xBlYgRwLmWOSqdq8791Mez55ahw/2QOmlI4OCvvu4Pnl09rqwY+hNQPmQcJKIJKAx+01tJU9Ju4pzDokJQ9wXr8pI2uWwHeIXUIF0GKeWyy2vgpjgPnqiVdSbWprAF+joL0YTCfg/XR/syY1MJ5td1O8T1JXYCn/+UqaoZ+0MKVSkS/a7tuCq6k+UXXiypN2Lvaa/z7Cm9J1x05/+2OeIW9Ez+JEGA1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWVoBgbqICvnHyTOKHD9U8AxgUnegZuHdpJ4yDiYJyE=;
 b=BrZ7xGWbJxfNQ5tOv/tEn0DHb1rHr12WO5eyIgX0talTFUpQCXTSwng2tn7JB6AoGW5WQLeqS+Ov03NQ6XCOKUwDKVl1DcEhrD/d9p77vGvLi1uoDVLHn1zwOpAcHZDxTfC/xOXYDLEuHHXmptBnAodIeALsvUQTE5skU6160pBsPVoZWSCeukSJEpvpGKCs7NrmlXi7Ldvr85oMn9Br3apf6uztewWsqshNrKfpe5wOt78VtwrT9J9tAVkOSNuB+hO5Utw3oYjXrEy0aOZ8TmIYXgXKXzYs3t+Z5QuGaDgi/txwq8Ccr6ibGqY6sFAiPOsPbifHoIfKm9ySw2jWkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9434.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Wed, 16 Nov
 2022 11:43:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:43:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 1/7] mptcp: add scheduler wrappers
Date: Wed, 16 Nov 2022 19:43:02 +0800
Message-Id: <7491f4f854be68092607ebaaf21c2bad3f4dd951.1668598782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668598782.git.geliang.tang@suse.com>
References: <cover.1668598782.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2a6822-e3c4-4b0d-13c7-08dac7c7b641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ayz1eisL0gUGKu5zN++bYzkI6F3RpM6evQ8m+uZtO5SsUzgY213ppSrtS3xBuBLTvkSmmFTBAFGPi//h+FH3R8J6bqGClszzO+3GCS/+Z33zAoFDI6Ikpxu51eX00Uo4iOCriTh9d+ZvrJI3Ar9Q7adR7GH0PVQ90ooWn6BLQNlcDuRzmjmTDhG09Fi8rT7bbCpHKucoR0vN7NrI1urT7X9h1V24WPldlTVc+PwzmID2ZkMhQ6Eit8UxUH42xvOcqoL3J+jDWta7FhPo5kjOLeJ2uIjJTS2gAHH/stepxsupd5cypKi1CXp13J0t1stHuttIKB+JzfBkSw6I1GHT1MumSk8Ij7BeiNI94VPuehW6K7P8mUVzaeh3dTMFarDygOGzNGARPdU/Et00jeYwvyxKuDLAjNoX5iGePoOkdmyOGZFHK9WWsajrsUrNF69TWqxPGTRDXBDwt00BbXOj6227zA00kcfZLFNqchhO81oZHeOj+IQCROjEb/WaTMGDNFFELteNQp+jL2xYkpx9+xCFCFcmmw2SRAyoTWSSkO2aurcZFy4KLVUAyKifzpiHUGuoJKgrQfSuURMSvbyn8DC0uLe0DUWzkY5NOMGk3PPJJdezjrurUrSjTRGmPJwLEF81ZvmYvWDCAlHcxAr4VHMVKTXxcm5g73Q5xK3OmOaOHhUiGqA46VVMPJ2VcMTlj+ieQ4ckXfOu9u5k/I9vcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199015)(186003)(6486002)(86362001)(478600001)(83380400001)(2906002)(8936002)(6512007)(5660300002)(107886003)(44832011)(26005)(6506007)(36756003)(2616005)(316002)(66476007)(6916009)(4326008)(66946007)(66556008)(8676002)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gr0ar6MdsmERAXUasnhWcJvEFZoA8lPoXuCuQgUvV/bn3/AJTjlQ+AT1+08f?=
 =?us-ascii?Q?K/L3eNghpXmc1uMa3kYgtWEb+CLJTY97VO4YTRlqWCxesfGOeMb4ydf/0feu?=
 =?us-ascii?Q?QTqYl6yNfydrqj21Yf2JDyoNM8inCTmzNDUILSAfTJkjpMSsWLjFc2Xn6mjB?=
 =?us-ascii?Q?qYurW5xIqUl8f75pN39j7n2jB2KO89JXBrXeI6c0F66G4siZ3MrafDJNXNH1?=
 =?us-ascii?Q?oPwq9wsELTJ9s+gjf0y1k5+z/Ie5QiqevPuH71acLGHYjo82in5fFzymsRlx?=
 =?us-ascii?Q?HORCiiCGN60zWx6FbtYwb/p2m3RpqHp15G4+Kr7hatVDqH2Y231E30fwE3nk?=
 =?us-ascii?Q?HWMCy6WXXA7uLMpiJwDcAtAbi1pQlTFo289UodlZntL8drf0IX7CAWA3VkPT?=
 =?us-ascii?Q?/mUY+jEQKWGdILv/b08bmP2me60F+ylg9I2O7KrMMsFdNREkWvb1159lcBkv?=
 =?us-ascii?Q?LSU2VCGQCtRH/WQY1EnJQmsvcGj8qyOLMcBsEjSSz27bQqQJD8uSSK+IfooW?=
 =?us-ascii?Q?V649sG1ATbVHdV+IdIpPMWDlB7rKP2scpGp1Vtpf+YDqMrvpuHvbjY8tjKnm?=
 =?us-ascii?Q?5NBG+6WSvdNm8OPVx6Pu24dN3zepFPgG4OvbkNgu9zkpfokw7Vji6GNhJS19?=
 =?us-ascii?Q?v19W5WQ+hXLFU+pVj3TYr23MPVPbkU16bOL7jkGPqSC2v/8ZtstZ2daKIYtZ?=
 =?us-ascii?Q?6DT5KwMlFlHsWj3RbwaXUjro13E6FL3gCdmSuok/KSUwdDm/5KlxkBxPzlEf?=
 =?us-ascii?Q?FIOQsX8IseqVGnnZ9za8mu750uUUXF44NjEncUbLnp1aKHNeTmXL/hQaA8wW?=
 =?us-ascii?Q?1sRyortazoRESDXqNv7UXxSZmuvA9H5jgWh9nrkvIeMU71lzmDgVUgipOhMO?=
 =?us-ascii?Q?q5p6NcqhN0T/VvxjlDifsfqMeUC3DdngP7FI0ryXoRUDIjpe1ZEb8WDd7g8p?=
 =?us-ascii?Q?9cRy1AMGltqMb47FvHVidKpv0ddTurM2VOy1kKVWm2jG7EWm81tj4OyhprYT?=
 =?us-ascii?Q?QqpKd22b9oDg3avdREqjB5Gp0TMSU/HDpMLAUiouSYxTeLVqiOTE4PGDb+A1?=
 =?us-ascii?Q?qnBXEKfsJt9jLO38n+xGuVyPvZo2EXz7Oyg/uvrWBdKVYjjdD4yPCxSp/f5T?=
 =?us-ascii?Q?wiXbkbFiG4w47GP0/5OT0WiKVJAz1XUkpZDWUS+1aISZL+RrBqxX+tbIMKGG?=
 =?us-ascii?Q?vguTErH4I8a7VF0A4Kn9IY6Tg2XmaMJDRU9PztX9rMZMwBTbRK9oRWGWMASQ?=
 =?us-ascii?Q?jP88KYrr5QuobCmr3UXN4psA2ao0+alr9V41magS8lo8MTlB8iZi5TqODN4M?=
 =?us-ascii?Q?T1G4x8K8EQ/0uEw7rsGivC1jYatU0AZ1bbrqxkMvkcHCUDBUHzsG3bO53NZw?=
 =?us-ascii?Q?AUWUVKS34O+6Gd0466QOCb/qp+QzSJyR/0ZjLEB0Txf3uQP9qtIRJrGBJm8Z?=
 =?us-ascii?Q?FdhvH3c6S33sdfwtE0ucxJClpmy4+4VUcupBMgwTKx4Q86OoSbutFzOBmtsw?=
 =?us-ascii?Q?WYeBYdNCzn6kcDioDD35fYF6VIAaMQQFP0bLw1UV169Xp6lJGlaPbb56yQgj?=
 =?us-ascii?Q?5OwCvwz1mbtM0LeH9FUGh+uM4b9+oKn5XKS0MvgWejyBGYTYuSLBc8YI8EX3?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2a6822-e3c4-4b0d-13c7-08dac7c7b641
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:42:59.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efHvHRDfOekSZErr7QusSnzB83htZ73901QVKauqPBBN2u8IHN8pnvmZQaNz2qfsKqGwp8mbe1GmRWnps7h1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9434

This patch defines two packet scheduler wrappers mptcp_sched_get_send()
and mptcp_sched_get_retrans(), invoke data_init() and get_subflow() of
msk->sched in them.

Set data->reinject to true in mptcp_sched_get_retrans(), set it false in
mptcp_sched_get_send().

If msk->sched is NULL, use default functions mptcp_subflow_get_send()
and mptcp_subflow_get_retrans() to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2e60165c0eb2..6531df5ef4dc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1397,7 +1397,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -2213,7 +2213,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bae216bff6e4..8536035a71d0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -652,6 +652,10 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0d7c73e9562e..f51f9cf20b6e 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -112,3 +112,51 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 }
+
+int mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+	struct sock *ssk = NULL;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = false;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+	struct sock *ssk = NULL;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = true;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

