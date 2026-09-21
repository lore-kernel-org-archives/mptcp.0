Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5CD311967;
	Mon, 21 Sep 2026 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015957; cv=none; b=qLnMLlxmnulSxhAft+/Ls50yblqh9nd5ZHmis95aEfYO491ze0On4KFJ9S08ezRtFNggaUIolyam8xd9G/YcG4cPAQNjQ16KQkDffAmww4/fbz2yzy/9gnuQmoqwJYKwx19JMcOWGjwgmckZRi5lQelBZwsnal3Yqhe23MvV3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015957; c=relaxed/simple;
	bh=8048W0Qstxb4u3tk/L4QUyhCusDPnUgH/De2pFrlyKo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uzyZy1u0uBvvgCpL6/Tqwu8SsVoDGDtGTcYi/7sRjDttHHGXbvvDpSX6WeVF+NYv7RMuGg1T9s1Wnbgj11pk4g2rrqLeidSD61CdwwiGqMRN8E3EUd/ehlKufE6gxRQsoTUDxviXoe/7xtw10ySaSGGyA8Y7DzQ0e3mu6i/31Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrJy2ugp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrJy2ugp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0535C1F00898;
	Mon, 21 Sep 2026 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015955;
	bh=UeDScPBNmOh9XYy9jBfRdxGXrrZgiZJlCCknSYaZGCc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VrJy2ugpYA+6Tz1lBz+byaiIjhJVmevATI7bypr66T8XbNKJRIiFhsHtouH0DO6g7
	 9y+ockqbzD9RTjMZ04jBZB/Yo1IrnwKf1CP/MExuhpjIIIWGVEuVEM66Eq+eI2D5FV
	 s97W5b9l2g44Km9quUipnN8UZGEnKKffqDNhIOvPhhSOzvdJh3zj8hWzAVlJz6gPVI
	 1XO+C9eFb8Sz9IwVrNlQ1X8ctx1zhMapZ0jKL3OFOlxC/iiifXnhx67jdPpQHG25lL
	 /bTRlc7Q2ABQ36eXl6uqi0vVbO4Oc5oie3cYNjvFsuJHcFFJ7BVSwwBZqw3eF/F8w+
	 5lYM4kJLnrJsw==
Subject: Re: [PATCH net-next 4/4] selftests: mptcp: cover IP_RECVERR sockopt
 propagation
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 devnexen@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Date: Mon, 21 Sep 2026 18:39:14 +0000
Message-ID: <179001595456.2160803.1891677059727765271@kernel.org>
In-Reply-To:
 <20260918-net-next-mptcp-msg_errqueue-v1-4-dd77e1738248@kernel.org>
References:
 <20260918-net-next-mptcp-msg_errqueue-v1-4-dd77e1738248@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit subject claims the patch covers "IP_RECVERR sockopt
  propagation", but the new selftest `test_ip_recverr_sockopt()`…
- [Low] The "empty-errqueue EAGAIN contract" assertion added at
  tools/testing/selftests/net/mptcp/mptcp_sockopt.c:823-826 (`r =…

--

selftests: mptcp: cover IP_RECVERR sockopt propagation

This adds test_ip_recverr_sockopt() to the mptcp_sockopt selftest, which
sets and reads back IP_RECVERR / IPV6_RECVERR on the MPTCP parent socket
and checks that recvmsg() with MSG_ERRQUEUE|MSG_DONTWAIT on an empty
error queue returns EAGAIN.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index b6e58d936ebe..d68515b7903b 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c

[ ... ]

> @@ -769,6 +776,68 @@ static void test_ip_tos_sockopt(int fd)
>  		xerror("expect socklen_t == -1");
>  }
>  
> +static void test_ip_recverr_sockopt(int fd)
> +{

[Severity: Medium]
The subject says "cover IP_RECVERR sockopt propagation", but does this
test observe any propagation?  Everything here operates on the parent fd
only, and no subflow state is ever queried.

The MPTCP-specific work happens in mptcp_setsockopt_recverr() ->
mptcp_setsockopt_all_sf(), including the skip for IPv6 options on v4
subflows:

net/mptcp/sockopt.c:mptcp_setsockopt_all_sf() {
	...
	if (level == SOL_IPV6 && ssk->sk_family != AF_INET6)
		continue;
	...
}

and in sync_socket_options() for subflows that join later:

net/mptcp/sockopt.c:sync_socket_options() {
	...
	src = READ_ONCE(inet_sk(sk)->inet_flags);
	if (ssk->sk_family != AF_INET6)
		mask &= ~(BIT(INET_FLAGS_RECVERR6) |
			BIT(INET_FLAGS_RECVERR6_RFC4884));
	...
}

The read-back path, however, only reports the parent msk's own flag bit:

net/mptcp/sockopt.c:mptcp_getsockopt_v4() {
	...
	case IP_RECVERR:
		return mptcp_put_int_option(msk, optval, optlen,
				inet_test_bit(RECVERR, sk));
	...
}

with mptcp_getsockopt_v6() doing the same for inet6_test_bit(RECVERR6, sk).

So if the subflow forwarding step and the sync-on-join masking were both
deleted, would this test still pass?  Would it be more accurate to say the
test covers the parent-socket set/get round trip, and to note that subflow
propagation is not asserted?  IP_RECVERR_RFC4884 / IPV6_RECVERR_RFC4884 go
through the same kernel paths and are also not touched here.

> +	struct iovec iov = {
> +		.iov_base = &(char){ 0 },
> +		.iov_len = 1,
> +	};
> +	struct msghdr msg = {
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +	};
> +	int one = 1, zero = 0, val = -1;
> +	socklen_t s = sizeof(val);
> +	int level, optname, r;
> +
> +	switch (pf) {
> +	case AF_INET:
> +		level = SOL_IP;
> +		optname = IP_RECVERR;
> +		break;
> +	case AF_INET6:
> +		level = SOL_IPV6;
> +		optname = IPV6_RECVERR;
> +		break;
> +	default:
> +		xerror("Unknown pf %d\n", pf);
> +	}
> +
> +	r = setsockopt(fd, level, optname, &one, sizeof(one));
> +	if (r) {
> +		/* For older kernels not supporting IP(V6)_RECVERR yet */
> +		if (errno == EOPNOTSUPP && !expect_all_features()) {
> +			fprintf(stderr, "IP(V6)_RECVERR not supported, SKIP\n");
> +			return;
> +		}
> +
> +		die_perror("setsockopt IP(V6)_RECVERR on");
> +	}
> +
> +	r = getsockopt(fd, level, optname, &val, &s);
> +	if (r)
> +		die_perror("getsockopt IP(V6)_RECVERR on");
> +	if (s != sizeof(val) || val != one)
> +		xerror("IP(V6)_RECVERR on mismatch val=%d len=%u", val, s);
> +
> +	r = recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
> +	if (r != -1 || errno != EAGAIN)
> +		xerror("expected empty errqueue to return EAGAIN, r=%d err=%d",
> +		       r, errno);

[Severity: Low]
Can this check tell the errqueue path apart from the ordinary non-blocking
empty receive queue path?

The branch it aims at is:

net/mptcp/protocol.c:mptcp_recvmsg() {
	...
	if (unlikely(flags & MSG_ERRQUEUE))
		return inet_recv_error(sk, msg, len);
	...
}

If that branch were gone, the normal receive loop in the same function
would still return -EAGAIN for a connected socket with nothing queued:

net/mptcp/protocol.c:mptcp_recvmsg() {
	...
		if (!timeo) {
			copied = -EAGAIN;
			break;
		}
	...
}

Since test_ip_recverr_sockopt() runs before connect_one_server() moves any
payload, the data queue is empty by construction and MSG_DONTWAIT is set,
so both paths return -1/EAGAIN.  Would something like checking that a
queued TX timestamp is actually returned, or that the one byte data buffer
is not consumed, make the assertion discriminating?

> +
> +	r = setsockopt(fd, level, optname, &zero, sizeof(zero));
> +	if (r)
> +		die_perror("setsockopt IP(V6)_RECVERR off");
> +
> +	val = -1;
> +	s = sizeof(val);
> +	r = getsockopt(fd, level, optname, &val, &s);
> +	if (r)
> +		die_perror("getsockopt IP(V6)_RECVERR off");
> +	if (s != sizeof(val) || val != zero)
> +		xerror("IP(V6)_RECVERR off mismatch val=%d len=%u", val, s);
> +}
> +
>  static int client(int pipefd)
>  {
>  	int fd = -1;
> @@ -787,6 +856,7 @@ static int client(int pipefd)
>  	}
>  
>  	test_ip_tos_sockopt(fd);
> +	test_ip_recverr_sockopt(fd);
>  
>  	connect_one_server(fd, pipefd);

Since the option is switched back off here before connect_one_server()
runs, no later part of the test can observe the option state on subflows
either.  Was leaving RECVERR enabled for the rest of the run considered?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918-net-next-mptcp-msg_errqueue-v1-0-dd77e1738248%40kernel.org
