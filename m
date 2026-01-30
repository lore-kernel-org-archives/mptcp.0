Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D62EC560
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780795; cv=none; b=nqWFlsP1oCBQyaENiNDZrWAWwuVch1/7HNN1vzsCflMpJ8WGRp566SGgcoJd/gXe+3mh95qq233+oj/mkiXZscBUkQS1ckKh6up7DyCyf2ZMd4WaNQAr15H+XkepPXOAbEFFoRWyJ1F62t9hRCtGm0JL3Ze5g5ZVoPRKjcSWrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780795; c=relaxed/simple;
	bh=JMlZ4Rc0QgscEf9abzIkqkN/PPMRn7vqZpmCaTpqBmw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UOzC8wbjH+2waIWp3fzjT56J8sH5NEUMzjW67qQqTZnSuIEK4pvIQQxSodgaJRpnbEYVKviypLuMuJ/rb1OwG0ZW2H0M5M2Nlu9sTCZCPWibNs0IaywXC4F1djEIgVcUEAavpXt+XFtXHUst5JUVBZRkle/AySmIoR/HxKBcZFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf2dSNOZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf2dSNOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3A0C4CEF7;
	Fri, 30 Jan 2026 13:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769780794;
	bh=JMlZ4Rc0QgscEf9abzIkqkN/PPMRn7vqZpmCaTpqBmw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=kf2dSNOZVX26GLTZIznsgjp6S8gQfvQl3wtEKguY5vq5qaNHsVPOkXwnXY4KuTQT1
	 imVlf8V7k/0LSZsRCJoRSKHswoRzb15TiVD8no7YwtLIpPbO0gbLzC5GatNtTXwD1u
	 oW4eXUui8kcLLiz1hcsN0C/sEUHbnoR9pLEcyVZ/i8KJ029F/kJ6skERpbsVBSn1Wz
	 nW5Jci5hKmjZoOGCe/Oi6R4EaPLzMUY0xjSSgabImE9TtwEYoMnUmHLQGjXa4D7LAJ
	 LOADNzEJRP7BdX5cr5XO+nGTLApBTQAyOd9voaqEdmdzZ6ztc6erGQlLMMSp0z/AiK
	 BAyUQ5wnvyyKg==
Message-ID: <e0ee5fe14cf45ac2af67b510ee0810c8a20da105.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add splice io
 mode"
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 30 Jan 2026 21:46:30 +0800
In-Reply-To: <20260130-mptcp-sft-no-ignore-splice-err-v1-1-af0a458b6ec8@kernel.org>
References: 
	<20260130-mptcp-sft-no-ignore-splice-err-v1-1-af0a458b6ec8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this fix.

On Fri, 2026-01-30 at 11:17 +0100, Matthieu Baerts (NGI0) wrote:
> NIPA review assistant rightly spotted errors with splice() are
> simply...
> ignored! Technically, mptcp_connect.sh will check the integrity of
> the
> transfer, but still, that's clearly not a good practice!
> 
> The different possible errors are now caught, printed, and reported
> to
> the caller.
> 
> Link:
> https://netdev-ai.bots.linux.dev/ai-review.html?id=93466fc9-574b-45fc-996e-13a19a1490a9
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me!

Reviewed-by: Geliang Tang <geliang@kernel.org>

> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 34
> +++++++++++++++++------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index ff1a298d3469..34d8efe429a4 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -937,24 +937,40 @@ static int do_splice(const int infd, const int
> outfd, const size_t len,
>  		     struct wstate *winfo)
>  {
>  	int pipefd[2];
> -	ssize_t bytes;
> +	ssize_t in_bytes, out_bytes;

This line is longer than the previous one; their positions could be
swapped.

-Geliang

>  	int err;
>  
>  	err = pipe(pipefd);
> -	if (err)
> -		return err;
> +	if (err) {
> +		perror("pipe");
> +		return 2;
> +	}
>  
> -	while ((bytes = splice(infd, NULL, pipefd[1], NULL,
> -			       len - winfo->total_len,
> -			       SPLICE_F_MOVE | SPLICE_F_MORE)) > 0)
> {
> -		splice(pipefd[0], NULL, outfd, NULL, bytes,
> -		       SPLICE_F_MOVE | SPLICE_F_MORE);
> +again:
> +	in_bytes = splice(infd, NULL, pipefd[1], NULL, len - winfo-
> >total_len,
> +			  SPLICE_F_MOVE | SPLICE_F_MORE);
> +	if (in_bytes < 0) {
> +		perror("splice in");
> +		err = 3;
> +	} else if (in_bytes > 0) {
> +		out_bytes = splice(pipefd[0], NULL, outfd, NULL,
> in_bytes,
> +				   SPLICE_F_MOVE | SPLICE_F_MORE);
> +		if (out_bytes < 0) {
> +			perror("splice out");
> +			err = 4;
> +		} else if (in_bytes != out_bytes) {
> +			fprintf(stderr, "Unexpected transfer: %zu vs
> %zu\n",
> +				in_bytes, out_bytes);
> +			err = 5;
> +		} else {
> +			goto again;
> +		}
>  	}
>  
>  	close(pipefd[0]);
>  	close(pipefd[1]);
>  
> -	return 0;
> +	return err;
>  }
>  
>  static int copyfd_io_splice(int infd, int peerfd, int outfd,
> unsigned int size,
> 
> ---
> base-commit: 7d56f2ba4d372e9660633de02a01236209c9df8f
> change-id: 20260130-mptcp-sft-no-ignore-splice-err-a35a97c217db
> 
> Best regards,
