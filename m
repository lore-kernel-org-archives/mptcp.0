Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6289D212D6F
	for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737554157; cv=none; b=k+JsXStdihJj2I7q18ZiiJUOiU12iJsSdyvsVUEUeVB2McmlqLKjm/MLAbOKcFcU+ZZCBFGbQh5+eTqjrplKTl98j5bpgVL9dqtsndu6864m3yqOlQpISAYbWcNGwd6VdEZiC9kflMRgiN8dLuIOpBPHK5Ss8/PZW2dSPVjQdGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737554157; c=relaxed/simple;
	bh=P5RC019cKT/eBtc7V29rRBzlBTQ5XDbSmBJnmu36ZkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jv3Vd3b5qpke8fSojikwcJyb4PZId49Pre1auSeLTRdn+cpWqUO2p6hHgZPao6wUefvsgIVyoteCLeiGAanCUE4vdFTnnijF1mLYmbSFNdT8HGW8f9z2iiTn+YNtzJM8Ea1IKAEBnr6mMsXSKoHEXHo5sKe1JAtMwPRH3YY9P7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmhk0nax; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmhk0nax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46776C4CEE0;
	Wed, 22 Jan 2025 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737554156;
	bh=P5RC019cKT/eBtc7V29rRBzlBTQ5XDbSmBJnmu36ZkQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cmhk0naxmUHeMgJUcLmAdzDX8Li7bU3KCQIKipEw2k2KxxTh5blUZU1mZ9bbvPTQc
	 OjKBog+z7v7J/Xtdo13IDAHMLVn45rax5r1KtqNWWYLKESkm/ojhg0ngpGhPNWq910
	 mFNOFV7tdOQNi/M8JZqZui3QH8GItUrJmHWJPI+xjZYpH078SwHtZJZ9dv3N1xmdxB
	 nu82N9t6EPwPlfMjcpqtHian1+pVHHHGQPyp9GfycLa0O3cgfcELzbb9oDiiMym60T
	 g50/50hGg8JTiLzD0uFxBUTNOkRb3Op6XAT1p6lAZXV301d71cc/2bbd7sj/RJmEjF
	 GFhX02BJAxDWw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Jan 2025 13:31:45 +0100
Subject: [PATCH mptcp-next v3 2/2] mptcp: pm: change to fullmesh only for
 'subflow'
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-mptcp-issue-540-v3-2-4aeed3022f23@kernel.org>
References: <20250122-mptcp-issue-540-v3-0-4aeed3022f23@kernel.org>
In-Reply-To: <20250122-mptcp-issue-540-v3-0-4aeed3022f23@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3010; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=P5RC019cKT/eBtc7V29rRBzlBTQ5XDbSmBJnmu36ZkQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnkPjoWeLmW4QfBoLt7tf5adsDgk4KJSjLtbPql
 pVQOcUgr32JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5D46AAKCRD2t4JPQmmg
 c1j2D/9P5zAQAbaneC5S9IQKibySY05IUku0yVU14Az5NM/Ud6QV5beGZM5MSa+67G0C+acwV9m
 i0c9C0dsjzuZKimbfZ9oKk7NIgKfJCNUmEeqjAdXkS+a691Zh9k+U1GNUyAczfYWfr8VtkMBkNt
 vWmYtv8BPx01sPlv3C9pRxGwOPOatXp/JxWRD+wit568DxgjsR/wIKF/Q/45SnoJ9HhuU0m46It
 PkllrMvdt1f0wLo6RtUs6akR6Tre9z5PKkrW4ZrPIib+Phl+mWLpmwX/ehcIWe3OfUzhigqU493
 GjHWoRK4bFIENCwm0nd0fM2oe4+i8azlOlzCFxH/OMRik2JqOTd9nQFpYYkr73/O4L3YvB65d9T
 4L1xtzvf6zyvmplCIg65pBCEAOMteuDnTu70ef8mi3bFmh8MNUqfPFjQ5sjBya/nNnTobb0YGxL
 oN73u8rbcw4eqy8vg4wEjg2Xi265dVJqTY6gw7iEfom/PMCVxISPqqMQKSXuUVBb8Dj4N+RPUeO
 PSGNKvXKNrPDxuUErLP4uoJI6ysZ09aXC6W/uAScHPeMXo9y/7jpVcQJDO6yEYTxcN1duJx18XB
 LaDE/E3bJW59HqpS1vAOUJw9DobsRyiQ4JpXc6mypufore7g8rJDpfTmNF3RY2iWGxTg3wFXRRM
 ZDnrf5P+O8tUuQw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If an endpoint doesn't have the 'subflow' endpoint -- in fact, has no
type, so not 'subflow', 'signal', nor 'implicit' -- there are then no
subflows created from this local endpoint to at least the initial
destination address. In this case, no need to call mptcp_pm_nl_fullmesh()
which is there to recreate the subflows to reflect the new value of the
fullmesh attribute.

Similarly, there is then no need to iterate over all connections to do
nothing, if only the 'fullmesh' flag has been changed, and the endpoint
doesn't have the 'subflow' one. So stop early when dealing with this
specific case.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
v2:
  - clarify the modifications: new comment and updated description (Mat)
---
 net/mptcp/pm_netlink.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ff1e5695dc1db5e32d5f45bef7cf22e43aea0ef1..1a0695e087af02347678b9b6914d303554bcf1f3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1923,11 +1923,16 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
 }
 
 static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
-			       u8 bkup, u8 changed)
+			       u8 flags, u8 changed)
 {
+	u8 is_subflow = !!(flags & MPTCP_PM_ADDR_FLAG_SUBFLOW);
+	u8 bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
+	if (changed == MPTCP_PM_ADDR_FLAG_FULLMESH && !is_subflow)
+		return;
+
 	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 		struct sock *sk = (struct sock *)msk;
 
@@ -1937,7 +1942,8 @@ static void mptcp_nl_set_flags(struct net *net, struct mptcp_addr_info *addr,
 		lock_sock(sk);
 		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
 			mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
-		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
+		/* Subflows will only be recreated if the SUBFLOW flag is set */
+		if (is_subflow && (changed & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			mptcp_pm_nl_fullmesh(msk, addr);
 		release_sock(sk);
 
@@ -1959,7 +1965,6 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	struct mptcp_pm_addr_entry *entry;
 	struct pm_nl_pernet *pernet;
 	u8 lookup_by_id = 0;
-	u8 bkup = 0;
 
 	pernet = pm_nl_get_pernet(net);
 
@@ -1972,9 +1977,6 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 		}
 	}
 
-	if (local->flags & MPTCP_PM_ADDR_FLAG_BACKUP)
-		bkup = 1;
-
 	spin_lock_bh(&pernet->lock);
 	entry = lookup_by_id ? __lookup_addr_by_id(pernet, local->addr.id) :
 			       __lookup_addr(pernet, &local->addr);
@@ -1996,7 +1998,7 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 	*local = *entry;
 	spin_unlock_bh(&pernet->lock);
 
-	mptcp_nl_set_flags(net, &local->addr, bkup, changed);
+	mptcp_nl_set_flags(net, &local->addr, entry->flags, changed);
 	return 0;
 }
 

-- 
2.47.1

