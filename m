Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43D2F5337;
	Fri,  7 Aug 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110636; cv=none; b=JW45kWIxjIUAGl2K2k1Ljyn8bf0JCxBTHl8YbUCLzIyFivvUotMSHbaDaroca5g3J/6gVofB2fOsm5+I4Px9Q56jKST6K+FZjOPiQI5Vn3IBUaV0tn+vcpDftgX/Xv4vkSb6t0QCN+b3IUyfNmdRJ9/C+zjNBMtYAVHlE+R0IYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110636; c=relaxed/simple;
	bh=FLk0G7duslb6LyR8oWVflOfVz1bEUiaFzEL1gnBd3aU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M5qstW1rkscc5WClQledhca2bGHEp/bOwn/zvrJyO7kC2NOoqGfw56MqHQBt2gHDq6IE5QE6cXGnPfC51s7RsDQfDuYHvbmruVEBLItfcPY4Dacq4b38m1jxbCMK7dYWYCEcPoZHHIx/P0gY0zwcklC7OZTmgokTn5nqcUoVbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fajom48d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fajom48d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2555D1F00A3E;
	Fri,  7 Aug 2026 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786110626;
	bh=27kReTIqIDVZ1zYA2K/pxnR3vMezeUuF6AAq7ItAXb8=;
	h=From:Subject:Date:To:Cc;
	b=Fajom48dAj+ywRKayYOXCpoNkCm0shmKVLxe1FyO2iiaknH7DfD9VIT+ORGChCUOL
	 mS+dXFiWuYBS3r2L5p+rAef+uPwMs0udGH2/OzkZqGThwAnNYFrMMvk7WGLBtu0zI/
	 M6DiVBfdzoKC7PZlfId1HUb3s2FPbBPoTdUnNTrK351HoF2bAktyuw6+Cqehkh9Ff2
	 Tmym9Ovlq/GV6O9FzN9uyF5tfhEYU1M4QWJK8Uyt6gtSToykdZuX/v4LSR2xhgpIvb
	 Ss27LbHl+nu78kLfgIQXNShkKwH9lavfuDoYtfitc5fXaxStZ8ZLz6gaD8zGXSup5y
	 5sai65bXC0fbA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next v3 0/7] mptcp: out-of-order queue pruning
Date: Fri, 07 Aug 2026 15:49:00 +0200
Message-Id: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43OSw6CMBAG4KuQrq3pi0pceQ/jAugA9dHWthAM4
 e4WjIlujItZTGb+b2ZCAbyGgPbZhDwMOmhrUsM3Gaq70rSAtUo9YoRJsmMCG4ipxohvLtYOW2v
 v2PneaNNiUeRSKkpUpQhKgvPQ6HHVj+gdRKfXJPTVGeq44Mtup0O0/rE+MtA18dfNgWKCc6WEg
 lryMheHC3gD16317XpqYB8Yp78xljAmCl5QKZqS0S9snucnbEO1/jABAAA=
X-Change-ID: 20260724-net-next-mptcp-oooq-pruning-48566d10dbd0
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2213; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FLk0G7duslb6LyR8oWVflOfVz1bEUiaFzEL1gnBd3aU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKH82cfHBuQGri9P2fQ554bpH8wHYoKIJB8zqn563Sq
 FuPZ7Z3dpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEyknZPhf22Vn5jBAfeO635p
 mx2V8o2WzTFs5ens4/H/yVj0+1jBdkaGaR0bGX1db7YrfFuT0eMvVjfJfkmhc4ir8tzz6d3/897
 xAgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Under memory pressure, a pruning of the MPTCP-level OoO queue might be
required as last resort, to avoid too long recoveries, or even stalls.
Geliang and Gang managed to reproduce this behaviour, and Paolo
improved the situation thanks to the following patches:

- Patches 1-3: improve the MPTCP-level retransmission schema to make
  recoveries from memory pressure/after MPTCP-level drop significantly
  faster.

- Patches 4-5: make the admission check way stricter for incoming
  packets exceeding the memory limits, with some exceptions for fallback
  sockets.

- Patches 6-7: implement OoO queue pruning for MPTCP.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- Address comments from Clashiko.
- Patches 2, 6: new
- Patch 3: many cleanups, needed after patch 2.
- Patch 4: check backlog and rcvbuf separately + do not drop rst
- Patch 7: prune only for new data + reorganize code to follow TCP
- Link to v2: https://patch.msgid.link/20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org

Changes in v2:
- Address comments from Clashiko.
- Patch 3: typo, comment, bump TCP MIB counter.
- Patch 5: uniform MIB counter name.
- Rebased.
- Link to v1: https://patch.msgid.link/20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org

---
Paolo Abeni (7):
      mptcp: move the retrans loop to a separate helper
      mptcp: move the stale logic out of retrans scheduler
      mptcp: let the retrans scheduler do its job
      mptcp: explicitly drop over memory limits
      mptcp: enforce hard limit on backlog flushing
      mptcp: avoid code duplication in __mptcp_move_skb()
      mptcp: implemented OoO queue pruning

 net/mptcp/mib.c      |   3 +
 net/mptcp/mib.h      |   3 +
 net/mptcp/options.c  |  32 +++++-
 net/mptcp/pm.c       |  41 +++++---
 net/mptcp/protocol.c | 290 ++++++++++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h |  11 +-
 6 files changed, 273 insertions(+), 107 deletions(-)
---
base-commit: 4fa4977a0d900f936bcae5cd2c510be5554e8dd6
change-id: 20260724-net-next-mptcp-oooq-pruning-48566d10dbd0

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

