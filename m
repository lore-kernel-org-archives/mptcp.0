Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB680C13
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169018; cv=none; b=OYojwXRZ9m1tP2XpvGpCJTtjmnwkrU4CBiNOb/kh1OQ96v7e1sAlOUrCOyjdJCDeTZUULwE0dbU60anjQs/LcE/sBcYEq6Z1cywN5FsGZivBiS4bHdB0KUPebOwFsO57sHRXIXxv7hEN+iWUYcixG9IUR54WV29HmAiHo0ADAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169018; c=relaxed/simple;
	bh=NMOtzIOCOETa0fpcP9kKo8rqzMY7RmWa6x2jUA8URDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8tFM3nZQyVJDxgUZB240SE2FwJV2gfnpcshz13gVm7zhwnkoBtS7wXUEirHDP0/xKivxkc4ulibFHcgkfEPovO6AtRzWlTyuMM6g8BoTq92QjysrRawIi1vV0Ir5Grq+fo8DaCvqPvI451xVXGHG4ejqw3f5JaLueJLy1S54e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W829K0Lx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W829K0Lx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC91C4CEC6;
	Tue, 24 Sep 2024 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169018;
	bh=NMOtzIOCOETa0fpcP9kKo8rqzMY7RmWa6x2jUA8URDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W829K0Lx+15VOBxIRg/0p5KHOrFmQ9DINx4m26QNrofjUKW4GqkhIDzqKXb3JI1S1
	 BPqT9YZGFf001sHXtpSaUpT03DkCBGE1YDDzJabCwyDwOAn6i1TaVjs1G9w0dJhJxh
	 oh6MAW8OLXe3VS81fgpW597sK8Yl0IrG9GgXDVVdcK/me4Vvtx/YvbDhB0iSCwFwg+
	 nCuaRvGB/awSvV89Uj0fjuHbmvbuTO338k/hi304tnNPn+WVByEip0HmxeSoZ/KtNS
	 MfsRW+agUupVZ+yWmrQWYZo3XhECW/obiHqEfHh8nQKDGA6OcWCj8tu28Q2Bb0TfyF
	 6hZQFT+cuJA0g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 09/10] Squash to "bpf: Export more bpf_burst related functions"
Date: Tue, 24 Sep 2024 17:09:53 +0800
Message-ID: <6caa3d6601ac95ef80b943016c783ffd56e3c2e9.1727168628.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727168628.git.tanggeliang@kylinos.cn>
References: <cover.1727168628.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop bpf_mptcp_subflow_queues_empty declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d864c8ccf316..9df56c21756d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -721,7 +721,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.43.0

