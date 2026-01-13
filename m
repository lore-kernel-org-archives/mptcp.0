Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A9325488
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768295374; cv=none; b=b2glha89tKO2aC2gEGLciEzvshkOGiRLHj1sed07FYxrh9qAaL+SA1nxnbRDarxoB9i586P0/wout951Gav0IM9m88AGeeoifUtob4dNrd199qfwd/6Dg6WDurpcZ0Bop+68vMCP3781pOiOPz78FgNLk+A9gSvJ3Z2Fi/ZXPhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768295374; c=relaxed/simple;
	bh=s+J0uiEWN2RKqf6vRJ0b882/FRaUaQiO4LNcZ2w7mr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpGwhafAr87tJv5Ze9v9q26Re1Xv672d9YfzDmhpH29JK15CIpRMixXFgMw6AD3o7w84Enbes+aZcaPBjrsWc8xPZCUm/r4//mRkGejmHIsh3ga1J3t01T+UJj18WOVhTj3hSueRLl7v7TRBfe289vNxEUkUUoBPc93HvI5ECYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRmHEAG3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRmHEAG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4670FC19422;
	Tue, 13 Jan 2026 09:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768295373;
	bh=s+J0uiEWN2RKqf6vRJ0b882/FRaUaQiO4LNcZ2w7mr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRmHEAG3QAvBeH4IdjGTWIJukUSO+6PivaaqJEE62J11m7qLLmlS6KEwLE97R6ILt
	 RecEZbPqN3128tqcLbftq67CrfEUivzHnNY+CpOYq9xqmqifPhQtGk2BMJDBs3I0h4
	 rMXrxk17UeeQChCNU4N6ko00M84inVU/4EK9hNx/d/Puf+vp/DgZFRHaK8SP2I3EaO
	 ts5FcaLiwJL8EZ8x2Oeft5/zJfFPczlJR1i7s3uZWt39SJrjcHIRxHZTarp6zJgMUZ
	 oBDQdleaDe9xEqHl8Bau495KExN/XCRThcpo/oNQrQmi/2vqrruRy/biel5lvNeTTd
	 1WdsSMEQQKDzg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC mptcp-next v8 4/9] mptcp: allow overridden write_space to be invoked
Date: Tue, 13 Jan 2026 17:09:12 +0800
Message-ID: <86ecc368bc66839d12bc409bccd07b674513dc43.1768294706.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768294706.git.tanggeliang@kylinos.cn>
References: <cover.1768294706.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

TLS overrides its own sk_write_space function with tls_write_space(). This
patch ensures that the overridden sk_write_space can be invoked by MPTCP.

Note: This patch was initially included in the NVME MPTCP set.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cd5266099993..f5d4d7d030f2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1014,7 +1014,7 @@ static inline void mptcp_write_space(struct sock *sk)
 	/* pairs with memory barrier in mptcp_poll */
 	smp_mb();
 	if (mptcp_stream_memory_free(sk, 1))
-		sk_stream_write_space(sk);
+		INDIRECT_CALL_1(sk->sk_write_space, sk_stream_write_space, sk);
 }
 
 static inline void __mptcp_sync_sndbuf(struct sock *sk)
-- 
2.51.0

