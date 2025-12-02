Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B35231C9F;
	Tue,  2 Dec 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691375; cv=none; b=PpNoI4cRSQ+MaKkf9wUBS8T3x1Mq5nmTbZovAFz3wylJQOQfBAiEDwK5dovM/kfT3LEIF42W6sFlSdNsI3yjulRbNo9h+3OSP+GiFOCrpyujY7urBBiUPzi/tNNX+lqQjvYnKnkqiMS6usS4BRdLqXktfFfxZy8hvtamWlBu36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691375; c=relaxed/simple;
	bh=I9x/MA3qKxImzhJ8VndCnMFLStVNla6ChO9g7wprhkQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=OZQQ6/PQZlPsLAK4gafytmCgPph3vQa4klKMK3QjgHVqA9eukQuZmGFPVu866Mjqj4Z+QzLoUkBAQeVSToVN7JdaBohAjOsEtrjnc6WKLQ4F33e6M4cbQVWamivHCErYFpOyJoQO2a32ZOI97G6SSOG29eje6p3XcXh78gGWQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BZTi/noN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BZTi/noN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D645AC16AAE;
	Tue,  2 Dec 2025 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764691375;
	bh=I9x/MA3qKxImzhJ8VndCnMFLStVNla6ChO9g7wprhkQ=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=BZTi/noN7uZmo4DhkMxt9P7LYiRIPodUC4F09A0K1X24bDxuY161dbWLSJpNHyZ79
	 pfSuULIAWBttuCDSiJGr8ZmubNarsHdiIPFFsrou1DUe68Bs51M60GDNlOTZJHGakA
	 CVdSQGBrdtpeDkQDxU+8mGmQGufNvwc2nIp2wJMA=
Subject: Patch "mptcp: fix duplicate reset on fastclose" has been added to the 6.1-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Dec 2025 17:02:44 +0100
In-Reply-To: <20251129165612.2125498-2-matttbe@kernel.org>
Message-ID: <2025120244-petticoat-puppet-8fe6@gregkh>
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

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-duplicate-reset-on-fastclose.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-197644-greg=kroah.com@vger.kernel.org Sat Nov 29 17:56:32 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 29 Nov 2025 17:56:13 +0100
Subject: mptcp: fix duplicate reset on fastclose
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20251129165612.2125498-2-matttbe@kernel.org>

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
[ Conflicts in protocol.c, because commit bbd49d114d57 ("mptcp:
  consolidate transition to TCP_CLOSE in mptcp_do_fastclose()") is not
  in this version. It introduced a new line in the context. The same
  modification can still be applied.
  Also, tcp_send_active_reset() doesn't take a 3rd argument
  (sk_rst_reason) in this version, see commit 5691276b39da ("rstreason:
  prepare for active reset"). This argument is only helpful for tracing,
  it is fine to drop it. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2440,7 +2440,6 @@ bool __mptcp_retransmit_pending_data(str
 
 /* flags for __mptcp_close_ssk() */
 #define MPTCP_CF_PUSH		BIT(1)
-#define MPTCP_CF_FASTCLOSE	BIT(2)
 
 /* be sure to send a reset only if the caller asked for it, also
  * clean completely the subflow status when the subflow reaches
@@ -2451,7 +2450,7 @@ static void __mptcp_subflow_disconnect(s
 				       unsigned int flags)
 {
 	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
-	    (flags & MPTCP_CF_FASTCLOSE)) {
+	    subflow->send_fastclose) {
 		/* The MPTCP code never wait on the subflow sockets, TCP-level
 		 * disconnect should never fail
 		 */
@@ -2498,14 +2497,8 @@ static void __mptcp_close_ssk(struct soc
 
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
@@ -2794,9 +2787,24 @@ static void mptcp_do_fastclose(struct so
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	mptcp_for_each_subflow_safe(msk, subflow, tmp)
-		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
-				  subflow, MPTCP_CF_FASTCLOSE);
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

queue-6.1/selftests-mptcp-join-endpoints-longer-transfer.patch
queue-6.1/mptcp-disallow-mptcp-subflows-from-sockmap.patch
queue-6.1/selftests-mptcp-connect-trunc-read-all-recv-data.patch
queue-6.1/mptcp-fix-race-condition-in-mptcp_schedule_work.patch
queue-6.1/mptcp-restore-window-probe.patch
queue-6.1/mptcp-fix-proto-fallback-detection-with-bpf.patch
queue-6.1/selftests-mptcp-join-mark-delete-re-add-signal-as-skipped-if-not-supported.patch
queue-6.1/mptcp-do-not-fallback-when-ooo-is-present.patch
queue-6.1/mptcp-decouple-mptcp-fastclose-from-tcp-close.patch
queue-6.1/mptcp-fix-duplicate-reset-on-fastclose.patch
queue-6.1/mptcp-drop-bogus-optimization-in-__mptcp_check_push.patch
queue-6.1/selftests-mptcp-join-rm-set-backup-flag.patch
queue-6.1/selftests-mptcp-connect-fix-fallback-note-due-to-ooo.patch
queue-6.1/selftests-mptcp-disable-add_addr-retrans-in-endpoint_tests.patch
queue-6.1/mptcp-fix-ack-generation-for-fallback-msk.patch
queue-6.1/mptcp-pm-in-kernel-c-flag-handle-late-add_addr.patch
queue-6.1/mptcp-fix-premature-close-in-case-of-fallback.patch
queue-6.1/mptcp-fix-a-race-in-mptcp_pm_del_add_timer.patch
queue-6.1/gcov-add-support-for-gcc-15.patch
queue-6.1/mptcp-avoid-unneeded-subflow-level-drops.patch
