Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366EF289E0B
	for <mptcp@lists.linux.dev>; Mon, 15 Sep 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959890; cv=none; b=fC+79WNS2IzEwL/EsvBEnKlCGGh0U5LL1cQEwe55jmcKbgueEaEGmARQ7DErHTgTNiD4GS8vuuXwWVfNWJrRYumCdLVPk0l2g3p3jO8OXZ12ZmK63y6UyBWKJy0TFgcVnn3wYD0woDFi7TKWlKyYbdFSlSFaFHsWyv6Nljn9vhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959890; c=relaxed/simple;
	bh=GBqDFHcuQygAoasiYlnDrHYFJfIgbKE9erdIbR3p0NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y4zKyB03av98UOD1yUXglK1cadh39PhHTAVAcmQf1q3XvSIUEfrH3eNJTExnLprTl1Anh7ovfBi5XLW4AZkxrQTrQ6i/Y1B8krrE4xUcQ1fWdPKI5GQyVQM+nfFdVWZnVsCsQrOu1fm2ogb9nBa+Hg57U/N+FwXXD9b7gdm7iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDJhMrOg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDJhMrOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C84C4CEF1;
	Mon, 15 Sep 2025 18:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757959889;
	bh=GBqDFHcuQygAoasiYlnDrHYFJfIgbKE9erdIbR3p0NI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EDJhMrOgMex8cBLf2HFT4j7+jT9yivltlQBECA7B2anaFRGCN4WvkgzizsA25kv1j
	 FT/XgXLzdXuXNUxIbba9T3P5Ij4jFSqcsXRZmH25quV+xLIUlmyB/LMzbcHJZRMee4
	 Y5KhUWPxAy7Ecbta33a1qxO9YDVhtVbKX49wGBFA7F3fC+f1tyYbhB0vudoaF3IljE
	 nFpVAf6XbHnkLiHzlOIlzlEzT3LkleiSL6/QQYTStVlDtzWdFDrToUdJUBTmWeqCk2
	 +nBFYwgEtncoj8YJeZz9lthJvVC+XTRHWM9WYZEvyhwQcBCSsAfMXY4cuwIZAPJMzK
	 OJTNilgybbajw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Sep 2025 20:11:18 +0200
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: join: validate C-flag +
 def limit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-pm-c-flag-client-default-v1-2-6bb241e4d991@kernel.org>
References: <20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org>
In-Reply-To: <20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3396; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GBqDFHcuQygAoasiYlnDrHYFJfIgbKE9erdIbR3p0NI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJOhJ3j6VLdNHXOa42Q9YHVEy5vSS4K7XvMHefN9OqEe
 0ij9gbWjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkU1jAynFtsJJl2uHtD5arq
 jclhyRrVNbbeuYsvJoT/38+n19hpy/DPzPVAZ8Sx58krXJR6V+xZwfA+09I+X8t97uQgeT4bUx5
 OAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The previous commit adds an exception for the C-flag case. The
'mptcp_join.sh' selftest is extended to validate this case.

In this subtest, there is a typical CDN deployment with a client where
MPTCP endpoints have been 'automatically' configured:

- the server set net.mptcp.allow_join_initial_addr_port=0

- the client has multiple 'subflow' endpoints, and the default limits:
  not accepting ADD_ADDRs.

Without the parent patch, the client is not able to establish new
subflows using its 'subflow' endpoints. The parent commit fixes that.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c                                  |  4 +++-
 net/mptcp/pm_kernel.c                           |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index fda8d1880224dedbbfb20954f93a04da435346df..5d037f9d4e0b4d158beaaa5a48c4efb50fe9b5cb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -637,7 +637,9 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		} else {
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
-	/* id0 should not have a different address ; special case for C-flag */
+	/* - id0 should not have a different address
+	 * - special case for C-flag: linked to fill_local_addresses_vec()
+	 */
 	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
 		   (addr->id > 0 && !READ_ONCE(pm->accept_addr) &&
 		    (!READ_ONCE(msk->pm.remote_deny_join_id0) ||
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 408801e20ed6e874b80ccbf38af76abc13615a3a..aae9b92aea4715dabaf3101a0341ab7eab16f407 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -394,6 +394,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
+	/* linked to conditions in mptcp_pm_add_addr_received() */
 	deny_join_id0 = remote->id && READ_ONCE(msk->pm.remote_deny_join_id0) &&
 			!READ_ONCE(msk->pm.accept_addr) &&
 			msk->pm.local_addr_used == 0 &&
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6055ee5762e13108e5e2924a0e77d58da584d008..e80f90581a2531ac31339ae3543604c68677c232 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3306,6 +3306,17 @@ deny_join_id0_tests()
 		run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
+
+	# default limit, server deny join id 0 + signal
+	if reset_with_allow_join_id0 "default limit, server deny join id 0" 0 1; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 2 2 2
+	fi
 }
 
 fullmesh_tests()

-- 
2.51.0

