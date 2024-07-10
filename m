Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F33192B8E
	for <mptcp@lists.linux.dev>; Wed, 10 Jul 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619179; cv=none; b=nZ4OwVGrbeXuMMv0bmBTiKEWuO7mZemAE3bGd86870U+xirlSrsPyv1XH+QwR8KLJPR5orKEGrAyUZGz4nLImP9gqi8boRDfo2o2524FbL6a9sHGLpS+3wBL+qNpaAUWWHn7BpXyEFQ44v8uHNUK8RafWUPxBmZM3NosQQTq+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619179; c=relaxed/simple;
	bh=O3tR9tbSIsQyfCbf2JpOJstEX6qV40s1stH3vP0N7KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOyIgCBgON2RTrqSdVHpiO9u8MmC1gf0My2GbKYBzCiweor+U/WbR9J96HKjnjSP/4RiXe/O3QZKGiqNWyWJWXdaa4Xwl2scNd5ZBx34a3y7LWKgMCRZxqVWa6GXMWF8pE2EkzQdSC6hFeVv9GxQ25pG22a7J4eJsb+NHKcp/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOqpAJQ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOqpAJQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6402C32782;
	Wed, 10 Jul 2024 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720619178;
	bh=O3tR9tbSIsQyfCbf2JpOJstEX6qV40s1stH3vP0N7KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOqpAJQ2cl2fIJZzYQfPbJ2Etr1FqqXYbo4VpVUkhYAV6mhEw+W3KGml0rKMjxe3h
	 GVkFgZjBFZgBAxuY2R+wYnyi5r4QaLiecb4bLC65DuWSw8joMEQ1c3X8DjnZFnMKCq
	 IPboPGHOEb9qOh4aBzL//qyZSW5DTN+zTDa5BayF35mxhjf+gGuQPmvi49ZYWCoAr/
	 vzus+69Czfadg0uc5tEt/NyQ0d8XPmEd7nu3EVrMfpOLapoxrtkofrGouRcaS6Pkbo
	 LRALANet7I7OveSoWnbabWgzcXxr4twnxFZ5Zh1Wqf7vqO/DKXsgGcxGG8HtXEH3nn
	 g50F4wEluyD+Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/3] Squash to "bpf: Export more bpf_burst related functions"
Date: Wed, 10 Jul 2024 21:46:10 +0800
Message-ID: <fdeb3a16c77e43551a3d534191963b839899f457.1720618186.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720618186.git.tanggeliang@kylinos.cn>
References: <cover.1720618186.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Allow mptcp_snd_nxt() helper to be accessed in BPF.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 9672a70c24b0..9c72f080e7ee 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -229,6 +229,7 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
+BTF_ID_FLAGS(func, mptcp_snd_nxt)
 BTF_ID_FLAGS(func, tcp_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
-- 
2.43.0

