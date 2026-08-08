Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE337E5F2
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160486; cv=none; b=cg54ghBSWgwciI17YuFbaVgWcyVKsP46Z05GLEqI1TetG2rDTgFN2uTGmSqBmsjM/mfWqUR18FcjKzz4qWdPPjohe7U8LKI/XKliDZFAuoouwuLzhuc+TmsZUbV/tQNL3YKYCI3wIjvuV8WR6SEHkgTlD6h7nYpWc119nCu+FSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160486; c=relaxed/simple;
	bh=DSQT6F5PcffIqxBLWKy7Ua+WpXRORF7ScrGp+LXv+i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDnHAbDYCW/4C9EUqrrW2zFK5Yfa+F6C5y6KTd3xwkzVjrhAURM0Ucn9SiHLbqBckq9l2zR78DYICAB5ZC0JDjVRdp8GXVXw3JC0Ma3P27znym0jyyFtQbmng6zaquYZlVHbgna032rj2JdvFapSaOJ4GJPRzgA1Xo140gN11iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZv6meBv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZv6meBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DCE1F00A3A;
	Sat,  8 Aug 2026 03:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786160485;
	bh=znu+rjDLrIvZE6/B7n+hCwCiEa5QO+72sQV4VPFREWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JZv6meBvSlvgnz1gyiKlo4lolF7kn2DBD0714/K3YPw0hWc+LVwwfODPuA8XRJL4/
	 rL/a7OU7w7H03FEgSqcoRA2l+m/WLTEQxiSB/jgYJcqo9rg+aB5Uz+DTPe1EIyEgBA
	 1WwQOiiuKrr8bkSI96AOExvTrlzrCti6fT3CY/MEwnynhsYNbD0caYag1Ozrgdonn+
	 atDKQ3dyvavxioWk4rIxiTR1p+gCDSFVPHK4oG5fhE9DgExFfhbaGJe+itQvbRfWob
	 YwuCuQG16EuEBMcl5jABQqMg1YpKomGqDMVYfqEHLJCUB7M4pfKfo9SUdNWPRR5U80
	 gaXoBY3k9bFlA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 05/11] mptcp: skip ip6 options on v4-mapped clone
Date: Sat,  8 Aug 2026 11:40:35 +0800
Message-ID: <93de8a870e49441c35ef2f2836613d5f91a24b67.1786159812.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786159812.git.tanggeliang@kylinos.cn>
References: <cover.1786159812.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4-mapped IPv6 destinations carry no IPv6-specific options, so skip
mptcp_copy_ip6_options() when sk_v6_daddr is in ::ffff:0:0/96. Native
IPv6 subflows are unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c2762d74f29d..f19777c04d32 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3750,7 +3750,8 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	__mptcp_init_sock(nsk);
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (nsk->sk_family == AF_INET6)
+	if (nsk->sk_family == AF_INET6 &&
+	    !ipv6_addr_v4mapped(&nsk->sk_v6_daddr))
 		mptcp_copy_ip6_options(nsk, sk);
 	else
 #endif
-- 
2.53.0

