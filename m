Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D018BC36
	for <mptcp@lists.linux.dev>; Wed,  9 Oct 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728469808; cv=none; b=DigzuPi0VpckDazj2tD5UIx7DlluhlNNk1BKBcoZe1OsdRxVYYg1XjdCkvsxs/C9MtbmdzhBXcOraGHQiIvE1tLIdX5cGZ0PDk6cNXKtcMDh8wWyK5WL8Zv1sBy8lqHqHTcIxc6Qd1Uz7aBbx5C8MlN/mu90ZM2e6IN/vAoqAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728469808; c=relaxed/simple;
	bh=2ViO1iohtQqu4Bsc+NY9ThkthovApoF3r8WYMnVx+R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkBQr2qFB6meRlku6N95bevgQ5r68I0exQygWnbez40ykXSJTSy2LzV2XgZDivVrhsouE7eoC0ShDOsUZtNiTrlizn1aDbd4J6Nx9RSI3brhY6TUYB94PigHX1VxUFC71JzrGxov1ccYB9gNIV1CuvHak+amUWCLL3UzZPAurlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsR1qpHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsR1qpHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03109C4CECC;
	Wed,  9 Oct 2024 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728469808;
	bh=2ViO1iohtQqu4Bsc+NY9ThkthovApoF3r8WYMnVx+R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NsR1qpHEDS7nwv8d7klPO8rV8mnE4htMrJFhLZhqDU49rzHmZcUkfGRGrxdx5Iri6
	 r6pnW0iSEfS/GBVF/JqVoOYyocw3dzyy8HOdut6pYwP6UICm2sQQf8BSkJe77f8ChR
	 vHrYxDR2xTHzhXyYeziUZRuELi3io+hUxQL7sryO6mudvkFxvSC+AQxgvu3lrhoSMy
	 zsURd9HND15V7JjIHCQ8nH3W13rMzH3kq5tvmaxUTFeUcTEEEKzXPhUXdcZnImHgDO
	 pu3+buoFPpsRQnJu35tohgpnKG2PmBV7CpR/2jWf00jF5wv1vwACBF3KRDZTTG7LSD
	 yYbPmfjK5oR6w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 06/10] Squash to "bpf: Export more bpf_burst related functions"
Date: Wed,  9 Oct 2024 18:29:47 +0800
Message-ID: <5b470d4495f55957e01c2e09cd8ce50c511e7923.1728469555.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728469555.git.tanggeliang@kylinos.cn>
References: <cover.1728469555.git.tanggeliang@kylinos.cn>
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
index c3942416fa3a..f1e90e7b2431 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -721,7 +721,6 @@ void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-bool bpf_mptcp_subflow_queues_empty(struct sock *sk);
 struct mptcp_subflow_context *
 bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
 struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk);
-- 
2.43.0

