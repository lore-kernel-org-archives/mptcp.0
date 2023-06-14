Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3B7F
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:22:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzzZHELYSCkjgI2hkqRs+q2P8MYBw06Zerf6skpaAZ2oNZkrHVS41yUPK3J5N2GqoNcl6vdX3spTcE0BVBwG79V9acaglsPJy1ZS7hRyp7tn8KE59sSPCJlCJMgTZqCmyK9uR0JmpS0BwGAQSQj+Sz7vAdPyX5CdMp4pqR0G2+ahUOISY/qmDyTzGpP7jCVk5ul7Hh8oKDuWhmMG9c6Ta5+C1OJs8bnOOYjc+iRAfCwoajP3OTolcGZcj6xaf2m9DcCjWsiICOZND69FbkHLIhDRdaTMCAIjP1PbUV1xmlD9rcC1It6U7vj2WkhqMECaNitvQopouDumI1FqYqf1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PBt/cmnmVNXb16M8eCSOcAOCMTB/i68A5SiCEWdjM0=;
 b=mDZQ8JYv1CelwbKiugnNv1ww/f/aLl1MfdEcX362damo8+xRJ7/lSWuPeHECpc0va0YoH5wvos0Zw8yX235aYK6W862oDiQVlMff1XitdDhU9HZIVjs7v2aAdCeaMUM95JHtRfMb597oS3gH42kXl47RRF96ZKESkLYVUGceBP2q29waLSVZg5AfEAzJA5v2qciH7qcVqNQ9k53T+h7uTlHpNvXPhXYdcrGd4UrdphjuXYQGcroWIbyLpL4WBWdPm27zOw51D4ldkFop8JfbP9tOaArvLH7qwirmbxtstq7MrusSwAbfS9hR4f15afyGLW27uQAslPAUhMIN7lXPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PBt/cmnmVNXb16M8eCSOcAOCMTB/i68A5SiCEWdjM0=;
 b=oo6osrYP7hY+UFdvqQ5RYLCq1Tia3Mj8qvf7eSdajr66w8ppRBeTrQ77sBNlLA+8dbXc3JckRT7ULdfiSpoaR4VMFp3sbxcbvuqXmF+2D3SWI1HBhAYYV4ly/efdr4NuPnW8Ko12uExTaUh6PujNmsKuKP5piBCrFHx/8E6ZxUFVVi/R1P6sCl0pOIBA9ICmrPRttIoOr8nZTwZZlcJfTKYNb7PsNq3GXr3epknxlVn2RpHK6FHLKs51ghWUkw5v7A8kbtO/cbU5uLXDjLGUWyVf7rDcJcDu/grw5Ym0fEQzJhTW5L5sl101trMmx7E+S81aSKyzLpVNqq4KZWdFeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:22:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:22:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 07/23] mptcp: add snd_burst in sched_data
Date: Wed, 14 Jun 2023 10:20:54 +0800
Message-Id: <4419a45a414f6afdcd38e9f43080fc707255b63f.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b5a5fa-ef46-449c-bbfc-08db6c7e38ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QN1z7t5rXJBgM9KOq8fOjNFzxQfQnpb7YgV9INVjXvtPT8FVfygDuFIMMSsE1egCb3lqL9O4lFW6hIKFdmPaJoiRiAsjVxxv8/anQd+9gNLv1Yp/Tq439N1OBSD3n5ImwYRXEqgi1T1+hwSq93llKQS3L35qOFSTQAeMBPjmi9UTs5NX3O1g8RR325c+EAcScagnKbsabmWSLeCfbgHwitjVm4YcGcRQHLmS+lG5iOVD6EJtRzkhB7QgQZV3X84UonMqZo97m37Yj3g9APisvMz1WzDjoxE26+tV2plyJpVBfHoEtV8cu4yAuu8y5570SMKJ13bQvbs5sBYUidDd10Bdk92UD5iLuy1ef1AbCrn7FyGI7HyZHM9RqNXlHYrVJ3yf/Z9re3YsLxRRSWRY0AlHZ6eBvBqLf1p5zkxmpWBCrRfK6qf/5m/7LZxdHjSmbb5f5BRpRtIEXk1Ce2s1Wgrr02UplzSlLtl5SxjfN+gVSIKTyq+TajcElneGyIvx+h3RctFtFYM8IhUAiO0xHV5xYgU/pqjYYgxliC1oaFBW5JlXfO8hsa+Ay4RHr1oN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+ePh5Vx1a67ioMiacSGmfgFxVglof8NZNxVPtzNiL1/pZg0Wx9hKTJrnc3L?=
 =?us-ascii?Q?NZbSqdFjXIuauqs9tA7Vx9ncZOG5ijYOaq0mZUydELGmAZxNXvHekoxlFYyG?=
 =?us-ascii?Q?ob0quVpTO2srI59pEKEd0UnGcfVEGz+ddAxIBf1K7YqYgmpyjDZiVYyfejf0?=
 =?us-ascii?Q?o3S8HEt+FHNONh3+B3/rneDrKhYSMH+csJmoJy+uhrhtz7MDYDwrg8ZkdAw5?=
 =?us-ascii?Q?zT7tjaKpmzOBxW9YNOnUXj8ZOeDti3IJUtLB0v6Bk/USiQJuzo32meIXwd3H?=
 =?us-ascii?Q?sxrrSxCktcqcJ/VxlBsPeorwGgCdD4LuDCH8wabmBmYYXJB6nvr45edyBB/Q?=
 =?us-ascii?Q?+oJEyjQBYt4ZATpvO/RIaGIayHjZcqrSd7Zs9Vb9eteIomniDbBdc805l/xM?=
 =?us-ascii?Q?eVXTKTON69DWQansQemSt9rBuq9VEdQNluwSGPOlYbf4B2U4OzPRrgqdlVpe?=
 =?us-ascii?Q?o3709jGjAVjcsEyaNSqDwnIiHmJ7omCd9t+GCVa+WVgNmBtMxAnFc+W1iCOQ?=
 =?us-ascii?Q?BcEpihYe39qy6nuRQvMFy83IMNhk+6lZxtcnnwerP4AR3OX5BXIHiseJw9y6?=
 =?us-ascii?Q?5A6tIlej1xzeNwqHtbBmnwbR27yWuLHtpc7KZUTd3EZdf4fGdSH7vRqs3Jao?=
 =?us-ascii?Q?xcA/JAH0ksTuyPaWfhl/9yRjqoAk0J3MmfqjtbKHCcwsWcb8wgH8bf9KPT+t?=
 =?us-ascii?Q?BDEnvrz+whNmjYDJf9+QNcOrfV+cCf6bpxZIjl2ty/sQe1izBfK/LQrldjVo?=
 =?us-ascii?Q?KRV5sWng75BLghNv3j1AnVWFRXcJivxkYHUWo4sY2PrnvRFH43j9C1hpOv5/?=
 =?us-ascii?Q?4Wtf/36AmYPtPLU1LbmsLbJQlDfrnFihR6CTwI+CXx4HYBnXS1HCBcrK++8l?=
 =?us-ascii?Q?IJU37Fn0wEGXPt25kPni3agAgC1ZOkJX+hXsuyhGskS8kg6rrHfEO0pRSSdP?=
 =?us-ascii?Q?XMDye7MH+7qH08RCno8PVqpj/1D1oL/3mYaye4Tmimjc+kZQJteoscUpE8oc?=
 =?us-ascii?Q?14x/Z5AIBUIdRcb/Yu64ptvm8jJsR7i2x35qYy2thJphHzUCQGLlSV/YRjS8?=
 =?us-ascii?Q?P/VNg7gYOl6z0dByGHF+40Q04H0RABIP6Jlu703mNjSKyIvkTDjUYdGUW6Hv?=
 =?us-ascii?Q?gtM1xU5Rx7e/N2G2KtPdAwQ5W1tUNhIB3ZrDhLlcZdkq+azk6aB9RKY2dRCx?=
 =?us-ascii?Q?SzC4LqGoetY2UZCXIPZ7+5mFQVk2jP79obuPL+kXcg+/Lw3yq88x46hBDIww?=
 =?us-ascii?Q?bK3E3UhxDDMiF9nP9f07WD/MmocK4OJbeipUb7VJCuddyIuNAnyZcuutb6rO?=
 =?us-ascii?Q?zPgFmG720B6hVcx2cTv8AyB36R1qQO8hegSXBvmxjAio6B0r6FWeq0bmxEbh?=
 =?us-ascii?Q?qtd9JDPaxZHCYL9lP4EGA15WuJB/LgAWqfBFIG5rAo3pMtzQoH6pBQhnrvYm?=
 =?us-ascii?Q?W0pd9ZKGj5hwlTQai0vYwg3KRZw5JjXVEQzrLJlfO8NtRhbtv08eSVeXe722?=
 =?us-ascii?Q?PkmkrIjIwVDtNx2kGDgs0AR4iTi5gLaBXn7e8VDoWhVWoHay40iZmQoz6nBR?=
 =?us-ascii?Q?qJPtfWyySyu9GtB5PsMVMxbNZ//8QoV/teJN8v52?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b5a5fa-ef46-449c-bbfc-08db6c7e38ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:22:38.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7xNOGfSkk+UTzrlgRz2RiDSUL/nyVFFSJori2IAUFBZunZv81lnteozlxA2HBuivHTIG62wyPBLKCL5IiLieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

This patch moves the member snd_burst from struct mptcp_sock to struct
mptcp_sched_data to make it accessible to bpf schedulers.

To make mptcp_subflow_get_send() adapt with MPTCP scheduler API, it's
necessary to make the msk parameter of it const. Also an new parameter
sched_data is needed.

With this change, msk->snd_burst should be replaced by
msk->sched_data->snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 11 ++++++-----
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/sched.c    |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index a9bd7d6cd177..ef8264281577 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,6 +101,7 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	struct sock	*last_snd;
+	int		snd_burst;
 	bool		reinject;
 	u8		subflows;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 64343c664455..3ca15f8935b3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1414,7 +1414,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1484,7 +1485,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	data->snd_burst = burst;
 	return ssk;
 }
 
@@ -1502,7 +1503,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
+	msk->sched_data.snd_burst -= sent;
 
 	snd_nxt_new += dfrag->already_sent;
 
@@ -1555,7 +1556,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (msk->sched_data.snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = copied;
@@ -2352,7 +2353,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
+	msk->sched_data.snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bda91399be49..f404a5e313ca 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -269,7 +269,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
-	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
@@ -669,7 +668,8 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
 struct mptcp_subflow_context *
 mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos);
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index b59046e31457..50ef71b17beb 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -149,7 +149,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	if (!msk->sched) {
 		struct sock *ssk;
 
-		ssk = mptcp_subflow_get_send(msk);
+		ssk = mptcp_subflow_get_send(msk, &msk->sched_data);
 		if (!ssk)
 			return -EINVAL;
 		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-- 
2.35.3

