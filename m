Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720758;
	b=bH2a53rhgoM0wnevy5aBIpV8aKGBNa8KDolFoY/JViUTKlU/4K1IUGn0BoXNjWi/52ag
	 vVNVsDGZNqWwEHscKm8uCuo2HsM0HsT3NWTljDvdeaffexdhGwO8KH4fnZ1Uey9lYK0+g
	 8NGlXEB17Yi5csEAomRnK8fsMl8Yt6XfDo5Fd3A82a7cfIfHDuHwjNDjCzBVLvqXMO7lN
	 Czo2A6rq0EAAqk1ZOf5G9YDn/4VeKtYEzidJ3bUBEaXcHyCfSPGjwugHULVoPpp6pXxwj
	 Cm093ryTduoCZKY3sfifJzKDBjDkyatWbkWb4ZhacotVspNak+ljAWqKXAigVstfTJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720758;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QRTh9c/ChdNy4zRXe6J0ON5wGrSsLQuJldVLAaSIMRQ=;
	b=i5xHqolMgoJJayeFcIxWCbIZvEPvvvZS3EZ/7CNHGZ9XG8xQW/ec/z1a2TYcVdo/Vzit
	 naOBu7pSW6WcKsHeJC6DqDK56gUy6MG26zmE5+8u62NV7CK++Or93pQ81OY5efeU/SgCb
	 ZJN1rJK27cebP/TzvqetEKOQLhctclh93/5vrWnltlloMUTqbwAdJQlJWOWrP19c/k4aq
	 l4k1HgaNXPuGYzxrna6Oo08qhtWUh7mlJpMwMA2WVqITZrYMYAr6HItm3SibIFjsZFRlH
	 3D83Mdxg2ovf6fjxnNW80I4PjNpgKk+Mglp+Zh/b6gkr00bmEBIYTRaC5pbVik0pefA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S58hlOkq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6882F606A31A
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S58hlOkq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3C01F01829;
	Fri, 23 Oct 2026 01:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792720758;
	bh=QRTh9c/ChdNy4zRXe6J0ON5wGrSsLQuJldVLAaSIMRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S58hlOkqJGA5cTkj1RFR1gsUVAFrAlPfyTxq4L0bnhXWjG/CxgPSCtP2hpYEcaCby
	 nHhxqMWQlgVlZkCgFbga/FqUWOCrZwiAc4BhOgbZQdOUvKXVFCLJcEjRKHO23JmpcS
	 T2IxXW3aGbOEDmnPjMY1eXVfsDtRE3dJr3IPKqN5t2FlN/O412LZlMvYOSmIs3eqeU
	 ZEAuh4a7jh9PzXel/0hjExNFJgV0Ht5jwohF+l4KAo1L8jyR1Q5KBiFGM9go2DlJ0x
	 Q6LGP22V1/1k8BO45lMFsDDuBHHsoqYhAaHsTySvAhP326C45FK2QTs5QE/pC0ZlNn
	 ysgba18Ucvauw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v15 09/11] mptcp: track app-limited state in mptcp_sendmsg
Date: Fri, 23 Oct 2026 09:58:50 +0800
Message-ID: <38d46163209730399bc8927b0e37cdd79f9c4b70.1792718041.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
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
socket lock. The helper bails out early when MPTCP still has unsent data
(msk->write_seq != msk->snd_nxt), because in that case the subflows may
look idle only because mptcp_sendmsg_frag() has not pushed data down yet
- e.g. due to a constrained MPTCP receive window - and marking them
app-limited would be wrong.

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
index 086de4f3100e..7870b9be76c7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2058,6 +2058,24 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
 	}
 }
 
+static void mptcp_rate_check_app_limited(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+
+	if (msk->write_seq != msk->snd_nxt)
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
@@ -2086,6 +2104,9 @@ static int mptcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t len)
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
+	/* is sending application-limited? */
+	mptcp_rate_check_app_limited(sk);
+
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
 		ret = sk_stream_wait_connect(sk, &timeo);
 		if (ret)
-- 
2.55.0

