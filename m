Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591397;
	b=z19hZjzpiuvu092lHhiY2Fz27Acj4l8kfTqE9ijZzIvQgcaDSguotFYztzjJRWe56rqO
	 zWmNiZPznqfGiFw5nCSRTamx6d5IY0wUEoXP+Trv81uOJQ2L5aLikQRxlHNYUrYGzKASy
	 uYv0d/TC9oS+paLVSuBjdIhvpSeVp7ENC+bYkHIpn0jrCAA281vsQtIbq7DDjZbTFEBA7
	 1v5fBFWgonC3fIyM+AwgEhXUs4EcNcRgjJArwJQeV+4cTXzf7HyBN8I/rIBnEMEcKEW4f
	 Rx7TvJsZliJmdzsKErFjYsLd47JR60br4oqhR2uCjzUvuwpGT2Bslk2KkZKyBuvlyIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591397;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qjzVSDkyRctbGysNYaskZkqTQpFyE7jnSVdTF1Y78yY=;
	b=f+nJ6GoLxt8S3QqKfwYiR/twePVOZhRDjy47LH6O5dFqxu/AUucuXIz7O4BvOYnvhuPr
	 9zjqB3b0kpoIVqzWc+tWr/t56dmHZ/ebTM8xEXjMoIarMMV51C09g3SFPPnq6JfvepXGi
	 jfTolVExQ/SwxWK2qo+n2z5rudrd85l0Rw/z/sx93PfTfnZN4LgmIV7bu+0485wkmGaUq
	 jQfyNcyswRheJ06DKBoE1g7Gghj3hbiPK4Xe0KikoFL0fuDG4sKo/d1yrHgB3d0R17FGh
	 5db5QJIfYhiYDX0IXwIfWwEvU/p8aNogSS3p6DBqAKEOUS3BXEiM0+bDFCWR2O4ZH0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4lqrf5H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D3F606A321
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4lqrf5H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4DF1F000C4
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 07:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591396;
	bh=qjzVSDkyRctbGysNYaskZkqTQpFyE7jnSVdTF1Y78yY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=I4lqrf5HI95fw5um8x8EZhHm7R/sQAcqiA5dskX8yDyFMKgstnbilYeQJP5mUfUU/
	 xO6omEGel2IctPrhMgS9JQu6PYM44kKg2mtxiEYm7YPjnBZ1kbwEBlTg/2l+I1bWaR
	 OW8tYwLVGckCstKKWORFU9nWAYnrT6dMILs97XdS6Owp1/YiL6tShYZhiS/UZo7e8u
	 HEK/BzdbwdcG1SJjxJ41Y2uNmCaYHyGaoQhRD/LRY43Jm4Umq07c1hdggHmJ87JtF0
	 EgNhFccE7j4porIatybfwDFlmoxbcNz9q5jLoW64RUC/MXBywx0OF0inc/92nx2duf
	 Tf6o5UoyPKUew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 4/7] mptcp: handle SO_ZEROCOPY in setsockopt
Date: Wed, 25 Nov 2026 15:23:02 +0800
Message-ID: <aaf330d9dbfe6e4f8b15542106d5e687e719a8cf.1795591278.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795591278.git.tanggeliang@kylinos.cn>
References: <cover.1795591278.git.tanggeliang@kylinos.cn>
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

SO_ZEROCOPY is currently rejected by MPTCP setsockopt with -EOPNOTSUPP,
even though the matching MSG_ZEROCOPY path in mptcp_sendmsg() is wired up.
As a result MSG_ZEROCOPY silently falls back to a copy on MPTCP sockets
because the opt-in flag is never set.

Expose SO_ZEROCOPY through the SOL_SOCKET setsockopt dispatcher. The new
mptcp_setsockopt_sol_socket_zerocopy() helper validates that val is 0 or 1
(matching standard TCP sk_setsockopt), flips SOCK_ZEROCOPY on the msk, and
propagates it to all subflows. sync_socket_options() also synchronizes the
flag to keep subflows consistent.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80c..3391f7a9d983 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -184,6 +184,31 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 	return 0;
 }
 
+static int mptcp_setsockopt_sol_socket_zerocopy(struct mptcp_sock *msk, int val)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	lock_sock(sk);
+	sock_valbool_flag(sk, SOCK_ZEROCOPY, val);
+	sockopt_seq_inc(msk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow = lock_sock_fast(ssk);
+
+		sock_valbool_flag(ssk, SOCK_ZEROCOPY, val);
+		subflow->setsockopt_seq = msk->setsockopt_seq;
+		unlock_sock_fast(ssk, slow);
+	}
+
+	release_sock(sk);
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 					   sockptr_t optval,
 					   unsigned int optlen)
@@ -212,6 +237,8 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_TIMESTAMPNS_OLD:
 	case SO_TIMESTAMPNS_NEW:
 		return mptcp_setsockopt_sol_socket_tstamp(msk, optname, val);
+	case SO_ZEROCOPY:
+		return mptcp_setsockopt_sol_socket_zerocopy(msk, val);
 	}
 
 	return -ENOPROTOOPT;
@@ -351,6 +378,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_TIMESTAMP_NEW:
 	case SO_TIMESTAMPNS_OLD:
 	case SO_TIMESTAMPNS_NEW:
+	case SO_ZEROCOPY:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval,
 						       optlen);
 	case SO_TIMESTAMPING_OLD:
@@ -396,7 +424,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	 * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
 	 * but likely needs careful design
 	 *
-	 * SO_ZEROCOPY is currently unsupported, TODO in sndmsg
 	 * SO_TXTIME is currently unsupported
 	 */
 
@@ -1682,6 +1709,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	}
 
 	sock_valbool_flag(ssk, SOCK_DBG, sock_flag(sk, SOCK_DBG));
+	sock_valbool_flag(ssk, SOCK_ZEROCOPY, sock_flag(sk, SOCK_ZEROCOPY));
 
 	if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
-- 
2.55.0

