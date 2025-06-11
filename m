Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392D25F7A8
	for <mptcp@lists.linux.dev>; Wed, 11 Jun 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633911; cv=none; b=Cwu2EvxY13qcAHaaEq05IhNoMAfDjE1e4pCkbXYGxjS8ZPJHe3w9BUOM0Em90aJmlR6o6b7dxUxKtGYCMwdC3FJQVHtyt8Efg5+3F87CBWqmXi/X5qScpCDfDLaTZ1Msu/qC0dFraq9FM2DU/cfvueNQdcg1P9Fgz8/z1tUEZUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633911; c=relaxed/simple;
	bh=ckRTtky5dUmt+IN8CQ9dCGUKltmexIW6KYwF+rdoUaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTAhF9FXJZ12Zk1EwzHh4l6iSEM17zmrwKP4p+9lQUtOeSrcVV5fPim8TXx4bwJXjkZWN4WUZfaxvL8oZ0wuXCNZU9+nXe4m1vL8jFR9Fv0kTFfPtTOlE9vqJy+Zwqb5v1FF98fKs7jyS6e19+TjKEBWa15B+bdU1Di2uFR/KGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmt2H/3V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmt2H/3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A620C4CEEF;
	Wed, 11 Jun 2025 09:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749633910;
	bh=ckRTtky5dUmt+IN8CQ9dCGUKltmexIW6KYwF+rdoUaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmt2H/3V0eT4TO6tfhmnRaa34RNX7rq2rL0sQ9ntfRpLi7wPBKlhuHyc2nUgh+J5V
	 m1ro5YKCP326GA+XnfslnVxLaJXUlp2oD6uDu9X0H3IGCHLT+YIIW7zT8nQQrvFppO
	 GkjVSbsX9D1TJtvaw55ilrk4nT503YdoASgGW6IxB1Jm6wkJDgFPEL1W2iVNYZuymp
	 LYo6Kh8+OWo+NEi7apqGsQHreAwWfJtwZOZrpWm9D5XkW9llCquSbYhb1pv+qG2eR2
	 Lmf6I9HYpHtsT6D9s7+49AihlX/s1tzeuFEp2Dfr6aNTIN566mhOKvQCqCgTdKu3dK
	 HoWddUQQnrunQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] Squash to "mptcp: implement .read_sock"
Date: Wed, 11 Jun 2025 09:24:52 +0000
Message-ID: <35dbe3cb9fc4a23039b96981fc105440dea4c8b9.1749633671.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749633671.git.tanggeliang@kylinos.cn>
References: <cover.1749633671.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use sk->sk_rcvbuf instead of INT_MAX as the max len.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 32d389329262..53057c4f41f0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3965,8 +3965,8 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct scm_timestamping_internal tss;
+	size_t len = sk->sk_rcvbuf;
 	struct sk_buff *skb, *tmp;
-	size_t len = INT_MAX;
 	int copied = 0;
 
 	if (sk->sk_state == TCP_LISTEN)
-- 
2.43.0

