Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E6017C9B9
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958435; cv=none; b=VUG+aIqgR6OloIMW1CRZdL2eRnrBsBE3bUTKmZx3ViDtX3QgR1m3wU2kDQ98ZufiCvmDqsT4emeE8hALUxpcpoPMV8kXz12SUpBNaXfWJh3PfC27UzXszG1ZS9qPW2YhC1aTu1KU/ZUG+fJDooiShFwsEUlY1pceNs7ztqH3HpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958435; c=relaxed/simple;
	bh=Xl+1w7CeIWABh8EqNhLJUUNRZ16V8EHB998xfiZb1n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJlvWFNzCAZcE9RWmHQagksCeDuCATkooNT4TRPQGHV5M1TWSP/hqFCzJbD/XqYML+W0sZL6ZidP82OrDUbmwbJQPRDTC4rgq8aTN4wuBIBKBjehgf+3YS72XNAxH3gxJwDGcgAdGceyON2JyhILG9AmvwP85Ozr2ctLe38QwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4O9Kn9H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4O9Kn9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CB2C4CEC3;
	Tue, 10 Sep 2024 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725958434;
	bh=Xl+1w7CeIWABh8EqNhLJUUNRZ16V8EHB998xfiZb1n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4O9Kn9H99svU6XhWnO7O/9fQ4FnyVSEy8wekPHTy62IV1NVz9PirNt0H6gFKIBkL
	 pkMLwILsyo5mp3rNPx2t9OtaiVxqrHknSjgAtaOC7wiay/Oiv/JMRJfZDTZDmhZsgT
	 N///JvvB9+QcJdllLUGZnFIvpnp9s/wnHhrqtTzl4YvrqUfrN7hueA0aWDkYXWiQhI
	 DrDzTCNCH/kWMqIBffl2QqI6Q47ik5ORIO3b9HTCTrXnvQjg3AMmIOtFra01lhTQsy
	 q5kfBVRZBLMpu8NcaJocj7b+99hWH9aKPIZITDUD45rKLDXWJVqOeHM/t/UYAESMr0
	 wmBrIbL2tXBnA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "bpf: Register mptcp tracing kfunc set"
Date: Tue, 10 Sep 2024 16:53:42 +0800
Message-ID: <59a223662c4443a61d5c9027729f88d0ee98db80.1725958296.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725958296.git.tanggeliang@kylinos.cn>
References: <cover.1725958296.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

'''
Since the kfuncs mptcp_subflow_active() and mptcp_subflow_set_scheduled()
are invoked in the mptcp_subflow bpf_iter test in a ftrace hook for
mptcp_sched_get_send(), it's necessary to register them into a
BPF_PROG_TYPE_TRACING type kfunc set to allow them to be invoked in the
hook.
'''

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0b7a0c2634c4..31a3c9c1d681 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -260,9 +260,6 @@ __bpf_kfunc bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
-BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_new)
-BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_next)
-BTF_ID_FLAGS(func, bpf_iter_mptcp_subflow_destroy)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx_by_pos)
-- 
2.43.0

