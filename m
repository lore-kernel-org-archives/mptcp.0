Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70F210193
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049920; cv=none; b=lIky9AvVBQMZ8Lzejs4VvBVuC2H/Xo7Cnc5DvzkFT3ZJX4Hw4PJhRGm5cfAXL+/gKhuf9BeOfwb/w24H/NAN6ucOGhriwPsOdIRCUrKKSodAVpCmP1qL0eyCfLGqVoWB6QrrGvOl7iDsA0XCRBoddDJAvEo8X1RQ1bxCir2SdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049920; c=relaxed/simple;
	bh=LPctx5z6w8mJzqOD74D8QCf8Xsgi24IJXFIKS+pDdGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRkK7MN/B7R3cVu9MjTuQSJoEjog77m/y5WsJ+zLWdfu+/4HRvQi01fwjK0J3GuO4RvXRgaDQa07Wy+2+ZSTIp+Z0etSybYCcTVEEPg0w0fP46/xLmkRTL/3MQy2aOw5jOXg1KdeMVl4zF961y5RvfX29r6FJLQn4oh2bOtQFZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5u/muD4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5u/muD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547D2C4CEC6;
	Fri,  4 Oct 2024 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728049919;
	bh=LPctx5z6w8mJzqOD74D8QCf8Xsgi24IJXFIKS+pDdGA=;
	h=From:To:Cc:Subject:Date:From;
	b=j5u/muD42I/rLTb2EpNUABGkgGhxLbK74URr0gRQzvs1aOl3dYOH7FNZcFVM7XfP8
	 xqBSCjl4ovWdgMdsCTtTPnPM8vE6cSni74pgwLhW5KgaQYbxJKp2D4AuCLBr0CFgUt
	 /3S7uis4iC8puelQHqiEkT+oZJtm6plIooOeeKUlFezKAP7v07qJxhoaKPbDiYhOPX
	 zg+ngAVKJbF4DqRBG2AZB/j5zfUkgsaSdLIR2MB3/O845R2L0YGjpjtux/twyG2tsw
	 VVfaX2uqMspuiklq7yTQKg5fA79Qc6wHKXf7PbXj+y6P786PLu9AV8wBSGY4jJzOTt
	 IRHvDfCncSfew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf_first scheduler & test" 2
Date: Fri,  4 Oct 2024 21:51:54 +0800
Message-ID: <f14fd685b8d11461d6cf60f69361a7e7d643a034.1728049901.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop duplicate bpf_mptcp_subflow_ctx declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index 9ca152a99dbf..f26394d66417 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -56,7 +56,4 @@ bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
 extern struct sock *
 bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
 
-extern struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
-
 #endif
-- 
2.43.0

