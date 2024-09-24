Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672480C13
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169017; cv=none; b=X/pUYDd8+kVDsPSi+L++MoBVDTJWhcjzmv2G1g+JPdfSpY3Y4m9vpF84JCwH5pf8AAl32HW2WnYSsEI+y0YfPBcNpaHcNxb3Z4qEembsC+6lUXAXmL0a70LiLWLr08v9IhZ3VAlfrSsF5IoHPkQmDtKy0ol2T6YljxZCgvf0EuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169017; c=relaxed/simple;
	bh=f0hBMXuSXKp5L3lBtmLBbKDXwkkk785wylGa9yTx9aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTjLStO4FQ4sIT3ykpB/BjaQfY1VDcuyNsxk494Hxd0ez9/sqTQZCOC6KaAR4oQPNNNz9yB13qQ7CZPOllySjFVdBocdMkGt111rVvoVQ0BsXiwJTTlVSE8ot7hNCQjIPzS3XZpeX1+zGsNVn5jujQd1+rftT3WLVpbPK/xZTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3m/PQDp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3m/PQDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538A8C4CEC4;
	Tue, 24 Sep 2024 09:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169016;
	bh=f0hBMXuSXKp5L3lBtmLBbKDXwkkk785wylGa9yTx9aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3m/PQDp/Skp5Pj3JFoAIq94KGF5ogBd5pHq9IefjXoLWuv2Soqvh7z/BTidD5nrM
	 1RWGNyq2/OtLQfgqRdSN0H1nvfWSppIcgNmqzijs6seIHiPXaCUWKfWTpAoFGmwtK9
	 U/IifGDgpvfOzAyZsJEf1FPFMKoU0ngs44T63OsULtDgNGPKQlGPgkJabcmeeNKvX7
	 0jAT4ILxzrxLL0pfjkeW6lIqBzW3HtF5q5ke8nA1RDyhL4+pgUuGKibqTw79AH7tWV
	 ObAm/IcJSMwG3gXrnSewSrgyh4Ko73DfX+stLuDvz23S+sisFTk8GWQreiI7wTdH3T
	 5ll3Rfd0TZAnQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 08/10] Squash to "mptcp: add sched_data helpers"
Date: Tue, 24 Sep 2024 17:09:52 +0800
Message-ID: <caca1a13952a076d62a49dbe919c421ee3ce0d76.1727168628.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727168628.git.tanggeliang@kylinos.cn>
References: <cover.1727168628.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use __bpf_kfunc_start_defs and __bpf_kfunc_end_defs.

Drop bpf_mptcp_subflow_ctx_by_pos declaration.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c3942416fa3a..d864c8ccf316 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -722,8 +722,6 @@ void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
 bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
-struct mptcp_subflow_context *
-bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.43.0

