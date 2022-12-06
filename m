Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6A6AB3
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 13:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XakI6Jo8/r2hZ8GsEBTvk2a7plcRqoyrIptZY/Yxdgf5WMW7hSlIAPy7Wee9wzSc/wcq8gordS6ksMvovvuCQGARdAOjEY2rnMGmqnucttbCi+FKWLg/9E8Mx+gKGUF3vgqwECyhrYhYA1mui0K/KVBQVSudXRek43B0inm/nEuFkPxgXfiA8MA4b8nHUVByHhEpkQ70pnLdnIYdpAnS0uBcB/K30k1c523EgxAZjPwM7LWs0CvnkS7JHvs2y/DbDei9dyIj/ZVUP9sQBYvPCbYDcRSpueGsEc+kKqECcfRQGEqWOwnI+GInPLezlo0/NtyRpGxVVhtjZODB0ZK31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpL03su/xuA8SbFc3r9A9LmLHcjlaRzV0QOe7+YfGIk=;
 b=bPhmnj4TKOJb2jl0jIfPH6Fv4YkGiNy5emQD9wVFn3yF4XXRIG8kCR8/TRYwCIsf/h7JiikxYchi1WXWR7JouOEp9kFuS7mubEdHY7ZKHCrgbkavFmtDn9r9ftOk37t/OT9eFmsxrz2dXlSld6YY33gx7tV4+nzI8CZe7sO3is941Xyc5/v1ZNTT3ZPXhXgo0scKi4DKGkvY7+fpVU/UAnsszUlfkelCeXdsENwX3NG4RjXYGVWoie/x28dMIDb/5AzCC3T+Q0dRRNnFBpgx9Vd9OhcIM9cFFEnJgc8eH9y347J3b175XTKJh+LdDeEGmF/UsgI/6OYELkAPUhtcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpL03su/xuA8SbFc3r9A9LmLHcjlaRzV0QOe7+YfGIk=;
 b=DSRznCew9WBlYu40htXCEZYmL5cuLtZElGagKhbQxJ+po4g2RTsrG7XqR6mATY3xsmZeBh+XkAYwSTt2HtO0pAxRofs6tJfSF822Z7MyhhbeK4ro3m6OB+qwiHcW46amCNNUwpkZZCXxeiyQ9r4fBTJ//E9OHf7YF5mdLwgmyGoEuPOcXbB7hBqJFg5VPZvCSWrJtuG8Yr/ra56+FQ6dlmvDT0r2Uo/CX6hAQPBCJ3W3TY+zB/R8UV+k3eONs2/Hpg7JCi9QTTWiRn3rbvGK5B77Va1gO8JWKW3N6HJp5VP8+j33CyksIrZ0U+TG2T+6i61KbBTA0T6HuLfSuA7X6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DU0PR04MB9228.eurprd04.prod.outlook.com (2603:10a6:10:353::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 13:30:39 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 13:30:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/2] mptcp: retrans for redundant sends
Date: Tue,  6 Dec 2022 21:30:26 +0800
Message-Id: <07e93f330aa94789dcb2a5d4953b7e0164748b88.1670333050.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670333050.git.geliang.tang@suse.com>
References: <cover.1670333050.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DU0PR04MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b8b65c-ed54-435e-288a-08dad78e1060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JWjTFLFwmMXg/U8+54mte2lvpWBs4B+rEGPQmuhde05bPoVbzoGzjNigfCZ2vfQIUUDJHv/OMzyE2t9nuFZYWhfh2eTy/h0obIBtS2Qf6+ydh99R331H5dsU+LgxFzIR6LqBncf5Jv59jb1MqKJBK6j6l/M1x7tZKgpZpqNlPXTIv4OrwxoQam90t7SiFrZgWop5NVq2fkDFZDcjTcHqBrRr5WnVjlFT42zYKT1S8dtFk01t3E/PTZaP/RMGb2epqN5EBgGTs93E6o0WqjzPKkBMAcgcW1JupxwzSTYJWY2KkdBEJWkYC7GPLEG0wfe5bM2RhsugPQEDDLl25A02XvQpiAOIRcOtAyTjbPl4PN5v2+GgKN/4t/z1aOT4dbCWDmxLi+YPwysWdWt++RmF6fBBHFir5GsNNcq67IB9kIBfWyKsADjrHgMkkjX4nov3AbWYfbec4mtF5wgqyexYFdH2QDPFlxJ6bSD4Ng17hRmcyKlRE2DFiVTojS1QfSyIsVnd8bxHz5eVLVEeUCaoD6AnC32J7GiTeyFAApfphlmI9uYMk72QlVZCzkNtc+E5HGgqjw4kjZU9I6ObXSZYs/pxSrSipyS0Ztv0oyEIE4RLyuPQSRJi05d87ASK32ZW01GeKY/hhOrrJ3UYtglmNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199015)(83380400001)(6506007)(2906002)(6916009)(86362001)(186003)(6512007)(26005)(2616005)(41300700001)(44832011)(316002)(5660300002)(36756003)(8936002)(66946007)(66476007)(66556008)(6486002)(478600001)(8676002)(4326008)(107886003)(38100700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w/jI01CxqD44d58XXua5JCtxlk7hFo3dP9z4jW1UF6OLYrEizKEm3zzQU07Y?=
 =?us-ascii?Q?9eI9dnSgT6iL0XgX4zfymEGLzgouV/OZOT76MRvVdqkdHLVo8TcX2evUqYRj?=
 =?us-ascii?Q?cCQoNMrNjvVb7nIMuuQOYSJO2L7QeeU8BdotvqjCr19cqmI+jCS79/0vK/er?=
 =?us-ascii?Q?4oziqIRH9Q+ocUftNo4TKfW+WjGKzt6V4kXHoZL+pVAcV0eCxtnbkoYN7Z2m?=
 =?us-ascii?Q?L0ghXYuKvkUn2HIXawLxmMcjowCpnW5+s7jKLf9Sfhs7tm19iZxEgElgrWDG?=
 =?us-ascii?Q?Mw0n9AbcIc+EtTdc4BuJWw7fQ5SdMmFhQ28/PKoTrncm0b5a8yZs3FLDt8GU?=
 =?us-ascii?Q?toPftjejaVcrPE2xa44y4bFxoo+sU4R684PxC+6ncIoh/sPFKB39xDHATwdg?=
 =?us-ascii?Q?sr7cqOvqlo96d1wg6RzNZGV+fVPZjD9DXUGuu9G2WoJLuoKhLMaF9XJHd/oO?=
 =?us-ascii?Q?QDV4fJvUD7MqHH9wdpnvNd8UqD3YM8JS8T2n0ZmRlwll+kQXqsj29YkfSxr7?=
 =?us-ascii?Q?HTftyq3jyRQHmwYCi9lUezeBxovvKjtsa1IJhuH+0strmXzZogdpVqPw/TcD?=
 =?us-ascii?Q?ga/lfWWGmFL6ztCDAzc2xlSgi6Tf4oY8rh3iviZPWLf/ehIBEhPcSoVu8tmc?=
 =?us-ascii?Q?NuYmP9Qy/RYv9QASe0+SKH16Aoa0RMuoX6z4iV8Fa/7AJA+FnoDcnsywHcKN?=
 =?us-ascii?Q?M2pP3kcZ5u8Qp4JZxMy1eTnR8lcRvloTurGLCtHJMYiz2Z5slRoH0FaqAItl?=
 =?us-ascii?Q?vECKIQ3i7mXOqPbTyc4orvWEpXXjeRh/S+o5PbzfVo+3KsdH8YHXB2iqWjrG?=
 =?us-ascii?Q?khCerB3DXrx7aGBHRXyDAToT9mBa8nkPlJ5fHe6rj8GD54X/yhB9a+McrAey?=
 =?us-ascii?Q?YBogT2nxi2h71EZXUnbzDxdtHHRymH19BSI8LOO21acHaVuSTP/1ZujvpJn1?=
 =?us-ascii?Q?Jzo+MgJNqFbr4GZ9iemzeCD+3jH2zjWy5VFbUSUcdbm4NWWMGeAhvxT0olCh?=
 =?us-ascii?Q?nl/N830e8uZrSVswcPV8Pngvz1WnLjGD4dAGk96weWREBhkO5XLH5Mi/Y3R6?=
 =?us-ascii?Q?qWt0Gzp7LFBMPi2TM3A6jD7XOsKRi8eSJL0Lqm70z89IZz2yxNySwj9LUNzg?=
 =?us-ascii?Q?R/KRingE4/ZvP8KcIT9kZU9/zQba1dHdHcFa3HdRTa5kFkiY6OHxFfVMr79W?=
 =?us-ascii?Q?W5TEOHuwfcuGhkeAhFW6sZ07v/JXltwJ1C+5CKbb/PtbdZS2+5qpaAZZ3yKr?=
 =?us-ascii?Q?SiA6nfX9ja7n+Q0eCvn7VmNFtITioW9yEYghQqDU1ODp3kSOuDsShNDuG3fL?=
 =?us-ascii?Q?pViLsIRaroN/mUnmDObVWGoGKUAIdcCGzVzXoR7LVbIMSKILuQNDjZU6CW6F?=
 =?us-ascii?Q?p/VFDW75OJDsYJpecnJlRhIS0Ylobe61NI+sTtSRMBF53TioAPEiXnOSgcDE?=
 =?us-ascii?Q?wio2miyXb8nhCb6bP5dgpBA20I+nWiKntYE9ZFwoz0qnnAhg7WszliMocRJb?=
 =?us-ascii?Q?EVlvEFpKUxcdcP6GVdg0ZX59tRx3ab5mGQeDG0txbxavVdnsIQck1FkHGLM/?=
 =?us-ascii?Q?wKDBVCIATm6SIInCsH9wutmpsMmxr6hKmVLvxtxfaY2sy4wr8JRr2Rh1o0eD?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b8b65c-ed54-435e-288a-08dad78e1060
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 13:30:38.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0j9lDWN6OhGypeq73ZX8U0XFJpuVj1ta8v/pNBqUxAsCdaiZkzlkpa2RsIC6L4gj49db0EHqJVW+a/RWvNcOIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9228

Redundant sends need to work more like the MPTCP retransmit code path.
When the scheduler selects multiple subflows, the first subflow to send
is a "normal" transmit, and any other subflows would act like a retransmit
when accessing the dfrags.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9f0237b5a4b4..a8cb12af1d51 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -45,6 +45,7 @@ static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_sm
 
 static void __mptcp_destroy_sock(struct sock *sk);
 static void __mptcp_check_send_data_fin(struct sock *sk);
+static void __mptcp_retrans(struct sock *sk, bool use_lock);
 
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
@@ -998,7 +999,7 @@ static void __mptcp_clean_una(struct sock *sk)
 
 		if (unlikely(dfrag == msk->first_pending)) {
 			/* in recovery mode can see ack after the current snd head */
-			if (WARN_ON_ONCE(!msk->recovery))
+			if (!msk->recovery)
 				break;
 
 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
@@ -1013,7 +1014,7 @@ static void __mptcp_clean_una(struct sock *sk)
 
 		/* prevent wrap around in recovery mode */
 		if (unlikely(delta > dfrag->already_sent)) {
-			if (WARN_ON_ONCE(!msk->recovery))
+			if (!msk->recovery)
 				goto out;
 			if (WARN_ON_ONCE(delta > dfrag->data_len))
 				goto out;
@@ -1473,7 +1474,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	if (info->mss_now)
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
 	release_sock(ssk);
 }
 
@@ -1559,10 +1561,15 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
+	struct mptcp_data_frag *head;
 	int push_count = 1;
 
+	head = mptcp_send_head(sk);
+	if (!head)
+		goto out;
+
 	while (mptcp_send_head(sk) && (push_count > 0)) {
-		int ret = 0;
+		int ret = 0, i = 0;
 
 		if (mptcp_sched_get_send(msk))
 			break;
@@ -1571,6 +1578,13 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 		mptcp_for_each_subflow(msk, subflow) {
 			if (READ_ONCE(subflow->scheduled)) {
+				if (i > 0) {
+					WRITE_ONCE(msk->first_pending, head);
+					mptcp_push_release(ssk, &info);
+					__mptcp_retrans(sk, true);
+					goto out;
+				}
+
 				mptcp_subflow_set_scheduled(subflow, false);
 
 				prev_ssk = ssk;
@@ -1599,6 +1613,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 						push_count--;
 					continue;
 				}
+				i++;
 				do_check_data_fin = true;
 				msk->last_snd = ssk;
 			}
@@ -1609,6 +1624,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	if (ssk)
 		mptcp_push_release(ssk, &info);
 
+out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
@@ -1623,14 +1639,19 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
+	struct mptcp_data_frag *head;
 	struct sock *xmit_ssk;
 	bool push = true;
 	int copied = 0;
 
+	head = mptcp_send_head(sk);
+	if (!head)
+		goto out;
+
 	info.flags = 0;
 	while (mptcp_send_head(sk) && push) {
 		bool delegate = false;
-		int ret = 0;
+		int ret = 0, i = 0;
 
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
@@ -1650,6 +1671,12 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 		mptcp_for_each_subflow(msk, subflow) {
 			if (READ_ONCE(subflow->scheduled)) {
+				if (i > 0) {
+					WRITE_ONCE(msk->first_pending, head);
+					__mptcp_retrans(sk, false);
+					goto out;
+				}
+
 				mptcp_subflow_set_scheduled(subflow, false);
 
 				xmit_ssk = mptcp_subflow_tcp_sock(subflow);
@@ -1660,6 +1687,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 						goto out;
 					mptcp_subflow_delegate(subflow,
 							       MPTCP_DELEGATE_SEND);
+					i++;
 					msk->last_snd = ssk;
 					delegate = true;
 					push = false;
@@ -1671,6 +1699,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 					push = false;
 					continue;
 				}
+				i++;
 				copied += ret;
 				msk->last_snd = ssk;
 			}
-- 
2.35.3

