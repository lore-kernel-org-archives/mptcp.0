Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016258;
	b=s3FA0o70L8bw9nr7MQdqZ0xOxnVKgZY9PT2lOC+wuU+Xa8NK9SVZnF+NftS5ciwWeSRq
	 kddaBkxkRNn1nXvDc1kCFe93r1TkzkzrZdjRHdTXn9IiS1Xn33gMkItyPifVoHDdIGONn
	 EK0dwxiZHb1tdoUzB7MEVol++kc9I6IzX52+doVY3DQmdy3exg5UCPli2CgIZ/sTXtb8p
	 fZvMadlCNVYO8UUFfBItg2QO8MYQ0PhbZCdjd8SHRDKr7o1AwSxWomRUCmomHSfPHEJcB
	 vIbwK/mRuEYZNexI5FhNEhPHEKA0FEpC9fWYRxb4aHHWQHGsxRzI5H3K2u8EC9T3O6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kLE4fUltKdv5uUw+RRFjSPgUp/UfLHROFugaciW1IrQ=;
	b=kk8Z8IKwBj/0aVsOW3bvMjC5vdLyHvEdj2R1pGum3UMX4AZmQogmnkcep2QJ/cF6DIHU
	 MUMSyK3rYChFKu7gT5IrGfDFw8vBUuRQgEK93CPVb4X5u5R1tN7rsMdkhfbEFHZNuKlNp
	 u++xPea6FQXKgfIPTjARl7CT4j/67CSZnuKiz16iKQy9noiraUXlGN5mjOVBvPcGOkeAB
	 tGdA6COnq6KnN6S5GsrGMOeez0xbn8/D2j3WD//LuuquR6QpXPSDTK6FuHA6bgyTXB9ZU
	 BTo9j7zFzRCMqNBk6nsDVjXJUuiwZ15VOvUcVb/Bnhhg1Y+A00x/rxQJ9lRn5fueFRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KcyRfY63;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1ED606A320
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 12:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B1ED606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KcyRfY63
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso911525a12.2
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793016258; x=1793621058; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kLE4fUltKdv5uUw+RRFjSPgUp/UfLHROFugaciW1IrQ=;
        b=KcyRfY63ZNwuojYDHb9tjNR+5AecvbO43wUrGQJiNP59RULV3AUxh3yGY2SS1mVJQA
         71konQKBH4/gg7uA0SlNR7Sa399iE/KXHhQqXdQ1P/jtqIL3LgIQqkCjTwI9Za49hMFN
         PtzwygjGCGeu/ewer+LLWRrEEpJDzQSkgsn8Pyi8Pj5QetV5ky7dmCfKox5zWk1/+Bv6
         1e44n1ubS0nfTsL0V+7v72hOvHVoka3IVlstI1kgGZDGmCdpARxyh5VsGBO2qTBViCZE
         3w3aPnUb5yVEDAD3UEy4LC0DxLeOpalpl3tLh234+njORV0tMpoKkmBI1wHnZROn4wjw
         SuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793016258; x=1793621058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLE4fUltKdv5uUw+RRFjSPgUp/UfLHROFugaciW1IrQ=;
        b=plMGSPr0/YJ1Zxa8OTZrTBbVdoL/owcjAP6O9KhSB7WHqyZisCGCFO2oIeGhYJNZyx
         8mXk1keuPzIEFlVXj3Kn5w10mm5GAvxThGD6Pmf+FnBqzgpZTjjAgwQLZujul99Qe4sv
         SvYyOPUhkrQmSKJekQdsM8uxg37n35VXcQteDmUFRn05xuzEZoonpAPqyU3+vDOslqkj
         2Blhqs2Axp/Dn8SZJU6PX+zEiQ5FE5Fv58ml+Cj8peKZUAQGl/NBE5teJ/l9TF0AMzC+
         6AvXy3ZDp+yZbvjSRBGf0hDBEAD4GsvJgAfqI6FNUynbEV4Rpubs6vqo4vxTbrl4q3rE
         ASPg==
X-Forwarded-Encrypted: i=1; AKwUvBxT2GSte0ElQoG/tb+G0ZSo1RrwoRZYHnwFnkNxNviqvH4A/HNufo6/iSTUeT0Q5aunNjJDGg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIuhUhAH4r1sZXWdDboQd7I5bpKAFoC5LEAyxwhlHCczt3VfnjY
	2DjQMk7KsAOa13NR/SZhpVHGSW9rZEvyAMe+Y6qmF3HVON/NGStEvU/9
X-Gm-Gg: AYBFou3XrmJD9bxIEQHba3Ya2QLZwDd2NxsAUPkJ/wd0qjyKWGevM6g4wOZG6JinEuT
	2jNrMtl+WFhYXcVRSLoEoysss6VQhcTH+/+5DlzT0cZ6hm5Pj7aJGvhXR61L7DFigkyyqeEwDdH
	g9hA4suyy4YCTeOWZGTwWox9AzV+WGpUmDAyGaQSletiI1dI2CpymaFqzHUO51aidN2d+jO5DHk
	2zQTBLrpZGOorTf5ZlRXP9t4I4VFaCoRxpEx+yGhQa/l60aKS8v0GeM4CTB0Z9Qa0GIQ1OQD5ML
	SqO6m4b7G3txDGS60cteEiBJx+MFI0oBfrLlJjkECrCugucF84GYaRjtabYN4MIXPI8hJnV26/c
	iJsvg+7oxyYTVtLXaEx67yML6uc+9abjZxFPm0VIdnL/8iRN2wMRSlmtCJQvMsqPNNQ8Fz/QgK1
	KWvfnUWl4NHi+WuMgkN1rW896b+1aZ9woPffLOzKid7dgkzCCxo9iqUt8QGHLWk/ERaJ1P294Gq
	gJRD4t+x++unxrvayL9ju5hicNya6UHlNIYeloXjRYdKfyooD8=
X-Received: by 2002:a17:90b:2e8c:b0:3ac:8897:7b9f with SMTP id 98e67ed59e1d1-3adeae77a16mr5287757a91.43.1793016257392;
        Mon, 26 Oct 2026 05:04:17 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0639bsm8298309a91.12.2026.10.26.05.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:04:16 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: geliang@kernel.org,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH net 0/2] mptcp: subflow context lifetime fixes
Date: Mon, 26 Oct 2026 20:04:07 +0800
Message-Id: <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Two use-after-free fixes around the lifetime of the MPTCP subflow
context, both found with KASAN.

The delegated-action queue pins the TCP subflow socket, but its queue
entry is embedded in the separately allocated subflow context, which the
ULP release frees on its own. Patch 1 keeps a retired context attached
to its socket until the socket is destroyed, and lets NAPI free a
context that the plain-TCP fallback dropped while it was still queued.

That context also owns the only reference a holder of the TCP child has
on the MPTCP parent. Patch 2 moves that release to the same socket
destructor. This covers a BPF program that converted a TCP child with
bpf_skc_to_mptcp_sock() as well as a delegated action that updates the
parent after the ULP was released. It depends on patch 1, also for
stable backports.

Cen Zhang (2):
  mptcp: keep delegated subflow contexts alive until socket release
  mptcp: release the parent socket reference with the subflow context

 net/mptcp/protocol.c | 18 +++++++++++++++-
 net/mptcp/protocol.h |  8 +++++--
 net/mptcp/subflow.c  | 51 +++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 69 insertions(+), 8 deletions(-)

---
