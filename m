Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6D630AAD8
	for <mptcp@lists.linux.dev>; Fri, 17 Apr 2026 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776469719; cv=none; b=sKquom4RidKZX8alsAXAWEXvZDC2ag8bqwLJKaL/GVnrocSz+7lj7nB5E5+zZm1QVyyUQ70x0O2nuqBEgivkCxOIeTYTDMM7eMGZLKJV6jJaw17CTnEEYcqjNs7qXU+LzipVTGyKEbc5Dsv+4YN1YZLCp9Tx7coBTEAy/k/ys7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776469719; c=relaxed/simple;
	bh=cMjw6s3JZb9vyookluIQsS8ImPnHPQDtUSKqI4Dat8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGbKoEFuWHqUpjekIRCdd9Md6mvTZFvUTvzjQpW3FEag8ssGMFYtvDF6JE+I1+K+sHCjKUwJILB9vJrojDjXFqEKlifPkEoS0GNfEaFeOSOqBj5BjnDHtS72uyJEXlfmYANyxUs/IXUnph72DFG0+EjRTx5prV0iWABFxN8BJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1C9b1z0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1C9b1z0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D5AC19425;
	Fri, 17 Apr 2026 23:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776469718;
	bh=cMjw6s3JZb9vyookluIQsS8ImPnHPQDtUSKqI4Dat8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1C9b1z0D22KIzJby46xf3qtoPlkJWrvmHKnldmuuQwGks1Qd1thvh89aeGs96bLb
	 /jpSJXMWtcvXjeSVo8QXtzROFgJEH0Rg8358ISE6utZdit6UeqFJkiyEfaMX5nn8En
	 mqSjTu55iKqM+MJLvTwMy8HOG6yPpsuLAUQfhM2lmavHHdDb4NJ3k9FREDiGFNzk0N
	 N7m4gMpleCGg3RCRodDctrLaL8gXE9JGJMm0OlUvxFPlBaSYDN/+9gzECiJks4srPb
	 W4+mGi/cvBS5eii7nmzvQZMt6hmHy2WK16bRhwVGDL2yJLrzQK+55UY8VK5XejvxQu
	 JlvPZeE4H4Jdw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v15 12/15] selftests: tls: increase nonblocking data size for mptcp
Date: Sat, 18 Apr 2026 07:47:51 +0800
Message-ID: <eb7bc7d40bb464a32e30d58f58d9943032aa7c00.1776469069.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776469068.git.tanggeliang@kylinos.cn>
References: <cover.1776469068.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Increase the data size in nonblocking tests to accommodate MPTCP's
multi-subflow behavior and ensure sufficient data for testing,
avoiding the following errors:

 #  RUN           tls.12_aria_gcm_mptcp.nonblocking ...
 # tls.c:1534:nonblocking:Expected 0 (0) != eagain (0)
 # nonblocking: Test failed

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 048bb4d3e0d8..8bd5def6f3ec 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1426,6 +1426,9 @@ TEST_F(tls, nonblocking)
 	int flags;
 	int res;
 
+	if (variant->mptcp)
+		data *= 4;
+
 	flags = fcntl(self->fd, F_GETFL, 0);
 	fcntl(self->fd, F_SETFL, flags | O_NONBLOCK);
 	fcntl(self->cfd, F_SETFL, flags | O_NONBLOCK);
-- 
2.51.0

