Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C230269D18
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395574; cv=none; b=OLk44guXsGCBMSn1i6az22sv8Y8NPY37hBYS/JF08/kPjB1i8HEMGUYAyFFhMNlnSFFEdE5AYua3QYzCID4T4ZC58uo02CzmU7HIhogIPUkwEhTWBEC/BnXaEoY5DTOALfA6896yO+wv/7PUb3CmivV03PWvdOOldOSIh9AcvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395574; c=relaxed/simple;
	bh=hJ0At0S1WYIoZRuM3MTkHnKiz8hXAw9lrFqef1mxF50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATblnswGjyiRvp8Gco2w6XUEyuqAtncywx3GHWOT5A6cAjsLdR0uAoLUWyR2LfmtBlzaiDKeeXkC3kGST9wqgvez4ouYfyAIt4k+s5iRBYfxcnyYd78DNavoc9yXilgWM8V9I2c3YmY/jbV9sl+s9/NtOjmVpUtByHgsrWg9LRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYwGJlQB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYwGJlQB"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f97d310caso1665992f8f.2
        for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 00:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785395568; x=1786000368; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8A48b86Q8tzhL6JgqpOj7us+/7g5P8hkVgC8RTpeQFI=;
        b=lYwGJlQBjkDE//iAagTf25NyjZO7eN11WOSgb9C0dI4ZQP+0bzbpq6DeJ/lp+cyvOb
         1QyzBA5oEO+b7WzxM+s5pgR/7FxLAUEgkzJGwXLal+bxy2TuX9dl2FtlgObi525Mz3wh
         ZmovvwybfQvq443/FloEDe9uBbnXhLkN6i7ixJJ0UXiH5Je6/FsY7EbqKh2Y6+y81C6d
         ICdQiNxaLEB5xXwbKeHtgp5OtlfmGY1KpsbKIph9rY2tksdahhNjhnS4HJKdH9RaS139
         abviKuXRYD6d0P5/VtsyoXskgRtu3Wn5lyZp2JgVOq0AlY8Igyr/RJsQBlQ7bGLvyRYc
         7KCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785395568; x=1786000368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8A48b86Q8tzhL6JgqpOj7us+/7g5P8hkVgC8RTpeQFI=;
        b=P7umSaPYGwk7kIN7xNFdg5hvyFCMTJQcGYtZJGRAecuaZayCPVWYITELYCaJgmrcCh
         PftoSaJuO3atiGXRvIWcCPD0OsR2gL5sgquA4BAbM8VrdNcW9IgSsBlDh9OEuPBJNHNP
         ZlrdirnNFwKV92uZASayejcx2OKHnjUrXFdUvHPqmOBxbtkDfLV+EoNHxrXrzPamEUww
         90mwX69yb8m/prRNwSkBbGZoTIalvrGtg2a/90Ze07AIKiEFOpTc+8teZ7VFSi+Tji0x
         943LxIk3ZgAFvk5RPKjamkC24pAsa8KgN5+H8In/3P8a+x0hmJXeoAWwhSjewY5L97pt
         mHGQ==
X-Gm-Message-State: AOJu0YxN43urfSTz2HZDEpS9g1IpGABJA7GJKrY8wJYiwiRlgdRs2zT6
	dZFd/BQn1gQD/x/CifibaCIrZa2vtA0KLvr32c3v5Fj8AMTc1CPyX6E3lYB1fQ==
X-Gm-Gg: AR+sD138VqaXB09IgVBfQ2zYzt9Gc4vNw06a20MKFH9zRBZrpT7pOLiPNisdZi9S2l8
	Heiof5V92FxX4MYpNZPKfVhRvsn1ZPQtBREXTwuXqFExP6k1K/qODvX++tCIst0OQzn3/8Q0N0g
	xO77U09z/iAesUCqlXSN/J0+rKmVHSSm2ZCDVL/pKC17mnhAuo8n0dxEN24U0ua2MDfIjGkLIRO
	0aV4S3WQjZsdRFVUeoQ2NUkxpRKrJyXKb6kmF1kby+9NKFkJPhhcOEoGscoaxwTNf4Q8eHwjCf/
	9T8D2WPIKypchRTqzNj0tepJzxHqIkYXN/+ZPshZrWHXvmsQJiVAeGjoj33Rb/aWRq3mKvz2dD5
	dS1hDeBNXZ3QIW9GvVfrl52UgjKpatS46e3FbVnEy6QDuWReWh1uGDHkNYHKaazNHWsChVIQQMe
	7XOtJ1lRk3lS80SVMsu3A8+Abqlg59La3P5+JEheoiviHGQo2EMh3o7Unmvrxi4/BFRSCjGWMXh
	13WvBto+3YSbGFOLMnOtgBQEGoa72CGkoavl99rNPOFh9Tx
X-Received: by 2002:a05:600c:19cb:b0:497:fefa:6728 with SMTP id 5b1f17b1804b1-49800ea4a20mr17055615e9.24.1785395567438;
        Thu, 30 Jul 2026 00:12:47 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d6e5bsm3821717f8f.3.2026.07.30.00.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:12:47 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	pabeni@redhat.com,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v12 0/4] mptcp: MSG_ERRQUEUE support on the parent socket
Date: Thu, 30 Jul 2026 08:12:40 +0100
Message-ID: <20260730071244.69473-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets MPTCP applications use poll(EPOLLERR) and
recvmsg(MSG_ERRQUEUE) on the parent socket to drain TX timestamps
through the standard inet ABI, the same way they would on a plain TCP
socket. ICMP-derived errors stay on the subflow queue: the legacy
RECVERR ABI cannot convey their per-subflow peer identity, and they
are intended for a future MPTCP_RECERR channel.

Patch 1 splices subflow err-skbs onto the parent's sk_error_queue at
error-report time. All forwarded events go through sock_queue_err_skb(),
which re-homes skb->sk onto the parent and charges sk_rmem_alloc, so the
parent's error queue stays bounded by sk_rcvbuf and is dropped under rmem
pressure, matching tcp's tx-timestamp path and ip_icmp_error() /
ipv6_icmp_error(). mptcp_recvmsg(MSG_ERRQUEUE) forwards directly to
inet_recv_error(), and mptcp_poll() advertises EPOLLERR purely on the
parent's sk_err / sk_error_queue, matching tcp_poll().

Patch 2 factors the existing inet_flags subflow-propagation hard-coded
list into a mask, so the next patch can extend it without churn.

Patch 3 makes IP_RECVERR / IPV6_RECVERR (and the RFC4884 variants)
propagate to the subflows. The parent stores the bit so MPTCP-aware
helpers can branch on it.

Patch 4 is a selftest covering the propagation path.

Changes in v12 (addresses Paolo's v11 review):
 - reordered the series so the core MSG_ERRQUEUE infrastructure lands
   first, before the sockopt plumbing that exposes it to user space.
   The former patch 3/4 is now 1/4.
 - 1/4: narrow mptcp_errqueue_skb_forwardable() to
   SO_EE_ORIGIN_TIMESTAMPING. SO_EE_ORIGIN_ZEROCOPY and
   SO_EE_ORIGIN_LOCAL events cannot be generated on an MPTCP parent
   today, so the helper only needs extending if and when they can be.
 - 1/4: trim the block comment above sock_queue_err_skb() and the
   matching changelog paragraphs, now redundant with the narrower
   filter.
 - 2/4: reverse christmas tree declaration ordering in
   sync_socket_options().
 - dropped the Suggested-by: Paolo Abeni tags from patches 1-3.
 - rebased on current export.

v11: https://lore.kernel.org/mptcp/20260531145955.322337-1-devnexen@gmail.com/
v10: https://lore.kernel.org/mptcp/20260529174524.260199-1-devnexen@gmail.com/

David Carlier (4):
  mptcp: support MSG_ERRQUEUE on the parent socket
  mptcp: sockopt: factor inet_flags propagation into a mask
  mptcp: propagate RECVERR sockopts to subflows
  selftests: mptcp: cover IP_RECVERR sockopt propagation

 net/mptcp/protocol.c                          |  54 +++++--
 net/mptcp/sockopt.c                           | 153 +++++++++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.c       |  55 +++++++
 3 files changed, 228 insertions(+), 34 deletions(-)


base-commit: 6201be839b36e8dd22a23b9b367388ed900a257f
-- 
2.53.0

