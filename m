Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436765;
	b=5nyRlL/ZyAjT6s2WMI8brG+hbPmNMT9BxPM88c187nTBD1CBkhdXIb2o9+1UlmBdC7Q8
	 wb6F3hRxpzyJqNSiRqQy9aqJgVq4vlwzpYtZ1LSY5VffmFhpuKzWZvmu53CJ9Z5OO9bjU
	 t8P9dA2ST2y7tBzeBZPPJ2sdGNXSvUtKPxeSnTvx2SmWWyioyK7LXOV39wZQv4ePU4NKs
	 EuytBm7tCddzwYlJ4wjFcPNIVi9jAYvAhMNhZKzZt0W0i2vZaSXYfSyZRyRQWUKWWnp8i
	 m66QK9oSPDbLRmH3mQXZFamhLEkDCZl5EJ+hR/DCzmTVAcRGLao5v9tlDeT9bVVZ2CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=bm1hmMZnvp2skj3H1oq2oCDmf13ZC4StHROQFsc/3Ng=;
	b=lIMIf1BXe8NNy/OM4JeMw3Qit2fwSmLcyB1zgJ/FI0YH3QLb17XYQg9GgrE+mhvSloCS
	 soLCtpX3PaS3xwmOmlz9GfnFgr7obTMfO4vtgyILTK+etj3lDjzRrPiz/prHGq4UXziKI
	 3GHeFNV5YhdgA+9wtvp3eJjfuHuE9B+urDL42w9XidSHUJ8PgWdnoPVVgzQQx8XVMatK8
	 vSH4A6363pnsKBHCrK43a9yE5XtXjqNzvCA+c0z74Ox8rzd94KOSUr1ZWfPKFUPCkGQJg
	 AhkKGAxx2sEtuOh/lIQrz0B3kOnmaDtqfOMmA+BxepFy3yGZCe+PGj2dG23uPM4mvcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Rje7/xjs";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5989606A31A
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 19:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5989606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rje7/xjs
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-354ba08cfd1so4485070eec.1
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792436764; x=1793041564; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bm1hmMZnvp2skj3H1oq2oCDmf13ZC4StHROQFsc/3Ng=;
        b=Rje7/xjsiMLMqORESeqOcW/O0B4T2g3gIjHTcGNH/ZX/E+KqmqMlFZ3SLd1/zUuxBA
         yZVyXI1ldNli7aW9hdA/dGkb7OsERsnsXyS08gImGvT0jvq/8dr/qMif0E7X1FNUKk2L
         gLwDk8nt6RFN2yxzMUQ76WLjt1xT7octy+touX86ro8QNmG6dRg82RGa0uP2sCZ/n2hU
         ivvhmsPN+OgMO/uyo/q8kb+UqgVbUXB83+HJncquKCH+flB4ffPmQ16vslcl8GsapKlw
         kHqvmQUPdYBeKUVY+bg2dSTCUVppbNU77YM45LedghD/66MVt6Xa0AC2XKvC5pAaKHz9
         PkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436764; x=1793041564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bm1hmMZnvp2skj3H1oq2oCDmf13ZC4StHROQFsc/3Ng=;
        b=Pz/t5h+v3qAZ2MkKo6Dn8ted8B0FjXJa2OuwL2Jlf36y+hNkMeLU/jVYS5DrX5zFOr
         KOf+EszBZzo1G2G6OxX+E2TiNbQ2kb0k+oCkDZivIlcUyrkkySFGtac0BXA6rXH9GL+V
         jwYslns9LpzRS1XJOsg7h9iDLn9y9Lx+yT/aIwv5C9UclLwq8yz+cQ23hiVJw+/6WUau
         gzDHWm1d4LHxkaQAlKRPdE0UHn7kaH3gDErqRK4FkvVX88FK5eBcYBeAIsPY1lnhkeKX
         UmLF9JT31CzoNbQvrKLa4dQlup/IqayCqpfvkhtLqQLxvPT1zntxNdANLJnmJmr1A7yt
         XAWQ==
X-Gm-Message-State: AFq9FYIF9X3/YDLxXYfzLxnO7d9RvtWT7aYpN6aAPqnuwengpbZ0wzIS
	o+vb5wwWoKDHq/R5f1Pkh7M2d1/bEuZNajww/o5alNoz3AL8RtUqztVU9DPJQg==
X-Gm-Gg: AYBFou2sIxuaeYZOjWcksmsiXSmpL5FPtjxi+4peS01kJ14gr/5CHzAYVSnJQOzXa8a
	cw7lsAOc+bhMqVynz5Y6DHX2aseTZqpI4vUyGvcQxLIOm7KzeI1AcKbLdkHrjsG6SzNhmDc4h83
	A30sSobR68wg62PHil9cJJ1+Guogg8pF8mn9Wl4VDM44fk+O0S5G7i9bUxNvDyl92ebQpp8Wrzc
	XNa56tWh1PWlsqABEfBPi2F/5o/yxk/OFjnzUH9ZwWvP3kFaStCtrdAj+sp5lo74dXj2Pf6eCqM
	jgglPXtMt2ek2GuczqZVala5eFKoElhSmUG1uC7cY8SFp1fEgDqzED5SwpCjpzK4rK4Nxwbffla
	lQhJFVUidIXrp8uUBAvsptBrhrNgZlIHzUnkC17PwRpyIrEwUsPMxGHeL0QrVnpkc2zVi64IACk
	usC73L/dyv1AIk435/wwezAw/319dPuKXoF3RUbEZ7+h9I5AJsj+BQbWOZx6LFg0PEvEnD4VIOK
	BJe2K9FyskOudWrbtCKtt33ZD4JBpGSNMYQ1GVIv4iRL59j5ndtskxwAs8ePUko
X-Received: by 2002:a05:693c:6312:b0:353:7f17:4358 with SMTP id 5a478bee46e88-361a1c4888dmr13640627eec.24.1792436763794;
        Mon, 19 Oct 2026 12:06:03 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm62848024eec.24.2026.10.19.12.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:06:03 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net v4 0/2] mptcp: pm: in-kernel: fullmesh: re-add of the initial subflow endp
Date: Mon, 19 Oct 2026 19:05:56 +0000
Message-ID: <20261019190558.465270-1-w453y.me@gmail.com>
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
is already used, or picks its reset remote address.

Patch 1 fixes that, patch 2 adds tests for it.

Found with a router flapping one of its links: the link carrying the
initial subflow never rejoined the existing connections. Tested on top
of export-net: the new tests fail without patch 1, and the whole
mptcp_join.sh passes with it. Patch 2 uses iptables like the other tests
there: when merged with net-next, it will need the same conversion to
nftables as the others.

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

 net/mptcp/pm_kernel.c                         | 19 +++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 61 +++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletion(-)

-- 
2.43.0

