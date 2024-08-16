Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6602A1CF
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806128; cv=none; b=CIWgfQnzUXQr1XRdx1QDGEcvjYjhoeh6vqpecYaqr04h30Gk2wmjmXqe1Dz6KjQw0IBQkbqsuQ6kmoT6ZisGSLAJ1otO56WqzQcHhQge0P29AayEiemNCNeI0MqF7jCxdM5fuetsW2hUuH9skqDHQlXjrpr9VvVm1/iH7n3jmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806128; c=relaxed/simple;
	bh=M3iEJAW/3IMjgpULwXwPoYt30daxeVtA2t9kZVIPX7Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ur1YBkVdVqgCiG9AIkVzxERHQbZfuVV1/aPhZ+AgLhDDKyOMbWMhHfDbH1COenT6hyJubZ9QReUNEn0GFkzACndY/vAmQXdYiBUjogEh8qAF7LztrWM8tY8NeqVdyCRuRy2fnt/30njvujTZhOFOHQYeZeklkYhCDUEy1hNMsnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnRcNQE/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnRcNQE/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F09C32782;
	Fri, 16 Aug 2024 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723806127;
	bh=M3iEJAW/3IMjgpULwXwPoYt30daxeVtA2t9kZVIPX7Q=;
	h=From:Subject:Date:To:Cc:From;
	b=OnRcNQE/rZLDIz+NdLQxuDsEYx96AgtbIbhP7IyUdot+puIXFZ3Rau0lLHW23wAFo
	 7s5aLS2zW0FxkIPbcVvI/6i2dZL6DgvczJVHb77/3stwdczbcmseYLz9RTCUlC1Ejj
	 qXnt9WFt85ghx5dliCQFhgAT3mMqS+8Pd6iegmtAANCwATrPh6qxxwoalbka1GIhiL
	 fOqRKkFWwnNS+YSyzp+QVtS2UX0dst4sXJUMWexawPn+XO/6+cLRuv6z3AMPpJmPnQ
	 vBSdEfjmhSBudcpdOQPL6RSI4zR1Gt+dQQUCm7Ap0KsR5aJxsUkkG82GM/+0v5dRjR
	 PnCdC3ec6RPgw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 00/12] mptcp: pm: fix re-re-create the ID 0
 endpoint
Date: Fri, 16 Aug 2024 13:01:54 +0200
Message-Id: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKIxv2YC/22NQQ6DIBREr2L+ur8RBDVdeY/GhcFfJbVAgJI2x
 ruX0C67nMy8NzsE8poCXKodPCUdtDU58FMFap3MQqjnnIHXXNQ9a/DhonI4Px2qzQZCShFJSMZ
 JdX0nOGTSebrpV7Fe4QsYijDmatUhWv8uf4mVwU8t/6oTwxrlJCWbm6ltlRru5A1tZ+sXGI/j+
 AAtexyjwgAAAA==
To: mptcp@lists.linux.dev
Cc: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2577; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=M3iEJAW/3IMjgpULwXwPoYt30daxeVtA2t9kZVIPX7Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmvzGtP3s2dqZGnVDtundE/kKeHh//+I9xlwGpR
 j3FaZqeNt2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZr8xrQAKCRD2t4JPQmmg
 c57YD/oD/2A2zCL7ivYgZArSGk6GcV9py+MGSjTs4wQP3v7Bmspd7R7owrd7rDf/0oK1L50g8kO
 +zjVBEkyFsVhACI5rRadfAGs5AIPgmo3OuTfiyn9+022y8vs2DeT9l2RJgX+Th49KVYYbtKwC2j
 Vp1+e66V9rnBg3ewszlA/qMrYom2evhT+RkzB5ybAYHFJ12aYVOVl9vAKaN74UIxYlsqD7K75eO
 UWm9kcrUntEHx4FFQyZvOZE+QnvEvzstHbrznLN+QzBWwGOs49cYHPeZRrZLUyYw+OR3S7FiYAx
 Ieqi8cR6/ZawFORPsU9i8tfE5dXqCV/cXnP1IoX/ankXTXOkeL4/Rz1QwzI9QModh0+nS/G/KBb
 vTaY7kG33dr+8ar7yXhyvg9gsaSmGVIB4ovMwKxcgDpFCQ4hQlvGf/CKsXUzk0s59UWJRZEL7GW
 MVGZyoB0sz8h+oK8YIgULO5/PpuH8kTNj7viHKWhx3RN7YCdKd5kGPL5vhC17F2nLL3Je/4J/bg
 jgE2zPUXz4RbMdqI3t7S1yEXKvVTmbsfDLkxRMqxInZlibYAXfX2NGoKZvPVDSMRdX19K3VV3GS
 klMHpwOoDEfMTwX6Vk2wt06e0TwB31E6am0GsQ/sFoDjXcnCdB/dGm2Rr6uAo7wtG2Fjbh2gvjg
 1ZK2gaIbe3XkyAw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Even more fixes for the in-kernel PM :)

There are a few Squash-to patches fist:

- a partial revert for a previous Squash-to patch: probably fine not to
  block the send of the original patch then.

- improve code coverage

- use the right ID with __mark_subflow_endp_available()

- small fix for the fullmesh case when re-adding the ID 0 endpoint

- set the ID for __mark_subflow_endp_available()

Then a few more fixes:

- avoid the RM_SUBFLOW MIB counter to be incremented twice

- fix re-re-creation of the ID 0 endpoint

- validate that in the selftests

- avoid duplicated SUB_CLOSED events

- validate that in the selftests

- ADD_ADDR 0 is not taking into account by the 'add_addr_accepted'
  counter, then it should bypass 'accept_addr' & make sure ADD_ADDR 0 is
  not sent with a new address

- validate that in the selftests

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- New squash-to patches after new issue reported by Arınç: patch 3,5/12.
- Patch 8/12 is re-creating the ID 0 endpoint 3 times.
- Link to v1: https://lore.kernel.org/r/20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org

---
Matthieu Baerts (NGI0) (12):
      Squash to "mptcp: pm: re-using ID of unused removed ADD_ADDR"
      Squash to "selftests: mptcp: join: check removing ID 0 endpoint"
      Squash to "mptcp: pm: only mark 'subflow' endp as available"
      Squash to "mptcp: pm: reuse ID 0 after delete and re-add"
      Squash to "mptcp: pm: fix RM_ADDR ID for the initial subflow"
      mptcp: pm: do not remove already closed subflows
      mptcp: pm: fix ID 0 endp usage after multiple re-creations
      selftests: mptcp: join: check re-re-adding ID 0 endp
      mptcp: avoid duplicated SUB_CLOSED events
      selftests: mptcp: join: validate event numbers
      mptcp: pm: ADD_ADDR 0 is not a new address
      selftests: mptcp: join: check re-re-adding ID 0 signal

 net/mptcp/pm.c                                  |   4 +-
 net/mptcp/pm_netlink.c                          |  38 +++++--
 net/mptcp/protocol.c                            |   6 ++
 net/mptcp/protocol.h                            |   5 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 129 ++++++++++++++++++++----
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |   4 +
 6 files changed, 154 insertions(+), 32 deletions(-)
---
base-commit: e2b07354530a5aea0cfc25e7d16094a15f080643
change-id: 20240813-mptcp-dup-close-evt-e4512ec78742

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

