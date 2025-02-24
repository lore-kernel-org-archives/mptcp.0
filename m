Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1BF510
	for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 03:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368273; cv=none; b=s7OxmDBBOVn5Mm9kxEx84HG5HsA/oCbbCdyUtsoTr7uwEgh8865gVBxqhqyqrmQAKDuaOO0XbP+MSrAImEniGcDZUUJ/qdJBeMhsd4k4blIEq8gAprDPxScSctly6PZMKEz8DOF6S2RSSk37XMgf8P2Cp0im35hrnp2QNXq4EWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368273; c=relaxed/simple;
	bh=Y/nSLpzRC0NZxGyn2KF0Yxwg1I5WdIB6hNFwT4Y3kEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hudNGvMsD2xkEOKHvozZgFs4tdu1Naq2SSo0FYdVGNd/yoBxbOZMJJPWRiANp9ITpj96qL8IqZ6xGyP2gUBCEkTG2oBVtBxE+MbZcoGMYrUivIBNLJQy83lu1rsRwt6AyKOEW9KHF6ZJAMzy+ommrOMiOLdGg38nH29+XV1QRZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM+2pHmh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM+2pHmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D7CC4CEDD;
	Mon, 24 Feb 2025 03:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740368272;
	bh=Y/nSLpzRC0NZxGyn2KF0Yxwg1I5WdIB6hNFwT4Y3kEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZM+2pHmhUU14giRuJyduZwEBxPH4TFCc3EtGL5ARDGsDx7vDWVORuBDaYLD37QkFL
	 3ZqWy4SPL8+5JTDGAfHEf/KRbM9tC1YX39e+SFL4ILtzyR/K63hs2JmaLgxVtS+HDf
	 prtt6w+KTEwF0uN//HBNery3wDpqt7tOmHYxGc8IITY3OZCz6M6523ZVMHewVfwQUm
	 9JO3YvTaRPJv6UK6NsyqcPrBob/Lyync5ov2V4W7IryrupfSy84dhB64GvVuOVXSMt
	 a34LjqJR4h+mzax7aahFmaimrR40JzZ7rdzSM44Nx94oKSZYxc1KDHPTzFO0ZIzoEM
	 DhNiAd9P+dYUg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/5] Revert "bpf: Allow use of skc_to_mptcp_sock in cg_sockopt"
Date: Mon, 24 Feb 2025 11:37:37 +0800
Message-ID: <e129edf39b1d209d37560a4bec1eaeb479ef6110.1740368110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740368110.git.tanggeliang@kylinos.cn>
References: <cover.1740368110.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

bpf_core_cast() can be used in mptcp_subflow bpf_iter selftests to get the
msk, instead of using bpf_skc_to_mptcp_sock(). No need to add this patch
anymore, revert it.

This reverts commit d8d42f5a4542c2dc31e4e00c58508a821c6ab789.
---
 kernel/bpf/cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 1ca22e4842cf..46e5db65dbc8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2358,8 +2358,6 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #ifdef CONFIG_INET
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
-	case BPF_FUNC_skc_to_mptcp_sock:
-		return &bpf_skc_to_mptcp_sock_proto;
 #endif
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
-- 
2.43.0

