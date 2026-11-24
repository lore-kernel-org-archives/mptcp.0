Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557660;
	b=UHKiQo8vOWAcWduTCL+E7VUFbxDG8l07hRfEX6qyBcaKmvEVd7smez3LW/A7ZbhemcxE
	 iEaG/Ob1UHUM0+EQqCdyH6rD4HG/Jo3SIKY5YrXydbsF6RGvykrF4i6Ure9/Jkc434SjN
	 KOlALMzz2azSrhv0Nun+uhkojKsG0qhGbLlI0kiMYIQzesGVzyXuTug566qIPoX6OOSjY
	 rTX+phSNZFYKWB9XgxnZsaPvwJDTGsD3wmiuCvs4Pn8kHZ71bZdQ87hvbLBfz94M3h0S1
	 3UP+nabU2d9GfkXO4Oc1+94p/AITabjlk2bqTO8639lSY/aUUwuN9dhHqFV/hjJsdXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557660;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=H87p4BaCJ9/1S2/jNtJswWg+CJoVJVLNVXu7TjHOntA=;
	b=DPgmbgNUZdM5O9idVpIyOuFwhoo7bD2n5huRk3FnjMe1W5+K/v7kUn3hdkb8v/P6981o
	 1ErhaNT/igHj4Xdp8CDVA6mDxondvgGVR/u0H9duKSmcwtyZwZYoJV028Q/173+v72TE7
	 4AS6b2NV8keSz9+dCPWSt2RqGT8l7w23Rtosg2PUlXM7k/5Dl4pHOMp7qOmpLGcz4m9NP
	 d99CTDft54rSQS3MKwONFibU0cCzZli8zkTR7OicceRCkI8AljALg9x7WB7IkHvm3NQ+j
	 5FKPg0z74DsNmEnG0hoZaG4kEhgJfkloscKJihfMlLxayd+iW8sRubnn68y4kAng/Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcIb7mH2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDE606A321
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcIb7mH2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7881F000C0;
	Tue, 24 Nov 2026 22:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557660;
	bh=H87p4BaCJ9/1S2/jNtJswWg+CJoVJVLNVXu7TjHOntA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IcIb7mH21Ms5NYtoCrDGuY0KtsbLfWwOlQRzf+Oqzj/SnmcEK/yLe0yjKjCmsvC+u
	 2Nlit63cBbfEemF+4wP92oU5r21icYwhw5cMdMJxDVAy1XSlO5SBfs9wnwzvePCsvH
	 xcFejXDFlyTyF2A266bKKMQjpjUMCd9xZf1wE/7CXK+K9aattWZnGv2HJ5VwVx/vc1
	 Urisn8eAq5G3O4Lo2C3gc9eLVniuuZBKqhVlv7nkKgklnWQt0oWb/El1DROWt86ERR
	 bc/untzqezg9p17evBqcZUgQCGhYOTs3iWWzeQPQVB629Jg4sX/gUnp19Nf9U13y6d
	 afDL5fJXIeC1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:19 +0100
Subject: [PATCH mptcp-net v3 02/50] mptcp: limit an orphan probing a zero
 window
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-2-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3493; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=r1DBDbV2ULWkfhAuLVqd6z/2O8cAIJ/YuPi80RA5d9M=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOH7YMfN5ThBXOvFkXq6Ut0PNDTO/58+3tl9XEnNmm
 VlydMOpjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlwnmP4xZR4SWn+Z24m0zW/
 72z/4MOb98bA+8mvzZ3LejrtPTc80WX4Z63Hw92SkaT68maZ6K2YS2zRJz7OnDA99V6M949Vbo/
 /8AIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the previous commit, an orphan with data to send is kept while
the peer acks something, at least the window probes: a peer keeping its
window closed, e.g. not reading, could then keep the orphan forever.

TCP limits this for its orphans: tcp_probe_timer() aborts them instead
of probing again after the max interval. The subflows of an MPTCP orphan
are not orphaned: they probe again then, and back off once more, up to
tcp_retries2. So check if TCP would have aborted them, when the close
timeout expires. Same with data in flight, when the peer has shrunk its
window to zero: tcp_retransmit_timer() only aborts orphans then.

Two corner cases needing non-default settings are not covered, which is
fine: an idle subflow refreshed by keepalives still keeps the orphan
when the stale detection is disabled, and tcp_orphan_retries is ignored.

This was found by an AI code review agent, while reviewing the previous
commit. With its reproducer and a long pause, the orphan was kept until
the end of the pause. It is now reset as TCP does, respecting
tcp_retries2.

Note for the backports: this patch is needed with the previous one, and
before v6.15, tcp_rto_max() can be replaced by TCP_RTO_MAX.

Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, to limit the orphans kept by the previous patch, with the same
    Fixes tag to backport them together.

Note (Clashiko on v2): a peer acking the data at the TCP level only
keeps the orphan, but this is bounded by tcp_max_orphans and tcp_mem
since the next patch. With the stale detection, the probing subflow is
marked as stale, and its data is moved to the idle one.
---
 net/mptcp/protocol.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 944c9d11d211..ff71f1954077 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2871,6 +2871,32 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
 		  inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));
 }
 
+/* Would TCP abort this subflow if it were an orphan probing a zero window? */
+static bool mptcp_subflow_probe_timed_out(struct sock *ssk)
+{
+	u8 retries2 = READ_ONCE(sock_net(ssk)->ipv4.sysctl_tcp_retries2);
+	struct inet_connection_sock *icsk = inet_csk(ssk);
+	const struct tcp_sock *tp = tcp_sk(ssk);
+	unsigned long limit;
+	bool slow, ret;
+	u64 when;
+
+	slow = lock_sock_fast_nested(ssk);
+	limit = tcp_rto_max(ssk);
+	if (tp->packets_out) {
+		ret = !tp->snd_wnd && icsk->icsk_rto >= limit;
+	} else {
+		if (icsk->icsk_backoff < retries2)
+			limit *= 2;
+		/* a shift of 32 already exceeds the limit */
+		when = (u64)icsk->icsk_rto << min_t(u8, icsk->icsk_backoff, 32);
+		ret = tcp_send_head(ssk) && when >= limit;
+	}
+	unlock_sock_fast(ssk, slow);
+
+	return ret;
+}
+
 /* Before its DATA_FIN, keep an orphan while a subflow can send its data */
 static bool mptcp_orphan_keep(struct sock *sk)
 {
@@ -2886,7 +2912,8 @@ static bool mptcp_orphan_keep(struct sock *sk)
 		/* a live peer acks at least the probes, every TCP_RTO_MAX */
 		if (__mptcp_subflow_active(subflow) &&
 		    tcp_jiffies32 - READ_ONCE(tcp_sk(ssk)->rcv_tstamp) <
-		    2 * TCP_RTO_MAX)
+		    2 * TCP_RTO_MAX &&
+		    !mptcp_subflow_probe_timed_out(ssk))
 			return true;
 	}
 

-- 
2.55.0

