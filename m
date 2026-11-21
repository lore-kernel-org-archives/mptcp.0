Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254163;
	b=S09l9AYmdizLmDap0imccg2jZhfIjx76Vzzu2Y/GmbmxHRma4MyMn0JRTfyTt9pIxT6w
	 SJO8fX/NBHxHbPpK7dlh5+6RPzeJFhm17f1UP1BtXcIumAL+QuiVzWPuaoNOPRlo0krmI
	 sJ/JyVDqW7Qh6bO4pgBcMc8dGw0NFxqlfHhBfeYXl6lb8mNLGJQ4mzK8hxJJed0fOYYxF
	 fKbP5/MnimFOgEBrdrxG5klJbH4h8KYPDYkr51UI6231XKFxndWwEvo06yRjfb5Ff0QvL
	 ZPHXkIilR06eqHAc5r2YjAhL5xz7hiyv0ZotU+yInsfHYfo2jeFk1/hdcPxu1V6DU1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254163;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qLn60VggItfZS/qHjlR0QceU5k5uYtw7CkH153DR43A=;
	b=MxUd62l74M0vYotvOH7CDZkVYnB87tDrbxprnn105KBVqgar/Wm5EWlhoCQQseHxNz3u
	 q4kz3qWhFXzi883bHNoDH2JTAvDKd7W4isXfIsWI7HZtlAvGLPqcw2AwP9GUb1yfw2u7R
	 s6SrDHmzN9aSQnxa9X9O87KT4cVmmdiN/OAUBy20izMlcC7O+FC25P3Ye6ZnUWwxxvizd
	 yEwhwSf5cq9lT0fPd8yxvpT7HQbLmkCHUC09uvQrzxuYSPo4e0r7t+ROSewpjjufNn/EW
	 sXsCV9xZQPOg9oea7Mb9Zb9s5Saf6am3/7IFkT13V/4LfzCWcTsWB6P+8VLOIKcLvSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lN0q3rrp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103A606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lN0q3rrp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15DA1F000EC;
	Sat, 21 Nov 2026 09:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254163;
	bh=qLn60VggItfZS/qHjlR0QceU5k5uYtw7CkH153DR43A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lN0q3rrp0E+FCnLfzpxmtHrheinhFeYvDX822Otwei/y05TwA60C1ysG9nZJzJCNM
	 ElQJocraDbCX/TqYkkcIr4mdckJa9UOtWwDAIxXU9zZ/ndE5kimbmldKJs06ffoxB8
	 CvNbuklvbaTvfeCuyMlaBeUwHurocx4LrMHSNZDC2RXBVnJuTUKA/h4/WCqXLAzQ2D
	 8AVo74rM8kuXxqO7APtDQX854CN6ekymVdyeR2c6ADRaSNp7lh440wa8siuTYTnhG5
	 R3jPYqzd8W9IzNeG8xU1PtewWmMCIAN6L3oilKnK8h9xTsWrmssJipWkEl1rqlhDpd
	 G6FbkhLJdZajg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:26 +0100
Subject: [PATCH mptcp-net v2 28/62] mptcp: no fastclose reset from SYN_SENT
 subflows
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-28-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aIOAa1mnfFISJwtn/OsIRa79h/MYRISFL2QmeNPvhpQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ02PrCje9aM0zPhk7q5hh6Z8C+5mvs86bTe2+Zrnsb
 /x2o5OXO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYSvJLhf2H3DOdJ2aKJBQ4P
 ctYWfZf8e8wsMcXAqqZ32duVmrcOSzAyNGcfuTT9T0Biioa1XFP6soOzRUoE/s2zDbNzqeHycHn
 NBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_do_fastclose() sends a reset with an MP_FASTCLOSE on each subflow
not in LISTEN or CLOSE, also on the ones in SYN_SENT, while TCP sends no
reset in this state, see tcp_need_reset() used by tcp_disconnect(). On a
disconnect in SYN_SENT, e.g. with connect(AF_UNSPEC), an MPTCP client
then sends a reset with an MP_FASTCLOSE carrying an unknown key, 0. With
TCP_FASTOPEN_CONNECT, this reset is even sent before any SYN.

Before the commit below, these resets were sent by tcp_disconnect(), so
not in SYN_SENT. Skip them again in this state, as TCP does: the subflow
is still moved to TCP_CLOSE, and a later SYN-ACK gets a reset from the
stack.

This issue has been found by an AI code review agent, while reviewing
"mptcp: clear DEFER_CONNECT on disconnect", and confirmed with a new
Packetdrill test: a disconnect in SYN_SENT, then the SYN-ACK. Without
this patch, a reset with MPTCP options was sent at the disconnect,
before the one replying to the SYN-ACK:

  disconnect_in_syn_sent.pkt:16: error handling packet: live packet field ipv4_total_length: expected: 40 (0x28) vs actual: 56 (0x38)

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f80fac0c22c0..55ff0298e5dd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3297,6 +3297,10 @@ static void mptcp_do_fastclose(struct sock *sk)
 
 		subflow->send_fastclose = 1;
 
+		/* no reset in SYN_SENT, as TCP does */
+		if (ssk->sk_state == TCP_SYN_SENT)
+			goto unlock;
+
 		/* Initialize rcv_mss to TCP_MIN_MSS to avoid division by 0
 		 * issue in __tcp_select_window(), see tcp_disconnect().
 		 */

-- 
2.55.0

