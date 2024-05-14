Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFD524F;
	Tue, 14 May 2024 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649222; cv=none; b=tWEDYFFm9+BukaE/n0WW5hZUkQvPovwe4Qgc186xOQvUKt8z6rF3+DRhbsS9KPyICTv6TVyHt0n572dy46AiEHlSMPWV5C8c9D3Eal7usSFRuc6BJJYEwR2mqFtO94L4PUW0kAvGAJtgWhwNScmJRxcqTliZ6QesRNdCdEEkncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649222; c=relaxed/simple;
	bh=n9oAOoyV8ndvOD7gMvnNfgAjFUhX65q5z8LOi/+KKtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdzVNJ/v3YHh/2EVLi85hBLN7uLKsDu/66XdpZkGO9vfGpRZ39tVTaan4yG/+iAki+oWyzqEGo9nd+fgNpmzTqONjjTcJGHSmxtb8BWga/XZY7DaxN3N83JT2S3UdZekuDWhzJnLqebyV5vf502XPt8OszoS29uIQiKrCn+9oNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8TQ0hv3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8TQ0hv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED80EC4AF16;
	Tue, 14 May 2024 01:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715649222;
	bh=n9oAOoyV8ndvOD7gMvnNfgAjFUhX65q5z8LOi/+KKtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8TQ0hv3qmDmHOXYFKYTx13UHkszIygak84lQNDzNrM/dc6SP3HnYA6njG4VZRfzC
	 tKsW+oYDccMGeQkbe8v3pHu2f5bOPYrp5LiSVB5NzOMicLlcsl5oFRGBZ+iRk3wDLJ
	 SK3/1SKVbqIcjlr2Ek4ZS81G6lNSc87hXnSRWGpUMOuuNlWnqTtlJvWqQDUkaCG2ZK
	 jvN6rSR9U8DFMQur1q529k6GvjyMrt3mMy9MI1Q6/EAy3L66FeCmBjqpKdeHQBozko
	 4fZWfYo1dnocZQMb9h78D/9/31klxVP1Juh977AZGpwWBIzjW0gjPLRFYlu/dvHbxg
	 w1Kosq5cdbU/w==
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fw@strlen.de
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	netdev@vger.kernel.org,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next v2 3/8] mptcp: sockopt: info: stop early if no buffer
Date: Mon, 13 May 2024 18:13:27 -0700
Message-ID: <20240514011335.176158-4-martineau@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240514011335.176158-1-martineau@kernel.org>
References: <20240514011335.176158-1-martineau@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

Up to recently, it has been recommended to use getsockopt(MPTCP_INFO) to
check if a fallback to TCP happened, or if the client requested to use
MPTCP.

In this case, the userspace app is only interested by the returned value
of the getsocktop() call, and can then give 0 for the option length, and
NULL for the buffer address. An easy optimisation is then to stop early,
and avoid filling a local buffer -- which now requires two different
locks -- if it is not needed.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/sockopt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index fcca9433c858..a77b33488176 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -999,6 +999,10 @@ static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, in
 	if (get_user(len, optlen))
 		return -EFAULT;
 
+	/* When used only to check if a fallback to TCP happened. */
+	if (len == 0)
+		return 0;
+
 	len = min_t(unsigned int, len, sizeof(struct mptcp_info));
 
 	mptcp_diag_fill_info(msk, &m_info);
-- 
2.45.0

