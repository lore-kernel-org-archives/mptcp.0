Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1007619E
	for <mptcp@lists.linux.dev>; Tue,  7 May 2024 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715043770; cv=none; b=bFY3solIId99GguUdyEuxZQ9naaymvVcJ4JOvaNdC4tFZ39zjkkQycWiHqDTg7ikQY5imy1uWImjdIHyyEAcKuYWNu7SjcGns6aGBU6I7E0sQ0mGrUHGhwQXoitIf/RFfQqdUtm5bu7rKvYoRHRf12GTwm8FOdpIvIjKv+Cg30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715043770; c=relaxed/simple;
	bh=Y/9t3YJy36KtfU5SlFB+RqOW06rgaU5Q34V0x0h+rK0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kDlS3nDl9vmQORY7Wdyl6s+8Ln/7Kp1exV0wtkIIJFDw5vpzFZn8gY0qUzxqj+LcVEFlFihLqdF9ptVh76rVScWOe9aZ33pj5Q8mxgAW2vevBLYitDq2vB7c3HbfyEmM9eslxcuZsvLRMFbBuN26/YhPwqrkwKAzY30kVb8z/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiT07mvT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiT07mvT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD4BC116B1;
	Tue,  7 May 2024 01:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715043769;
	bh=Y/9t3YJy36KtfU5SlFB+RqOW06rgaU5Q34V0x0h+rK0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QiT07mvTXkgmjKrjweb5aPDabHsPG9fu7e1liyZjJuGHuF/pkIT7sqd0gJ9s3bw4R
	 kGC9o+TRa74CYNxzzOBdPXzKXyG1EijN05blKTH2cLhETPeXNz2wY6mqKBflr8Yrq+
	 zSmVbV4j6Rki668R8GuKYMmZx0OBbauLuUamQ60BMUilKIyN6zB+XMc0jC27rTp1U5
	 tJF0OfRJeVJ28vR37ILRwEmC3GDp1+/Vdo4Dft0bMbOsDTa3pd23Hqx22GPemRW16D
	 7VAfoDHvqn8hhmRDeqByYDSe4mHBwLMb5fBDQcd2mtYJh39jrklFzZTVRijsFM/AdJ
	 YbGVnv2FggFUQ==
Date: Mon, 6 May 2024 18:02:48 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net] mptcp: fix EAGAIN errors in MPTCP BPF tests
In-Reply-To: <4538e7bca21fdb7f997c026d74f886aedb547d39.1714654631.git.tanggeliang@kylinos.cn>
Message-ID: <24b54657-5afe-b4a9-0229-3bd30477936e@kernel.org>
References: <4538e7bca21fdb7f997c026d74f886aedb547d39.1714654631.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 2 May 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> BPF tests fail sometimes with "bytes != total_bytes" errors:
>
> test_default:PASS:sched_init:default 0 nsec
> send_data:PASS:pthread_create 0 nsec
> send_data:FAIL:recv 936000 != 10485760 nr_recv:-1 errno:11
> default: 3041 ms
> server:FAIL:send 7579500 != 10485760 nr_sent:-1 errno:11
> send_data:FAIL:pthread_join thread_ret:-11 test_default:PASS: \
> 				has_bytes_sent addr_1 0 nsec
> test_default:PASS:has_bytes_sent addr_2 0 nsec
> close_netns:PASS:setns 0 nsec
>
> In this case mptcp_recvmsg gets EAGAIN errors. This issue introduces
> by commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale").
> This patch fixes it by adding sk_is_mptcp() check defore update
> scaling_ratio in tcp_measure_rcv_mss(). Do not update scaling_ratio if
> this is a MPTCP socket.
>
> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/487
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/ipv4/tcp_input.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index ad8fa129fcfe..39237d6713ee 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -235,8 +235,10 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
> 		/* Note: divides are still a bit expensive.
> 		 * For the moment, only adjust scaling_ratio
> 		 * when we update icsk_ack.rcv_mss.
> +		 *
> +		 * This breaks MPTCP BPF tests, skip it.
> 		 */
> -		if (unlikely(len != icsk->icsk_ack.rcv_mss)) {
> +		if (unlikely(len != icsk->icsk_ack.rcv_mss && !sk_is_mptcp(sk))) {


Hi Geliang -

It's not clear to me why avoiding scaling ratio changes when

     len > icsk->icsk_ack.rcv_mss

is the right solution to the problem. From the conditional right above 
this diff, it looks like scaling_ratio still could change when

     len == icsk->icsk_ack.rcv_mss

Does the MPTCP code handle that case, or is that not exercised by the 
tests? Are you sure there isn't an issue with the MPTCP code where it 
should be able to handle the TCP layer updating scaling_ratios on 
different subflows?

Paolo do you have any suggestions or notes?


Thanks,
Mat

> 			u64 val = (u64)skb->len << TCP_RMEM_TO_WIN_SCALE;
>
> 			do_div(val, skb->truesize);
> -- 
> 2.43.0
>
>
>
