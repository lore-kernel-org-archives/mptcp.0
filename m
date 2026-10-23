Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753412;
	b=cJFd9OVaWAiXhQe7rKcFBlBVkPijN413B6Pidzn8gUA6qRC5uZ4KLjKdHdj7gmOO6zTr
	 KopD0/zia659dGD+pnfXP9tjdM7xH5Ru35psW4vc4RfJXLmlb7wPcfI8HdX8FdnYvgW08
	 Dv158y+VTgrbFAYDxIGSnfverEbIs45utQA9MDTd84DAFzL+f9MEA4djMMcaoFltJBnV8
	 VEL4p6+bxfhYu5JWLrRI2QkbAOs68o5+8Yiv6vQKHRRQCv57rx1STWW7vC2p1NvEvv1lE
	 RmM452/ZwIrNQ3s9m0xPbRvZY/av2EwTcsjRa/ZVnGoAVOljcq0BDiJU8AzGtMgIhsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vEo38iKS1cVn8oUkfPI6+BGq9Pc+MWzOJphLGvvXjjE=;
	b=KAOH49aghOboORIH15R+n/lpLmrOi0sjH7+uXBRSz9/93twPOTKsS946CiGdSH/pF6ck
	 1h9AElfRQvTxNaANyB/P97qe2z1v/ExvxQeuj8UfHioxhVITVf8sODoyuCBwKxqYa+3MX
	 yNUffyeHLMI3C61mYK5PZ8jc/3vHxSsye3GGjuM7fPotOoXuPUkMYvBqVeE80wP8Kh+Tm
	 rhgTXgrp5U0BcA7Y6yjgQKFbcut9MH4iw789RstymFJPISrwi60WKJ24UxCdDxAPFDP9S
	 3oXePJXCmxM8No9UBppDzg2D5/euOWFGxVn9G835VSbWNNCJf7++Mthk/JHXtb9rBZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="XWJWA/AA";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA10606A31D
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 11:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AA10606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XWJWA/AA
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3550c917fd3so1146117eec.0
        for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 04:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792753411; x=1793358211; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vEo38iKS1cVn8oUkfPI6+BGq9Pc+MWzOJphLGvvXjjE=;
        b=XWJWA/AAiOghdsNAy+JMBn43lx2CkyrDfCLTeLujqxoML4nr0iaHmir8W5fW4f3Fx1
         pa/Rt8bORuFsKir9u81D4aJ+yN9OcgB4g1QdaiTdE56eDIGEoOHg/VdF7dhhNCXSinL9
         t5NX8ewvUkoFKH4wJ8OJka4fgPi/A/qPm6n62tYB0iFUGV0zzDnhJQyb2c1qjjQwBp6M
         Pi0qPW1EqDY4URmZiXTt8hFKEGzOTQ1QKvdkpZO0cSs0EWpcchk2FcflyEvufNdtmsMS
         FnJ3t1MulLJdx+o+79oxlDXL8NlWIp6GrglkLPR3opree4aN3JGPqE9jluxUnzVO5UU7
         n40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792753411; x=1793358211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vEo38iKS1cVn8oUkfPI6+BGq9Pc+MWzOJphLGvvXjjE=;
        b=p9oWxUdOfbo7QF+/SVT1Ak8OOCjxjwvgW/nR6VQXy5oZbFeJhbtRoQVBmxbuy6i1+7
         ayL1ZMzG7AZKYn7RXO/0wLKjM0D0GTKwJ7AUdIFOQPtK4aW726PcRrqJkAwKOkq4O8az
         xoZhQkyCvAmlnEakZ1uSLq01/H2/+TlAKT2yecoHsWzqIqljI/PY/2qEmsi4d7WKZSFK
         jyS2c5DYTmuDLJ8w71xD560pQkhXein+vceM7yQwkscIBwcSdOrQTsqrUCDHqNeLceht
         uapBzxjMWSlTiSxGEK09KBGeuPst908GyoyhsRLLzKmInI4ZiR0ElBQWnJT1ElZuY2m0
         ufEQ==
X-Gm-Message-State: AFq9FYIK/y4m2cWFahdBKckbG3qO/BIN9gmiIFrwww3LjNjXbAW2yU/K
	aVsx2StxAhG2s+EEi5yVqVkzAOMv5gi2/emfhlAsxKDF4T2DjVPHsjNVVc8JYg==
X-Gm-Gg: AYBFou0JUrT4vRmGx2o7tSSt1jsNxk8RojXs4nXo8vosbgI7cOh+LQzQ+no0Z+1dhdI
	+61VHhCMRVWl/VkTtw16x0xHw2sdtTQYLJ3iXKpHEqfgj0lvKL/Yet71Mn6TyJBfrzgk6UrDK4S
	CsYWv/vPRo5py/YJGrUuH7M3xs2b13Ua17BWom8ut/uXrwi71Cs5yJuDVF0puByr8Ux1cdvWQmr
	u+gkF4PX9oL2ubYsDbO2/ZXegH6M2wV4nKYLIbox8OOs3STcXFOEuHPZh0ykSeupzxweAq1QJer
	j6Icd3pi/PSfIQLUF8RikOJ54JZTBCsaedbRw6oarmMwOyzXvUIV+drGiG92AAxUgDbyBTnXF56
	SVQimQCXPkJuVsYcHTtYqbDiNeyriBJm5RLYFKd/7hLMchjOOVb/kxdR+escXaRI3G1BgS3oLO1
	u9q6Kd8saBMoQJ37NZUuEr6JtHZm6hbBCNZxkrVxZYAhpr+iTSCDpxrE671LF8pogYF/2VP2hV+
	WqI5092wjwmENdKVn1SaLOcZYaWB+WHsTlFFDBFzyW5z6iyI9x6VY7giwyU
X-Received: by 2002:a05:7300:e9d5:10b0:351:35b3:c5b6 with SMTP id 5a478bee46e88-369d9854d17mr2857439eec.27.1792753411305;
        Fri, 23 Oct 2026 04:03:31 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9defcdcsm12695186eec.23.2026.10.23.04.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:03:30 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	Abdul Wasey <w453y.me@gmail.com>
Subject: [PATCH mptcp-net v7 0/2] mptcp: pm: in-kernel: fullmesh: re-add of the initial subflow endp
Date: Fri, 23 Oct 2026 11:03:19 +0000
Message-ID: <20261023110321.403874-1-w453y.me@gmail.com>
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
of export-net: the new tests fail without patch 1, except the one adding
another endpoint, which already worked and guards against breaking it.
The whole mptcp_join.sh passes with patch 1.

Patch 2 uses iptables like the other tests in export-net. On net-next,
mptcp_join.sh now uses nftables (be3b69f3cedf), and ${iptables} is
empty there: this is why the CI failed on v6, it applies the series on
top of net-next. When merging with net-next, the "after reset" test
needs the same conversion as the others. Tested on top of export, with
the endpoint tests passing:

		init_nftables
		if ip netns exec "${ns1}" nft add rule ip filter INPUT \
				ip saddr "10.0.1.2" meta l4proto tcp \
				tcp option mptcp exists reject with tcp reset; then
			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
			ip netns exec "${ns1}" nft flush chain ip filter INPUT

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

 net/mptcp/pm_kernel.c                         |  33 ++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 129 ++++++++++++++++++
 2 files changed, 161 insertions(+), 1 deletion(-)

-- 
2.43.0

