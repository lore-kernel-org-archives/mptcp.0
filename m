Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3163A8D2
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764765; cv=none; b=RQ0GqYfkHaVhqRewSVxfCX+cGSTqZXROcsWzgmZ/mSu4JyQ6Ffa8o0fOHsUw4RKHIhoxfi1w08gZte/dnINJkck2ZoUVNoifgonGq6v8uzyIdkU+yss/GT0MUSQuh4d13IYhMzB+OCqtyuBb13wxKpLGEhkxdCTkAVnrBv1lJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764765; c=relaxed/simple;
	bh=qhbzNsHcvViIb5LJtBn9LRFim7+iKrU7WTRzdB8YuTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iSVn8GM5AAGTexjnO4iFpqB6ktBG5NLD7swrzMYz01086n7Ce2l8iIaR0dXLZiK7JAWIyGFwW7g+VBkpKd9wZDAD0QGtSFiyCuZOB7M9nLlUcfyohi4WCi6AADKAhzRmDq9DJSsSaVAeIzv1Rt+9DpO7QXwOGDg0Gt1Muqo447Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YneEQeV8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YneEQeV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0906C433F1;
	Thu,  1 Feb 2024 05:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764764;
	bh=qhbzNsHcvViIb5LJtBn9LRFim7+iKrU7WTRzdB8YuTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YneEQeV8K+jbDGJgIB1iaxnAFhJTz02dH5ZGsabGlvarPntt0AlFfdD28aNU2wOEo
	 BpA6B3ltTYkbQtnSjOdZs7NUFP8M6W94eri+yn1WE5mWUKoiIF9SmDpi3nsaYd0Zaf
	 ZUR7uieIs7QKyvCbOQKllRGbbNLl+0tbE2ynhY6xDr0es0FJdhABcWL5kLF4SPWAHD
	 /n7lkOcywvs4Q9HOZQojrKOjwmlVCdyf5TP5dWz+KzEs2OZ0xeyfv3J5bSTTvCFVBC
	 5pa8Y2TNt51Knt0YzGJaNGIx+wYFKsYjVXLKV/CMPvQq56kM3sWNBUqZNVqD37z3kI
	 kr44bTS4hx0YA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 09/15] selftests: mptcp: dump after creating id 0 subflow
Date: Thu,  1 Feb 2024 13:18:59 +0800
Message-Id: <7302b5f005300c252965b8131f537b448b20a31d.1706764519.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706764519.git.tanggeliang@kylinos.cn>
References: <cover.1706764519.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper userspace_pm_dump() to dump addresses
for the userspace PM. Use this helper to check whether an ID 0 subflow
is listed in the output of dump command after creating an ID 0 subflow
in "userspace pm create id 0 subflow" test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fa5c4e3f7c23..d471cd4a9904 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3354,6 +3354,18 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+# $1: ns
+userspace_pm_dump()
+{
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl dump token $tk
+}
+
 check_output()
 {
 	local cmd="$1"
@@ -3515,6 +3527,9 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		check_output "userspace_pm_dump $ns2" \
+			     "id 0 flags subflow 10.0.3.2" \
+			     "      dump addrs id 0 subflow"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.40.1

