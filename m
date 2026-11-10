Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353543;
	b=MNgf05eZ485I8KHjIQkBm5mQqXAMsuiDmeQwhFSHm+YA+urykuJSI5wvoxahGe9btmDr
	 oGL0v50Yu/z3YUp/Vl+9+U9tLmWVo8QcukasM05Be3rtnPmFD1ifxuIbu0wTXrvVmb0YT
	 8ID42folG5ArcLog5c54GC1RayqKylBPk4CNfzewYrAhHNE6kRDHo0ojwtey9Dn3WhMhD
	 0KY2zJEhWAZ1HXucXpK5EDQ7/nivF6JkG69D2240DE+H+6IhDdFn5xipHGbd90NqpHu7g
	 aVsFgD+jAgMCOJgpSirPfnl76ebD0lC5bDQ5CbJnQubJZ+B8BnLWk84sjV2uoCBpOsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353543;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Dc1Wjjmot5stqlAH4s44fpzlxOLvoBKWeCCncEb2PwM=;
	b=ohD96iiBjW8a72awcjKJmUDUXHIzWaI3rqFoRvPRVZEl9Mrt1zqignK//xproetgrxYO
	 4CN44tOfXpeM3S+iDLKjEANleyMPOyaqUJLuygyjj3gMN9aDQJILQpCLheo+NFvcMmDZ1
	 Z8cbICog+T/Do3uFHsih305TvorySqa8DeCmqxu9gty+63U6ZzU8N2xqb0N5lN5PyEwbP
	 ExApQfB3bavc+DXyvgIHwXtyDyw+10M8oBrlPs3oWjhuFT4b0nto5AVHHyGSApDYEfxPQ
	 T6iph5Csh9Cf/OD/j57fvV29XerO5A0ZBAUS07AjDtmz5tfttcpFJ2e3iS0IoW6KYQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RWwPGsjw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39948606A31C
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RWwPGsjw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D7D1F00A04;
	Tue, 10 Nov 2026 23:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353542;
	bh=Dc1Wjjmot5stqlAH4s44fpzlxOLvoBKWeCCncEb2PwM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RWwPGsjwzXjxSdQyTYccLrzh/w6Ie1xTKcDJip/5wD/W5IQe038jYfvH1Cmpz7/3u
	 L8gdkGVpP9kNyxOl/j36xgs7nZ+zOvHcXL+KbuMwsssuak4Rbw5k0CnBJK9ZIM7ZvF
	 hv7jlgvTUSE2mUYJBb6XXAiQONHy+Oa2OmJbMBIXZBxmJqG4fOYz8zvWgRuH0xmjNY
	 wWRF//RizfTXoavWbeW+lwZ9QrNrY1kifbdfuRuDHPUl/VEOe4QvGvc/Wb5hCrqEIf
	 daBrFSskRDTOsrW7vhWg2YYAJU2TrMzzxb7tXi3c1Zq1eSAk6nUbXZPgTqZJtor6eg
	 xFaB1pY4gPdxA==
Subject: Re: [PATCH mptcp-next v24 2/8] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 10 Nov 2026 23:32:22 +0000
Message-ID: <179435354208.488855.15120241187558911095@kernel.org>
In-Reply-To: <7062643d703b5143ba7bd56bc819d7e7854fdc9b.1794215614.git.tanggeliang@kylinos.cn>
References: <7062643d703b5143ba7bd56bc819d7e7854fdc9b.1794215614.git.tanggeliang@kylinos.cn>
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

- [Low] wait_for_remote_key() in
  tools/testing/selftests/net/mptcp/mptcp_connect.c can loop forever.

--

selftests: mptcp: connect: check TFO SIOCINQ overflow

This adds a SIOCINQ check to the mptcp_connect server mode when the
MPTFO socket option is enabled. After accept(), the server polls
MPTCP_INFO until MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED is set (bounded by
poll_timeout), then fails the test if SIOCINQ reports INT_MAX.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..da35a5ce15419 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[ ... ]

> @@ -1176,6 +1180,28 @@ static void maybe_close(int fd)
>  		close(fd);
>  }
>  
> +static int wait_for_remote_key(int fd)
> +{
> +	struct mptcp_info info;
> +	socklen_t olen;
> +	int elapsed = 0;
> +
> +	while (elapsed < poll_timeout || poll_timeout < 0) {
> +		olen = sizeof(info);
> +		if (getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &olen) < 0) {
> +			/* Not an MPTCP socket (TCP or fallback), skip wait */
> +			if (errno == ENOPROTOOPT || errno == EOPNOTSUPP)
> +				return 0;
> +			return -1;
> +		}
> +		if (info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
> +			return 0;
> +		usleep(10000);
> +		elapsed += 10;
> +	}
> +	return 1;
> +}

[Severity: Low]
Can wait_for_remote_key() loop forever when poll_timeout is negative?

main() sets poll_timeout to -1 for any -t value <= 0:

main() {
    ...
	case 't':
		poll_timeout = atoi(optarg) * 1000;
		if (poll_timeout <= 0)
			poll_timeout = -1;
    ...
}

With poll_timeout == -1 the while condition is always true. The loop
then only exits if REMOTE_KEY_RECEIVED shows up or getsockopt() fails.
Nothing in the loop checks whether the connection is still alive (no
poll() for POLLHUP/POLLERR, no SO_ERROR, no MPTCP_INFO_FLAG_FALLBACK
check).

For a passive TFO socket, accept() returns at SYN time, before the MPC
third ACK. Suppose that subflow gets reset, or the third ACK never
arrives, for example because the client exits early and its kernel
answers the SYN-ACK with an RST. The msk is not marked as fallback in
that case, so mptcp_getsockopt() keeps reaching
mptcp_getsockopt_sol_mptcp() and MPTCP_INFO keeps succeeding.

REMOTE_KEY_RECEIVED stays clear, because msk->can_ack is only set in
subflow_set_remote_key():

	WRITE_ONCE(msk->can_ack, true);

and that code needs the MPC ACK to be processed first.

Without this patch, the same dead connection would reach poll(-1) in
copyfd_io(), which wakes on HUP/ERR and returns. With this patch, the
server just keeps sleeping 10ms per iteration.

With a finite timeout (the in-tree scripts pass -t 30), the same case
stalls the server for the whole timeout before copyfd_io() sees the
error.

Could the loop also check for a dead socket, e.g. with a short poll()
for POLLHUP/POLLERR, or by stopping once the subflow is closed?

> +
>  int main_loop_s(int listensock)
>  {
>  	struct sockaddr_storage ss;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794215614.git.tanggeliang%40kylinos.cn
