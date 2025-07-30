Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E219E7E1;
	Wed, 30 Jul 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866807; cv=none; b=tlQ1EL/VfG2CoY3swFDgJvAH3S11nIIxvKCFPI6v3mm/asDPqFE/cWls8jgdjbVRSmsmMsTgh9kBnvny/dQ8plhNv94Kox3G81lPm9cborg6YVmoPvs5+DcCL66SMUwvj6LcKWhynokeT5UI30YS2KLLuHoxZo5+cpVp5OvkPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866807; c=relaxed/simple;
	bh=dhrlOavkcszK1F7/sxgwWsQZ/f4OQbnKugfdH6bAenc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=X3d/iCxQVsjNNz9qjAX+luTmwT3yiHngJp546lhenjcc6FjIWwbBgPNwb0DLoxe65Y4mJDmNEbrprtSMbrikp3wrUJKS7jOjV73o90+c/9UrO7tNS5KBTcVfMuydQgn5MCwm036iO1r5hPp+V7v9NeIvtToCaiqJhq1dg6oRepU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jwZtf3g6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jwZtf3g6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183CDC4CEF5;
	Wed, 30 Jul 2025 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753866806;
	bh=dhrlOavkcszK1F7/sxgwWsQZ/f4OQbnKugfdH6bAenc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=jwZtf3g6NwM/dhCB/n5CUohj+mfjytWLbjgr/3QYSz6h7YV/HA5gvK/P3t0EVY0dQ
	 r1OZgeencEsEQsvnn4WXM5zL4t+3g/gYMifZNjoCTbLW/hklaR5D1DY+hO2EtAAm7D
	 fqzIWR+13lKx73G4URRyZ40sT2g4EiDstKLbmsfo=
Subject: Patch "mptcp: plug races between subflow fail and subflow creation" has been added to the 6.6-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Jul 2025 11:13:04 +0200
In-Reply-To: <20250728091448.3494479-7-matttbe@kernel.org>
Message-ID: <2025073004-difficult-cardinal-acbb@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mptcp: plug races between subflow fail and subflow creation

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-plug-races-between-subflow-fail-and-subflow-creation.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From matttbe@kernel.org Mon Jul 28 11:15:30 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 28 Jul 2025 11:14:50 +0200
Subject: mptcp: plug races between subflow fail and subflow creation
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250728091448.3494479-7-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit def5b7b2643ebba696fc60ddf675dca13f073486 upstream.

We have races similar to the one addressed by the previous patch between
subflow failing and additional subflow creation. They are just harder to
trigger.

The solution is similar. Use a separate flag to track the condition
'socket state prevent any additional subflow creation' protected by the
fallback lock.

The socket fallback makes such flag true, and also receiving or sending
an MP_FAIL option.

The field 'allow_infinite_fallback' is now always touched under the
relevant lock, we can drop the ONCE annotation on write.

Fixes: 478d770008b0 ("mptcp: send out MP_FAIL when data checksum fails")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250714-net-mptcp-fallback-races-v1-2-391aff963322@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in subflow.c, because commit f1f26512a9bf ("mptcp: use plain
  bool instead of custom binary enum") and commit 46a5d3abedbe
  ("mptcp: fix typos in comments") are not in this version. Both are
  causing conflicts in the context, and the same modifications can still
  be applied. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/pm.c       |    8 +++++++-
 net/mptcp/protocol.c |   11 ++++++-----
 net/mptcp/protocol.h |    7 +++++--
 net/mptcp/subflow.c  |   19 ++++++++++++++-----
 4 files changed, 32 insertions(+), 13 deletions(-)

--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -304,8 +304,14 @@ void mptcp_pm_mp_fail_received(struct so
 
 	pr_debug("fail_seq=%llu\n", fail_seq);
 
-	if (!READ_ONCE(msk->allow_infinite_fallback))
+	/* After accepting the fail, we can't create any other subflows */
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
 		return;
+	}
+	msk->allow_subflows = false;
+	spin_unlock_bh(&msk->fallback_lock);
 
 	if (!subflow->fail_tout) {
 		pr_debug("send MP_FAIL response and infinite map\n");
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -875,7 +875,7 @@ void mptcp_data_ready(struct sock *sk, s
 static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
 {
 	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	msk->allow_infinite_fallback = false;
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
 
@@ -887,7 +887,7 @@ static bool __mptcp_finish_join(struct m
 		return false;
 
 	spin_lock_bh(&msk->fallback_lock);
-	if (__mptcp_check_fallback(msk)) {
+	if (!msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);
 		return false;
 	}
@@ -2688,7 +2688,7 @@ static void __mptcp_retrans(struct sock
 				len = max(copied, len);
 				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 					 info.size_goal);
-				WRITE_ONCE(msk->allow_infinite_fallback, false);
+				msk->allow_infinite_fallback = false;
 			}
 			spin_unlock_bh(&msk->fallback_lock);
 
@@ -2819,7 +2819,8 @@ static void __mptcp_init_sock(struct soc
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
-	WRITE_ONCE(msk->allow_infinite_fallback, true);
+	msk->allow_infinite_fallback = true;
+	msk->allow_subflows = true;
 	msk->recovery = false;
 	msk->subflow_id = 1;
 
@@ -3624,7 +3625,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
 		spin_lock_bh(&msk->fallback_lock);
-		if (__mptcp_check_fallback(msk)) {
+		if (!msk->allow_subflows) {
 			spin_unlock_bh(&msk->fallback_lock);
 			return false;
 		}
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -330,13 +330,15 @@ struct mptcp_sock {
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
 	u8		scaling_ratio;
+	bool		allow_subflows;
 
 	u32		subflow_id;
 	u32		setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
 
-	spinlock_t	fallback_lock;	/* protects fallback and
-					 * allow_infinite_fallback
+	spinlock_t	fallback_lock;	/* protects fallback,
+					 * allow_infinite_fallback and
+					 * allow_join
 					 */
 };
 
@@ -1113,6 +1115,7 @@ static inline bool __mptcp_try_fallback(
 		return false;
 	}
 
+	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 	spin_unlock_bh(&msk->fallback_lock);
 	return true;
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1257,20 +1257,29 @@ static void subflow_sched_work_if_closed
 		mptcp_schedule_work(sk);
 }
 
-static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
+static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	unsigned long fail_tout;
 
+	/* we are really failing, prevent any later subflow join */
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+	msk->allow_subflows = false;
+	spin_unlock_bh(&msk->fallback_lock);
+
 	/* greceful failure can happen only on the MPC subflow */
 	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
-		return;
+		return false;
 
 	/* since the close timeout take precedence on the fail one,
 	 * no need to start the latter when the first is already set
 	 */
 	if (sock_flag((struct sock *)msk, SOCK_DEAD))
-		return;
+		return true;
 
 	/* we don't need extreme accuracy here, use a zero fail_tout as special
 	 * value meaning no fail timeout at all;
@@ -1282,6 +1291,7 @@ static void mptcp_subflow_fail(struct mp
 	tcp_send_ack(ssk);
 
 	mptcp_reset_tout_timer(msk, subflow->fail_tout);
+	return true;
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)
@@ -1342,12 +1352,11 @@ fallback:
 		    (subflow->mp_join || subflow->valid_csum_seen)) {
 			subflow->send_mp_fail = 1;
 
-			if (!READ_ONCE(msk->allow_infinite_fallback)) {
+			if (!mptcp_subflow_fail(msk, ssk)) {
 				subflow->reset_transient = 0;
 				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
 				goto reset;
 			}
-			mptcp_subflow_fail(msk, ssk);
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
 			return true;
 		}


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/selftests-mptcp-connect-also-cover-alt-modes.patch
queue-6.6/selftests-mptcp-connect-also-cover-checksum.patch
queue-6.6/mptcp-plug-races-between-subflow-fail-and-subflow-creation.patch
queue-6.6/mptcp-make-fallback-action-and-fallback-decision-atomic.patch
queue-6.6/mptcp-reset-fallback-status-gracefully-at-disconnect-time.patch
