Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E5C8EB
	for <mptcp@lists.linux.dev>; Thu, 27 Mar 2025 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743055472; cv=none; b=Wi8DkbQIP2JSIceUNDMeM02Vk+G+R/kUyNtbenO7AUjtNL+vXMmeN04RARvlBlOu7fY/btJOY3sAWvOFOTlHdQ3k2aXg/mc1BwFBc7Z0DFumA/PfaXHiozust6tCsBnSiyiymagOy51MJAxzRBDTvtX3kdZMNgfaRGAfB4+Luu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743055472; c=relaxed/simple;
	bh=YO3YlXqT0t10hlK2/gKcXPeMUu8Dfa5Dqy+7eYZtW/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLjVMWo541BLlAxrDW5tlnp/gQX79ZY9vAe3gfwbBZulk79vHSMqawjIlNLNVNOnE2n0NlxFopfvsDE4w5o1EQbzoV8bQ0zXkad3WazmBMKKUgOTx2UURtZT7IpO0Z8Pj/+rR/QJsDIq1i00nxrP19AeN4zR8LxW7CuZ9rdioBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hpcurtt9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hpcurtt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AE1C4CEE4;
	Thu, 27 Mar 2025 06:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743055472;
	bh=YO3YlXqT0t10hlK2/gKcXPeMUu8Dfa5Dqy+7eYZtW/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hpcurtt9F4h3PrtTd6yLEyCxJvYoZapwMun6EATpjK80ZQ7+dn96FKwU/kZAnatgj
	 V6pYdAUSIgt1Wm8ctfjbgeA91mqhGXdNG854qnXLWLuwOOWhR0//KfJ196Hlk2IkgB
	 SjzbrkZ/m8XLyItAqn/l4I3ID2w7X9cHKJMczZBHwsa/8JJt4i0iygnsmrAl9I7+SS
	 YxT+jvwRd7gZi5+8tsxgxWDIi2P5cgMrLv2MT7sXpbTvDznI+3iJp+TUPsUlPQh2DP
	 +1TYNm7E6RLxTav+HsMMxr1cTTjHzXVFQcY9YSoVkg7DvzhsuuVJuZcn3AR+Smoa7a
	 Qpz+2st4UmY3g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 1/7] Squash to "mptcp: pm: add get_local_id() interface"
Date: Thu, 27 Mar 2025 14:04:11 +0800
Message-ID: <f30498386ee78e59743afbf3e2897a60eb3af5bd.1743054942.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1743054942.git.tanggeliang@kylinos.cn>
References: <cover.1743054942.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update the comment for get_local_id and get_priority.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 9f28ef550e10..4cf59e83c1c5 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -118,7 +118,7 @@ struct mptcp_sched_ops {
 #define MPTCP_PM_BUF_MAX	(MPTCP_PM_NAME_MAX * MPTCP_PM_MAX)
 
 struct mptcp_pm_ops {
-	/* required */
+	/* required, call from the subflow context */
 	int (*get_local_id)(struct mptcp_sock *msk,
 			    struct mptcp_pm_addr_entry *skc);
 	bool (*get_priority)(struct mptcp_sock *msk,
-- 
2.43.0

