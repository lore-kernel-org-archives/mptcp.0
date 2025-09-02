Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122F9212F89
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780515; cv=none; b=UyNWvIUxPv3WbhpZLL1lK4XnUo1VwvZQYpq2qR0OK1lrTWAJMBGoCNsFxopyuvJjIewJ+ukKCrp9oeoZ9FAXzSjEukY5JszcOVHp0KNvfgSTSl3BAn7cbE5jjBwzKXkO4oEknknoVS2ITQHhpsAh82mZomkP/4oq8swLKOZMZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780515; c=relaxed/simple;
	bh=moMuiFOgVUkY7ROKiCerLa/pgI+I7obr2rAWzku1UgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwf3TiB+NMoCPTSiTBGQtB+hLW4YpoLJQYhNFBMn00kc8DGyGFqstIGiyBcvf+x3Lfqie5s+lsKKy97fHLFs3VZEXuhsIXR9j5atT4lSikYhwfCy6FIZFh5Sx+GjUCbou8msESyb5DhRTeqZNxDqvJKjhL2XjYpc8Jdp+BUz11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtTd24wJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtTd24wJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F7EC4CEF1;
	Tue,  2 Sep 2025 02:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756780514;
	bh=moMuiFOgVUkY7ROKiCerLa/pgI+I7obr2rAWzku1UgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtTd24wJshvFcjWdFxnXFFXPdPOfKSxWN8VObqBUfd09jEsfWGHHfcYKjez8m83DU
	 xGaKgB/1wSZJMlmQbWGR9CFhzn2KpbzB5BfdxIYzkfHbcdtFwfjCh6phNPoc1cBwk6
	 j/OJgCEW7nlESHmPIIAs4dZAjEjx5+cL0sXJTy7XhniRWGJn4OetkzN8wJ1ivRRnIl
	 TqiHujt4lW9lNU3UnK4bokLij9DhSYtw3Ag8Dj6VZ8Cq1O/zdwWAhUIJewsUS9/plo
	 XRvmNERZtpchfTfKrPmsNlhrJynGr5dZokbButYM9OgHncUaaWVGMo/960Vr1Zt5iF
	 M+IO8TVVFbtiQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 3/9] tcp: drop release and lock again in splice_read
Date: Tue,  2 Sep 2025 10:34:54 +0800
Message-ID: <89fd2ab6630a8aceceef58273faae8db195ef2e6.1756780274.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756780274.git.tanggeliang@kylinos.cn>
References: <cover.1756780274.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In the main loop of tcp_splice_read(), release_sock() is invoked to release
the socket lock, and then lock_sock() is immediately invoked to hold the
socket lock again.

It looks like these two calls are useless, so let's drop them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c9eb94a6c41a..c6425f13afd0 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -866,8 +866,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 
 		if (!tss.len || !timeo)
 			break;
-		release_sock(sk);
-		lock_sock(sk);
 
 		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-- 
2.48.1

