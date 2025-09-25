Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14FB25DD0B
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790488; cv=none; b=IBtvc0H7RDVOLXKA3BgTal4gHoMmJQboNubNn8FaSQiGQZ69JOTfH02pGjcUIO72BRAzZwgLkhM3yiVp0hjah9fMFtEtfBQePL0iCO7n88Y3W3PtNMa+Co6RXzrol6OcXXoZGr70KphSZ8QTnkClUWtped1qManu9MxKzQ347C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790488; c=relaxed/simple;
	bh=kyKYMcQrMzTioRMYY61/SmizSR36xT1PMZ+LY20Ybk0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZJUQ1S7A/730R//Rxa9R9SUp3BqyGIerpe/3xMPgBRggl7Roy8HW81E3pvetaCVA3h4IAltZXoQT9/O+4AlhZC3EHB7qDRRRV3x+6Bnk1KcgrkKkZ3yEWmn61aNshAnsy4l1Ueu72s/DSn9+LPRDV03mV66KduLwIWF9q06GeH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odwuj7F0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odwuj7F0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CB1C4CEF0;
	Thu, 25 Sep 2025 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758790488;
	bh=kyKYMcQrMzTioRMYY61/SmizSR36xT1PMZ+LY20Ybk0=;
	h=From:Subject:Date:To:Cc:From;
	b=odwuj7F0ERYwXcpYhecH5QuRJFKFZz/g2YZkLIZH602MqN4eDJDFV0+86eJPAZBsC
	 i8GO7mdjIZH+MsuQ5bvEoJidy7YdHAA0JQtZrS/TlaOnvDPEXpX8CIJ0dz6m4tnG3l
	 i46eDD/7lE6FvnWhDNXbxjL7TRzTTbpFNe5mnpyD5sBdZAc/fGmT+xOSOhQjUt6pCV
	 MJOqqjUOokomX18S5fVVxzOlWDFgpjOJuZvbsaRrYSn5V4YQ85go4mjQA8G/68bfhU
	 o/n99v3iAX1B8r7upcyIPu08UIC8i+jR+VcuyZC7o8eHH7vGDvz4/JIltIaOIofJaL
	 Aaz9UQiDMk/VA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v3 0/6] mptcp: pm: in-kernel: add 'address'
 endpoints
Date: Thu, 25 Sep 2025 10:54:16 +0200
Message-Id: <20250925-pm-kern-endp-add_addr-new-v3-0-1697a14ffa7d@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADgD1WgC/42NQQ7CIBBFr9KwdgyF0oAr72GMIWXaEpUSaLCm6
 d1FXLkxLmbxM++/v5KIwWIkh2olAZONdnI58F1FulG7AcGanAmjTFBVS/B3uGJwgM540MZc8gV
 w+ADNqFQcG8GlIrnvA/Z2Ke4Tufu58xlbZnLOv9HGeQrPMpvqQnwWGP+xkGqg0FLkWqpW9o04v
 kG87acwFG1if6tYViEK3iqjjWjVl2rbthfRMgwHGgEAAA==
X-Change-ID: 20250918-pm-kern-endp-add_addr-new-a20893e45389
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3153; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kyKYMcQrMzTioRMYY61/SmizSR36xT1PMZ+LY20Ybk0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuMvutdiut/qU97XHSxGsX5zr7dqv85/wWHb23O7Di+
 rIyxgvFHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMxfsTIcDFy+4bCKrao/RUf
 vim1fFm90VvXLmmxNbPV8/v6Hw6ULWNkWChaWCMwv3Gr5H/fMM7UteKNYVuX1TL9fy9Zv/dcRwo
 HOwA=
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
Changes in v3:
- patches 5, 6: rename 'address' -> 'laminar' (Mat)
- patch 6: new test 'laminar' + 'subflow'
- Link to v2: https://lore.kernel.org/r/20250923-pm-kern-endp-add_addr-new-v2-0-ee5369dad569@kernel.org

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
      mptcp: pm: in-kernel: add laminar endpoints
      selftests: mptcp: join: validate new laminar endp

 include/uapi/linux/mptcp.h                      |   6 +-
 net/mptcp/pm_kernel.c                           | 229 ++++++++++++++++--------
 net/mptcp/protocol.h                            |   9 +-
 net/mptcp/sockopt.c                             |   2 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  69 +++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   |   9 +
 6 files changed, 243 insertions(+), 81 deletions(-)
---
base-commit: 77807b94c731081ef3d97e96dabcea7aae2bfe15
change-id: 20250918-pm-kern-endp-add_addr-new-a20893e45389

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

