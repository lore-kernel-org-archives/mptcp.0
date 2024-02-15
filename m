Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB2433B1
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997218; cv=none; b=vF14EKPnPlt2W4ikNrpDVGVQrJtIpNnv2jCWJXwiBOWili2L8DF4MXgYUAujuBJIxibCMN8H97TRdp5CszjAYzR+Wzit5eIpFHmR9C87MUVstCmzWqxyyJTmx8Ns6gbUXe00bwpMuGcAyrtsjE0/5C/6IStcZ8vn1ceV782NEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997218; c=relaxed/simple;
	bh=uCboPJ0LRaDIGMdWuBXqejhsmk8WqCnmSpXCIwZJHFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXj1y0JjpHKwio9hk30nkw9tOknRXilmXTOBBxfqhjprhsa/wPpx9M+xd/pjYq2Cdr78+kYar2V5NEQzjLLAAjhLUE2hsd2zqJJ2ZVJQuSv93TMDk9bbQ4onGL/obsZTke1QNUckQz1lNEnevNAHIxf90glcJ9e5H5JQIQoWTV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsN81ax3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsN81ax3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBD7C433F1;
	Thu, 15 Feb 2024 11:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707997217;
	bh=uCboPJ0LRaDIGMdWuBXqejhsmk8WqCnmSpXCIwZJHFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qsN81ax3SrOqCmj6TOD4pPXe8OG3VZ8BIUE2xy3ZC5WVAYo+Uy4JTgJpfqR6ruq6e
	 BSPM3CNpzb+0rRX4puNNJuApgWnkvSBReVpk2FN0U+JAAOwejnTsl6WPzsqvbPLzMk
	 py+m/6vgHodCnvMFyQ0J+qDiTOLzsrTi6rp0Fws0zNo4GMZY+Yp0GAnlqcKA2qGASZ
	 VELgc+6oyVTChqr7gIfQWnptt5Nclq4xsKxEsa3F8AhzLS3JBuPxdY6GRNtLxhhWNo
	 wqqLZZZ1cC5BdkmscysN3VJoxQ6oYptoWnVTP6AclgPU3piF42Dmbadxw+OpFDD1so
	 jEQQ+WQNkf0jA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 12:40:02 +0100
Subject: [PATCH mptcp-next v4 1/3] mptcp: token kunit: set protocol
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-mptcp-check-protocol-v4-1-16e932665e21@kernel.org>
References: <20240215-mptcp-check-protocol-v4-0-16e932665e21@kernel.org>
In-Reply-To: <20240215-mptcp-check-protocol-v4-0-16e932665e21@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uCboPJ0LRaDIGMdWuBXqejhsmk8WqCnmSpXCIwZJHFI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzfge/pF3aM0PypTWAngC+cOFobG6J8uvf0s3K
 WzbPlVN9RWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc34HgAKCRD2t4JPQmmg
 cwMqD/4keG0Z57qB3VeJjvDaRFgQI9uQK1cqPTBjfdpcI47nQi/lROp9scWB/qp285l2soY+d0S
 kvsL2JLDabr0PsW2+uJtY/m4zPsPi3RI5dl0dsVx0EFNQXo45+XfEwJ9OnH+YHmPoK2jdzfercG
 6BsUm/SwW8WrtYOjVCWJcdwzB9fBZ3mxQY8Q/Vf2b5O/vSXYs8eCnPxZtrQIoBI5GRZJf3/2H33
 c/4Z3/xsdPkFDwENumU3Ajv2tM+zhQXlkCIf8BDGUPYIbi+3/rgdElqWbukTap6EDE2aurllYA2
 mhhCDTjruomt1DVLU+8DoFKAozGb3LPNDpaclwUfkirdkO9a+1PjHZO/cjQMNIuqfjXmR2z/KG6
 AOjxrRELXD7KO77t0wfxFsNwFofDGyaXbzUGDmtSU2hnQISpHAdug7owVy8YK4o+FeqENzWRtbL
 smekq4mgcgoU4o1tAsaeAJqzZKn2LP7VkCGEkdV9c1lFS4rUbJSa2mVCDxfzwfwsyUvzZmoTEkg
 VzReA5Or5GcZfZUnHgBuuLZvDFBvHSntPLsgvXs34phRgHamMeb+o6GV7DdnNnMD4sA9kzl8T/n
 2Y691jrL+vg52jYzqRarjywYluYlxQrGH5levAL9O2XxgYO/iIMMwGUKwHeQ6Bu2EG3sk/Wyqb6
 gqkQ2M/olYXDRlw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As it would be done when initiating an MPTCP sock.

This is not strictly needed for this test, but it will be when a later
patch will check if the right protocol is being used when calling
mptcp_sk().

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/token_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
index bfff53e668da..4fc39fa2e262 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -52,14 +52,19 @@ static struct mptcp_subflow_context *build_ctx(struct kunit *test)
 static struct mptcp_sock *build_msk(struct kunit *test)
 {
 	struct mptcp_sock *msk;
+	struct sock *sk;
 
 	msk = kunit_kzalloc(test, sizeof(struct mptcp_sock), GFP_USER);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, msk);
 	refcount_set(&((struct sock *)msk)->sk_refcnt, 1);
 	sock_net_set((struct sock *)msk, &init_net);
 
+	sk = (struct sock *)msk;
+
 	/* be sure the token helpers can dereference sk->sk_prot */
-	((struct sock *)msk)->sk_prot = &tcp_prot;
+	sk->sk_prot = &tcp_prot;
+	sk->sk_protocol = IPPROTO_MPTCP;
+
 	return msk;
 }
 

-- 
2.43.0

