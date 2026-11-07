Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053878;
	b=ZoGfho/QsnoeTcTC1JDpYzAU6tTg3Bj3kN1h984QscEnJhWFC7tF8jZzQo906kb7EGtr
	 8OuK5jvnZh1+iudw185ud4qq3emEPNKOZHv73TsIEcCxmbybfpi6TX7PMyyFOjK4vfhbM
	 dCi/aktQhMvnCDFgxd4wz2DbnMcDL66xbZzq4Y3n3GuVNcWAj/8Z/ZcL0Z9UkfstObqkN
	 hoBbgVLIXjs5lh5jtehqGp1qnGrjC9MZ+zCFsZldu1HEwm8HHZDQfwCfZEsXtF2IicglN
	 pyy3/YKRt+vD6CDvJVSVWNpouP6XJcV7Uvz4y7YNZGA7eR5B8yKwbMJxX/ncSJ4m9zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053878;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vB14W92f97LdNXuls1+HvDNQoDo62F6XVhVXx8ENf3U=;
	b=obJg1UGvu3iMwBStPXeqHZ3I5xapkywuYVbzUkFa+w5HivTlppbQegnGlQvGFc/vBh9z
	 gH6kkuWVc4qqP2IWc5g01m7uaFQSfN0xbdwLfL0+TNZnEZrdr9FwaMvBMmvddF8taXRmr
	 atkZHnUQsp7aLh4HxzpAH4+8kzEpYvT9dG7Ev0ygDigwSS347JC9GZsZWem2u4sbksN4Y
	 /xXO72rZWOoMBZD26joAwss7J9OeRfnzsFBn3r8YhfEXJx8j8TFDmbcArgH8RrwogUhpd
	 Ns7SrZMd7SBBAKEytSfoqj90ZhmhvVR1nRI/a+xeUGcXtaUmhPMXyJwHPDTMTNXxPGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0NZ5z4B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EE6606A326
	for <mptcp@lists.linux.dev>; Sat,  7 Nov 2026 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0NZ5z4B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306F11F008BC;
	Sat,  7 Nov 2026 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053877;
	bh=vB14W92f97LdNXuls1+HvDNQoDo62F6XVhVXx8ENf3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P0NZ5z4BNCae2r/z8x9NLSt1yJgVncv4SE9THb/D6hAKN1jdwS9XEm66lMpWkJWwJ
	 CnmMtxxu3qE9UdX+DJMa+CcF4CGqSAKr3ZcndCtDTwApraR42dsH+n6YTTADArNd98
	 qLnKreSfsZ7MDJcRVHAwSDULGnXXumaPwf7lr+VzQGV6xzAukluCcmhg5hLykSvtyZ
	 Axh6OsMr0iXwcH1EdIOWQ/AlJOvb7nkI/M9tQQX9+QJvWByn9iWPZYiOzTpNt0lop6
	 d/bL1HP2dvpB588jg7rrntejYpdADaEXe2biW5Bt2EiN9vD8MAkETZ1/dQ7m4Q4a/i
	 IPsLKTbXn7q3Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v7 5/7] mptcp: track app-limited state in mptcp_sendmsg
Date: Sat,  7 Nov 2026 20:17:18 +0800
Message-ID: <4e7579752a4e3425830d8f66df284ca7ce61bdf1.1794053683.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794053683.git.tanggeliang@kylinos.cn>
References: <cover.1794053683.git.tanggeliang@kylinos.cn>
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
(write_seq != snd_nxt), pending dfrags (mptcp_send_head), or pending
retransmission (MPTCP_WORK_RTX or MPTCP_RETRANSMIT flags). In these
cases marking subflows app-limited would mislead congestion controllers.

Invoke from mptcp_sendmsg_locked() after send-side setup so BBR and
similar controllers can ignore rate samples taken while the connection
is genuinely application-limited. The per-subflow locking only occurs
when the MPTCP send queue is empty, which is the correct scenario to
mark the connection as application-limited.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8ea06167b05d..0c933bd6ad44 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2038,6 +2038,30 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
+static void mptcp_rate_check_app_limited(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	unsigned long flags, cb_flags;
+
+	flags = READ_ONCE(msk->flags);
+	cb_flags = READ_ONCE(msk->cb_flags);
+
+	if (msk->write_seq != msk->snd_nxt || mptcp_send_head(sk) ||
+	    test_bit(MPTCP_WORK_RTX, &flags) ||
+	    test_bit(MPTCP_RETRANSMIT, &cb_flags))
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
@@ -2068,6 +2092,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.55.0

