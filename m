Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD4233136
	for <mptcp@lists.linux.dev>; Tue, 18 Feb 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877895; cv=none; b=TJrQBTAGQt5Bc4OszCDYaFlpEhbfeNssLSbgCv9diMMnDV7S09d+ZDWxCw5ncxW0z1kmx6G1Ld9M3gpAHwq7dR8YSQcWAhoDIqeOkSOoOLGUYABtdi3WHERzSBjUAVsRRxGeiNkz7rvgnkYoiDwHf8wk9zy5Ei9I0OFGpDy5+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877895; c=relaxed/simple;
	bh=NF1EPdZbYXNYxCRDhgFcjiF5i/x0aCdt/V38Strw6/U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hHJO6eGbUwpR34OCwLjgQ0/rXcgNkPknfnjn6ZKT6GsJyFHNCIHXY+2BUDjrcUrPFIomBoeDJy1NZ1+llDX0Dq+Tef4crOq7yDrUaqXELWz/F9XBedyNa0KZE57PnxC7Gne6qSTCPLbixt57nZkZ5Lc+X9LK7bMeq32OtdZKbJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lstSLxQk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lstSLxQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACE7C4CEE2;
	Tue, 18 Feb 2025 11:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739877893;
	bh=NF1EPdZbYXNYxCRDhgFcjiF5i/x0aCdt/V38Strw6/U=;
	h=From:Subject:Date:To:Cc:From;
	b=lstSLxQkpn4Nl00zAQHvk2gGF4T8zFnqXBFvBG3bRMjDq0d/XhNC8hWHqp+xjJM4R
	 vH+fMOi2HSfYDj9kKtQvRWCAIlodtQIZV2LVuvife6bxDUWOGB7N0tZYlWiGTF03Yv
	 LBUIN8C3ydXRSssl6r9S327Mu7Xhe0Pj05YyGSKShwtiQ+HqmmSk8JLwujr+B7jTKK
	 r/zuNsYpAbsNgbCnCRkjAxA5K6kQcbMVIin6mz/FH3dHiXtJFL5oSBy63Nt1onGC6O
	 INyxE/BM4AhK+E4UipsDEBbcNu8IQmWiR247qk4v6AZT6pd1rR7eFDs8dCTLXwIHzU
	 qYwzusmnK2d5w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/2] mptcp: reset when MPTCP opts are dropped
 after MPJ
Date: Tue, 18 Feb 2025 12:24:45 +0100
Message-Id: <20250218-mptcp-dss-drop-mpj-v2-0-0c6caa10ec52@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP1ttGcC/22NSw6DMAxEr4K8rqvE5SO64h4VC0oMpJ8kchBqh
 bh7I9h2+TQzb1aILJYjXLMVhBcbrXcJ6JRBP3VuZLQmMZCiQpEq8B3mPqCJEY34kPCB3BNVQ86
 mzgnSMAgP9rNLb3D0Hc/Qpmiycfby3e8WvRcOs67+mReNCk1ZaVPe604Xl+bJ4vh19jJCu23bD
 z3zJQ/AAAAA
X-Change-ID: 20250205-mptcp-dss-drop-mpj-ec227f4ed942
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@xpedite-tech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NF1EPdZbYXNYxCRDhgFcjiF5i/x0aCdt/V38Strw6/U=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBntG4Ed18qjnEjDvU6v+xmZE1dkuIjHmsLV5KZF
 SU2jO8/C4yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7RuBAAKCRD2t4JPQmmg
 cxp0D/4iEFkfgob3pCwZmzda7DlWSxY05+BsCWIxUtJhcpJ6tsFqbx1lVyFta0MSMEB1WmtnqtS
 wqinJ5VEKJ2JZQw6FD1OVLmO+18cyU8LUgjQxIXwVomF4EkY4k9qWYXRxkqhVevh1PM1yXdzot5
 TesUwd0jpCrDsNiRRDk3/eHxNdQi2G3IxL3ZgmCzl8jfVqVLZLQDWIiBZ+YcUl7BbWlZQ8Uixzj
 dypLgl7NlCEZrjqpzLWai2C8W8+MOZkxT4AKyEY0+xQfuJNyLAHFaBLUkucSnUwHHHxSvMkPVUj
 QM1o7duOVWI+SauTZu2Lch3zP1mmSWJGmiBviZ2V0LqbDw1T6kc/TBjpt+uc9p5eXLq0FwxwEJa
 NoZYWUjibduYZuuLkx9TRO0m73nhc7BogTJ1wGJl+O+cJYvxpnRG34pruD0rsznGBeWiuFYtDyf
 +9jyl3Tj95UsDdPI6Sa7nnZvXuf/hbbTqni6ZSrlHDIm+BJujcx+EMz7bMP9M6gDDI8aiPLZU7G
 5E7VZ0kgna0rHDScuNePUW349remGRDh2avsjMpZOj6Enb0f2afjko5+PKU5yUu89Yy4f8Fcknr
 dIjWOxMvQVGCCESrASDasWLJGwvhl+JsRyxRfaSM+N2WeJL9fcK1r7eJihfvXNS29R/A12JNhBL
 VxgRxM2ti/DFGTA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

- Patch 1: fix issue #544 where a middlebox drops MPTCP options after a
  3WHS on the additional subflow.

- Patch 2: a safety check is added when asking to do a fallback to do so
  only when allowed. If not, a new warning will be emitted.

Note that two new packetdrill tests have been added in a PR to cover
this case:

  https://github.com/multipath-tcp/packetdrill/pull/160

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Squashed previous patches 1 and 2 (Paolo).
- Patch 1: no more special cases for csum (handled before) and inf map
  (Paolo).
- Link to v1: https://lore.kernel.org/r/20250217-mptcp-dss-drop-mpj-v1-0-d671d6b9a153@kernel.org

---
Matthieu Baerts (NGI0) (2):
      mptcp: reset when MPTCP opts are dropped after join
      mptcp: safety check before fallback

 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 15 +--------------
 2 files changed, 3 insertions(+), 14 deletions(-)
---
base-commit: 3a7786db65e8f361a8fc8abcd3cfbe17411b8b7f
change-id: 20250205-mptcp-dss-drop-mpj-ec227f4ed942

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

