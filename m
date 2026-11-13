Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599665;
	b=kte+2t1rpKNxn7d8YQhZIPTGyvhXpLp+/KIMu660R+qTc7cq5xZQstKzG0ARitUD4uTS
	 AmEutc9W2UfsVuATLHE+RO/SUvP9cC/NfiV9tMHVHCuJNQoV5eXsK5dJm4IJF/tphC0yR
	 L3KNiTOSvdOUY5s1ICKqYBCsQ2+c/ZgD0wHxY6OafukissAK/4b6i5k5vzJUihSp8EzjW
	 2IGeOdHOhRoYkgKyX7IfLg7GYOoI0wSTMSaIhqeGZ25u7PcMSP6wFeF/yZnW/VbiuIAIG
	 +vC9kqlRAzavAmoDXNFqdAs3Lx6+DfKA66bFDt9m9nB6OpvcuOs4XWorrC/RPHJY+CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599665;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XNrmfjZiaB6NkyhG5fiXM+iL/tqpZkpvhMu0Sz63ox8=;
	b=VTBoPX3j7WcIWJi3bvEewns+lP88PZa3NmMr6dQcYFIYkNurTq/gVs9H8b2HHs4zbPRo
	 X+DOb2HEhZXPVIvP+RW20CnMk1st6foS84N4Ex38Js0tIm0n660dB9yu7ODQP5mw6tcUC
	 jEtRakRsdUoszEiiH+CjytjsbnqXDqhYiqDh+FKa0SsPM6M6oALCkhUtwgBg1zPrO6xY6
	 GXg+xN6njCkT5ZIh4vpp9/3awna3SeuL1SFFL8B8HtUTUe5QH0Q+XzXBrBRE5+BuAdi4v
	 6lhEx0kEnCMZ8pDKO8cOiUpm64jMkI9cD/pRcgqxBpO6eBdxyyLNotsBdPll3yf5uOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tu9Qthix;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62060A6F69
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tu9Qthix
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C2A1F000C5;
	Fri, 13 Nov 2026 19:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599665;
	bh=XNrmfjZiaB6NkyhG5fiXM+iL/tqpZkpvhMu0Sz63ox8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Tu9Qthix8Mv1tm61Cwt19l1pwOr3lCFPOfVdqsp74OKsH6snoNEnFspcMOTgxDDHG
	 qFp/YhMMnbAj1JFD3R9ITiTuH5+jZIJE0hachupvuphDmMdDJwjT8wm/kElFc9BW+e
	 4GlsjmrVVSfozYqjc2rum5sAxSILFepRrd0DNO37OnAVioZe/8+i3pCt/pDaLnflij
	 97TzZfku95SJ0bMrNTlIfsyOCnRGdxpvr81wbWWnOG3YZUoRs4q2fxGUcNdZooNmeS
	 cj9JkggP/OK3PkgSwKYPo8hi9YW19iQaUKxsVX6gu3sRzN4OEQ8GmOq6RuJh5cqWcO
	 WraWsJDsuQhIA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:40 +0100
Subject: [PATCH mptcp-net 02/34] mptcp: drain the queues of a listen() that
 fails
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-2-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FyhXXk17aUixRyn+l+SOX/PtJtKBYobZnYhfU6yRSNQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z13++vnsmivna7ND/1/RLPDp+HRw9p2XMrMYL1hM2
 n7nRwrb4Y5SFgYxLgZZMUUW6bbI/JnPq3hLvPwsYOawMoEMYeDiFICJPN3LyLBnF9PbZHsXf81n
 mf0lzEaWE5Y41F5pTPkjGaXx6Pf52R8Z/vDfUA5Yxfs/6MCtzk/3UzQa26y2VJW28dad+3VjR3b
 lQQYA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

Sockets and their network namespace can leak, if a handshake completes
while listen() fails on an MPTCP socket that has listened before.

mptcp_listen() passes the first subflow through __inet_listen_sk() to
inet_csk_listen_start(), which sets TCP_LISTEN, then calls get_port()
and hash(), and sets TCP_CLOSE again if either fails. Until then the
subflow is in TCP_LISTEN, so a request sock of a previous listen() that
still points to it can be added to its Fast Open RST queue, or can get a
new child and be added to the subflow's accept queue. But neither
close() nor the next listen() frees what is queued, and the earlier
commit "tcp: drain the queues of a listen() that fails" skips an MPTCP
subflow, which needs mptcp_subflow_queue_clean() before a drain.

The fix used here is to call mptcp_subflow_queue_clean() and then
inet_csk_listen_stop() on the subflow in mptcp_listen(), if
__inet_listen_sk() returns an error with the subflow in TCP_CLOSE.

This issue has been found with the help of an LLM. It has not been
reproduced: the reproducer of the previous commit only uses TCP sockets.
This fix is based on code inspection only, which is acceptable here:
the issue is similar to the one fixed by the previous commit, and the
fix is simple.

Fixes: 76e2a55d1625 ("mptcp: better msk-level shutdown.")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Add a Fixes tag. Commit message: how the issue was
  found, and why it is fine without a reproducer. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 50de5cedfd0f..dd9fb803cad5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4381,6 +4381,11 @@ static int mptcp_listen(struct socket *sock, int backlog)
 
 	lock_sock(ssk);
 	err = __inet_listen_sk(ssk, backlog);
+	if (err && ssk->sk_state == TCP_CLOSE) {
+		/* inet_csk_listen_start() leaves this drain to MPTCP */
+		mptcp_subflow_queue_clean(sk, ssk);
+		inet_csk_listen_stop(ssk);
+	}
 	release_sock(ssk);
 	mptcp_set_state(sk, inet_sk_state_load(ssk));
 

-- 
2.55.0

