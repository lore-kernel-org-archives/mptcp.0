Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F6DDC3
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986660; cv=none; b=tSpijWrbG5QNcU9GpET+abMlcRO2gBb3ZBEiOXVJhLPkzI+dgZevlHFO12FZbGjn+Ooxy7yW7xnly8B7fh9aScgW8cXjhV8QjNJNN8Xz/nEQLInZvYdmZkb1aaIrGyB4M1qgpzlzxwJPI7hYPI9FdsRYRHLtiKsy23CdH4W+MCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986660; c=relaxed/simple;
	bh=EWwOYyAoARdNML8jinH/T8wESmxc0RqStwQnE81qJzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1QC2l+O29hcF2iQHsFpynLCnMToUc9mZKzlKnGP4mq55DeHFWkkCSYuX6BesgZfRAFUwwEaPolSsAD4qqGY5M3jS0RfQVOlXJGRswZgOa3db/hx6LzIKEJNRSDr/eE3acXslMjtp32jDXTuR6Ae5fhdHVGC/b1FQ6RzbGVgPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yfl4yOlC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yfl4yOlC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C87C4CEF0;
	Tue, 12 Aug 2025 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754986658;
	bh=EWwOYyAoARdNML8jinH/T8wESmxc0RqStwQnE81qJzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yfl4yOlCVZKtjbH81w78sY3zipjMGaz9Kx1+3RkyBWGInBzLIqdKbcU1MIotdlbXS
	 krYs6CPach3iC5JaaQgZezahg7efQWAF81BC1zp2R9F7LyqkrAX5lCaifHcbIcJlFD
	 3tstTXepXTpq7K64nzYBQxwwDcA65NujztMATpaJiUY7XBPE9olSSv2cILr6qQpboz
	 gThZLrEX9R5iV78KSGo2DJy6vUpmA6tFpLEItjoU5rINlKSesrHB5RMiYBMXMqJos4
	 McHx+XT21y+KDWC90tg8NJ0csCSWxWv+JT21mIf1F5Xu4uollVVR9jUCokARzgJaR2
	 9WsJLIdlc96zA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 5/6] mptcp: handle SOL_TCP options on all subflows
Date: Tue, 12 Aug 2025 16:17:20 +0800
Message-ID: <a5d23e81a795076bfe5868c16a92851004a8c344.1754986557.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754986557.git.tanggeliang@kylinos.cn>
References: <cover.1754986557.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement mptcp_setsockopt_sol_tcp_all_sf() helper to apply TCP socket
options to all existing subflows. This ensures consistent configuration
across every subflow in the MPTCP connection.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 964131ef82d8..81cc24125c29 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -848,9 +848,9 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level,
 	return -EOPNOTSUPP;
 }
 
-static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
-				   int optname, sockptr_t optval,
-				   unsigned int optlen)
+static int mptcp_setsockopt_sol_tcp_all_sf(struct mptcp_sock *msk,
+					   int optname, sockptr_t optval,
+					   unsigned int optlen)
 {
 	struct mptcp_subflow_context *subflow;
 	int ret = 0;
@@ -858,13 +858,26 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
+		ret = tcp_setsockopt(ssk, SOL_TCP, optname, optval, optlen);
 		if (ret)
 			break;
 	}
 	return ret;
 }
 
+static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
+				   int optname, sockptr_t optval,
+				   unsigned int optlen)
+{
+	switch (level) {
+	case SOL_TCP:
+		return mptcp_setsockopt_sol_tcp_all_sf(msk, optname,
+						       optval, optlen);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
-- 
2.48.1

