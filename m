Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC87171640
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676973; cv=none; b=m2+mJ7QCz+iq6irx1s860CFge/SY7dbrcgmO57Ee3lJol3coluQ7Tp5oIUqaWRt3M4ZhDi8v0mILSRxVRTWUew6E8h33Xknzqm3L7kGk5slwi8Qw57iMWZJZxPREWJ02wjLMLHm1mKo24YhYc7ohBN6o7EUp0c/oTu+LamOWwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676973; c=relaxed/simple;
	bh=TWpomIPCHdgqln4Z9R1XvaM1nsH19QkgyOXDZ5F+sDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U16JOupd96Ca4ccjieUuC7S4ZxyuVEvQ3oXwpDkPS9BtgaPuDLQPu4rkh6rf2eiNIyU5xcGY0RDL5vwirBCtimJ5W+YiMAVA8ZOkORctMW60oHPq65YpmWbvvM/ewuvNo0ERJPbvN+FOB1zk3nLAT0uElS0V+2s1/LfPHpC1J5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoGSD3I7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoGSD3I7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881FCC116B1;
	Mon, 22 Jul 2024 19:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676973;
	bh=TWpomIPCHdgqln4Z9R1XvaM1nsH19QkgyOXDZ5F+sDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MoGSD3I7v5ECR0nPGiN+Z/BBdLklrbLhAocIhYZz6OQcTpDWQeeRyCQMUF53k2pAy
	 KzCUZuIzvQYtirPSJSbRdBwB01YJMtLTI/RRaVG9oJrCSr4ra31OckrYe/TGsuXiWQ
	 mPITh7F9mlj1P7F7XErbpOCbCcG5EUvzSU8axUbgLVZU+LzslLeRZah9H7/18eSBX/
	 3Mf5BDJlM6MSOXTI9tP9R3J2UYmLu3aNios5Nr9nTR4FPsW0eZPXgjZVi64ak4z2C7
	 zDiUds6eM4WAYI7lh14LJEog/jLa7LDV7TPnNXvvKzVZ8ZRPqPCawP3soY/JhzrimO
	 mjlprn/HVDhew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:56 +0200
Subject: [PATCH mptcp-net v4 18/23] mptcp: pm: only in-kernel cannot have
 entries with ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-18-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1493; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=TWpomIPCHdgqln4Z9R1XvaM1nsH19QkgyOXDZ5F+sDQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSX7E6f4BXtyBWbZFG2Nd40NFDu0Cy2HlowO
 bQP1GduY7eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lwAKCRD2t4JPQmmg
 c555D/9ZZD0fBRw+TQtyoUdMZlUjQ/vFEy7epHnbVS8MAfGrJzKJtazZraPQB9UXQ0qv58IDF14
 hIpQIO46s6xrz/G5cjNHFNPRFuzVrZKM6jAtqsmFTaBQZ84sdhHEK3L623ujnyY/8meXuza/xkj
 kJsoCJHklkPRA+p1nDN8DVo+mHekuEEBX5tK0St+/BrBdlcpmuTqu0BCvihsn1WQgGrM3m3iDvc
 sEoUyWnzLywT/LfSEZMqCOBZvj2Rsz3wd826lJ4xtIdlQUgMf1XUtjOuZhEBiTMe0KNoLdCjIja
 1uVCoEPvx3DVjIDcHuyRB4Co3UI4CsQUqLAXvry3p/UcEnUuZsWH52LEUwpYbCJgdivDnhCH6T9
 g3IrB3EHDL/HljeRubTYSp+HPUXIDgQYDGC0lnxUcLAzF5tgA25EgNK02eS+k5ytOS4oINkIpin
 NT0yeSBRVAHH6TNRoqbHY9SF2r9ezayzS6I8NPffPNKAT1mcfX+HsWcl8YWnZe0cKPj15GojMN1
 q/zvtmPcSqxEgg7G79c1Lm6X6avm6obRhivWd/jKyvN0yZQl8CwlZNhQNj0AyDcKy9Pf5vFvQPG
 /cAkP2g2QHG/mnOMdFYW0/B408BCShlgTv6HCkXE0IL1dhu36xXGfOCrsp2D5bW+XjyVLq8RI0z
 0386cYxalRlud4A==
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
index 1f1b2617d0f5..ddad51210971 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -422,9 +422,6 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	*flags = 0;
 	*ifindex = 0;
 
-	if (!id)
-		return 0;
-
 	if (mptcp_pm_is_userspace(msk))
 		return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b6086e9c7fc8..ec23bb32862f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1378,6 +1378,10 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
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

