Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC9745E4
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 05:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725946658; cv=none; b=rqgv3zwBHuVYPmI5p5xujxEZLf+rkMbW53OS9qbuAyakbZ1UpPjKLLl1luroYjfo/UGjzvu32a411r0eMfIwDGA8+Zs7hDQr9EqA3xPqCXlWh7l4Fq1qli9Xw+Iqt0UTdbBm73EmwcKvBbSgPrMyVetf3+5k2Ezjk05e9UjNvA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725946658; c=relaxed/simple;
	bh=tmUhyMbuivaejbJwrRN0H8HLOXpXYI1ZrAXOA8fWcYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fov2oISn2QQ1n1KYUfsCbqBi5EGPHrsNvPWfFAMqe+UKeIc9zgspwUsVN2x4gEvAfhvfVbM1oeuEcG7iWuOQeQ2fnsa/3iozyokYnT8OMY/5wTQHYNfpJNyhmDqYQDK21zySnzCJwC5Yh4oBcllMVfaqVBCnAdD/lWnF3+xBncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfnZZfBS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfnZZfBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7556BC4CEC4;
	Tue, 10 Sep 2024 05:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725946658;
	bh=tmUhyMbuivaejbJwrRN0H8HLOXpXYI1ZrAXOA8fWcYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GfnZZfBSRT3p4AfOUZkfQSFpo236l4tHKElJNJJo/VcG3EWtJ70+aXCsmnz8ie7iu
	 N3gziGhU8ZHTmeA2AJRnjecsUHP1/a6OcsBEH6r7TIGHrxJimQBUrZPaVq0ydPNGFf
	 Q8DszEmzcEDVdhwNmuhs9nCaPjqjU8OknPyKeK0tdbBf04aT7TLBLnSFCTfYnxuFUO
	 u682OT3KvNh/4j9D/wUjNi5b2oP2g4CPlycDM07UCxRCk/9tkTcAcAhMhLxa3Caupr
	 KLGSIh732GZMeNVsrqgM9u0WP82Wpq/ZO3bGaLSh2ogmoOnVl66y3q0gzX1q8LTy/8
	 SjkcEy2Sut5jA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/5] Squash to "mptcp: add sched_data helpers"
Date: Tue, 10 Sep 2024 13:37:24 +0800
Message-ID: <4f91d977cc858cddcc9620a0b4ff3eb01c66c2a0.1725946276.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725946276.git.tanggeliang@kylinos.cn>
References: <cover.1725946276.git.tanggeliang@kylinos.cn>
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

