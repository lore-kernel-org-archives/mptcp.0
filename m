Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE171D1727;
	Mon, 21 Oct 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504294; cv=none; b=JKDtDS648z8Cy1NcvUsV4G2c6Bchyd0t9DZVESmRUx/p/KQVLnhlCE6VnvKEfuV5DJ51rsmzogNhWOtAcAX1cTEAylQVFUhTOywrxdKS18C+yFnpiZkhbpFCIO5u/GDHxxj3n/wS7C3CGvIZ299CexySPgmbHqBjZTlDI6Cj7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504294; c=relaxed/simple;
	bh=IJpCuprDj4+jfqdENwv43LSYBD7BRgoO4nM+duiJ4es=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=KbT7KlkgXbbMQCLd9hIkP9bz9eubt/q3Yx1iUQHIRhsb7rrITKP/pw/2Xt0pDUouKERZgbIiR9ggP16rUsWYBIwZiYt3YJXtzQjGZAbYsOal7WssIztky6DgrQ5NWKl/L1xpaLVFX2h/ErX9gyQFKY8oGPU4/WZ6Uh6RXOGuJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pac09Ccv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pac09Ccv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F36CC4CEC3;
	Mon, 21 Oct 2024 09:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729504293;
	bh=IJpCuprDj4+jfqdENwv43LSYBD7BRgoO4nM+duiJ4es=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=Pac09CcvRqFQ0CAGI/N29DOuQdMS8grUmiOD6suhQ3Y2eyZihS9fHKF5klIBLzHzI
	 qABO7BoK3nM2cS/0CKb4SgrEk736s+efiVl8sdZMA+x2x/VoOF5VLeh7EIkuUcj2cY
	 9NVlb8sMRoltD77XZglANqpEY1UOhqoN9Qv0SHYo=
Subject: Patch "mptcp: track and update contiguous data status" has been added to the 5.15-stable tree
To: davem@davemloft.net,geliang.tang@suse.com,gregkh@linuxfoundation.org,mathew.j.martineau@linux.intel.com,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 11:50:59 +0200
In-Reply-To: <20241019093045.3181989-9-matttbe@kernel.org>
Message-ID: <2024102158-snowless-uncork-fe7c@gregkh>
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

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-track-and-update-contiguous-data-status.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-86901-greg=kroah.com@vger.kernel.org Sat Oct 19 11:31:00 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Oct 2024 11:30:47 +0200
Subject: mptcp: track and update contiguous data status
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Geliang Tang <geliang.tang@suse.com>, sashal@kernel.org, Paolo Abeni <pabeni@redhat.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Matthieu Baerts <matttbe@kernel.org>
Message-ID: <20241019093045.3181989-9-matttbe@kernel.org>

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
  added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    3 +++
 net/mptcp/protocol.h |    1 +
 net/mptcp/subflow.c  |    4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2472,6 +2472,7 @@ static void __mptcp_retrans(struct sock
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+		WRITE_ONCE(msk->allow_infinite_fallback, false);
 	}
 
 	release_sock(ssk);
@@ -2549,6 +2550,7 @@ static int __mptcp_init_sock(struct sock
 	msk->first = NULL;
 	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
+	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery = false;
 
 	mptcp_pm_data_init(msk);
@@ -3299,6 +3301,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	if (parent_sock && !ssk->sk_socket)
 		mptcp_sock_graft(ssk, parent_sock);
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 out:
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 	return true;
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -249,6 +249,7 @@ struct mptcp_sock {
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
+	bool		allow_infinite_fallback;
 	spinlock_t	join_list_lock;
 	int		keepalive_cnt;
 	int		keepalive_idle;
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1219,7 +1219,8 @@ no_data:
 fallback:
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk)) {
+		if (mptcp_has_another_subflow(ssk) ||
+		    !READ_ONCE(msk->allow_infinite_fallback)) {
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 		}
@@ -1481,6 +1482,7 @@ int __mptcp_subflow_connect(struct sock
 	/* discard the subflow socket */
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
+	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	return err;
 
 failed_unlink:


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-track-and-update-contiguous-data-status.patch
queue-5.15/mptcp-fallback-when-mptcp-opts-are-dropped-after-1st-data.patch
queue-5.15/mptcp-handle-consistently-dss-corruption.patch
queue-5.15/tcp-fix-mptcp-dss-corruption-due-to-large-pmtu-xmit.patch
queue-5.15/mptcp-pm-fix-uaf-read-in-mptcp_pm_nl_rm_addr_or_subflow.patch
queue-5.15/mptcp-prevent-mpc-handshake-on-port-based-signal-endpoints.patch
