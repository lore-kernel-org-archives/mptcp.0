Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676634;
	b=pkusmV35YeiG4VNcNJviEzs7FBOa7tFNzG6HYDCMLRZenXHhFyyNEwy4hVNY8G3YCRXu
	 Bl8KTO9XreYjMlndIUkDVJZQaxKkDIannSKz18R/D5kDDtUu9k7hUe3prOuDewckkqH9l
	 ZgaQf+h37ZCe8nJ7bd1YNpcNU8G3UZVL99DcGnqmPZx0SAhDx+LLaaZPJa27jZuHcMlDp
	 Vm3PcdjXewMF9/oc5WHkaIyzxzdckZ5sCqyeY6BpzbUbxLiiTuM8W/T6+iWTN482lv96c
	 TbXt7BqGfS4PpWJJZ/TigRWiLn1d5v0T4keyLP6vX9S1t0B0E26T06zv7zievnXOUuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zEfSbIRPgP8xmeqYZ5Dj/gEVwjjuOUxuTR+GEo3HwoU=;
	b=dXeid8ql9L4VwOl9ahZ6UHJtZU0rxBKo2Qx69M4L3joetUw8+cPxawtIAhbca+0xWW9y
	 /mCXinuNNZz7qmB8up/HklrchjgTxDa86tiZsWkH6cMEtljakGIbfWTSlHZuHsYhISQ5e
	 tuzn6UB36T1kWRyJU8pe0qn9bv8qx5tqOQYUs7jjUMWeW+bSYaJzdO1nFJF9dkGokOLid
	 7CjnW2x33bb7vAFXN7BzIf6qkqD9U0dmiQ7PDeOQ0nd/UEdsiA7Tv4Wp/PXv0owK8N+l/
	 riy5J/gKDtF5lHJTO28MULrNVBLbOJtBRRpLAHApl0KEzmzccevMWhuHPpkMVtlLjvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAawDjy+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB8606D827
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAawDjy+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1411F000C1;
	Tue,  3 Nov 2026 03:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676633;
	bh=zEfSbIRPgP8xmeqYZ5Dj/gEVwjjuOUxuTR+GEo3HwoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OAawDjy+M/o7x3fGfp1ojDQQLkKclTGY/FQpYZ6wCy35VyCKDLpnMASkKkdAmoAEW
	 nsEA6F3CL8CTJCqww18lKozfCF6Jvwo80CdaaaLqOQZwU/X7kkhImVcnGUZI3UGXhj
	 LrHZAh0UQlb75KefU6K8qmMiCt3qPUceaj6czxwQjmXZt4+fKNVoOYjxQn25MMKOHI
	 7qnYzOoT1VZftQNIHVf1h+vE9GxXKGQq3MZWI9TuuFbH7kvM+f2cyYzTuQcAWvdlGN
	 KjcLI/yYdfGfARO+8HsybNGdQ2zpY7Aap2Skn+v3uA7/4xLbPetVBum9oZhBBhbaHH
	 n2xBn2vHArsnA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 6/7] mptcp: track app-limited state in mptcp_sendmsg
Date: Tue,  3 Nov 2026 11:29:55 +0800
Message-ID: <eb467edffa6bd66e1c4bcc7939a131066b1c21a6.1793676064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793676064.git.tanggeliang@kylinos.cn>
References: <cover.1793676064.git.tanggeliang@kylinos.cn>
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

Add mptcp_rate_check_app_limited() that walks every subflow and runs
tcp_rate_check_app_limited() under each subflow's socket lock. The
helper bails out early when MPTCP still has data to send: unsent data
(write_seq != snd_nxt), skbs on the send queue (mptcp_send_head), or
pending retransmission (MPTCP_WORK_RTX or MPTCP_RETRANSMIT flags).
In these cases marking subflows app-limited would mislead congestion
controllers.

Invoke from mptcp_sendmsg_locked() after send-side setup so BBR and
similar controllers can ignore rate samples taken while the connection
is genuinely application-limited.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b9c7b0bb6f74..c0a0b28f6af1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2038,6 +2038,26 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
+static void mptcp_rate_check_app_limited(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	if (msk->write_seq != msk->snd_nxt || mptcp_send_head(sk) ||
+	    test_bit(MPTCP_WORK_RTX, &msk->flags) ||
+	    test_bit(MPTCP_RETRANSMIT, &msk->cb_flags))
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
@@ -2068,6 +2088,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.55.0

