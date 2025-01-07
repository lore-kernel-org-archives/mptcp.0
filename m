Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306518B463
	for <mptcp@lists.linux.dev>; Tue,  7 Jan 2025 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269791; cv=none; b=CJ7bo1xaO5cFHMpNBMidWVqG7T/IO0ECyNnxMhDaW6tWNpf5vH47wPlIyk5PM3pXjq0w4wIsfF0k+9F4wci/uOS53t8YZAHT/AwiPWs+Z1vFeYJuQrupDg3ODfMcb2NhuNzK70qyQjn7ioQfhzPkw8Mr4kEkV31xGEGdR4G+3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269791; c=relaxed/simple;
	bh=CVAOuun7mDL73b5my95jCYGy0JCOjOS9TvwRp02LlBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HykNVAMUB0tNFMz156oFxTw+45ie42CvookyKoAXqpYouz5bf3IlysA0ajfbVSXJeE+krRZnRrNcSiTThR8VQCDK9fqXeD7u74okRr4KqEvQ3NecJ8qww0cZ4LQqE/ON6mwDBbt/qlBHK5vlUfc0bHnYaWAZGjCGHet1phtc/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTJ6vugv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTJ6vugv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2B4C4CEDE;
	Tue,  7 Jan 2025 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736269790;
	bh=CVAOuun7mDL73b5my95jCYGy0JCOjOS9TvwRp02LlBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HTJ6vugvCk9OVSVt+kbDhgSDZHZCUbH3F7hsQ6o6tksNCtyioCdWhUNOEYCQ1B2o0
	 Sc3eGaQQBj1Ml+uMJh3TZSlq3+wtUbdr5bRt0+SdsWY+/jRzKtKSc6CZYFcrJv29xr
	 vdVWyBw3ukOHb/dBIIHvdQTN8wMnhjfTgP/o294Zr0IKwMueiuO4cM8XYIJI43C0dz
	 LJCiqOxTUh94QswO2evCTxV7cejdQVvL/FnuZpnecelxCoMbwwt6rmdNYcZnNx8BcJ
	 VZlgxxxGUa71r8M08a6fc07y/P2VqQ9kuA9K8iI/fcwr3BxjBLTOBBuZvuBC75KwtU
	 n6yf0DHc2LcOw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 Jan 2025 18:09:27 +0100
Subject: [PATCH mptcp-net 3/9] mptcp: sysctl: blackhole timeout: avoid
 using current->nsproxy
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-mptcp-sysfs-netns-v1-3-2fa7075d9970@kernel.org>
References: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
In-Reply-To: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CVAOuun7mDL73b5my95jCYGy0JCOjOS9TvwRp02LlBg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfV/akjtd1XMliggbob0/tleh/S3SjqxWmJWHM
 pmRE8Ug5dOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ31f2gAKCRD2t4JPQmmg
 c3XrD/9ThlkCL+NqYrU1zKquQCb5JxSRMQvxirzAOiW00iOWiNb6Rg77oUw7N8IrojORl+MOWQA
 hNKAfNiyn23qaYgZ8e0uu3Ilv13jBTh29ClLqwbQZgbLGuoUApZEkEoPHKQ6wn6f9aYBO1u/KTX
 FrsLtPOBd9huOXWp5nqCbt+/B4VfDu5nmgHDn3/EeZxVLfhLHyrJOVhvomZMd8XfK1RsVbFXYqm
 Uik1pFST1UwlgqeJ/4h5aaJOelyj6vuWG8wrHKwyDk8uQK6pe7p0BgbGrWCJ5OTvoagtLcxJvDT
 QkURY2frLOlQLZdhxJ7ah11rI4QHE0vtB9jWhbNVlv+yjQjZmm+YVo/MfsLNONX/EymH7hoXkl8
 85cMv49VFEToe4dRTllPikdU3F+OzgGYl3wqraDaKI0Ls6PA8Tpbxyh50idQdFlWouKwNns8glg
 QXY8NPnIq+gCQXDKjATduLcRCJ32+JrjppErAKmPy791RM0rdpeXiHSZW8FFGtbHgs9FlefM8Vc
 4hhhOpGrFU1BS+UTNxJ7iLYZxKd1CoR8anG4fEda5juHTIKcBVnulHisi9Pd+hGzUyZGYfTrwyG
 vhT0K6jEVyfhizsCPUp/nlOULLV4Ss+m7PDsCjsi1enKX6fyyIRkAuGc3peKnnXd9WgUcrz3NUn
 RaehWJI8inY+QsQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in the previous commit, using the 'net' structure via
'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The 'pernet' structure can be obtained from the table->data using
container_of().

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 81c30aa02196d69c55799e5963f6591e416c8831..b0dd008e2114bce65ee3906bbdc19a5a4316cefa 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -160,7 +160,9 @@ static int proc_blackhole_detect_timeout(const struct ctl_table *table,
 					 int write, void *buffer, size_t *lenp,
 					 loff_t *ppos)
 {
-	struct mptcp_pernet *pernet = mptcp_get_pernet(current->nsproxy->net_ns);
+	struct mptcp_pernet *pernet = container_of(table->data,
+						   struct mptcp_pernet,
+						   blackhole_timeout);
 	int ret;
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);

-- 
2.47.1

