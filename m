Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740002FB08F;
	Wed,  3 Dec 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768717; cv=none; b=X+b3DBMX4NTHnYmYxInOF/4fmBQY7GZRYCd+9zooT9k7eAH4bQT7iqHgKt5YCgvaAnnR9Sxm2pYu2AcBPb5cbDL00OX9C/BuSiH10YyyAAg5IS+fi/6T7+CF96GRqDXfZwJy2oQEX8DVojJRsAqFz9Uofa3VGw9/dKrYN2pe2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768717; c=relaxed/simple;
	bh=Fjr7fxEMmlFS459uG6l2DUztBh4pEyw+w/xJloTKyFI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=f0vpK1JcSs1YJqo7FaCe+SALtb8Sxuwpa7HH7ovT2B2qzpA2+feY7+awRXJbTeU8wzGn2SIWJuGxTyJ/HujDOzitUxfOSygXAPMi51wdz0cHi2omzWRHgB8fgqZ+maOiifFypkOuVhWAY1mV9BCdmMr5NF3mq4WknlEllSSGiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mJfjjUK3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mJfjjUK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931C1C4CEFB;
	Wed,  3 Dec 2025 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764768717;
	bh=Fjr7fxEMmlFS459uG6l2DUztBh4pEyw+w/xJloTKyFI=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=mJfjjUK3IrYLT2rwYDliLrSyotR01bGsROAN5acG38XGgkSruqApe2XUgHtOooUfv
	 fVxGaqe+tfFjXO8mpblh8uO/zip2TyZIa1TbUbKSjE9ArqBaJ7nUWIvCfkTcaIEUdi
	 /RejZDlY1qqhzH587p5W4SYG3uPzvlGTw4Nm2fuk=
Subject: Patch "mptcp: avoid unneeded subflow-level drops" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 03 Dec 2025 14:31:37 +0100
In-Reply-To: <20251129165825.2129168-2-matttbe@kernel.org>
Message-ID: <2025120337-decipher-pried-b85a@gregkh>
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

    mptcp: avoid unneeded subflow-level drops

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-avoid-unneeded-subflow-level-drops.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-197646-greg=kroah.com@vger.kernel.org Sat Nov 29 17:59:57 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 29 Nov 2025 17:58:26 +0100
Subject: mptcp: avoid unneeded subflow-level drops
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20251129165825.2129168-2-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 4f102d747cadd8f595f2b25882eed9bec1675fb1 upstream.

The rcv window is shared among all the subflows. Currently, MPTCP sync
the TCP-level rcv window with the MPTCP one at tcp_transmit_skb() time.

The above means that incoming data may sporadically observe outdated
TCP-level rcv window and being wrongly dropped by TCP.

Address the issue checking for the edge condition before queuing the
data at TCP level, and eventually syncing the rcv window as needed.

Note that the issue is actually present from the very first MPTCP
implementation, but backports older than the blamed commit below will
range from impossible to useless.

Before:

  $ nstat -n; sleep 1; nstat -z TcpExtBeyondWindow
  TcpExtBeyondWindow              14                 0.0

After:

  $ nstat -n; sleep 1; nstat -z TcpExtBeyondWindow
  TcpExtBeyondWindow              0                  0.0

Fixes: fa3fe2b15031 ("mptcp: track window announced to peer")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-2-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in options.c, because the new rwin_update() helper has been
  added after __mptcp_snd_una_update() which is not in this version --
  see commit -- and then causing conflicts in the context. There were
  also some conflicts in mptcp_set_rwin(), because commit f3589be0c420
  ("mptcp: never shrink offered window") is not in this version. Only
  the update of subflow->rcv_wnd_sent has been added. Also
  msk->rcv_wnd_sent is a u64 before this commit: in rwin_update(),
  READ_ONCE() is used instead of atomic64_read(&). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c  |   32 ++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |    1 +
 2 files changed, 31 insertions(+), 2 deletions(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1001,6 +1001,31 @@ u64 __mptcp_expand_seq(u64 old_seq, u64
 	return cur_seq;
 }
 
+static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
+			struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+	struct tcp_sock *tp = tcp_sk(ssk);
+	u64 mptcp_rcv_wnd;
+
+	/* Avoid touching extra cachelines if TCP is going to accept this
+	 * skb without filling the TCP-level window even with a possibly
+	 * outdated mptcp-level rwin.
+	 */
+	if (!skb->len || skb->len < tcp_receive_window(tp))
+		return;
+
+	mptcp_rcv_wnd = READ_ONCE(msk->rcv_wnd_sent);
+	if (!after64(mptcp_rcv_wnd, subflow->rcv_wnd_sent))
+		return;
+
+	/* Some other subflow grew the mptcp-level rwin since rcv_wup,
+	 * resync.
+	 */
+	tp->rcv_wnd += mptcp_rcv_wnd - subflow->rcv_wnd_sent;
+	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
+}
+
 static void ack_update_msk(struct mptcp_sock *msk,
 			   struct sock *ssk,
 			   struct mptcp_options_received *mp_opt)
@@ -1160,6 +1185,7 @@ bool mptcp_incoming_options(struct sock
 	 */
 	if (mp_opt.use_ack)
 		ack_update_msk(msk, sk, &mp_opt);
+	rwin_update(msk, sk, skb);
 
 	/* Zero-data-length packets are dropped by the caller and not
 	 * propagated to the MPTCP layer, so the skb extension does not
@@ -1212,7 +1238,7 @@ bool mptcp_incoming_options(struct sock
 static void mptcp_set_rwin(const struct tcp_sock *tp)
 {
 	const struct sock *ssk = (const struct sock *)tp;
-	const struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk;
 	u64 ack_seq;
 
@@ -1221,8 +1247,10 @@ static void mptcp_set_rwin(const struct
 
 	ack_seq = READ_ONCE(msk->ack_seq) + tp->rcv_wnd;
 
-	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent)))
+	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent))) {
 		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
+		subflow->rcv_wnd_sent = ack_seq;
+	}
 }
 
 static void mptcp_track_rwin(const struct tcp_sock *tp)
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -417,6 +417,7 @@ struct mptcp_subflow_context {
 	u64	remote_key;
 	u64	idsn;
 	u64	map_seq;
+	u64	rcv_wnd_sent;
 	u32	snd_isn;
 	u32	token;
 	u32	rel_write_seq;


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/x86-boot-compile-boot-code-with-std-gnu11-too.patch
queue-5.15/mptcp-disallow-mptcp-subflows-from-sockmap.patch
queue-5.15/revert-docs-process-howto-replace-c89-with-c11.patch
queue-5.15/mptcp-fix-race-condition-in-mptcp_schedule_work.patch
queue-5.15/mptcp-restore-window-probe.patch
queue-5.15/mptcp-fix-proto-fallback-detection-with-bpf.patch
queue-5.15/mptcp-do-not-fallback-when-ooo-is-present.patch
queue-5.15/arch-back-to-std-gnu89-in-v5.18.patch
queue-5.15/selftests-mptcp-join-rm-set-backup-flag.patch
queue-5.15/selftests-mptcp-connect-fix-fallback-note-due-to-ooo.patch
queue-5.15/mptcp-fix-ack-generation-for-fallback-msk.patch
queue-5.15/mptcp-pm-in-kernel-c-flag-handle-late-add_addr.patch
queue-5.15/mptcp-fix-premature-close-in-case-of-fallback.patch
queue-5.15/mptcp-fix-a-race-in-mptcp_pm_del_add_timer.patch
queue-5.15/gcov-add-support-for-gcc-15.patch
queue-5.15/mptcp-avoid-unneeded-subflow-level-drops.patch
