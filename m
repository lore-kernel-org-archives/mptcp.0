Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254151;
	b=YfnYiZJ3F3QQ6FTK1cXDpOtduROgnX3KrfrzaRVjhT43lJeJ3S8Wqx5k2r/N8uBlgnSJ
	 ML/ET8mBdyn/hY6r73oYNBpRY7KTY16qvePNTo/QvlEJhMHnNnde9hewaCYA3/5kDLjNi
	 mbMImPiOh0VVskzD0bilR4yYqeTDG+9n9xjYZ8dSEcrCoD8FPAn/8M7OSaA73GDuvTi4I
	 uf+4Wn2rKmnyHAtiLemrJB0iv/PiQWpIWj7zywYvyN1RpkvfDJuuxcRESdCAbVxeaehz7
	 7mzMc/SThSuE+5K6vHsWJuTs/XyonnR95cw46PRhOXgIEZrZre1TX97D5R/A9d2KE8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254151;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=EuaRc1ypLRY0OsqMixol/2IwWa91F3qluP81xjD7qzo=;
	b=gpv1GPNg1D6o0HRBrYiHdlrF4UxJ+UqfyDpB01rudfKrjvGLvsTdaB4LYvPGs1zUHI9j
	 aiwI9gHt8RsaEG8L/iczPyYkY6CxrPIP2tUB6h50SvQOGCWaGzEJqRs2hLnAknZXR+pmH
	 jT11Xxe+2rgs7RaDz/IwztXrbPEhmxAXAD44NpOF7MPdS/cjbZY2QZTEkv8QdY+1d1qd9
	 XjFVEXhODXt5pwtTrpepD8Afut7Lc+LUKJypn7pLaNcilSn6otYV4SpfbGZXMF7aFeAwQ
	 tTyIbLn3ED0tV8sfbVH9v8eyQi9Eiok6nlBaEFQq1vgCsLKURt+Tval8/8DXcWKY//g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jISkaxIS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF4606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jISkaxIS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F0A1F000C6;
	Sat, 21 Nov 2026 09:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254151;
	bh=EuaRc1ypLRY0OsqMixol/2IwWa91F3qluP81xjD7qzo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jISkaxISGsapRMLeXu2YwRKIubgW6PpyUE6Q+9NmhAYYx03rbFIlZ48OfdVFfbk5I
	 Frv7/OhYJ7M0zwuyhDvIwhdvwpMufR1wlvdV9o76DZpyncO+a9csqxGqncwLJeVuML
	 CGqgattHA4Pg4unINxlNjYNcSFsui0f3mlA2v1tnLd2IVl1o4+PElJB3KMjWsZD2Kf
	 cBdk88GuJUU5zKRNo+qTU97cGmq8MJjfoDBO6Q3Fv//xa4WdsKCL+Nui+/Wi6JAkV2
	 WWAW+udqrBC/IfqhcBsZ1tk9uGO4118LyvhVKHLZABUvtipstMNPCwkuzAe+5FASx1
	 KvOp+yPQeB6iw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:11 +0100
Subject: [PATCH mptcp-net v2 13/62] mptcp: limit an orphan probing a zero
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-13-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3223; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+/1gYyOmkXyss94GMp5AKiZxjk1halm7uRap7J6BSfs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ04Mm25+OsbGWjnqUacawec2TeQctNeMFlS/HCKt+u
 hj++xpPRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESYrzAyHI2fopYfMkdvh7UI
 r5bbIjvv2UJef7m9g5by8hqH7W9lZ2T4eeSv14ngieJ3pjAYFTf/ev+z/tnzXRqnSy/U594MTZn
 MDQA=
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

