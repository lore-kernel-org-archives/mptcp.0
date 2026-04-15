Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9792EA171
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247097; cv=none; b=a14aS0gsrruVMjtFaXLmVeSnEtl9fOK8S5CHlD+z1ueM1IpcbD+EoA4eIfhpDMMNW1t92jriK+RpBoCjqdiTXZMMZqmnTa2lSYPBiJeLHXyIOi0SHeNt+J+21B2pHxhwQ094rAZ0g8tWVkm9cyqAmD8Oak+WJ4eJCO1NK7kNJcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247097; c=relaxed/simple;
	bh=Kktud8wCpveHjCbjDWmaJblCLdYijhqyRCfLH5Kou00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mKgB5sLoIzST/MD243NEQOrw8zUJCnTAhNBYPLe+8WNmItw3gXEi7CBZE+V3TsSv7zaf6oZADSv7Jri79PNuVEtAu1HeiUZKDC/zK4R9sDg/d6Ve08v3wQqVvGH2kaLUiWCNIraH9zNC7RZnHjugU1xuuQUJo8Y5HZvCYoL2nYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVcGW7QZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVcGW7QZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FCCC19424;
	Wed, 15 Apr 2026 09:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247096;
	bh=Kktud8wCpveHjCbjDWmaJblCLdYijhqyRCfLH5Kou00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UVcGW7QZ4kT65PgMqZaModFCrPSsZuAi3KmMJhegORU1uftdGEa4DffGJfyw/Lj4B
	 3nLWSkLfdCrRr/k2Lc7E91cYHrD3QHGLmaJ85eT6cZ0AEquzYv9su3ae0BtNFk4CmQ
	 nVbq/cuzJuj17ah7LztzhFXKGopNzQUX4nukJn8TCEXrvmqeqrQQxUrSvWmDnAMBCs
	 G5tG/zBFzyBAJFEfPf/kTn/i1mc0nt8yd7jd3dvDVYnxk+VdwtW1oip081aMZpx/xX
	 H5IjRzQ2N8Ulmw3gku0+EeohHeNnTfmajZDVr1sSj/iajwVgQcoD6O3sdpbiG09iPO
	 dWWydci993tcg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:56:56 +0200
Subject: [PATCH mptcp-net v5 08/20] mptcp: pm: retrans ADD_ADDR: return
 early if no retrans
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-8-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Kktud8wCpveHjCbjDWmaJblCLdYijhqyRCfLH5Kou00=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ2rMZlL1VnPVvOf1W/r/NfEtDg0zG8NO/+LNjFsb+
 m/ttCK1jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImslWH4K/2PQzg7dPvSYzX7
 L03imuH40i80YDGDx/fLMomWwSyqyxj+1xru/lWcwpD1tJ2f59hbjTUea6c9TvQTvPzz1pobLx8
 G8gIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

No need to iterate over all subflows if there is no retransmission
needed.

Exit early in this case then.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 22ba75fa876c..25cfc5b7cb98 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -308,6 +308,9 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	unsigned int max = 0, max_stale = 0;
 
+	if (!rto)
+		return 0;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct inet_connection_sock *icsk = inet_csk(ssk);

-- 
2.53.0

