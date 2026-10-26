Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000199;
	b=kS3rn4CZEF+4/9xlyGYT6r+gMVNnjJO4H58ftRsLVsunQcA2YlAw2UmoNy/qyF6GalBz
	 h5rIgeoTivHEBge9K5vz/meVRc4Q1djGnPSBd769IMJ6HLoMKVAqcMM93iG4NDDvrYpM3
	 xA1a9OMWcW7Ge/YqutGOKr/lBfKgcSEg8ysBM1p/YtTWYwMYHqdkSlkjZ0pd7Z4yftmQj
	 MRue0qBGzgTTj34U7Uii5L5vDyoU9JXaHem2Ku602GweqWm2SSHE8kCAZ6Oz9NqqKt4pf
	 S7CpJcxsDMM6SqTmb0owharcIGs0v29k1crMgct+1MZUZqTDWySmsbnOAiTx4CnstnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000199;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VODG3h47/Vzu4ftrz0xLYwqWjt+8jmX8qe2xsUmQWK8=;
	b=KUAFh+IbrmZ38aS3X2MamS11aC+SmCJGnwp4oAKzSdTPNWRtGGKGDSD+piqsxcbQ7TiB
	 cwKdLTURk7XMcdgEbAsb/xrdOht5oj0AaNY+rIsJ0QX1XJoXR4y2gAP1+qEZk2d6zMfLJ
	 BKEFFcEiBWhc1IGI+Xx4qwftVWWEx++XhY13Nsqed3a2GX49TjgF6QLQuGPfaN0J2Wqcf
	 URHNz8dNA3qKj4w0/Eq54iOaFcXMMN3P0hLCWWzi8r2q3WEunZB4PA5mI1qN+52Lo91YK
	 fOd+RdIiqufwthQ4y1slEU91IR017AQhrF4817b9cM6ViP0h1vYmttg9ePVvDmuUNhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSqXev3W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3DF606A31F
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSqXev3W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B903B1F031E0;
	Mon, 26 Oct 2026 07:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793000199;
	bh=VODG3h47/Vzu4ftrz0xLYwqWjt+8jmX8qe2xsUmQWK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TSqXev3W8knjZo5LM6pdUItqY8k3HKk5rVbTYvmCE2vxa/4eLtcBBYn2zEzojwZhP
	 2KP7FVcm3Fn/gmj1jCF+7wqxV+R5a7ICFBCMEn6mclNAJUJsLsxPb+loqzKhOiBXc8
	 rKGLtMhnWmMWbNdEqItvH+q/vOxWE7vLwLucagtZD+b8xQFKJJ6FTpWtCtjeZfButY
	 IjzCbQAxxazFW/NdqsgOFT1QrRAXLDGPA4kdg+Qp1SpyVIf39f1OjjbuIGTCj9AEFJ
	 GEn7wYZn3sT93XsG1sbCI49aEFqTi8jylg2W8sSBP2QT+mPHyqILuXurPjuG4pn7O5
	 aKKvbUQ9Nv4TQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/6] mptcp: track app-limited state in mptcp_sendmsg
Date: Mon, 26 Oct 2026 15:36:21 +0800
Message-ID: <ca74735533f3c29d3bf81fc94d7a61c0a1db89f2.1792999988.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792999988.git.tanggeliang@kylinos.cn>
References: <cover.1792999988.git.tanggeliang@kylinos.cn>
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
index 8aad55e0cce7..568b6b52734b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2039,6 +2039,24 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
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
@@ -2067,6 +2085,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.55.0

