Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65933257453
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804398; cv=none; b=V1BM6M9W2aY6SyzWBLIk9GCi52RIJSYuTy/NotCg2k/AVHmSrz0P7sTz+VwmvUk75JicX+9r3DCRDwLBQEuG3WsOuuons34RUyY1JouJ/lSwIh2jjaR8DlP9qQGEURVcp6XaMsxn2wouKoyd8jp/kutFCWPudw1oL+CtsJ/1iKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804398; c=relaxed/simple;
	bh=Ow1hK2WLiruOPeZn+Dtb69TBX0BXmFysmVrd4o+S4fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0R685gPTE9YTqR6QwJIm93yffSF10DMY+XD6D/ofPiv7nYaN4CAdAb4o0lvn+q29tP5bePSE1up5UevzK1uXDnZvv5rXR2k/G9eEORZevG5CwlFM25sA8rYoxTw2DXIxiIS8TGwG2+8V6aXkrqmrQNhMcjQfEdXNIJ5i/Rr4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts/HngP8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts/HngP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B616C4CEDD;
	Mon, 24 Mar 2025 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742804398;
	bh=Ow1hK2WLiruOPeZn+Dtb69TBX0BXmFysmVrd4o+S4fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ts/HngP8q/3T1KBW5UhcTbkjI6+Ab8WWxpJqghHjsOSTb+AUj/RMglOqUPNhOAxTT
	 59gppJ9QNqguxDFvNCzzoOJTihIL70tyT7liRPzGOl0N9UC6BlgHeFPbDkIbZFNvyL
	 2/Xf13+XV7I0lXAzJ9tKF0rGWZjHAcIf79Fr78uhjEAJengbUSfCm54rw32lfFAm/C
	 OUmlZP+DKTfg3MdL3087shLxZSBAc22wAw8vxnjpbFF1aa4q4lvv4o9gNVTQUq5d7N
	 eBuDLNJS+3a6SaVlyLsU+hK/wzyO4cPhSR8WmtooI1lycglXaUY458iPcwphkjs5WO
	 v7/y/9DqHDcxQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/9] mptcp: pm: drop redundant MPTCP_MIB_ADDADDRDROP
Date: Mon, 24 Mar 2025 16:19:38 +0800
Message-ID: <d16062a0e4387b9b09554eda9a5447e89ff7529a.1742804266.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742804266.git.tanggeliang@kylinos.cn>
References: <cover.1742804266.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP_MIB_ADDADDRDROP MIB counter is incremented from both the in-kernel PM
and the userspace PM. This can be called only once to reduce redundant
code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 906c558aef0b..8efb47331f79 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -586,6 +586,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct mptcp_pm_data *pm = &msk->pm;
+	int ret = 0;
 
 	pr_debug("msk=%p remote_id=%d accept=%d\n", msk, addr->id,
 		 READ_ONCE(pm->accept_addr));
@@ -599,7 +600,7 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 			mptcp_pm_announce_addr(msk, addr, true);
 			mptcp_pm_add_addr_send_ack(msk);
 		} else {
-			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
+			ret = -EINVAL;
 		}
 	/* id0 should not have a different address */
 	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
@@ -609,9 +610,12 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
 		pm->remote = *addr;
 	} else {
-		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
+		ret = -EINVAL;
 	}
 
+	if (ret)
+		__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
+
 	spin_unlock_bh(&pm->lock);
 }
 
-- 
2.43.0

