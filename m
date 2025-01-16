Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8296419E7ED
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012430; cv=none; b=afyRwKAImJhnWmftX/+c0Ti+qOvb63uuEUmQv0j77YiKIOqdPbT71cWW0Cq79SbpNJMMhGllHlV7rfWNQR9gR3956V/2sS9akMjMNcZM9kFAuCqOUtqWyliRKIyV3NdSsOE1LrEmPaPonjk4sENldkJ8omtFHkTHq/28hVLueGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012430; c=relaxed/simple;
	bh=7eBYfjdZA97+FDSGdS1BGUpeREwkRg9R24kg+Cb0R1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6Hw5DTfvX2d09GVxym0cOHhfcClv7Hvndjx3llN8LxU66joconl436tdhIRJAgkDWR2WYJpHxVDuXDBI8xaNUqVqshd2ArdiLREblxkZohBfjktSGkIXPHX9zfcIXCx8LJNN//Egrl53C4hZSTd5b0fOc8Gm/YITsDgNPSSiEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV3d8LlP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV3d8LlP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE05C4CEDF;
	Thu, 16 Jan 2025 07:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737012430;
	bh=7eBYfjdZA97+FDSGdS1BGUpeREwkRg9R24kg+Cb0R1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iV3d8LlPukOcCWC8RNd2wIf9EkybPXt/7VUesxx1qtA8OprdwiLYPTP3vU8cJk954
	 lWu3J0ZjqENJbZ2EOpMFaNYDzsWHm4uOE9BL2JlQfWGR24N1xKRNEwhzNE7y1rZ/zZ
	 v+yHxTd3GPUsySzNMgSeoKNgPh6BPqhIEiXek3do/vqS8iqeXjoRlz4zNvL16bYO74
	 ixz2f2kMdmtRkaYD/7QvGk6ehjXAkt++OsnDX4PayFWsbJ7bbbWmo8TZfHWBp+6DXk
	 yyaI8i0NXzI/OHbvXtc3yUaxCljmlh2cgih6ANAnCbfSCwKb8H5K6u5CcSdSDRTrA4
	 dzF4CS/19KEzA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/7] mptcp: add a build check for userspace_pm_dump_addr
Date: Thu, 16 Jan 2025 15:26:54 +0800
Message-ID: <477b35468fde94e852135a0c701a8631339d60b4.1737012165.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737012165.git.tanggeliang@kylinos.cn>
References: <cover.1737012165.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a build check for mptcp_userspace_pm_dump_addr() to make
sure there is enough space in 'cb->ctx' to store an address id bitmap.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b50462b527bd..540b2080f02b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -642,6 +642,8 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	int ret = -EINVAL;
 	struct sock *sk;
 
+	BUILD_BUG_ON(sizeof(struct id_bitmap) > sizeof(cb->ctx));
+
 	bitmap = (struct id_bitmap *)cb->ctx;
 
 	msk = mptcp_userspace_pm_get_sock(info);
-- 
2.43.0

