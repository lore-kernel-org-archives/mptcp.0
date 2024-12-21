Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B11799B
	for <mptcp@lists.linux.dev>; Sat, 21 Dec 2024 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734747164; cv=none; b=XMgjGCcwA11msHZmMEB5o2G2p7/ie3tERyyFbPXdI3NutlnVqfI/oQuXTtQ/oqw8EYKWLf1RJ+NWp07TOZ0T/reEeNCX1vWNWXadbEDU3+sjGu3xrhNKraELY0RaPtkdGyh5ykvza1ZmFqEUgjoDD+o1KgE8w7zuTILfy/1wSIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734747164; c=relaxed/simple;
	bh=ctQ5UTmXPpwGpSpWnXacM73iaW0hCG2nwid6LE0wkmw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=j8l/clPAbQX7rGV1RaVb2g/JCUkHCDK53BO3L5AfmOh9smrYNVslWVxpzH08KTQhzOKCXGzzb3UjQkIP+FqkR8f0V4YWjTmpQrVY9N/xKqQZIq0lVra+umfplBBrFis876I57SfSNfLqNSdxKfRzOZdv4Sl455j1c3+/bK8Pm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unGrPxzg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unGrPxzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9632AC4CECD;
	Sat, 21 Dec 2024 02:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734747163;
	bh=ctQ5UTmXPpwGpSpWnXacM73iaW0hCG2nwid6LE0wkmw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=unGrPxzg13RCY87GUNnPzR0c0ahjZ4AzGStvD821eLDDvakHz+YdrwQVMRjyJUJOF
	 1BRel8utCbztnZhDb3HWqybTVT6Ty4MBhi/BrIyodVkPziDt1zJYcIYd7wI+cK+9xZ
	 TqkLpRmu5r16iEHgtksB2EGiKkYXG2DpjyUtf/NvV+9xcfW2Zb02HOi3T0ANbaIiUS
	 8m9Td0hlk2M0dbnktZmy6SDSLqx7E0xhGkcq4+LIBZ84r3/A+5+pHR7GcTgCGn+xWJ
	 +c08q7afp9j9SpeGV/o1kU/mvsvw3jVFYFRgSYW1i2dWZ8dlHpokkLpMHv8wrovUT3
	 NeywJc17jfAqw==
Date: Fri, 20 Dec 2024 18:12:42 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 0/7] mptcp: rx path refactor
In-Reply-To: <cover.1733486870.git.pabeni@redhat.com>
Message-ID: <8782daf9-6f49-2eaf-9d4c-5176c8b9de5a@kernel.org>
References: <cover.1733486870.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 6 Dec 2024, Paolo Abeni wrote:

> This is a batch of changes I had sitting in my local tree for a while.
> Why another refactor you may ask? Two main resons:
>
> - currently the mptcp RX path introduces quite a bit of 'exceptional'
> accounting/locking processing WRT to plain TCP, adding up to the
> implementation complexity in a misurable way
> - the performance gap WRT plain TCP for single subflow connections is
> quite measurable.
>
> The present refactor addresses both the above items: most of the
> additional complexity is dropped, and single stream performances
> increase measurably - from 55Gbps to 71Gbps in my loopback test. As a
> reference, plain TCP is around 84Gps on the same host.
>

Hi Paolo -

Thanks for the v2 and for sharing the performance numbers - great to see 
such a dramatic improvement in throughput!

> The above comes to a price: the patch are invasive, even in subtle ways:
> the chance of destabilizing the implementation is real (ence the
> additional, intentional '-next' into the subj).
>

I think we will also need to be extra careful about monitoring stable tree 
backports that modify the affected functions. But to me the 
simplifications and performance fixes are worth it.

It will help to get this in to the export branch for further testing!

Reviewed-by: Mat Martineau <martineau@kernel.org>


> In any case keeping the patch hidden for longer was not going to do any
> good, so here we are.
>
> Changes from v1:
>  - fixed several data stream corruption and wake-up misses due
>    to multi subflows races
>  - added patches 1-3 mainly to address the above
>  - added an additional follow-up patch (patch 7) with more cleanup
>
> Paolo Abeni (7):
>  mptcp: prevent excessive coalescing on receive
>  tcp: fix recvbuffer adjust on sleeping rcvmsg
>  mptcp: don't always assume copied data in mptcp_cleanup_rbuf()
>  mptcp: consolidate subflow cleanup
>  mptcp: move the whole rx path under msk socket lock protection
>  mptcp: cleanup mem accounting.
>  net: dismiss sk_forward_alloc_get()
>
> include/net/sock.h   |  13 ---
> net/core/sock.c      |   2 +-
> net/ipv4/af_inet.c   |   2 +-
> net/ipv4/inet_diag.c |   2 +-
> net/mptcp/fastopen.c |   4 +-
> net/mptcp/protocol.c | 259 +++++++++++++------------------------------
> net/mptcp/protocol.h |   6 +-
> net/mptcp/subflow.c  |  33 +++---
> net/sched/em_meta.c  |   2 +-
> 9 files changed, 104 insertions(+), 219 deletions(-)
>
> -- 
> 2.45.2
>
>
>
