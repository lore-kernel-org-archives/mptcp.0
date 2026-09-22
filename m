Received: from mta0.migadu.com (out-66.mta0.migadu.com [91.218.175.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF4535FD1
	for <mptcp@lists.linux.dev>; Tue, 22 Sep 2026 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078607; cv=none; b=Jf/ZudNxFiFB0sLJgkysKAWtsjcqAAiX1WqE+Pa9bcHThEgeAcgXMmVqg7jGFy9trYBc50jMcC68BpdbrPQJ/AptAcX1SJA/a1v3sHFz967yWWyFqxMFAPW8bj9hKRBZbBOcw5DvXUxSNz0UR8B5WelnMosL1Gzofa8eeXRhBlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078607; c=relaxed/simple;
	bh=N+YY9kP72EJX4e0q1/BpSD+bJ/oqJzCRVO1fh2+Sk7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEzYGRuEVIiuGmWGZq3mHjLMaa5ujAWkv1Db8Aa60oO3C/+6gZEHmu43kLDqcRN7eHWxsOKIXfGuTiTXyB6nQWTMIzG6GFqC20XRtGTZArbbehsEfhpoLA+HkLZdsuPCZCYZwUh2GRijDSu10fsSIG0vJogVsRfV09HxVih7jxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KeOcB33z; arc=none smtp.client-ip=91.218.175.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KeOcB33z"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=N+YY9kP72EJX4e0q1/BpSD+bJ/oqJzCRVO1fh2+Sk7M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790078602; v=1; x=1790683402;
 b=KeOcB33zVuS9tuH1Bq7u0QLT4f7hRrZ6omqQ4tYOxIartMAVKtz+PprWX8jJIL7Urt1TSTJS
 ZL880NRb/CXh3ayuddUXKg4bd+rDENAlX+MC9NGSE5sQac2yU+oChcCGUFOXQbcYItwk+JeNICi
 0fC6aLqAU66HkUYTRWbRzr4c=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 1c9ea4c20335ce24;
	Tue, 22 Sep 2026 12:03:22 +0000
X-Mizu-Trace-ID: 1c9ea4c20335ce24
X-Migadu-Flow: FLOW_OUT
Message-ID: <f56e2df4-1f2b-44e6-b807-dccb60d5393e@linux.dev>
Date: Tue, 22 Sep 2026 20:03:07 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4] bpf: drop duplicate check_app_limited in
 tcp_bpf_push
To: Geliang Tang <geliang@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, mptcp@lists.linux.dev
References: <1f7dc605b16fc0590f7cbf5a27d57271926c01ce.1790074764.git.tanggeliang@kylinos.cn>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <1f7dc605b16fc0590f7cbf5a27d57271926c01ce.1790074764.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/22/26 7:06 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Commit c5c37af6ecad9 ("tcp: Convert do_tcp_sendpages() to use
> MSG_SPLICE_PAGES") moved tcp_rate_check_app_limited() inside
> do_tcp_sendpages(), turning it into a wrapper around tcp_sendmsg_locked().
> Later, commit ebf2e8860eea ("tcp_bpf: Inline do_tcp_sendpages as it's now
> a wrapper around tcp_sendmsg") inlined the wrapper in tcp_bpf_push() with
> direct tcp_sendmsg_locked() calls, which perform the check on every path
> that queues data, but kept the outer tcp_rate_check_app_limited() that
> was previously needed to cover do_tcp_sendpages(). The outer call is now
> redundant.
>
> The site changed here, tcp_bpf_push(), holds the socket lock and invokes
> tcp_sendmsg_locked() on every iteration. The early-return paths in
> tcp_sendmsg_locked() that skip tcp_rate_check_app_limited() - the
> MSG_ZEROCOPY allocation failure and MSG_FASTOPEN branches - return without
> queueing any MSG_SPLICE_PAGES data, so there is no functional consequence
> from omitting the outer check.
>
> A potential benefit of this change is that it facilitates future reuse of
> tcp_bpf_push() for sockmap support in protocols beyond TCP, such as MPTCP.
> Since tcp_rate_check_app_limited() is TCP-specific while sendmsg_locked()
> is a generic interface in struct proto_ops, this change allows us to switch
> to different protocols via sk->sk_socket->ops->sendmsg_locked() without
> carrying protocol-specific assumptions.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


Thanks

