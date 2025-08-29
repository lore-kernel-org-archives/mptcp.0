Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63243164
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499630; cv=none; b=f+yG+NI9ArHE/zYs1kZuI++p2qwaimqoTvXQCfJ8njdytCz8U9oE6oMPfuTlWXXfz4XecPZW7Be5uP+vQ3PHcyIbP+hKOpwIA7lGUejLYxpLaZC0Pt5IkffEVa1kKTqRNLaJtuyMvIOLetbRfiXmnv3vuqMdSR6DD9F8bs4ZwD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499630; c=relaxed/simple;
	bh=oQJ1zu1Tp1GN3H1YlmqBW7GEmBiGt+6zPxriZV19FTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BtnhmD9qxb7QGxSIRsTL1G0pOjWgraWi29zOfzPoMLXTCkC+0Gvlalz0pH3Qo2DsmtiCQ9PyJrkwGgqZsfDC80UDgZWXp31ymat35HrZv7Wmf01qC5NXQwYsv93E4doMOhGn2z9+MWq7de8SlaQvfe1+bv+6dXl09ory8P0FyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keZEv3U3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keZEv3U3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCA8C4CEF0;
	Fri, 29 Aug 2025 20:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756499630;
	bh=oQJ1zu1Tp1GN3H1YlmqBW7GEmBiGt+6zPxriZV19FTs=;
	h=From:Subject:Date:To:Cc:From;
	b=keZEv3U3Zaeus5nz9EvDgYQmD1FSMKgKTI9udoW4KSvVTAcSqKaV16N1vFLw2oP1e
	 FJKem/Jtw+P8wCHtr5TS4RVVM9wduo+/xuochsZTVcuQruBXhQCRgEGJQOutJJAxTL
	 iW364X5c+FelEWzT3TaOHTHq7myInXgrTKrBWOdjtolqq3t+mPulbQzBwR2sYftLpc
	 eOwuwcafZ5npRke7xkK8sr+z8DDRqBWsOUSKRs+kErEKr89IDilCTOEv3La8aEdqs2
	 HDnIERyMnbgKwaUdzw1ZYOF23vLZNkDPa1BE1XaDi8SbjOF56m6Gm1YdrXa7B5wkgU
	 uZz+xSneR/ajA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/7] mptcp: pm: nl: announce deny-join-id0
 attribute
Date: Fri, 29 Aug 2025 22:33:32 +0200
Message-Id: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ0OsmgC/yXMQQqAIBBA0avErBuYhBK6SrQQHWugTLQiiO6e1
 PIv3r8hcxLO0Fc3JD4lyxZKNHUFdjZhYhRXGhSplrQiXONuI8YVjyLRol/MhEa71mlDZDsPhcb
 EXq5vO8AvAu8wPs8LzH6VBHEAAAA=
X-Change-ID: 20250720-mptcp-pm-user-c-flag-a7d5d7a00c6f
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2885; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oQJ1zu1Tp1GN3H1YlmqBW7GEmBiGt+6zPxriZV19FTs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI28S07s8phQRTb8wVTH6gvftx2nF/z1ulWuQ9tvGf47
 nbMFGf37ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjI5ECG//Vcp9Z/OLM/6s0x
 g1nzAhsa+IWu3pbt2pWaWBPwReX/2q0M/1N8AhO+pabIeO45dWlJSkzodFnNQG//e8rrBJo8nVZ
 FMAMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

During the connection establishment, a peer can tell the other that it
cannot establish new subflows to the initial IP address and port by
setting the 'C' flag [1]. Doing so makes sense when the sender is behind
a strict NAT, operating behind a legacy Layer 4 load balancer, or using
anycast IP address for example.

When this 'C' flag is set, the path-managers must then not try to
establish new subflow to the other peer's initial IP address and port.
The in-kernel PM has access to this info, but the userspace PM didn't.

The last patch is adding the new attribute in the Netlink events. Please
see the note with a question about how to add this new attribute.

But before that, a few fixes have been added:

- Patch 1: add remote_deny_join_id0 info on passive connections. A fix
  for v5.14.

- Patch 2: respect the deny_join_id0 attribute by blocking the creation
  of new subflows to the initial IP address and port if set. A fix for
  v5.19.

- Patch 3: record the deny_join_id0 info when TFO is used. A fix for
  v6.2.

- Patch 4: fix a wrong attribute type in the Netlink MPTCP specs. A fix
  for v6.7.

- Patch 5: stop mentioning net.mptcp.pm_type in the doc as it is
  deprecated. A fix for v6.15.

- Patch 6: support Shellcheck v0.11.0 in the MPTCP selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (7):
      mptcp: set remote_deny_join_id0 on SYN recv
      mptcp: pm: userspace: respect deny_join_id0 attr
      mptcp: tfo: record 'deny join id0' info
      netlink: specs: mptcp: fix if-idx attribute type
      doc: mptcp: net.mptcp.pm_type is deprecated
      selftests: mptcp: shellcheck: support v0.11.0
      [RFC] mptcp: pm: nl: announce deny-join-id0 attribute

 Documentation/netlink/specs/mptcp_pm.yaml          | 9 ++++++---
 Documentation/networking/mptcp.rst                 | 8 ++++----
 include/uapi/linux/mptcp_pm.h                      | 5 +++--
 net/mptcp/options.c                                | 6 +++---
 net/mptcp/pm_netlink.c                             | 4 ++++
 net/mptcp/pm_userspace.c                           | 6 ++++++
 net/mptcp/subflow.c                                | 4 ++++
 tools/testing/selftests/net/mptcp/diag.sh          | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 5 +++--
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 +-
 14 files changed, 39 insertions(+), 20 deletions(-)
---
base-commit: 569dfa7d27f329168b34177931080efc317511b1
change-id: 20250720-mptcp-pm-user-c-flag-a7d5d7a00c6f

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

