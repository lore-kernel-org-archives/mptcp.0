Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E018953D
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676432; cv=none; b=o/0+ezc7WUwsmLhV6l7mrA/NMMeZFz6Om18hbpdAN20DvRDx7YN8BR1BnRQ+FxRj5wDSqwMJsa8rw2fYiaPi+mT2aKBrpQp1RaTJ489Dk64JsttW6USJZDCABGpILBjttHO1+ZeasWxgotLWIMYQJ7Rz5VcKMnr/kyMQ67MBSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676432; c=relaxed/simple;
	bh=fkwQLcs6tzUrO+f5yBEU0KgcCzgzMniTdPsOx0v8dAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YchGcPCGxS7bzfc1TlZe58e4Is8ddsEIEcJiLr3LrzXHjmspx+Kb5UHecq89L9A74YqoRd73QQfraD+9GAhgye+YBxNybsxfFCJsggOMkd9EG3OP9yEfS2VZsR+lCFPBjMJL0h2sHEFhmYJBbWZzui8klVtNYtunb7tvN7bC2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuuObrhq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuuObrhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D586C4CEC6;
	Wed, 23 Oct 2024 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676432;
	bh=fkwQLcs6tzUrO+f5yBEU0KgcCzgzMniTdPsOx0v8dAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NuuObrhqA18txJRCx8rlYabL43z3fXHw08hatkXk0XO8h5dom/87C6uvl7LP6ZulU
	 E6Fu69iMVq603d11Hylb74OU4VTyN1qjsWkLEldhViBalKI82KI9llk3EfRQisk2Ir
	 fA6OBUF8xCg1VfggHvHBuIU5jQkeKASMgMtymPjGyek9YwqtWudh1d2aTbiaCyuvfM
	 SR1J/kAXY4vdQ1+X6g+y4arp92kaVnDXI4Zoa2WvA1F2oUiCWkD6N6LCrVzTe65MHV
	 NVpZBx7zKlYg7Dm9iIzze0k8Zj8wBydKnsRv4Ph1pkX93+X6U4LJnm7Dg8UtlNdCwF
	 rpauWsHJnpvKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 01/13] mptcp: check sk_stream_memory_free in loop
Date: Wed, 23 Oct 2024 17:40:11 +0800
Message-ID: <0c7d7cc7882ed66112656bca6031e6436ddbf250.1729676320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729676320.git.tanggeliang@kylinos.cn>
References: <cover.1729676320.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to make it easier to implement similar logic to the burst
scheduler in BPF program, the sk_stream_memory_free() check is moved
forward into mptcp_for_each_subflow loop.

Assignment like "ssk = send_info[SSK_MODE_ACTIVE].ssk" is not allowed
in BPF, so bpf_core_cast() is used to cast it. But a casted pointer can't
pass to a kfunc (sk_stream_memory_free). To solve this, In BPF burst
scheduler sk_stream_memory_free check is moved forward to the position
of mptcp_subflow_active() in bpf_for_each() loop.

To keep mptcp_subflow_get_send() and BPF burst scheduler code consistent,
this patch also synchronizes the change in BPF burst scheduler into
mptcp_subflow_get_send().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 21bc3586c33e..f36e63b84b88 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1444,7 +1444,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
-		if (!mptcp_subflow_active(subflow))
+		if (!mptcp_subflow_active(subflow) ||
+		    !sk_stream_memory_free(ssk))
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
@@ -1482,7 +1483,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	 * to check that subflow has a non empty cwin.
 	 */
 	ssk = send_info[SSK_MODE_ACTIVE].ssk;
-	if (!ssk || !sk_stream_memory_free(ssk))
+	if (!ssk)
 		return NULL;
 
 	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
-- 
2.45.2

