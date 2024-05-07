Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0C13C83E
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069565; cv=none; b=RqQcRVPigq+S9VEhX/VMyCU4R8Wmso6OscxTa5cEgYXvGkKwtFCS0/WCZaKPS8/QlTgmx2WZj3XxP1EckSy0KlCTn1zn8RIw/9/tRN1ZzcK7e5XrU6wZ2iff+yGtd+RvdwIObJrAzqtl0U5eeRk6CVBPUGVBn4K3xNbTbH1Ebzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069565; c=relaxed/simple;
	bh=NXh+amqcHZFILwCx51DtFWxrj2ewpyihCsc2qrgHac4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mqrh1MhRvinl5CAggewFVjd6BnjRwv8OP59TT6QTKbNo60FPNF8pV6GELcyGJLN98UGoVA1lhyyebKNGVLqbd2vJVF75McqGFJjGj4Vz2Pu5NTbqw1v58yg/GoAHgFUuIigOvUVtpDC1f+nykRkDjyj9cHGOhhWenoLwGrGf02o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ygffgf25; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ygffgf25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAD4C2BBFC;
	Tue,  7 May 2024 08:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715069565;
	bh=NXh+amqcHZFILwCx51DtFWxrj2ewpyihCsc2qrgHac4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ygffgf25C8DRPPj5FhxuFrrNc3XODCoYxilfbPmY0jyAMh7WizuVAFm44eZfRtbX0
	 MwwK1/FqPChCM3L/rnUReEMPte6d4B57xf78fiNcF4A3z4rpF9BcC6pn1JnQkHZp8r
	 /o50XfzSmX17iFDiVCz9J+N8KzRk+p/jdlROVg2ohQPyav6LTUbdNx5FnJpvtOPp3r
	 87CEcqQBitUua9KNaRN9h7lSH5qIyMSER0Gqs/CRNdD87Ak0bhFvEpBDDgGe2xWO8R
	 xDdgyPYEFZ00P4S3W2ae3K2BgZ8EQYa6d8gTM6cZGM/IsyxR30uXumpGiVh6551rNp
	 7Ajn0Lm7kxt8w==
Message-ID: <7f9f2b7f-9bb5-4c17-bdef-c96fe2707d27@kernel.org>
Date: Tue, 7 May 2024 10:12:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2] mptcp: fix the default value of
 scaling_ratio
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: martin.lau@kernel.org, Geliang Tang <tanggeliang@kylinos.cn>,
 Paolo Abeni <pabeni@redhat.com>
References: <0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0ccc1c26d27d6ee7be22806a97983d37c6ca548c.1715053270.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

(+cc Paolo who wrote the commit mentioned by the "Fixes" tag)

On 07/05/2024 05:46, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> BPF tests fail sometimes with "bytes != total_bytes" errors:
> 
>  test_default:PASS:sched_init:default 0 nsec
>  send_data:PASS:pthread_create 0 nsec
>  send_data:FAIL:recv 936000 != 10485760 nr_recv:-1 errno:11
>  default: 3041 ms
>  server:FAIL:send 7579500 != 10485760 nr_sent:-1 errno:11
>  send_data:FAIL:pthread_join thread_ret:-11 test_default:PASS: \
> 				has_bytes_sent addr_1 0 nsec
>  test_default:PASS:has_bytes_sent addr_2 0 nsec
>  close_netns:PASS:setns 0 nsec
> 
> In this case mptcp_recvmsg() gets EAGAIN errors. This issue introduces
> by commit b8dc6d6ce931 ("mptcp: fix rcv buffer auto-tuning"). The default
> value of scaling_ratio should be TCP_DEFAULT_SCALING_RATIO, not U8_MAX.

It looks like you are modifying the max value, not the default one.

Also, please always explain the reason: why should it be X, not Y?

> 
> Fixes: b8dc6d6ce931 ("mptcp: fix rcv buffer auto-tuning")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> v2:
>  - I finally found the root cause of this issue.
>  - cc Martin too.
> ---
>  net/mptcp/protocol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 579031c60937..d00cd21e8d3f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1981,9 +1981,9 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
>   */
>  static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
>  {
> +	u8 scaling_ratio = TCP_DEFAULT_SCALING_RATIO;

With this modification, you are limiting msk->scaling_ratio to
TCP_DEFAULT_SCALING_RATIO. That's probably not what you want. See below:

  (...)
  mptcp_for_each_subflow(msk, subflow)
      (...)
      scaling_ratio = min(tp->scaling_ratio, scaling_ratio);

  (...)
  msk->scaling_ratio = scaling_ratio;


Do you mean that in your case, msk->scaling_ratio was assigned to
U8_MAX? Or it was assigned to a too high value (>TCP_DEFAULT_SCALING_RATIO)?

Please add such info in the commit message as well.

>  	struct mptcp_subflow_context *subflow;
>  	struct sock *sk = (struct sock *)msk;
> -	u8 scaling_ratio = U8_MAX;
>  	u32 time, advmss = 1;
>  	u64 rtt_us, mstamp;
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

