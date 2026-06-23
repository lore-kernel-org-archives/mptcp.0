Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786334AB01
	for <mptcp@lists.linux.dev>; Tue, 23 Jun 2026 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183381; cv=none; b=hmB3LPrY6L4onX5UWzG0qoqEL8XYBM7w0YQ4F9Pd6LMB6PhfKfEEDCLY4Q3NSIzVWLxE7Jv1vTGoJE06wBuW/LRdmEy+Cgqs4i4DA0eU/42j4rvwvrRvFb22kXj3G8cF1vWCUeNZnkJUY82KhvTWwfsnJPEkQO2YJ0MWMoh2R7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183381; c=relaxed/simple;
	bh=lFb/geS2dZg3XJzMdoYqIDC5yB2B+9DfL04NK4etorM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZNFmWHaZwZ7lsSNJcqghCUhyv8tR0TFFL0a+5B0dEw0rDmSrngW57zbALiGOfVHLxa+BG9XMD3zD7vvUaYVYIsrn97VOPoUBeFUUK1wN6nfkLP5W8NLO8SL+LaLuLwfJFWYfEU4Ph45EltAmhxOkSB2xSwJRoFn55KlEDAENJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkseMYLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkseMYLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FDF1F00A3A;
	Tue, 23 Jun 2026 02:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782183380;
	bh=U34nGYcY58lJoa5TjzbUg0D4eF3hXF9c26ILuO7GtFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dkseMYLPswvp/xggIsi9CrQqFUx75FJi13XLP9mQ1UTxT9R8fU9W+IDnsEMNh54tZ
	 xNmypj3ypwF6wb1gRn5LJljnzgHTpd6PQsJSN9H5sq5XQOO2QiR8ViKPLskoHAQvDs
	 CHrG8daKfU++3fVx7CNAN+jDntkgynV+jLRb0MgAmeap6ufal1fa4ghbOKWt4TYBjP
	 qWhbKgRybphE2Li3aGGVSGlgwYJP0EE76XEGV1OQaeQH2VV0YwmBohfi6HRgehJv82
	 tU35Ek/5t2V2d3WVID8cG3RrM7DURh7tXrwJ4lShvuwugBOn5QR2jnkWtWlIN1HWeG
	 Qui6vfySvSwIQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Tue, 23 Jun 2026 10:56:11 +0800
Message-ID: <ee0785ca07c6b2f4ffec09f9b4f394b8a46a9565.1782183266.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782183266.git.tanggeliang@kylinos.cn>
References: <cover.1782183266.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Remove bpf_mptcp_subflow_queues_empty() kfunc and its BTF ID. This
kfunc is no longer used by any BPF scheduler after the burst scheduler
was updated to implement tcp_rtx_queue_empty() inline.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 577b815775a2..0845061ddc65 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -289,11 +289,6 @@ bpf_iter_mptcp_subflow_destroy(struct bpf_iter_mptcp_subflow *it)
 {
 }
 
-__bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
-{
-	return tcp_rtx_queue_empty(sk);
-}
-
 __bpf_kfunc static bool
 bpf_sk_stream_memory_free(const struct mptcp_subflow_context *subflow)
 {
@@ -327,7 +322,6 @@ BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
-BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
-- 
2.53.0

