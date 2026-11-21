Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254149;
	b=GyA30sPr+/XlWWtX0JdR4xEw8JcOPYKQgsiD+WE6F8pVLjJ63xfGLfidCbB5A4/KueS4
	 F8sqWO1WcF19zdMynvpX8xUogbh1Ko1IN8yQFsektXonH4DfIjLet48NTKKWwDcff8Qt4
	 9SH5ExjqZwqRKif+XDJfzVga2ra7ShicI+8AKbQ80qTOcsg8CxIfOTc1sM07au3SXCrlT
	 3IKNGOzbgKSKMLN26nw9R0/5eylvGlGlIbE1e26Wu68ggoXGZd+kYNCTyhg0ctN120Bxm
	 2qkmxr5jPAV7Lst7mmvQ5ME27uyiQ3kfskimVUBsBo3TBoTqk4ilAaasF8RjhUpIBvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254149;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=aDdQtZguyY/2cZoXgdqkFPYNOi0VWM3eNkRFzvdZ5tQ=;
	b=WBw73RSIbanZtqzVyvHl5gFUaOAM12abZ3cjSAyGvRwaekfa7RFuJqwHnbHjePVT2bI3
	 /vHZulIJAXZSjJhqIemBKI4CWBu0aM8MW5aKnlumRcXRLf14BPj9OWzt906/oMGt4OhS/
	 SgEWVJIfVlKepXivbN8k0M1M/xNGQjZh+8+khWhTNvGKS4SntXPzlciT9uWEtGV7ijhrb
	 uRWUwkQ87Dt/erMQ3OufOHPf5Ad2rXKD3+Pinamewnz7q4Ij816qcClTJtIaIMWYT62WD
	 eXXSv8pgYcksu22Ql2mAnvO7J4+Fdmoxpr19fGgk7BHFNWZu4tv1nCEvWshsJWxu2Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjyP+JWq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32AA606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjyP+JWq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFFB1F000C0;
	Sat, 21 Nov 2026 09:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254149;
	bh=aDdQtZguyY/2cZoXgdqkFPYNOi0VWM3eNkRFzvdZ5tQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CjyP+JWqMRbAFUO5YWyn10FpzIYlO9BKAzXueeOfvuJvEcWkJb+n3AeKyyqQkDwJ4
	 cKVK+hRylfmAYXKwVUTTo3tpRJodluZ+sdPt1mzqBpt9SubBZuoznHGDwpkMEDFwwu
	 NoJtkCxnl0MEPq74XPwD22hymyo4z/CwJMnpckm5+qH4QJ9w6DTfhpRZzcXaVeKEF2
	 XTDdeP62yNKPEOoXrTeJFWpjKb/Rjgo6ktYu70V1rwsbnnFSfsg9lU+kh4AgdqMpZG
	 YewGG70RampUjwap1mErRnppP/hE5vt0dWQFJdxq3VOo/gUSD72HYIXKs4l5kgfnsn
	 xih1H6FgMMUfQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:09 +0100
Subject: [PATCH mptcp-net v2 11/62] mptcp: don't leak an orphan when the PM
 closes its last subflow
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-mptcp-cmason-fixes-v2-11-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GjPt2W6y/Y4VVZf45pUA/dmGKQTmmSGadM4E00uKWgQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0wOk2hn3qYmafshdFCEwKbx/R997izNlU+acubFAZ
 vvZ9qzgjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInIhjEyPPV4V1/5/KbFZktx
 P04/AbfebVzOn2autqybWfdEPmaJJiND68szetsE/81+fdhKeMUXJ5MPapOs2Cf+3fqiqFIsdrc
 vEwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Once close() has returned, an orphaned MPTCP socket is only destroyed by
mptcp_worker(), in the run that sees it in TCP_CLOSE: later on, the
worker returns at once for an msk in this state, and
mptcp_schedule_work() no longer queues it.

__mptcp_close_ssk() moves an orphan to TCP_CLOSE when, after the closure
of a subflow, only the initial one remains, and it is closed. This
function is not only called by the worker: path manager commands also
close subflows of any msk of the netns, orphans included, under the msk
lock: e.g. 'ip mptcp endpoint delete' or 'flush' with the in-kernel PM,
or MPTCP_PM_CMD_SUBFLOW_DESTROY with the userspace one. In this case,
nothing destroys the orphan: it stays in TCP_CLOSE until the reboot,
with its token, its initial subflow, and its reference to the netns,
which is then never freed.

This can happen when the initial subflow has been reset or has timed
out, and the connection is closed -- the orphan then waits for the end
of the DATA_FIN exchange, up to TCP_TIMEWAIT_LEN -- before the endpoint
used by another subflow is removed, e.g. when an interface goes down.

Only the worker can close an orphan, as it must then destroy it. So
here, mark its close timeout as expired, and queue the worker, like it
is done for an msk in the accept queue. The worker then closes the
orphan with mptcp_do_fastclose() -- nothing is sent: the only subflow
left is closed -- and destroys it. If __mptcp_close_ssk() was called by
the worker, this happens later in the same run.

This issue has been found by an AI code review agent, while reviewing
the code of the commit "mptcp: leave an orphan's DATA_FIN to the
worker", and confirmed with a new Packetdrill test: the initial subflow
of an orphan waiting for the end of the DATA_FIN exchange is reset, then
the endpoint of the other subflow is removed. Without this patch, the
orphan stayed:

  UNCONN 0      0      192.168.0.1:8080 192.0.2.1:39933
  kernel_orphan_last_subflow.pkt:39: error executing `! ss -HMan | grep -v LISTEN` command: non-zero status 1

Fixes: 27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 803ed1f9c413..d64e04245963 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2795,8 +2795,13 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 */
 	if (list_is_singular(&msk->conn_list) && msk->first &&
 	    inet_sk_state_load(msk->first) == TCP_CLOSE) {
-		if (sk->sk_state != TCP_ESTABLISHED ||
-		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
+		if (sock_flag(sk, SOCK_DEAD)) {
+			/* let the worker close and destroy the orphan */
+			mptcp_set_close_tout(sk, tcp_jiffies32 -
+					     (mptcp_close_timeout(sk) + 1));
+			mptcp_schedule_work(sk);
+		} else if (sk->sk_state != TCP_ESTABLISHED ||
+			   msk->in_accept_queue) {
 			mptcp_set_state(sk, TCP_CLOSE);
 			mptcp_close_wake_up(sk);
 		} else {

-- 
2.55.0

