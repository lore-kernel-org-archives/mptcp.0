Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8FD3D093F
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831532; cv=none; b=IWjzFz+RmjXfSWvRAoFrChmiRm0NDUF2io/+2l5PbgMtZOYlp32lO/elc8XIcJFDRQTkfOGNNRhri0CI4yavyS8isOtTdCljABXy5BeujdKUNFrUzfFeZFMvZ10Ir3kaIifMoT4FMDElx4GYDW2wF8nGxR8BJaL6raEAZ57v0ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831532; c=relaxed/simple;
	bh=n7m5NGRD8flhLCd8/DFZTtI0Qr6tVjjJUIHGjUNfB0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tHs5jN253/faOyJb8oSxKdT9j19qtlD+y2CrqIRzBIv5EltsQbz/Hn2dBgZvTYyGhbgi4WsHD80HIz5lixA3hXcfImZ8ejwaqn71/rlL8tHvk4ISdFijv7ulAmPBoW7R+atDlax9lTk8dGXtPnnECnaF+jz2mLokIYf2myZunSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEpAMUvs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEpAMUvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20DAC2BCAF;
	Fri, 10 Apr 2026 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831532;
	bh=n7m5NGRD8flhLCd8/DFZTtI0Qr6tVjjJUIHGjUNfB0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KEpAMUvsKG1q80KGc43t0Xb5EyfDbrtv5ZlWSs8RIuwR3rT7CSmInXU6LsHIMWteS
	 dwDnTtos2g1sVLmzlKH/EjWlo6evSsMaNc40CTR0khbZORltrww+3KgToJswLrz4Mf
	 zaTESy3UrcrZCM9x6upyE1sKwpGDoeTzcP/isxYhk9J9rWG++DTB0uAYnyHdWkF5qM
	 j1IXCo5U31SlOkOzIKut6MLU/eXV80Gf6RBdtnxhTs4MSVJ2mR452pC7R05JE/Uu+C
	 Dl6XJe96vAqW/joNzaRr5yH0c4LA0vylfiKXMH8ZJMO+dwLCE8aOFpSejgn+sHuLFb
	 AK8sZWCKSEoGA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:45 +0200
Subject: [PATCH mptcp-next v2 07/17] mptcp: pm: retrans ADD_ADDR: return
 early if no retrans
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-7-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=n7m5NGRD8flhLCd8/DFZTtI0Qr6tVjjJUIHGjUNfB0c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvct7drn1/vpMjZ0sNo6bQ9LNmi1eYqFzuzA74qJFaf
 mpJp3d8RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQ+PWD47+ldIrdkufeiNs1Z
 nB95Go5oBwsl7DXZ/yni/JR3DNmzGxj+x+x917/TzGuZfXeQ+uzVks8tIy2vvX1X83y6NGvgB/5
 dLAA=
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
index 1c3376c01d70..6f1950462556 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -307,6 +307,9 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
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

