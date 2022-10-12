Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60061.outbound.protection.outlook.com [40.107.6.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547BC17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHiHZCQ1WaatLQ73203VAF8T/xR36nXNaOdi+4JmMILo7N/o4ZgidcgejxSbDnmsXey2riBEf2UnpsUgraebwJXM8lzxqrxG/c4FfOgdC7jbpH5iVAaSTS0JjHDtsbn5F4M90rKn6Fb6OybSHdVoA3PwQb8GWdpG/sb0No6gDeRLpe1czBs9Qo2t8fTiDOR2rsjQstalFjjUuvWKSU0oCxoVuIYWVEXF3+KSloI4FUUAxq23y95WhWRBG5Xm6FSNvh/b6Sq73s9IWIx3vw6nRUoZ3ClzOKeUiHdL2YqDBjEsc5VLH1D8bzLaED2FPMKh/j8KhG0WiT67Xw7fFaWtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frpfUlHl0g4mqeO5XoOX6vFqKuKbluUcWAc5PZmZE9g=;
 b=NXwCZP4kxF1j4q5afutmypYBCcohWDPu1dgl/Ji5X+X/6xFvSoi31uq6Xe98RQ1W1biXrupfXQ1eAwRYqIs4sfOQVt34QwvHOQRhtziBEE+suE+oOkryPAM4x8KoBkt35xb6tbgdK+cinh2V0XF0Is1OBfkBiE2IzU1gAVLXLHXyXgl+48xXQOkuxjiyqzzLEfJUrbhqMQNMtJ8Lb2fV7iFSJc7J+NFdDKBvMkRswFlDWcIyV6beQXu3V2BOkrC6rWkbBFHHfj8XKoL68zsQh3ik+yo7higbnT4hVy3cPDKZBdVyE7BiF4arFtK8EVH8n9AVptUtz1buKOufxf+PVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frpfUlHl0g4mqeO5XoOX6vFqKuKbluUcWAc5PZmZE9g=;
 b=whIdbQSXWkAZvmgu47VWF1IM6Cu3irrjydD6E4Lxq67stfX5GurqzVRP+Az946KmtSV+YscSr1aGP7llEcPz6bR8YKgY/hBWaN6Sda2Lbhx4X1VXytect20ilMFreJzf2uFLjyfqjJvU9wEh0FzGA1x6WmHTGPl01Ul8y5mRu3ZY0faggUIP5eNq9ufmDPI/PtLy1WkLyFxCfnaMluIyYAx3K1FtwbNzdlzcpTXqXWFN6Q6MXEmtaHLGlRyzURUnP+TG1eZV8ZNj+eVwBhZIVF0JQiTO2jiF8cGLZIAVjXqqMccA4n8u+f+WJ058QR3sSNSzQA7TauhrQ53lt3gifw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:51:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:51:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 08/16] mptcp: use snd_burst of data instead of msk
Date: Wed, 12 Oct 2022 12:50:29 +0800
Message-Id: <10bc4f8060728d5b58bdecb2f2f122f319624589.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: caaf074d-05d7-48ed-2756-08daac0d7116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+vpi1zvx/Ly9wxLRepkF13rmols71wLMjufyTYaQkAmPaDRRUs0Opz1gsv2xXgf0LdM+vUuzSgf8Vyqr1qbAW5+yNw3qTs62rSBHKRZV1hLQqgA63NC0S5mtArS55dv2H54V6b6U4xnffKFNRA1XnVWMV8LwB/DJZoQkP5vhAYeXisHcQuTLfBDrsy3ZDHM8AXmo9GdVroLBbZJxosYcjW1yW+feWC1FhvBOKV9Cjs1n5jCDeBQ4tyeLTcTVPId6htLTXL4pUuQsLdUDBnahfvQ2vw2f/hzJNUFrLOYHKRNl1YQgTm7NHhTbZtspM3lnQXOz3Uuiht79CfoNy5Fiws9NXhtpWCi/eDnsFGlxXMTUBL/Jui99CuufdGK3XzAIsKhorJkOJbIg9r0g2VWlP9KbNQ2gYhcuLbESnB9+31FQb6N70TDnOiNrRIiawBpt+bQdyY7g+YmRFGORrSqQgV3WMMI8uXR2mmbxnha1iGQZewrJJ2JhSTadVLQtct8QOWgLE7uzBCOINrcOMyKAwW4lK3JO/VzMAkrqdB8Vy0eeRfR/4yzpcRHS7kQ2+NsT+Cwbf2opbqvlbMzTgeabpUFzE+WUUiWVdupk/kkI3uLfNtKsoCgW4IkpZwdGKN474uM4LbAshcrwbUQfyR68EjYoIbqrzMgTbMutkD5HgvVSWBaxRWiMVn93rlMPnknzvetlMPJ1TjxPuKlQK7f/EYaBsNGtlSvG6ZxM6stEjraznavUsUQggXXOyMiGzkuP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(6666004)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(36756003)(8936002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/fd7PdWWj1Ols60rSlAnlddA6x6QCAIl9YhLfIwCnY3txqkYduZeKETtofPJ?=
 =?us-ascii?Q?G2DweQ+Dgx8jSTrAqVdbrSGdqR7Pc1qU3jpGCrt4LzjbgmdhSBBXz4VUbtgP?=
 =?us-ascii?Q?iufibLWcXOu9D/4u1H4F0kuXaz3/sJZze/aiV+7PDkbh65ZOR3nq0CXX+VVd?=
 =?us-ascii?Q?jXDKDrZzyszPHsTiQmOZc7oAILw/ZrvwO+63LpnLFShEMqYGxXQTuQLuaGDI?=
 =?us-ascii?Q?2CGFQx1ZsJbdgnjmoutJAGfSHRMT9+S7RKeHDpivFjwm8TSqNEXAWRxFvWi7?=
 =?us-ascii?Q?kgrOGrgfWvx1JbWI0z+Z+fhMj64FUG3IJqWMRd3WfBq9B4Uv/kkUykXgMQkc?=
 =?us-ascii?Q?UO96SZPmkwJ5285BEV8y1K//0ilNpdtcWQo3EzgQf3wyhpFiZ7QHTqgk4bbn?=
 =?us-ascii?Q?9jE3kn/HZIr26ypd42wykarN2l/3n5iK82969MPvki6YAzks6u86jBm71g+X?=
 =?us-ascii?Q?9uURHj7qF42wL2EbCgqVfbFzuS0Ch+ap7WBybQ7ZGZFVOYD+hIT7bIni2eiD?=
 =?us-ascii?Q?d5uGeM1zUfhgj9HoA3cnCT7uLlcJBX8HekJq5t9lKF4NOvQaHVM17j7pyuK1?=
 =?us-ascii?Q?6is9w5pMwS64VhRGHMQVR3f+xF5rWz/q+0sy7dYV0Zq35EWy8rvKavDoVE2n?=
 =?us-ascii?Q?PVo8nfm6VlbHBW0uscgwjgELaVBMvVF/BsNVpLh1lQQtT8gbBDI96+V3Kn26?=
 =?us-ascii?Q?fSHzCGjuT6m20jcXcFPQ8lPOPDq0+xGUOjkF+9AcxNEpnELz1bGjj1dKRxqe?=
 =?us-ascii?Q?C6NQReTa9IZXCD960yNUBjpqIPSLr1xpcFvZ3ix6O2MRftpbgnB//qPoUrbg?=
 =?us-ascii?Q?VG9jI1GZbMypSI2867pNb3ADc9JQhGxF1ylLCqYSolU90uceSVTmecaJMGla?=
 =?us-ascii?Q?eMgfJcVzCk9k2pcF+rHc5wauc2t92OvAdf6E3TP4iipV/QTLR2/5hfavUcgq?=
 =?us-ascii?Q?XsAnbsEuyJ9JASW+cfhtQefApz45IatlRlRyjdSPIJjIBXVJPy8grlQLO0Cp?=
 =?us-ascii?Q?uUQcUjVtA1b6kzJfjLOuU2FdHK2poFpI7syxPJLTuQIHrHOV0W0tVtHEB2/X?=
 =?us-ascii?Q?3ti5DdY0p44VrPArAk2nNoEGfTgYBRXxroOs3w/fMfh/liFQEwtBCm/X6WLd?=
 =?us-ascii?Q?uSoIDcyjoyuOJDqO9XQEzeim1iA0F94soGnHVArFD8WeEsjvp8kEPwy7PNLa?=
 =?us-ascii?Q?7n0HGfJbOqcgKi8LyH3MlYB1BuZDsMuGgm9hcvFQgzjJ25GMhFOA68ggRYyY?=
 =?us-ascii?Q?Ry1XJlk7K9mEYEFA6kiK6IdwDSKz0k+5xBo+aBNq8dChJsuUuDk4jwZTfWUT?=
 =?us-ascii?Q?uh5VivkX09p7Oxi75yxBiM5CluyVBIUUzh1wB8asD/6QeSeHysA9THa5N2zi?=
 =?us-ascii?Q?bMO4gft/rWhedAbI/eYqow0UMEMkUM+RaGeQKOIHQ1BG9sdoOxNF/L7ve/vE?=
 =?us-ascii?Q?7ibhuwjJOsjddI3tjAvN1ixXhtyYKQ05fPeB34TqJaR6GgWEMS2A+EXulARt?=
 =?us-ascii?Q?sHihR0M8LS1zoK//qCGJnkRa8pmcgTkF/9Bc5dllXBI2UWOQlBSRxEpvnY1s?=
 =?us-ascii?Q?TOJhyCwMNb6T+xDehGUTgKu6wppKV/2kDJbKva2BCWHhqOJNQyy+u8TgE4ON?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caaf074d-05d7-48ed-2756-08daac0d7116
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:51:36.0832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvCjpu3cWhrL3y6tf5hOTZI/Zw8PD8S2jVSEp7D9xUnl3bELKGNVsuOB2RercPKT0VWlO9DrCT1D5qKmLDKadg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

Use data->snd_burst instead of msk->snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 12 ++++++------
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/sched.c    |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0d9fae5718cc..956c8ea0edcf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1406,7 +1406,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1476,7 +1477,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	data->snd_burst = burst;
 	return ssk;
 }
 
@@ -1488,8 +1489,6 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
-
 	snd_nxt_new += dfrag->already_sent;
 
 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
@@ -1535,12 +1534,13 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			info->sent += ret;
 			copied += ret;
 			len -= ret;
+			data->snd_burst -= ret;
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (data->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = copied ? : -EAGAIN;
@@ -1616,6 +1616,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 		 * spooling the first chunk of data
 		 */
 		if (first) {
+			data.snd_burst = 0;
 			ret = __subflow_push_pending(sk, ssk, &info, &data);
 			if (ret <= 0) {
 				if (ret == -EAGAIN)
@@ -2282,7 +2283,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ee9e7e55dfe0..3f97bacca67d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -257,7 +257,6 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
-	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
@@ -638,7 +637,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk,
 			 struct mptcp_sched_data *data);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c459b01f9a9d..f9440b935c76 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -113,7 +113,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk,
 	}
 
 	if (!msk->sched) {
-		ssk = mptcp_subflow_get_send(msk);
+		ssk = mptcp_subflow_get_send(msk, data);
 		if (!ssk)
 			return -EINVAL;
 		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-- 
2.35.3

