Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000192;
	b=SMOAJ+yMsAB1YqUs93g8uhhccpjC1b0gj2VX7eGqAA0i2UlGvZAtXK3KhBbqwkDQ7vOs
	 IDjn8D4BuFoO19IzvVaYh0ziCzLG9NNMJe3LoZNUDyRovXrsXZKbAM9enWdj1rFNRTucp
	 NmKKuoGp3HMUhIASwfl4/7QQHBcbGZ4nxaI8AtM0kPeM9gjyaDQVst/2uf7PNpz11YRi/
	 jwtx7UN3SJIv+mZnc9gIpyE4dFCg3umSwXpDYRMCi5NqcAqAgDKjmXzRPkXGNWLM/iYNE
	 3IlWrXaYCewj0vm3fhuePAS5XhkaMC2aU3HLGMG6HW1F5JB/+/5LDGrvSpbexApypzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000192;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=s3wUI4Rffeqvtew3fCHpivfru7G7wPPHmlZZmjiUDcs=;
	b=4wYKsZHksUUzv28sfIvkPjgCr+KSO40i0mkPqk3NdXGXoKlYERmwqzD2oe0SgT+np34g
	 mKPuHCUoV8bSTNLl7q7hrnH01McnU2i2iAmQtIFZmK11WV7EhYBch3sy+q9tBN+zboBHr
	 CYywoCoCxGynqy41bHUw2yEzBztngyDfbJqapm4hXa9J0TcBcvW8QgRmezzJ9sszZehpC
	 ABcRT0V199kD5ohldHiK7raPdZruToY4WGmVvmwKMIoCDZQJhYZRiysU1uuA76iAf0Us5
	 90nhdb6zORsPiHp57+M/EUdaNUfq66otrbBey/HKA2ZCsI60lkM1dXXbQIog30pOkQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TwkUEP5M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D6A606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TwkUEP5M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDDD1F01829;
	Mon, 26 Oct 2026 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793000192;
	bh=s3wUI4Rffeqvtew3fCHpivfru7G7wPPHmlZZmjiUDcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TwkUEP5MyJb1jbjdW7Wt2Ryve/omxcOMK8wBhS9t0uYwqocNIdJsYPDfQoVUxdeo9
	 nV2SwYvtwT6jkDWXxnaiIlyTm31FJjuJ7qtiNEsS5XyGrOb3oYx9BX8OH1STwu/ZRe
	 XWHVPXI2XrrQS4wuPm1zfiYnhTCNzxm/n9YsdQdFocQF0yGAFijzrBQ+y6Jb9iiCvj
	 vb93cGoY6CaoSZiZPLUaEmId5GhfrQmRGenrkVctxthN+5XAnjHCfiCo08Sr3KDAs6
	 IRNKNF0VvdL5rX84yWxjCFdxDOvTq55JtxIHGhnMSfcsN2fO4H6ov03DlPjUPA/B6f
	 8BgokPPwRq0pQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/6] mptcp: prevent dummy DATA_FIN on RST in fallback mode
Date: Mon, 26 Oct 2026 15:36:18 +0800
Message-ID: <827c399d23b97b70e59e123d32c7b4b74d3f3987.1792999988.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792999988.git.tanggeliang@kylinos.cn>
References: <cover.1792999988.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When a fallback subflow receives a TCP RST, subflow_is_done() returns true
(because sk_state == TCP_CLOSE), causing subflow_sched_work_if_closed()
to create a dummy DATA_FIN. This is semantically incorrect - RST is an
abortive close, not a clean close with FIN.

While mptcp_recvmsg() checks sock_error() before RCV_SHUTDOWN (so the
error is correctly returned to userspace), creating a dummy DATA_FIN for
RST causes unnecessary state transitions and semantic confusion.

Add a check for sk_err in subflow_is_done() to prevent dummy DATA_FIN
creation when the subflow was aborted with an error.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/subflow.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 78e886b20258..a53c83644a40 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1327,6 +1327,9 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 
 static bool subflow_is_done(const struct sock *sk)
 {
+	if (READ_ONCE(sk->sk_err))
+		return false;
+
 	return sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state == TCP_CLOSE;
 }
 
-- 
2.55.0

