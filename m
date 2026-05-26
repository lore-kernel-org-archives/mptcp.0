Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732BF3542D1
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781672; cv=none; b=cycqfyjp9ru6bDSFTMeqBv51nNcOBG46c2eBksdzroCyhYUHN0RL/Ha3GymNuBzXjNPmDWb/qVASlST8k4z6ZirEyXYUun8iD6muhOIN+GHe5IjnjPAvxE6xgEjCS5sljaPiNvtOZAoDY0YSsNMTghJ5FMEnySVhjBDTdJf2+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781672; c=relaxed/simple;
	bh=LMgxpxV3Y/oXrx3zS8l+pVftmmehJ5uZMWuEGROjm9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyYRYcVmuKPBSV2lnfWvYm4j9fB/EFGdZwm7Uhq7q/1BlMB3i8Uq6skKcoCT7XH71AJg+DKF906xz85rhRezIps7oeqU47CvOTrtioNvu6XWSv0V8U9jSfQV1FJ/jZGGFSkaopKPYZyAwx1sgtFdv39Cebodgu4qEXhney9lEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+EVrttZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+EVrttZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABBB1F000E9;
	Tue, 26 May 2026 07:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779781671;
	bh=dilRQ8DZ0tF7mb5ZkGGCMXbdXpUuKYXAKKZzspX1n8s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A+EVrttZSWgSOlrw9cO/Xe2ZbQYU0cIhYdWDq2THUt9hHHJwZtc6hAY+OM23FuQL/
	 eppvT5vKrP+p2Xq8qgWy9PG8VZaXN+tAwoV5b1RCBqt8sZIMvnuDhVAleg+24wuo3V
	 SsVGswaNE5hgJ1JtIRqUZA0/0/xTKigcWsDMT4Xe6Nbk4Crc+FnNJ1W0BuFqCmbW9t
	 JngAOuWtQhXEizIVZAE7tmT4ztv94s+ES5TvXrI0s5MLKsFvAZvunzQgG4vPhyVAIO
	 TeAw5rgEWSbpurHVSiwrxTjXivuZQOvvrmvPY+NuyTgTRMiBWekLvz0KTSGET/Dv+V
	 NQAuy7qiH4yBw==
Message-ID: <2ca3575c-4837-4989-8796-9a48d8c761d0@kernel.org>
Date: Tue, 26 May 2026 17:47:47 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 mptcp-next 1/9] mptcp: fix missing wakeups in edge
 scenarios
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev
References: <cover.1779485511.git.pabeni@redhat.com>
 <a8674727a7a9cb80d6840c9ca11950caec74ff31.1779485511.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a8674727a7a9cb80d6840c9ca11950caec74ff31.1779485511.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for this fix!

On 23/05/2026 07:43, Paolo Abeni wrote:
> The mptcp_recvmsg() can fill MPTCP socket receive queue via
> mptcp_move_skbs(), but currently does not try to wakeup any listener,
> because the same process is going to check the receive queue soon.
> 
> When multiple threads are reading from the same fd, the above can
> cause stall. Add the missing wakeup.
> 
> Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v6 -> v7
>   - use mptcp_epollin_ready()
> 
> Notes:
>  - sashiko may raise concerns about thundering herd problems. If
>    application uses multiple threads to read on the same socket, that
>    could/will happen. Application should not use multiple threads
>    to read from the same socket if they want good performances.
> ---
>  net/mptcp/protocol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ce8372fb3c6a..f14572fb1975 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2276,6 +2276,8 @@ static bool mptcp_move_skbs(struct sock *sk)
>  		mptcp_backlog_spooled(sk, moved, &skbs);
>  	}
>  	mptcp_data_unlock(sk);
> +	if (enqueued && mptcp_epollin_ready(sk))
> +		sk->sk_data_ready(sk);

Nit: I hope that's OK if I add new lines above and below this new block
when applying the patch.

Apart from that:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

>  	return enqueued;
>  }
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

