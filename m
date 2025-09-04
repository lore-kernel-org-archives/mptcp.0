Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D412D6612
	for <mptcp@lists.linux.dev>; Thu,  4 Sep 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985901; cv=none; b=MDcKl0DxwOjyvzyS2Yih8+FpxNKRJ1UJe0FmshrPKMKEODIWKIs53LdpgY8uNazYPBbV7Kcmo1qwaG3VdnsNJjCEWqh7FtMWegOhhcwAEx1UJX6oihbDNxK12TzSSnIOx2EcM/EVfBPvqU0MyrvMQY1r+p+kqi0dOtLmsNT+0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985901; c=relaxed/simple;
	bh=qxVwrMuIo7sF7Z1mFquMwAGTMi7NsC/Rkz46ZXL8rnA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sYfokMQFI0cQm1RSaYycMws8IQrzbGco43OfHvGwGyPu4cJJjy4r1s8gNOA0kGIrfSE+tESuWI4IDGhRGH8lWrgCKqpiNXoxPArUi9OChDuOvfhHk5Mnq832m+F6gXSDPxuBHJcCz0rZXv6XPBdt3VNb+9ihG6qwLYsUY1AqC0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pS/mciCS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS/mciCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E9DC4CEF1;
	Thu,  4 Sep 2025 11:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756985900;
	bh=qxVwrMuIo7sF7Z1mFquMwAGTMi7NsC/Rkz46ZXL8rnA=;
	h=From:Subject:Date:To:Cc:From;
	b=pS/mciCSe9668iIrnHQyF0I5XlUt1r9K2DxpP2GCWuEZAldyg4MPnnRFalnwNVhXm
	 bY0FAG90/ctsghUP8pBWbm0TC59YAjQ1n8A4yOcrwQRcgPeoXLxNh+ZFGW77Ji69z8
	 Pz0TilsCf/nL+G0CeHrNKQwbgI3l0T7tmND2pLhj+ZqakuWLft6LHUsfkk2LstOT7q
	 o1Y/Fn6MmG1o59t9ZKq8myoXgZ/BVV4Kq0RjLa4N9NtD0llLQzIglfr8i4p+maFy3o
	 mXzziVO5OuwbhKwMFFP5c0zaqGkTDXFvoSv1fwfBxM8J2jpSyYHmC7wmPFVnDqTWx2
	 UgWHBDR1TW5cQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 0/3] mptcp: fixes for adaptive ADD_ADDR
 retransmission timeout
Date: Thu, 04 Sep 2025 13:38:04 +0200
Message-Id: <20250904-sft-mptcp-join-add_addr-no-retrans-v2-0-a019e6678628@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABx6uWgC/5WNTQqDMBCFryKz7pQYjWBXvUeREs2o6U8SJkEs4
 t0b7Am6eIvH+/k2iMSWIlyKDZgWG6132chTAcOs3URoTfYghVSiFRLjmPAd0hDw4a1Dbcw9i9F
 5ZEqsXcSqVr0yfd2MeoB8FJhGux6QG/y2jtYEXc5mG5Pnz8FfyqPxD2opUWCrGl2VyjRa6euT2
 NHr7HmCbt/3L1zjS8bhAAAA
X-Change-ID: 20250902-sft-mptcp-join-add_addr-no-retrans-345b5db46fac
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qxVwrMuIo7sF7Z1mFquMwAGTMi7NsC/Rkz46ZXL8rnA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ2VqmbP3kw57lfnPaSJZtP5H3h6vx4JPr7Ts2O5euXq
 eu4s5wP6yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIiTBGhpMrItnb7CRO/Ws5
 sC9+s4rz1AvK72y2hN2IsM43z9zstJHhf/DxCpPDHYLcx/3O/RRv++MbaXxtpsC+TR+9nhoacMy
 4zgIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The recent patch "mptcp: make ADD_ADDR retransmission timeout adaptive"
seems causing some unstable tests, see the links below.

The modification in the selftest is reverted, and more tolerance is
added instead.

While at it, slow down some signalling tests.

Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/17391054770
Link: https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg/results/280241/1-mptcp-join-sh/stdout
Link: https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg/results/279881/1-mptcp-join-sh/stdout
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 2: tolerate more ADD_ADDR, except if no ADD_ADDR are expected.
- Add Geliang's RvB tags (thanks!)
- Link to v1: https://lore.kernel.org/r/20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org

---
Matthieu Baerts (NGI0) (3):
      Squash to "selftests: mptcp: remove add_addr_timeout settings"
      selftests: mptcp: join: tolerate more ADD_ADDR
      selftests: mptcp: join: allow more time to send ADD_ADDR

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 28 ++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)
---
base-commit: 8984ec428a58d1d82ba89db40e462ad1e8dd317e
change-id: 20250902-sft-mptcp-join-add_addr-no-retrans-345b5db46fac

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

