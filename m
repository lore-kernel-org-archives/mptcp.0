Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123446;
	b=J4y4mEtYuPnP92EtxFdvFzU2XsEzZh4GrAP6piIIqCYkloFoYXI6amxhwKBUiheUVi52
	 hYZ8CFizb0HQlFInUCd84+sXXbY76UeGoCd5bSOLDonf04XVDtOVMojEz/q1JwohLQqCG
	 N6b8M7nLBt2x8IPPcv0Jc1YkDT0w96wKVJRTAl+6hDimFRCNqbZ01m0o7xx4k6uCKgePe
	 JQ1pq8OVsej+dnF4EHwK4IA5TgjfJhlpNkIDbJ6ET/E9nIg+bmnBHYodwbL8eRXFJ+s62
	 q6W23s9yBZjH0PUisn6ZMpVGgDRbmvq8wZsX/ugQ3L6B42qGM8/cWAhcyuSHnxxc1NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123446;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hSwDllpxq/SPdMjFQ8KkhkcoYiTZWr9LYi5ZpGEiYQ0=;
	b=jpNsxF/9g0dP1gZE0Y31XOZUqUXooUgf2vYsbT5aV9wNX5NVNJJjYzSvwSsdym0U+pRo
	 4FALdWIMQJ0Z/mXSKTQYdHX+dPUPO1SSuYVzt6KPuPO2fVZf14K11dpL7PJ8V57vh5ybx
	 vLkeeg4iK7RbFl0tmb67G+LlrJ+p65eBWQuwoBmeFAMiB6jmNE/Ay84Huvht2f2PoLTel
	 wx4KJCtDPTbVzBJuKB3ta2+QD2+xHFamvLiOCMKEKDDahp6pvPkuyYEl4cNTe/POLoTs6
	 g75L0YvDQfIYLSyO3BFkGHaTPonPznPH10UOk3ZjaHkPPWFXmgxLXRTmcHNIj0EGftA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrBW1ePC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C98606A31C
	for <mptcp@lists.linux.dev>; Sun,  8 Nov 2026 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrBW1ePC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EFF1F008A1;
	Sun,  8 Nov 2026 07:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794123445;
	bh=hSwDllpxq/SPdMjFQ8KkhkcoYiTZWr9LYi5ZpGEiYQ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PrBW1ePCGsQ1UGTmgv29dwWKpww5NjZ9zeusvvI3ifubM0ATy7cn6WWx03yy+iXuY
	 VKUkdtcro+fCaH8SUr+6U48bMgGdGY9gd6NqM5y9Ex78X/ziSY6X5km/kj8Z6q/jFE
	 Ef1TYb4U7mgmVm8SAoQojCfkgtmhxVM7yuj/SdzLY7CFLI/DmwhVfWe66jABedR2bX
	 ADoXJRxTB945BPS7HJD980xKCkvJlRzfZotjhkmGh2v5LSV26z73u8PIGimV7V2A+f
	 iC8NJ9myPGtEXTFq3sbbgO91aKjQzRU35Bh6UixfW9xSywm3H4HXzbP8ZLcOXnt9RG
	 +HQotlECj8eJQ==
Subject: Re: [PATCH mptcp-next v23 2/8] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Sun, 08 Nov 2026 07:37:24 +0000
Message-ID: <179412344483.488855.6021417172691923264@kernel.org>
In-Reply-To: <9705c8c5686aca72e8bbaea893587f92bdd3306d.1793969127.git.tanggeliang@kylinos.cn>
References: <9705c8c5686aca72e8bbaea893587f92bdd3306d.1793969127.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] wait_for_remote_key() in
  tools/testing/selftests/net/mptcp/mptcp_connect.c only treats errno ==…
- [Low] The new TFO check in main_loop_s()
  (tools/testing/selftests/net/mptcp/mptcp_connect.c) fails the whole…

--

selftests: mptcp: connect: check TFO SIOCINQ overflow

This adds a SIOCINQ check to mptcp_connect's server mode when the MPTFO
socket option is enabled. The server polls MPTCP_INFO until
MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED is set, then fails if SIOCINQ returns
INT_MAX. ENOPROTOOPT from getsockopt() is meant to skip the wait for TCP
sockets and for MPTCP sockets that fell back to TCP.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..3a72bae43b906 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[ ... ]

> @@ -1176,6 +1180,28 @@ static void maybe_close(int fd)
>  		close(fd);
>  }
>  
> +static bool wait_for_remote_key(int fd)
> +{
> +	struct mptcp_info info;
> +	int retries = 10;
> +	socklen_t olen;
> +
> +	while (retries > 0) {
> +		olen = sizeof(info);
> +		if (getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &olen) < 0) {
> +			/* Not an MPTCP socket (TCP or fallback), skip wait */
> +			if (errno == ENOPROTOOPT)
> +				return true;
> +			return false;

[Severity: Medium]
Does this skip branch work for IPv4? On an IPv4 TCP socket, or an IPv4
MPTCP socket that fell back to TCP, getsockopt(SOL_MPTCP) seems to fail
with EOPNOTSUPP rather than ENOPROTOOPT.

The call goes tcp_getsockopt()->ip_getsockopt()->do_ip_getsockopt(), and
there:

net/ipv4/ip_sockglue.c:do_ip_getsockopt() {
    ...
	if (level != SOL_IP)
		return -EOPNOTSUPP;
    ...
}

The netfilter fallback in ip_getsockopt() only runs for -ENOPROTOOPT, so
EOPNOTSUPP reaches userspace unchanged. A fallen-back msk takes the same
path, because mptcp_getsockopt() forwards the call to
tcp_getsockopt(ssk, ...).

Only the IPv6 path returns ENOPROTOOPT:

net/ipv6/ipv6_sockglue.c:ipv6_getsockopt() {
    ...
	if (level != SOL_IPV6)
		return -ENOPROTOOPT;
    ...
}

So on IPv4 this helper returns false, and main_loop_s() prints "TFO:
timeout waiting for third ACK" and returns 1.

That looks like it would fail every IPv4 -o MPTFO transfer where the
server side is TCP or falls back to TCP. Examples are mptcp_connect.sh with
-t (the MPTCP TCP and TCP MPTCP transfers that run_tests_mptfo() starts
through run_tests_lo() for 10.0.1.1), -tt, or a manual
"mptcp_connect -l -s TCP -o MPTFO 0.0.0.0".

mptcp_sockopt.c already checks for EOPNOTSUPP after a SOL_MPTCP
getsockopt. Should EOPNOTSUPP be accepted here too, or should the wait be
skipped when the socket isn't MPTCP?

> +		}
> +		if (info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
> +			return true;
> +		usleep(10000);
> +		retries--;
> +	}
> +	return false;
> +}
> +
>  int main_loop_s(int listensock)
>  {
>  	struct sockaddr_storage ss;
> @@ -1207,6 +1233,24 @@ int main_loop_s(int listensock)
>  		check_sockaddr(pf, &ss, salen);
>  		check_getpeername(remotesock, &ss, salen);
>  
> +		if (cfg_sockopt_types.mptfo) {
> +			int avail;
> +
> +			if (!wait_for_remote_key(remotesock)) {
> +				fprintf(stderr,
> +					"TFO: timeout waiting for third ACK\n");
> +				close(remotesock);
> +				return 1;
> +			}

[Severity: Low]
Should a missed remote key fail the whole transfer? Not seeing
MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED within the fixed 100ms (10 x
usleep(10000)) only means the SIOCINQ precondition isn't met yet. It
doesn't mean the SIOCINQ regression happened.

The rest of the tool uses poll_timeout = 10 * 1000 ms. The third ACK
depends on softirq processing in the peer namespace. On a slow or loaded
CI VM (debug, KASAN or lockdep kernels), could it arrive after 100ms and
make the MPTFO group flaky? Would skipping the SIOCINQ check, or a longer
wait, be safer here?

Also, wait_for_remote_key() returns the same false for a real timeout and
for any getsockopt() error. This message always reports a timeout, so
errno-based failures like the IPv4 EOPNOTSUPP case above show up as
timeouts and the real cause is lost.

> +
> +			if (ioctl(remotesock, SIOCINQ, &avail) == 0 &&
> +			    avail == INT_MAX) {
> +				fprintf(stderr, "TFO SIOCINQ overflow\n");
> +				close(remotesock);
> +				return 1;
> +			}
> +		}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793969127.git.tanggeliang%40kylinos.cn
