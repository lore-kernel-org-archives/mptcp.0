Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210229;
	b=XAqytNBHVLmarwkNl5nxPo4YQSh5++Nuq5ACA3D0ZJAplBHFiLTq+WHXJmdIa11TVVxF
	 XaqpWYsQFk0BrRzRCbo7sE6KVHsj5mb3T6nufGw39wHWMbuaf/TXhEg+IhLe8W1JwbXzR
	 cXhoQuObuPF5EYkHkhnBhA8b8qvKJKmqD0Ovh8JS5yqG+ZHlpsk2DYb4+4BISo6TRlsfX
	 2V6C8ncwkEmmaKV77PByJcpl1aZ5TB1zCyfaJ/Oy7O8KZ/fHxQmDU1sjooao2h0K9XCGX
	 8R6i8y4eKkYDomCevegMLC9PNUHl0/qAbhhCJIPXwT/SCwRPoiONOFiAFZPwmSHQNig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210229;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=n1FExJ2YYOcMBjxKbzlEbZLCmz73/PfKMECGOdwKHZ4=;
	b=QNerugSa1dSlkaj29+7coPXU6pQu32ULyRSK2m7xjIiq15+Oc8+bOL4gmhPHXp/zvcE6
	 BBymjpsa3kQLRw8v1vA6444a3I0aBzbsf7qconJRcO1T2eh9NI+zirDtd0UvRPelguyyT
	 UlzCbSwt9deamsonYlqHspG1YiSMhaKqwwEZtwgdwR5d0nciT48K3h4DUb9tGC6ZFOzI/
	 30bXYyD0qeckUFGBdMHeLxGjVCLPIvN5UOiqLYdQRzQW3peaS3zk98VOfEBAbpiJ3cVs/
	 4AY7yYZZd6b896CvKJkpbLmcyeSbHeP4PM6ZMyEOwfb9EatjDDhUbXl5/eeLnKTIT8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGJ2dXSK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0F7606A6B8;
	Fri, 20 Nov 2026 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGJ2dXSK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FDD1F000E0;
	Fri, 20 Nov 2026 21:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210228;
	bh=n1FExJ2YYOcMBjxKbzlEbZLCmz73/PfKMECGOdwKHZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DGJ2dXSKcMyS7zYe1iaZ1FoWLjdXOHgpDLM2FlrUdOGCsnej0rvhOPzFOsam/88c2
	 SLtHiUjjsNBJuCuWyhrjDDIlmpL8rmHs/2C13eERhmuLDZemLigJYn0LEo+ISLq3HN
	 li++buSPJwvFolr4WT70hbSQkt7LODWYJMWHzgSlFuNRD8R2V4GTP3loRrF8gkf6Rh
	 jokLMWdhmGK9Pdq8vQs2EBmdgE+3gCoBOQk98PtXlDOE5bFrbspEBL9ejKA/pxyao7
	 y96eKwPdX1mHcE9Vor6kj2b5cunJqUb8zGvtvnbH6cY7Vg+15bjyqW+5EasBqf4KRW
	 rLNZZn2fZeg7g==
Message-ID: <38afe45e-7c7d-4b91-9436-020ded6ca6fc@kernel.org>
Date: Fri, 20 Nov 2026 22:30:21 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v3 3/3] mptcp: limit blackhole_timeout to one day
Content-Language: fr
To: Yingjie Wang <x-professor@outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "edumazet@kernel.org" <edumazet@kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>,
 "gang.yan@linux.dev" <gang.yan@linux.dev>,
 "kuniyu@google.com" <kuniyu@google.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "martineau@kernel.org" <martineau@kernel.org>,
 "geliang@kernel.org" <geliang@kernel.org>,
 "ycheng@google.com" <ycheng@google.com>,
 "weiwan@google.com" <weiwan@google.com>
References: <cover.1794847474.git.x-professor@outlook.com>
 <568bf901e401ab7186ba2af8fabdaeb6cadfd800.1794847474.git.x-professor@outlook.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <568bf901e401ab7186ba2af8fabdaeb6cadfd800.1794847474.git.x-professor@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yingjie,

On 16/11/2026 17:46, Yingjie Wang wrote:
> net.mptcp.blackhole_timeout accepts any non-negative int as the initial
> period for disabling active MPTCP after a blackhole, and the period can
> then grow 64-fold. A multi-day initial period is not useful, and on
> 32-bit kernels, values above about 1,073,741 seconds at HZ=1000 are
> shortened by the MAX_JIFFY_OFFSET cap even on the first blackhole.
> 
> Limit the writable value to one day, matching
> net.ipv4.tcp_fastopen_blackhole_timeout_sec, and document the limit. The
> default of 3600 seconds is unchanged.
> 
> Writes above 86400 seconds, which were previously accepted, now fail
> with -EINVAL and leave the current value unchanged.

Why did you split this patch in 2 for MPTCP, while it is in a single
patch for TCP? Can you avoid the split for MPTCP.

> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> ---
>  Documentation/networking/mptcp-sysctl.rst | 1 +
>  net/mptcp/ctrl.c                          | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index b9b5f58e0625..ca00253c8ae9 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -63,6 +63,7 @@ blackhole_timeout - INTEGER (seconds)
>  	blackhole issue goes away.
>  
>  	0 to disable the blackhole detection. This is a per-namespace sysctl.
> +	The maximum value is one day (86400 seconds).
>  
>  	Default: 3600
>  
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 0b10e94e7f43..1f167f72c1f5 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -20,6 +20,7 @@ static int mptcp_pernet_id;
>  
>  #ifdef CONFIG_SYSCTL
>  static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
> +static int mptcp_blackhole_timeout_max = 24 * 3600;
>  #endif
>  
>  struct mptcp_pernet {
> @@ -350,6 +351,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
>  		.mode = 0644,
>  		.proc_handler = proc_blackhole_detect_timeout,
>  		.extra1 = SYSCTL_ZERO,
> +		.extra2 = &mptcp_blackhole_timeout_max,

Could we also use a variable called one_day_secs like with TCP?

>  	},
>  	{
>  		.procname = "syn_retrans_before_tcp_fallback",

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

