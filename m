Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599674;
	b=3eTl6nR9RcO8LTSP/P3TIGu4C8UQJJ9bWsAquoOSqC07p6eBjVE4QGCw+PpSZhnxo9do
	 XsrCTml1NO6qz187iZ0bDvNR9uHv98++C7a/Slr28YxI22vlQZPQ+lFSzR8EmWboRlZXM
	 KVpKAoZNcO6NkIxh2gruYfH6Dpt1dzlcI58K5qF9y585VBEJflZ/2mVSvIcMLOxFU2U9T
	 TKR4e6kuKk1z71bqvA3Bc//y+dMZA50PvVqmUWYdS9bn+CCexFrUqU5Y524vt9Y3O9JQ/
	 HWny5A4KRDwcjDhXfYkj6GVG/dKDi+rfAu0HVw3nowgqgTbSoHbQF0b+sI1EAXwzAYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599674;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=430RsdtDu/QEoIdJjfe0DmpeHGPaJFmwxePSN63kwmw=;
	b=JwXsmCcJzyPXLnywge55MuvWqlzwsXE2wr5ojhak572L2BzuVWoUENsY2+6BRNIxjt7y
	 tWnVNcYxYq5CygFOjPhlmvWXAOc4EPFKXOVT4kwS6F+4a4vTQw7DwqYHyoS4t8rflQwwN
	 tpgn81B1p9ug/axsecTcDIGicXLqrvzo4U0FfK0EuEve8wnV4T5U5bN1le4vC078XqNRP
	 EADOXHrJPWCs4Wn8IQQFn7FzSuGsiYHOgKDeT6c/3fCHd6+jX2RO8ryIbfqODkG8w2CwU
	 r8CDUHPjFGyOvDxWKaHcj3lgypvgCRiv32NNjkazgRm5zpmq1WDa5qsANPUNXe0WAmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXs43PAn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B4E606F373
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXs43PAn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2861F000C5;
	Fri, 13 Nov 2026 19:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599674;
	bh=430RsdtDu/QEoIdJjfe0DmpeHGPaJFmwxePSN63kwmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OXs43PAnfHQhv2+BW2mPaOfjWtYhWV/n/+iT0K6bQ+BQof8GVyOVFrBMxTyIredJ9
	 1nY5uClHRCd/Eqqxg9KGZW3Jv1/eA6riH9O/VjEUNlqZMnQqUV/4k75Tpz47r13A7m
	 uYqTYVOXAB3ALqihFlkSoGyeacImkmJaVd3+7tYm+48uxYD90H7MD5/KimVnTF8VUv
	 ITXYyD6et+0EGGanH+H+iVZVp54eS5cPQK7OJhRgboxM3gm9SAnFPzXXZyBo+CWdDe
	 h0GAPSGCWRnQ6HqdxYIdPPTw3lgF6a71l5JcoTnt0VLdP6eU1ZQr9lIPOKSJDXz4Si
	 qNEEjykSAGPRQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:48 +0100
Subject: [PATCH mptcp-net 10/34] mptcp: don't leak an orphan when the PM
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-10-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3150; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=A1+RHb/uwhq+6tQZFUBnEU5KPZvenDGb9DWa57H0lDM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z92IEw/oYFu5xPyJQfCcVhvjC7dsubZmPtc+MylY5
 t3popgzHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO51Mzwv26qeUHqIRe/YrXC
 s0WhPvuDC1Y3bHJnqq+IqyrsuDP/LcP/sBrNh5tu+p86eGjN4gQFT40JB2yz5VbsVX1+yOxxr6U
 fLwA=
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
index 16824bed85b4..6dc55a3f027b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2794,8 +2794,13 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
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

