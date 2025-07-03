Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECFE1CD1F
	for <mptcp@lists.linux.dev>; Thu,  3 Jul 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532437; cv=none; b=NQjI5QuEk4VvTpWxLuZBjmnKjPIA3AJZ+XglLII0D++/C/rhnIOHRD77AGXg5OUqmNRAsyOujpDn1XLMzLrnX+8oOBhfC4nYRvRny0Fa+G6EJuG2PxjdGAJh1SPAFNDQfEHj9Frpb09prAitvif4M2swjwaoCMyrUyW24AJRVis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532437; c=relaxed/simple;
	bh=bDMY23dA/RzUmn7QMYqs98BjpjHWDKIJzPP/SBcQxkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKNps3INVxwmYUfG3PZbJGzVlDPC99IBh/34863tGd4My1chqgOBkhPHbJZ+GVoiHIz44JGt9O3KAIJQZ3mF9wrOeCDP06BjEigzWN8lb9EK93ltKyqYvbSyX7tknaw3i8GE52ptSw1H3JxALvj4YexgWsC5Aon8gcHh4LGdEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDxsuK/o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDxsuK/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103D1C4CEE3;
	Thu,  3 Jul 2025 08:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751532437;
	bh=bDMY23dA/RzUmn7QMYqs98BjpjHWDKIJzPP/SBcQxkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDxsuK/oVjN00TVJujPbd2ZaIjHSDeT1U/P2A95KQcmg8DDS98kCqj1nG2dpJVLxr
	 jMPV8AzlTBfdJpdgyd4yIfBiwCpWvK6kfjAoqsvikX7eiDHtWA/3KcfOvBvaZasmW4
	 Z9IfLdEsORVGchzY8rY710TCoD/npCvzMs+MXsVHR5YFDvUZtOX1MkuovnF7/7Epla
	 ICMehhVJSFEseOu+EfBKKnVK7+lx0wHu7NvR/Geem2yanufcWpkR/PKM/x3VdlEbig
	 1hpuBJid4kcG6iqqvBRHiUYkBpSj5Hm/NtjBD5kx9jVvzLp21WVfl65L4z5yFTlGsB
	 wy3CNilPsUYwA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "mptcp: set .splice_read"
Date: Thu,  3 Jul 2025 16:47:07 +0800
Message-ID: <88ac8b73aba0ba8947cb52ea2060a6099427deaf.1751532205.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1751532205.git.tanggeliang@kylinos.cn>
References: <cover.1751532205.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add NULL pointer checks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a627e1ee5668..6fca35f3fd24 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -779,6 +779,8 @@ static int __tcp_splice_read(struct sock *sk, struct tcp_splice_state *tss)
 		.count	  = tss->len,
 	};
 
+	if (unlikely(!ops || !ops->read_sock))
+		return -ENOTSUPP;
 	return INDIRECT_CALL_INET_1(ops->read_sock, tcp_read_sock,
 				    sk, &rd_desc, tcp_splice_data_recv);
 }
-- 
2.48.1

