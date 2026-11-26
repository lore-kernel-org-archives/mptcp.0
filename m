Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688305;
	b=r0v/hTt/m2x2HhtqINBQN+mDv4UlXa8L4hGoBWmu5mz8WhEa8UsWdgB8jNXjtHAhsd9U
	 4ROZR4FEDTcDT1vnmHhk+JgFikCwoKa7rSx9Q/PpXnmgyq9Cz3fTnDUbLzCF4IOwcN0Hy
	 bLmPT64B93d9DaZFiqnBkWATtMjzL4saJFulteipzO8EQcjNNr6GUrp6W/sZB4uX9Nz3d
	 6+KMo6Mm5wH9E7/+P1vAGBBh13zxRbnPG/4vPIahTgOl7sBB3tqMTKdbUQyHshVthZ9Lj
	 RXaITa9XzsB/0KYCLi3Ty87cDKC8N2CJAQn+xMErKpB3c84RqcWpLg0PRtpvoLu3Rng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QiWnylv6wFNOmDeyBKtJKVb8TFmJ9oHgIMjFjSpXJiw=;
	b=GQWvqeWbd73vX+lk1PHAzWCyMpz5NAwH18inttcIAoRm3iUxgsMBuL97r0f5jgyUOnjF
	 8bkpi3kpB/iTZq9xixYy4G2+Jc+E0vDq37KFxnGhOpFSA3GUVcwmGlHPjYQXGiAgsSEWy
	 kn05y/lnZRYZBorv6Z5kyQ8VjnL2ST99VjxlCmK27HClGHKqlVVSH9M603KP8W8GuTFhM
	 BY3N0yDIuiYdU3kCyT4qv+m8YE8+OKOd8d/6shhME0Go6+Jw9AFm2VeeVWcia5dh32gr/
	 H1cgOVi9lfRPmG8rXc27kmfu6jvQhJBViDDg2enfaRObwMr98BD4jazLLy1I0La1pXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WPFD8MGa;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F82606A31E
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 10:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F82606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WPFD8MGa
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-385d8a00598so10082396eec.1
        for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 02:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795688304; x=1796293104; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QiWnylv6wFNOmDeyBKtJKVb8TFmJ9oHgIMjFjSpXJiw=;
        b=WPFD8MGaMYCUuXKlAX0RxvPB1BfWczvKFMjQY4ht3B916N4L3aYp9IoaiDCKciddt3
         Vp+GgLMYe4LNk3hMc3//N+gxKwL1CjbfIoeW69IibEizeAlrtyoz3uIDnpK4ITTKOU1s
         Q45ePkpUg5P/jqJPuIrQPJStXC/gMRaq5ppXCWE2nNNdPE0DsobylcZPsDFQvnxvEoq3
         QPpq1eDmZoaKRJsJ/7Sr+juC10aP+M5lhcqLmfHY/tY6DMPS9G11YUETEQ0WqWjj16If
         /4XEvHtoE2cV7TJpYehjQxtePehWTCLCosHxrdgi2KbSP1QJHt3YR1aIYK2qRf00Vp2k
         Sp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688304; x=1796293104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QiWnylv6wFNOmDeyBKtJKVb8TFmJ9oHgIMjFjSpXJiw=;
        b=WCEIasUc1uDS+u1fy6yZZ4IqMrSSv+fRuI8tU2NgsPl2DI3juUEhN5J3cCrngHCff/
         F0Ge33GE3aBnsQdpBRIDVXa5LjbRhR4VrW87MyEJpHY3ntmAC5gALgVc9yC0/V8zwXgP
         7MWfVfc2mJdyrUjTWuGnbHT1nR7ekIvVqOC85AkdiJYOzrbJCR92NIIFlRrJ+QZ2ZLIo
         z82SJIffU80xssL7vPysvBqcoty3x+cmUgHJ93PeGgoNrCzjl6XOLQScEafZXbC1sutv
         9khX1sdcJQw1TXm+MAZmDu69T/gK2BYy9OIYpJWSA8WtAyPOVUKc9OMstNMNxTMDxN8G
         qI2A==
X-Gm-Message-State: APuU4Z8rb4QcQD1aLJX7FWp9Wajnm9MA3waUky2rCE+zjb2oj5D4L+WO
	to/rAfS/GMEsVpxk6pBs9s+Elx8+zWWhQ42bIk9HB9hn1vfxrlDyEDIIop+cpA==
X-Gm-Gg: AZFdTZe9omos8s09RlkKZOo5iXmixgHXzCQ1gKMhlVsXT04SPEZf4B5r5BzfSgd+mgj
	Wkr0MtiB8/MXw5FfSTDiierHXnel55IeWKadDDQd6g/Cd6zFUifVGacdSAa0jb3JHbu0TkOlMt4
	onvNw8yoYzHe8/hVOf2nwli5wkW3P6Rdk6okvJ4cDx6/ZL160qNIdSQ9fTKase4NKOLMhMQx2fg
	t2hGL0jYm8CSEPK1LXztmqABJWIiz2eTrP3nIzPoQJqaOUDmP4pvoId1Y38efAIp0k1La0z7uvX
	MVCmceA4KmMmKURWR/7UFI/Up5kcxO7+tquvflwIsTZcnG2qXV8lTgoieihrdRHcHQRaRYHXAcN
	0ukjkjHQx3Cw0nRdxSwp2KQB1KuI1ckLi9Sxsl9w5qUDQHb0cGvwunbUcuTfKpsYpvsKj0ABuWt
	2J+LSCMncjNMs1t28tEjM66ft8kBLwAeK/+sGYJzGQPR94Adr/furQIn6EL6mmPveY0IXXa1N4y
	amk0KoNvsxNM0xMQmADgMTP4qOZVpBxNN8m8HnYe7FIXpLprkI4yq+9iqKPp42dD5sLjeSJ6sAS
	3APasKfs28LguMpBflW1wIa3HgQc2fIhZIA=
X-Received: by 2002:a05:693c:88d4:20b0:386:a8de:2bfc with SMTP id 5a478bee46e88-386a8de2f67mr13532700eec.6.1795688304342;
        Thu, 26 Nov 2026 02:18:24 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm74221227eec.10.2026.11.26.02.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:18:23 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>
Subject: [PATCH mptcp-net v9 0/2] mptcp: pm: in-kernel: fullmesh: re-add of the initial subflow endp
Date: Thu, 26 Nov 2026 10:18:16 +0000
Message-ID: <20261126101818.3916631-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fullmesh endpoints, removing and re-adding the endpoint used by the
initial subflow never creates a new subflow from it: the closed initial
subflow stays in the conn_list, and makes the PM think the remote ID 0
is already used, or picks its reset remote address. If the initial
subflow was the only one, no address is left for the remote ID 0 at all.

Patch 1 fixes that, patch 2 adds tests for it.

Found with a router flapping one of its links: the link carrying the
initial subflow never rejoined the existing connections. Tested on top
of export-net: the new tests fail without patch 1, and the whole
mptcp_join.sh passes with it.

Changes in v9, after the review of v8 by Matthieu:
- Patch 2: drop the test adding another endpoint after the removal of
  the initial one: it already passed without patch 1.
- Patch 2: merge the test with the initial subflow alone into the first
  one, to save the setup time: after the re-add, both endpoints are
  removed, then the initial one is re-added alone.
- Rebased on top of export-net.
- v8: https://lore.kernel.org/mptcp/20261024111842.1069878-1-w453y.me@gmail.com/

Changes in v8, after the review of v7 by Sashiko on mptcp and on netdev,
and the MPTCP CI:
- Patch 2: use nftables in the "after reset" test, as the rest of
  mptcp_join.sh does now: export-net also got be3b69f3cedf, so
  ${iptables} was empty there too, and the test failed on v7.
- Patch 2: stop the transfer and the event listeners before marking that
  test as skipped: when all features are expected, the skip exits.
- v7: https://lore.kernel.org/mptcp/20261023110321.403874-1-w453y.me@gmail.com/

Changes in v7, after the review of v6 by Sashiko on netdev:
- Patch 2: in the two tests with the initial subflow alone, wait until
  the PM worker has accounted the initial subflow endpoint before
  removing it: a join on a third endpoint is created in the same worker
  run, then that endpoint is removed. v6 only detected the race.
- Patch 2: wait a bit before counting the subflows after the removal,
  as the other tests do: the closed subflow can still be listed.
- v6: https://lore.kernel.org/mptcp/20261022085041.211318-1-w453y.me@gmail.com/

Changes in v6, after the review of v5 by Sashiko on netdev:
- Patch 1: in the commit message, the closed initial subflow keeps its
  remote address: only the destination port is zeroed, not the address.
- Patch 2: skip the "after reset" test if the iptables rule cannot be
  added, instead of passing, and check that the reset closed the
  subflow.
- Patch 2: in the two tests with the initial subflow alone, check it is
  gone after the removal of its endpoint: the ESTABLISHED event comes
  before the PM worker accounts that endpoint, so a removal right after
  it can miss the subflow.
- v5: https://lore.kernel.org/mptcp/20261021070324.50533-1-w453y.me@gmail.com/

Changes in v5:
- Patch 1: when no subflow is left to take the remote ID 0 address from,
  use the remote address of the MPTCP socket, as fill_remote_addr()
  does. Without it, v4 also broke adding another endpoint after the
  removal of the initial one, when it was the only subflow (Sashiko on
  netdev).
- Patch 2: add two tests for the initial subflow alone: re-adding its
  endpoint, and adding another endpoint.
- v4: https://lore.kernel.org/mptcp/20261019190558.465270-1-w453y.me@gmail.com/

Changes in v4:
- Patch 2: only check the joins when the iptables rule has been added
  (Sashiko).
- v3: https://lore.kernel.org/mptcp/20261019185512.458313-1-w453y.me@gmail.com/

Changes in v3:
- Patch 2: use iptables instead of init_nftables(), which is only in
  net-next (Sashiko).
- v2: https://lore.kernel.org/mptcp/20261019180306.382039-1-w453y.me@gmail.com/

Changes in v2:
- Patch 1: also skip the subflows in TCP_CLOSE: the initial subflow can
  be disconnected and its context reset, clearing the 'closing' flag and
  zeroing its remote address (Sashiko).
- Patch 2: validate this case too, by resetting the initial subflow
  before removing its endpoint.
- v1: https://lore.kernel.org/mptcp/20261019170751.200446-1-w453y.me@gmail.com/

Abdul Wasey (2):
  mptcp: pm: in-kernel: fullmesh: skip closed subflows
  selftests: mptcp: join: re-add the initial subflow endp with fullmesh

 net/mptcp/pm_kernel.c                         | 33 +++++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 79 +++++++++++++++++++
 2 files changed, 111 insertions(+), 1 deletion(-)

-- 
2.43.0

