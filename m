Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C310E9
	for <mptcp@lists.linux.dev>; Sat, 14 Sep 2024 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726304378; cv=none; b=Bzn1A3YiHhk+QRF5FZZNAptOGysNmdc3kqsFcY3geYaxd1zHUlwTudYIz8QgmzvtMGvcZD2/oRLG/ZduMVeLznjvRA9NI3ns8mZKpSUivEGTTZ/tM1Apt/hD9BSucEAmE6TQYLEwjaEjh1rqcEMBO2vVvJk8kRrO6JAok1qw+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726304378; c=relaxed/simple;
	bh=JrjP+cxxwQctHpBi6PyjZFtDkVVFpWStd9Gbslehly0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIo83XLgLaUGSeVIGd8wCJv+uoxwzZwuukxMDiFQXoYxQCqOvDffkhR2R9XwPKCZ4NHdaseGvGkHkIyg2CLzc28ed3X4hC6w1AcweEvRU0nF7gXiqt6liRQAezT9w19FUuf7cKicAuVnn12BhpMQYcJo0Rg8Xne5+Eez+zjPPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dduljdT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dduljdT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34CAC4CEC0;
	Sat, 14 Sep 2024 08:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726304377;
	bh=JrjP+cxxwQctHpBi6PyjZFtDkVVFpWStd9Gbslehly0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dduljdT8XNkT4OsN/D9b4HRd5NbygeeIZ1GqJwXFqa6ZtSuYkjInVuHB7XG626Cdl
	 xrO5x0hq8F/pCSab0nWFOXcpdp1vep5Myw1xDx7t5f4q/FyAx0tYQsKuUs34OWB5zW
	 huBJvFnlxdtM+WVMIrdw+Dur1/hOd6Aice68rDKSYpy8eE8ir9JRawRzwsXWE/hU3V
	 Gh+0nrV4DskzLKZLA6Wztow2hmpyjLDohAd7sRJuZBQfkqGxafbcU+9XSrkwVSuIuR
	 mSRgTqWTR1OwokgcFPAEpsKuWWf42nSlGa/vO3umq4/NCMmLOvZUz1FNMKdgK5pg3X
	 2w+07nYs4bQiQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/4] Squash to "selftests/bpf: Add getsockopt to inspect mptcp subflow"
Date: Sat, 14 Sep 2024 16:59:27 +0800
Message-ID: <0568d6aac109835392a348e548d3b97a4ffa626c.1726304196.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726304196.git.tanggeliang@kylinos.cn>
References: <cover.1726304196.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use can_loop instead of cond_break as Martin suggested.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 928a1e5ad8db..c3800f986ae1 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -26,10 +26,10 @@ static inline int list_is_head(const struct list_head *list,
 #define list_entry_is_head(pos, head, member)				\
 	list_is_head(&pos->member, (head))
 
-/* small difference: 'cond_break' has been added in the conditions */
+/* small difference: 'can_loop' has been added in the conditions */
 #define list_for_each_entry(pos, head, member)				\
 	for (pos = list_first_entry(head, typeof(*pos), member);	\
-	     cond_break, !list_entry_is_head(pos, head, member);	\
+	     !list_entry_is_head(pos, head, member) && can_loop;	\
 	     pos = list_next_entry(pos, member))
 
 /* mptcp helpers from protocol.h */
-- 
2.43.0

