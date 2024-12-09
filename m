Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED02147EB
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734049; cv=none; b=gf4u2rnB0vrp+07uEiDRMs0DlzXcsEN+6UIjv2FD9PgaEoDdnbETDR/LGLy45ydV4eqXB2HILfQn560qyiOcxeg8VHrAxvVRGLKZNA6rjeICQRJtjC0RqzewSBBRWPwHYCwuTh9nQXaMnrlfnxmMkAUGMLhkhbj+USc13wD17rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734049; c=relaxed/simple;
	bh=6Jv1bZiTjeIAnj7+JEcUud5D+MHKJfVYna8mKV9jh/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs8XK34YDL4MkcL1Cr5QtxR0A1f3y7zuEtP1jzsQCAFS6f0+0C4jevOTdxpFagxSAcsSNJkKyDJ/1fn1m1KZrStCUKFI6/LLINHpj7SP/bZHj2pQy3q6QWLH89GIrCa7sx933NtAyAH1VYm1sMo+ZiY4jL2yvz853uq7Vfot/js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4lYV30P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4lYV30P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55807C4CEDF;
	Mon,  9 Dec 2024 08:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733734048;
	bh=6Jv1bZiTjeIAnj7+JEcUud5D+MHKJfVYna8mKV9jh/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4lYV30PZkBZ6qiQnn9SgYOXbUS8zxKn0IQTdnLctD+Q6Rned9rMRP8RGyRD9kgc6
	 CRHuOLIqLHRONHw8/F1Qpx9eUQqRrINcER1bHObsT7eKY11iAkRHj28DH0Rjb/lTE+
	 W/1PpO2bwz4/c29tgCfFI9yW5LHrDYiZavYDzwgW9VXWWgc6ijDI7UAQIVsXAaXLf9
	 wOJ/9VTFs3eFBSHdJwYkQ0wZMUZfqinVM/zoV00js1T+BBV/tSQmhgoYTUY0DfPdKi
	 Asilzn0SJc8EZWCo//y84K7rh1KGw8eaSK9glSBdkzPNBzvEgShLEHRGsZmz+0cOAj
	 TD7zEtaU1IpCw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/5] Squash to "bpf: Add mptcp_subflow bpf_iter"
Date: Mon,  9 Dec 2024 16:47:15 +0800
Message-ID: <f62b51d57b363348f46b6a77d427fbf121a7e944.1733733573.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733733573.git.tanggeliang@kylinos.cn>
References: <cover.1733733573.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add "sizeof" and "alignof" checks.

Address Martin's comments in v1:

- bpf_iter_mptcp_subflow_new returns -EINVAL when msk socket lock isn't
  held.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index f9ba0a46a9f1..0563d3c6d9d3 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -232,12 +232,20 @@ bpf_iter_mptcp_subflow_new(struct bpf_iter_mptcp_subflow *it,
 			   struct mptcp_sock *msk)
 {
 	struct bpf_iter_mptcp_subflow_kern *kit = (void *)it;
+	struct sock *sk = (struct sock *)msk;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_mptcp_subflow_kern) >
+		     sizeof(struct bpf_iter_mptcp_subflow));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_mptcp_subflow_kern) !=
+		     __alignof__(struct bpf_iter_mptcp_subflow));
 
 	kit->msk = msk;
 	if (!msk)
 		return -EINVAL;
 
-	msk_owned_by_me(msk);
+	if (!sock_owned_by_user_nocheck(sk) &&
+	    !spin_is_locked(&sk->sk_lock.slock))
+		return -EINVAL;
 
 	kit->pos = &msk->conn_list;
 	return 0;
-- 
2.45.2

