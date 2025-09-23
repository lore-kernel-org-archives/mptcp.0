Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924C22ACEB
	for <mptcp@lists.linux.dev>; Tue, 23 Sep 2025 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619985; cv=none; b=EOvOwXks95Dn4PZ2NhOM+PVCY7/8jgIygqQW+uvzXk+F59S1AEVgv9JiPVB8DHvH3VrULnjTcYSvboFcgj21A4c8m9KnmsgYg/LZoonJC+Z3Hcr7h+xKlNDT+2Jj2Ax1iXukQg/xQLrKoEHOVL+DKBB5O8RV5NZmKYLL9592gj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619985; c=relaxed/simple;
	bh=cKTPWStEgOHVwn7yrpknWu5ujXUUWFY+2wRZU14QZkI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Fg+9SDYM8McOiITCdyBeujijGw0k/jbgJcq6KCuLMOAW9wW/MlPrCgpG2yUiyT7nFFzv+MTsqJfETN9jCmcBKMNMeyoKHXz7qHbxtodb+PJCkrMK9hqk0UIISxwsZdm3DYROh0sTL12P64X2G6hMl1mPOqeLPH9t7Hnxk+O0j+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKPTs+SO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKPTs+SO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FB6C4CEF5;
	Tue, 23 Sep 2025 09:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758619985;
	bh=cKTPWStEgOHVwn7yrpknWu5ujXUUWFY+2wRZU14QZkI=;
	h=From:Subject:Date:To:Cc:From;
	b=VKPTs+SO6KzCIsHrP37PU2/Euj56q9wI07iEY2rh3LGdirEVYbRQf2kR4N8cDyGcZ
	 XCt7+v+vOvQr647pZdQD4Al9gkywR5ebxKTd6urCr43hUhHzNgwm3pdYdFUzpxjwsH
	 ZlfuWJAGGPsFhBnQ3CzaLcJqahSvJjjN0sBJRFLudazMQISh8S6baFdx3Apai+wXGu
	 QgiuvIIFtucdKJsXt2BzO1lk5/JES8UaCSy6w4ykssuYpPfitnvGJxOD7BaLXqkHVd
	 kqoN8rt1buuEBhP7wUJkBRfE2pXexlmxSBZjjfcYQOaUV5UGRPm5n6mXd2G51QW7ga
	 LD3cXWJzi6hfg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 0/6] mptcp: pm: in-kernel: add 'address'
 endpoints
Date: Tue, 23 Sep 2025 11:32:46 +0200
Message-Id: <20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD5p0mgC/32NQQ6CMBBFr0Jm7ZjSAmldeQ9DTEMHaJS2aQliC
 He34t7FLH7m/f82SBQtJbgUG0RabLLe5cBPBXSjdgOhNTkDZ7xmqpQYJnxQdEjOBNTG3PNFdPR
 CzZlUgqpaSAW5HyL1dj22bzCFuQsZW2do82+0afbxfWiX8iB+Bi7+GJYSGTaMhJaqkX1VX78gP
 c8+DtDu+/4BD2qfhM8AAAA=
X-Change-ID: 20250918-pm-kern-endp-add_addr-new-a20893e45389
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2942; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cKTPWStEgOHVwn7yrpknWu5ujXUUWFY+2wRZU14QZkI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIuZXq8dg7+XPsl91HFlgQLk+zoB/5H++VulVlt9Hg/+
 dK0H2cmd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwkJ5fhr6Tge4nMTZ+cPaKW
 rNp/wqav3aTa+83xq+W5LKbWf+/8cGH4xTRjwqzfl9d4XSnnmJ+ULJg353O1cWR6zK74cwFqHIt
 mcwMA
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
Changes in v2:
- patch 3: rename helper, move where it is called, comments (Mat)
- patch 5: rename var and function (Mat)
- Link to v1: https://lore.kernel.org/r/20250923-pm-kern-endp-add_addr-new-v1-0-60e3a8968f45@kernel.org

---
Matthieu Baerts (NGI0) (6):
      mptcp: pm: in-kernel: remove stale_loss_cnt
      mptcp: pm: in-kernel: reduce pernet struct size
      mptcp: pm: in-kernel: compare IDs instead of addresses
      Squash to "mptcp: pm: in-kernel: usable client side with C-flag"
      mptcp: pm: in-kernel: add 'address' endpoints
      selftests: mptcp: join: validate new 'address' endpoints

 include/uapi/linux/mptcp.h                      |   6 +-
 net/mptcp/pm_kernel.c                           | 229 ++++++++++++++++--------
 net/mptcp/protocol.h                            |   9 +-
 net/mptcp/sockopt.c                             |   2 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  56 ++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   9 +
 6 files changed, 230 insertions(+), 81 deletions(-)
---
base-commit: 77807b94c731081ef3d97e96dabcea7aae2bfe15
change-id: 20250918-pm-kern-endp-add_addr-new-a20893e45389

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

