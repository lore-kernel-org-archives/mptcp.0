Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254156;
	b=rAvlKCBjRgZmvw1J/L7gA0BOVhcxACav0v3Mu3q9eeDdsZoVo5tliK7TqVMc4iX+zIFq
	 Q5iY+GeR0Yxbh8gqIkRnI4ck8HbOxZC0maR0V5Cb8/6KHxWM+ObNCuOVBabLsYeg9FyAX
	 h5SF9TOiLTYjUIBnJK9yAJ9X0aOKdaW2+8OuySLOueM+fU/Mn0+85RC1A/x/HVHAbIhHc
	 xTac93kxYMeIisyQJxIGWsLcubRzBMoVZC6yFXzprwr3Nal/LUjqeWv8LZ3UNA9OuoHAM
	 /cUAwJPUKPnFK77PhKm8ZeQ5l7+yoHXmkrb/ne8lXxp1/dUyiq7yP1ED0r4kMyblSVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254156;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=snoG3KnRJLf5qvvPhvv06/c+TQwurTrWKBhvomICLfI=;
	b=ZI9XI5oNz/DnzjXGTCxDxWJX4ayEWi6ed2hOgGb5FJTamxwdWjvAfv0IhCAs3INYRhRh
	 w3ud2atZsMC40Sl4iFY6ZNjYMaPKYDG8fmyLU0a+8Fcc4VAb5unF9C51cJhuy11rWfG8H
	 d4UAXBh51bN6/QyjvB2HnGOFBWTBZs5WyRy93PRcqNZzxtA97gMuZGM+zcXW0jt3k636c
	 AYifyuHAM20x1Dlv4fPEK9XXpp3smx5k5w5V/c7SWbrA4mda+NpEodTgYqiezhyviSG6j
	 NtS7H+GhwCOGiqRdmT7xeWyxOgLl0xF2xavHbGvCdxsEEaql1ey2s1G+lwhCFz4TB0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oh2mvy+O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CD606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oh2mvy+O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84DB1F000C6;
	Sat, 21 Nov 2026 09:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254156;
	bh=snoG3KnRJLf5qvvPhvv06/c+TQwurTrWKBhvomICLfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Oh2mvy+OD4vz66Kai1x5SZOP3OykjNivn4swoa3UCohz+xNWzbze9QN6CJbYNQz3V
	 gjT4JADv96RArfs+2auneGw2jbQLRkDe7ywQng1b7yv9e39fIpYdA8/IzG6dQ+uzMM
	 2MK7BYURDCpTo+XdqmHeyboikHkzjEKWM1Ryh3D8F2mqYZB41+GYoIkTlsr6eiPDbG
	 Yomt2VN29OPeNp4yC75qsMqdoWw8+PGvjipjpejWwgI+YYXtTZwSS+aMJb6/bBjYJs
	 wQ3TNYy9CVToMPhvJJukMt+duomrESGX2ToJX5Ov/GykM2EyPZY1NhzcSTxte3Zn3r
	 WfwYDaytirUtQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:17 +0100
Subject: [PATCH mptcp-net v2 19/62] mptcp: set SEND_SHUTDOWN on close by an
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-19-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QwZcq8nED9ntzoh+9NXScrY0Nhk+R/dAfxZuPKIROAQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ08O4TK0co4JXnN9medE9/6Leyh/RG/ewrGeawlarb
 SEu9M2to5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKz2Rn+Gf7iOLRng67ynYRZ
 F/YFN10Qfav9OHBzn1iAyaoYpsjfdYwMV6c872M6K3bYpOrBHmtJxoObeR7/Wav1oWrF7au1nh9
 vsgIA
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
---
 net/mptcp/protocol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b0f8a3d2e8b7..835796fd4f77 100644
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

