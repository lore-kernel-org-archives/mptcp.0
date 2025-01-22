Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2493212B0F
	for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547803; cv=none; b=QszQYz3uJZ5zi+NTk8aZhxGwHNTtVhfNQ0ly1wFfoBv0qyS2YT4w8fW7mXcuJg9DTNYIW9YWbkTOCKejEoP6QqEpbmabsZ+py4L48pilMAB5PmKUKjIARKV1bIOT2aJF7FgmDX47CkmTQ0zO1qlALrPKkkkXaOc+NGhZFGaHABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547803; c=relaxed/simple;
	bh=hzUdkybC8xmAw8WkDQfPYEA1YRrdsrbhJoa4h+2afz0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PjVFaD5EkXX/qz7ZdF/XiaGZC0mHAt6N1iichnBn13/klly5iCe6eDx1dg6EpAjnZHb5Uzou4cO0RfSami7vgnfP1jzOdvHNKWy7fNY+AskF9s5tuPcdruuFlhnwPJE1eJpestR5ANiy58w51rsGVMdnYsnFYCQYEwLV8+P2OXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn4IKCzl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn4IKCzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA77C4CED6;
	Wed, 22 Jan 2025 12:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737547803;
	bh=hzUdkybC8xmAw8WkDQfPYEA1YRrdsrbhJoa4h+2afz0=;
	h=From:Subject:Date:To:Cc:From;
	b=Nn4IKCzl5mUai1/wZ0tsHPDK3HnYKFyuIi1fY3DuMw34RFEGzF4pdVKEEUjN0jpKs
	 vGEzfICjrCdRPUOUff2e7hSFRFOLM/ORk6fV+USaiHAgQKHFKX5cFGTqF5cozEABye
	 /DgcezyjUXZZxc4LY9tseWnIVBYUpFWMOQoL1bby4QLvjz3yZLeyQR5aozK1qTxGf5
	 nsZQw6FuMHDSDkmSqxJowElnDAsADLhEKJTFS37jHYoI2i+SWCB1EfYiG/Zn6yqA62
	 z+wQlX7N8HWSpBVIunzhgT7cAoRo/wAA2dUI3XhqI8xDkxwu9cZQXcMkrdPphesyNK
	 MWeeN0QZ7dWNA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/2] mptcp: blackhole: sysctl SYN retrans +
 fix conditions
Date: Wed, 22 Jan 2025 13:09:47 +0100
Message-Id: <20250122-mpc-no-blackhole-v2-0-13e6670d512f@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAvgkGcC/3WNQQ6DIBREr2L+ur8BFBu76j0aF4hfJSoQIKSN8
 e4l7rt8mZk3B0QKhiI8qwMCZRONswXErQK9KDsTmrEwCCYk47zB3Wu0DodN6XVxG6EUrWo5KVb
 XDZSZDzSZz6V8w+6T9mgpQV+ixcTkwvc6y/wq/Pdmjgy7rhlGoWr5mIbXSsHSdndhhv48zx/5K
 aqYvAAAAA==
X-Change-ID: 20250114-mpc-no-blackhole-526a61ea0334
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2697; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hzUdkybC8xmAw8WkDQfPYEA1YRrdsrbhJoa4h+2afz0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnkOAaU6ACIrCWg53bRHhFSfSwU5aIiijfyZ868
 FJVyz/omm+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ5DgGgAKCRD2t4JPQmmg
 cxAHD/98xZew2SgSwqdNi0V9Xk0yUl28sWNMqIA3/VcEhTPI2UwnnhpP4nmUPftNdMgJPgthiGz
 6Ff9V/L5c6U0pb0oFu3Rn7jTcw5YlW048m7KqhTi5XsWeYju/dxscjO3pA3wQhFEqoSZcoljTUl
 HhfUBer5LWxt0bbjIr7PDxWW3DK7mtmIwpgJur41QQstL3jCNUT75OSpp29vWK8LKGNDQxE+IIj
 4vqZJXnyWDUx8B9y82c0yvAylHmbkH+9cHdVh1wC/Jgt+9fxEAAVZwe1ii4NQhvoL83JH1d7+XF
 Iic45ro8w6D0MftinPfvCUmcS59tkLN3gWMMNUvIcy7sApjbjkZ5ROD9jdueFmCiGYfonGIzmiS
 I90c17VRdzgp24Qx0r6c/s9g64v8DJZVkLLt1uAoeDjGqAif2dKtveqqGOXLKnHb70uMOAd0MXN
 PehLh2qlno9H93i4Be2RH4KcJ55n3aP11aEvWz9PbGbKJAx8iBx5fVYvC5+G+npj/D150dR8rru
 Nj51mtn1blPUqHW6EU0svzyjtiR+m+YPMBIrRtvT9mtKU22azqIvj9FzDPczbheAuc8kq6HpZZJ
 o6bkOjBbAAC2oKS5lKKAmDlm9Ko4Zl7pczlfYFQwoJY8f/NmYVwE/WbiTp1i28hNJr9yIpLQ5Jm
 I2SkGZ09TXkkONw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, I found a network having weird behaviours with MPTCP packets:

- The first connection to a server had a successful 3WHS, then MPTCP
  options got stripped off.

- The next one had the first SYN (with or without MPTCP) and 5
  retransmissions dropped, before being apparently intercepted and
  proxied to the end server.

- (The next ones were sometimes intercepted, sometimes not, or dropped
   at the beginning. I'm trying to find out which kind of "optimiser" is
   causing this.)

The result of this was a blackhole being "wrongly" detected, and no ways
to force connections with quite a few SYN drops to finally use MPTCP at
the end.

In this series, we have:

- A small fix for the doc. (applied)

- A new sysctl to change the number of SYN retransmitted with MPTCP
  options before falling back to TCP. The modification looks simple
  enough to still be sent to netdev before the closure I think. (applied)

- A fix to only turn on the blackhole protection only when the first SYN
  retransmitted without MPTCP option is accepted, instead of any after.
  The blackhole feature was supposed to do that from the beginning, but
  a check was wrongly placed. I think we should consider this as a fix,
  even if there are also risks of not detecting a blackhole if the first
  SYN retransmitted without MPTCP is dropped by accident. But that seems
  more unlikely for an "MPTCP firewall blackhole", and I guess not all
  future MPTCP connections will behave exactly like that. It sounds then
  safer to reduce the possibilities of enabling the blackhole protection
  by accident, and apply this patch.

- A small cleanup to exit early.

Please note that patches 1 and 2 have already been applied in our tree.
So this version only has patches 3 and 4. Patch 3 is a fix, maybe not
patch 4, but it might be easier to squash patch 3 and 4 and send it as a
fix to -net.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Previous patches 1 & 2 have been applied.
- Patch 1 (ex 3) has not been modified.
- Patch 2 has been added, it can be squashed to the previous one.
- Link to v1: https://lore.kernel.org/r/20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org

---
Matthieu Baerts (NGI0) (2):
      mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted
      mptcp: blackhole: avoid checking the state twice

 net/mptcp/ctrl.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)
---
base-commit: a9a670c7f9f94ac66e6a79ecb81e4e7a6e20f001
change-id: 20250114-mpc-no-blackhole-526a61ea0334

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

