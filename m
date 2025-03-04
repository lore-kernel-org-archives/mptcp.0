Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D34A1FCD00
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741088465; cv=none; b=k96Hj9Gqoykz/8tuliXmKqTOr/tgWgH7URgsLCfnMhpC7YxizP7pgiADzTVbEUJIMLe1nOWYHPVfiLVNpK2pnD+7xpjEYNnC7nU+3l36EgfspmTIxrj5D8+DuRYYK3SsIkmUEM12N1qOJIN1ofv/B0ZSPGgIdzU/9BcVm0F9Dic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741088465; c=relaxed/simple;
	bh=+PQKihkDXPlndYbmwsdiDyVQpIisjZCnOzJvYYcl/pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEoRS+2tJUNMCTQntCiraIEQJbViHmLMmiL3m2Lfw+65XFtpDT4wodR2J6h70OVQCGr71hPIQo1oO1JE16FCaPhNIMj03qZuNTFM1NgnnheIa0yDDGbfMsrQ03WwqEYOVPt7whJ9aqGkMa7ipHOUivOrfV2OBwfJ/+ukJL98jEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrNfUb7Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrNfUb7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EE2C4CEE5;
	Tue,  4 Mar 2025 11:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741088465;
	bh=+PQKihkDXPlndYbmwsdiDyVQpIisjZCnOzJvYYcl/pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hrNfUb7QyfXFvabOuyrrb8hDcWpA8Jx204Mt04g9mSe7MwmkpnqdSL68wb30rx/Kv
	 UuivNlcUze/cVZNF7cTHUeW2jkd+A/N+8qvtDF2NAdc1m8zEy5kUiTo12uuMVrs+dc
	 usX2JMLwPudgWl/4l0zT9Jx2IupDnq0+CzxxdDfSc2Jmz+IiETWbMmOTa8nbyEU8GU
	 NSFmteA366KwIwwKc4Bg5I0mPCca1O+/0Flwt9kpxG2uvKWVvh/JvBHutcX2kgJIkq
	 lLUgJxYyeFwCGJ2XHN8TYEnOfCjfOmaooERfkLM/LmjDEaEfTMav/RD5pvE9JYPH1r
	 f3zO6qzgO8zBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 11/12] selftests: mptcp: add pm_type mapping tests
Date: Tue,  4 Mar 2025 19:40:38 +0800
Message-ID: <5af6ae4fa325ea616e4f65beba00a0a20afb60bc.1741088339.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741088339.git.tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper set_path_manager() to set the newly added
net.mptcp.path_manager, and test it inside a userspace pm test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 13a3b68181ee..fa1929ca6ad4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3572,6 +3572,21 @@ userspace_tests()
 	if reset_with_events "userspace pm add & remove address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
+		if continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
+			local pm1 pm2
+
+			pm1=$(ip netns exec ${ns1} sysctl -n net.mptcp.path_manager)
+			if [ "$pm1" != "userspace" ]; then
+				mptcp_lib_pr_fail "ns1 pm_type mapping fails"
+				return 1
+			fi
+
+			pm2=$(ip netns exec ${ns2} sysctl -n net.mptcp.path_manager)
+			if [ "$pm2" != "kernel" ]; then
+				mptcp_lib_pr_fail "ns2 pm_type mapping fails"
+				return 1
+			fi
+		fi
 		pm_nl_set_limits $ns2 2 2
 		{ speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
-- 
2.43.0

