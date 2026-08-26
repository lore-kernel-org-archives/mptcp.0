Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D005A471273
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764469; cv=none; b=Ix5Gm4z2rMh9QZkKBWl5EPLdCM+As/gfO1CVHZLzsR10xd+ovKPUsPyFCPXTYwj/vDEdS3NOfz26ym5QKpwpC70JdFmXNEzpvkOrDY2QRdYM8BNex5o+IESE6kl2neeW0nwGAtw5L3VW+VlQ7DZ9vsj8IZUWfgUNh1bj2WXUUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764469; c=relaxed/simple;
	bh=FYU7KMAFHEMK0a2QdB7zYECmQAGqWOP3hrjJRZA4Zgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uX1GWy0DkpS95i+cF/iyyL2ga26qSvQWF1qLQSe4aaiZCysPT07SjMaeMRjSzKueEvs1D5UH76lWNWvQmf87L9wsCABSltO/f9OmmfvZ5sVmcWBqITgvpM/IiHUsjyMaf3y9scOpf8rG/omnaG4RtiUV+5eJnFUY85b/8A4p4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxEAX/qH; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxEAX/qH"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-855de2d0d4dso2428977b3.0
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764449; x=1788369249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3I8jJPf0z07/GaYv+UyScI71SC+rAjjfZUq3HdGlVP8=;
        b=JxEAX/qH9oXEmTK+WltBoQGREtB5qw5j7P0FEckWNH2wB/bkZ2lkC67TAJtuygdVll
         ikK4jaYKQUZ8FBw35GgASy+SvYCP6Hve+EAGv+LbWsNI/fhsPCE8ybGBYiLMBRMdO8Zc
         6Izqwlcs7iSOfuZu7iGb6fFjwwO0OFb6dx0W6b7ESDf9wUqlnvvsLgoVUXs5zx2vPnsh
         tP6v2TauAvkaHeeNTJOX2I8lUwRZZ0LANZ+Glynf6DsKHl+a9xg3QztJv+Ff6N7gtZAO
         TsMNIDAWEjfEOfWMnzWSgLGWDrpSqjf8gHKDMEvWA2/MVWLKrcgDwHgE1Cd+SXjyujTt
         BDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764449; x=1788369249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3I8jJPf0z07/GaYv+UyScI71SC+rAjjfZUq3HdGlVP8=;
        b=Q1FZPrc6JKxWnheuIK4hLANM7WyBZfGDGKohtAjLELGZd9t/ohxjc5jDQcH/Q/YHrw
         fRGfdi/y97h+XzLKvK+4qAquYG9Mi6pivinBg7M8Ca4vkghuMntYPGfXkQzP23652gpd
         2yHEEXOZvJfP9d0WzkARo0nvlLFYl9vwPozEeghmE9+/nFVd936SPZlrfWfKLc3N6A38
         UzyjuYrNwfWGA+q0BcukXD48qnLnfPILp0nHrQ9XcCvBsTsLtNvgX4/xsZFeBholhVN2
         NyfSitn5g7zMVA38YgUml4ng92cQxW/31n7rReeMeVbwdAZHVXzRFeKn5XroX60cf0Fi
         Q+Wg==
X-Forwarded-Encrypted: i=1; AHgh+RqU1QVXLAhR9CwcjgStIHmtNSkg33ya1W9obdEdzSs8tmX3L+Tvm4QqDXO0mHDTCKm/kSM/OQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nnxXzT517nbJHh74uzDh9bxXmFdy1z0j0YSH+20+BCFkY49Wzz
	FvifKgvJLl2M+fdndNTXBWkuYvpLo0M7Z2hsXR8PDvX5g+3YCFucGqMY
X-Gm-Gg: AR+sD10s86dLaKA3vMPI0wVhUIgzmYE9XHvo1kCntauoy/P0qE0stF1yU7l3Of1ybOJ
	SnwCiGhthNwqeVCIoGqb+o0dxDPRIkggGy0deJ7e8IEAAbBu/qRM0DsrCre/vZl1VuuUGQzzcqu
	V/IBixNTpr456UrQrMtcpkDHlk6usAZ79dJRfv6ypZXF6eL4vSiFtStCI4qSoOcKlA2YDCc6Du7
	LAXDOg0JilCVDnVKlFbPsnwOxa/ACdPCeAdRyFJ61UvU23H/uCmi+5CwOsOwyBXGPItmNEHLySY
	tDd2Hd7BogeCv+YlMNCAjx8VUPclcQ/nH8lcJUn/gbRQW6yU5OhpJh9mXsOvOVNjW3kdZfzQNqU
	o74oQTWCElhxdQRfDnwsl3w2HXoZpKAoLhX83Z/nxs7MyUcr6VGUV1V8oNSiUjThTKsQV4R8Juo
	T4MbMrPYAmPdo7XaDkgmbr9XG0+B26uwQNYAIgvusa6LYC9LKqOu3PHhaTH+NFungETaI=
X-Received: by 2002:a05:690c:3709:b0:826:f78b:8462 with SMTP id 00721157ae682-85a9ee40bd0mr3306087b3.7.1787764449016;
        Wed, 26 Aug 2026 10:14:09 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8570d620433sm19313287b3.42.2026.08.26.10.14.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 10:14:08 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@google.com,
	horms@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	yhs@fb.com,
	kafai@fb.com,
	andriin@fb.com,
	ast@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v2 0/2] tcp: fix use-after-free in do_tcp_getsockopt()
Date: Wed, 26 Aug 2026 13:13:42 -0400
Message-ID: <20260826171344.4133-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>

do_tcp_getsockopt() has two lockless reads of icsk_ca_ops. Since BPF
struct_ops congestion control made icsk_ca_ops point to dynamically
allocated memory, a concurrent setsockopt(TCP_CONGESTION) can replace
the pointer and free the old object while either reader is using it.

Patch 1 fixes the TCP_CONGESTION path by copying ca_ops->name to a
stack buffer while holding rcu_read_lock(). It also uses READ_ONCE()
for the lockless load and annotates every explicit icsk_ca_ops store
with WRITE_ONCE().

Patch 2 fixes the TCP_CC_INFO path by keeping the READ_ONCE() load,
ca_ops->get_info lookup, and call inside an RCU read-side critical
section.

Changes since v1 [1]:
- Add READ_ONCE() to both lockless icsk_ca_ops loads.
- Add WRITE_ONCE() to all six explicit icsk_ca_ops stores.
- Include the data-race annotations in the UAF series as requested
  by Eric Dumazet [2].

[1] https://lore.kernel.org/all/20260821182449.79785-1-blbllhy@gmail.com/
[2] https://lore.kernel.org/all/CANn89iKr1ypEFeL+7te3xWoNaK5AFyYQmr+pDh2zSZAxfgNKjw@mail.gmail.com/

Cen Zhang (Microsoft Security FORGE Labs) (2):
  tcp: fix use-after-free in do_tcp_getsockopt(TCP_CONGESTION)
  tcp: fix use-after-free in do_tcp_getsockopt(TCP_CC_INFO)

 net/ipv4/tcp.c           | 18 ++++++++++++++----
 net/ipv4/tcp_cong.c      |  4 ++--
 net/ipv4/tcp_dctcp.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 net/ipv4/tcp_output.c    |  2 +-
 net/mptcp/protocol.c     |  2 +-
 6 files changed, 20 insertions(+), 10 deletions(-)


base-commit: f967455fb2a5a2079b9eb5823e9ccf359174bf9f
-- 
2.55.0
