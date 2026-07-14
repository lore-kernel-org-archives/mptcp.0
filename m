Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE6360EE8
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 01:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993285; cv=none; b=pywt0qVyI1N7mkz7b8EyrjRBqKgPPwH8QxcZc5bOJh3eU2haI6GeJfiGffxSRKXKoQt8bnmRq4J0x/3L5dQ/vc8Drxuroo9SaoGD253C8IIcF7bhU6bTdxoQXnJIr9j+O6Vp7obQr0bcgC2x8X+4CD39kZ3bxVTs6UXmiUwzxtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993285; c=relaxed/simple;
	bh=h0KHbTdRLXfAQDlm+Mzn4sOSwJyxsp1fPSLu/6K0DEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+Qyj9VExt6ssn5jv49GI2YVJbxXE1sjSLIACOnj8cCY77OPMV6EIRjiCDyt1IyKgoe4S7y6GNjkc3PL5wRH53lYPd10WSfpDE7xAIL12vzUgksi8munY3tfZ6Hexs49qeuXp4O6kuXd34oKzGh08lFX0VSqemdNHc9EjH+y57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKeHhBu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKeHhBu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E3D1F000E9;
	Tue, 14 Jul 2026 01:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783993284;
	bh=1aL2W8PM3bCKMiZfqkj5j62ROsq0aloJ4VBeqLorDFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iKeHhBu1CX5yA0mFdpEeKHQe3We4uMd0GhjeA0pvYJfcaNXD+SCDcO3ft7OUF2M5f
	 Rau1Kq3/RDcIkKLwBmsDPtshWD6h/pEfQ9r6JVfvq+TLq6+9CjbCRowIv5+D0S0pLM
	 EtiYBVZ9tNtvMQZ4T/vI0ydForTdD42/mbA5UsUj6o1y5QOfoPPXrNdryryB0dQAl5
	 3kNMmWdHLQcES0YKcQvkQmwmcJjiszQ7VryGQG4qxLSzXJwiWw18jrr5aZooEn/gzL
	 KM9dS7IyJImZGiJ3d+xQk5tVz6GmjX8r00KmQvc6P73fNt5AdPEscXnEUp4v/Im4z+
	 +ZnIgBUlzUqdQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/7] mptcp: handle SO_ZEROCOPY in setsockopt
Date: Tue, 14 Jul 2026 09:40:59 +0800
Message-ID: <ad34fd2e73131ec1310e35332f66b584cc02b5a4.1783992745.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783992745.git.tanggeliang@kylinos.cn>
References: <cover.1783992745.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

SO_ZEROCOPY is currently rejected by MPTCP setsockopt with
-EOPNOTSUPP, even though the matching MSG_ZEROCOPY path in
mptcp_sendmsg() is wired up. As a result MSG_ZEROCOPY silently
falls back to a copy on MPTCP sockets because the opt-in flag
is never set.

Expose SO_ZEROCOPY through the SOL_SOCKET setsockopt dispatcher.
The new mptcp_setsockopt_sol_socket_zerocopy() helper validates
that val is 0 or 1 (matching standard TCP sk_setsockopt) and flips
SOCK_ZEROCOPY on the msk only. mptcp_sendmsg() consults the same
flag directly, so opt-in is honoured on every data path without
any cross-socket propagation.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..abcc7d4452b4 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -175,6 +175,19 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 	return 0;
 }
 
+static int mptcp_setsockopt_sol_socket_zerocopy(struct mptcp_sock *msk, int val)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	lock_sock(sk);
+	sock_valbool_flag(sk, SOCK_ZEROCOPY, val);
+	release_sock(sk);
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 					   sockptr_t optval,
 					   unsigned int optlen)
@@ -203,6 +216,8 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_TIMESTAMPNS_OLD:
 	case SO_TIMESTAMPNS_NEW:
 		return mptcp_setsockopt_sol_socket_tstamp(msk, optname, val);
+	case SO_ZEROCOPY:
+		return mptcp_setsockopt_sol_socket_zerocopy(msk, val);
 	}
 
 	return -ENOPROTOOPT;
@@ -342,6 +357,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_TIMESTAMP_NEW:
 	case SO_TIMESTAMPNS_OLD:
 	case SO_TIMESTAMPNS_NEW:
+	case SO_ZEROCOPY:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval,
 						       optlen);
 	case SO_TIMESTAMPING_OLD:
@@ -387,7 +403,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	 * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
 	 * but likely needs careful design
 	 *
-	 * SO_ZEROCOPY is currently unsupported, TODO in sndmsg
 	 * SO_TXTIME is currently unsupported
 	 */
 
-- 
2.53.0

