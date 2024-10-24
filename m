Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA7F3399F
	for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765370; cv=none; b=gl+Cpm7yuKYt2ekbniyK/mo7kpgXRTZXjOBbfQtYPoCxN3T6TZaRWbsfWUZXjtY0FHGnDNz5GDrZTyITETIBUxmJp0+Jm4uMXL1ihXUG6oSH3fB0ZEdHRsY+i5uDTdkMIVcXfMSHbNzOewaZeL64Hfk0BeMrC3wToQKn6BocL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765370; c=relaxed/simple;
	bh=VT43MGQuTuntnrzOsd2zKMJLJlTGKEs3kCyDsZa1odY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZ8fnUBsK0y3BKHnf6W7FB2DzGufu89qTI4mJkoJilwFhtRchqbrbHiNZDcOHBlNL264ZQd8hLE6b2P6tmhwkUcMRBB3OdDXRAq3blsfcpn14l5erADwdq9yzSXmnKH81a4L6rR4xQ9ciOdjZcT/gbv/J9dyg+kr1VeapAMkpL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu/NvehG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu/NvehG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013F5C4CEE7;
	Thu, 24 Oct 2024 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729765370;
	bh=VT43MGQuTuntnrzOsd2zKMJLJlTGKEs3kCyDsZa1odY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mu/NvehGExxDBw3aynDIcL1SH2GlJB+ap8mXrCBsW7xl7uZ5/CRoe46SzA9C/gFNS
	 v0zVR1ScnlxfZ4rPKsEdWtzZLX3xlVoWZDaRS13YvZw22NE/n6T2mDMv0rpfqGEO1T
	 d9NRJM3NFDNS3EsFE3Rqjk1wh7HCzXPSy4MhhdajH4ZgxZRupt4A3iE7G8Ya5Uap/y
	 mNGA/W3JSOEhb/sjPIrCyrk3JU2/Hu+gwULqykDOcmz8RStz0r4WBAungM9/idXgKi
	 1DEMLH3r5qmEwnHOcgmymU8IFIvfd0oR8WDb7aLlin8jlHi6MeucJTMY1PI84bfbe0
	 7MRv1xEMS9B8g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/3] Squash to "bpf: Export mptcp packet scheduler helpers"
Date: Thu, 24 Oct 2024 18:22:03 +0800
Message-ID: <02394532426ceb8b5d9baa3d6ed25c1dfe60208c.1729765157.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729765157.git.tanggeliang@kylinos.cn>
References: <cover.1729765157.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Should use mptcp_stream_memory_free in burst scheduler, not
tcp_stream_memory_free. Add a wrapper for it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 13bdcbe34e1f..72d8be2f3853 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -284,6 +284,11 @@ __bpf_kfunc static void bpf_mptcp_sock_release(struct mptcp_sock *msk)
 	WARN_ON_ONCE(!sk || !refcount_dec_not_one(&sk->sk_refcnt));
 }
 
+__bpf_kfunc bool bpf_mptcp_stream_memory_free(const struct sock *sk, int wake)
+{
+	return mptcp_stream_memory_free(sk, wake);
+}
+
 __bpf_kfunc static bool bpf_mptcp_subflow_queues_empty(struct sock *sk)
 {
 	return tcp_rtx_queue_empty(sk);
@@ -311,7 +316,7 @@ BTF_KFUNCS_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
-BTF_ID_FLAGS(func, tcp_stream_memory_free)
+BTF_ID_FLAGS(func, bpf_mptcp_stream_memory_free)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_queues_empty)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_KFUNCS_END(bpf_mptcp_sched_kfunc_ids)
-- 
2.45.2

