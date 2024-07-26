Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91C1F951
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984511; cv=none; b=IrFFLtyG9boTWYqqOa1O+d/jbac8c/D/WQ3Xp0/w2BugERLucj0Xa81d7L7UBryb80n2MA5r4d3cU0+hi/5zVMgf6VZubt3r0WDhGUAYJXijzl8mNWnWX0yJn2vOeXrTbzcyZu4JwMwq8F9prldOx7/iTc1fPpHHzv15msJBNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984511; c=relaxed/simple;
	bh=6LK+vWpXvXMPJCfqIGEmLGG1ZGT7sOEi4Qt/ngfpWWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yay3zMH1X5nE+m1x8pZXhP6tMcOdEVBzV0fr+SD/FQCXTJGNT0AjCVo+lBG/o0Iiy03j4PW5YN1iB2oZIRqIgevNmgPjoLjf4nV/GHjJNoT6dZ7jSRwW2mPrtHPxkx+XiA8v2c28UjuDELY4gIDbsCNWf0W+7CHIkopGOEJWA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ6hMPOi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ6hMPOi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C83C4AF0A;
	Fri, 26 Jul 2024 09:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721984511;
	bh=6LK+vWpXvXMPJCfqIGEmLGG1ZGT7sOEi4Qt/ngfpWWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iZ6hMPOig2uaRdcJ9E+UIL4VuKzCpUXXbd6L3XocHTqJMxUBUNBzrhC5f4aa0Stqf
	 rf0ImqueVzkoXmNX8+Pz5qy/QdQ9f/jP0AMWLCx384gYKIj0VYTAnV7imPJ5v4Wnf+
	 AcqEklgwV2Qkr/Mb8NEIjGhWRUnG1b8Ufy/xgHk3hHD7hzCoBzn05ZQmkGZ3+NcVvz
	 uOzw0jgaPrsokoI162aaTaWlZLFf8yRBuexQWjosCvMfTndArIuYanq1rxZJ9VYR/S
	 dDW+MnZ9WeyzQFzHNgCRwldhj+2hSDSF5TuhMxDuZVbJCvYdoErv9jynXglJqOfIHC
	 yTIbhnBdM9CnQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 11:01:38 +0200
Subject: [PATCH mptcp-iproute v3 3/7] man: mptcp: 'port' has to be used
 with 'signal'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-user-feedback-v3-3-c6ba1f5fa13e@kernel.org>
References: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
In-Reply-To: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6LK+vWpXvXMPJCfqIGEmLGG1ZGT7sOEi4Qt/ngfpWWo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo2X6hb7hBf5BqDFgUROYi1IL6cGU5DGXYdia/
 9qUn4gHxnWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqNl+gAKCRD2t4JPQmmg
 cxS7D/41E8wKKmWb7zXxwri3Z1+UK73kNLt1wSimDCBHJagw23RKMZcjvL4ZJ45dBWj8p7GuVt3
 V7OkMY1vSb3He4bCv5hbH+AelbbaYPXJ8RhWd/QvC+zfqys/E3pybarrBkc8TxxfluDpz/2+olg
 sixHAOgVP4dsQLnWfomjyzBXJb8+rilOfOrYa6/cQukmEGRORXFkHv5sTtI/WkxQrUk3BJQrXT+
 nz6yriUmABnJVMXgRD/oKVbw7oQiSQGaRkamBAsXZVP26zTBCMg3/Ra/sHwO21sIPV/T3htksCD
 4Ysc/bkTkHDuxxGFN1sKJ6h8twSgOV8o79XVvNQYM68WCpZYVVl1P7P9fVOYubvGxpMPmlyDQsh
 YjN1bdevqfoPPlj9lKvvfwajIpDHNW/7SG9xSaBsDH5PxupFMifZa7VJne3qY3ErSov4JYkwvrm
 m4dyDxvxgr51oJguEgkIbcB4pCD6QZUVEjjZqzaMtEkI5K9fU771SFdmTlKoGSDAEehrgRAUpHn
 0Prt+o3LIW90CgkQ6ApETvCjHwUWKdOt9ZMIbt5RN14kjQL5xB1Is7VH7l9YJUBtNWTEEJcpgHA
 vYPNkZQVrwEqnX95vvL/GYe4DqD1BboK5dVnafc8A1XN2Qzusmg1KqfnLBCPkgtQAZOyM1uEdDp
 3TDeJqWgow3XZ7g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

That's what is enforced by the kernel: the 'port' is used to create a
new listening socket on that port, not to create a new subflow from/to
that port. It then requires the 'signal' flag.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 2b693564..11df43ce 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -133,7 +133,10 @@ is 0.
 When a port number is specified, incoming MPTCP subflows for already
 established MPTCP sockets will be accepted on the specified port, regardless
 the original listener port accepting the first MPTCP subflow and/or
-this peer being actually on the client side.
+this peer being actually on the client side. This option has to be used in
+combination with the
+.BR signal
+flag.
 
 .TP
 .IR IFNAME

-- 
2.45.2

