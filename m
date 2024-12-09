Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D014AD0E
	for <mptcp@lists.linux.dev>; Mon,  9 Dec 2024 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724760; cv=none; b=Js1md5/fiTKwvrG6lg4QkcavfqgKMmurDhaCu/yCSfWlfeGjOT4tWSjPTlVz7bHYAx8TMPIVO+UQcFfwYav0CWMv/+4LadxkF9ymlkNAfG49KoeI74E61q/2AX/74oaiL2GRlRDOAIzzNCtun9MXGc1VwUhIa++jczHL711sDaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724760; c=relaxed/simple;
	bh=PDPl9RB/6dCKKUJchPq9UX9loOsc2k2o0XbbZp0CIYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCAHpS9K7kSlJpjbvuxXMeex4qnfem4HWW8F8xLpxsBqoCP9znpdTqLWKCfCNwTJ4Xr3UybpXSFNeJiCANrGlhqU68XkXgV/8iom3JlcGParuNGwNsXLQFgHipo4aI5y9/iIV9tN03cYU4+XyzcuqovC1y6miDiTV6kYvk1woV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO2YMdv1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO2YMdv1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AD0C4CED1;
	Mon,  9 Dec 2024 06:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733724760;
	bh=PDPl9RB/6dCKKUJchPq9UX9loOsc2k2o0XbbZp0CIYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YO2YMdv1qvDyHHuXgqRnenuIjg3VezQiwIrMx7KxfVCxWTFMV6ETim8PMqSfvMXtM
	 W0+XHXzcRpKV2mp9KQHeIgmzNusUT2hsuX0Cw/Gbx/zG+ZZr/CyHoSMPb8g5KOMOjF
	 +ajVbyy0EzrOMYug9x3MlgUaXe+Ievyec8QunpQxFRoOjOZ4aGeORkOnEKJkbY3hFk
	 BYuLT3jmf/XagGw6E3gr5PhqKLYrSf2pMklMkfm/enGgK4uwash0qIOsjA5VGq0tM/
	 8+k0YgAqB22nE01zj/D676GokAXY0FekaJwLNqJdGSIhR0OuVVN0+2T0ePMnFpABvn
	 rubOGX6RTkOsg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/5] bpf: Allow use of skc_to_mptcp_sock in cg_sockopt
Date: Mon,  9 Dec 2024 14:12:27 +0800
Message-ID: <6ccf3f9179e820ac477702bae8a88bdb8f0cc93a.1733724383.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733724383.git.tanggeliang@kylinos.cn>
References: <cover.1733724383.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Currently, bpf_skc_to_mptcp_sock() helper is not allowed to be used
in cg_sockopt. This patch adds this permission.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 kernel/bpf/cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 46e5db65dbc8..1ca22e4842cf 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2358,6 +2358,8 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 #ifdef CONFIG_INET
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
+	case BPF_FUNC_skc_to_mptcp_sock:
+		return &bpf_skc_to_mptcp_sock_proto;
 #endif
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
-- 
2.45.2

