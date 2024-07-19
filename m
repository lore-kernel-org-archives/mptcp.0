Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4D83CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391880; cv=none; b=ncHra7lwDpmRdLm0k7GxwxdHYHyfBolfOq5S9PuuD7DJOqycrLnfx6DpIP4KuUxYEZPoC/LviWmq6j2bbd6soJs//EAKoVqNGo62W0lSWFbaRV52rojJDrano9HKRk1lrHoU6MEgGZ0eeJShX93qG4cs5/P+mnzXS1q9tJl7hkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391880; c=relaxed/simple;
	bh=i77z9tOTtHs5P1x2DEPDtVt0aXpXalQv5SfvpCPktr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XuSFd2vh8bAsb9rThonkm5x+G07HjxJ/9+Zg2+orE6ialcST2Qv4hC4QShyH5sNIJ+g8As46aGgY+RzMNY1tZKNpOAPo641FMQONX+oAjYkmh4Pag9Zfh4LS5schpiAlgfMFqKi8bYqXRInivFH7sHhFCBHKKHTHs4yisXehuGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF5b8q7Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF5b8q7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6769C4AF09;
	Fri, 19 Jul 2024 12:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391879;
	bh=i77z9tOTtHs5P1x2DEPDtVt0aXpXalQv5SfvpCPktr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OF5b8q7ZwkLpaoS5Q4BJ0c4kBcgTFYro7JrSg+5JN5x/IvGlsGvh0GgCENpxq0OkC
	 K6x6+Gd4c+LhT7g9f1deh8wZtFrby8JqMeIWS8s3DyxJtQ4yrQGNr/hLls3KOHcZx1
	 AC4ZNAjeEBc/lVyAc/NHGtPe2Wu8dnekPICRfnubFkPv+vYCf/XzhxNH1/1ElPm3P4
	 N7XJXZ1jCR4TQafHdhUC2Q31wJmkEQjugtGwNsVY3J/nP0snpvfc5d3Z5Td80GOozV
	 Wk2bTb+DxYEjFEkQCZ2jHOVTcLNeRibwgewEL+HXNuyedhuaMvlI1DCQiSJjzIBahH
	 0wFaHdaWD73tA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:16 +0200
Subject: [PATCH mptcp-net v3 05/20] mptcp: pm: do not ignore 'subflow' if
 'signal' flag is also set
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-5-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3907; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=i77z9tOTtHs5P1x2DEPDtVt0aXpXalQv5SfvpCPktr0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlr/xHsih0kF7d7BonDcxQxAgeak2r7lGAL3H
 yIBBYwc22KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppa/wAKCRD2t4JPQmmg
 c2XvD/9l2PGUfYlbC23PevWrbvfYkf8CO79ULSIvYRB5H7M995vGdWhb8+AWCxN8FH0TTW36d4i
 xPxdy/iBzpXrgYGhrVVzoA6d93CHp0JVeyOClXSRiVwEMHb1OnKMXwpm3UE49ERV9oKFcH2YyRV
 RyoKB1ZLNFiIhfDaip8vwqFygsLOwZrLhQ7DdcfsOzx2tRRH6e11vsDsSkAlwA3QOHZ1pBaRcxp
 /3sU4CnXgBGxgKNOjSvWotJKYDH+cjakUVP938exUN8/M3EvaUf4Dky70DI0ryXI0koPtIiJ0pT
 uDbgrQAy3brCx2MpvY56Vxw7dX9JKcIJIac6ZLJGXhUUiSv3AP77vFOYDvMUJrB0M+9y8gtE+Da
 vMKBEsso1saBONGUEGtZoJa/0QEPu8Hm7uCqauodYa5W/7naEQxk2GooqXBHUND+UoKXOik5Kzf
 3htVc/5b+ObBFVUIu3pbrzy0Sxo/U5zMH1Zim3OreGfA0wJRrUZ+Kpz1YgZbZ7bQWbv+vWfMZ3H
 m4uUb6keq6W0TNpZ6uZUKJ+HnYjvrQqxnILi1jW7NN5S44rQAO30noI3WDIU2ACZa0TK9ltKAwT
 y9leBq6vbXSKlygAucbnqINyMDy5CHaEQWg+xqmzXnQbAroQ/o1me2y0skMqncTu+G/xLQ4BwmC
 afCRU8geE9D0TbQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Up to the 'Fixes' commit, having an endpoint with both the 'signal' and
'subflow' flags, resulted in the creation of a subflow and an address
announcement using the address linked to this endpoint. After this
commit, only the address announcement was done, ignoring the 'subflow'
flag.

That's because the same bitmap is used for the two flags. It is OK to
keep this single bitmap, the already selected local endpoint simply have
to be re-used, but not via select_local_address() not to look at the
just modified bitmap.

Note that it is unusual to set the two flags together: creating a new
subflow using a new local address will implicitly advertise it to the
other peer. So in theory, no need to advertise it explicitly as well.
Maybe there are use-cases -- the subflow might not reach the other peer
that way, we can ask the other peer to try initiating the new subflow
without delay -- or very likely the user is confused, and put both flags
"just to be sure at least the right one is set". Still, if it is
allowed, the kernel should do what has been asked: using this endpoint
to announce the address and to create a new subflow from it.

An alternative is to forbid the use of the two flags together, but
that's probably too late, there are maybe use-cases, and it was working
before. This patch will avoid people complaining subflows are not
created using the endpoint they added with the 'subflow' and 'signal'
flag.

Note that with the current patch, the subflow might not be created in
some corner cases, e.g. if the 'subflows' limit was reached when sending
the ADD_ADDR, but changed later on. It is probably not worth splitting
id_avail_bitmap per target ('signal', 'subflow'), which will add another
large field to the msk "just" to track (again) endpoints. Anyway,
currently when the limits are changed, the kernel doesn't check if new
subflows can be created or removed, because we would need to keep track
of the received ADD_ADDR, and more. It sounds OK to assume that the
limits should be properly configured before establishing new
connections.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2: re-use the same bitmap instead of duplicating it for each target
   (Paolo)
---
 net/mptcp/pm_netlink.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0ca6b358ab51..2e94f2a9f2a6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -513,8 +513,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
+	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *local;
 	unsigned int add_addr_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
@@ -580,6 +580,9 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &local->addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
+
+		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = local;
 	}
 
 subflow:
@@ -590,9 +593,14 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		bool fullmesh;
 		int i, nr;
 
-		local = select_local_address(pernet, msk);
-		if (!local)
-			break;
+		if (signal_and_subflow) {
+			local = signal_and_subflow;
+			signal_and_subflow = NULL;
+		} else {
+			local = select_local_address(pernet, msk);
+			if (!local)
+				break;
+		}
 
 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 

-- 
2.45.2

