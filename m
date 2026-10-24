Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792840729;
	b=fZs9HUp1Rlem0QAYws1KJ4KO4T5k3B9gIx0tCONOus3/T2qdY2S7HzH3pMccR3k3JiwA
	 5wyxDnFV0VmG/Obs8o8OOkMMScg9WeCG9Cvh1+KIHTsXB76gNm4NJd+0BuIRgsnnTbqtN
	 4wdiIv0d8Z2mTb/uA2z0N0P/q1PeTMnkGxmsB/6No/Tb1ao7Ed73zej3o762vPmo5Dh/U
	 aMQ1ckyRYcmt4suK/N8yCpyiwHBu3pwSek1j/GD4nJHB6D2WiQHveFRmBN77bFW7kCZTW
	 3+QNcwM0ggPYZnTRIP9PKp39Db2W8cKtO+YzWoAkK+8x2bfxzbqTODRkhTE9GpbIloQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792840729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/WUwy9+Lg2AU2psx0cCAyfS4NVUsg4eGAr7YFPYwQno=;
	b=4i0ub3our7VaZwnIwwghZENHn7LRSIMjJzllhVpL1l4lqLl34imzL1uNcJfwnFKajGyz
	 hJO7iKOhONjgMqHPzt7U/jQpd+EZy7nLFnHK50VpPgc3uRmoCtz0j7f7cDh9PSOk7v4m0
	 7YpQ8w22k1CzFmBtWk6+/eIvuUwc1Oa8XSvg+NFZ6K5m++DKDxKDMChVRzK30AuhxuZtL
	 kGEzlfxLOJ15qMFsJzs5jdopTV8hQCIWVI+bMzoSmkDyYchxK1v4IJaqXD6Wa5DwYGCwY
	 j6YCRwiH8gMBIjPsLOuySES+Pn/0y/WpFTAvKFui6lToH6qqgBU8dQr2+nHOzlrvWDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZuGfKKCA;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2C606A31A
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 11:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E2C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZuGfKKCA
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-354ba08cfd1so2936146eec.1
        for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 04:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792840728; x=1793445528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WUwy9+Lg2AU2psx0cCAyfS4NVUsg4eGAr7YFPYwQno=;
        b=ZuGfKKCAZ3ZW7Z1vHdDmYJ9HPQfKqif5Xb+PExBYo4caciENx114MRvmy8eUUtg/dQ
         BJJXBsAZvj9vix2L4JEG3Om/FitFe7IWc40fuqplk9AXB1pgc9lSjfRO+NMdhKZVTqFy
         FgFKcNJa7WKrsNRUNjLwLEyNBUa5NAwER1DKKyUxTskuZO2z4yC2zuRJWt1HyG0FIUuj
         cYBNdzpDRoOOEqRt5rDs3z9OSVSHwLPLh8B9EsyVfmWVbhlF1yK1G9OvzjUR5tko2d+P
         pbkkiGzOfvFw9mMsQdNGqqEC/AZSka0VjytyqIzdTQgcwNPW/gHBodY/iS1ZLZJMFvMG
         c6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792840728; x=1793445528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WUwy9+Lg2AU2psx0cCAyfS4NVUsg4eGAr7YFPYwQno=;
        b=WKRK4bqHPkR+QEFT1aeZODsfSRcrMZS3oVk9lOqWgrwhkqbg3QcspwTRX/7A2XtROq
         nO/4Cd6ju7CL1DVadVKneZe7NpSEXmzVC7arqWLd4E3BhB7Gxs0/9xQDmLCC1bbtHzgr
         a6I5y+iEOK+oNYazF3PLiSIROLgiluj4JBMfXQ0X7oYpgRj1q9/DzThGqKnA4caN8t0Q
         jcNI9C3i7iY+w9FvDQqymRt/uuAHjh+VnB99zvckYlty+ri8NGMAht7NSEU2kvvrk2v7
         NH+lP/wMuABi2ksilSklP/Eo20PS1Bh14H8GRSO0e69Hy3B1Z25miVonHFGx0gqFwbyJ
         xVGA==
X-Gm-Message-State: AFq9FYKGYYfCJNnwF6diAZeSXw8cLXcSav+6i6mrugHXhneFqnKxcU3e
	uDKezYa1/6WJOpEbSOJsjGQ/x8QYyJKFCly/sCPywHMplM35ewGi78kX7sKHrA==
X-Gm-Gg: AYBFou057SDISwO8B5YavnbRqmGjFhszzPqWDI0tm3Y+FVg2djOuhnx9pXoha5pwzQo
	VPXk8DljPsn5KMi53NPOVm7vImAUTYNTGeaRBxd6PniTnIk1hhH2xo4D90KeQUtuIjjUOAzhFy5
	V1Usi8krTkeUeBYnx2sYLIlo1QzQBZNV58STDq7ASuuUAp7uhfbGc6VBVWIPN6GPh72KR/zVRKz
	yn4MAZTkYgptnMSF3VAmTK6OjCmqsHxiRsdU3q9dQ0gfzTDorZPFHbEMIP1oknH7aNBUzmSz5G3
	tF6HC7dOxXYw62NA2rVYzRRK26wLg+kbczU2re2NVCc9g48rKptBEXG0Z3MqpfLT+xE0qYBRD4X
	gPwUuo2umnTLwx/VFe1+5tRWXdI0MoJT83bckbihZtMrWr6PftxLBsaMYRKwfj4M77PHF+L5Kii
	ZXQap6vjUpwGXYon9NM4ieFQV3s3DKbTvHyl6uxrMJiQfphZUn2xKuO9lDnh5v1H3Q5w7xSSyk3
	hoLkHxPRvZ15lIjC/eRjpNZjD9c1dIfgA7kU1EqoLaFsENJYrXk65BgR+OOeEB0CV6zxCAIBobp
	WOUlMQ==
X-Received: by 2002:a05:693c:8809:20b0:369:daea:812a with SMTP id 5a478bee46e88-369e84f4d51mr2463967eec.30.1792840727452;
        Sat, 24 Oct 2026 04:18:47 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8afd64fsm7458774eec.0.2026.10.24.04.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 04:18:47 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net v8 0/2] mptcp: pm: in-kernel: fullmesh: re-add of the initial subflow endp
Date: Sat, 24 Oct 2026 11:18:40 +0000
Message-ID: <20261024111842.1069878-1-w453y.me@gmail.com>
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

 net/mptcp/pm_kernel.c                         |  33 ++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 133 ++++++++++++++++++
 2 files changed, 165 insertions(+), 1 deletion(-)

-- 
2.43.0

