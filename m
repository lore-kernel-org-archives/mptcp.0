Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A966FA9
	for <mptcp@lists.linux.dev>; Sun, 28 Jan 2024 06:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706422623; cv=none; b=QIoN0eRIFBebHtguAyr0bK+PcvGFnqlP7QwlThRx/XOMh5xobit2AgCrU0XTJ/yNleBrd+qvk9nuLrbWB576kO5AIxta7DCSVFKVM1GOvA2Gry+Z+Qe2a0ReGoJb4EptQGQE1GOKBnd/PpDq1iuWV1a5Vi0xn5AiHhR3r1mhJLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706422623; c=relaxed/simple;
	bh=IYwQgfEYenZYlUMo770sJmPpkXmlV5nnmabqrvbTs/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QiD7EEChRYd4R4yCXuPeASiLL7IIU0SMyz9oXMU0YnJyZLtTxWhyF+2DyVZ4wYOjWzugjuy+Rp2RJFve/EmL8j+XXQzhNF9DYs36gUL4K/ftYavUFQzR3t6CY6Qye1Pnnvzc7sV6GMITA322Tf8tVtNXvr/O9JGjEC4YRAgtE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvJpFMt9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvJpFMt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A019DC433C7;
	Sun, 28 Jan 2024 06:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706422622;
	bh=IYwQgfEYenZYlUMo770sJmPpkXmlV5nnmabqrvbTs/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvJpFMt9ViiXSRwYCcG1OdDmJ16fmZIH8PSs29znN1Xs8cVMMW4kO3g+9t7IRC6ET
	 455vUuk7TdsdlsScPesj4HpHMhNJViYl0r9RLaUiOk9IS+5lmCOmdIRrielqytr6ke
	 lyFW6iQRTgaPf/imtCBmcoYJyqvaYpx8jCcMNzHi8notdw4E1xPbcjnzVOalP2oei/
	 gdB+tffuz6kAryzQLZDVCgWd+/s+sSEOTrAjVrcTUhLB7HEdq1CZMxCq93WwSTrtSs
	 N1wSNDvIdWORJAMtgdZuTdF4SY6gf2i/06QdpvLwVd6z7mE4RiYWm+EO8C/GOlLkbC
	 0mbJZ67yK/SRQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH virtme-docker 2/3] upgrade to ubuntu 23.10
Date: Sun, 28 Jan 2024 14:16:02 +0800
Message-Id: <dc2e14b63fd7ec288e015124919c28c9470d5913.1706422466.git.geliang@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706422466.git.geliang@kernel.org>
References: <cover.1706422466.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There will be many build errors when comliling bpf selftests under
Ubuntu 22.04. Upgrade to 23.10 to use the new versions of gcc, clang
and LLVM.

Fix sparse build errors for llvm-16. This part alse be sent to sparse
upstream. It can be dropped from this patch when accepted.

Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 Dockerfile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Dockerfile b/Dockerfile
index cf8c692..cbc11f7 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -1,4 +1,4 @@
-FROM ubuntu:22.04
+FROM ubuntu:23.10
 
 LABEL name=mptcp-upstream-virtme-docker
 
@@ -71,6 +71,10 @@ ARG SPARSE_GIT_SHA="ce1a6720f69e6233ec9abd4e9aae5945e05fda41" # include a fix fo
 RUN cd /opt && \
 	git clone "${SPARSE_GIT_URL}" sparse && \
 	cd "sparse" && \
+		sed -i 's/LLVMConstGEP(/LLVMConstGEP2(type, /g' sparse-llvm.c && \
+		sed -i 's/LLVMBuildInBoundsGEP(builder/LLVMBuildInBoundsGEP2(builder, type/g' sparse-llvm.c && \
+		sed -i 's/LLVMBuildLoad(fn->builder/LLVMBuildLoad2(fn->builder, insn_symbol_type(insn)/g' sparse-llvm.c && \
+		sed -i 's/LLVMBuildCall(fn->builder/LLVMBuildCall2(fn->builder, insn_symbol_type(insn)/g' sparse-llvm.c && \
 		make -j"$(nproc)" -l"$(nproc)" && \
 		make PREFIX=/usr install && \
 		cd .. && \
-- 
2.40.1

