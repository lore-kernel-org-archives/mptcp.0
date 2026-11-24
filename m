Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557667;
	b=oaZQ9tO13RWbDdGe7p2qZDMCREC2RWEmveGFc/1JoN/1EC+qI3z5l8v3tUp0dKOEFvls
	 bbm89NtxBCOcvntUTSiCUSIBALxs7LbUJFEpTTgdbXXvyOFp+BRfjAyJU1B5ZlrDKIiIq
	 T0Imo4a+jUnGJnnOh762DNrv6uo9DoEp7t4FEisb30pAn2VAU5GQ84X0J3DVsV5PI00Jv
	 fS83Fs1B5Fu5wg8BcnQI1uOUtvGcPfyOqfOE1aLSUKE1udmTY7Byllc8sYzSPFhLDfUWn
	 fOmgo8wubY7FehCqr5+U57dTJPK4fQYhQ1W5/CfXU1ywUrGhCc/yrjO3uykXdfztILw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557667;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VETGxmR8wNKj/imU7IijmkgeBkHY+lhHhlHq0BILz+Q=;
	b=CaQbdODjhRRFZg0Xm6jLZYpxFBcD2lzFPK+PYEbpA1GV6YAP0f655T1NbMYJo8xsg138
	 55zCV78bveaJFfzVHdlUgrX9GIBYnyNOSou8jCA38nW1ujVAbo/kkU1gesFK6yq1KTplL
	 X/J6Pzn+Bu83yowriagsSKLKQiv1QgF+wy9A2azGJvXtSeNcbSAo+6MJEQExeeZvE1eAB
	 omBJTYiP5Znc45Q60ItBQdxz6GXhzu7sCc9gOw2HGhd7vShjVKSG+PxkW045/C0CFvDj2
	 lamudgcOcRbW8DMpanBgqbYYPHOF6evicX/PMFyQ++fQjRe+22PuxUi3l9Y/Drq44Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEK68anu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B1606A329
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEK68anu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E281F000D0;
	Tue, 24 Nov 2026 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557667;
	bh=VETGxmR8wNKj/imU7IijmkgeBkHY+lhHhlHq0BILz+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hEK68anubg8f5mUT3BRs9ulFNNuek+yS97+ZU/rwAONXoQUTMZol/crxrbOKvaNKR
	 YM1eAw9MmYOTt7+EO9ie873qP/LqkZxZHq8XErFDqoUhnKz0fZ1Gym+QgOuuW27CK1
	 jRsKM880UfoRObTWECeR+JHPYzpdSiWY7dlJMfGeHibqJBu/H93TJKBwaHDHycPKM9
	 iLoUwjnBiwa3NgC8AQo15OV8fJzxUKkmTJDjifX0cWgEUGUszNYUrWVAA+4obrwlYa
	 AlOdAAli52eag7ZOOUS3pgFAs306xUZCRiJWHjBeQtS/HlMPbHn0M56r+gpVmpJW2j
	 QS7beq2gd/ppw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:25 +0100
Subject: [PATCH mptcp-net v3 08/50] mptcp: set SEND_SHUTDOWN on close by an
 sf error
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-8-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=w/V3HpV0/PH+pPe5qMiv6etcBkbZVYwqmw7fMpP+OZM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOH5HnNzypv/e2qvyKefC4/h471jFha8RaJMom8n10
 e68n+zljlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkoFDD84Tjy3+gRt5LDhFSd
 hQ9mTii+9W56oreWw9rcmT43Tr4ymcrwz3x7YMKUxfoWkfMMbkz8FNmaOcn53Zvox+GqaouOn3J
 czgMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After a fallback to TCP, or during the MPC connection, an error on a
subflow is propagated to the MPTCP socket, which moves to TCP_CLOSE.
But sk_shutdown was not updated, while tcp_done() does it. A thread
blocked in send() was then only woken up by the socket error: if
another thread consumed it first, the sender went back to sleep, for
good.

Set SEND_SHUTDOWN here too, after the error, as tcp_done_with_error()
does, not to have poll() reporting a close without error in between.
Setting RCV_SHUTDOWN, as tcp_done() does, would change what recv()
returns once the error has been consumed: this is left for net-next.

This issue has been found by an AI code review agent, while fixing a
similar issue, and confirmed with a reproducer: after a fallback to TCP,
a thread reads and another one writes on the same socket, until the peer
resets the connection. A part of the writers were then still blocked in
send(), and none with TCP or with this patch.

Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for a similar issue found by a review agent

Note (Clashiko on v2): the comment in mptcp_poll() names
__mptcp_error_report(), not __mptcp_subflow_error_report():
pre-existing, can be fixed in net-next.
---
 net/mptcp/protocol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d54ca367fc39..d1bbba582aa1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -979,9 +979,13 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	/* a FIN received before still leads to EOF, as with TCP */
 	if (sock_flag(ssk, SOCK_DONE) && mptcp_pending_data_fin(sk, NULL))
 		sock_set_flag(sk, SOCK_DONE);
-	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-		mptcp_set_state(sk, ssk_state);
 	WRITE_ONCE(sk->sk_err, -err);
+	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD)) {
+		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+		smp_wmb();
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
+		mptcp_set_state(sk, ssk_state);
+	}
 	report = true;
 	propagated = true;
 

-- 
2.55.0

