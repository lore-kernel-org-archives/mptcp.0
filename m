Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7FE3546D7
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107118; cv=none; b=QkqeN9tOsJ0ZRublG0uj+/JTpj4w6ib5kAWO2ncd8scGXi8pTBZqPGEHq1rA8s+AtMbyrLojkaK4/ue6tcMWeI4uh/yTh/G1hXzlYdEvxhz/iNEeda2F9eeO9vf1xJWWOroq1Xb+UfEVs5al2sVQ0kzyGsYNPNeT40qVkFfwgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107118; c=relaxed/simple;
	bh=kym+qBjlodY0u2hYBsCmui9bf1mdepv4ZExhGaElc8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbtXtJAxW9yxhTslJE9HO+xnyyJzwxuIoIjpP0dgGJ4PUKzudcPr96+oaMZ+77V4XPoqg0E/FAYdFjXr6HDJ+pZf1Bt0ue+CSjqrHd4tKjHcPGYVo4Cj2f/oq90/UQnyOk8En+DiKqUnz/XtWPfan0Qc7M+Elx0HteWkMhBt2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIciGCEh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIciGCEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C091B1F00A3A;
	Mon, 22 Jun 2026 05:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107116;
	bh=OfgDFaSVw2FuwahDh3l1T41V1fY36q/RCFV8aV14sAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TIciGCEhdv1CpAy2lNCggxBIMrviYhxLdno/CJQ3PPrMO17gMFwjVkrX/fb3OLznp
	 ZICxxyuo/4QeMhnjkvi//xRiuGWeez+sFpTEUZ2bvqIYjdVDJqtHTIlz0t/fOAEEo7
	 9oOx0Vg6wL8+HyagkOV5ut1VPznNhC4uUorKqtq0j0/m+7VOLrCfu4j16RfhA3Nl6h
	 uNMxtoiiW1ergGAGQ3hoookirWkq0PY3gbzlkWy1bXacreBfNjp0Tct1vRf1HYCoZn
	 dwmHq6i/OhTHyI1o9AtB8LCH0sp6eCEoD2Kqd4Llu0XwFVLhm59o9F2ruW5UXx+8rO
	 Ev5MiB17Ok9TA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/7] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Mon, 22 Jun 2026 13:45:01 +0800
Message-ID: <748696aea2486ca11c8d818ec2d253a00692c668.1782106180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782106180.git.tanggeliang@kylinos.cn>
References: <cover.1782106180.git.tanggeliang@kylinos.cn>
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

