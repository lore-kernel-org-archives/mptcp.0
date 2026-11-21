Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254162;
	b=pQJ3EncwRWIc3GqGUNAnEEWmwnWzDtndHyxxHDzw61qKsFTpFhKhc9DfKGkWNznEZRMc
	 k7I0TVF3o2gSOVJhlx3EaJD6e+kTh6bBbUAYg3zIIcoQyf1VkNJ0O89SnhfWEI9lcFZ/U
	 djg0aP+IIw7F81uiEHnaBv5pOKv8p1fJ8CULT95zIpB/6hKL9pZ6/gLr0oroTxueEq+GB
	 /DdA3Fz65AOmlcz4wgmQE5fryMBpPWyrE7rYOL5xQoBjofJSFhpySTFMR9q13uHwO+ni6
	 bzzByWv1L6fHPtN+WfJtm/Bo7yZZIcXdzpesnOoLNCVCpuMRvdajrAmh4SQzpFSzY9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254162;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=O5MXK5gqtGPvuJ4JanXCfz5r1NYIEMzLW7eSPtGVvjY=;
	b=2/FQ2Sqf7fuf/hHzx2H+aEkHHD2uWrKn3RaOstgVRKWCKVO3auyfYQtTvPMS/ut9neZP
	 jMsxmxekMOM8ra3QBGWHa18d0AjbQFVVT/geCfcPehBfPwrqPb1M32fdd32kLE22Ryc++
	 QLj5jtF1mq2Ira1BytPjVT9pCGq1ZGHtJVThbPDbVO7b8DdKekb9rF7vnmFJaDRapSQdv
	 7cEpmXgq9QZbzNc4BC/8hmbgGEG/Vo+WrJ7XtI+9bOFMQUiG/f7yyqknXjsjWOQUPxadD
	 cWuhCenfDc5J/49ZGQnBRw1FQieorD2kE/jAHoGAdeNzjADsY066abCH2M5swoaasfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJAByYWb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6A606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eJAByYWb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADAF1F000D3;
	Sat, 21 Nov 2026 09:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254162;
	bh=O5MXK5gqtGPvuJ4JanXCfz5r1NYIEMzLW7eSPtGVvjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eJAByYWbzGKZCPoAJo17k+rRFWCMPoEP7bsyEhw3yY09oYWKgFduP77FxFAaVysIo
	 p6xHiw16cm6T254uOaqbIvn+kbUWj9iLs7jBftoQB83TzwwahkQWZ/URWzVNDR/DVG
	 V44eUg/SauTBNB/MXJFLf+/zl/zIq4jht+WkclQk4PWC/YkouMLfBAJQ2HGGq6KwqY
	 k+XcRL3utYvY5OVxRFM/kHYK1EkZnrAFp1DYxxPn+vUJTxE+KRgvYKvjvTHrKkg8gV
	 HqK8LChZ7qYGp5rwIkCdWOr6KD48OFv8nQJjGYq7zNL/6feYBtuCdRvr3MXdljxj80
	 LMABdigvBmMaA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:25 +0100
Subject: [PATCH mptcp-net v2 27/62] mptcp: report sf aborts during deferred
 connect
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-27-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4108; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lkiYLbXXCZrYjwN4i0qnri7ouiBQpgMzp/E1QZO2Nhs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ02M+HfH4V5Ca93l9biAf+4k6/i33FnCXKrMyT1fXm
 z+fy7i6o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJRnxgZOqq3pZdYtd2a9Tjk
 8bcD+sv/u5XsWnTaL5BhppmtjNPnGkaG31dbxU+7eSyLYp7lezcxf+/Oo1F3pFaatvKticpVbz3
 NCgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With TCP_FASTOPEN_CONNECT, connect() on an MPTCP socket only sets
DEFER_CONNECT on the first subflow and on the msk, and the first write()
sends the SYN with data via mptcp_sendmsg_fastopen().

If the first subflow is aborted by tcp_abort(), e.g. via a sock_diag
destroy request or the bpf_sock_destroy() kfunc, while mptcp_sendmsg()
already owns the msk socket and is waiting for the subflow lock:

- tcp_abort() clears DEFER_CONNECT on the subflow, and moves it to
  TCP_CLOSE;
- subflow_error_report() can only set MPTCP_ERROR_REPORT, because the
  msk is owned by the user: the msk stays in SYN_SENT, with
  DEFER_CONNECT still set.

tcp_sendmsg_fastopen() then skips tcp_connect(), and calls
__inet_stream_connect() with the msk socket, the first subflow being
grafted to it. Because DEFER_CONNECT is set on the msk, -EISCONN is
returned to userspace, on a connection that has just been aborted.

Detect this case once the subflow lock is held: if DEFER_CONNECT is set
on the msk, but no longer on the subflow, the subflow has been aborted.
Propagate the subflow error to the msk directly, instead of waiting for
the msk release callback. mptcp_sendmsg() will then report this error
via sk_stream_wait_connect(), like plain TCP after tcp_abort(), e.g.
-ECONNABORTED. The deferred error report is then a no-op, so the error
is not reported twice.

Without the race, the msk is already in TCP_CLOSE with the error set:
the same check also avoids going through tcp_sendmsg_fastopen() and
__inet_stream_connect() in this case, except with MSG_FASTOPEN. Then,
the socket has to be disconnected, as with TCP, for the next sendto() to
connect again, and the race cannot happen: __mptcp_nmpc_sk() requires an
msk in TCP_CLOSE.

Clearing DEFER_CONNECT on the msk from tcp_abort_override() instead
would not be enough: tcp_abort() is called on the subflow without the
msk lock, and mptcp_sendmsg() checks the msk bit before taking the
subflow lock. The abort can then happen in between, and write() would
return -EALREADY, followed by a disconnect of the msk dropping the
deferred error. In this path, only mptcp_sendmsg_fastopen() holds both
the msk and the subflow locks, and sees a consistent state.

This issue has been reported by Sashiko, while reviewing the commit
below. It has not been reproduced: the abort has to happen while write()
owns the msk socket, and waits for the subflow lock.

Fixes: 93723db43e51 ("tcp: Clear DEFER_CONNECT before tcp_connect() and in tcp_abort().")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Sashiko
---
 net/mptcp/protocol.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a9ce2b6317d3..f80fac0c22c0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1960,8 +1960,6 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 	/* on flags based fastopen the mptcp is supposed to create the
 	 * first subflow right now. Otherwise we are in the defer_connect
 	 * path, and the first subflow must be already present.
-	 * Since the defer_connect flag is cleared after the first succsful
-	 * fastopen attempt, no need to check for additional subflow status.
 	 */
 	if (msg->msg_flags & MSG_FASTOPEN) {
 		ssk = __mptcp_nmpc_sk(msk);
@@ -1974,6 +1972,19 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 	ssk = msk->first;
 
 	lock_sock(ssk);
+
+	/* subflow aborted by tcp_abort(): its error report may be deferred.
+	 * With MSG_FASTOPEN, the socket is disconnected below, as with TCP.
+	 */
+	if (unlikely(!(msg->msg_flags & MSG_FASTOPEN) &&
+		     inet_test_bit(DEFER_CONNECT, sk) &&
+		     !inet_test_bit(DEFER_CONNECT, ssk))) {
+		inet_clear_bit(DEFER_CONNECT, sk);
+		__mptcp_subflow_error_report(sk, ssk);
+		release_sock(ssk);
+		return 0;
+	}
+
 	msg->msg_flags |= MSG_DONTWAIT;
 	msk->fastopening = 1;
 	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);

-- 
2.55.0

