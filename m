Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516873;
	b=YfnGViTLQGbjYD45pcDTntoCPuqJalH2w3E2mp8Z9kCANyfwwZH5EIzoCBqDPw68L4aF
	 uZc8BjOKeQDknYJgvfjf8kPc7oXKcll8kUou9UMYMJYnmShIydRhuj6pJHk33ZjVYfKpT
	 6tFh6kXmhS5C7f0nC0ko+eubLDZpQgCKG+1cHOwBiCepXpF1O8hDTDVHdqCtT0giEzQbt
	 zSsDoK0q4xrV9Mhn/KAZ4rW/c/kxZAG2nk85cqXB8Xc/O0UnhUk882DDuEYq+pVaYvrn/
	 ylP45ej1Ti5NtH3Zwf5Ys8WjQEYbxJSI0jpw88KuQX8OGJBB0VnjXSxRL/c01+X7N7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516873;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sE6ePLMMMHh+ZSJHFwXfOhRlLbg+XAg03wgRoUf1Sbo=;
	b=f/TGFuZU7V97yNbNRRbnpWhyCQtyZPNaDP3pYuPcxqL8kY78FPaRLpEbxrbw4Jub7lVX
	 qWTDruN3tXub0bpVdaLc4CToGzwsqxnxDUeK+1n1SnW+u0fZgSy0HJVeJ99BQt5MF2k5m
	 oQoxeaLH0AM1Is3WMEDTMag/g7tSXpbwcB7meHrU5h1eDWYHFA3siamcg0Nt8xzFhKlxz
	 qiGNOyTiacF7XOxUK+Q4scEmivt/9lCLsJwdW/EWn0hNMl+TtfHJYRKD37vGwVuT01nvw
	 H93JY31xx1ZU+0N9z5HJwxh+s/jLG9cVibQgUcJVW4NANBTdAwr34iF6IH6y+sbhd+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS2hDwvp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FD606A321;
	Tue, 24 Nov 2026 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS2hDwvp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4921F000C4;
	Tue, 24 Nov 2026 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795516872;
	bh=sE6ePLMMMHh+ZSJHFwXfOhRlLbg+XAg03wgRoUf1Sbo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bS2hDwvprKevfXXLmk6HqNrBpHnXCRuxmzRYXt8tWKlOe1Yj7Zqy4CnCkCMXLjUpj
	 gZeF770bHCehreTKxBZyDtlcjTsTQ1qzcRxQg6dSUIaiq3PEwh9buyfyl+s1Lyq2Xn
	 nYG6Jhc0m8qnPJ6jUDYWdWwthaRjFObmj/IniNUfuFbZkFREUIYutQ2Dao99Y1ti87
	 xZosc7DRWQn8MkqPqFThtHJ+uiLxRJL6TkVhClNvsuWApbIyJE+KgsUSKj5gwuqvjS
	 EOwJy+h/2gVHqpWAcjgk4fAZwJjRWxDiR+J4trAsq+Lt/L4tTLaq7Nj9mdMobGu+aj
	 79Bhq8VFSBFLQ==
Message-ID: <7da8ca7b-f985-402d-a314-454c9094eb44@kernel.org>
Date: Tue, 24 Nov 2026 11:41:09 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH iproute2-next] ss: move to its own directory and split up
 ss.c
Content-Language: fr
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, mptcp@lists.linux.dev
References: <20261119024049.3109143-1-stephen@networkplumber.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261119024049.3109143-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Stephen,

On 19/11/2026 03:40, Stephen Hemminger wrote:
> The ss command has grown over time and was a single large file.
> Move it and its filter parser to ss/ with their own Makefile, and
> split ss.c by function:
> 
>   ss.h        shared types, option flags and prototypes
>   ss.c        main() and option parsing
>   output.c    column layout and buffered output
>   sock.c      output common to all socket families
>   filter.c    socket selection and filter expressions
>   users.c     socket owners and SELinux contexts from /proc
>   service.c   port to service name resolution
>   inet.c      inet_diag dumps, kill and TCPDIAG_FILE replay
>   tcp.c       TCP, TLS and MPTCP details
>   sctp.c      SCTP details
>   bpf.c       BPF socket-local storage
>   unix.c, packet.c, xdp.c, netlink.c, vsock.c, tipc.c
>               one file per socket family
>   events.c    -E event monitoring
>   summary.c   -s summary

Good idea to split ss.c!

> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  Makefile                      |    2 +-
>  misc/Makefile                 |    6 +-
>  misc/ss.c                     | 5845 ---------------------------------
>  ss/.gitignore                 |    2 +
>  ss/Makefile                   |   21 +
>  ss/bpf.c                      |  337 ++
>  ss/events.c                   |   95 +
>  ss/filter.c                   |  927 ++++++
>  ss/inet.c                     |  580 ++++
>  ss/netlink.c                  |  205 ++
>  ss/output.c                   |  529 +++
>  ss/packet.c                   |  216 ++
>  ss/sctp.c                     |  140 +
>  ss/service.c                  |  246 ++
>  ss/sock.c                     |  276 ++
>  ss/ss.c                       |  603 ++++
>  ss/ss.h                       |  386 +++
>  ss/ss_util.h                  |   23 +
>  ss/ssfilter.h                 |   34 +
>  ss/ssfilter.y                 |  369 +++
>  ss/ssfilter_check.c           |  104 +
>  ss/summary.c                  |  167 +
>  ss/tcp.c                      |  623 ++++
>  ss/tipc.c                     |  119 +
>  ss/unix.c                     |  140 +
>  ss/users.c                    |  333 ++
>  ss/vsock.c                    |   87 +
>  ss/xdp.c                      |  170 +
>  testsuite/Makefile            |    2 +-
>  testsuite/tests/ss/ssfilter.t |    2 +-
>  30 files changed, 6736 insertions(+), 5853 deletions(-)

I was surprised that you ended up with ~900 more lines, but I think you
missed the removal of misc/ssfilter* files.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

