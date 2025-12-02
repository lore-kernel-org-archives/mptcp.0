Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359203242C8;
	Tue,  2 Dec 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691168; cv=none; b=VJoQTCEbhV9JdwHIy2cYS659kVYR5++azbfEQBpdHa8PQtzsdiLOTW4vVjQsPa7RmMOkDBTdHbk4nb34njKiE/We56fxi8IYte3NQ0y7zVTEGUHTfITJ8WFzx/rIad7uTilupP0Z8YBVQP9UfnWf53+gN9PqbPL0bHOhePp0/gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691168; c=relaxed/simple;
	bh=VaKTVo6pS/Z+f6wMzpgzQJvIoxU9JBMuppHg2p+WJMo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=l51WdjgyN0tVoiGi6hu32nceo9O1iCctJInFnmGNT11v12RRIZkn2R3l5ZOMuIdL6cn2sC/dyRnnG/eGqGjvyrCmIhNFISewBKYp+1Pv+NnvGRcz/e6rIjPzq82A4Hf4GuEC2INBr6qzh876fZy/Tt/634NwvZkmxx9cxh2uzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c5/dzWkh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c5/dzWkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A93C4CEF1;
	Tue,  2 Dec 2025 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764691168;
	bh=VaKTVo6pS/Z+f6wMzpgzQJvIoxU9JBMuppHg2p+WJMo=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=c5/dzWkhyq/BVDNxNa1FTqjfeC6rguo+yRamSwBo8gIBChaeJtypR0//FzquwxNTX
	 5rtntGKbCExSF6cq865Q+uaY+QrATpGOJBFAOtTDjZJU8g5zLasyvoeBkaVKD381bL
	 y0b9izPf0OKEnUaKKKok5iiO9pexV8gYuwwoWWNw=
Subject: Patch "mptcp: fix duplicate reset on fastclose" has been added to the 6.6-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Dec 2025 16:59:03 +0100
In-Reply-To: <20251127182741.3577840-2-matttbe@kernel.org>
Message-ID: <2025120203-tidbit-anemia-97e5@gregkh>
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

    mptcp: fix duplicate reset on fastclose

to the 6.6-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-duplicate-reset-on-fastclose.patch
and it can be found in the queue-6.6 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-197529-greg=kroah.com@vger.kernel.org Thu Nov 27 19:28:04 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 27 Nov 2025 19:27:42 +0100
Subject: mptcp: fix duplicate reset on fastclose
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20251127182741.3577840-2-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit ae155060247be8dcae3802a95bd1bdf93ab3215d upstream.

The CI reports sporadic failures of the fastclose self-tests. The root
cause is a duplicate reset, not carrying the relevant MPTCP option.
In the failing scenario the bad reset is received by the peer before
the fastclose one, preventing the reception of the latter.

Indeed there is window of opportunity at fastclose time for the
following race:

  mptcp_do_fastclose
    __mptcp_close_ssk
      __tcp_close()
        tcp_set_state() [1]
        tcp_send_active_reset() [2]

After [1] the stack will send reset to in-flight data reaching the now
closed port. Such reset may race with [2].

Address the issue explicitly sending a single reset on fastclose before
explicitly moving the subflow to close status.

Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/596
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-6-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ No conflicts, but tcp_send_active_reset() doesn't take a 3rd argument
  (sk_rst_reason) in this version, see commit 5691276b39da ("rstreason:
  prepare for active reset"). This argument is only helpful for tracing,
  it is fine to drop it. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2431,7 +2431,6 @@ bool __mptcp_retransmit_pending_data(str
 
 /* flags for __mptcp_close_ssk() */
 #define MPTCP_CF_PUSH		BIT(1)
-#define MPTCP_CF_FASTCLOSE	BIT(2)
 
 /* be sure to send a reset only if the caller asked for it, also
  * clean completely the subflow status when the subflow reaches
@@ -2442,7 +2441,7 @@ static void __mptcp_subflow_disconnect(s
 				       unsigned int flags)
 {
 	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
-	    (flags & MPTCP_CF_FASTCLOSE)) {
+	    subflow->send_fastclose) {
 		/* The MPTCP code never wait on the subflow sockets, TCP-level
 		 * disconnect should never fail
 		 */
@@ -2489,14 +2488,8 @@ static void __mptcp_close_ssk(struct soc
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
-	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
-		/* be sure to force the tcp_close path
-		 * to generate the egress reset
-		 */
-		ssk->sk_lingertime = 0;
-		sock_set_flag(ssk, SOCK_LINGER);
-		subflow->send_fastclose = 1;
-	}
+	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
+		tcp_set_state(ssk, TCP_CLOSE);
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
@@ -2809,9 +2802,25 @@ static void mptcp_do_fastclose(struct so
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	mptcp_set_state(sk, TCP_CLOSE);
-	mptcp_for_each_subflow_safe(msk, subflow, tmp)
-		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
-				  subflow, MPTCP_CF_FASTCLOSE);
+
+	/* Explicitly send the fastclose reset as need */
+	if (__mptcp_check_fallback(msk))
+		return;
+
+	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+
+		/* Some subflow socket states don't allow/need a reset.*/
+		if ((1 << ssk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
+			goto unlock;
+
+		subflow->send_fastclose = 1;
+		tcp_send_active_reset(ssk, ssk->sk_allocation);
+unlock:
+		release_sock(ssk);
+	}
 }
 
 static void mptcp_worker(struct work_struct *work)


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.6/mptcp-clear-scheduled-subflows-on-retransmit.patch
queue-6.6/mptcp-fix-duplicate-reset-on-fastclose.patch
queue-6.6/selftests-mptcp-join-properly-kill-background-tasks.patch
