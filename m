Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2301FE471
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087980; cv=none; b=l+EdmpvubbrzmIaI79lbFf8wt/mn3ecoATjnHtYTxEvgVwKMMNCtPP3cofRQynDILE0v6i/IDkRZck99ZZ17ZdZ4LCv5SkdvMEwqOWwRgT9zkvfyMbKaC3uGRASkc1H8EhfCa1Be6GfPNY9b3ShVAf6FH5pdxwX5B35PfBM3V5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087980; c=relaxed/simple;
	bh=c5CSyTdy3BzyhnKO8OTXVMvkGGEH2UUJtieRDrgTp/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nv68dT29h+v4vrXzAyULR912O9QM/iG03VAV+1+YAOV2JpqjbSs9qzjHTV9/OpU0EfX0oS1loYowXtWK+7mqkps63toRHpWhtah+21fw2XjNKjwX7aXeIoMoAvrSGGVK79UJ5fnF24UhycS6sJVyzlETF4hedJDHJPhz6C2wclo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5ilMtUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5ilMtUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0D2C4CEE5;
	Tue,  4 Mar 2025 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741087979;
	bh=c5CSyTdy3BzyhnKO8OTXVMvkGGEH2UUJtieRDrgTp/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g5ilMtUoPHXar6SLk5AIg+/aSNay/IkdFPHzPgG53lQsRDTan9W//yU0mOyZvKbxF
	 ygq/7+wjwFUQzkzC70sAw5bN+5G/taRtNfP/F7ECfi/86iMY1DeZJah5fZA/enRCXe
	 DBBH3jYyLNmCYoMU5H4qFxrlEDB+wnliFwQFcdkds9/pOeulP90FU/LtUiYKXNcxSN
	 1BNRtpJB+22mAjmh9SOFgrjeXSpmyW3ol8FrMjTaTCqBAj+jvFEP90cnj2ylqrlTIt
	 QXH8fpXjlbNq8swQqkhndEWM8Hv8B/bZHemWH5sdByeUdFWeK4XUzZ0QxpkOr51Axm
	 Z3zrg2vRTuFpw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 04 Mar 2025 12:32:51 +0100
Subject: [PATCH mptcp-net 2/2] mptcp: sockopt: fix getting freebind &
 transparent
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-mptcp-sockopt-missing-get-v1-2-6d306d0384be@kernel.org>
References: <20250304-mptcp-sockopt-missing-get-v1-0-6d306d0384be@kernel.org>
In-Reply-To: <20250304-mptcp-sockopt-missing-get-v1-0-6d306d0384be@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=c5CSyTdy3BzyhnKO8OTXVMvkGGEH2UUJtieRDrgTp/s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnxuTokaWm2AyOJrMVHJcV47K78Ofkoq8h5OPQE
 liZ5yoTZHyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8bk6AAKCRD2t4JPQmmg
 cxKyEADHo57A9jl2LcKqACUHKxOEC0HZ2nWjw6cBGaDlgMXSxcgFJzGB0EEB4b8V2+2/1q/hpjn
 LddB/0YwYRr2waV+3Ru4r87ov3ZAPxS/0JTS8WFqKrn162AS5vEzyhg54rITrDHzaHf8zoH9Fy+
 +aSUNNDN7w/xygBNouZOI8NDWNKM79aYCeLu3FaLAjjTxZyESiWEkNtl42Y8lsBxU4LYsf8htP7
 om7kYXpFAQ7SVN+V2KyxBTEnqd2Rwd4kB+KgYd3Ab3UC8dbDCXEI7X4CmAnAd0C82Feht8D22AG
 exDzPxzRKVmW3WBRhCyC81aJiu9h6kyzZ0pUgJIlUIBhsqwgovzWOmJ3kC8ep2bYjJgOiI/QY4T
 Pwt7+SLI1WJyEoXo0riCDQVJUPueG/kQtFVx8a4hGXHcs1u8juSSf16WhbQoXet79kYBa7DZ9Bg
 xnSM5aV4oaDjzwldlzW+1HgzxYOPpBzKa1JbWgNzDuajNsWzvVDGSdupFPYm3aYDjSxi2Ky+CdM
 HgWrC8xSevKEoZJ0RMXiWw411nrkmlrUpb3YBhd7XaMDbARoHvJHKjhhee8ZnF5horz61oHEhP/
 Q2NQ7EmPI0KgbNLH8Aqt+dZcJLkatrCWUmCcBIt3v6AE7Snk4G3j5SaUNMpI0esOSt0dHkU6mz+
 +A45L5MgP+QKPSQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When adding a socket option support in MPTCP, both the get and set parts
are supposed to be implemented.

IP(V6)_FREEBIND and IP(V6)_TRANSPARENT support for the setsockopt part
has been added a while ago, but it looks like the get part got
forgotten. It should have been present as a way to verify a setting has
been set as expected, and not to act differently from TCP or any other
socket types.

Everything was in place to expose it, just the last step was missing.
Only new code is added to cover these specific getsockopt(), that seems
safe.

Fixes: c9406a23c116 ("mptcp: sockopt: add SOL_IP freebind & transparent options")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sockopt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 4b99eb796855e4578d14df90f9d1cc3f1cd5b8c7..3caa0a9d3b3885ce6399570f2d98a2e8f103638d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1419,6 +1419,12 @@ static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
 	switch (optname) {
 	case IP_TOS:
 		return mptcp_put_int_option(msk, optval, optlen, READ_ONCE(inet_sk(sk)->tos));
+	case IP_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(FREEBIND, sk));
+	case IP_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+				inet_test_bit(TRANSPARENT, sk));
 	case IP_BIND_ADDRESS_NO_PORT:
 		return mptcp_put_int_option(msk, optval, optlen,
 				inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
@@ -1439,6 +1445,12 @@ static int mptcp_getsockopt_v6(struct mptcp_sock *msk, int optname,
 	case IPV6_V6ONLY:
 		return mptcp_put_int_option(msk, optval, optlen,
 					    sk->sk_ipv6only);
+	case IPV6_TRANSPARENT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_test_bit(TRANSPARENT, sk));
+	case IPV6_FREEBIND:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    inet_test_bit(FREEBIND, sk));
 	}
 
 	return -EOPNOTSUPP;

-- 
2.47.1

