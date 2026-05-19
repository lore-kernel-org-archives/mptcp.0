Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1A32D42B
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169876; cv=none; b=YkpefjHoz4BrgsYdYEMx58nivtIRBD9LQeyJTAjKT57ojsBc/tWthyLGevU2pYiyugZRtIKZx4xr0BC0auiY/ivmCBHpelaJI/i1p4AIAa0fwRDr8g5AGWdYkEfb3pZFww+SPV3yW1bbrmpSPSRipJFawEf7pHjrbs2S19XDPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169876; c=relaxed/simple;
	bh=O1+G9iqka0VOYj8ahr/tEr6HmqRDHO7MNm50KL/Fe2M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hK2MLRsaIDOwVx7rCoOjPSwK2AA6TVCxXC1QQb7KAjO6B6Bz5TsChk5HejFxDkiye0lli1qzyFHDQu8IUY/+yaMU1VIXHnx6Qiu8wEtsKMOOrf0dlAqG5N8p7ylWOl3yidoe9ajsNaNd7b0kCT9/RtwbhARvrWEvPCCPs2UU82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/iiJUnL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/iiJUnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469C2C2BCB3;
	Tue, 19 May 2026 05:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169875;
	bh=O1+G9iqka0VOYj8ahr/tEr6HmqRDHO7MNm50KL/Fe2M=;
	h=From:Subject:Date:To:Cc:From;
	b=o/iiJUnLnET1n69chU2zFmmJxVyUDcS8f2ylugChYJvbPzHvKxBnNw0TK7T4fZ/a6
	 Ecg/A9foENMdRnHNaXJRk1bfzJgMZzcqgR9ABEgEI4onNIHy0MWGO6d7+RsyBN+raI
	 KKMHaIofjcnduq84mg35t8Sb7J0Y8BiwKoGOd/+4d0IPkKJ9NEACR36fbmwD/yrqJC
	 He5U1vB4YHLaS4MZrZr764hBw2GEQ9mzuuOn4LvyVCt4fYy85Es9hjZuM1HK1sn+ci
	 GQPwwKVxzvPv+CZSte2N4ZPjK4s2aCXuLt02Q1J6oiETB1RlY89LIzskrGT6mH3TAB
	 poBj71mKBm7pA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net mptcp-next v2 00/15] mptcp: pm: drop TCP TS with
 ADD_ADDRv6 + port
Date: Tue, 19 May 2026 15:51:09 +1000
Message-Id: <20260519-mptcp-add-addr6-port-ts-v2-0-3b36a51e6a86@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOzQ6DIBCEX8XsuTSAFW1PfY/Gg4VV6Q+QhRob4
 7vXn3MPc5jMfjM7QUSyGOGSTUA42Gi9W4w8ZKD7xnXIrFk8SC4VL3jF3iHpwBpjVpFiwVNiKbK
 8FKrIkbfVKYeFDoStHbfmG+yQwzFBvWfxc3+gTmv1et3bmDx9tzcGsTH7ovi/OAjGWSt0I9W5L
 Fttrk8kh6+jpw7qeZ5/9f3ui90AAAA=
X-Change-ID: 20260508-mptcp-add-addr6-port-ts-371653e0f843
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3344; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O1+G9iqka0VOYj8ahr/tEr6HmqRDHO7MNm50KL/Fe2M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqC/pSf45ol2DleoVxmL9zTXBBQqWnqv97t51A5
 h6Uv0mLxxeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagv6UgAKCRD2t4JPQmmg
 c6p5D/9yAi335mn30hnMmWC+Th764SA7QIKI/qW+so01OKTC+fQh0YUpJRDXIeHcLiF7Qf3IjI/
 R8ZVa9W8lqrfUIbK4jk2LReqxUXzrzbUt3s4Coie6E4aLOHRD5I/arsJMYOFmdtEdrPbOlbUm5R
 vcItYzt25FdWZwjesisdcoCQJ6HiKhmZk1HtLwRPdflqreIjBk9CACikhje2T8Qd3wO12QmuBsA
 Z/lfoLrYwm14vpCWfvvbgAKFcsYztyZzIAizP26DmEnVuU+kTfh68Zl5rIv0PlhduQFnfAzjkMK
 E0S63xTr+1sDeh/3sYIv/h24NAbkc/I/Tzl7ya4oF5lObKaE7rOsefid1MFUNL8xsvTa6uhe3Qo
 YJWhZq9e420C3Yh/8b7Lc4z8+vjmjDJDw5JxbjpFS+8MXSygvbJd31prTEecldeYy4dWoi1tDOf
 7jWAFR8XDVzuCZhICkhRQCj+miJs8i1+TQzTJitEK+ERGdvTIM9TM9YOftjLO++EC4juwRdeoUR
 v4gAKX53W7KwQk95P2EBqyJWowyFOcyx3+TK9cuPS2USnJWq3yykMMqQ3Ne1OoUWIeSeeuTb4wF
 nIqx1RdQSwITZyKvcIXY1re/1GLzMusgpBdUCBg+8BdnEMfPORCeC7EKsCDOhEcCOPrnzdZrCom
 Nk/FvYgrIsNDPOg==
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

- Patches 5-7: the new feature, controlled by a new sysctl knob.

- Patch 8: extra checks in the selftests.

- Patches 9-15: refactoring/cleanups: some of them were part of a
  previous patch: "mptcp: pm: clearer ADD_ADDR related helpers names"
  [1].

Note that the mptcp/add_addr/add_addr6_port_ts_server.pkt packetdrill
test is supposed to fail with this series, until this PR is applied:

  https://github.com/multipath-tcp/packetdrill/pull/198

Link: https://lore.kernel.org/20260415-mptcp-inc-limits-v5-20-e54c3bf80e4e@kernel.org [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
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
      mptcp: options: ADD_ADDR size can be negative
      mptcp: pm: avoid computing rm_addr size twice
      mptcp: pm: avoid computing add_addr size twice
      mptcp: introduce add_addr_v6_port_drop_ts sysctl knob
      mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
      selftests: mptcp: validate ADD_ADDRv6 + TS + port
      selftests: mptcp: always check sent/dropped ADD_ADDRs
      mptcp: pm: use for_each_subflow helper
      mptcp: pm: rename add_entry structure to add_addr
      mptcp: pm: uniform announced addresses helpers
      mptcp: pm: remove add_ prefix from timer
      mptcp: pm: make mptcp_pm_add_addr_send_ack static
      mptcp: pm: avoid using del_timer directly
      mptcp: pm: avoid confusing check_id in del_timer

 Documentation/networking/mptcp-sysctl.rst       |  13 ++
 include/net/mptcp.h                             |   3 +-
 net/ipv4/tcp_output.c                           |   6 +-
 net/mptcp/ctrl.c                                |  18 ++-
 net/mptcp/options.c                             |  43 ++----
 net/mptcp/pm.c                                  | 190 +++++++++++++++---------
 net/mptcp/pm_kernel.c                           |  22 +--
 net/mptcp/pm_userspace.c                        |   6 +-
 net/mptcp/protocol.h                            |  46 ++----
 net/mptcp/subflow.c                             |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  83 +++++------
 11 files changed, 233 insertions(+), 201 deletions(-)
---
base-commit: 23350e342bf2604e09d89ef91d000aef684f593b
change-id: 20260508-mptcp-add-addr6-port-ts-371653e0f843

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

