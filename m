Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783558;
	b=CLpK2hK585uVcWtnJM9ZdD8iQPzE9T73R5Wg/rSs9tIFLIyGMw09GyaRBMXS0Pqxpmll
	 AYpVDaENbNgtKSJq5qiHTXyGiweQCvOK4p8KRsLul++krqnEspXmTJNIyRL3cB7xPvDcZ
	 EFQGBkmspb+zwuuT5OPl4ziWXBQVd/NzkTX1y+BEaIeLEw7P2/j2705TCfl+xI5nKRWKX
	 b0pSudYCXjqXte1T5iGIah9tQm6XgOKmtz22SrspnpzodSDhkbS8scq78W7hnQ1SNfU+H
	 /nj7Y3hWdfaTSrnOFDpKHc6dArlURGeMcByHUuXDwAUcoFsWx0dNh5oJf5nLzApThIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783558;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qjzVSDkyRctbGysNYaskZkqTQpFyE7jnSVdTF1Y78yY=;
	b=rYaRM2IsJUBUlsrMNUMS30b79iWZh/dWR1YU6PGhoaU4Rrs/90Brvb8e1zbvr9d1PZFi
	 VQEkDLMZpL1iVq0Usp9SkkHUh3s3ie62F+FyGSvxRg41MS7OE8IcTZxzPNj5xWXClOqf6
	 IxFfNxICE3JGBdzIn3iKXwb+UcOxBl8JaWAe/GakIZBUkaVH6FSZ+69WUhlxglt11hBsG
	 JqfqmkTiPztDhK0pMszsBOgA8da3vLf11YcFdi4XfCFclv3TnanQ/94EfWmY6pda8DL9e
	 /RtQ9ktHx5Dx5P7gbKH2DfP5yk95vaHqCsRgsTahLnqqeTZKUNA4NISjSQvsgmatHAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4yPHcST;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6842606A324
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4yPHcST
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937741F0089A
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 12:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795783558;
	bh=qjzVSDkyRctbGysNYaskZkqTQpFyE7jnSVdTF1Y78yY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=A4yPHcST71dd9IedVEkwH7nniF79NU7QeeivrhoQNWQ0vMGodC1C0pIm8jo8l67eK
	 fRoI4m2+MMfRzSwg3Mt59eMD50i/VVc1dgjwpisKJHVGuAKGnOccUjSwawo27zvepI
	 IWrs+11MfiONv/tElTnQPTYN6kK1fVXH0S2H3hLAXPrXECnpSxPVTBTvkbnTv/3AM3
	 T7v+aEZcnrlnYnky4CogpkpzLn0iSVyV4oLHMnidBkmxSKJyHRgIisfXPpsURxChph
	 w6xosqmAlV/NjnR/9n8uQ6b4AhQBqj7XHOYeeckcBTHCYAAautoGo0z52o3pR3FHbZ
	 9/SpJQthtTCwg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v11 4/7] mptcp: handle SO_ZEROCOPY in setsockopt
Date: Fri, 27 Nov 2026 20:45:24 +0800
Message-ID: <430d5645bcfe26ea0caf89ba54b9c3a1b5c2d9e5.1795783388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795783388.git.tanggeliang@kylinos.cn>
References: <cover.1795783388.git.tanggeliang@kylinos.cn>
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

