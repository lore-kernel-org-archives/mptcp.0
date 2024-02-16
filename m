Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED01CD1E
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077055; cv=none; b=Cqw7X8pts/kQ+rL4vrpVrRXyr4pt7qLrK/MPIytGMssGf8X1wDU+3dn3a3rSseWnynNPTyE1SuS57mCS/lqtdnBsW6nvrNmjbifs3bik1jsfsSPUdLQlXnsDxIi77zVrPX4QYT00Ftyy2oD0K0lI3St2kGvF7b8EL2PTZ7+yJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077055; c=relaxed/simple;
	bh=cKRbb0c0guvejKW9j5J7luR+8vA4BbBT80H37rwsE5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fwFnEihXiHbVI/nBq+Q1YwieOedLxeC7qlwrURnwpY3v2XeQrkr/RC6zNSzoeSttrhlZnL6zT7BQJg3XST7OTdYixnTJEHQ9q5edFwWQN0q1euWCaTGQOZ7f20sOvpEPaX16o59AMrOq/AMWBnAKby9g7/i99tKASIoR4UhWlKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWTJwWg7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWTJwWg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08791C433B1;
	Fri, 16 Feb 2024 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077055;
	bh=cKRbb0c0guvejKW9j5J7luR+8vA4BbBT80H37rwsE5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWTJwWg7UamEba2dwLEaEfGJGw/ImeN+r/UhyRACGuh/KW0GaOrBAsnj+JoAS2fIH
	 oFuxug45ZQKB2FeM+sSHs1+H1jKM6jePIcuslCQd6ddWhXTms82eU0H3XKDQD7lec8
	 xJfinJgcG9KPxWE96NUsqtfifUkNb2VeJ+aeGeERIp1KAOL8/jp7nzf/UNKrCPMtzA
	 8AU+fTErjJ+CflxysshSSVQ9xKoDoNJVUxNW9SDHkZp5nQe35eJpnGFOZk4l5J8ilF
	 5pqdmwxVlARILGBfLe51ElWkGujqgwVBC0kD6ABWjfp9+H6ZZdIWl9J3eYhErGSy7C
	 sy/uga4c6QaQQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/7] selftests: mptcp: diag: change timeout_poll to 30
Date: Fri, 16 Feb 2024 17:50:32 +0800
Message-Id: <a0a67fde8bf9a59be5c661c3489d78552dfbc049.1708076886.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708076886.git.tanggeliang@kylinos.cn>
References: <cover.1708076886.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Even if it is set to 100ms from the beginning with commit
df62f2ec3df6 ("selftests/mptcp: add diag interface tests"), there is
no reason not to have it to 30ms like all the other tests. diag.sh is
not supposed to be slower than the other ones. To maintain consistency
with other scripts, this patch changes it to 30.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 0a58ebb8b04c..8573326d326a 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -8,7 +8,7 @@ rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
 ksft_skip=4
 test_cnt=1
-timeout_poll=100
+timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ret=0
 
-- 
2.40.1

