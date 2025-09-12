Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C092E8B90
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680712; cv=none; b=T6L3wb5p3Co37FwOqxHIgglJbn4uU1qWhKTElGP/xl5MLQ9qhC5o5j/9zH5IFe8HSnHV8mkcfRAAC5pj9CS4aCtRyhMtIy/ja8Jl4g8JZx72/wFQa5p2FjA/RG40aWsvi9Fu4S7hDAjsHzxj/i6SS8n8ynLjTOUkz8bUv/bTte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680712; c=relaxed/simple;
	bh=oiKGCtgQpqjrM9X9ZUeNhOWAiZi5j7p10X8voyw0D6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3zYEhXRU+HBWJ3f9pkxEDIeSaqtUYQpQxkn8tq2A2jfkxX+bqqQ5q8wM2tHqgNVxCZLQfEQEao4Jx/Y4qtMsGUrGCDIB0jyIR24c7w4yQoKmpexNtw5WAmDaIxpKYnUwVXjT/OeLFURdH9978NRcwehUEfTydcg0UB2heMB9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qq7nXVVS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qq7nXVVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4E3C4CEF1;
	Fri, 12 Sep 2025 12:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757680712;
	bh=oiKGCtgQpqjrM9X9ZUeNhOWAiZi5j7p10X8voyw0D6A=;
	h=From:To:Cc:Subject:Date:From;
	b=qq7nXVVSe5R0ojIZFJG7EHC1AboximkZDYwsk7EttmvSvsDUaeiM9+OdZ9/Nfc/oE
	 dvw0+9FsrgxoemA2NtqHbjyusLn5NagyukNao1ltDBOpX7fkto8LegEJPN80rbJESB
	 pZG8th4AWA3h2uiUCq9vOWchhzZ7L46XXEOXPeVNs4d9CLpsQ5F+1eletZfjL67dM/
	 PMYxGZPHBZ7dH5LnEbYatqrMKWH0lB84nHI+9vcnwmuorbiBmNtdLwtOYMzPuff81C
	 ocwS9Af4Taf3NQq70a1sQzN4FRCDyU2BC9+idEhdouS8hHnJns4pwrQyB3TVSkSZXz
	 8jOa+B97NDAOA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: userspace pm: validate deny-join-id0 flag"
Date: Fri, 12 Sep 2025 14:38:12 +0200
Message-ID: <20250912123811.1179276-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1496; i=matttbe@kernel.org; h=from:subject; bh=oiKGCtgQpqjrM9X9ZUeNhOWAiZi5j7p10X8voyw0D6A=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOiJhUp53bFVvp27+nqerLnmnWFgmMB25tOxV1ke2Ka WziyegVHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNxPsDIcOdNfke58OWeUkXt 1XvTEvNeb9pb5L1u/o7PZjvLW2qdnzH893VWXX6ZXWuxXNGuy0H3ellq7s9f5nVk2btp8pM/Hj0 exgoA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Set net.mptcp.allow_join_initial_addr_port=0 on the client side, so it
also validates "mptcp: set remote_deny_join_id0 on SYN recv" commit.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 0801d57a9710..3d45991f24ed 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -201,8 +201,8 @@ make_connection()
 		is_v6="v4"
 	fi
 
-	# set this on the server side only: will not affect the rest
-	ip netns exec "$ns1" sysctl -q net.mptcp.allow_join_initial_addr_port=0
+	# set this on the client side only: will not affect the rest
+	ip netns exec "$ns2" sysctl -q net.mptcp.allow_join_initial_addr_port=0
 
 	:>"$client_evts"
 	:>"$server_evts"
@@ -242,7 +242,7 @@ make_connection()
 	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
 	if [ "${client_token}" != "" ] && [ "${server_token}" != "" ] &&
 	   [ "${client_serverside}" = 0 ] && [ "${server_serverside}" = 1 ] &&
-	   [ "${client_nojoin:-0}" = 1 ] && [ "${server_nojoin:-0}" = 0 ]
+	   [ "${client_nojoin:-0}" = 0 ] && [ "${server_nojoin:-0}" = 1 ]
 	then
 		test_pass
 		print_title "Connection info: ${client_addr}:${client_port} -> ${connect_addr}:${app_port}"
-- 
2.51.0

