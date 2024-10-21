Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90701E1C11;
	Mon, 21 Oct 2024 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504258; cv=none; b=I+54ZrzOk4TJ/2mj62cI4ydYUKncKRwQzcDS0gduIjmZVwGh3NOobcPD9RGA2ygUo8aGFltMfMT/jhnJN5B5KE3suWXcsWcySzQQtrbIfgqUiVLiTDLCd9EZWm3ScR5QaAuAjHaCbOsHt3MSuNFRlO/aWITTGy5I6rFTS8PeZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504258; c=relaxed/simple;
	bh=HSFI81wowXPb77zvrh9eMsUTxd7gGu+NiUYeL+g78WQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ffHzNe6CxmiMzgCD9e/IgT6hmxRS67nzdc7T9nbtGBlaAHx5ptBZzaCi0igDPoNhdk1gBqvHmPR4EiORcg6K0pyiIgVkFWs+5CovTJ2yspvmm1AQIKGGKs0NKnAo9ZH9YJS38fUEoqiXBClbK7bVPdWFRsLFQ5sUCq8GfzlQsD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MQM6HEK3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MQM6HEK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6898EC4CEC7;
	Mon, 21 Oct 2024 09:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729504257;
	bh=HSFI81wowXPb77zvrh9eMsUTxd7gGu+NiUYeL+g78WQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=MQM6HEK3JQ4+DkLe+EWtz8sQqu7fPr41QkWs1W/BT09Wun3hgipgf7rZMuyvIVEpA
	 ZuL5yrzi4Tfc6CMox/lwuFCUjzcZOA1AERplsLuOCPcPo3KITr5kwHt0AT1jny8AQO
	 5hn3J9GJJDMeKdP6pTXflnP7IK2CX9iVvnHVTfgY=
Subject: Patch "mptcp: track and update contiguous data status" has been added to the 5.10-stable tree
To: davem@davemloft.net,geliang.tang@suse.com,gregkh@linuxfoundation.org,mathew.j.martineau@linux.intel.com,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 11:50:47 +0200
In-Reply-To: <20241019102905.3383483-6-matttbe@kernel.org>
Message-ID: <2024102147-cubicle-greedy-b09a@gregkh>
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

    mptcp: track and update contiguous data status

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-track-and-update-contiguous-data-status.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-86909-greg=kroah.com@vger.kernel.org Sat Oct 19 12:29:21 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Oct 2024 12:29:07 +0200
Subject: mptcp: track and update contiguous data status
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>, sashal@kernel.org, Paolo Abeni <pabeni@redhat.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Matthieu Baerts <matttbe@kernel.org>
Message-ID: <20241019102905.3383483-6-matttbe@kernel.org>

From: Geliang Tang <geliang.tang@suse.com>

commit 0530020a7c8f2204e784f0dbdc882bbd961fdbde upstream.

This patch adds a new member allow_infinite_fallback in mptcp_sock,
which is initialized to 'true' when the connection begins and is set
to 'false' on any retransmit or successful MP_JOIN. Only do infinite
mapping fallback if there is a single subflow AND there have been no
retransmissions AND there have never been any MP_JOINs.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
[ Conflicts in protocol.c, because commit 3e5014909b56 ("mptcp: cleanup
  MPJ subflow list handling") is not in this version. This commit is
  linked to a new feature, changing the context around. The new line
  can still be added at the same place.
  Conflicts in protocol.h, because commit 4f6e14bd19d6 ("mptcp: support
  TCP_CORK and TCP_NODELAY") is not in this version. This commit is
  linked to a new feature, changing the context around. The new line can
  still be added at the same place.
  Conflicts in subflow.c, because commit 0348c690ed37 ("mptcp: add the
  fallback check") is not in this version. This commit is linked to a
  new feature, changing the context around. The new line can still be
  added at the same place.
  Extra conflicts in v5.10, because the context has been changed. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    6 +++++-
 net/mptcp/protocol.h |    1 +
 net/mptcp/subflow.c  |    1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1810,9 +1810,11 @@ static void mptcp_worker(struct work_str
 		if (!mptcp_ext_cache_refill(msk))
 			break;
 	}
-	if (copied)
+	if (copied) {
 		tcp_push(ssk, msg.msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
+		WRITE_ONCE(msk->allow_infinite_fallback, false);
+	}
 
 	dfrag->data_seq = orig_write_seq;
 	dfrag->offset = orig_offset;
@@ -1845,6 +1847,7 @@ static int __mptcp_init_sock(struct sock
 
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
+	WRITE_ONCE(msk->allow_infinite_fallback, true);
 
 	mptcp_pm_data_init(msk);
 
@@ -2543,6 +2546,7 @@ bool mptcp_finish_join(struct sock *sk)
 	if (parent_sock && !sk->sk_socket)
 		mptcp_sock_graft(sk, parent_sock);
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	return true;
 }
 
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -213,6 +213,7 @@ struct mptcp_sock {
 	bool		rcv_data_fin;
 	bool		snd_data_fin_enable;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
+	bool		allow_infinite_fallback;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1179,6 +1179,7 @@ int __mptcp_subflow_connect(struct sock
 	list_add_tail(&subflow->node, &msk->join_list);
 	spin_unlock_bh(&msk->join_list_lock);
 
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	return err;
 
 failed:


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.10/mptcp-track-and-update-contiguous-data-status.patch
queue-5.10/mptcp-handle-consistently-dss-corruption.patch
queue-5.10/tcp-fix-mptcp-dss-corruption-due-to-large-pmtu-xmit.patch
