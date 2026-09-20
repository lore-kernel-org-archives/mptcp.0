Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7033E1231;
	Sun, 20 Sep 2026 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789890017; cv=none; b=tjQT0t4VvkygPoT4fROzYfOigExxin77pL+zlN28U35bSaOvWtfxGnPHJU/0TH8vjMKJHkxKFp+QuDPNeY7KmEu0KVZiMb7gd00pUjHaeM2OLJ7kwKj2d8TZsEX/uYADttVdTp62qPgo5rDBuF9vc/NWfhiJEBEwaDig5Z27d5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789890017; c=relaxed/simple;
	bh=Y456Jrvb9pFjjl/Vvjr5O3QE3o3VvbQJT062QzkMVlg=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=GfwiOvr0u0GnAL8ehGG/a8c8+EvhnWHoM+3Cwyb7Spc8jK8mhbExGoD6QNj81Zsj/PL71adOvuIz/0ntYN3VDE0IbWprAQlnt6YKU/KhzbBZd9piUjEIZEdKexwCZON9qaUuU/TU2gSeuFKvlRXZ8c/8r2bcYBDL7Ho+8Q9b0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s592kCmN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s592kCmN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8251F000FF;
	Sun, 20 Sep 2026 07:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789890016;
	bh=r19dh9GQOI32we7/yhMkKDCQutARJDCnGK8m7N1lhnY=;
	h=Subject:To:Cc:From:Date:In-Reply-To;
	b=s592kCmNAaOUvvsXlGPDfrHRzS8iw/mV03IJRA2/PepDOiNeWcRgDrnTHolThOI9Y
	 CTBuBbCtpJKC0ZXzIvPOw5NxHOeu/pbSrv8k7sijaNAgP3dGcnplX7F5Ysr+u7uTpi
	 vRykKxL1DcNaXeoDclMFH0HHg/BoylDsu9CvhKic=
Subject: Patch "mptcp: annotate data-races around subflow->fully_established" has been added to the 6.12-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org,yangang@kylinos.cn
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 20 Sep 2026 09:36:37 +0200
In-Reply-To: <20260919195642.1977885-8-matttbe@kernel.org>
Message-ID: <2026092037-islamic-default-0aca@gregkh>
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

    mptcp: annotate data-races around subflow->fully_established

to the 6.12-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-annotate-data-races-around-subflow-fully_established.patch
and it can be found in the queue-6.12 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-338598-greg=kroah.com@vger.kernel.org Sat Sep 19 21:57:10 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 19 Sep 2026 21:56:44 +0200
Subject: mptcp: annotate data-races around subflow->fully_established
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Gang Yan <yangang@kylinos.cn>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20260919195642.1977885-8-matttbe@kernel.org>

From: Gang Yan <yangang@kylinos.cn>

commit 581c8cbfa934aaa555daa4e843242fcecc160f05 upstream.

We introduce the same handling for potential data races with the
'fully_established' flag in subflow as previously done for
msk->fully_established.

Additionally, we make a crucial change: convert the subflow's
'fully_established' from 'bit_field' to 'bool' type. This is
necessary because methods for avoiding data races don't work well
with 'bit_field'. Specifically, the 'READ_ONCE' needs to know
the size of the variable being accessed, which is not supported in
'bit_field'. Also, 'test_bit' expect the address of 'bit_field'.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/516
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241021-net-next-mptcp-misc-6-13-v1-2-1ef02746504a@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2b0f561f21b2 ("mptcp: avoid unneeded actions on subflow reset")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c  |    4 ++--
 net/mptcp/protocol.c |    2 +-
 net/mptcp/protocol.h |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -532,7 +532,7 @@ static bool mptcp_established_options_mp
 		return false;
 
 	/* MPC/MPJ needed only on 3rd ack packet, DATA_FIN and TCP shutdown take precedence */
-	if (subflow->fully_established || snd_data_fin_enable ||
+	if (READ_ONCE(subflow->fully_established) || snd_data_fin_enable ||
 	    subflow->snd_isn != TCP_SKB_CB(skb)->seq ||
 	    sk->sk_state != TCP_ESTABLISHED)
 		return false;
@@ -999,7 +999,7 @@ static bool check_fully_established(stru
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
 	 */
-	if (likely(subflow->fully_established)) {
+	if (likely(READ_ONCE(subflow->fully_established))) {
 		/* on passive sockets, check for 3rd ack retransmission
 		 * note that msk is always set by subflow_syn_recv_sock()
 		 * for mp_join subflows
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3685,7 +3685,7 @@ static void schedule_3rdack_retransmissi
 	struct tcp_sock *tp = tcp_sk(ssk);
 	unsigned long timeout;
 
-	if (mptcp_subflow_ctx(ssk)->fully_established)
+	if (READ_ONCE(mptcp_subflow_ctx(ssk)->fully_established))
 		return;
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -545,7 +545,7 @@ struct mptcp_subflow_context {
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
 		mpc_drop : 1,	    /* the MPC option has been dropped in a rtx */
-		__unused : 8;
+		__unused : 9;
 	bool	data_avail;
 	bool	scheduled;
 	bool	pm_listener;	    /* a listener managed by the kernel PM? */


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.12/mptcp-annotate-data-races-around-subflow-fully_established.patch
queue-6.12/selftests-mptcp-fix-an-uaf-in-mptcp_connect.c.patch
queue-6.12/mptcp-fix-bad-accounting-in-__mptcp_subflow_push_pending.patch
queue-6.12/mptcp-syncookies-remember-the-request-backup-flag.patch
queue-6.12/mptcp-remove-unneeded-read_once-annotation.patch
queue-6.12/mptcp-close-race-between-scheduler-and-state-change.patch
queue-6.12/tcp-use-gfp_atomic-in-tcp_send_active_reset.patch
queue-6.12/mptcp-avoid-unneeded-actions-on-subflow-reset.patch
queue-6.12/mptcp-options-handle-mpc-data-csum-reqd-no-csum.patch
queue-6.12/mptcp-subflow-no-need-to-copy-thmac-during-ulp_clone.patch
