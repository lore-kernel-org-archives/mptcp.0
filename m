Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186923;
	b=JRtmDWrXerabsgYzQwKjauGHJ8pNjZ9ASeiJUyLqq/bl2r+3LaOnwzMkdqGYGS03EZ64
	 bWgGj7kkZJ8FT3xV1i+KvsQCSZHaWnsSaJQCZXX9Blisiv4gyavRcouwtN/mjlp0XWxXC
	 8GUHwtlQ4pI6pad3RgNhmEeN29cyRcm3cq7plce/zMhdw15yYuhJZGh1IjJv4lL4a/H5f
	 f3BaOEmZRmeUSZg+KHL85tLVDxdms3wMrUCTqcCdZnmenERcdGNTTxJPEymNActoTghFG
	 Rljdgqpp6UTmrJXAQcZaHq05q1PoV45nRD3AsdFZWIWdUjG28BsXNpn7mUD5RQVsIfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186923;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NO+ZqaualRhtzBzg+J37+exva1v4SUGt7pt1/FXJoYo=;
	b=I6CdFSI0KvQKMAI04Ks6021QnVhb5B5MobpbWkz8Lw1J+ae6VZIgwljV80mJMIlleskR
	 vFG1YHTbmHsXjgydOP9wEhpjcaQiJ8vuH28cyrdg4E0DfrAYID5q4VWrrVZekY2Ymxt4Y
	 K7n9p98wUqYCEYWShjJ2CRQynR7ZS+RCdHKjkozrQON0zmrA5gVXC3sqP9le72+oBE4dZ
	 RxjS+pdig7K7Xj4bLfbVzgqHR7MDZSZ7h7GtjCa1g2qttbP4zHni2/d0oXh72ErpalLWq
	 4qgCDKYscne2q6BWG+RSfhtb66WHiIeuE6B4UdY0CFR4fC2bEsuwb95OLFeDUNgwzGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6Oh4LQM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAFB606A31C
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6Oh4LQM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BE81F008A1;
	Mon,  9 Nov 2026 01:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794186922;
	bh=NO+ZqaualRhtzBzg+J37+exva1v4SUGt7pt1/FXJoYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j6Oh4LQMGRcSGFp9CPrlgqGSnhsZTvfYFwl9FaWkYyL2+2clCCIKFKyNHvcJ1gqyF
	 fq+CxA3CPm9PMIuqwYI0fNdJ/SDsEZh45NpoVf09YllAUzTi9j2VvcYdS4rHbNnF5d
	 JDmj/MQYT7RmQyzBIgp17PBTZhYFQ7U24VELGx1HWkTiA8yTcJIdh8ZXAHX1DzlikU
	 SaXFaxAmdYfZzJEPT5JNVaUjm9c426rmzCXpy6nOQswJxcwSVfpELLc2i50MU1ZWUY
	 lN94wUN58ij3T8sZ7BPcomXxfwfM5d1H8itsc7MUaXJzhuLb+L8ziRcRrSqlInbDGi
	 f/MXxUjZdZZbA==
Subject: Re: [PATCH mptcp-next v7 2/7] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, yangang@kylinos.cn, kuba@kernel.org
Date: Mon, 09 Nov 2026 01:15:22 +0000
Message-ID: <179418692223.488855.3861560686142168497@kernel.org>
In-Reply-To: <e09a65432d53e0ba14816efdd83b075b9681044f.1794053683.git.tanggeliang@kylinos.cn>
References: <e09a65432d53e0ba14816efdd83b075b9681044f.1794053683.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new MPTFO SIOCINQ check in
  tools/testing/selftests/net/mptcp/mptcp_connect.c only waits 100 ms…

--

selftests: mptcp: connect: check TFO SIOCINQ overflow

This adds a SIOCINQ check to mptcp_connect's server mode when the MPTFO
socket option is enabled. After accept(), the server polls MPTCP_INFO for
MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED for up to 100ms. It then fails the test
if SIOCINQ returns INT_MAX.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..f9f9c02016877 100644
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
> +			if (errno == ENOPROTOOPT || errno == EOPNOTSUPP)
> +				return true;
> +			return false;
> +		}
> +		if (info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
> +			return true;
> +		usleep(10000);
> +		retries--;
> +	}
> +	return false;
> +}

[Severity: Medium]
Can this fixed budget of 10 x 10ms cause false MPTFO failures on slow
machines?

On a passive TFO connection, accept() returns once the SYN with data has
been processed. That is before the client's third ACK arrives.

The flag polled here comes from msk->can_ack in mptcp_diag_fill_info().
The only place can_ack gets set is subflow_set_remote_key():

net/mptcp/subflow.c:subflow_set_remote_key() {
    ...
	WRITE_ONCE(msk->can_ack, true);
    ...
}

That code runs only when the client's MPC third ACK, or its first MPC+DSS
data segment, goes through __mptcp_subflow_fully_established().

Nothing synchronizes the server-side wait with the peer's ACK except
elapsed time. The SYN-ACK -> third ACK round trip in ns2 can take more
than 100ms, for example on debug kernels with KASAN, lockdep or kmemleak,
in nested VMs, or on loaded CI hosts. The key can also arrive only with a
later segment or a retransmit. In those cases this helper returns false,
and main_loop_s() does:

	fprintf(stderr, "TFO: timeout waiting for third ACK\n");
	close(remotesock);
	return 1;

As a result, the MPTFO group in mptcp_connect.sh would be marked failed
on a kernel that does not have the SIOCINQ overflow.

Any getsockopt() error other than ENOPROTOOPT or EOPNOTSUPP also returns
false here, and that gets reported as the same timeout.

The harness sets timeout_poll=30 and passes "-t ${timeout_poll}" to the
listener (poll_timeout), but this wait does not use that value.

Could the wait be based on poll_timeout instead? Another option is to
skip the SIOCINQ check with a notice, rather than returning 1, when the
key does not arrive in time.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794053683.git.tanggeliang%40kylinos.cn
