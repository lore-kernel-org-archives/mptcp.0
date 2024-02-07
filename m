Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C76199DC
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307014; cv=none; b=HLdVljYPt9AJy3DhSOlxBXpDcu+q8fzxQoYMpKRFoEjDoqqXkOiAlj8K4NDKbI93qrg6hIpC/jBRcHttAfveFjfc1uvNJj5HePYQkZtVLKBca0+fF1EZLLPZsRGxz+Y25g06ahoJ/8hVxL7X1h3TXeLTfkWksIFL0fN8pwlfrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307014; c=relaxed/simple;
	bh=5RnpXBTmJah/lQgyyeXn6rhz8z43A/1TcmH1d3oAxs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxSoNiEnmZCWfMUINpohcZsH6fGjvqr7k0Xfh/vUqkPVDuCD+r6Lyy+DjZk5wid06tEfUu8VWPB64Oyexl3KlnCyEHIy4z8QqerVF5gIRdXcXvR7dMo1g5alfu0Q+eQp4mNZToHwwVa5rPEj/AB/dybtkwXjWgKDjcN7fFker9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbbFhhk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbbFhhk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4AEC43390;
	Wed,  7 Feb 2024 11:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707307013;
	bh=5RnpXBTmJah/lQgyyeXn6rhz8z43A/1TcmH1d3oAxs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HbbFhhk5mz2hOoMI72eWebhYndAjJY7loZk4YuIOYQZLo4W7FmsouR8ImbSuC2hoo
	 aqkvr6BW803H9wS1t4Uer0FipSHdJLc90SJQTAFjE/vgifSkFyel++whDADmdMxPL6
	 k6bP1RwFtOp5MByyPLn3OM0yqy73FxUNZVyLQh0Wsz3aiC4Ps/R1icgNxLy/HFA92D
	 BnlI/p+5MHn3WhZ7Mj5xYxyAXjp+7J4MKbBeLdTkTDiGHwX6olxIQcvgKNyIQX8LHp
	 3m67CIhObah/Wo4SOVsmyAFIQnhB9n4JUgB8Q3DCyiyVn3bIpXSMnxOKinZq0J/BOZ
	 OIqMRQ6nsq+7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 07 Feb 2024 12:56:25 +0100
Subject: [PATCH mptcp-next v3 3/3] mptcp: check the protocol in mptcp_sk()
 with DEBUG_NET
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-mptcp-check-protocol-v3-3-77c69c596f55@kernel.org>
References: <20240207-mptcp-check-protocol-v3-0-77c69c596f55@kernel.org>
In-Reply-To: <20240207-mptcp-check-protocol-v3-0-77c69c596f55@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5RnpXBTmJah/lQgyyeXn6rhz8z43A/1TcmH1d3oAxs4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlw3AAQn1XmhWjaQG6CvjdZmUCDOZNz2u02nBwh
 Lv6ycjTirmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZcNwAAAKCRD2t4JPQmmg
 c8YhEACgks0ptmmkAev8mOdVc7YdlWPOZ0c2emM6NZKsMuQE/1lxo+kQVQBf/NExZHhbj/KA7qi
 YW5QBNk05G2u+peBF+AnqbsrYPLGNAmB/mVx+mTk/Qn3hgH0q0o6UiMjQZkiT5oEa5SjO0RLT95
 7HtPqze9i3kknBDKspYcoqx6xoAK30gc0pJE0M3q+7uQUxuEDeZFQCd5gutPYmSfo2S4hGcnVrk
 z6plHRoz7O0add87rPU8WN42Bs2mE3KISWibciKMfq15M0GV3m5jztQeCbOUoDlBV/zzUviBEh0
 5+MluqAezWUBD3PWBkH65jPJZgmkcCNH6hV4CXlH0kjG22Gr6QRbI59F3Kbnygrv83ImWgBC6EJ
 3RMIOLEIpQOSCaKFgVokiNbvIZpIdtjVkDRABMHx2ktvDxz8JkQpaW8Lsmom/aRDmTNXSfSd2eJ
 yP4H7MkTjuIkIWhzfNGK3M+NXEFOOE7npIcTawv8NPYWT7grWzPB8BH3TSOUdVBsai/1tHLoEe2
 tuweMIMlZdGSZA6tPxBa3EXeD1DdBbDvXjnWez/Q5aApQJUamHzjAcRNty1J90dMKgbnnIvwbtM
 Qd0zTrXTskTWVphwJYtVO1ZgGBviWbnykPMYwe5Jk+vW3Yb6Q0znT/ZnyKHFkjHTXePQI//x9Lf
 dISiyBtdcWVWrVg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Fuzzers and static checkers might not detect when mptcp_sk() is used
with a non mptcp_sock structure.

This is similar to the parent commit, where it is easy to use mptcp_sk()
with a TCP sock, e.g. with a subflow sk.

So a new simple check is done when CONFIG_DEBUG_NET is enabled to tell
kernel devs when a non-MPTCP socket is being used as an MPTCP one.
'mptcp_sk()' macro is then defined differently: with an extra WARN to
complain when an unexpected socket is being used.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  v2:
    - Use a macro instead of an inlined function (Paolo)
  v3:
    - add parenthesis around 'ptr' (checkpatch)
    - there is still this check from checkpatch but I guess that's fine:
      Macro argument reuse 'ptr' - possible side-effects?
---
 net/mptcp/protocol.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6b62a7f35dd9..2b837676d1fc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -355,9 +355,14 @@ static inline void msk_owned_by_me(const struct mptcp_sock *msk)
 	WARN_ON((ptr)->sk_protocol != IPPROTO_TCP);				\
 	container_of_const(ptr, struct tcp_sock, inet_conn.icsk_inet.sk);	\
 })
-#endif
+#define mptcp_sk(ptr) ({						\
+	WARN_ON((ptr)->sk_protocol != IPPROTO_MPTCP);			\
+	container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk);	\
+})
 
+#else /* !CONFIG_DEBUG_NET */
 #define mptcp_sk(ptr) container_of_const(ptr, struct mptcp_sock, sk.icsk_inet.sk)
+#endif
 
 /* the msk socket don't use the backlog, also account for the bulk
  * free memory

-- 
2.43.0

