Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557669;
	b=OTcm38DHlr1MLff0EC3N76eSYz+YfahmQgrKdDiAlJZEV6yuOJv5+S41jfn2ItU63JJM
	 LgfHTT5RyUA0M2n59Rk/jkCEZLqQLMrgtkjes5m5NuL7jj6GSnqkcKVz6YCAcv1wW3/Z+
	 SGAETb5wBHwuUoCr7EDEcdlFy/pWl6d3Ci755GisCOSfwgXf6X1VJvtpipV6+PiaLv6i/
	 AvEjARnsMx81LaagoFn8UuzUxNclhE3t5Ns6zB9NAbrTsGEkYNwO+S498onqDNSKbvUqe
	 /FfNElmwyq7IRe+YhCcmWd4LctbGRvn/aOSs1S5Uzj07iVo6oeKHqs944q0ut8h7iHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557669;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=O4aCcBi7Us3eM0HBea8VkJSovXuzIfvbDTIVlAQcp6M=;
	b=HVWMCAi3h1O7MhStN6jEPOCCDrB5uVnLIwb7GRupR8MhBDbm9UncVdE/o90Jv3GxumlQ
	 zjHTICqYWP6AwnlLiYNRIhqdORAlwGQsIdCu04Y+wbniMDGfwxGufq0e7JQPEuQ7uLB16
	 rSWd8nolGK414++MZN5NYofsdXg73m4Ti6ifMphs458xxRAiptxhoteJCkqTHJdH0b5Vv
	 xQ0tFIrjS+CmcIHHHWQozDqHYl6POzRCCujApZp3uxfU9BV5ysTe7VVOSVsG9Se6ods/9
	 8P1+g9bS1/gphn5Rqs0bhVlCSXjshL6oNQ97X/vEMEdBJCAWmXBtBuy+w6xkSZOarhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOWsMCy7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85C606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOWsMCy7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F33A1F000E6;
	Tue, 24 Nov 2026 22:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557668;
	bh=O4aCcBi7Us3eM0HBea8VkJSovXuzIfvbDTIVlAQcp6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TOWsMCy7JCe9E6n9bsAWmt3VvjXR1Fzdw7IBusTrjgNcVdwDrjC2Ayl6tpghBcHHG
	 qYmbrwBnJw0ZLhCi+L19svndMgqcWaDb7467R6+hm+q/7jiV5ZOEcMHyPJdkuOmLD6
	 VE874eRdza4J7xgZJgf0rHc8u3zdsqS20Sa+Xs2/nuyZbXGk/iTWhWddrOXUxEMNKt
	 v3XAZBsMguz5QfWPM7sPRlgRUHgj1McTmKmjr0Hs2Nv3AmagaTJLaLHUbNI+GsM6Qh
	 KIxs3qVhtAvOtNOJuiFqWOeV9z1DWD9PmWGUNwqyh0BKiRX1f0/BYMFUlLWnYVQZa7
	 VWIaQO7IDCVmw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:26 +0100
Subject: [PATCH mptcp-net v3 09/50] mptcp: start close timeout on initial
 sf shutdown
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-9-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2601; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RgJwaWW1PfaKKNjalkD7LKS1JrMYSgMagVuVNS0UEwY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOP40XP9VJVWQE51uw3pysfhNn63XZzumpjYoJs1a6
 Xr2YOvKjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlMWsDIcJXXoLhq2azF/Sqn
 Vrpezu5y11X8yfTlz5Zmj/+Vp+5N3MrIcKzjcV7RkQ1X9zPoc8x53rvhu3Q9328X+fKOezH/NIJ
 0OQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the initial subflow is closed while it is not in TCP_CLOSE, e.g.
after a FIN without DATA_FIN from the peer, it is only shut down, and
stays in the connection list. The check for an MPTCP socket without
subflows then missed it: it only looks for an initial subflow in
TCP_CLOSE, and when this subflow reaches this state later on,
mptcp_close_ssk() ignores it, as it has already been processed. A
socket still owned by the application then stayed without any usable
subflow, without close timeout nor error, and with blocked send() or
recv() calls, for good.

When only this shut down initial subflow remains, start the close
timeout, if it is not running yet.

This issue has been found by an AI code review agent, while reviewing a
similar fix, and also reported by Sashiko. It has been confirmed with a
new Packetdrill test: the peer closes the only subflow with a FIN,
without DATA_FIN. Without this patch, send() stayed blocked:

  subflow_fin_blocked_send.pkt:26: runtime error: exiting while a blocking system call is in progress

The check only looks at TCP_CLOSE since the commit below, and
mptcp_close_ssk() ignores this subflow in this state since commit
d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events"), which is in
all the stable versions having the commit below.

Fixes: 27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent, and Sashiko

Note (Clashiko on v2): in the accept queue, a new subflow can still join
during the timeout, and the first subflow is then disconnected, as after
an MP_FASTCLOSE received before accept(): checked with Packetdrill, no
warning. In the other states, the subflow is only shut down: it can
still receive data and the DATA_FIN.
---
 net/mptcp/protocol.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d1bbba582aa1..5d916c6b43f4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2824,6 +2824,14 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		} else {
 			mptcp_start_tout_timer(sk);
 		}
+	} else if (list_is_singular(&msk->conn_list) && msk->first &&
+		   mptcp_subflow_ctx(msk->first)->closing &&
+		   !inet_csk(sk)->icsk_mtup.probe_timestamp &&
+		   sk->sk_state != TCP_CLOSE) {
+		/* The initial subflow has only been shut down, and its later
+		 * close will be ignored: start the close timeout now.
+		 */
+		mptcp_start_tout_timer(sk);
 	}
 }
 

-- 
2.55.0

