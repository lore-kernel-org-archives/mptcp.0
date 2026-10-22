Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659050;
	b=rHI3Rns1WxUI64xMMbF/d5tGRqKqR9Ra8a1pQu5ao+z7DnjttvmOrKEbdgtRNPRupJzY
	 LVMDpPfZ6aBNjl8vRqJFOd0xmFlKg43nVIDpwmp7WZptI+JllcTNGUsp00C5DvO4W5psh
	 7bUm2Ca0BfH8/ml8LKIA/MAFsyzk6+n+ZvgDMZNtLmUrSMUvp/bJIF8dnddYw6FwhCExL
	 TIYpKHumOVz2poY1M330LczJKzRZ5GivjTC6MjjcxoUwTeIbQo1KqVhk7CAdLwm+qBwzm
	 krOCSANetxghsc8xxOqW1UPqQz4HXZoxavCQhVxs51nLhzQ1nOz1j7NYubgN2/Zj7DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FT7Ga97+J2Gy/6Icdwz35ay1LYQZy53L4z0u6aTaB+4=;
	b=yFt8vUbc8ddnHBHZikO6RdlQjqSy9zgjzoWyv9suY5hiMy7IdQA+fyjLgDdFVoIcRYP6
	 Dsn6pboFNtFqYnaS3GgW0P50WxQ/k2Ut2DF3A+qiapCwDJH9bR3NvbwyuvJayBZ2heQkR
	 f8vhngNRACURelItmktfDEbvJ6m576XgWKEgUNtYS6hclMOccxSY8cZ4OkLg7M/d6Ku0t
	 HOGGUrvW6EndoAKQRt/homJ55zvCe4S9V0mxdb71/bF1WCLTBApxp1HurgUt4+P+NrCBJ
	 Bfip8mjJWk0AF+D38/pVeXy2oHTNvy+P/Pl1h9aNLHpE3a/Lln+KhCvbWl+8jsnxstw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=epnMa5ee;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50456606A31A
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 08:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50456606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=epnMa5ee
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35f036b17easo1034843eec.1
        for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792659049; x=1793263849; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FT7Ga97+J2Gy/6Icdwz35ay1LYQZy53L4z0u6aTaB+4=;
        b=epnMa5eeei0/t6OdpUq0cFKAFNo3W4eVZX4BVCv5LcF65yGzQhzDw9v2AVMpMJDKRG
         3U6+7wTI9V8Lo1XIC3CpF7Bo3koZt+1VTV2YdnayEw0YDLasMGv3JB6Ydzjprmv9m/90
         /Ar1HkwnDig8lBWM/XuG2bK/MouukR/6D/O4UOY/YEuXZ53tHxBdXAvxVLg0/9IUKd3S
         Z9wjqPt/SQFHVbhhRS/k75orQ5gp8LJquvj3CtncxnklvA3cYhRMnVQ1eNaAlJCwn0v1
         t7YSBFKW9G8nwqXfBviI4xak85hUCKP6k/JqGJg932EyCkMt1fHAqAwHBbzy3hZ6baET
         NH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659049; x=1793263849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FT7Ga97+J2Gy/6Icdwz35ay1LYQZy53L4z0u6aTaB+4=;
        b=qfqPlD0qe6waL78kAh1wMjIXYQHZxoTnBHXa3eFSCGpSXK6g8D3wgv5DH8DLX64Zz8
         lse7rXIc48qFb3jW3w4Jkq0lTwj3FCbPSGKPdznPAdMwbStWEkRaeGoYQil9kz0njPOl
         /Spo+WCyA4MK+Hs/s6cGqiaMPQdNBWZeZmZWrIhnyDsncCjuChqWzn8mliwbP4rbgxbk
         PQv8O+vAa87KuouoS9LInTbk3BIWkXfmUnG2Psts6xu/6vSt5R1N6ekiMkerA0fiGpLY
         IRrzhEnMiv3xPVSxM4ob5SaE/xOvQBq0/XqAupW1/yrLwrCsKfnaT1825iUhQQ7Mv6yV
         0/uw==
X-Gm-Message-State: AFq9FYJ+9WPF8t7Y2utSDZxq671aGeR8HH0Ne1w9J45DvVWDfozVCqB/
	T07hWERBogN9Z6dev7YlJbB5XSzXv4cjINlA1vnRKpYPjkiIzczKQZJyM5A9gA==
X-Gm-Gg: AYBFou0IntO9mh/E/PlQ84JXV+ZSAt1n0Y8oDJIwpqnsseUWz5Kl2Toma8uDEYkE7fT
	XdMp70BqzfczM+NMww49JXR+tgkapdvh8RAFlLUGt5f/wjogamTyIbi7P3I7CsIbJfXHI20lSET
	YsBAfvd9A+JevUIGUrd+QtnLQfeivUezzmL3rxmlHGnw+8l+Hf+Mt4Yr8YFobKtgJ0o4iSJ2hEL
	lS4eV059ChPKqBnAgjVj04ecpG/lASxfh3oFWv422o/WoGO5OCDV1ajLa8AJxU/HpH7QqeGoMAr
	tyiiAaso0jMNLPqL8PQlU5ZAbafABuaGN9JAkujymIzSGeE4l3WvzIi/hMULM+S7N+FoObR3P8d
	GoIvo6CB3Um6IC3P5XqfymG/cycfNtHtOeDKXgTrsr3JX5RRetfT2QUotixEWnXgu/MDIq/Sa2D
	ktYYniBpmIJaKUt/nJP6qD02b6IYl+V2CPE/aaE1UVvG0oo2ZKITb8bJS9Qd7STefRuTukeOi0b
	UXIyBBU+ZNqO7HQU9Bc99KVBJNDtN9PIMT13WjHBdGp8v2E0/g0AHfO6LTv
X-Received: by 2002:a05:693c:66d2:10b0:366:f9c2:9b16 with SMTP id 5a478bee46e88-3674fd08d54mr6494315eec.31.1792659049229;
        Thu, 22 Oct 2026 01:50:49 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm25343328eec.2.2026.10.22.01.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 01:50:48 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net v6 0/2] mptcp: pm: in-kernel: fullmesh: re-add of the initial subflow endp
Date: Thu, 22 Oct 2026 08:50:39 +0000
Message-ID: <20261022085041.211318-1-w453y.me@gmail.com>
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
The whole mptcp_join.sh passes with patch 1. Patch 2 uses iptables like
the other tests there: when merged with net-next, it will need the same
conversion to nftables as the others.

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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 117 ++++++++++++++++++
 2 files changed, 149 insertions(+), 1 deletion(-)

-- 
2.43.0

