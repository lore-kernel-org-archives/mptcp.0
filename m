Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9630FC1A
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699370; cv=none; b=qArqYJtVzLxkxqS3HRo/bp+0sJZ2uOtzyTSSimDkGFZzcKjA4bIwlbRXOzzu6wSv84Rura+rsWMb1v1iMIizuXswlBw0m8jZiWm8XHXqSfJrYEqiFsZBEwL2eZm1AqOUaiYUglqJVpYpT96NTsSGdgMlPSY+orHbsy3Ka6f4NFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699370; c=relaxed/simple;
	bh=kym+qBjlodY0u2hYBsCmui9bf1mdepv4ZExhGaElc8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4X5yz8zc/SjIHtHVCLLiGY9yVIQTW3Ml8Opn6YsjqWRfH0kmkEOxqagM2uquWo418BNek1pIcdjQxkcxaNlkluLdtWTdMBHEwM/qEi3V5Lrh+5zDrdB/jxOUiCjI634IvS6bEC45hVM1SCqp8i7survSURhgLIuS2d4AGdAEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/6y/L7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/6y/L7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451E91F000E9;
	Wed, 17 Jun 2026 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781699367;
	bh=OfgDFaSVw2FuwahDh3l1T41V1fY36q/RCFV8aV14sAk=;
	h=From:To:Cc:Subject:Date;
	b=N/6y/L7Om+dDMVsx+pR5teWO1iqBYU8I4rfXHaOeY7SOamhW9b8rkWX64nr27R90Z
	 tCZ5IhngcKbz6pPBfycPAR8klyr0/oS18qLhvGL/fz0wJLLRXkkyaOj3qLlk1K2UHd
	 6SQ/gYgeaI0RCNLOQp+VqqhoMokS3F744FXJxZvAg/CfnPMi+aSgsOyTxse996Rsk7
	 3/w0v9aLIBw6iSJ6Vj1qF0PnOMbjceUrxUoBIvzGaUtk9v14zs7/7npe4FDKpWPRkN
	 xuLhBY9AN7dTKA+dWwEBDAKxavzSB+1yoDLZ1fm84UzqJxHS4iBTCog3kFmTxNvwUJ
	 7zd8icOVtJ9Aw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Wed, 17 Jun 2026 20:29:21 +0800
Message-ID: <10a30ed6484cc4d48009625f1ed8e12802e78e94.1781699193.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

bpf_sk_stream_memory_free() returns bool but erroneously returned NULL.
Change to false and drop the KF_RET_NULL flag.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 08bb037f0951..259a2ca4fb0b 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -297,7 +297,7 @@ __bpf_kfunc static bool bpf_sk_stream_memory_free(const struct sock *sk__ign)
 	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
 		return sk_stream_memory_free(sk);
 
-	return NULL;
+	return false;
 }
 
 __bpf_kfunc_end_defs();
@@ -320,7 +320,7 @@ BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
-BTF_ID_FLAGS(func, bpf_sk_stream_memory_free, KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
-- 
2.53.0

