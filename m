Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278AD13C3EE
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721752296; cv=none; b=N/YOOduoELKs7C1S9KW2wae+dm+A8dObnokOOVpPYnD4rFm8oeDZvdF/ZZqOuIJmsTK5LueSqqKRYHT3tncclMDv1pTHJZpdDQp2fVikTeRuY8Y+UPhvXJAf8fVWYM4snE2BeeeLszxC07DLBE7CLZ5By8AnN07aasamWzA3RhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721752296; c=relaxed/simple;
	bh=yShgghvWN+d0JwzuFGKRLCbjmKgCyWHurnO2662vpjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PP3iObr1Y/yWqE96yZAyBVE/gnH8gcB2m7s98eTpbI0MxhashW3t8DEfQpapooC2D+RM8V3vHyeSQYabM8zWf1ai3SSxatUH9j2ollrrcpXfScN3RGCUBeLnNCXuXncputbeO9u3RaH7ZXoIs0qP24AthR3u5cSAz55gLg9kBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjP39Pr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjP39Pr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9BAC4AF0E;
	Tue, 23 Jul 2024 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721752296;
	bh=yShgghvWN+d0JwzuFGKRLCbjmKgCyWHurnO2662vpjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cjP39Pr0xl8FME4ggV213hA8wWgMRTMz4WCrNpjxz97b/17FbC5p6RZDDdDz5kB6+
	 fiZbRk19DmraRqToEHeQaum7Rd4E0/cUi6U8I0UzhBQrXZvvpWq9rrZagmLc9cEyHk
	 7M+bbrf43iouuCW0hdHjKC6qYTH/S8duhw+m09ABlm+CUGgjVLrf61xPQBsks1AcIp
	 gx2xDS9aaxk1c6qChX6tl6df/G8fMIQyNydYvpmA9F4KTXa0Y4SmQDmIzYmB7HH4RO
	 hCPFieYDH592FayNhUGPGLksL9+OpuTtP7HB/uQV6+mpx+X1+9S7ti8TWEjL5rUBRa
	 kxRBf1qTlq2bw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 23 Jul 2024 18:31:08 +0200
Subject: [PATCH mptcp-iproute v2 5/7] man: mptcp: 'fullmesh' has to be used
 with 'subflow'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-mptcp-user-feedback-v2-5-59f18975401c@kernel.org>
References: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
In-Reply-To: <20240723-mptcp-user-feedback-v2-0-59f18975401c@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yShgghvWN+d0JwzuFGKRLCbjmKgCyWHurnO2662vpjY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmn9rgNk3lXxHqYzvtUm/UvPSpmXd8BY7QUUrVq
 sy5F0bmwjiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp/a4AAKCRD2t4JPQmmg
 cxXcD/0RKNs3oN6PpNQL1IhbjimeTrUiYgrnzC6h9+hZn1URPF27vzd2hc/SaKEGlSDwpbGoUGH
 CsJx13ArBOluvOGVxATIfoJRNHqUqYCozB1Mdi833xP8PRlKKoF4FZ5OLeQv6H8kmgc3Qmy5god
 lINArq/4tLijxSaHUwM1akvIO3Tm5FoRs385+1OeDl7OvNvvYjnNxqpDwgfQIzqur9I9aBO9vKV
 UprJHRyH7h0PYczBrDd7VfZBsFUpCC49KJQLo+b1JOYQhMPMJG1C7xw2m5z2OlZ8wDd+UBNofI7
 iE2lGqK9Sk7wvz04eDos00FghH5XEk2sGlbqds6oscBUmfngxyTK/YtLJj2LbvoQm42M1bUNIWt
 KA54R8HVo56mT4aQPM60n/OsA9Ya0OyXhWqscOtSyrqzvfy3Wt8QXfpOZrn79kMggo6rCIxDqPu
 X+WWc+CgbCe1g5lo62jmzIZUgXmZ4JYWTWZcYDQxSFzckqNiuatACurFA85VigwKNef0SEvqBdR
 VtyG2vg4nWIULJc5UpbZdV/eJvTNDZrcb2jVisbDoB3JWjTQG4K/E58lMkgDsL7kx63/Hl5TQmy
 nBASpFeCTmDDsIzDj4ilPIgUN+P81N8adt7n3FjT74d1FJzvAjVei65sKVT85TlTNOIVYhN+kCv
 QCAsoXUqpYp7R1w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'fullmesh' affects the subflow creation, it has to be used with the
'subflow' flag. That's what is enforced on the kernel side.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 4d4c879b..7eeeeef2 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -189,7 +189,14 @@ this will behave the same as a plain
 .BR subflow
 endpoint. When the peer does announce addresses, each received ADD_ADDR
 sub-option will trigger creation of an additional subflow to generate a
-full mesh topology.
+full mesh topology. This
+.BR fullmesh
+flag should always be used in combination with the
+.BR subflow
+one to be useful, except for the address used by the initial subflow,
+where
+.BR subflow
+is then optional.
 
 .TP
 .BR implicit

-- 
2.45.2

