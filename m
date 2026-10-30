Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324668;
	b=G8zdj+0Ae+in1PKajPEhXEQ1fwWHQGlcdHDC8CRUpIDsZFk5epFUigiyMt8BzDDAomc/
	 SmOuBYMnbwCsM84tt5CEkN0+gTxWR2JkqZnNtLDIqrAmQOFOeruTAjyUDFXn1vgWslBSD
	 l/2JO4XlWPzoiewiF0pDYl0w4qYz9AjKH/Xzv2ABp+jpWEn5ngUphOhQDxWwvkc3DpSLR
	 5/mQIzXsWZhyX0egr4zsoVY6P5+QKlHJwMNtTnscwPA9WhCKPRUds5mqc5BLdpOaK0MRm
	 6NidJzO2Q2MP1QXzrjSLFIp0OhoHqplHUD6EBi5BE37zGaGKCsP8fC9sl/zKvOZZeUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324668;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ug9Alc1wEMUhe2Yn0LTxVcg90mtk32hHv23Ht5XBpR0=;
	b=I7DRDPeApP4k7HYFCstZu1txRTyWpMtXxv4v2W2QBq8NRH5WTqIE+EfR/zV1KryN+Fme
	 abBrogdDxL1KMHXiGrno5bp0oT3VM3cTD+IWWffGsfZ5IY81wkkxIY6xFstHFJ9kU2DQh
	 KNT2HNVb1vjZA/Ocv91YkNyWBo/kw/f+5rE0DgQ0qHD1bkzpsNVulg1PgdjFCpPPmAQ/v
	 P+qcJvJevl3yrTK2vjxvW2r6pfPZfzy1INetB53tX5fqaDX6DOM3qwuZ4v9/GUwI+Eqbs
	 D4FtNgJtYKoYzgAvSnePmaAma2Yal1tXwiLdAxUhm9MYm0pTyF080mXZhWIS6bxIS+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhHPJpM0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296D606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhHPJpM0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF491F00A02;
	Fri, 30 Oct 2026 01:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793324668;
	bh=Ug9Alc1wEMUhe2Yn0LTxVcg90mtk32hHv23Ht5XBpR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dhHPJpM04VlDL99Pv6E19TomaB6iegE5HM7xTqBmfgO79izf1m2vR81YxF7PG3ITF
	 lFKY351NmdNSepAM1Ufhc6tvqb2siEdV0PWujwcGpY1mEFqsvIx5PXMCnvn3cKBECB
	 ldbcUXMSi+1bNLlGH5gRgR6ce9mGsSb64dTzvAWDAr292wQIoqG534Y0zrs2bj/zUp
	 1o3ZT4kO/BxDWvTGWilyzjzdiipUEhl8utMuuEMQC/Xv3NuXnemIl0VrR4y5oc/snO
	 VxX3GhCaqkVhM9kpVSoModUh8je6AoYTZJmtfGHCI3uIkI65atPTtdyO4KuEpDOJAu
	 3AhYEaMGXdK9g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/5] mptcp: track app-limited state in mptcp_sendmsg
Date: Fri, 30 Oct 2026 09:44:16 +0800
Message-ID: <9fd8f849cbcb94b46bc2f59225dbdde81e8389d2.1793324316.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793324316.git.tanggeliang@kylinos.cn>
References: <cover.1793324316.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_rate_check_app_limited() that walks every subflow of the
mptcp_sock and runs tcp_rate_check_app_limited() under each subflow's
socket lock. The helper bails out early when MPTCP still has unsent data:

 - msk->write_seq != msk->snd_nxt: new data not yet pushed
 - mptcp_send_head(sk) != NULL: re-injected data from rtx queue during
   failover or stale-subflow recovery

In these cases the subflows may look idle only because data has not been
pushed down yet, and marking them app-limited would be wrong.

Invoke mptcp_rate_check_app_limited() from mptcp_sendmsg_locked() right
after the send-side setup, so the delivery-rate app_limited state stays
in sync with what the application actually has to send across each
subflow.

With this in place, subflow rate samples taken while the MPTCP connection
is genuinely application-limited are flagged as such, allowing congestion
controllers like BBR to ignore them when estimating bandwidth.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 696cdba76bc9..f30e14a2775a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2038,6 +2038,24 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
+static void mptcp_rate_check_app_limited(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	if (msk->write_seq != msk->snd_nxt || mptcp_send_head(sk))
+		return;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast_nested(ssk);
+		tcp_rate_check_app_limited(ssk);
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
 static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2068,6 +2086,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.55.0

