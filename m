Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557672;
	b=X2TYFtgk3CIaAhJ0pQYhouoSUdbEjdLehdQHXLhPSZfOV/a38aUaE8yybpkNy1K9lWEr
	 2IBh0agddzXH8QavWpLa4nVgZdxAWfpCRULeUg9rqTp0jg1kuCWdYLg3sJ/+VlXt6iAf1
	 LdKSDnKFTmV1UK8v9tygYW1w8kk7j9loo9m1gqeqEHyT1j5etUrpYBeqzCAct9uTvbHbE
	 wndaWWXOXRlfCpLPwEBBP4wBVxQRJyNU+VDUbN5J+180hxnozitbeW+0a7EAO/Opbeg+q
	 KeZsJn/pTFz/NoFKi5tWxosDfAm4pvpXKPScs1VGvcAyKNFRu8xi1YZSO9ZvnnYGSUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557672;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WgH5XgY1Djciv5KFz4pWoYan53BwFSdZTREbmhskrPI=;
	b=jbI/Jg0rVBRjWiElTNr3ORyqUgrjkmVTfTvaDc4X+hPb5iFRcRLewfLG6I2gDIU46d8F
	 kMGh7LY04kl5pkTYVzuAhPd9dYpyLS3YnQ6dvSAquuXeh8q9cUtjOKiziR8nLHzKbHvtu
	 f4OrZC4UpCTBcKgVoI2FPggDgQ6lLPq7/6xwjUVXRR54qA4sDDqmLe+NlQCtvfXs5DPra
	 2MG4QalBOStEbWgTSvkdDgOY0p/R5TZIdlPUA4lXUmuO4pwSMlUxtPVq4cKL74xG7+5SG
	 rUfIrMHAaqkWhvUY+Kgzp0gpi5UUPmrVkuu3EOj2eOi29wM9mtNlYZIaKTX9JHNe6RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgTvWMbF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60C7606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TgTvWMbF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8011F000C0;
	Tue, 24 Nov 2026 22:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557672;
	bh=WgH5XgY1Djciv5KFz4pWoYan53BwFSdZTREbmhskrPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TgTvWMbFNrWUpycdmOTnmvVWfMVdIsoJeIWEOXysTKXCtprHWXFdS8/oK0Tgxq8KU
	 yj0DHjoyzXnvRDjCzB5bFziyPmB/cdIcuWt840mdl7x3CFwvvGbeyqRvt6RVizdbK7
	 4Ov8iCD23vXIotF+peW5OIdeScuInA/xymjBDNF/gERhWyPGsyxhO04NUeazslh4p2
	 c6XK1I1uFVtGGlWSrjkvtNIqTV4VWShPAgFmw0hKkOLGgG897fF5KnET2jg9TU6WVc
	 fgai+vBCxitYuz5uZJgD7Zk5/MW9iVvSNjlE0kIo69AxeONUTexFFbKwLHXQHv2i3W
	 gp7JNhl2QeCIA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:29 +0100
Subject: [PATCH mptcp-net v3 12/50] mptcp: no sf left: process pending
 DATA_FIN
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-12-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4393; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=VGzsF4nB27A7cEMNCANNCJeD3maaX4yxvNjMnkdA6K0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOP5NDXt5YK7FYS/ZxyI/Nn89+uveAaHEWbquPAFyc
 6fF77nW31HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCROGeGv0JrC78VT5sXUDdf
 ebfJuSfNWqJzWyeyywm66K9qeM/Qe5Dhn9oKR9mpJzQWGWrNeTTxmFB6YvrU05bHJM/birDKyE4
 IZQEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the last subflow is closed while the MPTCP socket is no longer in
the ESTABLISHED state, e.g. after a shutdown(SHUT_WR), the MPTCP socket
moves to TCP_CLOSE. But the peer's DATA_FIN -- or FIN, after a fallback
to TCP -- might not have been processed yet: e.g. if the last data was
received while the worker owned the MPTCP socket, this data is still in
the backlog, and the DATA_FIN can only be processed once the data before
it is in. When the backlog is spooled later on, mptcp_check_data_fin()
ignores the DATA_FIN, the socket being closed. RCV_SHUTDOWN is then
never set: after the remaining data, poll() reports EPOLLHUP, but
neither EPOLLIN nor EPOLLRDHUP, and recv() returns ENOTCONN instead of
EOF.

Before the commit using the MPTCP-level backlog for the RX path, the
data received while the MPTCP socket was owned was left in the subflow,
and a subflow with data in its receive queue was not closed.

This issue was causing the "Infinite map" subtest from mptcp_join.sh to
be flaky: the server only got EPOLLHUP after having received all the
data, and spun until the timeout:

  timeout
  (...)
  tcp   TIME-WAIT 0      0      [::ffff:10.0.1.1]:10123 [::ffff:10.0.1.2]:51790 (...)
  mptcp UNCONN    0      0      [::ffff:10.0.1.1]:10123 [::ffff:10.0.1.2]:51790 (...)
     (...) fallback (...) bytes_sent:131100 bytes_received:131100 (...)
  (...)
  [FAIL] client exit code 0, server 143

The same issue was causing the 'peek mode' and 'full disconnect'
subtests from mptcp_connect.sh to be flaky, in the MPTCP to TCP cases,
so after a fallback at the connection: the client never got the end of
file:

  64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       main_loop_s: timed out
  (...)
  mptcp UNCONN    0      0           10.0.1.1:35046     10.0.1.1:20002 (...) <--
     (...) fallback (...) bytes_sent:714380 bytes_received:714380 (...)
  (...) [FAIL] client exit code 143, server 2

The root cause has been confirmed with a debug patch keeping the worker
in FIN_WAIT2 after a fallback, until the subflow is closed: the same
failures have been seen in the "Infinite map" subtest, and in the 'peek
mode' and 'full disconnect' parts of mptcp_connect.sh, with the socket
closed before the DATA_FIN:

  (...) closed with a pending DATA_FIN, state=5 ack_seq=11784643520213419601 data_fin_seq=11784643520213452397 backlog=35484

To fix this, spool the backlog and process the pending DATA_FIN before
the close, if the socket is still in use. This is done in a new helper,
mptcp_check_rcv_close(), also processing a pending MP_FASTCLOSE: the
next commit uses it at accept() time too. With the same debug patch,
these subtests no longer failed.

Fixes: 6228efe0cc01 ("mptcp: leverage the backlog for RX packet processing")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue causing flaky selftests

Note (Clashiko on v2): after a fallback, the FIN cleared when the first
subflow is disconnected is now handled by "mptcp: return EOF after a
DATA_FIN, as TCP does".
---
 net/mptcp/protocol.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bcdad00d3573..b57d0f82b416 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2707,6 +2707,18 @@ static void mptcp_cleanup_ssk_backlog(struct sock *sk, struct sock *ssk)
 
 static void mptcp_check_fastclose(struct mptcp_sock *msk);
 
+/* After the close, a pending DATA_FIN or MP_FASTCLOSE would be ignored */
+static void mptcp_check_rcv_close(struct sock *sk)
+{
+	/* process the DATA_FIN after the data still in the backlog */
+	if (READ_ONCE(mptcp_sk(sk)->rcv_data_fin)) {
+		mptcp_move_skbs(sk);
+		mptcp_check_data_fin(sk);
+	}
+
+	mptcp_check_fastclose(mptcp_sk(sk));
+}
+
 /* subflow sockets can be either outgoing (connect) or incoming
  * (accept).
  *
@@ -2819,9 +2831,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 			mptcp_schedule_work(sk);
 		} else if (sk->sk_state != TCP_ESTABLISHED ||
 			   msk->in_accept_queue) {
-			/* After the close, an MP_FASTCLOSE would be ignored */
-			mptcp_check_fastclose(msk);
-
+			mptcp_check_rcv_close(sk);
 			mptcp_set_state(sk, TCP_CLOSE);
 			WRITE_ONCE(sk->sk_shutdown,
 				   sk->sk_shutdown | SEND_SHUTDOWN);

-- 
2.55.0

