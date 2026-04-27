Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D23373BE9
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324213; cv=none; b=kk+Y8wS53NKfpoy+msyxHKo0Y62rVN2vooBP9RRol8aUwwq8dGApxxkqas7SpR5H/xsurxi5Nw/2SGiv7kBztBcvXoYKexyYYoUWBE7m3p25LFvU/egLDa0jdL0IdXH6ZRLvydnXrrnCfZ+MAeZzkU7kxA/26wjHtRdboxB1HWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324213; c=relaxed/simple;
	bh=ZN27K3RCYO5I1aCfr2zlng19CFhx9WcnzmSjiyZCi5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXo8gQ1gwKL9AhyWWzCsi/RtBqvttWcT3BeuYHqQyLxXhN0JeRqEU38IoWF48VsG0TNy0ROMfJzCMYyq+Kzj1J58xpSOfJ0km9w4N9OM7EzLEoRBaDLfcVlcGWGAJDa6v+cwY2iw06u2o62qflN0blSFDZoQJ0cDh9PguseEnmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQOXlauU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQOXlauU"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so6936027f8f.0
        for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 14:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777324210; x=1777929010; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE//YQbv5HSdVFf+bGbucTb2jY2eZgZu0WJglyDjo4k=;
        b=dQOXlauUBgf8e3ErAj1nPqcESJYIpbqAI8ni/4mrCG4ZdPOc4uSMy595mtGuK5W8Np
         L9m2PxOOPXkItl/2bEnYnxAcZ0uqVz+goQ0swonnE/pNTAt6ytY3bGc+/31OygGfu1wi
         NedodX8/2UevKQ9tJORvZn4VjyA+n8nnFhK28ceHyr6N1ht/sqTgeFAhMTH3O5EtapK9
         vDny9v7/VperYBsqoChaNfwmXOHZOb9tj754lGz38gQ22HOCx+sP8p6VmYRBGnOBMfHC
         f3/ctM00bzi3tTMqeogi8T6YgYw1uXsYVx+dUw0jUi+h06EjmFSAIsVjHaA4UnruAc/4
         0ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777324210; x=1777929010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SE//YQbv5HSdVFf+bGbucTb2jY2eZgZu0WJglyDjo4k=;
        b=h2sInVXQC2HLrv8f6u5FXtorA+9azwgOo8P29n8F+gOTDpYGXLUhhKXI+kWQVPSiSS
         JAsCL8LrrEkVldt6AlkQfw9pkyaKSDatX0dBik5l8MHLSzs8/aV+2LP3QKpslz4M1Qxq
         9f8uEOZl/hW7GONeWngb3THtAEvZaBbp2u/4akuDnTLqE6wQ8bnzrk0ZBy7V2qT3qCBj
         VkVMYtr8723geB4hwMvJclcsNzcIEXxM2EXGsV/hxR5Yo5DSRfu1VdG4biAB86aDwrCa
         gsWAc+S3EqoDBdlCIqEFwOP2qv7mf0wLRo8OhPFodNejIMCtmwgAL5E8+dmbWSIjDFvK
         gVJg==
X-Gm-Message-State: AOJu0Yy7s9Zt8oGJv3t6DJktlZeDg5HUdSpmQeWUT285wi+wESNAdwHn
	K+GBaIV01vyMrUjw9VNrDV8Wa2t7LJHSnaoNmZC8+t3oFUZ/dfqn1Zz+JlIxr/DQ
X-Gm-Gg: AeBDiesmrJkw1nemg1zAZJ99OCm4L7P2aju9QG2FkhQikhAA5PTtFE+hRAXq1CVr7fr
	Sf72l66+HHR+S2aTGkhX7XTgPt6J35ospWeQ8EanlAi8BNVkPweTn8dW4DuedyFsj/JMdHreI3e
	KVZaxnIrYd3VCKhDFjs8TUUOv08xL92m4wl4UZxW/rRQl7Af0L3UFQ+CRGqckdexLL9P6QkoAib
	FicF80nK/HeLskDhwBlrBX1/pOyWnxsoh2QYPYgk01mCuK6AT2xvIfnu+1ddtWWxOvYm8dWDlsf
	MbiKjgkdgmQ+oA2LeJ1f7/qX0iLK3XdDlXqoMuhwNDgXQArUtHOOGNIuVG1bUpgrsmUm4qJmEDC
	wa3ncaUdlvsU86gtQGu8MJJGj7OHvuNRiqzKjF/emxuMs1fAvV2A0nTJpycJ9AaqK37t94uFPaE
	MvmgrsTfh1THrqjJiW1oocCABivwmekh+/GiHdpwDosgPIb0+WU86Xn8frU9glJI0bPBsuYwMaH
	uPLMOvuRhBqCtAM/Kfklw==
X-Received: by 2002:a05:6000:438a:b0:43d:c95c:5e75 with SMTP id ffacd0b85a97d-44648f28e79mr686297f8f.4.1777324209776;
        Mon, 27 Apr 2026 14:10:09 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d5ee9ecsm1107145f8f.16.2026.04.27.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:10:09 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v4 0/4] mptcp: MSG_ERRQUEUE support on the parent socket
Date: Mon, 27 Apr 2026 22:10:02 +0100
Message-ID: <cover.1777324037.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421223338.52743-1-devnexen@gmail.com>
References: <20260421223338.52743-1-devnexen@gmail.com>
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
parent socket, and lets recvmsg(MSG_ERRQUEUE) on the MPTCP socket
consume queued errors with the parent socket ABI.

A new prerequisite patch factors the per-flag inet_flags propagation
in sync_socket_options() into a single masked word copy, so further
inet_flags propagated by MPTCP can be added by extending the mask
rather than touching the call site.

Patch 2 then leverages the existing mptcp_setsockopt_all_sf() helper
for the setsockopt path and extends MPTCP_INET_FLAGS_MASK with the
four RECVERR bits, dropping the family-specific helpers from v3.

Based-on: <20260424-mptcp-pm-sockopt-set-all-sf-v1-1-38e7023822f8@kernel.org>

v3 -> v4:
  - New patch 1/4: factor inet_flags propagation in
    sync_socket_options() through MPTCP_INET_FLAGS_MASK, per Paolo's
    review.
  - Patch 2/4 (was 1/3): drop the mptcp_recverr_enabled() and
    mptcp_subflow_set_recverr() helpers; route the setsockopt path
    through mptcp_setsockopt_all_sf(). Inherit the four RECVERR bits
    via MPTCP_INET_FLAGS_MASK in sync_socket_options() instead of
    explicit inet[6]_assign_bit() calls.
  - Patch 3/4 (was 2/3): rework the MSG_ERRQUEUE plumbing per Paolo's
    review. Subflow err skbs are now spliced onto the parent msk's
    sk_error_queue from __mptcp_subflow_error_report() via the new
    __mptcp_subflow_splice_errqueue() helper. recvmsg(MSG_ERRQUEUE)
    on the parent reverts to plain inet_recv_error(), and mptcp_poll()
    only inspects the parent's sk_error_queue -- no more on-demand
    subflow walks, no extra lock_sock() / data_lock() in the poll or
    recv paths. Keep the original early-return structure of
    __mptcp_subflow_error_report() and fix the reverse christmas-tree
    variable order Paolo flagged.

v2 -> v3:
  - Only consume ssk->sk_err in the fallback / MPC-connect branch of
    __mptcp_subflow_error_report(). Steady-state MPTCP now leaves
    TCP's one-shot sk_err to TCP's own consumer instead of silently
    draining it via sock_error().
  - In mptcp_recv_error(), also route to inet_recv_error() when
    sk->sk_err is set, so a fallback-propagated error reaches userspace
    even when the parent errqueue is empty.
  - Scope the new selftest to IP_RECVERR sockopt propagation only.
    End-to-end errqueue delivery (TX timestamps, ICMP, zerocopy)
    depends on subflow-side producers that are out of scope for this
    series and will be covered by follow-up work. Fixes the
    mptcp_sockopt selftest timeout reported by the MPTCP CI on v2.

v1 -> v2:
  - Retargeted to mptcp-next per Matthieu Baerts' feedback (net-next
    closed during the merge window; iterate on the MPTCP tree).
  - Guard mptcp_setsockopt_v6_recverr() and its dispatch cases in
    mptcp_setsockopt_v6() with #if IS_ENABLED(CONFIG_IPV6) to fix
    the MPTCP CI link break on without_ipv6/with_mptcp configs
    (undefined reference to ipv6_setsockopt).

v1: https://lore.kernel.org/mptcp/20260421152216.38127-1-devnexen@gmail.com/
v2: https://lore.kernel.org/mptcp/20260421191337.58341-1-devnexen@gmail.com/
v3: https://lore.kernel.org/mptcp/20260421223338.52743-1-devnexen@gmail.com/

David Carlier (4):
  mptcp: sockopt: factor inet_flags propagation into a mask
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover IP_RECVERR sockopt propagation

 net/mptcp/protocol.c                          |  33 +++++-
 net/mptcp/sockopt.c                           | 107 ++++++++++++++----
 .../selftests/net/mptcp/mptcp_sockopt.c       |  55 +++++++++
 3 files changed, 170 insertions(+), 25 deletions(-)

--
2.53.0

