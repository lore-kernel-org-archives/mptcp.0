Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C05257A
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 13:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0SwOuS9Zk3CWOAUVsM7rGh8nUa7OP+W72r6k6RzvtXfhJrCENYzC5zboeGd4aMLI2VjX+ewD94WyDgS9p2DBf0z2LIk35FvBhwqjVLBZnoS9c8wuETN6gC3/EID3J7RtL87Of2i6EBlsFN43qBz/UCXkVafYr5+d11ygqWUwt7n448Ej2gVfJFaxJe7Jf7E7uINqSgQYgBMU7e/2gAnnf86fq6OArHvT9ebGso2cRfFcbUtroQ7UYWD/rnSWzBG7rLe+vmd1Drs01qD7nABZ4ITSDRIhOkMUFHwHmkmc0uRw6ivFSxZVMGzDIdM5X+39aDZAPRb+hkW50yCCQcTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJ6J42si83t13BaxdeYjkqENRj2fVAyTMP36NzIvvbg=;
 b=AEEngaewbQmbi8JehJsUMI0QqtmkMcK+BTg1xHrxjIpY8IYnQgZXCSMt9QqpM5DjaZBAvlCuIIZTBB5/JTRyWJ3BJgLH4hpljK3zWfiL4easGL7n5xPTwx8OOI+cKT33VEW6sEVRv4rUO7IR3Qar3kor3mw39Fac3DjEs9yFaeO6yDLat22LE719tLeHBSjUcmwkeIeQUX69/cf/vw0dNz4RxFVEniOGOe2Xx7D5vJVVRG2Wp2hf2EoxvCPwGcpMYOtmeAj7lla4DHzfIWvnq8UbGQupYWOeubCVWzG/9xl7ulUXiVyDlze5HLk5QCYdHzAofPChkEwugpOF/Ix9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJ6J42si83t13BaxdeYjkqENRj2fVAyTMP36NzIvvbg=;
 b=EhhtNUwusiolgldquT8oBhXxjoeLkFw29N0KPGKlNbsyypJF6K9OhG7HrB+I6f3p2aVOYVTUr4FuucmN7w3bmd3vvyVoNml32UYkmr25yhUoh3CRdvhc24hZ8ENMCGIdOqJgmNoWoVSnhzDdu2KgM5FWJVdE1IUlhIFFtYyV/IY3vAs4+5uA30FquLSQ1M41y+Fk8NS3rNFzvHOZtfHlbmObDE0uqhvpbHX0AyMey9OmVp2TGbU7XkWgVxVOZLCvNP0tQbOEy/2bblYtPCivHcvFnSodCd8Wf9Xu2lS/U8DrtulrbONLH055jF94W2ZSvKkKTr4BWPs5gwzSq71fvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7509.eurprd04.prod.outlook.com (2603:10a6:20b:23e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 2 Dec
 2022 13:30:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 13:30:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v22 2/5] mptcp: use get_send wrapper
Date: Fri,  2 Dec 2022 21:30:14 +0800
Message-Id: <052d8257378ae7fae5e913f2c3a4007eaef1a856.1669987293.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669987293.git.geliang.tang@suse.com>
References: <cover.1669987293.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b68036-bc02-4f28-51c4-08dad469676f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Os4Fi+r+0VTCpOm2j24tDrPIie4pHsonae0CQikMVHDEOe0/qK08dGNQuAgBtsZzjXWni7+nYCJlf7AcDyMiG071/lJWRHBY8oq0q6DSsli+P0uU2nluhvHCAzVKJVKs88O+LkwAV8rsQkkGT6Fm/jLyoHIquIam6GV22TCf9/oli9FuICdUwJj18Ms4fDznv8WSnM45Gdn//bvKbfCBy+4wHh88EldhLT5v5hivhE0JbR0KARlI0s6EJfhQ7vvuJDLGYb8HF20CoNq3tCZqIdKqveazEEA7W12AdG2ndJVCAemcq/YwwSFWwU75Q5kTTzGV4TiIMLIcQqo8MBbiJ8jRu1EJ/2NhLld4CTRKOmbP7Y0OnsA67cNNslS2rwJj5+P+Z0XRypBEFyyUede7B4dcOzERWwGNoOTRtgAqTe1YC43IHf/Vwy2VjS9Q4rU2ivyIhC7HIKK6nde7nfs4k8EVKoizqNrPJQhlGTcNs2VJkwbT1Gvgi28MfXTXJg9UR0nDa9ZF4Lv9JOyFvYQtqmyJqzViIcJxpeNJstPvBZgOO5S77ocy66oqwcugKYBVU/nL4ifA04HvYAq89Afz38MJld/45daEUeWbcrPzA7C70w28EZNCHcd56NWLWk6X4VZjUxvlyHq8uV41sN7eVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(44832011)(2906002)(36756003)(316002)(83380400001)(6916009)(6486002)(8936002)(478600001)(6666004)(107886003)(66476007)(66946007)(5660300002)(2616005)(4326008)(41300700001)(8676002)(66556008)(6506007)(86362001)(38100700002)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jq+LoQLNBaKaguQllQM0IxzCukuJT/wUbJTqTecHWY9UdSnspEdv4esOMFnK?=
 =?us-ascii?Q?+iNHYUezfNFfgREVOyYloL+DZWsJJfsO7hgSg4i5CRQ2DFxqiPVNAUO1Rej2?=
 =?us-ascii?Q?UNzz+bihOZ2PLHUf5W338FbW+wjk3C2Nc3A1VwM6mQEIEoA7TnVMKNS2f1bp?=
 =?us-ascii?Q?AQUpO2mmCM8IhT3+62YgUcgLs3y4BRJMDcA5YyUCVQfLfcqZMyAdZigE3j0V?=
 =?us-ascii?Q?76EON0rrNadvcYx8YAJZUPYntg9vKZKbUAk4rR2Roq9s2BQbjbh4PbRA9F7x?=
 =?us-ascii?Q?7rsM0im3znRxv2tD/MaQVyzrbZzaWkffdvxKqombYUsAj3BHuRt3xNwrMmYv?=
 =?us-ascii?Q?8k7Wkpe2b7VDQSZSFxgE4HpvozANbUZjBgn/moedrAgk38+YeU4ZWBLa8Ocb?=
 =?us-ascii?Q?octUUGybtMAnnpAT5V68TKMvT6o4UxIEGp/lfVHdpiqFkWXqfENillMDcaNG?=
 =?us-ascii?Q?D51dUzBuqoPprV6Pd/H/9j3JMH5JQox0/w5bBEXkuftNP8eGMSkMiMO52jFi?=
 =?us-ascii?Q?Qw36lRRSrodOYjqeUgu6a31r/jeUmBiKDTMgnVolJAdNnSNTVYFIagcm++D5?=
 =?us-ascii?Q?VFKFVfp5BBltLfxSrIV+W1ju5YPCN+oPykmdpw+3JmYe+NRmluT5yU8ytubj?=
 =?us-ascii?Q?SKznPjH6VFFKJLcXcxb/+5X/4EapyJrMOWc6TXf9yVLYIfxO1PrKVleLxyg/?=
 =?us-ascii?Q?ntonqmiiwH7jg8qKaMXSo9o+Cr538WP7zzQRoNUALjtd4nV4aX3WluDoQQ9X?=
 =?us-ascii?Q?uKy7UMvKpEenyfsxUA9g1q4Rw5KWZuTdgD+a8qbaGmcyzBmLMYNuMtZQd4rp?=
 =?us-ascii?Q?ekvTHVAkg8A4KM+ROhiSttpJpqhOpfEFGuuMmrK6qwSEJ9WokmJGEJ26Rge/?=
 =?us-ascii?Q?boAEJooE9Cq4/+baUEZuK1H9thsh3w3dbfvU0TZyUHx9P0grmNBhTFOxLa+E?=
 =?us-ascii?Q?SCBusbc3YTebfDg1d2LxgrbkgmiP+AEYTd5/Yh7vij78CQ2NFVxRmTnmo2lq?=
 =?us-ascii?Q?BJlHu5nL6Js7/yKL/eTkbsL9coJVz0a7tFj7LNGLzuwtCFhScfI7Et+/vLnl?=
 =?us-ascii?Q?Jyqphe/72WxCmZkpml39RGyvgO5RfeOiqB9JtyLmEL9bkfe9SYcTvZRUd8gB?=
 =?us-ascii?Q?R7GZQlgcLT4ruT7asjplPF71JDFc3rBv5m5aP7lL9tLGVa1JllvbxNaTSYVK?=
 =?us-ascii?Q?Y8ANdrZR8m0jQtdcLLAwRRLxgKnd4w3Vl0/y4SaSQPU5RCe6azrn7I+Sk3tf?=
 =?us-ascii?Q?CC+gXuKkazKtEXvyYRUCh/a4tiUbFVidKgMFUwf9IGjHbniv5yYvQ47/z3do?=
 =?us-ascii?Q?FVsozzft8HgDg1bCvzCUallahHNWfTCPHEzt6JaeBx33xKrDXoXJzHKVRX3U?=
 =?us-ascii?Q?goRINwjlyZYVEbMmAO3WOxjg7WzXpzcVZEciODFjseJVovh+YbTYWfTU/yDG?=
 =?us-ascii?Q?YEByX1sHFrjwuNeHtl8wiyyKExrwox9AIJYvPlxuTPLcSW80isfsXzUnSym0?=
 =?us-ascii?Q?GpVBtEi+7P9arv7cC+lhNmkkIEA83pc+3ihCEn56I5qcntAS5reMT1Z8ijuK?=
 =?us-ascii?Q?zt7Ekah69jD2QqNj3huPI7AjOKUVoMqoxdxfPn0ERfBncydVoevURbFkmoe5?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b68036-bc02-4f28-51c4-08dad469676f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 13:30:40.0068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxqufriKVflMfSWi7Fq+/ek78C3xI4AsvkJSnG//dCm1CL4aJsYW2dbirfLT5rMPut/YC9VEjprCuUAESSTv5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7509

This patch adds the multiple subflows support for __mptcp_push_pending
and __mptcp_subflow_push_pending. Use get_send() wrapper instead of
mptcp_subflow_get_send() in them.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Move sock_owned_by_me() check and fallback check into get_send() wrapper
from mptcp_subflow_get_send().

This commit allows the scheduler to set the subflow->scheduled bit in
multiple subflows, but it does not allow for sending redundant data.
Multiple scheduled subflows will send sequential data on each subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 129 +++++++++++++++++++++++++++----------------
 net/mptcp/sched.c    |  13 +++++
 2 files changed, 95 insertions(+), 47 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d8ad68dd504a..cef6086c7f40 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1408,15 +1408,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	sock_owned_by_me(sk);
-
-	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -1563,47 +1554,61 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
+	int push_count = 1;
 
-	while (mptcp_send_head(sk)) {
+	while (mptcp_send_head(sk) && (push_count > 0)) {
 		int ret = 0;
 
-		prev_ssk = ssk;
-		ssk = mptcp_subflow_get_send(msk);
+		if (mptcp_sched_get_send(msk))
+			break;
 
-		/* First check. If the ssk has changed since
-		 * the last round, release prev_ssk
-		 */
-		if (ssk != prev_ssk && prev_ssk)
-			mptcp_push_release(prev_ssk, &info);
-		if (!ssk)
-			goto out;
+		push_count = 0;
 
-		/* Need to lock the new subflow only if different
-		 * from the previous one, otherwise we are still
-		 * helding the relevant lock
-		 */
-		if (ssk != prev_ssk)
-			lock_sock(ssk);
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				prev_ssk = ssk;
+				ssk = mptcp_subflow_tcp_sock(subflow);
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			mptcp_push_release(ssk, &info);
-			goto out;
+				if (ssk != prev_ssk) {
+					/* First check. If the ssk has changed since
+					 * the last round, release prev_ssk
+					 */
+					if (prev_ssk)
+						mptcp_push_release(prev_ssk, &info);
+
+					/* Need to lock the new subflow only if different
+					 * from the previous one, otherwise we are still
+					 * helding the relevant lock
+					 */
+					lock_sock(ssk);
+				}
+
+				push_count++;
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret != -EAGAIN ||
+					    (1 << ssk->sk_state) &
+					     (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSE))
+						push_count--;
+					continue;
+				}
+				do_check_data_fin = true;
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
-		do_check_data_fin = true;
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
 	if (ssk)
 		mptcp_push_release(ssk, &info);
 
-out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
@@ -1614,33 +1619,63 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct sock *xmit_ssk;
+	bool push = true;
 	int copied = 0;
 
 	info.flags = 0;
-	while (mptcp_send_head(sk)) {
+	while (mptcp_send_head(sk) && push) {
+		bool delegate = false;
 		int ret = 0;
 
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
 		 */
-		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-		if (!xmit_ssk)
-			goto out;
-		if (xmit_ssk != ssk) {
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-					       MPTCP_DELEGATE_SEND);
-			goto out;
+		if (first) {
+			ret = __subflow_push_pending(sk, ssk, &info);
+			first = false;
+			if (ret <= 0)
+				break;
+			copied += ret;
+			msk->last_snd = ssk;
+			continue;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		first = false;
-		if (ret <= 0)
-			break;
-		copied += ret;
+		if (mptcp_sched_get_send(msk))
+			goto out;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
+
+				if (xmit_ssk != ssk) {
+					/* Only delegate to one subflow recently,
+					 * TODO: chain delegated calls for more subflows.
+					 */
+					if (delegate)
+						goto out;
+					mptcp_subflow_delegate(subflow,
+							       MPTCP_DELEGATE_SEND);
+					msk->last_snd = ssk;
+					mptcp_subflow_set_scheduled(subflow, false);
+					delegate = true;
+					push = false;
+					continue;
+				}
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					push = false;
+					continue;
+				}
+				copied += ret;
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
+		}
 	}
 
 out:
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c4006f142f10..18518a81afb3 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -118,6 +118,19 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_send */
+	if (__mptcp_check_fallback(msk)) {
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return 0;
+		}
+		return -EINVAL;
+	}
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;
-- 
2.35.3

