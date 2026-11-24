Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557711;
	b=4fGZe82AswHTOdyxWEznGyunTgsJ5SxCcEN7aDhIQDmuEDpOen7D98iMnCka2F8a6rMp
	 8gffdZFiK29upzwf9gF4RjSVJJrDl2VMOosLSlDAd0ncGUS8GB9DJCXzWZgxZpw0uQozm
	 I1ZQW/dket1+5NbUOoEzajhpcFtU17UZucKHhQvqAmDG44qB2i6zW1n28Y6I5t0EVt5aD
	 LAeAH6XD20i+RsloKFbGqohXTfYv9FgSFcOKpKYNLS8vyAYaAEmOSzz9YmLzx2Mx4phop
	 YZxOc3VH1NslIPZEUvVQ8hDfMcVq9JgDCuk/3P361ElfM2oVkpNdioPbQ+8PJNBRLDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557711;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Wpc8NQoFDbc3SUtQXMz9OSb3rLLK95RFFl1NMsM2Myw=;
	b=kbDYtdiEk3EMhgSDTUnAXv7/frvDe/9aFoFsbwcEg/jA+4buZGMa+CoyQzHHMDPLz5Bg
	 hcLgjQwo5vfKrMmgrvZXGW0lwBNpMwJgLO/mfYRb0onZlur7eSYRYBF8439FaJ/b5ZRJK
	 uB+v9wZelC7XpOyVIPhsLf3laEFbNI/vc8cPQZ2ggQnQt6idrpgG88VgBTodpSQ8mdwk0
	 3+2yUj0GEYS7npR5OahZyZwNtYUzp18zEaw5oDAsgsEYtx6RCjXuTEp2KfCROa58bYNyg
	 hcH7QZFzC9xxvPQCODs/l6wn/Q6amF5KyDdmmN9xNtd98S4CgPQlVavzyPXOdD1OZxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alvVLrxs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725BC606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alvVLrxs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6B31F000E0;
	Tue, 24 Nov 2026 22:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557711;
	bh=Wpc8NQoFDbc3SUtQXMz9OSb3rLLK95RFFl1NMsM2Myw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=alvVLrxsw2OfO2YD0PnMhrD+gV5vtmHJK8iMlXxEoEc0k4rQv+z9ObZ3RmN4yjcHr
	 rWg0+Cz2UWEA2y7/7HfXngPqakOXPegIifNJ1kMzChDqC6CnReBIR9AamiHJwYgfwh
	 Ggu+1VwrUuFDYKg/kBRAYrumdLLzYbQjFqyYLsGnDI+gzIFztzMZcnCnbhhjEYwOfD
	 4hHdOUZ9tC8iXwP3LBUXUqjx6pIs0d2rsDu9bKDHIzp8ggvfyItIcIEWFKQYv4XtAk
	 +ev4ygrZ7V0T/lpmWjAikBl+ZzAWTEsTJ1OkfQPw+mfs9QQpGSrrEj3cgbnjrcDWe9
	 6zoexKFFoY4jA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 23:00:00 +0100
Subject: [PATCH mptcp-net v3 43/50] mptcp: order write_seq and DATA_FIN
 flag
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-43-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2519; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+QfHppTEXucMsitalkhZ1Oba6m65ZLLLiq0bb2hZsg8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOIV6k3i1NnYpX9q7d9uXB5svf/Ux6rp9WGL99Afvf
 M9W7HtZ21HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRhL2MDD83NE4W73td3u9+
 ufOq0T12231ve64LXO7WTwvY/Cv+vDbDf4cZS72frRYOfTWrVyxxufUtQ92zkwJfLDzlfPngtuc
 nQ3gA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_data_fin_enabled() can be called from the subflow TX path, e.g.
when an ACK is sent from BH, without the msk socket lock. But
__mptcp_wr_shutdown() sets write_seq and snd_data_fin_enable without
ordering them: on a weakly ordered CPU, the TX path could see the flag
with the old write_seq. After all the data had been sent, the DATA_FIN
could then be sent with the sequence number of the last byte of data,
before the right one.

Use a release/acquire pair, to read the new write_seq with the flag.

This issue has been found by an AI code review agent (Clashiko), while
reviewing "mptcp: order write_seq and DATA_FIN flag for fallback". It is
theoretical: it has not been reproduced, and it needs a shutdown racing
with a packet sent from another CPU, after all the data has been sent.
Still, it is fine to fix it like that, without real impact: the
release/acquire pair is cheap -- plain accesses on x86 -- with the
release done once at shutdown time, and the acquire when sending a
packet, as the plain accesses before.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3: new, for an issue spotted by Clashiko
---
 net/mptcp/protocol.c | 3 ++-
 net/mptcp/protocol.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2f89719e8454..e0f39931493e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3694,7 +3694,8 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 
 	/* will be ignored by fallback sockets */
 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
-	WRITE_ONCE(msk->snd_data_fin_enable, 1);
+	/* pairs with the acquire in mptcp_data_fin_enabled() */
+	smp_store_release(&msk->snd_data_fin_enable, 1);
 
 	mptcp_check_send_data_fin(sk);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cdd0a7e8296..a9daa047203c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1028,7 +1028,8 @@ void __mptcp_error_report(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit);
 static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->snd_data_fin_enable) &&
+	/* pairs with the release in __mptcp_wr_shutdown() */
+	return smp_load_acquire(&msk->snd_data_fin_enable) &&
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 

-- 
2.55.0

