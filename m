Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AE4A1D
	for <mptcp@lists.linux.dev>; Wed, 18 Sep 2024 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647936; cv=none; b=pU2oDfBVY8y/Zz3lbj5C4VcvxeH4mzNxOv0AC2SIhqjy1hDWrpRBwNr19oEH5t+E9cnxDh9IOsg/jmj5QJWkB8CK90knzZ/IfpqkeLq6o2suNK14hpv+4rYDIsIlkEeV+kPKrsk9H45Y0wQ4uYtZinHqtHvY8jy0vxi+w9/dTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647936; c=relaxed/simple;
	bh=NMOtzIOCOETa0fpcP9kKo8rqzMY7RmWa6x2jUA8URDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJMixR/xeTLloeoyLcp8XPMwAAEAM+JcfFjCExPpN6zjc4VQFG9g4ptBs2SOJIilGkLITXT8BX7vBvwctrKgpkQjLYcXPGrM9lNPhkBfbPufbElgnFEbgX5K0Au/A95z5TSr0ixcK+oDWNc7d41WddbI6wLNqcxlX+wVoZ1NEfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUl36meP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUl36meP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34BBC4CEC3;
	Wed, 18 Sep 2024 08:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647936;
	bh=NMOtzIOCOETa0fpcP9kKo8rqzMY7RmWa6x2jUA8URDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUl36mePWJw/vkW2LgsxIrqj9DdeNMvIwUnMyFZyBAQHFpQU/N1dQIA94/ks03Hhc
	 /0Cq9PEiVYQw1cKGId8GadADA+N0JvCi2VCe04d3JFz4tTxgj5CV4SfU4CLdQq08zG
	 WVHcBjTxcDvEgcA+b/j1RDWIx7r/RJjZoKGoj86n8oFeWlUgdyoPcLiKSz7DVXLOok
	 OidRDx6aDo4tY+kF9X328RTqo4xJ9yngP2nnDvf36dnufPsxNwXTdLqIFgRlT6P7mD
	 k19FC6WmJg6gjlu/vz8GowFp2dEVlDT4IY8ZsQjD2h8WAJqaeD8ceTM5h94UwSYe+o
	 0sONfn7+huUAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 6/6] Squash to "bpf: Export more bpf_burst related functions"
Date: Wed, 18 Sep 2024 16:25:18 +0800
Message-ID: <98a3a4c94ebe9aa31a4e7282c8598ce6592e8fd1.1726647599.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1726647599.git.tanggeliang@kylinos.cn>
References: <cover.1726647599.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop bpf_mptcp_subflow_queues_empty declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d864c8ccf316..9df56c21756d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -721,7 +721,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.43.0

