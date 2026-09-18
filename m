Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128C517BB7;
	Fri, 18 Sep 2026 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756726; cv=none; b=tQS6SAJSd5QzVuTnEvPQTBAoeLE/xuwmlvNFr85dQWH45zqejhtaFDHY/RTB9QbjRaVoG4At1QpGtzXvGWLEFJ7hIqkgz5X0LN34Xvy8f4Hqhl/So1GWbQZXqukHe1OBT+u1248ApvC7MuNFeeiVYRBbcx5nr0tk633dlzZEGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756726; c=relaxed/simple;
	bh=ij0ZLOqV4a1NW73gHHs+zwV1KBHd/t0FJBBKKAs5pkY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iokHv8CwLfYSwJZi7SnpSTJNnpAIILPLjXMM0CmVwq8SB2qdwEDy76USi33YEMIrkjUSmxQ0lIiiTZtCfpFnlR5U3kcIrd8E9zCcYX3cWn5ZJPtWuiKYHd/OV77KUMfDR5jMYIZhvBDR6G9cgJbUH+Z72qz4XCv2znx2bksK6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owQs0ZMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owQs0ZMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AC21F000FF;
	Fri, 18 Sep 2026 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789756718;
	bh=biC+8SCAXKWW6NiMDcUaJ7XQBN7jv400DbE8wg+PFYI=;
	h=From:Subject:Date:To:Cc;
	b=owQs0ZMvbbQdREl0izVLnvsC9/nO61Jokthh9WdsAOb2OjfBA3VTrAGTxmcamEbgM
	 JKYrwd8heRB+yJCzADyufp3+Sk4cTMitjIrlitVatG81CFtkz68kXiCkLuTIS2SScI
	 Evx00jZjwbRrKqrmrDlfQki9VCrIUJ+h6ueGkMeDM+KV3mEy6qO+OwhSmZNesOCbRh
	 Dzq0FtQY/VRpdwUAqVx2qhlAqU8gA1PhnQLhPSRsDRU6jhb3+dGDGAZ+Jm8n4CmI6w
	 ADeEBzfedONNgCCE525vfAYeeIwNF+xIxIppynYOd7eM0EP0MOzvARAy1UTcCe1ZKy
	 nd+FS+wYua3lg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/4] mptcp: support MSG_ERRQUEUE
Date: Fri, 18 Sep 2026 20:38:24 +0200
Message-Id: <20260918-net-next-mptcp-msg_errqueue-v1-0-dd77e1738248@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMywrCMBBFf6XM2oFJlGL9FZFS47WO0BjzkELpv
 xsVF3dxuJyzUEJUJDo0C0W8NOnDVzCbhtxt8CNYL5XJim2lM3v2yHVz5ilkF3hKY48YnwUFLLC
 y64atSGuoFkLEVedv/Uh/kU6/J5XzHS5/4rSub1qghdSJAAAA
X-Change-ID: 20260918-net-next-mptcp-msg_errqueue-0e2049a30061
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Carlier <devnexen@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ij0ZLOqV4a1NW73gHHs+zwV1KBHd/t0FJBBKKAs5pkY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWtqqb2j8yqGHQ9nVjObg54jHTZvmpLxYsntCXtr+AU
 dPNK/55RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwESmz2X4Z8bif/soj0Rp8heX
 a8fNRad/O+1mfmaXxBJbwWuiky5Ne87wh3fm8f32ua2qex5I1SokCL+x+eRmsPRQn36dnc762Tc
 4mAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series lets MPTCP applications use poll(EPOLLERR) and
recvmsg(MSG_ERRQUEUE) on the MPTCP socket to drain TX timestamps
through the standard inet ABI, the same way they would on a plain TCP
socket. ICMP-derived errors stay on the subflow queue: the legacy
RECVERR ABI cannot convey their per-subflow peer identity, and they
are intended for a future MPTCP_RECERR channel.

- Patch 1 splices subflow err-skbs onto the MPTCP's sk_error_queue at
  error-report time. All forwarded events go through sock_queue_err_skb,
  which re-homes skb->sk onto the MPTCP and charges sk_rmem_alloc, so
  the MPTCP's error queue stays bounded by sk_rcvbuf and is dropped under
  rmem pressure, matching tcp's tx-timestamp path and ip_icmp_error() /
  ipv6_icmp_error(). mptcp_recvmsg(MSG_ERRQUEUE) forwards directly to
  inet_recv_error(), and mptcp_poll() advertises EPOLLERR purely on the
  MPTCP's sk_err / sk_error_queue, matching tcp_poll().

- Patch 2 factors the existing inet_flags subflow-propagation hard-coded
  list into a mask, so the next patch can extend it without churn.

- Patch 3 makes IP_RECVERR / IPV6_RECVERR (and the RFC4884 variants)
  propagate to the subflows. The MPTCP stores the bit so MPTCP-aware
  helpers can branch on it.

- Patch 4 is a selftest covering the propagation path.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
David Carlier (4):
      mptcp: support MSG_ERRQUEUE on the parent socket
      mptcp: sockopt: factor inet_flags propagation into a mask
      mptcp: propagate RECVERR sockopts to subflows
      selftests: mptcp: cover IP_RECVERR sockopt propagation

 net/mptcp/protocol.c                              |  55 ++++++--
 net/mptcp/sockopt.c                               | 155 ++++++++++++++++++----
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c |  70 ++++++++++
 3 files changed, 246 insertions(+), 34 deletions(-)
---
base-commit: 4bb9710c6a68d35207f123aef55dcd50e7195ec5
change-id: 20260918-net-next-mptcp-msg_errqueue-0e2049a30061

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

