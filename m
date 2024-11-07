Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69019CC36
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970599; cv=none; b=QAsCJ4mQgB+I8etrdKafokuAdf6xylRUnk5BC55pVmDALsH8qJ+qWI3oWFQ25N4gusPpKwnDmCBjomkDPFERfztT1QnnqwBXVfl/rYQj5mE2R2e/FfjsIjd1Ib+s0tJ1b0/y1B4LX+20QoRrID5TpEPZPfz8zOdjT796Bi2h4b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970599; c=relaxed/simple;
	bh=/VF77SAF39byCwbOD5hNvJqh/yxw5otX1wXH/nRl954=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gbht1+Z3GBsg3imAlOEOhPKFxxJRWBBPxwgb6NqagL7mTZ+FQZrTQBsCcOqGuK1D0ZESM/NFYOWCxvixQbyzV7L8dZ2/pqJsSeyov0SOMW5QCTfSOollMeM5lHUzRbXHVab/05dYaevMfRLv5YqPbLm56vGeae3vX2MhHlqN0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eub9zIQD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eub9zIQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F418BC4CED0;
	Thu,  7 Nov 2024 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730970598;
	bh=/VF77SAF39byCwbOD5hNvJqh/yxw5otX1wXH/nRl954=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Eub9zIQDtlt1xjTNouymtHr3N5e0hkyz6V3Zlz6XgcrvT18RYcuotBD8OZWBxsDBg
	 R4fL6WjEe0H/bynFQeOQShh0B8CeKQqkVOqFwqeS4UCeFebgNa3s2mcLXEUded7xdV
	 oTRyxIrMEZssmPRJZ1Y5pk0GVnbmn99cbt8t4QIJgZGjJebRsd1/3WKhQwynSWv4Cl
	 b+7+qQOQks7eI+uo0W+YD/Ya0b/mtlNwZAzkHr7cTprUkZ+pMgFq0r9c5ElqBIJezo
	 uMsAcA/qQpZvFjH0zRwPFeIW9KHc6EyrUbGmPeAQq6J7KLXFdIsF0izTBi2BgBBcqc
	 khgfYF9jyxNAg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 07 Nov 2024 10:04:14 +0100
Subject: [PATCH mptcp-net v3 1/3] mptcp: pm: use _rcu variant under
 rcu_read_lock
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-mptcp-pm-lookup_addr_rcu-v3-1-3c458d025de4@kernel.org>
References: <20241107-mptcp-pm-lookup_addr_rcu-v3-0-3c458d025de4@kernel.org>
In-Reply-To: <20241107-mptcp-pm-lookup_addr_rcu-v3-0-3c458d025de4@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/VF77SAF39byCwbOD5hNvJqh/yxw5otX1wXH/nRl954=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnLIPj4R8dmCaKkOYhqMeiwxhhEAcGZ1nn4E8nV
 pnDR0Szb2KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZyyD4wAKCRD2t4JPQmmg
 cyJKD/4jam6LCrRBbVJSDg5DCnzaHvFUrozDN2wOHUDtZmWAaSrkwoouCibXKd/NuRqooQU++sa
 4vYeMdVXhVzfvBnycQwLi+Ldu3WEMO+5MwgGhsd7ibtT1GrDubLxb4GQX5C432evjnMikxm2D4U
 Vg21I339jib2jlMESNZrkcLIvZBxgjR8WKgVC9ssBMCGViFmOyMEh+EXko8u24gfkhkBCI8EHSK
 JWDdhX4YDJ0e2t1zBBgCun+Rngmi1YT6JGsii8pAzRPJ8lS+0PKuDY5e7x0EeSbraCSzSY/SbxJ
 7Par8z4xhR1kVYxCqwI9HWe5+TmJgoCvmK0C4n6ZmafnSi2iVQGJMt/QnrbypkNu3kMVbdpb9jX
 e+OdCdliMZAlnw/YfgUkNR4MQKcTpUHiHrQ88/HREfb+WQfsMs8YfQHvADBi6Jyidy4z7pKdt9c
 O57b1UD7oy/RuN3EgziqbALdQ6BTWzoAnW1NvEpG3MfamnwU/idZQenYlRkB+G/FAUQ+TTqhAZR
 REF+bBGoNApyE+MrGncN6/CNQMwt4YfRfC/VmGlxAtGT9SlD6Aa5OXIW+UWR5k9NQx4CQtveGBe
 O5LEUxvkx5LMdpsE+fWg/E8QRtv/Ze/pdK5cwv0Le8NOUUYmeGgy3zUM4O1BgSOhu4tYEFTDN+X
 BAZE1gn+qvpfUZw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In mptcp_pm_create_subflow_or_signal_addr(), rcu_read_(un)lock() are
used as expected to iterate over the list of local addresses, but
list_for_each_entry() was used instead of list_for_each_entry_rcu() in
__lookup_addr(). It is important to use this variant which adds the
required READ_ONCE() (and diagnostic checks if enabled).

Because __lookup_addr() is also used in mptcp_pm_nl_set_flags() where it
is called under the pernet->lock and not rcu_read_lock(), an extra
condition is then passed to help the diagnostic checks making sure
either the associated spin lock or the RCU lock is held.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v3:
- Use list_for_each_entry_rcu() with lockdep_is_held().
- Update commit message accordingly.
---
 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 618289aac0ab7f558d55d8b2ebb00dc62fc72f88..758a0dbfcf78e545d840c0b580c0b12bd042d7a4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -524,7 +524,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+				lockdep_is_held(&pernet->lock)) {
 		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}

-- 
2.45.2

