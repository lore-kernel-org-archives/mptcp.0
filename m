Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDE52BCF4C
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 02:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380058; cv=none; b=YtfX464Ozfx54jpg9cpYdTcRtYAQH6Zm+8he6O+AcjR3Ad/jggdUTFqZ9+dfueHNM0RVHDrSMRF0NMnrAcUBVC3uawuCZaF3JNWTNRGmN3IEMWzcnNwUpPIgs8Lnxzrk5qsmF181dMOnkAP48QOfKbl4f5rqD0v1pfUHAAwrHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380058; c=relaxed/simple;
	bh=hnRdmd3i4pMqRlq2KAW5JlOwu1gHDhXakz3I13cZSUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1jxo/KjL+HHppE5/0MnEs9ero4ijutMPzHAUAyC8zr654uoCbN9+nYagGAwnzxaK8o10szd5TfySYW8oi7aw1IFfNeAijb07BdJIaHIQq2Q7+yBokO11U8plIo/8m/s8Nic/MylZbGgFgJPsD2fBiLVCPdU2msiG2Ln2tHSXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA7ZzUFi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA7ZzUFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DD51F000E9;
	Thu, 30 Jul 2026 02:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380056;
	bh=YV0JXnpiXszaXfnHGLGoqUaEj8Uho1EeAyo0R88VJLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CA7ZzUFiLUVwJy9ku1tT9CMAQ2Loaa9SWZNMPSE0u3GY/BfB7Y5+TVHjDcN2Nvq5Q
	 HkkmhWKyIgP4pN332+K9QHtpzbqPM3R7QAeNuBokqSkP3F8I8LLD8Uip19jSxb7bYr
	 ZGs3xFsc2gdIhe6+J/+mlyYG/LWt8UN0lvjLBzVO+pdYsGAHPyPapR8hNGtIqv8Rwu
	 o1LdWcrSkPUUrSAGN/p2DMvQX2lCBV947J5kPWo0J3Hpo61kIZjz64xKHMZfK60tuH
	 KM8oqfgjvrWRicALgBULe94Pyz6e96vGKqKoUl81DJDRXxpIh5fuVt7pGSNZnuu67n
	 ONv/aDBvVArfQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 02/10] mptcp: inherit sk_reuse/sk_reuseport on subflow creation
Date: Thu, 30 Jul 2026 10:53:55 +0800
Message-ID: <7e0df1d3036d4eed4667c3997d04bf482b792e0d.1785378180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785378180.git.tanggeliang@kylinos.cn>
References: <cover.1785378180.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Propagate sk_reuse and sk_reuseport from the master socket to newly-created
subflows. Without this, subflows created after the master toggles
SO_REUSEADDR/SO_REUSEPORT would not inherit the setting.

Also bump setsockopt_seq in the SO_REUSEPORT/SO_REUSEADDR path so that
subflows created later (e.g. via MP_JOIN) trigger sync_socket_options()
instead of skipping it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..37e65923f544 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -326,6 +326,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
 			else if (optname == SO_BINDTOIFINDEX)
 				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
+
+			sockopt_seq_inc(msk);
 		}
 		release_sock(sk);
 		return ret;
@@ -1601,6 +1603,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
+
+	ssk->sk_reuse = sk->sk_reuse;
+	ssk->sk_reuseport = sk->sk_reuseport;
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.53.0

