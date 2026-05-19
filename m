Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C153E5EE8
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225924; cv=none; b=OzoScep0rebxXkeaDigAYWewMfDQ6X/Cmh4vjCKPmlcbMAeWdIdZWY3wgvOY3OBXPpkZF3XUTXmR+8N0e8L/FZ222qVYg/YAhxHlyI0WUclX1pFizi/gJeBQZKo5Q/qqWU/0QHrN8dKyUmfBUlhFyqzLuCusWV4dYoUfRyBHqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225924; c=relaxed/simple;
	bh=kxY8SWpb25wvGcI+yGAO3IvA5k8cDS1FyQd/Qqu05u4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WSCLz6hXLVQ4L3n0I94QUu2paTCWYS126T3zlqYqZLokSKjzfh5Ou41nDrfLrGlrLNVxhzKoUbOr27i2LfiBpKSeyy/zRTze96BEkYWJY85K+tYkVEClTA+t9v+s0eZ8tTIZQp7LxYDfBaGjDXmfAXAXcXHCZcF8Tb87btLYxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIduQuJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIduQuJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9EA1F000E9;
	Tue, 19 May 2026 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225923;
	bh=EostfeppD7g0tXnqg9uwEf5Y/xf3Y/v3hkiTpDX0mWI=;
	h=From:Subject:Date:To:Cc;
	b=cIduQuJNBXYa5sa53bu26Vdk8v7eEy3Qc1vMjh6xSUhwpxNbL/01htwVemKkkWEQD
	 OFBUnDYrW9/iE+XIRENBgkMOOb03N4sNNR35rP0NBPgegEHnIh1L86t20BK2iUeDCT
	 LruSVKLYZqWvE7soFMeYEA5YnbDSI7pD8wRObgVwKdnKKwAJQor2qtsZkKNkS7IUtW
	 zBOiwtfcm8zBL4Qp70WF+/QzcuONwUbXKXx9Go9tH24pp8700bjAcVRlHdYskDyJat
	 mhwPwM9B/qMaYOUxuFjBQidoVYqiGyH4K0ujfhg+9KHYLsvAUj34tcSP3BEVVssNcI
	 32C1/+PynONjw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net mptcp-next v3 00/16] mptcp: pm: drop TCP TS with
 ADD_ADDRv6 + port
Date: Wed, 20 May 2026 07:25:11 +1000
Message-Id: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOyw6DIBBFf8WwLg2PitpV/6PpAmFU+lAClNgY/
 72Km3bhYhY3M/ecmZAHZ8CjczYhB9F4M/RL4IcMqU72LWCjl4wYYYLkpMQvG5TFUut1nMB2cAE
 Hj3lBRc6BNOWJo6VtHTRmTOQr2ko9jAHdtp1/13dQYUWv153xYXCf9EakqbMZ6b4xUkxwQ5Vko
 iqKRunLA1wPz+Pg2qSJ7BdU7YPYAuI1FzKnIGQp/kDzPH8BxHFAoiYBAAA=
X-Change-ID: 20260508-mptcp-add-addr6-port-ts-371653e0f843
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3631; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kxY8SWpb25wvGcI+yGAO3IvA5k8cDS1FyQd/Qqu05u4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqDNVAqdX5ZRkG2CSR5jLkumLA5JwPxYHJiPYT4
 fGa9nDO92qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagzVQAAKCRD2t4JPQmmg
 cxvZEADTahEfVRRC/a3zwr+m5GP5vyNErROWQImdabNbfbwlZLEmCbdt1eYZnlO7Nb//Te3Klcx
 JxvEHCrMAr8fwZUdl0IrQlfk9rugWHRQDuJVDHplgg/9qvpSL/SHN7V5LVQVRUnwE5ORdeLKCI3
 hfJmVwpjlaoAUeF7f+JPVDpdXtZMMyA+T/rYYnrfK7pGk+eXSvNt2WKaXxr83jaSANDox2KLBV3
 v9x65PCbnfHUI4XJ+Q3I7kMkm9ps6aV3eFMf6Uq85pjrhjRiEGCxN75IPp2wJ3jkor2hW0HLt5q
 2JhQoe7LpfxFm/ocNoEcvM/43KSUeRiPjjokRDec2rjQsJyEAraB1foacwutF9X/I705jslE9IO
 pA5RTD/nOvd5gQki2N2wWh4R1qGwNLDrNZfWAnHCks2KbZcGUruTw3sGERTtiHFtDzkx5gHFZS/
 RSJETUXYEatx7Ah6UvxlUqlUfK2+F8m5kukkbRVVj81qhHP7noYX+zj4bFDm2AhtwOPU31Eq5wE
 d22Z0FnjBeW9eChOayKP+HWa1zJf3fqmnOsQyKGX9BHvHbd8Vt6d1rbV2UG99rzK4wRR1ei2Xd6
 nYyB0VyMJOZeG5q9KxDPx3ZUUPycZqyx4j7LpvEeL4yknTCW+O7ga8VzTEf2fhRoXLOsb5k/Kjh
 CZoCbaGAhq4AfWQ==
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

- Patches 10-16: refactoring/cleanups: some of them were part of a
  previous patch: "mptcp: pm: clearer ADD_ADDR related helpers names"
  [1].

Note that the mptcp/add_addr/add_addr6_port_ts_server.pkt packetdrill
test is supposed to fail with this series, until this PR is applied:

  https://github.com/multipath-tcp/packetdrill/pull/198

Link: https://lore.kernel.org/20260415-mptcp-inc-limits-v5-20-e54c3bf80e4e@kernel.org [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
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
Matthieu Baerts (NGI0) (16):
      [mptcp-net] mptcp: pm: avoid sleeping while holding rcu_read_lock
      mptcp: options: ADD_ADDR size can be negative
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
      mptcp: pm: avoid confusing check_id in del_timer

 Documentation/networking/mptcp-sysctl.rst       |  13 ++
 include/net/mptcp.h                             |   3 +-
 net/ipv4/tcp_output.c                           |   6 +-
 net/mptcp/ctrl.c                                |  18 ++-
 net/mptcp/options.c                             |  43 ++----
 net/mptcp/pm.c                                  | 189 ++++++++++++++----------
 net/mptcp/pm_kernel.c                           |  22 +--
 net/mptcp/pm_userspace.c                        |   6 +-
 net/mptcp/protocol.h                            |  46 ++----
 net/mptcp/subflow.c                             |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  83 +++++------
 11 files changed, 232 insertions(+), 201 deletions(-)
---
base-commit: 08d7466136ffa606d823f1fc4879f97d366d9e92
change-id: 20260508-mptcp-add-addr6-port-ts-371653e0f843

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

