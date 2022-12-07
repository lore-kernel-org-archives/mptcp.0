Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2051.outbound.protection.outlook.com [40.107.241.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EDD1FA4
	for <mptcp@lists.linux.dev>; Wed,  7 Dec 2022 11:05:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVTXQ8ulDECrWjS7irguXn8fGvuFIgOhJoJsgwo4I4WVUR46rwmaYJtSBAgYR1+C9BPsVifz11jXHClxsRAaKphL/b1h3O3Yg6CytMm9ifACpao94VuVOH8QhWufVs/+7fjOVZbCLigs581eYHslkksJUySQ+P7Vha2eYsnsu85dJ6ngP3ykD5utELST8280GXJN+MSrYwx5ExYOsUPwHqu/THwC+nBlgnX+QbhsJtiWKg0BG02XC6+88tz+P1mrnJaXCJlOkHoHvVvFIoJp3AokF3GpWZRa6utsAhkxuT3+k9Hc1d1HcQQ5jv+aZB2cikbTDWpJiGNggIYltBkasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GJxFlrxoOYjaWjUIgb+G7VdhQRKslkLiF/XfOLDSMc=;
 b=ohANbnPTMNIwpCvOjslSRZnFITKOa3b4yR8quP/Hx/ugxr3NBdgpEPzRer3eujEM3U0+q6jhBVRtamESzzVFuKvwY5dLIvT/iLx3IA6erxjJTWHVDxpr4O+h4mpETt8qI5B8GsZV6eRS8JLbwLYNRCtIEK1HalsZCGO+FJFNsxrFawtq57CUUoob+Hgh4QG4nbjfO1VVqg0qRVjaBkApOA9bvPqmrQ6vHNEP9lr+DEgxDpm2Ggiqm2RPxxUEnVUmwFKruHYQN9EQvgqDOfKSLFXgREiCtEYENljGZO8lZBBWPNm5WVRgTozlk8deFz6ON8bC/ZSsO2ZKLfltPpDSDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GJxFlrxoOYjaWjUIgb+G7VdhQRKslkLiF/XfOLDSMc=;
 b=ewKVtB3caPPVdGMtTc48DXJU/Vidb6/uc6czVIZqL0aknhZBYPn/VIB7NVQ646zTyPazUhqCWLmt+GDg7XPVHlI4XiVBSaaUI1nlpKJqpBKcoEuz5KWs+xT0pE6TAuoksKZhq4nmw74NNa4h/XivejjGfy+pqZptdfMBrGd2w3hQYhXjhGnmNyCacvEhpVrsHsJk+v6NEsz2QsmhFPWuGXM20mGq/bNdM3v1AeFxwN1qbUDGHTiQGcL7MAJYCOdit+xvO/xqqN4UGsE8gd3R0wlJ8WksJL6ZFBZEjWXrt5Cs5s9QqveuPKoH/PdupesRE+wgOPrsm/n3InOSegG2pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 7 Dec
 2022 11:05:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 11:05:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/2] mptcp: retrans for redundant sends
Date: Wed,  7 Dec 2022 19:04:57 +0800
Message-Id: <e9c88454c14a007e9e847374500da09731041300.1670410690.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670410690.git.geliang.tang@suse.com>
References: <cover.1670410690.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:403:a::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed4d362-a4bb-4e31-14d3-08dad842f5b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qhiV6uOdFSL+eZvGgpVq6NAMTu9v8uUEaHzUCrFHeewrQQRiJpZ2r5jxUmSObzEP8JYIOW+iBobTc9Zrs3mgbqy2cA3lEiBbifGJ0DTt9+R+WSo7ndadVfzy89x8IJ5th534+JQfehBAzApIlxGsVCmtVADrzt6hLVA9mCbLWaF30A6N6z5ZCNTpe5STylRJ5kjfbg0+hD4wVLvUefNGLaMPIcKY1CG1tcOzXjypNN+AXq19nMLGC5xiiyR3g5K0lA0B0dfcx7RFI0scpadqr1bfgeaySYPZYzVcWWOQvDI/lM5ONGQaBLIMsVxt4pik1LwxzmAEsID6eJhI8n7SErOzVpcn3XuUD+ypdkFdoPkDBwnXLaliF3rKWrvw1Ia44OOG3q/vrv6t3ny6DSoxkOPGBL/T6jiUC6tEVJhPMrnXJS2fYFpKNVvaZ7sHQlrxxcWHOfHU6LnfpAgQi3nDozx6BHbdEvJoT7eUvK9QmLL5Iiuu5d4XmqSazKh3tg4s4a49hAKR6Gx0LUEcSC47lPDDhRu8jlUOEwhBhMDMZLvgk4CW2u5eb5CEh2lzff3jBWGfjenqzH3lrBt+q0nvQyaYFCKqlvnegxDnMwLDagjOj/ewN69nC+o+WAq0C2l2L2Su8JxTA97M94l8CkttpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(6486002)(83380400001)(86362001)(5660300002)(4326008)(44832011)(41300700001)(2906002)(8936002)(8676002)(107886003)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(316002)(66556008)(478600001)(66946007)(66476007)(6916009)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x4vdOSqtF5DZraxL4vTW/O2luaobv0Bnb1wbqCKvkD2gtNO/VhxvznOhv/y0?=
 =?us-ascii?Q?aVbGvE9oNDeG5UaqL73vF17Noo4n+tR+oIRCvJgsrifgl7MdEtqcruPPe6j6?=
 =?us-ascii?Q?cRFnR8552BwqrK4ysa29HArrLHlBwjfc+U4YtBxYYqJT6aYizHPs/+XFCPsb?=
 =?us-ascii?Q?Gly6Wz3GapItiWazTyMV/rIiUGuxixYG6+il/E7IqZcllkugL1YMLMF07bmC?=
 =?us-ascii?Q?S0XjeS1viRW2K6W+IsDjrhajRKiZPcWO/pAkVHGv2KA9QXcWNi3Y20/kveI9?=
 =?us-ascii?Q?KIn3BtmYwidIGrJds9RIb00PIAOuQcbSXbEdR72uQ8Vfhn8iiwtwwQPdyU6K?=
 =?us-ascii?Q?eej0k+QfV5YLXyiFO+tEPat7jiW93I5/pC62e/wchf+v80FAZE1klU5zqZZg?=
 =?us-ascii?Q?8SFcp1p94BWapEjZp4F13FRIw0pcn9hGc0KDduVAdPQzOWPjeThPgwYX197M?=
 =?us-ascii?Q?ra/JmuKZG3gPR/mzfdiIAzv9zfvFGrBgP5Jj4wXcFWSFb1pFm7SMnvriINE3?=
 =?us-ascii?Q?7OGl+6dJkToghlyW9rtj5HL/QIVKOuZztaZ932EmPa5gmqo5rdwwvHdACdPX?=
 =?us-ascii?Q?xkrHAtKDeTbdbBP+zQNNIkMqxKKghJZ6tAI2yku7Wrpa9In6RQzr4RtfoXlQ?=
 =?us-ascii?Q?G9BukZ/ajA/8zgTZ+YzTdTHmVXfin5xBdMyuwlVkvMgk3uQHXek0EVXchfmK?=
 =?us-ascii?Q?rzfNTtmca0+8yGWvqfQGEm6lcGkWB7V9CJTzHW/rgsOEZXzHI7KvpESNl8Wc?=
 =?us-ascii?Q?C3ZSWDu/X0hd4AMP+I5y41jAMAwttl1wC11s8eRPlCL4eINoCqkEG6X/nVL9?=
 =?us-ascii?Q?N+8dmYKZTWxpaX935afWRazPpMcC/6uvlTf5W99MYjRIEVwp5kNXcoqmSlhd?=
 =?us-ascii?Q?qeNIwD9e5QOXwWNNB29szAfCtxxFNHEUMEN7J3iEKfUDJ15REjO4FgucwKEj?=
 =?us-ascii?Q?mZcEq1EbrHSwpASu7/hP9YiNNUOCaMCQcQebQ0NZhEoow2AdodTBK277HCJo?=
 =?us-ascii?Q?IW4v4JWqVL0Fh+9ObJzCDLaN5iLtvXA5LEF7OJohqz6yo/clRf7A5CPBtRm7?=
 =?us-ascii?Q?AdP+tZiTyLeyTe1HP1OgduKgk11auTyKUW+FPQ29EfBxuwRmK/7CdwTN7eZW?=
 =?us-ascii?Q?wHSpq9TxQIh1KsliGqGGXtYA7ZQCD0sdqRic+WNX3W43ckW4kXpYpjsGGdSP?=
 =?us-ascii?Q?QQoxrlD83V8LRY92/sO3Jbzmf+HXLn1PMbvkoc0EwLsuKy074rCpHhp49sMD?=
 =?us-ascii?Q?2l99f66ig+ha6JUw+QUH/pRDjmHRCx5L/5PySw3atkq9uOETwbGwS5b8Ojqn?=
 =?us-ascii?Q?dfbly3JX96Q7G+axNYw4q30KjXQknvRXVlolEbzK9+dBRtxy1rWknPqB/ZKW?=
 =?us-ascii?Q?z7lXLPo55TYxKeXJ/7+93XHF8ld0s8zTpB0b3E8peJZFamv8x4OJvRYpExmu?=
 =?us-ascii?Q?0Go/fSq7KQ2YvY33iCbg4F2x4P5JoL8CaWtOX/TD8vB1gHytgnhqb8djWs68?=
 =?us-ascii?Q?iYIEm92sMMmNJ9IAm97HVGWQ+ssZcqIP8QdY4fPi/wAsU2aLfyp36tRUiiKW?=
 =?us-ascii?Q?Vbroz1wYMB0GN1hPE0BmS5K+HzfEa7crItwMYvMs00vy9oifLq2ygYum3F7l?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed4d362-a4bb-4e31-14d3-08dad842f5b9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 11:05:33.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIt12c6HwBb5uczFBD59pYSuJDAmLy6aTH6SF/0HfSAhnlsThZYfqHszv4P58vUS+JoGbvMez44zaA10vayacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176

Redundant sends need to work more like the MPTCP retransmit code path.
When the scheduler selects multiple subflows, the first subflow to send
is a "normal" transmit, and any other subflows would act like a retransmit
when accessing the dfrags.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0c4403c2aace..8c2480b4baec 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -45,6 +45,7 @@ static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_sm
 
 static void __mptcp_destroy_sock(struct sock *sk);
 static void __mptcp_check_send_data_fin(struct sock *sk);
+static void __mptcp_retrans(struct sock *sk);
 
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
@@ -1112,6 +1113,7 @@ struct mptcp_sendmsg_info {
 	u16 sent;
 	unsigned int flags;
 	bool data_lock_held;
+	struct mptcp_data_frag *last;
 };
 
 static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
@@ -1527,6 +1529,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
+		info->last = dfrag;
 		while (len > 0) {
 			int ret = 0;
 
@@ -1563,14 +1566,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
+	struct mptcp_data_frag *head, *dfrag;
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
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
@@ -1579,6 +1587,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 		mptcp_for_each_subflow(msk, subflow) {
 			if (READ_ONCE(subflow->scheduled)) {
+				if (i > 0) {
+					WRITE_ONCE(msk->first_pending, head);
+					mptcp_push_release(ssk, &info, do_check_data_fin);
+
+					while ((dfrag = mptcp_send_head(sk))) {
+						__mptcp_retrans(sk);
+						if (dfrag == info.last)
+							break;
+						WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+					}
+					goto out;
+				}
+
 				mptcp_subflow_set_scheduled(subflow, false);
 
 				prev_ssk = ssk;
@@ -1606,6 +1627,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 						push_count--;
 					continue;
 				}
+				i++;
 				do_check_data_fin = true;
 				msk->last_snd = ssk;
 			}
@@ -1615,6 +1637,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	/* at this point we held the socket lock for the last subflow we used */
 	mptcp_push_release(ssk, &info, do_check_data_fin);
 
+out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
@@ -1629,14 +1652,19 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
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
@@ -1656,6 +1684,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 
 		mptcp_for_each_subflow(msk, subflow) {
 			if (READ_ONCE(subflow->scheduled)) {
+				if (i > 0) {
+					WRITE_ONCE(msk->first_pending, head);
+					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
+						mptcp_schedule_work(sk);
+					goto out;
+				}
+
 				mptcp_subflow_set_scheduled(subflow, false);
 
 				xmit_ssk = mptcp_subflow_tcp_sock(subflow);
@@ -1666,6 +1701,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 						goto out;
 					mptcp_subflow_delegate(subflow,
 							       MPTCP_DELEGATE_SEND);
+					i++;
 					msk->last_snd = ssk;
 					delegate = true;
 					push = false;
@@ -1677,6 +1713,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 					push = false;
 					continue;
 				}
+				i++;
 				copied += ret;
 				msk->last_snd = ssk;
 			}
-- 
2.35.3

