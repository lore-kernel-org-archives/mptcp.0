Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710448C8B0
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086565; cv=none; b=n1ULC3jIQ+M7Yc+qVuOZqCMZ/QgjCemV9NgTq31kmF6JEbQbYuBx2UWqMCRju90CT04N6BokEBZfYemlOUabSRGrNXFhvndMIXsd2IDdofoLREyzb7liM03eoc2L6fS6daZ96NdlBZyS496+3wXqlUf81DN50CosuY40nCwnCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086565; c=relaxed/simple;
	bh=qosT+ruvwITclDF0NJ68R4Aby8ekKJM8VfSsMWq/y/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBCQR0kGTAw86y4EF+mm+CMtzTppTC+tC+DSdQrmLeueZT0ZSIopjd3DFp2xmNcP9+F1h3pscgkcl2tTD8BocDNWH/6h8aaWK+42tjCvJX1MrHVGkYvElciX932Hs7hknGhnQEPIkhE1YaFECfBGpSndCgkFiFxnLhm7uHX4Pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwNKDi1c; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwNKDi1c"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b150559bso46441665e9.1
        for <mptcp@lists.linux.dev>; Wed, 06 May 2026 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086562; x=1778691362; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zJz68VAHZ5t5g+Gk/nEZDa9iG7OIx3Z96QaAXq0MJY=;
        b=MwNKDi1cGDX5kc7BCzoTuz4IYNyNVK+Dr44EyUvKCo7cTfA6+tAK/CloR832ZbgMlO
         K4TcQIJexuminp1VJ3T3lvvbytNxBdfKpG4iaHvDvMtTLfut0f6H3vo/jnbpWTpH/I1g
         9PxcvgwWol9euGkXnKH0tAUol3u3x0KNem1inXFRaMcb6D+hRQOrXi0VcYc2xQPuZlmb
         8VuiXgwxISTNZTj7yB3uJrEumDMb3EbQ8flazsQt9g/GZWBi+VCpgw3Wdt/AvpBxOCgR
         gJOEmDtIvtT9sHj6YejXWnky7F5hSXIC5Ctnp1cKdEAscKVHNmcPpC4WNbBq8adtYvEc
         CfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086562; x=1778691362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zJz68VAHZ5t5g+Gk/nEZDa9iG7OIx3Z96QaAXq0MJY=;
        b=KSerdeT7y91KJW0a5H2dt3bcxdjth4J6k627lJTwJ4pUZ/XixkBuD9E6CBDKrx7SVj
         YYFUWzGGaZ/FTx2bofvunBToFBWKcLvRoOG/rLA72NE4cQ3pIxNvf+L8SrVyQt2wkrEE
         V8SOErRjzr6ViBHLfa8SY93fptnN4smI807lkMFD2QYwtfTjHXuOaWhUKpDL7HfWiln3
         pAM92Eg4rUgz+a/X/YXoJIUJTk5/G9InTBrlY1gQsDmNrLm7ldh4L+u3jfPBt80cmArA
         Q3nVIQZl5Wepysofncc1RrcufJFQM2DHiNRA64H7uZpTQybxsVR1WwmEyfc04OOyYEVb
         m0tw==
X-Gm-Message-State: AOJu0YwrTbiF/sJmRJ7jsJc6u4m+ZhQcSzfi5CmA5TKW0J4h53EsmT1/
	ghdwyzq5t39j7lCZ3sYWSt52l4JLW3cMBx2lPKhcOL74S2qR2b6vAdb5tRQdviNXnw0=
X-Gm-Gg: AeBDies0wv9JjtAO+rLbKdp+Bt/h3B27q73J0dsTAEe4nNvQUDmLgbKxlIacznp9jn/
	//QZrr0hzFHI/rVuKOH8o+g6Po1f1nFdl4pEHhv10l8CS+quylDuMtu26X9gnyuLDo0ivTAGjS1
	VgkfVG950rZJHFoatLwWXnIVpcT7OQl2x6xa5EIv2kFzXeiWD2zTlQsaidhd694icYh5BqPZo7U
	HhTswRMZ2fbiAyvBZQR/RyVUMN2GusKamyqMeH84I4/HflAjbUvuKSodnjQif437m/u+jTQgwjA
	U6xeOvOROJ85XYJNo8cyJ54wxHJewNgkEdjhyCDM4HXMF9PtbMcWRibuKbA+Sffu+Yd7Fib+GCw
	cL7/c0FsycV2CEwIoNqkLXePaeFUkOT6vSz1d/SaNoZP8OD28L9maS+a8+KUXmAYWcj+lbDL9Gl
	8rtphra/NjdbvuJhjA4C0+1AmXUbWJqy9HnmEiavY8HyokqED7hZwMcvdSlZWNupojEHyO3DEUG
	V99IijDDXOycRrZrO866g==
X-Received: by 2002:a05:600c:a118:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-48e51f37363mr58100775e9.17.1778086562085;
        Wed, 06 May 2026 09:56:02 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm94586715e9.15.2026.05.06.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:56:01 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v6 0/4] mptcp: MSG_ERRQUEUE support on the parent socket
Date: Wed,  6 May 2026 17:55:52 +0100
Message-ID: <cover.1778086500.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets MPTCP applications use poll(EPOLLERR) and
recvmsg(MSG_ERRQUEUE) on the parent socket to drain TX timestamps,
MSG_ZEROCOPY completion notifications and SO_EE_ORIGIN_LOCAL events
that are produced by the subflows, the same way they would on a plain
TCP socket. ICMP-derived errors stay on the subflow queue: the legacy
RECVERR ABI cannot convey their per-subflow peer identity, and they
are intended for a future MPTCP_RECERR channel.

Patch 1 factors the existing inet_flags subflow-propagation hard-coded
list into a mask, so subsequent patches can extend it without churn.

Patch 2 makes IP_RECVERR / IPV6_RECVERR (and the RFC4884 variants)
propagate to the subflows. The parent stores the bit so MPTCP-aware
helpers can branch on it.

Patch 3 splices subflow err-skbs onto the parent's sk_error_queue at
error-report time. mptcp_poll() and __mptcp_subflow_error_report()
already handle the parent path, so user-visible behaviour matches
plain TCP.

Patch 4 is a selftest covering the propagation path.

Changes in v6 (addresses sashiko v5 review,
https://sashiko.dev/#/patchset/cover.1777756707.git.devnexen@gmail.com):
 - patch 2/4: take lock_sock() before the parent ip_setsockopt() and
   re-read the freshly stored RECVERR bit via inet_test_bit() inside
   the critical section, then propagate that to subflows. Two racing
   setsockopt() callers can no longer leave parent and subflows
   desynchronised. (sashiko v5 #1, High)
 - patch 2/4: drop the local 4-byte snapshot and pass the user buffer
   straight through to ip_setsockopt() / ipv6_setsockopt(), so 1-byte
   boolean writes (char on=1; setsockopt(.., IP_RECVERR, &on, 1))
   keep the same ABI as plain TCP. (sashiko v5 #2, High)
 - patch 3/4: drain the parent err-queue first in mptcp_recv_error(),
   then splice from the subflows. A previous splice that failed under
   rmem pressure is retried once recvmsg(MSG_ERRQUEUE) frees parent
   space, and the successful sock_queue_err_skb() re-asserts EPOLLERR
   so userspace knows to drain again. No permanent event loss.
   (sashiko v5 #3, High)
 - patch 3/4: use skb_queue_empty_lockless() in mptcp_recv_error()'s
   subflow loop, matching what mptcp_poll() already does. The plain
   skb_queue_empty() pointer compare tripped KCSAN against softirq
   writers. (sashiko v5 #4, Medium)

v5: https://lore.kernel.org/mptcp/cover.1777756707.git.devnexen@gmail.com/

David Carlier (4):
  mptcp: sockopt: factor inet_flags propagation into a mask
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover IP_RECVERR sockopt propagation

 net/mptcp/protocol.c                          |  74 +++++++++-
 net/mptcp/sockopt.c                           | 136 ++++++++++++++----
 .../selftests/net/mptcp/mptcp_sockopt.c       |  55 +++++++
 3 files changed, 235 insertions(+), 30 deletions(-)


base-commit: aa15c271d79edde595fb6f4eedb52fbc16325a83
--
2.53.0

