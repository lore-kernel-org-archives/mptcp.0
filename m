Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA3284693
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798824; cv=none; b=MDzwWZf1kEyVY0KJueLB+6QQlLOgIQ65virZD8lXq9Ndf82bk7PCe2JWHXV3gP9JDSxmFp09BTOnx8M0gqZ8sep9Y/WSZWeUV5YDD11yK1oKrZbZ5CXvT29mnCw2ZJbExt848HG80zXM54o6ikKEIPrsQ0Bl5wAHgPx2U/975EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798824; c=relaxed/simple;
	bh=5t07SqB1TdeQfW1kcS6h+pQux8aD5e+2xEB60dDkqHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daHdbg5shCEpDJx1wxtnoZizt7Xibx2Rr3GI0/IugB5Y/dclObb1I7XNdtq1LSopPSKNXAjFrE+x1ggLOIG/s+naJs9VxmOE4NCKdAaWv+GENhUmYVOsiRusYFMAWIVBOR11SZkzrJU55gyD5ZhqmIRElg8zRoY0LmmAHVssjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPBqj+gx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPBqj+gx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ad135063so39457395e9.0
        for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 12:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776798821; x=1777403621; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAKHNXDLKhv2okVIs2YvyjoFJLt6j4iyOHytJReNXMU=;
        b=mPBqj+gxQYzYpmTrBYkW32WKvU50fJpP689fS7m61A6HnKwqEQ6pc28Yl1orj/1u50
         XqEWOPbPTJh/SHWEUb7g0q5by26/fpTmAc1izu9b9/epmf8dFnAQBa9gyYl6w1Hh3pHv
         kD2ZPQLK2CJoCUGAbrvjU1cjoI6lmyVsNrgIQydB6QNTFtPszvZVdtWG/74y9BgfCZk8
         MKwCiOniwwzKf1KAEeGYdCWQzlvvW+JiDHZ5kKQNcjie5YGqUE1lWxB+VAmE4l48QOUi
         uATKHK3FRJ+C+SGmKY/9c1HN6y1hk/kXv1hjeWO1noupdedFm2O1LcZv6+vsadv8meHR
         diSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776798821; x=1777403621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAKHNXDLKhv2okVIs2YvyjoFJLt6j4iyOHytJReNXMU=;
        b=IlZToDAYiHIZouH3hG79tG5ppsor6HqK1/gQpN7tS1fXs2WpBpKcO534XjjbT0eE1P
         jWuVTvLCaZG34fP5gZ48pfXRXOnWs1Bda3ZrW7DMUBiLbgXfNjitDQ0kNJmu9liVf6wA
         g0mNpRV2T5hGbuty5WCeqwfndwmsFPrTM+t6HItzA4HngV4FPV8PUZzNHfWk3E7ww0TW
         4hbZawPnrUaOcUUQmNIhWfD6yGVwOrh2tSqYL3eBspCXufMEiyGePC2T7RhPm0lqMPso
         Ua7PwNgUuow2Dt/4Qg+XYjwd6RGB1D3zO/0Mx6DUc84mkW5CfqnBDonjOObS2OnRIKLJ
         Cb7w==
X-Gm-Message-State: AOJu0YzqFjRlcj47b12x1vZSP4SJMQ7I4+CH7gp1caI8OUqvJJ8zPqHz
	sKlzR4UVWlmJ/6TMWuZqmu87QyL72s5g7BhMP2zSAv8B//F8BmgTDqI1Jzd2NHrgAVI=
X-Gm-Gg: AeBDietNOlsFeL7wd3Vk22r0g9SkT6RlICkLeg4dtdKJEwwPiI5Zc7bbtp0KZi6NxDy
	CPWYfk6iMQ077nQwS1DpUzVp4qgjE/pv+Ith/TaoqRqRaQmOtH78uC03tK/UwMnkeDIgZD5JI/o
	4IueIwaE4RbiDOaLQa9ukgMqoMZJb1E7zm2jO9mI5xQ0Y0p5ZyIua3vvBeG0XIII8IlxfbT6H/2
	amX5xNtP3Nk/3w23iod+JQj0vQseuD+WjdCbkpu9E+/aPw9Pw5vqaQZHBfYkriNFniddW6jMJu6
	zS6JaZCHfnR6iGmZQvb6pv9WCPlGICS0P9rt3LWMRMR8OAyqpbxX6BD2VtqWBLaunsdV6aCh2tT
	KT/GjtAmBVeV3sqSM9ccivsGctRBGn1eij0a88/Gy3PNqYSf+suSBkZkCUL3N43CXWOI3A3k6qa
	NVv/WvwuEtR+KycZ0ihUGWifoGhGU5eDsI8vOqfLEMi2Yu5/hYtBaaJ2eN0/4RnnVS527VljdSs
	QpTrsLTDfayy3sgaSML+sRiAVckUWWN
X-Received: by 2002:a05:600c:1da1:b0:488:d376:42cd with SMTP id 5b1f17b1804b1-488fb785901mr309051165e9.22.1776798820356;
        Tue, 21 Apr 2026 12:13:40 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm43859447f8f.29.2026.04.21.12.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:13:39 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v2 0/3] mptcp: MSG_ERRQUEUE support on the parent socket
Date: Tue, 21 Apr 2026 20:13:34 +0100
Message-ID: <20260421191337.58341-1-devnexen@gmail.com>
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
subflows, makes poll() report pending errqueue activity through the
parent socket, and allows recvmsg(MSG_ERRQUEUE) on the MPTCP socket to
consume queued errors with the parent socket ABI.

The series also handles mixed-family subflows by applying the matching
sockopt according to each subflow family, and avoids silently losing an
error skb if requeueing to the parent socket fails under rmem pressure.

v1 -> v2:
  - Retargeted to mptcp-next per Matthieu Baerts' feedback (net-next
    closed during the merge window; iterate on the MPTCP tree).
  - Guard mptcp_setsockopt_v6_recverr() and its dispatch cases in
    mptcp_setsockopt_v6() with #if IS_ENABLED(CONFIG_IPV6) to fix
    the MPTCP CI link break on without_ipv6/with_mptcp configs
    (undefined reference to ipv6_setsockopt).

v1: https://lore.kernel.org/mptcp/20260421152216.38127-1-devnexen@gmail.com/

David Carlier (3):
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover RECVERR and MSG_ERRQUEUE

 net/mptcp/protocol.c                          | 121 +++++++++++---
 net/mptcp/sockopt.c                           | 129 +++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.c       | 152 ++++++++++++++++++
 3 files changed, 384 insertions(+), 18 deletions(-)


base-commit: 4464afe97dc56e817a23b730979cbc6fc48f1912
-- 
2.53.0

