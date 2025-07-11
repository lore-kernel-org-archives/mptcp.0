Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE65227
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752197777; cv=none; b=Y00d0fNwiZTaJBWdw4z/RlzjdksnHrilUZyecH7IKPWL5PDz58uRIX6l86djA6iAcc6nhQ24aapKo6KrmbUCryBja1LeIayL8BROwv2ojWdzL/eOxXbZQ5NRulIbD6l76UDxZ3APkw1598rK4fzj0gdj9H1xwwdPoxHobk8FvaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752197777; c=relaxed/simple;
	bh=NXrAKw9mC+lyRqL+qTmEsNGZDlEeup8X2gjc6x/TG1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNO/kVQ7+ul8sxzqBaIE0nUN3LX6IckLdWnb1Bn12yVFoIUoljh9hMLSuZE05Gjj5fizZm5+p/u6+UKV2b5gvjuuEcPg1+ZdPrvsDgIYWruEI7uoKSEq/vmBd+Nrfh80EvaXiC+6W05NC3ak3DnRReqrbvNNfq1+pWF2H4FptPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGfevu7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGfevu7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DF1C4CEE3;
	Fri, 11 Jul 2025 01:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752197777;
	bh=NXrAKw9mC+lyRqL+qTmEsNGZDlEeup8X2gjc6x/TG1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGfevu7m7ihG6wfVdhdrNX30woK+Akz6ok8rFOlr1ru9gEmVFgMGI8hnStVXAdM/J
	 JmjiDBtw2iJtUkpsBC3ox7JMqxfZQvESuFnvw/NvFrWKpzyDA66AhzZHMsIO9/y6Dh
	 mEn6zKE0nqM0/bwHP8VODS937PFUUtwjuXvwO8zfZeMsCZhNXU5JETqXJ8coK3QfhU
	 R7ltABIDrXscFWUX1NbqCiVzLMkdhPWXUqPrj2n30Hju8ngMaph1phPNumTIwnUsWI
	 kfuLEf7VdrFgMuPTg4q5UGflsvh8huYxFyBI4sTSSBMiF1k59nqxpgB/bntyIXNEGi
	 194H820Jh3FMg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/2] Squash to "mptcp: implement .splice_read"
Date: Fri, 11 Jul 2025 09:36:06 +0800
Message-ID: <1456b8263a71f3b7a2666c89c0a862a6e87cc72e.1752197546.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752197546.git.tanggeliang@kylinos.cn>
References: <cover.1752197546.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update the parameter of mptcp_recv_should_stop.
Use mptcp_recv_should_stop at the end of the main loop too.
Rename to tcp_recv_should_stop.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5dc3716daab5..54eb5c824b74 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4036,10 +4036,9 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		.flags = flags,
 	};
 	struct sock *sk = sock->sk;
-	int shutdown = -1;
 	ssize_t spliced;
+	int ret, err;
 	long timeo;
-	int ret;
 
 	/*
 	 * We can't seek on a socket input
@@ -4060,13 +4059,16 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		} else if (!ret) {
 			if (spliced)
 				break;
-			if (sock_flag(sk, SOCK_DONE))
-				break;
-			ret = mptcp_recv_should_stop(sk, timeo, &shutdown);
-			if (ret < 0 || shutdown == 1)
+			err = tcp_recv_should_stop(sk, timeo);
+			if (err < 0) {
+				if (err == -ESHUTDOWN) {
+					if (__mptcp_move_skbs(sk))
+						continue;
+					break;
+				}
+				ret = err;
 				break;
-			if (shutdown == 0)
-				continue;
+			}
 			/* if __mptcp_splice_read() got nothing while we have
 			 * an skb in receive queue, we do not want to loop.
 			 * This might happen with URG data.
@@ -4086,9 +4088,7 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 		release_sock(sk);
 		lock_sock(sk);
 
-		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
+		if (tcp_recv_should_stop(sk, timeo))
 			break;
 	}
 
-- 
2.48.1

