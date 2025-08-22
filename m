Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C362FC86E;
	Fri, 22 Aug 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868300; cv=none; b=id5pCaY3OpnMZLNc1j5UY+fJfIv7E+KKKpGtyM8PaN0lxvPx24X3FMGxvG1OOgX1mFw3LsMMXierUgoyFeJbDFtatG0hhxK5IsfQt4LduZTcDsyusasGd94n/lEri07zGr6QQK0IJiF0sbAeaJx8FuhphKgPQyUWVw+iAlo62Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868300; c=relaxed/simple;
	bh=iFFsIwGTa6EJfURqoriUqvKOqER6DhHtsvi0xiF3O34=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=hU6ZkaJDHYYx1iNkPKj4h1pdsUaRCfoEjvSS4qoR9fqQeVhlabgcpk5wVfL1JKNjqiSC/PNCzvBvfTwiru1KUGk1aQYaGcIa6VxJjH65XM9E0Stu4ZaL6V4Mz2scGn5cPp71r6gvOZ6uXjKBUJpzrbL44NxZiyLu4h5tte9KPg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1fFnF0Ov; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1fFnF0Ov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE66C4CEED;
	Fri, 22 Aug 2025 13:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755868300;
	bh=iFFsIwGTa6EJfURqoriUqvKOqER6DhHtsvi0xiF3O34=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=1fFnF0OviD4MvdW2bVKEO/jq5k4H7/WREqZrQVk7OnHlC0M4ixMXoXTQzCuoOZfC4
	 YTppQ0kMR4LaC+es7VryFpKmi5nu4Alvsm06bs2vYeG7DxmWX1DIA6KnYjfgNZxLgu
	 K8gK5PmNm0LW9s7k5UiJPKbRqDxhHqhSC+3fIB9k=
Subject: Patch "mptcp: plug races between subflow fail and subflow creation" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 15:11:07 +0200
In-Reply-To: <20250728132919.3904847-7-matttbe@kernel.org>
Message-ID: <2025082206-ended-cartwheel-090f@gregkh>
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

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-plug-races-between-subflow-fail-and-subflow-creation.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-164936-greg=kroah.com@vger.kernel.org Mon Jul 28 15:29:45 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 28 Jul 2025 15:29:22 +0200
Subject: mptcp: plug races between subflow fail and subflow creation
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250728132919.3904847-7-matttbe@kernel.org>

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
  be applied. Same in protocol.h with commit b8dc6d6ce931 ("mptcp: fix
  rcv buffer auto-tuning"). Conflicts in protocol.c because commit
  ee2708aedad0 ("mptcp: use get_retrans wrapper") is not in this version
  and refactor the code in __mptcp_retrans(), but the modification can
  still be applied, just not at the same indentation level. ]
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
@@ -309,8 +309,14 @@ void mptcp_pm_mp_fail_received(struct so
 
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
@@ -885,7 +885,7 @@ void mptcp_data_ready(struct sock *sk, s
 static void mptcp_subflow_joined(struct mptcp_sock *msk, struct sock *ssk)
 {
 	mptcp_subflow_ctx(ssk)->map_seq = READ_ONCE(msk->ack_seq);
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	msk->allow_infinite_fallback = false;
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 }
 
@@ -897,7 +897,7 @@ static bool __mptcp_finish_join(struct m
 		return false;
 
 	spin_lock_bh(&msk->fallback_lock);
-	if (__mptcp_check_fallback(msk)) {
+	if (!msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);
 		return false;
 	}
@@ -2707,7 +2707,7 @@ static void __mptcp_retrans(struct sock
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
+		msk->allow_infinite_fallback = false;
 	}
 	spin_unlock_bh(&msk->fallback_lock);
 
@@ -2835,7 +2835,8 @@ static int __mptcp_init_sock(struct sock
 	WRITE_ONCE(msk->first, NULL);
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
-	WRITE_ONCE(msk->allow_infinite_fallback, true);
+	msk->allow_infinite_fallback = true;
+	msk->allow_subflows = true;
 	msk->recovery = false;
 
 	mptcp_pm_data_init(msk);
@@ -3673,7 +3674,7 @@ bool mptcp_finish_join(struct sock *ssk)
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
@@ -314,12 +314,14 @@ struct mptcp_sock {
 		u64	time;	/* start time of measurement window */
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
+	bool		allow_subflows;
 
 	u32 setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
 
-	spinlock_t	fallback_lock;	/* protects fallback and
-					 * allow_infinite_fallback
+	spinlock_t	fallback_lock;	/* protects fallback,
+					 * allow_infinite_fallback and
+					 * allow_join
 					 */
 };
 
@@ -991,6 +993,7 @@ static inline bool __mptcp_try_fallback(
 		return false;
 	}
 
+	msk->allow_subflows = false;
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 	spin_unlock_bh(&msk->fallback_lock);
 	return true;
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1168,20 +1168,29 @@ static void subflow_sched_work_if_closed
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
@@ -1193,6 +1202,7 @@ static void mptcp_subflow_fail(struct mp
 	tcp_send_ack(ssk);
 
 	mptcp_reset_tout_timer(msk, subflow->fail_tout);
+	return true;
 }
 
 static bool subflow_check_data_avail(struct sock *ssk)
@@ -1261,12 +1271,11 @@ fallback:
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

queue-6.1/mptcp-drop-skb-if-mptcp-skb-extension-allocation-fails.patch
queue-6.1/mptcp-pm-kernel-flush-do-not-reset-add_addr-limit.patch
queue-6.1/mptcp-plug-races-between-subflow-fail-and-subflow-creation.patch
queue-6.1/mptcp-make-fallback-action-and-fallback-decision-atomic.patch
queue-6.1/mptcp-reset-fallback-status-gracefully-at-disconnect-time.patch
