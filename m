Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B3E1F951
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984510; cv=none; b=iuMuZS+S5/Tvy8cWNTe84DazHsPWQcw135KG2Xox3qvCda1VzZHxsw9wDaCtfmXvvGwEWQFpOGMgszhZR3NSA4GPfPtNZ1zXKGPDpQzvFTbJIXLb4ttu3JeqSYsjzJuaLIiB+dvjkc2XufCGm1pBaZMgtcWBPzbtaxIOnB2eU+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984510; c=relaxed/simple;
	bh=apSMkqX6PlYgHFRluqpDHKw+wbmfYFw9YsE5MBU44Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZMHrzzxiZskMV4Onr6FOspDN56fdfeFq9tZkwne9Pvf+Y9PzGnSHoC+52z83NFFLeYSaX138Luams3bTatCR7p/uxBbnzCD7CPREPelLkLYgKM+2CJR6U0nEjCkUdmtLFcb/KA4Az6+f+kLBWbWAadTVXflk7LNAuZ9BZC6Mwg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSAdlEzH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSAdlEzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5213EC4AF09;
	Fri, 26 Jul 2024 09:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721984510;
	bh=apSMkqX6PlYgHFRluqpDHKw+wbmfYFw9YsE5MBU44Eo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NSAdlEzHjjdvDLPGWihE1VVcc0e+kgBwoYGS0FIA9v4WkdjJwG10k05lUzgqOatl0
	 7VmemXu7LkYYEsuhQMg56zUMypsNGLlefr5KGBqAjH0urbD6MimdFKXVgba/rs2TjL
	 vECwP6j3vAltKOa9X37h9HJorlO9IGf2FohFvoUOyo+RQVIEecpEQf32DnyqUEORq/
	 LCgzLSuhsOE7SRYU+esENRjRk6XuV9Dji4Bxb84yaxQ0hbfdieDYwTx4hd8sPNueO3
	 Miu4E2FXP53s/H9R6zMlAE7raglO3Iaov1vaDMHTCmGATVu99qMj5c+iP8OQpqQZeA
	 iITfhmjlzCvRA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 11:01:37 +0200
Subject: [PATCH mptcp-iproute v3 2/7] man: mptcp: clarify 'signal' and
 'subflow' flags
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-user-feedback-v3-2-c6ba1f5fa13e@kernel.org>
References: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
In-Reply-To: <20240726-mptcp-user-feedback-v3-0-c6ba1f5fa13e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=apSMkqX6PlYgHFRluqpDHKw+wbmfYFw9YsE5MBU44Eo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo2X6tVIDsMDfkiB1zy5JfigiSsG96Hxd9spyF
 C9zDA4SoeWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqNl+gAKCRD2t4JPQmmg
 c6HsD/40cUJOvk4dtaflevUzYF4K5GNEer/GjUCMEwYulxck6FPy+K2lHUbGYUao0QA3OL9DRzY
 7iPuViNxzCB099yQKbblvp4uBYRhn3qo0UPkOgMMYAt6TcwfxpgC9yjEd4uS8nnb9uTP2Fb8HqR
 GaY1XWaJogzQxDlIdr6ktyT4LwGU39y4aKD1Iztg8UccyblaL79p0uFaHJmWAHRbMuPY/tJMg/3
 z7qy6+SZUz3RSZgpfilJ80wLMuOrAlmXFtvJUEg9IU6zBiEddb6rnQfA0YbN5Zuk/C+kF4jNc0a
 c0Ayf40WHCfCnvIiNhNpogi/mDh9lazkqLQBi8Zsizre46Y8z4LQgHB7j3W1gLAGMlbgkCFgtVL
 XTJyy7SFGi0e3fvffbp2aidBWjalIgLtyEaZ5F4NeOT3in9twXGr5d5LjnwEcFg3CAxVZ09zUrG
 uiBizeNaDdf1UrY/3bnycIShCTzyFINPZhbKip/lMECyuIch+XV+MpYetgND/xJWmKFTZWlq6Rz
 DjuCB6qFhQaH82TMW1iK5LN16S/l3GDB7NXQmudNw/ZiBIPQn68lzx5RiwrSqCXoDwIeDywTwAS
 xrOYII/z+WM+2VbTmTTZjrOyv0F41Dcc9e+u8vtKuwB4TyJiMUCCRaesIPgRGyDDwrImbttSaY6
 2b3T+Wpd1H5WIeQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

According to some bug reports on the MPTCP project, these options might
be a bit confusing for some.

Mentioning that the 'signal' flag is typically for a server, and the
'subflow' one is typically for a client should help the user knowing in
which context which flag should be picked.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 89fcb64f..2b693564 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -150,7 +150,8 @@ is a unique numeric identifier for the given endpoint
 .TP
 .BR signal
 The endpoint will be announced/signaled to each peer via an MPTCP ADD_ADDR
-sub-option. Upon reception of an ADD_ADDR sub-option, the peer can try to
+sub-option. Typically, a server would be responsible for this. Upon reception of
+an ADD_ADDR sub-option, the other peer, typically the client side, can try to
 create additional subflows, see
 .BR ADD_ADDR_ACCEPTED_NR.
 
@@ -158,7 +159,8 @@ create additional subflows, see
 .BR subflow
 If additional subflow creation is allowed by the MPTCP limits, the MPTCP
 path manager will try to create an additional subflow using this endpoint
-as the source address after the MPTCP connection is established.
+as the source address after the MPTCP connection is established. A client would
+typically do this.
 
 .TP
 .BR backup

-- 
2.45.2

