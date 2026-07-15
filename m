Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B662931D7
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113449; cv=none; b=CASaoj7Sak3Slyu2yP5XkcIxU0P2ZL8AqEtGjGRO4JLeiETh0jWyFllBmuKf1ta75NY574a4hgBGKkYIDcYsaBKh7yvBgzC+73NVQf80KsdAaITGdopfrcCupZR38mhhup3FT4k0N4qwV1+P9s9lAt4T/ZQ5AEHquhbRj3wWCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113449; c=relaxed/simple;
	bh=h0KHbTdRLXfAQDlm+Mzn4sOSwJyxsp1fPSLu/6K0DEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeJbBeVNKpAJ3a7WYHPmMl1eFtyXZ2GCpYpYQezKzWSwHH2Ge7xf/uQLA77puyzXBjZUk788N2eV2rkh6JHZevuMhRd7BDh8LdX8qm+GfbSPmgzEfx9cZ7vs2Vsgj4IrYcAqMa9uJ+8XdttTFVnKpeYn7h9dNLTUpnVAlLuCyMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtNSLf5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtNSLf5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC071F00A3A;
	Wed, 15 Jul 2026 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784113448;
	bh=1aL2W8PM3bCKMiZfqkj5j62ROsq0aloJ4VBeqLorDFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dtNSLf5kUYQgvfP7OSHENUtx54WtgU46sjlw4MbIkU3/tJdK95T5HM7Yk+Z2C41k5
	 ME3G7Mg0ydmc6WN05hn7uUsOSBD8gaQmJqiVlyrZQhPj4zeADLolY2AIlkDDT/31Kj
	 CMliAcpRlyC5hLUG+70WkdM7DjYDn5MYxd6Ud5cLwZYWHYHj6azWd0F+QGXkvphFPk
	 C3ClNz45lO7o1Kumuw/g+g5dEqHkuSC4OVT6EQ1QSjXfLIQs5rYo67bIgW1APap1T3
	 1HnwrDFWHk+r2r6T/UBseLAT3kDlP5iEoMra+mFGyetgbDdOCyqAW8sDvrilMch1ZM
	 c5Mw+ndzg3A0g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 5/8] mptcp: handle SO_ZEROCOPY in setsockopt
Date: Wed, 15 Jul 2026 19:03:50 +0800
Message-ID: <b089fb3fa4904333caa10b228131b0569092c605.1784113088.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784113088.git.tanggeliang@kylinos.cn>
References: <cover.1784113088.git.tanggeliang@kylinos.cn>
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

