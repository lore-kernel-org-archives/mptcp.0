Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8461F336ECF
	for <mptcp@lists.linux.dev>; Mon, 13 Jul 2026 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913549; cv=none; b=fBcL19V2tO3NnFwf054qx7P70m7KCUSlpOoMxCiI9sLaHcOJZab/sDVW0C8L82Px6ORXWjBfZFo6oolfqGk6m0mSZP1lSIWPJ5j2JFc+gezShP/gnn6sfpisu2MBY6sbvdmlOWbH+TsPUjfmoqTo1Aw1Uoau0HYVD5xPqggPRl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913549; c=relaxed/simple;
	bh=g12QInZZm9uAEB8vH+UVkxjY4g4LWQbgcUBV6Vl8YOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcEkBO/J3Ynqf/oOtbTC/2799MlbiiFtkKvcKm4r+EaZOBaz1GAdoLHtJAWxfx4PA0dSnYZFlYnhcI4jwEmiRU6tApjN+1vKdniypFiUrH+FPgEljBVjh1mHxrKckYsuWgRfSPM9VlNHPsEjfNYssstAeVlQH/zkUQEh3UWT9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqjdXI2+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqjdXI2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE731F00A3A;
	Mon, 13 Jul 2026 03:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913546;
	bh=XLxKMUhOcEYVDrUxoiLdhpibnUKceSYQfHKS3MspWTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LqjdXI2+nB5KyxC0xGhiPviZvqlschBuEAaIQd0oagK5gCFwa4AA+v6lmp1n90Vq5
	 SG+QFiWtDSHohETJ8VooboQLR5x9d9ruJi495dgnHdeFGl5mFYJrjJ9Jk5stPagrD9
	 xt9+qoU1gY5rRzsWYkWLH9B9wy+yv1OiKPU6AYABzRraMZueNyEv9hGEe+j76XbTp+
	 tJWhEf0GnuLxz8tOF5Stc/bBw6RazTrIPO4ilNBD6XdWctj6BgKTp29JQfm9kjZgUy
	 MP2E43CFg/CO/M2gKeXs4H2o1W8arg5XWSpnhSpnPBNnKMyYYM7HN+0wBevz2bzhvs
	 YuuNa7dUQ2fKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/5] mptcp: handle SO_ZEROCOPY in setsockopt
Date: Mon, 13 Jul 2026 11:32:11 +0800
Message-ID: <8d306e449fe38533265122fb09c67fb402a67be0.1783913332.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783913332.git.tanggeliang@kylinos.cn>
References: <cover.1783913332.git.tanggeliang@kylinos.cn>
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

