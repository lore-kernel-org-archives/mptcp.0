Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3169F1754F;
	Mon,  4 Mar 2024 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540783; cv=none; b=Nr8HAzQ6Z99B5JKWJhNCezV4QA6hzKjP4nxx14h26QhgjOtXSQJY2KuGOwFVsRdjmQk+TVeluaq9ZpknDK7iL8FvnI0ayO02sHg6Q2g80SkgERv+prcmiK0DpUZZXU13sEuuz3koGdB6KarkBTimhpSuS/E5DCGy0E7om8wXtuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540783; c=relaxed/simple;
	bh=u2d3iDyCibGC/QPgl0gXJ8IOUhnxC9ZtcMFxl7Y7i3U=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=f2fsXbvVuoa+Q4seA5PE8LSG39d6rtG0yUFI3QtTf7ot+krMSdXGDG5YWZ4tpQqVPPhgCaeB2w3eS3DzRdCSCUr+NZ0h/Ry59dlk032tNWeVgaI9lBgOIXU1cVu5NjkP98YeB7tUyxLttNDL3LGIZCxMm8d9hpHgVeqKQtzh+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OBShbfc6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OBShbfc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C41C433C7;
	Mon,  4 Mar 2024 08:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709540782;
	bh=u2d3iDyCibGC/QPgl0gXJ8IOUhnxC9ZtcMFxl7Y7i3U=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=OBShbfc6U3TS3JcZPm794RcKQuz3pG/XNd3ii+baflMERnusNQegmHy79pAf6SL4U
	 u6VDOPNlUs5MikrmI0V+Fd4S4Xg4MvRsb9PhCgBhKxSgr5g5Ki9Zu6p0jcSWigGRcb
	 ATT7zd588/Yje+hAhBX2tCgrf9aGZmx581XHihO8=
Subject: Patch "mptcp: process pending subflow error on close" has been added to the 5.15-stable tree
To: davem@davemloft.net,gregkh@linuxfoundation.org,martineau@kernel.org,matthieu.baerts@tessares.net,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 09:26:09 +0100
In-Reply-To: <20240228173317.257282-2-matttbe@kernel.org>
Message-ID: <2024030409-sandstorm-wool-af16@gregkh>
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

    mptcp: process pending subflow error on close

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-process-pending-subflow-error-on-close.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-25403-greg=kroah.com@vger.kernel.org Wed Feb 28 18:33:29 2024
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Feb 2024 18:33:18 +0100
Subject: mptcp: process pending subflow error on close
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, Matthieu Baerts <matthieu.baerts@tessares.net>, "David S . Miller" <davem@davemloft.net>, Matthieu Baerts <matttbe@kernel.org>
Message-ID: <20240228173317.257282-2-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 9f1a98813b4b686482e5ef3c9d998581cace0ba6 upstream.

On incoming TCP reset, subflow closing could happen before error
propagation. That in turn could cause the socket error being ignored,
and a missing socket state transition, as reported by Daire-Byrne.

Address the issues explicitly checking for subflow socket error at
close time. To avoid code duplication, factor-out of __mptcp_error_report()
a new helper implementing the relevant bits.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/429
Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   63 +++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -688,40 +688,44 @@ static bool __mptcp_ofo_queue(struct mpt
 	return moved;
 }
 
-void __mptcp_error_report(struct sock *sk)
+static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow;
-	struct mptcp_sock *msk = mptcp_sk(sk);
+	int err = sock_error(ssk);
+	int ssk_state;
 
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		int err = sock_error(ssk);
-		int ssk_state;
+	if (!err)
+		return false;
 
-		if (!err)
-			continue;
+	/* only propagate errors on fallen-back sockets or
+	 * on MPC connect
+	 */
+	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
+		return false;
 
-		/* only propagate errors on fallen-back sockets or
-		 * on MPC connect
-		 */
-		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
-			continue;
+	/* We need to propagate only transition to CLOSE state.
+	 * Orphaned socket will see such state change via
+	 * subflow_sched_work_if_closed() and that path will properly
+	 * destroy the msk as needed.
+	 */
+	ssk_state = inet_sk_state_load(ssk);
+	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+		inet_sk_state_store(sk, ssk_state);
+	WRITE_ONCE(sk->sk_err, -err);
+
+	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+	smp_wmb();
+	sk_error_report(sk);
+	return true;
+}
 
-		/* We need to propagate only transition to CLOSE state.
-		 * Orphaned socket will see such state change via
-		 * subflow_sched_work_if_closed() and that path will properly
-		 * destroy the msk as needed.
-		 */
-		ssk_state = inet_sk_state_load(ssk);
-		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-			inet_sk_state_store(sk, ssk_state);
-		WRITE_ONCE(sk->sk_err, -err);
-
-		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
-		break;
-	}
+void __mptcp_error_report(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow(msk, subflow)
+		if (__mptcp_subflow_error_report(sk, mptcp_subflow_tcp_sock(subflow)))
+			break;
 }
 
 /* In most cases we will be able to lock the mptcp socket.  If its already
@@ -2309,6 +2313,7 @@ static void __mptcp_close_ssk(struct soc
 		/* close acquired an extra ref */
 		__sock_put(ssk);
 	}
+	__mptcp_subflow_error_report(sk, ssk);
 	release_sock(ssk);
 
 	sock_put(ssk);


Patches currently in stable-queue which might be from kroah.com@vger.kernel.org are

queue-5.15/selftests-mptcp-add-missing-kconfig-for-nf-filter.patch
queue-5.15/selftests-mptcp-add-missing-kconfig-for-nf-filter-in-v6.patch
queue-5.15/mptcp-add-needs_id-for-netlink-appending-addr.patch
queue-5.15/mptcp-rename-timer-related-helper-to-less-confusing-names.patch
queue-5.15/mptcp-process-pending-subflow-error-on-close.patch
queue-5.15/mptcp-clean-up-harmless-false-expressions.patch
queue-5.15/mptcp-move-__mptcp_error_report-in-protocol.c.patch
