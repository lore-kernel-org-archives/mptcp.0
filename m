Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A460299949
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154019; cv=none; b=V1Pjw2VWbbsbbuSnMMqkqoavO2Y4T4GA2o29CFLeyPtFq53u2lY/e+gzpazJHPwTuO4eTkN+Ef+8ggmaPAMF8uJKjhVjBnlq+L8Nib6Qvj+/Xy4PYllnDqUu2YVWxf9WMr2/UcQpYyuZy0J85+rUiIqAYR9iafqyVN9ljCCBnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154019; c=relaxed/simple;
	bh=e4gTS+sKFGsXPrSHt0mIcGP631MDfzdINN9EdpnTMnk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d3OGBjJiU8VCM1DTHuTw5R/QJkVfJQJRrM0WQpF7XeUV2oHVpxrq2fDs4KZwsaXl3TLJzARlqojLEt6i2cw68sOAtWA9Z59kEZ1WD6gaRIpNZuE+xLCgU4COSgamkDERvZiXFIYdU9ZQ2l4fGAM2ySwIDM8OtiCx53dToBVY4sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ar4tiDok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ar4tiDok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BCAC4CEE7;
	Mon,  3 Nov 2025 07:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154018;
	bh=e4gTS+sKFGsXPrSHt0mIcGP631MDfzdINN9EdpnTMnk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=ar4tiDokXqc3vcmfOeavpLM1coq4uwpX1GgtU05TZyIJ02MDrKtxLk9VhSFjMCQKF
	 qh3hWjLHlLiv3t4wmCSPjNqV1NMV7beARf2Y+kVW+Wc7EzOtYsI4dgF/gQA7DMbaq7
	 c+19DBjkZzLZVS6j8C74Zzn3crhwWVPVf9TLOoi0EWM7tvOfTmtvwKCJoeN92GH/fK
	 D0cruhI5S9rclDTG+DN2oZiCdleJ0MnCFBh6h2Tgf3Yn0DT8x+IWf5igsNOGqOfnYT
	 DVdtpi786i6+wehpllx1ygIBIo+3ksfF/sTnzgbCNIQbsInppsCy2qQOPaU6bdotai
	 B3cwb1/JGheTQ==
Message-ID: <d94c0f0850c8985324956cfdfef900bde3f2b377.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 6/6] selftests: mptcp: connect: trunc: read
 all recv data
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Mon, 03 Nov 2025 15:13:34 +0800
In-Reply-To: <20251102-slft-join-inst-v2-6-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
	 <20251102-slft-join-inst-v2-6-b4f3ba15a7c4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sun, 2025-11-02 at 12:30 +0100, Matthieu Baerts (NGI0) wrote:
> MPTCP Join "fastclose server" selftest is sometimes failing because
> the
> client output file doesn't have the expected size, e.g. 296B instead
> of
> 1024B.

Thanks for this fix. After repeatedly running the fastclose tests,
patches 5 and 6 have indeed eliminated the flaky failures.

> 
> When looking at a packet trace when this happens, the server sent the
> expected 1024B in two parts -- 100B, then 924B -- then the
> MP_FASTCLOSE.
> It is then strange to see the client only receiving 296B, which would
> mean it only got a part of the second packet. The problem is then not
> on
> the networking side, but rather on the data reception side.
> 
> When mptcp_connect is launched with '-f -1', it means the connection
> might stop before having sent everything, because a reset has been
> received. When this happens, the program was directly stopped. But it
> is
> also possible there are still some data to read, simply because the
> previous 'read' step was done with a buffer smaller than the pending
> data, see do_rnd_read(). In this case, it is important to read what's
> left in the kernel buffers before stopping without error like before.
> 
> SIGPIPE is now ignored, not to quit the app before having read
> everything.
> 
> Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose
> test-cases")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v2:
>  - Also catch EPIPE, and ignore SIGPIPE
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 18
> +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index c030b08a7195..404a77bf366a 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -710,8 +710,14 @@ static int copyfd_io_poll(int infd, int peerfd,
> int outfd,
>  
>  				bw = do_rnd_write(peerfd, winfo->buf
> + winfo->off, winfo->len);
>  				if (bw < 0) {
> -					if (cfg_rcv_trunc)
> -						return 0;
> +					/* expected reset, continue
> to read */
> +					if (cfg_rcv_trunc &&
> +					    (errno == ECONNRESET ||
> +					     errno == EPIPE)) {
> +						fds.events &=
> ~POLLOUT;
> +						continue;
> +					}

We're adjusting the behavior of the falseclose tests here and need to
ensure it doesn't affect other tests. I'm considering adding a new
config like cfg_rcv_ign to encapsulate these changes within an if
(cfg_rcv_ign) block, and only enable this new config in the falseclose
tests.

WDYT?

Thanks,
-Geliang

> +
>  					perror("write");
>  					return 111;
>  				}
> @@ -737,8 +743,10 @@ static int copyfd_io_poll(int infd, int peerfd,
> int outfd,
>  		}
>  
>  		if (fds.revents & (POLLERR | POLLNVAL)) {
> -			if (cfg_rcv_trunc)
> -				return 0;
> +			if (cfg_rcv_trunc) {
> +				fds.events &= ~(POLLERR | POLLNVAL);
> +				continue;
> +			}
>  			fprintf(stderr, "Unexpected revents: "
>  				"POLLERR/POLLNVAL(%x)\n",
> fds.revents);
>  			return 5;
> @@ -1441,7 +1449,7 @@ static void parse_opts(int argc, char **argv)
>  			 */
>  			if (cfg_truncate < 0) {
>  				cfg_rcv_trunc = true;
> -				signal(SIGPIPE, handle_signal);
> +				signal(SIGPIPE, SIG_IGN);
>  			}
>  			break;
>  		case 'j':
> 

