Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258617BB21
	for <mptcp@lists.linux.dev>; Mon, 22 Dec 2025 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373349; cv=none; b=exTcPeZGXU0814prH3diJAMypn4smVQCmEXZs3+zQ5iaZc/VNt3xBylpO4aV1bu3Yw+2HZOxx4PXaab4qGE0ypfrTm9Dw7gXv5wEgtvey7prbMpQ0dp5by7koDIlaHfLTyZwB+41x808PdJVzbA34E4yI8e7vN+BQoPIMMUj5qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373349; c=relaxed/simple;
	bh=ay9zKnjO7Zj0NHw4LCkAruhgM2sMbmPS+SIGauojMd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqCnr+j17BJt20Gig+IARt1STyooLmQ9N5MwKuPkIGbc6TUB5NP0vHPInrsZE7M6J2+teCqJuzMxAJsR5qpYfvWevBagkGwnVVgkmY5Tj3nMUmQn5FkSh3Mmomxqy3SICoNE9Q+d14RC9lq9qZRajcTSEDmkg3eJojmK5Ranl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPpK8oFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPpK8oFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2351C4CEFB;
	Mon, 22 Dec 2025 03:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766373349;
	bh=ay9zKnjO7Zj0NHw4LCkAruhgM2sMbmPS+SIGauojMd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPpK8oFfDylwzrcad1k0x5SPZoAKpAhSj2FAsP1PmUBi9H6ByL+cquDz9pR0gc8dR
	 +4ykxgN7ujuwp6ncuHKpC1TxNcTeBoG36pGBGyAjvlj9wnQNjUnsBaBAEGWzkNQyMW
	 unwJ5CER/JziVYT1bFRzkwqWjdJitCXnYRcT/eov9VhYpef0QBh6Rw5M/WdbpoXN7a
	 wQ93bgIBK8G7Z2ppBP7fRvrmIX0VlOAVUCoKa/bON18gMGtywXsuE2AqGS+XceMhm4
	 wSAVhxxrkkCWchS3O5HgOLJw+4BI/2l6GrYMKeU/y7rySkA8wCSmL6AxBxnHR3XBbz
	 eRrkBDvqNt/+Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 7/8] mptcp: fix the mptcp_check_readable
Date: Mon, 22 Dec 2025 11:15:26 +0800
Message-ID: <814297ff30d16e51ac7c126255ef26dbfdc1ca10.1766372799.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766372799.git.tanggeliang@kylinos.cn>
References: <cover.1766372799.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

'mptcp_check_readble' is corresponding to the 'tcp_stream_is_readable',
but the later one will call the 'sk_is_readble' ->
'prot->sock_is_readable(sk)' -> 'tls_sw_sock_is_readable'.

If not apply this patch, it will cause an error in 'poll_wait_split'
test when running tls_test in mptcp mode.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bdf53e4b3f7e..8363d89d3a13 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3260,7 +3260,9 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
 
 static __poll_t mptcp_check_readable(struct sock *sk)
 {
-	return mptcp_epollin_ready(sk) ? EPOLLIN | EPOLLRDNORM : 0;
+	if (mptcp_epollin_ready(sk))
+		return true;
+	return sk_is_readable(sk);
 }
 
 static void mptcp_check_listen_stop(struct sock *sk)
@@ -4322,7 +4324,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
-		mask |= mptcp_check_readable(sk);
+		if (mptcp_check_readable(sk))
+			mask |= EPOLLIN | EPOLLRDNORM;
 		if (shutdown & SEND_SHUTDOWN)
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		else
-- 
2.51.0

