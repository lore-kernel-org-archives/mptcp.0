Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C639EF19
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121161; cv=none; b=DC6owevhXAbheMCJZLDsZviTeGZMFpMn/PcHawaCJLxKWrD5bmbYomzgx2tPCBfHGJhNwRpi/HltYRYTC3Ej4ykKSJYPyIOXr7LBVmCe6c2gJmUCX4EbVvcupnCyd3GWGcOvNpvzSCaBp7AESsbHIm/5r80wRQfzsm+w2r5QNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121161; c=relaxed/simple;
	bh=qB+X0nIYJuppH3GnnVQVDO1NDPHKh4aCdlZo6MWapjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZESWaCM301IuewRmkdPsTjvKClzHOat9jsFaAs7IrKkoGgpdIUIbKCTU/iklyAynNHeYax9Jmb3hqf/0w9awGcMCIEEPkDKYI1hHbmPEstcPiIIHgzi+K/QeGZ2NCwmnAOzY2nq7sID2iaFidXHzGlOWw3OliI2Ydtp9cDfTDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqBQ6rjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqBQ6rjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74D71F000E9;
	Mon, 22 Jun 2026 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782121160;
	bh=jywbFWJJQMb4voZKch/mhIhEN+ZQuAx8Z5zBj3xYH84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oqBQ6rjJaVnRIrkjFCB0jUF2O5Fd/oJeLFqfK8zegHzDSc1Iuecg9D1Avply2d8ro
	 mJ2bpRxwOQTi9c5yo4humQsvDlCWQbCJuLXXiCBrNb5TXxDlhp+VM21Cp5ZTeRXRgA
	 eki/u5rm56FEfcqlfUo/S1TWela4g4g1ZMD7FaWPdxV0nICfjgmJJJ6kSvAJe1P6g4
	 vF4R0y8GFM0n9VAF5+dRCQzxmy2BqraF3yqFOVb6J3MznO/v68hdM0nu7C14PZkTXq
	 R6oupS3gehB9fZOLIL7TRHxC3ESl5t+zjR9T597oO+305bhxoTKq48JoLdq6NIqUOc
	 CK84WDYzUGZWA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/6] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Mon, 22 Jun 2026 17:38:59 +0800
Message-ID: <301756f0f5009b7fbf8b88055358024d36c419d8.1782120674.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782120674.git.tanggeliang@kylinos.cn>
References: <cover.1782120674.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Change bpf_sk_stream_memory_free() to accept struct mptcp_subflow_context *
instead of struct sock *, and fix return type from NULL to false. Add
sk_type == SOCK_STREAM check for safety.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index cb2dddb7c3a6..85ec7b0e00d2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -296,15 +296,16 @@ __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 	return tcp_rtx_queue_empty(sk);
 }
 
-__bpf_kfunc static bool bpf_sk_stream_memory_free(const struct sock *sk__ign)
+__bpf_kfunc static bool
+bpf_sk_stream_memory_free(const struct mptcp_subflow_context *subflow)
 {
-	const struct sock *sk = sk__ign;
+	const struct sock *sk = mptcp_subflow_tcp_sock(subflow);
 
-	if (sk && sk_fullsock(sk) &&
+	if (sk && sk_fullsock(sk) && sk->sk_type == SOCK_STREAM &&
 	    sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
 		return sk_stream_memory_free(sk);
 
-	return NULL;
+	return false;
 }
 
 __bpf_kfunc_end_defs();
@@ -327,7 +328,7 @@ BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
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

