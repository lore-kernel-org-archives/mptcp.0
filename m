Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A578635D
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785132274; cv=none; b=COfN83mbz6miKBKTk5s8bJuz9pq7QAsbfYRZFZPPupxdkNaAokZhZycoIL0JZ+IA14i+FZarDnso2r0KQ1/+eMreR19WzuVT4qq3s4r/sxXYfDcHYwBKqv/TxswEuTUQcK6gc58mrmE0puk2PnLwOu6OkJU4gVkmF+XH1Pz1OPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785132274; c=relaxed/simple;
	bh=XEOZdAUaRD9DAB3SkV8wDCvx1MgH+dzROrI1eOxCg+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jhsdcje0EvjOlTcJHenMTy6SGc+z5DIJEdyJ7UoDqmiwxetUExK1WaElv7+XSfAK81QMKLL/aQeVqYG3GOL9BmhjqT+hC8B6Mi/zf9pC8nJsQDKxcL/q+Mjx8QTPZ8iKuNV6MXwNoJbyzvineKfYHkdd12JXw5X16qt/9GE5FHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8+Recfh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8+Recfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF0E1F000E9;
	Mon, 27 Jul 2026 06:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785132273;
	bh=7ZaELvY2J+0bHRXLUPm/xZshY5z3GWQZHpD56t13z3E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P8+RecfhK1pA9lE1jYnc92AMwecq7seiX0aoyfSLYIQW4uAS9u1QMg0br19sons1G
	 Zts9sG4VuXlfH30Vu1DGbQpW+GtuJFa4PaLULsS8Rga6//Z+08PSgVZ0DmurRf477i
	 nscUv7Rz6RZjRWJG8tkGh34WAKkMIZcJ4hRUPiTt+sR7lL3HtL/29B6mnfZMo3Ldi0
	 y9czqaRkYH0yG68SUmRaKi5lqkI80DFKF3oDkd/wvGOwaBnnoLSGz25EPbLbzm9a2v
	 KJXTJSsT9KDs8d+CMe3KuycqXohhL9lz+HyYlaZlNbxOEWvuWIVmRDvsr082vh90uV
	 crf+PHqwDTN7w==
Message-ID: <7769654745b0fc72ac1a2a9c697ead37dc841666.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 0/7] mptcp: add bpf_setsockopt support
From: Geliang Tang <geliang@kernel.org>
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Date: Mon, 27 Jul 2026 14:04:27 +0800
In-Reply-To: <20260727022849.20923-1-gang.yan@linux.dev>
References: <20260727022849.20923-1-gang.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gang,

On Mon, 2026-07-27 at 10:28 +0800, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> Hi, Matt, Geliang, Paolo
> 
> Patch 3-4 have been reviewed by Paolo before, and ready for merge
> [1][2].

Do not put unrelated code into a single series. This series is for
adding bpf_setsockopt support; other patches do not belong here.

> 
> Changelog:
> v3:
>   - Patch 2 keeps the mptcp_setsockopt_all_sf as Geliang suggested.

I recommend that you hold off on sending this patch for now: "Let's
wait until IPV6_TCLASS is merged before posting this patch." Rather
than keeping an unused mptcp_setsockopt_all_sf.

Do not send code that has not passed compilation to the mailing list.

> v2:
>   - Patches 1 and 2 are new in this series; they address TCP_MAXSEG
>     handling in the bpf_setsockopt() path.
>   - Patch 4 adds an early return to fix msk->sk_rcvlowat being
>     unexpectedly modified, an issue seen in v1.
>   - Patch 5 makes the hook safe for the non-tcp master socket: it
> guards
>     bpf_sock_ops_cb_flags_set() with sk_is_tcp() to prevent out-of-
> bounds
>     heap reads/writes through tcp_sk(sk)->bpf_sock_ops_cb_flags, and
> does
>     not set is_locked_tcp_sock for the msk (unlike tcp_call_bpf()).
> That
>     flag authorizes the verifier's direct tcp_sock-offset field
> accesses;
>     since the msk is not a tcp_sock, leaving it at the default 0 is
> safe.
> 
> v1:
>   Link:
> https://patchwork.kernel.org/project/mptcp/cover/20260713095735.1222033-1-gang.yan@linux.dev/
> 
> [1]
> https://patchwork.kernel.org/project/mptcp/patch/20260522-sockopt_lock-v5-2-108629a46e98@kylinos.cn/
> [2]
> https://patchwork.kernel.org/project/mptcp/patch/20260522-sockopt_lock-v5-4-108629a46e98@kylinos.cn/
> 
> Gang Yan (7):
>   mptcp: drop unused @max arg of __mptcp_setsockopt_set_val
>   mptcp: take TCP_MAXSEG handling into __mptcp_setsockopt_set_val
>   mptcp: use sockopt_lock/release_sock in sockopt
>   mptcp: reject sockopt requiring ssks' lock in BPF context
>   mptcp: enable bpf_setsockopt on the master socket
>   mptcp: add TCP_CONNECT_CB sock_ops hook
>   selftests: bpf: verify mptcp bpf_setsockopt from TCP_CONNECT_CB
> 
>  include/net/mptcp.h                           |   9 ++
>  net/core/filter.c                             |  10 ++
>  net/ipv4/tcp.c                                |   1 +
>  net/mptcp/protocol.c                          |   6 +
>  net/mptcp/protocol.h                          |  29 ++++
>  net/mptcp/sockopt.c                           | 127 +++++++++++-----
> --
>  .../testing/selftests/bpf/prog_tests/mptcp.c  |  61 +++++++++
>  .../selftests/bpf/progs/mptcp_setsockopt.c    |  32 +++++
>  8 files changed, 223 insertions(+), 52 deletions(-)
>  create mode 100644
> tools/testing/selftests/bpf/progs/mptcp_setsockopt.c
