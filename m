Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C534AB11
	for <mptcp@lists.linux.dev>; Tue,  9 Sep 2025 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428435; cv=none; b=DOyN1v7q1tToTYOP4XeDj2tOUSOurQk9FggHZN10Z46FKQUx4FfevKuNcZUgxXGNxI1E0oFsYkIHtLoDjdPMjRo9br41N2IcAZ8+SEnpEBJdkt0Q76RC7tQEVQlO+heeCKo3gAI2Oz3m2/zvfO61D4p+SMOJnWtZyrVcQyQHGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428435; c=relaxed/simple;
	bh=c8mqTrrxsE8sVwlxKmpcMNt3sh+WaPV3LstRM+dcK+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaqzuLsGlkS+CNJvvylb1OGaglgglmh09UdopozjjgeBXMDir6keq9GCkqNpFfRIdxcrsmiYKqDhcT6gZhYLtwkP5ixqTOPig5qwrVJn3hfzWdEAzABYS/qg9Ia8u+HjAXXpMDbm950arzuU6P8jx170m+HyB9unghNkLZ+xokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvQUi0jJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvQUi0jJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8829C4CEF8;
	Tue,  9 Sep 2025 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757428435;
	bh=c8mqTrrxsE8sVwlxKmpcMNt3sh+WaPV3LstRM+dcK+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MvQUi0jJxSqr7j/vK8BqRmZfk8JmLpFWathjwr6Vr7Lktcx5R8cH/U8VwUdqcL7w1
	 zyJ5bbOtTUrBP5t0gI4OKri+M9+roNFrcBp+8xwaNj5DqWZJRXuNCf1B/+3E+ANQi7
	 xJnN1XsaQexRAonZQhqtF+moFEXiAhDkQqx2+3WhFQR6OzBYOobGzhD/rBVPnJGO/m
	 8BEBNczv065fqtkCtQ5cI+d8kY7HxhEi9pMQwJyOmv6KcMhbIDo4QbxFXZBtjsYiZa
	 ODxBLZrFq/LfoNIvSA2Hzo9cbhH85/rWEZ9yKT0Qyt8IWWTShTponu00CG5UOnLKg3
	 SnI9PAeGRNwQQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 09 Sep 2025 16:33:34 +0200
Subject: [PATCH mptcp-net v2 5/5] mptcp: tfo: record 'deny join id0' info
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mptcp-pm-user-c-flag-v2-5-a6f9542481c5@kernel.org>
References: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
In-Reply-To: <20250909-mptcp-pm-user-c-flag-v2-0-a6f9542481c5@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=c8mqTrrxsE8sVwlxKmpcMNt3sh+WaPV3LstRM+dcK+E=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIOWJ0xmHbM5dD1ZkGVj3NesU7imLE2UeuV89dl5ldu8
 j/9fZr3eEcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEOMQYGf7O7c1mrT6w8/y9
 Cb/71duTn09pSz8pdI3f6JpxZdzpWeKMDId7CqdsqZ1d6nZsOnPz2q93165jZiiTmrgwrev51XU
 /o3kB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When TFO is used, the check to see if the 'C' flag (deny join id0) was
set was bypassed.

This flag can be set when TFO is used, so the check should also be done
when TFO is used.

Note that the set_fully_established label is also used when a 4th ACK is
received. In this case, deny_join_id0 will not be set.

Fixes: dfc8d0603033 ("mptcp: implement delayed seq generation for passive fastopen")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d47b8a9bc2df2f14645b1b3d3e10fea1b38567b1..cf531f2d815cdfbc772b837def6e7d558e64d558 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -985,14 +985,14 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		return false;
 	}
 
-	if (mp_opt->deny_join_id0)
-		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
-
 	if (unlikely(!READ_ONCE(msk->pm.server_side)))
 		/* DO-NOT-MERGE: use WARN i/o pr_warn: only for MPTCP export */
 		WARN_ONCE(1, "bogus mpc option on established client sk");
 
 set_fully_established:
+	if (mp_opt->deny_join_id0)
+		WRITE_ONCE(msk->pm.remote_deny_join_id0, true);
+
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	mptcp_data_unlock((struct sock *)msk);

-- 
2.51.0

