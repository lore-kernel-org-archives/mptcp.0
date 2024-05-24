Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8E11720
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533348; cv=none; b=BCH9l9Vdfr8SJadiwduYU4z4LQzV538NwKFo6e0Y4M718/tF6CtrqFsKIod9qaniuoNVvUo/zjd8mUTkC+2k9x7lH35ae+sTMtn1Vhe4ozrRg8ODEje8FzCUZtor4K2zuXwc8M1No0hZIkWrMNZH9+DaYv5jleazxVN61inoT4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533348; c=relaxed/simple;
	bh=D94f7tCpA8bNG91b284y77ri1VvUdY02S9+axO3A/c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2lYleOlqXvcP51LmOyRjuJhsjfn/Fj7k27+zFFeMBFs9+E6ZxN/ut1qY6i5urGiWn3tXpzwptF2MKDcoGB4M3+0sPR09GUGnTuNsZAqQ+ORK0uW83OcbaEXLR8OrIt4NLi2fYDmpfbChBydS3C1iL8i11kEc+lN4GBZGBkaoSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBSU6hhV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBSU6hhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE6EC2BBFC;
	Fri, 24 May 2024 06:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716533348;
	bh=D94f7tCpA8bNG91b284y77ri1VvUdY02S9+axO3A/c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBSU6hhVJSxt+J2yirWXrH8JNVZnApC5ANB6ttazOmpPdK8zSvRr7LRFwBuP8bzC9
	 w7CwFifpk1oDfxXi7dPbVqA09u+ClMCx2bxxF+jO9c2ne6BgRbVNAKQcHL0LRIWG/e
	 GwZDBWQD+M2oRDDaMPv5o4/l+3LjwoeZChhQfjXplAlY7qXcgbv2wwAVU2gjWdb0SA
	 Gx2cNSm7thIjNI0d/DyHTdMq6YUXHB97W4rxJgF2DsMqsq4AMYlho2eN9TepbWvTlM
	 9fqpB2QzPGArvO38VJzpLq8IfHOC4RPbII0RqWg02dm7K/BAVUhrbdQMJNQyXuvLUL
	 qAhLmwrSJzaPg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/6] selftests: mptcp: diag: trap cleanup after ns_init
Date: Fri, 24 May 2024 14:48:49 +0800
Message-ID: <f32ec0ed692ee29440c9507991e8f1903331d2b0.1716533107.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716533107.git.tanggeliang@kylinos.cn>
References: <cover.1716533107.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_lib_ns_init may fail sometimes, then ns isn't setup correctly. In
that case, cleanup is invoked, and ns is used in cleanup. So an "Invalid
netns name ''" error occurs. The patch moves "trap cleanup" from the front
of mptcp_lib_ns_init to the back of it to fix this.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 776d43a6922d..cabe6f8f489f 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -266,8 +266,8 @@ wait_connected()
 	done
 }
 
-trap cleanup EXIT
 mptcp_lib_ns_init ns
+trap cleanup EXIT
 
 echo "a" | \
 	timeout ${timeout_test} \
-- 
2.43.0

