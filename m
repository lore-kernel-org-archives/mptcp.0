Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF019CC36
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970598; cv=none; b=nrNjgXE2uEtJpveebvoeSR3G+gogN9XWxvmKNhpWD3SW1nFtt1GMC46f/YPizVuaSvJA5HAyBDAB4MEphkAIfTQjLVa+3OR859xJHOQWlguwiWll362iSWT4syM+xP4JtAAfHIKieEJB8EKFiLkMchM4ikSBqG9SiUT9wgF4c18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970598; c=relaxed/simple;
	bh=DmVFr49oNSbLFDYhpHCKvKTOzPdbkCtkudyOpzz3lMA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P/tpH71cG03NzRC40mB3nzi2NLFnVJAeoS82f5A2yfcNmSDZte5+fEzvqLfwoqbRZWrDzUpkHRHhlpkNp4OTvmSHYjSe/4ZDkCdOFewy8rSEvnwFYxny6HN7h591faRFAVa8Te5o/GOugVt/8QMHRwObape9OXoVzLR9D1qo4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmTV+tgg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmTV+tgg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E170C4CECC;
	Thu,  7 Nov 2024 09:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730970597;
	bh=DmVFr49oNSbLFDYhpHCKvKTOzPdbkCtkudyOpzz3lMA=;
	h=From:Subject:Date:To:Cc:From;
	b=BmTV+tggVxR/ppj+0RH/lACHT8jkOF494tD8ZgezzMCguaXPecUkFEyoXP5dEJgVo
	 JILCzi2KSFzxoyeup+5etKeZ0iRMG2sKwIrKLFjNgAI0HNNzkXS5uuVoww7Ce8fEvN
	 dYlfdH98jYkdrknaUxNn4r+Hcb7hazB47PKmevBq7oSkdzH/ERRVfKaKEgJda/YnDb
	 ESjh4RKsiWhVViU+QNb5KWVXDbhK0Ad2OvySt/zF5GqEOsDdNmKFH7GOfNvvQtmMII
	 2BmPhMd1M3eNWNrr8w56z8atYPsTsA42ImCBcHF01HNhBQz8MK+tRBau708G0/Rmds
	 Qjaw52EoFsErg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v3 0/3] mptcp: pm: use _rcu variant under
 rcu_read_lock
Date: Thu, 07 Nov 2024 10:04:13 +0100
Message-Id: <20241107-mptcp-pm-lookup_addr_rcu-v3-0-3c458d025de4@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI2CLGcC/4XNTQ6CMBAF4KuQrq1pBwroynsYQ7AdoAHapvxEQ
 7i7Td3oRjOrl5n3zUYm9Bonck424nHVk7YmhPSQENnVpkWqVcgEGGScAdDRzdJRN9LB2n5xVa2
 Ur7xcKONlmmJ9ElwIEurOY6Mfkb6Sd8vgTG5h1elptv4Zn648Hvz3V07DnFQmGshlWcClR29wO
 FrfRnWFT0n8kIAyyrOibHKZ3YGJL2nf9xcIZCegFgEAAA==
X-Change-ID: 20241022-mptcp-pm-lookup_addr_rcu-01833ea95155
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DmVFr49oNSbLFDYhpHCKvKTOzPdbkCtkudyOpzz3lMA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnLIPj0z5FghUY3kxu7HsHvUhyU2QdTLpoSouLm
 rhDLKTl3VaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZyyD4wAKCRD2t4JPQmmg
 c40CEADXa39gULAo7ebuGdEkCRtHCfxr9oPp7JTV1bga+hUkbnrCaFUI6B9nGELjRxEW+/No3uE
 5nL/6cDtdOH4t8A/QKkBMm1WJ3gBYpIGVgeMiTLsIj/1Fle8Ddz1Gtim7ObKCnwpdADtd8hq7Hk
 iIIYoO/a0Lqdn06vQdpdY7U319at0BEaAjHXdzIGNvZ00VN9fE7tEkfdRSC2RqBRVE3J3xNxo3m
 r7B14180g9vCG3rwR7Fw5X6V+JAOyoMYTDicTO0fKof5pYneY8wbtaUKt3trdR3rlB6vP7EvBd6
 VzQlrPL6FIsnUoSgf7/+A+6UFc1rFslIqTOPWRBcixFuxgxKN216Mj5ujXv38fmVSBnZnUzW76E
 jY9O/2ivVgMZOAR1x9tTPlti5foaqY7nuyXJcSjnGsw9jXKE4EDPcY8VuvqX7++SZt9VPFkiqIR
 YJ0kd0AGF8BMPwpFFmzNB2CKziSxvKyxCvtaND+VeG4GVCkwxbmYd1AhFNPGIngtDyY+XdlBlLA
 JXgWqoIduayrQJL3hfUvwhaNdbSaHBB7Gev2PA/Wr2u11STWBHVHlSZbikXk+GpNoxNOm0FJ6Zs
 ++NJwFBYOKmfb15yfy5vStZ07LMqv6fnYcmeASfydQSRL6zSHbzJLbXOegF7ReXQ9JH0DncFpLc
 VkjCPfSzME3Qdkw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When looking at something else, I noticed that the local endpoint
entries list was iterated under rcu_read_lock, but using
list_for_each_entry() instead of the _rcu variant. That's what patch 1
is fixing.

At the previous meeting, Mat and Christoph mentioned we could use the
RCU variant elsewhere. That's what is done in patch 2, for -next then.

Patch 3 is a simple change to remove duplicated code.

Note: I see that we are using spin_lock_bh(), but the RCU read "locks"
are always used without the _bh() variant. Is that OK here, or did we
miss something?

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- Use list_for_each_entry_rcu() with a 4th parameter: lockdep_is_held()
- See individual changelog in the different patches.
- Link to v2: https://lore.kernel.org/r/20241025-mptcp-pm-lookup_addr_rcu-v2-0-1478f6c4b205@kernel.org

Changes in v2:
- Add patch 2 and 3
- Patch 1: avoid > 80 chars per line in __lookup_addr_rcu() + update
  commit message.
- Link to v1: https://lore.kernel.org/r/20241022-mptcp-pm-lookup_addr_rcu-v1-1-19d45f26c872@kernel.org

---
Geliang Tang (1):
      mptcp: pm: avoid code duplication to lookup endp

Matthieu Baerts (NGI0) (2):
      mptcp: pm: use _rcu variant under rcu_read_lock
      mptcp: pm: lockless list traversal to dump endpoints

 net/mptcp/pm_netlink.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)
---
base-commit: ca26062fcd85c61922f543674c5dd0382e2059cd
change-id: 20241022-mptcp-pm-lookup_addr_rcu-01833ea95155

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

