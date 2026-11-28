Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795864114;
	b=ku02PXYLURJRhr1zYD5PJUfIv9IDTytQrXbBxk20NlAShdC91FGGK53d3+UPJ57Wjwq+
	 1+i2MttusNrS9CDuI0lTF0nbHfNDWszL23UWPAe1ukd9++9Q/+ZYBzpoln27tKuAQeaZj
	 CErS99fLfi94k9wT3mzAwWJlAouXMvRrL+edJcdF5fRSBrrzyFH39CNe2ydnolEfjX7t3
	 y5ES5mFK3zLHtNA5/x+Lq2a7Y0sV8Nnv1p29QIQdJaglXkVEq4OwIc2pgop5k2T+f2pah
	 Lb1UPmQffTTv3NRRIsg4lHf67yUlU02Hr7+sE+j0Ze5A0Zupf+gFVIOAeGMIWKk8RXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795864114;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FENn64p4AoZBNGqi6rSEppN2PJwHi1CYdKEHqHkEmkI=;
	b=2KkPET1SBwUHBrmBmDzzqm6xrpS6/u+dBrga79HFOLXhWsmc5D966/Gs3P4Xq/W9/Hyx
	 e6z/6NXw8EH2ewzikI4X971WsTfo0PzheHVwQE6NBaEEOQng0HErKBhJGKhDC/aeq3gIr
	 QHBC+MC9sGk7JrFPifidZ20hxelZGryLfsGzC9GBWtFp3M7X645xauuQGRGfaSCIdQMPs
	 +gNnSIvEe8OBitaU8ad5ZO/jY0RJ7j6vUXrSRKrhwkphEMu48Zz7ZGXTzAePcm6wTNrwq
	 tq8kvyYUN4omAzxoaJKrhy8JNNaeSw9pbKDWUCFiADXx5o5zGJJrsPip6Fs0IsNGyTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D8zX4JZf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A60606A327
	for <mptcp@lists.linux.dev>; Sat, 28 Nov 2026 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D8zX4JZf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDB31F000C1;
	Sat, 28 Nov 2026 11:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795864114;
	bh=FENn64p4AoZBNGqi6rSEppN2PJwHi1CYdKEHqHkEmkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D8zX4JZfkryg3wfw4+90Vzz+EvB1EZF4GDlM5qe5EW70adIe5BrXtRpSHu7Ol0GkD
	 uTtidmYvh+3fYwYJGfCheXkVeQmkJtHPaz2rTxor4qzbrFJTyIKNpdfzp94ehje+w1
	 DbNG9r4QEDMpbcI/hiyOoLzsp4ruKQAx18LGgdwM1lDZoNblmKbCKA+9kOEL1zVShy
	 U6lXX3QNW1OlE8jwYPWu82ai7hZCE/AR9+cec3VkqzB3Iw3aOz5M+44sLn834JOyoo
	 TTZuZrfUlRQn0EdkjqdQ5y9Kdxgi8YYs5C1lULWLcjXMmzAXBIOZuRrZmrZz9xkuAS
	 3arz+GPDdb5Mg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net v4 2/4] mptcp: use SOCK_DONE in mptcp_inq_hint
Date: Sat, 28 Nov 2026 19:08:04 +0800
Message-ID: <a9eb2043cc9dec009979c30c940f940f2cba2953.1795863454.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795863454.git.tanggeliang@kylinos.cn>
References: <cover.1795863454.git.tanggeliang@kylinos.cn>
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

mptcp_inq_hint() checks sk_state == TCP_CLOSE and RCV_SHUTDOWN to
decide whether to return a non-zero hint when the receive queue is
empty. This is redundant: SOCK_DONE is the canonical indicator that
no more data will arrive, and it is set in all the relevant paths -
__mptcp_data_fin_incoming(), __mptcp_subflow_error_report(), and
__mptcp_close().

Switch to sock_flag(sk, SOCK_DONE) to align with tcp_inq_hint() and
simplify the check.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4dad5da12680..be08a0abd197 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2641,7 +2641,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 		return (unsigned int)hint_val;
 	}
 
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
+	if (sock_flag(sk, SOCK_DONE))
 		return 1;
 
 	return 0;
-- 
2.55.0

