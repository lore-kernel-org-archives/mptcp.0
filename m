Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9772FEEB2
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004135; cv=none; b=oeg2k3NjUBs640jxhSqcZDGJgxSfExsP/wHUcZLSXQSkg4b7tjlVe9FYjvM0VE4IEACwdZZii7fvQ1qbWNrrU9j5MbEc2SqczkX89iAOr/lNI7Ph1Ky/iGZxr/rV9IP+O2/4+y3wStoKqiUtGUNTtbEccfqDHuJkZ1FWhJ2zWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004135; c=relaxed/simple;
	bh=+d91lFsMQ1muFkSoMmSWbdY5ieuuCOxbXNJ7SGQttTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PADL38PH4ppAtRyU+hZfEMpnL38nP6TayM/dReQeU18M3d1/o33NezX0kkzxaUecg2uDyKtp2bjj2ScaVgHotorem1QXzGvqWwsCw69uQ3PK5DOY0ddCJR5SYcJ8ucWmPlryQCJL/ZCr9ecYUxJUs7CEWKGICT3iWFkV8Bkf04U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba/xyUTN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba/xyUTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D40C4AF07;
	Fri, 26 Jul 2024 14:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004135;
	bh=+d91lFsMQ1muFkSoMmSWbdY5ieuuCOxbXNJ7SGQttTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ba/xyUTNCi/gFT1TDPgwb0DU3l5OeZ7/gIAFKx9T3GNS2+JPY7N9v3uWVoqC0CxRC
	 eqzY62kvITGMIHkfo5I7/VQxPFS1iPrT9y3yK0Wj1Ljjj+EmyST8MP4fBCBsb675hg
	 BWAbxZrCoLsKnuQNEg0QTAdwJm1+GiG1SdRefYQTxxitZJDWlxUrwAvud2cZXPoZcH
	 S1XgJZ3lgeg1ByDLEKHb/+SEiQY5ZQF9smgAnA4Y65VoQ+FwX6mNVh5W7WNzp6+aPA
	 cvaiRZLqbp6sWQJjbbLQVHwRHJXn3Rk8OZybOHISqG0wmNt9k1J9QolT2MR+3szEtd
	 PQD3dfICzlZPQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:33 +0200
Subject: [PATCH mptcp-net v5 07/13] mptcp: pm: only in-kernel cannot have
 entries with ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-7-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+d91lFsMQ1muFkSoMmSWbdY5ieuuCOxbXNJ7SGQttTs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7KcfpDAWECBsroh3JLdDOwiQZvL7061ZDUsR
 J0UHN0qlh+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOynAAKCRD2t4JPQmmg
 c3LcEACkNIWWeEzcsUOY0SwXfx5hK6e58n2Q7/ZldDeNdQNR+NtbO/hSMLcwDSB60zhw+peHNy8
 pzCmVhZ+4LKduWnf+mUON0STfFeLhllsPRXWyzHTcDQ87HBYd9WuLTpPhDO1dTMiApzjMLhGp2F
 ldU8fhyoOiFxf0yycaTC9wjam9qGuhZG9oeV4450vz0cAeDVHlFm+iMrRVi3VMRyx2EML761WYS
 VqXuk2g7sZYAppFMKE/nJYiJVkuxbDyEu/TBLlXuQ/+bRUJc71TMFLWHVvh5as0ZfU1IvHyioXR
 evOh9T39IlVG6ub6yhB5LlE7oz635mMguGkrVvQLv6zBzFaq0fFOZsAQICw6FW1lmz8dBDmVh/m
 CUIdFTHPS9L0kQNqBIYPabqPt/QKvyBv2eQAn3rk/svJx0OH4tX+dk5AfAxWvgHxzKDumziLXKi
 4eh4SoZMumkOyDrxE0oC5ylDAq1TWiSzD17KdTFAY203gAXaU7EUUIMxpWkRqlYDErBxUaExwse
 JTP3gFDJxvfH5JqA4yJwBAQplm5tg0b0gVrMw74nVADmzrykxaj9/skLJs4f/RruaFP52oRHJN7
 30r12NB6jb0MxveIZnyTCzc0xWKnDXb8Hy9TO1DynDvdbNqkQ8u/OScUTqYWEY1d8UmAF9Sz5RY
 WFDqP6IkNgyPe6Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The ID 0 is specific per MPTCP connections. The per netns entries cannot
have this special ID 0 then.

But that's different for the userspace PM where the entries are per
connection, they can then use this special ID 0.

Fixes: f40be0db0b76 ("mptcp: unify pm get_flags_and_ifindex_by_id")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 3 ---
 net/mptcp/pm_netlink.c | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 925123e99889..3e6e0f5510bb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -434,9 +434,6 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	*flags = 0;
 	*ifindex = 0;
 
-	if (!id)
-		return 0;
-
 	if (mptcp_pm_is_userspace(msk))
 		return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3cb02fe359c0..6a1495fec7ae 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1395,6 +1395,10 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
 
+	/* No entries with ID 0 */
+	if (id == 0)
+		return 0;
+
 	rcu_read_lock();
 	entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
 	if (entry) {

-- 
2.45.2

