Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC6175A66
	for <mptcp@lists.linux.dev>; Sat,  2 May 2026 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777756817; cv=none; b=VpMcUlvn4111RWtqTMURlNM6mv77ooyY4SoofYhuXC5YYHVvNUW0c/lzXclRzjm3MGNwgztMxIvMjGbs8qQxnISMZk6pEUGfeQmDj4f4rDmt4K0RMlw1h4COJe4r0Y4Yrwln74eEB7DySh2pGbF7+S7wjUAgK5bHYAE2DMUSGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777756817; c=relaxed/simple;
	bh=Pu/tX28v2FAF/Mgs9qjlzjTibFWaRnRiZEfdPz6zfFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWtSEC7E3x6ydzZ6pElg7PsUZ+For5GLBQuE3WzMQhYCFyD0tgJj2t0rzETbUf6RkG+VXaisJ2miihwUQPeoZLMqmWIltoKUajjN3kbCAX7pt+2eQJv9AcI3cL6ecohWgTx+zCiLN/7aT2+HpeXqpY70bI1VajnYD/d1itQrtzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8dgEBhA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8dgEBhA"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44a5174670eso907624f8f.1
        for <mptcp@lists.linux.dev>; Sat, 02 May 2026 14:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777756814; x=1778361614; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=47yOcsKJNwigpJrQBdq/3DEnuPRQMAPfdvAqAWYmghk=;
        b=o8dgEBhABY4AnhwP122GF986JYItkjtO48fPIAQFQYwltBWd7jzHwCcs0Ta5tuz6wQ
         Dvg4AdD6EVVzGQ4G3U0AI7eJuPINOSzy/rJezO2q/OZBkKzw80f9B0L8q96nm+AVbt7U
         +slELde5iPy5Lvu8cLp8/EQjhIDcj1xRWWOhYN3CgxE8di4d8kreDNhWiUz6oZfzBCLb
         b35WcoJEMKA5b0Fy8jXdBV7BB/q1ASPCArARiTb1bSEkiSJrReRiatAZdnt/1D818l5T
         s5cbBIg5jfUQJtvrbzhO9FDaU85ypt+okhWGc0tRokAr71YP9HACBw4xaVP9aOo6UpRd
         OIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777756814; x=1778361614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47yOcsKJNwigpJrQBdq/3DEnuPRQMAPfdvAqAWYmghk=;
        b=aaYjVwmkFikI+FhsPjkKZu6TXf7yWeKlE5AA1Uxgn0anFeVzsZmBkJ7unL5WqDCAqH
         Mp8tv5YBcbkkg+g7o/pnyPqS9bKyDWBCKycc/LMnHc5xv1wGLqTEubbku59SjMgq5U14
         juvRifhpmS7bVLlFal1pa8UsLkfbp/bq6MoR1FIFM+v6HQFFjSJvwiYG0kAVGbIvV3gn
         6ZO9rFTCt8HDRdwAXXFOGCWKUlpRm8Um79+G0lOg4uFDqxOxMVYsJEFhNInqneCd1C0j
         OPGYKrMVUfHmN+gJ8408sruaNSKRNdPfNTDyXAqZzkq6XmTBcK8zeIYQdCQzQYX1PcO2
         YdOQ==
X-Gm-Message-State: AOJu0YwhBvVH9vxxNkVzaETKuBB5U4e5/v0n1Syvi9uvJ5dbGIOEzMoC
	XxVNgGVAH/X/nzKw0XSBMVK2TwtdfUxWO/Zbs8wq/V8bKFr8gknBmNlWnlWC2zwl
X-Gm-Gg: AeBDievOB1wt9AEFaVYsPe3KOrPhcbbwiIGYUqYht3qoRImD/RNwRo9EZmgtxkcIUFa
	09Z9vi0sAm+N1oAzcUA6C5D+qA1tyE/0AcJmZw/wfiZq1cKPHoNzY/CD7Ykp9JCEuMHjayNUxkE
	gArx0IvdtS78ZKp53NRG/QekShIm+Ylw8SZWMYQgwHpuWMJ5yYIVxalt6bt7v47RJ1rUysAUtgu
	/fjmMG4FK0W112XGZI+mfjfdwyLljbe1Vq5B1O2p5DPNEI+TmK+41hu7jXjJTvvNIM1OhH4AQlZ
	oa7AyUMUaF4xH7Br3y71jIX04gZmtv/HGpjADWSgwOsIezBw2jLSYQrhqMaZHB8x1QTjYE8J/p+
	G8Rs3Et07B912djUthZOvKsDoUlL+PTkjSgdhzpgQaGZu0e2WM+8eZo0eSaPtYobkpQAlSbiOkb
	Ha3Af9EQpz3c79ELWywLh1RCb5UASOhbxmLk2rPnODGnJdkA5IyVMVqTGpSQART0GPlnxeEVQzu
	6JJezZnfvUEjzSdYw1rmA==
X-Received: by 2002:a5d:5d83:0:b0:44d:1338:46b4 with SMTP id ffacd0b85a97d-44d13384739mr1180762f8f.9.1777756813446;
        Sat, 02 May 2026 14:20:13 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981defb3sm19490140f8f.20.2026.05.02.14.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 14:20:13 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v5 0/4] mptcp: MSG_ERRQUEUE support on the parent socket
Date: Sat,  2 May 2026 22:19:56 +0100
Message-ID: <cover.1777756707.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPTCP already advertises IP_RECVERR/IPV6_RECVERR as supported, but the
parent socket does not currently provide usable MSG_ERRQUEUE handling.

This series wires the MPTCP socket up to the IPv4/IPv6 error queue
paths. It propagates RECVERR-related sockopts to existing and future
subflows, and lets recvmsg(MSG_ERRQUEUE) on the parent socket consume
queued TX-timestamp and MSG_ZEROCOPY completion notifications.

A prerequisite patch factors the per-flag inet_flags propagation in
sync_socket_options() into a mask-driven loop, so further inet_flags
propagated by MPTCP can be added by extending the mask rather than
touching the call site.

Patch 2 leverages mptcp_setsockopt_all_sf() for the setsockopt path
and extends MPTCP_INET_FLAGS_MASK with the four RECVERR bits, with a
single mptcp_setsockopt_recverr() helper covering both families.

Patch 3 splices subflow err skbs onto the parent at error-report
time, filtering by SO_EE_ORIGIN so user-data cmsgs (TIMESTAMPING,
ZEROCOPY, LOCAL) reach the parent socket while subflow-level ICMP
errors are dropped to avoid leaking subflow identity through the
single-path RECVERR ABI. A future MPTCP_RECERR channel is the right
home for those events along with the per-fd subflow lifecycle events
tracked by [1].

Changes in v5:
 - 1/4: replace the WRITE_ONCE() RMW with a per-bit assign_bit() loop
   so the per-bit atomicity of the original inet_assign_bit() calls
   is preserved (Sashiko).
 - 2/4: collapse the family-specific helpers into one
   mptcp_setsockopt_recverr() that snapshots optval into a local int,
   bumps msk->setsockopt_seq, and forwards via
   mptcp_setsockopt_all_sf() (Matthieu, Sashiko); skip
   family-mismatched subflows in mptcp_setsockopt_all_sf() (Sashiko).
 - 3/4: filter the splice by SO_EE_ORIGIN to forward
   TIMESTAMPING / ZEROCOPY / LOCAL only and drop ICMP / ICMPv6
   (Matthieu, Paolo); add mptcp_recv_error() to retry the splice on
   the pull side so a parent-side rmem-ENOMEM does not strand subflow
   skbs (Sashiko).
 - 4/4: unchanged.

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/78

David Carlier (4):
  mptcp: sockopt: factor inet_flags propagation into a mask
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover IP_RECVERR sockopt propagation

 net/mptcp/protocol.c                          |  66 ++++++++++-
 net/mptcp/sockopt.c                           | 108 ++++++++++++++----
 .../selftests/net/mptcp/mptcp_sockopt.c       |  55 +++++++++
 3 files changed, 203 insertions(+), 26 deletions(-)

-- 
2.53.0

