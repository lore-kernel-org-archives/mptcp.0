Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DDC2E7397
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024922; cv=none; b=Hz7ehrThb6FJAj5vauwUkc9nYsIxD8+wB/Rw6yIyKb+pXBTBr2xBU0GvdlQ71TANhhBjwp1o31waApGDd5HvWzJ9KspzA/xCzBKi3uaXNqcwMxWS9gvAS17x7Fy1bVk+9ot8ks+NurjApfIu0a9LqvzJzRqhllUJZYM9tvscyhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024922; c=relaxed/simple;
	bh=u8isTv/ZPK512/QB8A26lbZGm4m2A4Laliw0Zf/3um8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aHFKCP3lER0nXFH2cyLTgxapARYP9uxIX+6T39mDTPpfjyo/NXkCuwMpCWhuloifbn+B8RoV+umHqPtJ88AwUJg7Ha4LD0GVHLAoZdFffkiIZYPlzy07Adh/LJXqlIvPku2geSbAis0R0c2F2+ZoFJp9SwWp7QC44SMlzo23Odo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj6nmy7b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj6nmy7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952ED1F000E9;
	Fri, 29 May 2026 03:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024920;
	bh=ALvqUqs3ETQC1hV6nCuj16lHnoEIoGkXCoyqRfwZj90=;
	h=From:Subject:Date:To:Cc;
	b=Tj6nmy7bQt2U54tdT72Gg29FRiGlzgQZlqSG23ivQtrFbWMAGUiyglYbEIujXwy8G
	 SkNMYNcPPiULXS1fPVtViaRQtcJ1y1IEtvGjioqE2gr45bUDSuifdf99Lwfb8aZjHD
	 WEXBFi8IORnrEXQSACJ7nqKQ1bJwxzOL8jQtzig0elDv9EtF+ZxEPjIxW+03xYxgki
	 YtJmfIla34G7Ba+z4ZE31c7k9iNB6U/y/ryKjXhIdkTIvGVDhCH07bV+y8tMeB27Cz
	 Tc3AIWU81arvkpEO1c+FO+5wBJkqQATOPSyVbGPjGTe2MlW3ArM4hUyIxeWmGlQIUG
	 SmeDYpK8dHacQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net mptcp-next v4 00/15] mptcp: pm: drop TCP TS with
 ADD_ADDRv6 + port
Date: Fri, 29 May 2026 13:21:38 +1000
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOyw7CIBAF0F8xrMXwsAO68j+MC0oHxUfbADY1p
 v8ubTca08UsJsM9lzeJGDxGsl+9ScDOR9/UedmuV8ReTH1G6qu8E8EEsIJp+miTbampqnEC0LY
 JiaZIpeJQSGRObyXJ6Tag8/0kH8kcqrFP5DTf4rO8ok0jPb6++Jia8Jq+0fEpMzfy5caOU0Ydt
 0bATilnq8MNQ433TRPOU00nvqHdMiQyJEsJpuAIRsMfJL8gwZYhmaHSOQOFNgqU/oGGYfgAtlz
 wgG8BAAA=
X-Change-ID: 20260508-mptcp-add-addr6-port-ts-371653e0f843
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3800; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=u8isTv/ZPK512/QB8A26lbZGm4m2A4Laliw0Zf/3um8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZWTqIjDyI5X+3NLoOP3hM9veeYGSqHFdwAU
 0Ky6sUyNQCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVgAKCRD2t4JPQmmg
 cw0OD/9ghmgjojWMxuQNGm2J7O3W8Zzgup8E7clFlG/67BxU1X6W0ieHr7gRC69c6arVavG2Tj8
 2H36UR2uYL10JtJoT0fL1Hr9rfKRdWzxGTCS5SA0uM/AFZtfGdrdhLZHsDJtzf+s0frufsZxY5v
 ZpZnhdJHODwxSGmR/E34qg4eBrBdampYFg978cWP1hUYUBKvTxuqJGNVu8StQjCgVJ7WRxUUZle
 TtKEnGbPzqfw4JrOgAHCT5GNonMuEhcnhvh57A2swyljlgC24SUgtv8NrDX1D3GoAqJtSj90enE
 SofvVP9+B4gxgQDnq9oE8sj3hP+FtLFF0/p454oc8ON6vWhyObRZ26jdLN5flukABxd4aSCK+LG
 AKIw5Bp0CkQJ44kYGHBEE53FR8+dZdKfWA0QcEt0PY/ZCyCDneGHyAJAe9TBwOgiQU8XEpPldOx
 3HyusQI+d6Kw9l18wliMMFVHG4SQTxn91zxOptsEJyr719KfkHfR7ndlaQQ2YVVXC5MdwLMCExL
 JZ0IwksQDO0GqrZ028g0TnrJRq0zoBA3bmqQB2kymGpIgeCBp1Kh/0Sd9WmaAInYMP4RBfWLup6
 zHgB83sRifLxSLUEeRUWdNcq176yINfhKcuyIQ+WE1yv5Gybo1+c9JgsuocpW0oKj1LQcK2+rYI
 kkR58Wx81YQMQMw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, it is possible to add a "signal" MPTCP endpoint with a v6
address and a port, or to directly request to send an ADD_ADDR with a v6
address and a port, but such signalling option cannot be sent when TCP
timestamps is used due to a lack of option space. Instead of simply
dropping such ADD_ADDR, the TCP timestamps can be dropped only for this
packet.

- Patch 1: fix for PREEMPT_RT kernels, for -net.

- Patches 2-4: small cleanups to avoid computing ADD/RM_ADDR twice.

- Patches 5-8: the new feature, controlled by a new sysctl knob.

- Patch 9: extra checks in the selftests.

- Patches 10-15: refactoring/cleanups: some of them were part of a
  previous patch: "mptcp: pm: clearer ADD_ADDR related helpers names"
  [1].

Note that the mptcp/add_addr/add_addr6_port_ts_server.pkt packetdrill
test is supposed to fail with this series, until this PR is applied:

  https://github.com/multipath-tcp/packetdrill/pull/198

Link: https://lore.kernel.org/20260415-mptcp-inc-limits-v5-20-e54c3bf80e4e@kernel.org [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v4:
- Patches 2-4: uniform "size" type: signed for all suboptions. (Mat)
- Dropped previous patch 16.
- Link to v3: https://patch.msgid.link/20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org

Changes in v3:
- Patch 1: sk_stop_timer() should still be called under rcu.
- Patches 6-7: split + s/has_ts/add_addr_drop_ts/.
- Link to v2: https://patch.msgid.link/20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org

Changes in v2:
- Patch 1: new.
- Patch 3: reset size in mptcp_pm_add_addr_signal for dropped options.
- Patches 4-5: split from previous patch 3. (Paolo)
- Patch 4: fix typo.
- Patch 5: fix reverse Xmas tree order + change label. (Paolo)
- Patch 6: back to v6 connection.
- Patch 10: fix comment.
- Patch 14: fix typo.
- Link to v1: https://patch.msgid.link/20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org

---
Matthieu Baerts (NGI0) (15):
      [mptcp-net] mptcp: pm: avoid sleeping while holding rcu_read_lock
      mptcp: options: suboptions sizes can be negative
      mptcp: pm: avoid computing rm_addr size twice
      mptcp: pm: avoid computing add_addr size twice
      mptcp: introduce add_addr_v6_port_drop_ts sysctl knob
      tcp: allow mptcp to drop TS for some packets
      mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
      selftests: mptcp: validate ADD_ADDRv6 + TS + port
      selftests: mptcp: always check sent/dropped ADD_ADDRs
      mptcp: pm: use for_each_subflow helper
      mptcp: pm: rename add_entry structure to add_addr
      mptcp: pm: uniform announced addresses helpers
      mptcp: pm: remove add_ prefix from timer
      mptcp: pm: make mptcp_pm_add_addr_send_ack static
      mptcp: pm: avoid using del_timer directly

 Documentation/networking/mptcp-sysctl.rst       |  13 ++
 include/net/mptcp.h                             |   3 +-
 net/ipv4/tcp_output.c                           |   6 +-
 net/mptcp/ctrl.c                                |  18 ++-
 net/mptcp/options.c                             |  65 +++-----
 net/mptcp/pm.c                                  | 189 ++++++++++++++----------
 net/mptcp/pm_kernel.c                           |  22 +--
 net/mptcp/pm_userspace.c                        |   6 +-
 net/mptcp/protocol.h                            |  46 ++----
 net/mptcp/subflow.c                             |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  83 +++++------
 11 files changed, 240 insertions(+), 215 deletions(-)
---
base-commit: 4d6bda29d05f8789f40c095d5d08396ffd6b470f
change-id: 20260508-mptcp-add-addr6-port-ts-371653e0f843

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

