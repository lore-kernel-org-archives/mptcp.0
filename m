Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D779FD
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160571; cv=none; b=cUiB7WECpBa/2nPvpnm/21S58q4aRIDW+s5kpo6HQJZMzWnZqp0Piiw840aw1obRbV1sTwq49BOAbN1hXydbn1Ob9GQaJaAM5aBHO+nES2UlaL5+BeQXKfX9zePC08itqfTinR7S6e5AzofksLWnIhHUexgAgvuJdgnTMyBFBpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160571; c=relaxed/simple;
	bh=SBYyz3UfP8B09or0JY+xbymOV/Qj9iiPUqV3IalP6FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qw8zj+HouSproZecLC2Lu9WQxQKyiqUboehLRrjRshAcFil9uWzxMBc78DuZX2B5wLMkQazfAhPdQPMVYBhJxyfRcBxrfhouePwRbQ9gyJcJiOqbXXQCR6ofhkpqi8ERh5nOY2fHJjI+x6+5bLaZSTxsap9osxS3BD3vSE6ATMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyJij44M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyJij44M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E431FC4CEC7;
	Thu, 17 Oct 2024 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729160571;
	bh=SBYyz3UfP8B09or0JY+xbymOV/Qj9iiPUqV3IalP6FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyJij44MEFpDaFFblhYaBOQHd46T0hvdmJZDKZerW1idgH+mOuK/7lzEX9Pv91wVO
	 /dJavqn07W4Jz1Z4n99NawH9dz7y5SvcAOYe3/Eo898bRjeUfAOxAx6JZdU8J+UF9n
	 dyG7oCyJ8TEtTEesi9L0WtKz7PqXW9cjM4hO65WguIv8a0Pkkm6zelvy7uRlG5JdvI
	 V8kulHgVqrhPe5m28EKOKmB/QnChCDHMJYlLPFBrwC1i+S1m6pftgaFQaYGOEHtmuR
	 vzI62ent7dJROV8DGasNOKG/220lPDQuWPCBO+KB/ym7QNUHUXXMtDP0zClCIzpPj+
	 Sk9VSZldjTrbA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter test prog"
Date: Thu, 17 Oct 2024 18:21:42 +0800
Message-ID: <01292808c07fdaa9925d3be09a4ed1d8b82887f4.1729159086.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729159086.git.tanggeliang@kylinos.cn>
References: <cover.1729159086.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Export bpf_mptcp_sk(), it is used in this test program.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
index b1f6e1fb467e..3b20cfd44505 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
@@ -46,6 +46,7 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
 extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
 extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
 
+extern struct mptcp_sock *bpf_mptcp_sk(struct sock *sk) __ksym;
 extern struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
 extern struct sock *
-- 
2.43.0

