Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D64DDDC3
	for <mptcp@lists.linux.dev>; Tue, 12 Aug 2025 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986653; cv=none; b=st05/dM/R0+XFqwjQpY3UoRHIcZXP7wISD+uwKC+4LudeRtPj+ZFrg6DwdhmpgmAf+Z8o29dQxgwq2wSixOsftD77K6K6JCOOj/1gsWNKaaoW8jkj7DhnMI6PWfTbu1pcvIGz34y3ZU0+BWEECW/H5z7jGUUVcgbbpHqMns/9u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986653; c=relaxed/simple;
	bh=9pJf1zRuo0TP5+4IWk2SSqRJMnP9mlqynIWJyZQ5+vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZaHmUtBL5BbjBDjt1DGpUIgXOjt94WLyx3uaTlQSlWZBmP+Jcs5wu8Ke8pgrclNAIIO3AEuioDTY6Ehy6MCdHX/bbRKlqPQxB2MsVjsOGvZLMBeJ4Nw4/bvR8N2iHNKCkOLm8tJOwy9cWctNW228a/MVZ4NQrCkWVjh7Th1XG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=topL40zy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="topL40zy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22E0C4CEF6;
	Tue, 12 Aug 2025 08:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754986652;
	bh=9pJf1zRuo0TP5+4IWk2SSqRJMnP9mlqynIWJyZQ5+vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=topL40zyxUQ0MWukzYiW5kw7TwbJOfWta48avE3lRTbk15V4Z/o4TQIncAiKmzG4S
	 opMcM1US+ZW5i/ZW2k6Ij9A6XemHojs5IBGljDfvzrYzTcz3m8KpCyJ3z7RREbzaNx
	 1aEctVIy11ucdMWWq/jtF4/YRhzdmzQ8VNymUXxNKdfYACvc6SgR7MSrLpIieKiv6m
	 t8AhmkatzOtEE5KaUB3OtR8EIgZ1XlvW49AusrIhYhSQDtCINl24viz1ObFA4Abaxs
	 yABci/rjZXDdJTehBR3rnoGrlMWYHxYM4KEf2Z+PRczoT8ggS+rmZJd99+K/6bfPgz
	 bpG43CB4QRnmg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/6] mptcp: add helper for setsockopt on first subflow only
Date: Tue, 12 Aug 2025 16:17:16 +0800
Message-ID: <a6dca2cbf3321f7844696ee833e7d55ddcf6b31a.1754986557.git.tanggeliang@kylinos.cn>
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

Implement mptcp_setsockopt_first_sf_only() helper to manage setsockopt
operations applied solely to the first subflow. This centralizes handling
of TCP-level options that require synchronization only with the initial
subflow.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sockopt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2c267aff95be..6cc073fab17c 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -776,8 +776,8 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
-static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
-					  sockptr_t optval, unsigned int optlen)
+static int mptcp_setsockopt_sol_tcp_first_sf_only(struct mptcp_sock *msk, int optname,
+						  sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct sock *ssk;
@@ -791,13 +791,26 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 		goto unlock;
 	}
 
-	ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
+	ret = tcp_setsockopt(ssk, SOL_TCP, optname, optval, optlen);
 
 unlock:
 	release_sock(sk);
 	return ret;
 }
 
+static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level,
+					  int optname, sockptr_t optval,
+					  unsigned int optlen)
+{
+	switch (level) {
+	case SOL_TCP:
+		return mptcp_setsockopt_sol_tcp_first_sf_only(msk, optname,
+							      optval, optlen);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
 				   int optname, sockptr_t optval,
 				   unsigned int optlen)
-- 
2.48.1

