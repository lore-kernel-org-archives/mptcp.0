Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81DB1885BB
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105533; cv=none; b=eo0qxohJ0TgbdBeN3wY++WErExaISmMvjk6WYhh9Cdg2mdNDGuMssRaGscmIIkZhmgyx+qzXG2xGJ7dLTAoLHehPpLTJ4PUVQpeb4rvAspCxhUU/CfOq7JZzhYTm5i3hF/LUeci2TI00z6CA0IHQXbrinhNIHF3q2GrQUgmtGdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105533; c=relaxed/simple;
	bh=OZKcmeDLyP0nIVHrCZJr9ZjIACqXrKoLzQwXKIQRgfU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jy0wJvfKwzd3dC1997vIdWZ+V08K5TlsZRNfJ03P8xdy2SsU/PiA7PM1WBrFiddbfJ0mYiOftXNJyLTup3VplI/6HRExjfzA7bjGFjjmXnJtJeXN8hJH7Br4iVa54eVzDlihSuex4YDYVszPlbD6kl2uQj0gGRl9+ouw8h89uR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxibRuO7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxibRuO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9CEC4CEC5;
	Wed, 16 Oct 2024 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729105533;
	bh=OZKcmeDLyP0nIVHrCZJr9ZjIACqXrKoLzQwXKIQRgfU=;
	h=From:Subject:Date:To:Cc:From;
	b=JxibRuO7jW5Ujd65/xd80j3TE0c5OTuNCQHD3PM/e4xmdKDp+Bk/Uxlo0qAq2rdXv
	 7dP/RRacGhSO17gdz+SgKdd+0ZfRrzW3CBb//2ewOt2JkzG+Ds2w1ca02fW8h/kiOo
	 wj1mbYALNJ4wddP2vwdXEZPE8BIQuPSxHlFfSbBZ8LsL8MSFwwVyYjDZ7gCw/DkhR2
	 YPMwcxza9v+e0ySw9WXdLe/c/jcmF+OGNrF6LtUIet8bC/duUc8vzD3LFvMzovvmD/
	 w5ce7FJGFuw86yjWa+o7glFKhtIJoqZGyJIGuBN+lhNo/mdKlm37bQNFu76GHp28GJ
	 wBU+7C1U/CsmQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/2] mptcp: "fix suspicious RCU usage" warnings
Date: Wed, 16 Oct 2024 21:05:18 +0200
Message-Id: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG4OEGcC/yXMQQqAIBBA0avErBvIlMCuEi1inGoWmWhFIN09q
 eVfvJ8hcRRO0FcZIl+SZPclVF0BrZNfGMWVhrZpjWpUh1s4KGCilR3O4h1GOrEzllhra7U2UGi
 IPMv9bQf4hecDxud5AX44iOtxAAAA
X-Change-ID: 20241016-mptcp-sched-find-rcu-649ce3399334
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=808; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OZKcmeDLyP0nIVHrCZJr9ZjIACqXrKoLzQwXKIQRgfU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEA57CzOMqgQMA9ULWHI2rABhhcASfOhzo+sRy
 SEcrp3kZICJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxAOewAKCRD2t4JPQmmg
 c4GvD/44iSE3GS3NXcTORp8Xhej4B5RUCELabYAAxqReyyYQrxdLjIYm2X1bZElSULgtu5Ps8mn
 w27JqEumzXtt0xK3JopB3q/IAvuGNgM6xOZaZNTcyuolknio7ViarJvzuuBCumjlQdx68JqAQjz
 bWZhccyWtNconizIAnq8tPH/hNoNjHswKHmXb60F5EtugqdcrngmSN9XQ/IH+/trvcKNI8I5fm9
 TG7W7pChdwtNzsRCG5qTpsVak4WM8ou4U5B9H5zx2UX1oPmPkEe13vH+Lgk/lXDp8QbSevX67BH
 TW5M9uCEEhx+p5p+wRZOlYSQEsdAvVHGxAbA2yxaXmBk0vQgII7AE3CnqChGfR/cXNBUfihg8pq
 2ONPRN9vk9ChA4mblXVoIkdpwjr1PwscGtoRz5PzIWUOrsVC5BCB/Rh4RfjzmW0pziKAmZqLjKn
 0lOZyeuFx7c5EZVjOkbz8dGsBiCZ5U1cer1JmwO1Nvh95cQOnAlDnk+x7hbZhjupM7sWhfeHx5N
 iM3hdEgewPkBkMukHzWrJgocj0MEiprGwUOOlusULgx3Q083Ctq+7HbvAtWNbWbzFQVtQnSyS9K
 ZgbqHoBJLir9cFi6KoIhOEXvimcnxcp52SWYfOQoVPGjVrfp0uVoYVceQbMu3fwQ9QVP73GOyjc
 V3QoONwONuwJ2BQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Enabling PROVE_RCU_LIST (and RCU_EXPERT) shows list_for_each_entry_rcu()
from mptcp_sched_find() not being used with RCU read lock held.

The first patch is a fix for -net. The other one is for a commit that is
only in our tree.

Link: https://lore.kernel.org/20241016011144.3058445-1-kuba@kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      mptcp: init: protect sched with rcu_read_lock
      Squash to "bpf: Add bpf_mptcp_sched_ops"

 net/mptcp/bpf.c      | 10 +++++++---
 net/mptcp/protocol.c |  2 ++
 2 files changed, 9 insertions(+), 3 deletions(-)
---
base-commit: baccd7675477b1db387aa71b48c3312b5fb67a5d
change-id: 20241016-mptcp-sched-find-rcu-649ce3399334

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

