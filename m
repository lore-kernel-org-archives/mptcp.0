Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650EE1DAC9B
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729162557; cv=none; b=fydUotvwl70Sxm3SXESjNM2wusPeyutCi9djtV6raFuLVLNlbMDEkx6M+xeUbYceryHcZ4ZmC8iFZ4mrIfmJl1ss2kZ4BUD6rvYGZpS/QMoIi2IrlJl1QTCCyEm0ujCk9XoCrwgXrrwF8no2T3OFw8Dcb4vXaFLQINelxG6L3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729162557; c=relaxed/simple;
	bh=SBYyz3UfP8B09or0JY+xbymOV/Qj9iiPUqV3IalP6FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOcmQ+M69oSug1ZSQNEYnkOaOGe3MP/S2m/qSO2vtNx4EWFSwOfoPjbTOk0HuXGOxCCLhv6crvc2XNz8nD/cX7vuZj9NGjcgQEH4BuE8SHZxUvxNYhxDiSQWeOio1CDVn4ZzxoSiydfGR3+bcdpS5URzFNeH5gkGO0MlUac6AoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVGew4Ze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVGew4Ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9B2C4CEC3;
	Thu, 17 Oct 2024 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729162557;
	bh=SBYyz3UfP8B09or0JY+xbymOV/Qj9iiPUqV3IalP6FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVGew4ZetdcyjllArZvSBueWJnPbkjUfVA19kpglxiVXYRBRC3CNQBVRlhqxM8mFJ
	 RPtSSc9ANeewd6x5YzXvrsGaJ4C3aHS0IjTyRRe8nhIP5nl2v1LFCwaMLrLr7ne39h
	 9lZx3auQ34/Z7EreWqtuHN5X5f94jlQBzvGMCDk16IBTpp9QwndxEqVW4UkkCTVZ1j
	 ffJY700JdJOeOFWk0kSwfEv4uvOFKn7Xj7mGL6r0BdGhsMwRebFXSyguGeuTbFh7WD
	 GrVTE8nhXS8Qm+KkmG30r/BcplcW80gxRQ4pgtDyF/MQKJq8vaUGTsCYhkQuecdt9H
	 uG5zjLN5ckZ1g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/3] Squash to "selftests/bpf: Add mptcp_subflow bpf_iter test prog"
Date: Thu, 17 Oct 2024 18:55:31 +0800
Message-ID: <01292808c07fdaa9925d3be09a4ed1d8b82887f4.1729162349.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729162349.git.tanggeliang@kylinos.cn>
References: <cover.1729162349.git.tanggeliang@kylinos.cn>
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

