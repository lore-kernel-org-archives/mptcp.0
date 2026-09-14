Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21542466A
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379289; cv=none; b=d1KPsPghxBQQcvOaqO4WHqRzQrMPpn5IjsOO2mYtsJM+/FdwZVaH4vcw5ocnnECRE2E4NFbilZV1I7DRPCvn9uJUg8d4RySKnJV7RwCYXPenRa9lqFMAVHhQMG+n6YK+08DPdhrxZdOSvFghzDgiqFt96exw5H65LfxGT+40fw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379289; c=relaxed/simple;
	bh=uvms7JwxRity1Ng+3vOkCZDDhuo7gXhr5OBjQRjpmQw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BbrVaG1kdJGzW30fmaJ9lOdnqjtJNKGrnAtGDm72KO9KIVlFOVV2rg0+ltufT1Jp//C5x420xSy/XKzpJ2o6Fg+sueibcGCunGQRTZ7clLXAU2ju+TYx7fDEv/oT+8KLXqPRPC4uRB0IkZn4h+5Q0GnEv4IcXd7HAttF5Wupj4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP32biVl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP32biVl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257C71F000FF;
	Mon, 14 Sep 2026 09:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789379286;
	bh=4Hp101V4XNtrF38qV5eczWoEGuRLUxIl+LhTBtW7wHk=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=hP32biVlxI++yxnN58L6N0R82/rTL8TamN74dU0q9L8FjS4TGG5bCFs5gqVqmTevK
	 4OGqgi4XO380gSQbAsRe4imybW0yzow7BNIrFRsN2xSMef9Gh6eO/X/64NgjCA7jAx
	 j1RXSEiIt4ftmpO+KqNRjIsMwdPxkbXvoUcHkjiyeJJYj9O3N52IaW4wC0YQV/A6H4
	 uFSW5hDNuRc7dFEc5jZis/VB1a3aRXPXD4W8SoID9b4MK4Br74Fz+FGvCNGd0Ijhg7
	 X5Yr8sBD42RUwg6sDSmvsRn7sqHB3ELnAhUciZfHOXeiAeyi6IJlx7hhIYB87x9Ppw
	 KcTJ5wsQ3UJaw==
Message-ID: <20b73dd157c0e948ba2b33c3600f33097fab5299.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 00/16] MPTCP sockmap support
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 14 Sep 2026 17:48:01 +0800
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sun, 2026-09-13 at 18:14 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> v5:
>  - Patches 1-4 are from "Reduce the differences between TCP and MPTCP
> for TLS usage" set.

I put the four patches from the "Reduce the differences between TCP and
MPTCP for TLS usage" series here because this "MPTCP sockmap support"
series depends on them. Actually, it doesn't just depend on these four
patches - it also appears to depend on "mptcp: remove CB offset field"
(see sashiko's comments on patch 9) and "mptcp: implement peek_len for
proto_ops" (see sashiko's comments on patch 13).

So this series depends on the entire "Reduce the differences between
TCP and MPTCP for TLS usage" series. I could use "Based-on: <...>" to
trigger CI based on the dependency, but Sashiko doesn't recognize
"Based-on", so it won't be able to apply successfully.

Is there some Sashiko feature that can handle this kind of chained
dependency between patchsets? Or do I need to include all ten patches
of the "Reduce the differences between TCP and MPTCP for TLS usage"
series in the next version? I'd appreciate your thoughts on this.

Alternatively, let's first do the review of the "Reduce the differences
between TCP and MPTCP for TLS usage" series - it's already ready for
review - so that both the subsequent "MPTCP KTLS support" series and
this "MPTCP sockmap support" series can move forward more easily.

Thanks,
-Geliang

>  - More patches for sockmap support.
>  - Rename this set from "implement psock_update_sk_prot" to "MPTCP
> sockmap
>    support"
> 
> v4:
>  - Address Mat's comments: implement .read_skb to make the selftests
> run.
>  - Move mptcp_bpf_update_proto() from protocol.c to bpf.c.
>  - Include the "implement .splice_eof" patches in this series, as
> they
>    both modify mptcp_prot, mptcp_stream_ops and mptcp_v6_stream_ops.
>  -
> https://patchwork.kernel.org/project/mptcp/cover/cover.1787554581.git.tanggeliang@kylinos.cn/
> 
> v3:
>  - Address the comments by ai review.
>    - use WRITE_ONCE to set sk->sk_write_space.
>    - update the selftest, set a new key for client socket.
>  - Fix line length warnings.
>  -
> https://patchwork.kernel.org/project/mptcp/cover/cover.1773826662.git.tanggeliang@kylinos.cn/
> 
> RESEND:
>  - rebased.
>  - to trigger ai review.
> 
> v2:
>  - Include mptcp_bpf_update_proto within CONFIG_BPF_SYSCALL to fix
> the
> compilation errors reported by the kernel test robot.
>  - Add checks for IS_ENABLED(CONFIG_MPTCP_IPV6).
> 
> Implement psock_update_sk_prot, for basic MPTCP BPF SOCKMAP support.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/521
> 
> Geliang Tang (15):
>   mptcp: add sendmsg_locked to proto_ops
>   mptcp: track app-limited state in mptcp_sendmsg
>   selftests: mptcp: sockopt: check app_limited
>   bpf: drop duplicate check_app_limited in tcp_bpf_push
>   mptcp: implement psock_update_sk_prot for sockmap
>   mptcp: add sock_map_update BPF helper
>   selftests/bpf: enable MPTCP support in sockmap tests
>   mptcp: implement read_skb for sockmap stream verdict
>   bpf: export and generalize tcp_bpf_ioctl
>   mptcp: add TCP_REPAIR sockopt support
>   selftests/bpf: add MPTCP coverage to sockmap_basic
>   mptcp: add sk_is_msk() helper and use it in sockmap
>   mptcp: add SO_ATTACH_REUSEPORT_EBPF support
>   mptcp: add sk_select_reuseport BPF helper
>   selftests/bpf: add MPTCP coverage to sockmap_listen
> 
> Paolo Abeni (1):
>   mptcp: defer read_sock cleanup to mptcp_worker
> 
>  include/linux/bpf.h                           |  13 ++
>  include/net/mptcp.h                           |  12 ++
>  include/net/tcp.h                             |   7 +
>  include/uapi/linux/bpf.h                      |  19 ++
>  kernel/bpf/verifier.c                         |   8 +-
>  net/core/filter.c                             |  60 +++++-
>  net/core/sock_map.c                           |  14 +-
>  net/ipv4/tcp.c                                |   9 +-
>  net/ipv4/tcp_bpf.c                            |  40 ++--
>  net/mptcp/bpf.c                               | 172
> ++++++++++++++++++
>  net/mptcp/protocol.c                          | 114 ++++++++++--
>  net/mptcp/protocol.h                          |  20 ++
>  net/mptcp/sockopt.c                           |  21 ++-
>  .../testing/selftests/bpf/prog_tests/mptcp.c  |  27 +--
>  .../selftests/bpf/prog_tests/socket_helpers.h |  25 ++-
>  .../selftests/bpf/prog_tests/sockmap_basic.c  |  33 +++-
>  .../selftests/bpf/prog_tests/sockmap_listen.c | 122 ++++++++-----
>  .../selftests/bpf/progs/mptcp_sockmap.c       |   8 +-
>  .../selftests/bpf/progs/test_sockmap_listen.c |  25 +++
>  .../selftests/net/mptcp/mptcp_sockopt.c       |   1 +
>  20 files changed, 622 insertions(+), 128 deletions(-)
