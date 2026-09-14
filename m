Received: from mta0.migadu.com (out-7.mta0.migadu.com [91.218.175.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFC40B119
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374273; cv=none; b=L/ghziMaAG6aQDt3YBSx/zfHULJ4q9cacfYUeYO4FKFI6WNv9+zgAo01OY3gEr5u1TvM0BojPImapqzgAHOVMsWSoRvsox4Fcdr4Vfk10b3I5mhx/j3ahVuVWDRJgWAaGLH/t5GVrF2CAjtpf+7nY03jx8etk2XBjTSkWA8O/iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374273; c=relaxed/simple;
	bh=2CejH3qnQToq8Lckt6cRiGOTw0v5Aus/f1gzF5KY5j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2vV6ul5oJ/DQiAOYe0pKYxIrw4L+9enHxeOLY8kqzSwEVDB4qsDAHQOybGh+BxoUIk6NuvztRm89eA0nI3cSQf36hZAmkasZoZp0tZmfLG6Eaup00j8qvgaE3HrqDQMnFFGtdqc3ipuADj9UEsXXGdJMLyCMY1eMmNGg1KTbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NwuSyX6z; arc=none smtp.client-ip=91.218.175.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NwuSyX6z"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=2CejH3qnQToq8Lckt6cRiGOTw0v5Aus/f1gzF5KY5j0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789374269; v=1; x=1789979069;
 b=NwuSyX6zOkYl0/CMIDei0mL+vctK4IjBPo3H74nhkCeijXXLNd0CntAz0XSQoS5cBOhxoiPo
 2HHjUZ/ci+usTjfnTvutqaWycEUdBLuNWwWaKh8DQEGyYPSyS37/xuRFbb1XP0JCc3TMe1bKAGD
 YEyDvmp9pZea8uavhrLB0kMc=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id faa09a68a2868c7b;
	Mon, 14 Sep 2026 08:24:29 +0000
X-Mizu-Trace-ID: faa09a68a2868c7b
X-Migadu-Flow: FLOW_OUT
Message-ID: <da26d2f3-7283-4e9f-85b4-6c12b9beda99@linux.dev>
Date: Mon, 14 Sep 2026 16:24:22 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: drop duplicate check_app_limited in
 tcp_bpf_push
To: Geliang Tang <geliang@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, mptcp@lists.linux.dev
References: <cover.1789368148.git.tanggeliang@kylinos.cn>
 <f12f1d886c8ff2b6f6e48f797ccc861037eda685.1789368148.git.tanggeliang@kylinos.cn>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <f12f1d886c8ff2b6f6e48f797ccc861037eda685.1789368148.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/14/26 3:14 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> When the sendpage->MSG_SPLICE_PAGES migration series replaced
> do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, callers that
> had used do_tcp_sendpages() kept an explicit tcp_rate_check_app_limited(sk)
> that was originally needed to cover do_tcp_sendpages() (which did not call
> tcp_rate_check_app_limited()). After the inlining, tcp_sendmsg_locked()
> always provides the check, and the outer call became redundant.
>
> The site changed here, tcp_bpf_push(), is a MSG_SPLICE_PAGES loop that
> holds the socket lock and only iterates when size > 0; tcp_sendmsg_locked()
> is invoked on every iteration with state identical to what the outer call
> sees, so dropping the outer call is safe and behavior-preserving.
>
> A potential benefit of this change is that it facilitates future reuse of
> tcp_bpf_push() for sockmap support in protocols beyond TCP, such as MPTCP.
> Since tcp_rate_check_app_limited() is TCP-specific while sendmsg_locked()
> is a generic interface in struct proto_ops, this change allows us to switch
> to different protocols via sk->sk_socket->ops->sendmsg_locked() without
> carrying protocol-specific assumptions.
>
> Fixes: ebf2e8860eea ("tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg")


Same as the tls one: this looks like a cleanup to me. Is there a real 
regression that affects kernel or user behavior?

Do we really need a Fixes tag?


> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   net/ipv4/tcp_bpf.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 2e234d155b5e..d5fcf3ce4861 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -108,7 +108,6 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
>   		off  = sge->offset;
>   		page = sg_page(sge);
>   
> -		tcp_rate_check_app_limited(sk);
>   retry:
>   		msghdr.msg_flags = flags | MSG_SPLICE_PAGES;
>   		has_tx_ulp = tls_sw_has_ctx_tx(sk);
