Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB5B347FCD
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 02:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822561; cv=none; b=PdjdkLKNhNgI9DHhTE0VpiutAoa2qkb4P3oktE/Yd1b5XsYctEFjQl2+nwHfgkmlWfG9LhrATXJZSx2EMXWaRU21EtyORHOnh6WjbbREwpyE6V1ihmYwseiT1UQWQQrZd14jWIyQB/J+v4KQB6wBJkLDhJ7kO5kuQRMhk+zTSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822561; c=relaxed/simple;
	bh=kXKm6si4iXJLlyXEcj40GLiKTQcZdC35OqVbep9TFOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbJeD94eJfdrx+y4ZArtM6fLGiodRGvU6wwtmqIPADILofC/Yie2p2vIC9zWCUhjH41MTrRb1jURL7CUIpiLGxBojgIUA+VvONXJx7sJWRq8zhq4+o/ZRXfhMKAUv2IiWY2FBGTkVt7ZLhM7MMVSpEHUzpnCZB1kAOE2Qr57k6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSaUD+NB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSaUD+NB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80261F00A3A;
	Sun, 12 Jul 2026 02:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783822559;
	bh=TH2i7nLzFOPv1VBrrH4KEavWgg+yYDYhiYKzgeKfSSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XSaUD+NByGw/aTmgJtqL+LdcgDOQXT9fm749DOK5hjTzn7avxAas+aG297e11ctCf
	 vFB0Ftmwlnn42SUCiDhh/pWU7meDeqIHJKT0M3VXyozbncWHU3WCEkjYzBDui3zgPk
	 UvWDhhXk1nNZ3DImXzfdkJYrXBxHJG7wjHr+Ns8fSX1nYbbT51Pkz4XmSM/yy93jiL
	 sUmU/dTKEVtEG1rz4COxxsUKqroYbUE1BNsWjBgwbrtOhGXerjnW4S7ry7xtXWzD0U
	 gw+7c7NFfTW3yfmUGtNlKzyoGI2L8nF9H+lVqHqs5QRceh/lx6l7GfOmhzlcSjxLUo
	 95vs6dyjuqQ6A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/5] mptcp: handle SO_ZEROCOPY in setsockopt
Date: Sun, 12 Jul 2026 10:15:22 +0800
Message-ID: <42142dafc905e9a1efc1bca74a078daff71ac1e5.1783821830.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783821830.git.tanggeliang@kylinos.cn>
References: <cover.1783821830.git.tanggeliang@kylinos.cn>
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
The new mptcp_setsockopt_sol_socket_zerocopy() helper flips the
flag on whichever socket owns the data path: the msk in
non-fallback mode, the subflow TCP socket in fallback mode. The
check in mptcp_sendmsg() reads the flag from the same socket,
so opt-in is honoured on either path.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcf6feb2a9eb..c02373199616 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -175,6 +175,17 @@ static int mptcp_setsockopt_sol_socket_tstamp(struct mptcp_sock *msk, int optnam
 	return 0;
 }
 
+static int mptcp_setsockopt_sol_socket_zerocopy(struct mptcp_sock *msk, int val)
+{
+	struct sock *sk = (struct sock *)msk, *ssk;
+
+	lock_sock(sk);
+	ssk = __mptcp_tcp_fallback(msk);
+	sock_valbool_flag(ssk ?: sk, SOCK_ZEROCOPY, !!val);
+	release_sock(sk);
+	return 0;
+}
+
 static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 					   sockptr_t optval,
 					   unsigned int optlen)
@@ -203,6 +214,8 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 	case SO_TIMESTAMPNS_OLD:
 	case SO_TIMESTAMPNS_NEW:
 		return mptcp_setsockopt_sol_socket_tstamp(msk, optname, val);
+	case SO_ZEROCOPY:
+		return mptcp_setsockopt_sol_socket_zerocopy(msk, val);
 	}
 
 	return -ENOPROTOOPT;
@@ -342,6 +355,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_TIMESTAMP_NEW:
 	case SO_TIMESTAMPNS_OLD:
 	case SO_TIMESTAMPNS_NEW:
+	case SO_ZEROCOPY:
 		return mptcp_setsockopt_sol_socket_int(msk, optname, optval,
 						       optlen);
 	case SO_TIMESTAMPING_OLD:
@@ -387,7 +401,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	 * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
 	 * but likely needs careful design
 	 *
-	 * SO_ZEROCOPY is currently unsupported, TODO in sndmsg
 	 * SO_TXTIME is currently unsupported
 	 */
 
-- 
2.53.0

