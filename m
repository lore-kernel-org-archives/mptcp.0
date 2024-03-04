Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D779DF;
	Mon,  4 Mar 2024 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540786; cv=none; b=tnvNpgdIpGfFqzJ5zvCP06W11l6k4ma2XCpT4sa2KF+u/yXQPi/uaA8Jt96AX/wcCRSyZXU9YO5k79KzqxaKNOFrLTqwRVBj4DYeQ3NRKjeYYILTLRC38G6iiuz9SZmqlUhHjCSf7//4hhsWex94tIZ8m0Xt7PPtgfDqWQ3TXZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540786; c=relaxed/simple;
	bh=9FlXTSQx7IhdjGZefas53xEeeqGrAhXyCCPnI09Yufs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=L1A5GaJCQm+bC8NGYFlA1YQe9GS6MQvhZaGTsUSdoV4ELbtRXVqbeon0oFq2G4d10VSEYS1A1wsmn8ZYZK+CAhLDaQTi06o/ymTtyZ4Jn8QB+5XkN0uCaS7cbF90YJLtd0GAakknLJkE4XWjR46ZTVDk7ZkOXKp7zqZGws/t3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dv2D2fC7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dv2D2fC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216EFC433C7;
	Mon,  4 Mar 2024 08:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709540785;
	bh=9FlXTSQx7IhdjGZefas53xEeeqGrAhXyCCPnI09Yufs=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=Dv2D2fC71CpxtmG9rtkz1ElapzFe3EAhTp1/hQpjw0k6N6cuyVLNnvAopodA9lSSf
	 byHnw/j5eVBXrbnLnBZYwfEijHUc5DD029Id3j6rApEYvvWmusSsvS0oV8z4C2yR5T
	 MH0yT9D25RGHe4il26TCZgZKIa4xR7dHBvgzKU1E=
Subject: Patch "mptcp: rename timer related helper to less confusing names" has been added to the 5.15-stable tree
To: davem@davemloft.net,gregkh@linuxfoundation.org,martineau@kernel.org,matthieu.baerts@tessares.net,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 09:26:09 +0100
In-Reply-To: <20240228173355.258080-2-matttbe@kernel.org>
Message-ID: <2024030409-console-popsicle-a34a@gregkh>
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

    mptcp: rename timer related helper to less confusing names

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-rename-timer-related-helper-to-less-confusing-names.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-25404-greg=kroah.com@vger.kernel.org Wed Feb 28 18:34:38 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Feb 2024 18:33:56 +0100
Subject: mptcp: rename timer related helper to less confusing names
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau <martineau@kernel.org>, "David S . Miller" <davem@davemloft.net>, Matthieu Baerts <matttbe@kernel.org>
Message-ID: <20240228173355.258080-2-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit f6909dc1c1f4452879278128012da6c76bc186a5 upstream.

The msk socket uses to different timeout to track close related
events and retransmissions. The existing helpers do not indicate
clearly which timer they actually touch, making the related code
quite confusing.

Change the existing helpers name to avoid such confusion. No
functional change intended.

This patch is linked to the next one ("mptcp: fix dangling connection
hang-up"). The two patches are supposed to be backported together.

Cc: stable@vger.kernel.org # v5.11+
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -330,7 +330,7 @@ drop:
 	return false;
 }
 
-static void mptcp_stop_timer(struct sock *sk)
+static void mptcp_stop_rtx_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -830,12 +830,12 @@ static void mptcp_flush_join_list(struct
 	mptcp_sockopt_sync_all(msk);
 }
 
-static bool mptcp_timer_pending(struct sock *sk)
+static bool mptcp_rtx_timer_pending(struct sock *sk)
 {
 	return timer_pending(&inet_csk(sk)->icsk_retransmit_timer);
 }
 
-static void mptcp_reset_timer(struct sock *sk)
+static void mptcp_reset_rtx_timer(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	unsigned long tout;
@@ -1145,10 +1145,10 @@ out:
 		__mptcp_mem_reclaim_partial(sk);
 
 	if (snd_una == READ_ONCE(msk->snd_nxt) && !msk->recovery) {
-		if (mptcp_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
-			mptcp_stop_timer(sk);
+		if (mptcp_rtx_timer_pending(sk) && !mptcp_data_fin_enabled(msk))
+			mptcp_stop_rtx_timer(sk);
 	} else {
-		mptcp_reset_timer(sk);
+		mptcp_reset_rtx_timer(sk);
 	}
 }
 
@@ -1640,8 +1640,8 @@ void __mptcp_push_pending(struct sock *s
 
 out:
 	/* ensure the rtx timer is running */
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
+	if (!mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
 	if (copied)
 		mptcp_check_send_data_fin(sk);
 }
@@ -1700,8 +1700,8 @@ out:
 	if (copied) {
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
-		if (!mptcp_timer_pending(sk))
-			mptcp_reset_timer(sk);
+		if (!mptcp_rtx_timer_pending(sk))
+			mptcp_reset_rtx_timer(sk);
 
 		if (msk->snd_data_fin_enable &&
 		    msk->snd_nxt + 1 == msk->write_seq)
@@ -2173,7 +2173,7 @@ static void mptcp_retransmit_timer(struc
 	sock_put(sk);
 }
 
-static void mptcp_timeout_timer(struct timer_list *t)
+static void mptcp_tout_timer(struct timer_list *t)
 {
 	struct sock *sk = from_timer(sk, t, sk_timer);
 
@@ -2465,8 +2465,8 @@ static void __mptcp_retrans(struct sock
 	release_sock(ssk);
 
 reset_timer:
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
+	if (!mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
 }
 
 static void mptcp_worker(struct work_struct *work)
@@ -2543,7 +2543,7 @@ static int __mptcp_init_sock(struct sock
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
-	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
+	timer_setup(&sk->sk_timer, mptcp_tout_timer, 0);
 
 	return 0;
 }
@@ -2629,8 +2629,8 @@ void mptcp_subflow_shutdown(struct sock
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
 			tcp_send_ack(ssk);
-			if (!mptcp_timer_pending(sk))
-				mptcp_reset_timer(sk);
+			if (!mptcp_rtx_timer_pending(sk))
+				mptcp_reset_rtx_timer(sk);
 		}
 		break;
 	}


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.15/selftests-mptcp-add-missing-kconfig-for-nf-filter.patch
queue-5.15/selftests-mptcp-add-missing-kconfig-for-nf-filter-in-v6.patch
queue-5.15/mptcp-add-needs_id-for-netlink-appending-addr.patch
queue-5.15/mptcp-rename-timer-related-helper-to-less-confusing-names.patch
queue-5.15/mptcp-process-pending-subflow-error-on-close.patch
queue-5.15/mptcp-clean-up-harmless-false-expressions.patch
queue-5.15/mptcp-move-__mptcp_error_report-in-protocol.c.patch
