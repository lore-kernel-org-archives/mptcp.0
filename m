Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439BB3A1E72
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767522702; cv=none; b=QIEDfBiTMHrzcVtpr27JoaU8E53dtjkqtJcA9Nl/ciDI4IPDdkBdsInszs8a2P21pJ4izMdTCrnK4R84POdqhrZ+2T3eZk+hC1NyMJRNIUtdOdmijkibVdINaaDS0N32MCSUD50tIkMehox7uRpDZQEYTp0tY9bTMN9u8uV7cvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767522702; c=relaxed/simple;
	bh=jg0I+brJWPqz0U3SH/U1Y1euIeqQA701EFsXBNnOJ8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+9XjtwWQPCWxG0IYG6V1n/t0l28U9sGf7eyTsC6o780SDFvyAjKSmMhM9PCJG+cJ0cD8FDwhcd6foaZ0ZYbP1ZjGPNfDKecgkQ+/CSTuVy0/KKcPVx/Dfyjw48WsBjsJwUdBYWel2ZmKFmwWC6jZnFKsfAM9dj5fgsAn7NDDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIkr9sb5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIkr9sb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FC0C4CEF7;
	Sun,  4 Jan 2026 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767522701;
	bh=jg0I+brJWPqz0U3SH/U1Y1euIeqQA701EFsXBNnOJ8s=;
	h=From:To:Cc:Subject:Date:From;
	b=RIkr9sb5y7gJmn9F8Jfvspry59Pg2MM/ZZuNyOxLKrMlboHdXmDp5+3ZyYxMSQUmx
	 zBIhoHaXet8Qe8b5P4FPhzI2rJ1GZzD6cJjQKzNYoTt4ddq2J2r88uOFauT2eG9d3l
	 e1wNrN64GRz6JivFyo3iyypJ5zXg0rOic7ZTm71J4grO0sQrAPpJdBuNcvSa1PnzSO
	 AVkwgiXdNr2LI3aMqzNmsjwVDVcwYqlkM49bF3bh4BILkU2XlYpMNpavFrKe21MYZA
	 GU7BfrXpeXPDpbIaxP3g3+GQ11jooqCZDR6Zh1PM9/Om/rqA2gc9wdvT4K+dNmcbkl
	 ZAkOT1dsi2Yjg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "mptcp: implement tls_mptcp_ops"
Date: Sun,  4 Jan 2026 18:30:24 +0800
Message-ID: <867d350fcac80ce446ae2a756f1eec09d4cc54fc.1767522515.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Fix the error reported by CI:

 CC      net/mptcp/protocol.o
  warning: net/mptcp/protocol.c:4754:21: warning: symbol 'tls_mptcp_ops' \
           was not declared. Should it be static?

Based-on: <cover.1767518836.git.tanggeliang@kylinos.cn>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 2 ++
 net/tls/tls_main.c  | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4cf59e83c1c5..02564eceeb7e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -132,6 +132,8 @@ struct mptcp_pm_ops {
 	void (*release)(struct mptcp_sock *msk);
 } ____cacheline_aligned_in_smp;
 
+extern struct tls_prot_ops tls_mptcp_ops;
+
 #ifdef CONFIG_MPTCP
 void mptcp_init(void);
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index db3c9ffabd76..70fd533d5c6c 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1117,10 +1117,6 @@ static struct tls_prot_ops tls_tcp_ops = {
 	.epollin_ready	= tcp_epollin_ready,
 };
 
-#ifdef CONFIG_MPTCP
-extern struct tls_prot_ops tls_mptcp_ops;
-#endif
-
 static int tls_init(struct sock *sk)
 {
 	struct tls_context *ctx;
-- 
2.51.0

