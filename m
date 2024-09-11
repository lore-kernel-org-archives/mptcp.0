Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC592A1B8
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023793; cv=none; b=FjMKOFQ6JCVEQ5EonLHcv/pM4q9M7P+QrYAKraLFkTbTLdPyei9hf2llhu3HBAiY8po1pSiQZssla8XzZttH5BrUP35pALpOhnLAg/KPqQ2q3mFxLtHFoCgWCb70xF5a2/KvUbFjVnsI3Z+kmr+TnxBc9X+2OsfPFMTCZX3QFjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023793; c=relaxed/simple;
	bh=tmUhyMbuivaejbJwrRN0H8HLOXpXYI1ZrAXOA8fWcYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4DbGHVS6/OU9eXOqP1cG8IuXsRMqTtM9GpAbuG2v65XTYcLiTjo0QyxUUyevWgVEkfj4r04kR07dUarTcIE9BpFYgzRqLPjukyFhkq5hxK5wzRdcQffkm7FTaM6y8sbknPBEE/V7iyQosocPNjJ2QY9l8FvbKXAcxKq841pDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zxu0PvFo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zxu0PvFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33C5C4CEC3;
	Wed, 11 Sep 2024 03:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726023792;
	bh=tmUhyMbuivaejbJwrRN0H8HLOXpXYI1ZrAXOA8fWcYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zxu0PvFoL7fUjZ1W2nU4Ofyx76Oh85fqgOGqbkCqDMP2z11A1D3oTtFrLOK7xvxOn
	 WlqyO5/ylHimslADvTj+BZZ47q2gP49Pezr8DnqPmYHWTFezUDnBWAyUoF4pXSrubn
	 KC/AxTIOXWvtblHAtmdkUNUK1okQc1KxFY+YB5WQwsU8inS27+xGUk1S6YFBv9tV2h
	 aRkPngS6a0/l996amPT6EISzgLtotBivta+63PSF8bKKsk67ZUexspHlmjeoLmAyzL
	 ezXpBuCqRGKajKRu294U3DqUPWsDYeoQ98fl04lk+eyCTdm1Op1DaxDv+h5giZaCBz
	 0PX8a7sQ7kUhA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/5] Squash to "mptcp: add sched_data helpers"
Date: Wed, 11 Sep 2024 11:02:58 +0800
Message-ID: <eeacb1f4f277e746252849f8fc836ce0cffd2406.1726023577.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726023577.git.tanggeliang@kylinos.cn>
References: <cover.1726023577.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop bpf_mptcp_subflow_ctx_by_pos declaration, since
"-Wmissing-declarations" is ignored in __bpf_kfunc_start_defs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6e7d88ca7d42..aa0969d4440b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -722,8 +722,6 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
 bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.43.0

