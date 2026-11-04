Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812596;
	b=dQsAxCEzphfBvQecI6psdjGaEvbAvSVQ+xGt8s57LepY6wSTSqnSHS3tzSTxzjZ2stq/
	 VR1/O8YsIOfit981ZHSiBDjPWM3dphA7L46Fn6SnzdPbzV7H8fJbzC48YWrHTIhN94vYK
	 IbQXnuKNp48zOnmMXIQGCQ46hlAYalP8YX9QHCUo24zFGLH+LgBjkF9iwt4blYwDgz+2x
	 lusP7Z50YL2jVPmTgbaQhkWG2/jhMWyT1h6+GttLCXqz5kodfWOyxDA6YiRQdr1zyylQw
	 aEjNEgtJWzsLA6prmPt87BwIL8IAJ1Dg8LpQaQIjTOUt+KWTlEg+8AbgwM8BZ+7BYjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812596;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=N+UXLjumTtUBB6cL67Ri+n4BcGaLklR6vgquMIM3Bjs=;
	b=KMoh82cL99F7S96Kiuvf/RxUjOvjuYN0J5nVG9vtwZYBJNGfOPRq92wt948hpqT6X0Xi
	 uATFSqc+2v80V4+cLF6GcnhYv9LBEHlmRHAn8RRacODWIse5mvAfUXboiAp+M9Ke+PMpD
	 4cr/V3ebPKt7mYnCxf9xA6UkpckQNdRIqllHCi5wUgI4eAfqzj0lOz2aLZ3fRfBIJk57g
	 1uFc/zW7JC0BX08M68LA7wX4ElRZCovllxYnQ2IMeRV9QDfbEvA9O7cezRvipDeQ8vbgK
	 gN/SRvKDfCyqnGTVq7JnlOYBikSJET9NPlJu2NKj5O7CZKRfVfks2XeekveQKD95/kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATHVli+g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6327606A328
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATHVli+g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8285A1F00919;
	Wed,  4 Nov 2026 17:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793812595;
	bh=N+UXLjumTtUBB6cL67Ri+n4BcGaLklR6vgquMIM3Bjs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ATHVli+gfCRL8+p9Tz8nkFKqT9FHIdtv1bOCBpjemKQ/XPVEV0uEzFg4tyTRIyHdx
	 89Zafl4QtkS/bOpgJlOTbati/30USuNkcuktupvOeJbqLN0Q/tXv5ihvDzpDUIrlaT
	 8iBzGM+BMRQdEKPAc9UOEYkdnGq7CzDQHnPihXVMBRZXMQZTrN2DV+TUE1SDhglwec
	 aleFr0cC6qEvNEpc0zwNU9VoKgn65gufm794/7p8P2mDzzNmPfa3Q+8jit7rxDssPX
	 /HaUGyy649wspA/4fUGrKj2LyB1JMDyYNMsCMIMFgWhczFTc6jd1Wmt+/FsQwPDi8l
	 14AT+dQOq1F3Q==
Subject: Re: [PATCH mptcp-next v5 3/7] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Wed, 04 Nov 2026 17:16:35 +0000
Message-ID: <179381259511.488855.11814425654213644766@kernel.org>
In-Reply-To: <b56df4ffba6a0af45ccda5d6be2da1d74acad265.1793676064.git.tanggeliang@kylinos.cn>
References: <b56df4ffba6a0af45ccda5d6be2da1d74acad265.1793676064.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new check in main_loop_s()
  (tools/testing/selftests/net/mptcp/mptcp_connect.c, lines 1210-1223)…
- [Low] The commit message of "selftests: mptcp: connect: check TFO
  SIOCINQ overflow" gets the bug and the check placement wrong, and does…

--

selftests: mptcp: connect: check TFO SIOCINQ overflow

This adds a check to main_loop_s() in mptcp_connect.c that runs when the
MPTFO sockopt option is set. After accept(), the server polls the accepted
socket for up to one second. It then fails if SIOCINQ reports INT_MAX,
which is how the mptcp_inq_hint() TFO overflow shows up.

> When a TFO connection is accepted, wait for data to arrive using poll(),
> then check if SIOCINQ returns INT_MAX. This detects the overflow bug
> where mptcp_inq_hint() incorrectly returns INT_MAX for TFO connections
> due to map_seq sign extension issues.

[Severity: Low]
Is "map_seq sign extension issues" an accurate description of the bug?

mptcp_fastopen_subflow_synack_set_params() in net/mptcp/fastopen.c does
this:

    MPTCP_SKB_CB(skb)->map_seq = -skb->len;

skb->len is an unsigned int. The negation gives 2^32 - len, and that value
is zero-extended into the u64 map_seq.

The old mptcp_inq_hint() computed:

    READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq

This synthetic map_seq is not in the MPTCP DSN space, so the result means
nothing for the TFO skb. Even a properly sign-extended -len would give
ack_seq + len. That is still huge once ack_seq holds the 64-bit
IDSN-derived value.

> The check is performed immediately after accept() and before opening
> cfg_input, ensuring we catch the overflow in the initial TFO state.

The code polls the accepted socket for up to 1000 ms before it calls
ioctl(SIOCINQ). Is "immediately after accept()" accurate?

The commit message also describes the bug in the present tense. The fix
appears to be the preceding commit "mptcp: use mptcp_data_avail in
mptcp_inq_hint", and this test only passes once that commit is applied.

Could the commit message reference that commit, so readers and stable
backporters can tell that the two belong together?

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..b12afca2ce303 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1207,6 +1207,21 @@ int main_loop_s(int listensock)
>  		check_sockaddr(pf, &ss, salen);
>  		check_getpeername(remotesock, &ss, salen);
>  
> +		if (cfg_sockopt_types.mptfo) {
> +			int avail;
> +
> +			/* Wait for TFO data to arrive */
> +			polls.fd = remotesock;
> +			polls.events = POLLIN;
> +			poll(&polls, 1, 1000);
> +			if (ioctl(remotesock, SIOCINQ, &avail) == 0 &&
> +			    avail == INT_MAX) {

[Severity: Low]
Can this check in main_loop_s() pass without the TFO data path ever
running?

The check runs whenever -o MPTFO is set. It does not depend on whether the
accepted connection actually received data in the SYN.

In run_tests_mptfo() in mptcp_connect.sh, the first run_tests_lo call for
each address family has no cached TFO cookie:

    run_tests_lo "$ns1" "$ns2" 10.0.1.1 0 "-o MPTFO"

The server uses tcp_fastopen=2, which requires a cookie. So the child is
not created with TCP_SYNACK_FASTOPEN, and subflow_prep_synack() in
net/mptcp/subflow.c skips this:

    if (synack_type == TCP_SYNACK_FASTOPEN)
        mptcp_fastopen_subflow_synack_set_params(subflow, req);

In that case the map_seq = -skb->len skb is never queued. With the default
do_tcp=0, run_tests_lo does only one MPTCP to MPTCP transfer, so that whole
invocation cannot fail. Only the second invocation per family covers the
bug.

The poll() return value is also ignored, and the timeout is hard-coded to
1000 instead of using poll_timeout. TFO could silently stop being used,
for example with no cached cookie, TFO disabled, an early fallback, or no
data in the SYN. Would the test then still pass, with nothing in its
output to show it?

Also, only the INT_MAX symptom is detected. With the fix, mptcp_inq_hint()
returns mptcp_data_avail(). For a passive TFO msk that should be the TFO
payload length. A wrong value below INT_MAX would pass here, such as 0 if
the TFO skb was not counted.

The test knows how much data the client sends. Could it check
avail > 0 && avail <= sent, and fail or skip when poll() returns <= 0?

> +				fprintf(stderr, "TFO SIOCINQ overflow\n");
> +				close(remotesock);
> +				return 1;
> +			}
> +		}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793676064.git.tanggeliang%40kylinos.cn
