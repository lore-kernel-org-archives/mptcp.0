Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800666;
	b=ZwpNbbsv1xi+Gwex+tTWj96+uAvkaOOEoSqubCrkQDdFUdN+w5AAhc4j65Q0VImvqqyk
	 ZwvR1tLwcZwM5fkznx4WLQc7HdV4qAgqtvDEmPJAvxpUgVJMbABSFJ1M+p5yOJe8GKu0V
	 9BJFZoXKd+0ASLsnu7TKCScZ0adzHphiksluigMA2Zvzksvdd/ELKMH/F55p7z1cjyiLi
	 Wu7iX1OmqKS0pr2uVju1yM3AOYaQcvmXDyj7Ha5r6aIJoFfUkBFt/Shb8mPIFQHcNlPYW
	 zMG4MSCREy7TegIEfGD20EjXMdwMnl/5yFQzWJ3eH0OYjiVIi08vGA3/0cS2tMurGZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800666;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TLF94ouYI+B6sP72k8e2y3GFn+pAf+PC6QFaW22DcBw=;
	b=kYi+Jve1IA1bDBQ7hn8fL+hUatMPxlhj925SUFz9l2DzL8+8W/5yETkaW4DBk9UAzbMH
	 Gqs/O6PrV8pudAnOFpDTWj3z2AB1nsUAuMz0GQAy0y99mxssFxNMLi6hg1gRJv8MYX1ks
	 6SN4Z5U1XxnZE6bF6AbAV2NJpGpQdVrZgpncS0x+oIt1vOuE8ZENdM++USZ85B8Dk8OU7
	 890UhRr1F79XSLfqwSFcLtVG8/Uz9Jiumzdzvhtb4gdCdscKyEKMGdnZuxTXqelkVXvq9
	 o63BiHmPxtEEqufciIQNInB0HSNwuVwcn5Ktf7Rhg4OvndCwjNw6Xh01OGYB9S0aesQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olt3mEfc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A564606A333
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=olt3mEfc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0211F000C4;
	Mon, 16 Nov 2026 03:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794800666;
	bh=TLF94ouYI+B6sP72k8e2y3GFn+pAf+PC6QFaW22DcBw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=olt3mEfcZ8anfJ95lZzh61XLgUTfJFrg2cNnvpcskF7epmiVpRWo9Kjud/Kkn6Gyf
	 qkI0vGcC9ig9++pJ0CvO4NVoN4Hl0mTfLrpjaXaBL9j9QwvzZEn/O/6YOnVHuPPiAp
	 5xQHe7U6C9A+52wl8gVFBhACtQWFNJ2TPtPu9U8zUUELBbicb5N4K/zjTFVex2qhmx
	 gkThZy/y54azi6n3zykfi50BGpUG9qK8eSDwGsHJA3a5/piR9EQs+rmoqOwT0E6sEL
	 vDu1dg0eSsqJQeitC1Vpzr4rX/eIvj2APc9tBkOqU08CQS21fwvFDQaEEVA4rFadkP
	 IGrcdv8hAnEYg==
Subject: Re: [PATCH mptcp-next v27 2/8] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 16 Nov 2026 03:44:25 +0000
Message-ID: <179480066581.3133.2291623347932821892@kernel.org>
In-Reply-To: <ac3de6c2e3d3593a1737af35c3681cc129c5e552.1794663678.git.tanggeliang@kylinos.cn>
References: <ac3de6c2e3d3593a1737af35c3681cc129c5e552.1794663678.git.tanggeliang@kylinos.cn>
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

- [Low] When the remote key never arrives, the new TFO SIOCINQ check
  passes without testing anything.
- [Low] The TCP_CM_INQ check in mptcp_connect.c is now out of step with
  the kernel's new inq semantics.

--

selftests: mptcp: connect: check TFO SIOCINQ overflow

This commit adds a SIOCINQ check to the server mode of mptcp_connect
when the MPTFO socket option is enabled. After accepting a connection,
the server polls MPTCP_INFO until MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED is
set, bounded by poll_timeout. It then fails if SIOCINQ returns INT_MAX.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..152976d39d464 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[ ... ]

> @@ -1176,6 +1180,47 @@ static void maybe_close(int fd)
>  		close(fd);
>  }
>  
> +static int wait_for_remote_key(int fd)
> +{

[ ... ]

> +	while (elapsed < poll_timeout || poll_timeout < 0) {

[ ... ]

> +		if (info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
> +			return 0;
> +
> +		elapsed += timeout_ms;
> +	}
> +	fprintf(stderr, "TFO: timeout waiting for remote key\n");
> +	return 0;
> +}

[Severity: Low]
On timeout, wait_for_remote_key() returns 0, which is also what it
returns when the key arrives. Can main_loop_s() then report a pass on a
kernel that still has the regression?

On the unfixed kernel, mptcp_inq_hint() computes
ack_seq - head->map_seq. mptcp_fastopen_subflow_synack_set_params() sets
a dummy map_seq:

    MPTCP_SKB_CB(skb)->map_seq = -skb->len;

msk->ack_seq stays 0 until subflow_set_remote_key() runs:

    WRITE_ONCE(msk->ack_seq, subflow->iasn);
    WRITE_ONCE(msk->can_ack, true);

MPTCP_INFO reports can_ack as MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED. Before
the key arrives, the old hint is 0 - (-len) = len, not INT_MAX. So the
avail == INT_MAX check in main_loop_s() cannot fire on the timeout path.

The commit message says this is intentional:

  "Print a warning if the remote key does not arrive within the timeout,
  but continue with the SIOCINQ check rather than failing the test."

In that case, though, the SIOCINQ check can never fail.

Would it be better to skip or fail the test when the key never arrives
on a socket that is still MPTCP and has not fallen back to TCP?

>  int main_loop_s(int listensock)
>  {
>  	struct sockaddr_storage ss;
> @@ -1207,6 +1252,22 @@ int main_loop_s(int listensock)
>  		check_sockaddr(pf, &ss, salen);
>  		check_getpeername(remotesock, &ss, salen);
>  
> +		if (cfg_sockopt_types.mptfo) {
> +			int avail;
> +
> +			if (wait_for_remote_key(remotesock) < 0) {
> +				close(remotesock);
> +				return 1;
> +			}
> +
> +			if (ioctl(remotesock, SIOCINQ, &avail) == 0 &&
> +			    avail == INT_MAX) {
> +				fprintf(stderr, "TFO SIOCINQ overflow\n");
> +				close(remotesock);
> +				return 1;
> +			}
> +		}

[Severity: Low]
This is outside the hunk, but this patch is the selftest update for the
series. Should do_recvmsg_cmsg() in mptcp_connect.c also be updated for
the new inq semantics?

The earlier patch "mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint"
makes mptcp_inq_hint() return mptcp_data_avail(). With N bytes unread
after DATA_FIN, the hint is now N instead of N+1. It returns 1 only when
nothing is queued and the socket is closed or has RCV_SHUTDOWN.

do_recvmsg_cmsg() still assumes the TCP-style N+1 rule:

	if (cfg_cmsg_types.tcp_inq) {
		if ((size_t)ret < len && last_hint > (unsigned int)ret) {
			if (ret + 1 != (int)last_hint) {
				...
			} else {
				tcp_inq.expect_eof = true;
			}
		}
	}

The hint now equals exactly the queued in-order bytes. A short read
therefore returns at least last_hint bytes, so last_hint > ret can never
be true for MPTCP. As a result, the expect_eof branch never runs, and
neither does the later "expected EOF" check.

The only in-tree TCPINQ user is do_transfer() in mptcp_sockopt.sh, which
runs MPTCP on both ends. So in-tree runs no longer exercise this check.
No later patch in the series seems to change it either.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794663678.git.tanggeliang%40kylinos.cn
