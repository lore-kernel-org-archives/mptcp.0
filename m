Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54727A906
	for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579847; cv=none; b=TuJUq0n9kSJ+FmxVC4kmwx0ix9Th9ha6tu37PFulh6L1zvKSwvHERdiDzyg+PHv+P5SPlop0lrrpl9Iijykiyel+enUssJ4x0Fz6iwK/kInJsV0Bn+3jQUsNiShE59wUQwNa89PsUYdAaKpfi8DUjXXapSZQm8KXWjvZlcheS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579847; c=relaxed/simple;
	bh=lCPZT6uO7WOqxa8zmSc8VLgor4IZj0cxtW4O+n4Vpbg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PQ5JaQzebjoQdJlrK/e3+o3RctMUu9fOTV2RpsoQgXaIXxpGaEKcyYoXVs0YUh+K68iFeqvC+ZJCHDhW1ezhLU5qRTIPzmPgT1ZdIdBvgE/shN7Y+eLRkc79/oDNIu6yuCODwC9hwUzpPnmjMMgzTs/+aCARfMKLlYIrajuJg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8mIxZ3U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8mIxZ3U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1EEC4CEF0;
	Mon, 22 Sep 2025 22:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758579847;
	bh=lCPZT6uO7WOqxa8zmSc8VLgor4IZj0cxtW4O+n4Vpbg=;
	h=From:Subject:Date:To:Cc:From;
	b=t8mIxZ3URDBfF+8DSu6oZ1UTHShg4VxnjQk5/qeXOiTLv95+pCSYCunBRKAzQ78wx
	 o4eHkS/ptDwN2p/dsvJKHoNkiFxIA9t26v6vGtZM/+I3f/j6tYjFnIU51CdgB6g1Gw
	 jL5TSvLtwba0F2RGNpg9Tu3Z49wpRLJOZMHtDNJLBYoe1JIR24Mid/aNxKHa+ik+Tv
	 8216SYhF7TWw2RzxCKFb0QAeC5CJbNsN4szuBJKQspzDBESZFk39VgyQOHDsSwCebW
	 liSkCbbuSsv2GvIC4aOXoS5WHlK7UzC9X5iLacGVn2p1IcvFphpXrG4Y2rvB5S+0Fw
	 WpVFMDmovlLKw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/6] mptcp: pm: in-kernel: add 'address'
 endpoints
Date: Tue, 23 Sep 2025 00:23:51 +0200
Message-Id: <20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHfM0WgC/x2M0QrCMAxFf2Xk2UDXOWj9FREpa9QgiyEdczD27
 wYfzsOBc+8OjYypwaXbwWjlxh9x6U8dTK8iT0Ku7hBDHEPuE+qMbzJBkqpYar07hkJfLDGkPNB
 5HFIG36vRg7f/9xVmXSb1bFvgdhw/zn2fu3cAAAA=
X-Change-ID: 20250918-pm-kern-endp-add_addr-new-a20893e45389
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lCPZT6uO7WOqxa8zmSc8VLgor4IZj0cxtW4O+n4Vpbg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIunqkt3cVYtmrDVj/hr3uOLbIS0c+pye75cKrYJk1k9
 sGVVfIFHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZxMLIcDT2yAzudv80D+uL
 T6ZEPQlP3bF0i7u2fMQWt7KDE+acZWT4Z/e4+4tAWuVSP6lT1X4Ld2wQ2syyW4ft3qVIiw3ZD+4
 8YAAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, upon the reception of an ADD_ADDR (and when the fullmesh flag
is not used), the in-kernel PM will create new subflows using the local
address the routing configuration will pick.

It would be easier to pick local addresses from a selected list of
endpoints, and use it only once, than relying on routing rules.

Use case: both the client (C) and the server (S) have two addresses (a
and b). The client establishes the connection between C(a) and S(a).
Once established, the server announces its additional address S(b). Once
received, the client connects to it using its second address C(b).
Compared to a situation without the 'address' endpoint for C(b), the
client didn't use this address C(b) to establish a subflow to the
server's primary address S(a). So at the end, we have:

   C        S
  C(a) --- S(a)
  C(b) --- S(b)

In case of a 3rd address on each side (C(c) and S(c)), upon the
reception of an ADD_ADDR with S(c), the client should not pick C(b)
because it has already been used. C(c) should then be used.

Note that this situation is currently possible if C doesn't add any
endpoint, but configure the routing in order to pick C(b) for the route
to S(b), and pick C(c) for the route to S(c). That doesn't sound very
practical because it means knowing in advance the IP addresses that
will be used and announced by the server.

Patches 1 & 2: some clean-ups and refactoring.

Patch 3: "standardisation" and small perf improvement.

Patch 4: squash to patches for a commit queued for net-next.

Patch 5: new 'address' endpoints.

Patch 6: validation using selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (6):
      mptcp: pm: in-kernel: remove stale_loss_cnt
      mptcp: pm: in-kernel: reduce pernet struct size
      mptcp: pm: in-kernel: compare IDs instead of addresses
      Squash to "mptcp: pm: in-kernel: usable client side with C-flag"
      mptcp: pm: in-kernel: add 'address' endpoints
      selftests: mptcp: join: validate new 'address' endpoints

 include/uapi/linux/mptcp.h                      |   6 +-
 net/mptcp/pm_kernel.c                           | 228 ++++++++++++++++--------
 net/mptcp/protocol.h                            |   9 +-
 net/mptcp/sockopt.c                             |   2 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  56 ++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   9 +
 6 files changed, 229 insertions(+), 81 deletions(-)
---
base-commit: 77807b94c731081ef3d97e96dabcea7aae2bfe15
change-id: 20250918-pm-kern-endp-add_addr-new-a20893e45389

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

