Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18992FAF
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 17:11:45 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id 30so9940859edw.5
        for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LJFiVgm+cvgYgRsHTWVT23V3eG4Cs5qZfVA/Ahe4xuo=;
        b=KPkfoWh0XQgoxjA7FbBt+8ywQQe7ptO99oicvleJQJiNFfetsVhaUNhO+kDp3r6TSk
         JbL0HfcGN2PnbZuan8so4j4oCBVtcWyq/RrJ4t1Y7mFIQoMYLyx3dH+X940NjtGta8mH
         QlareVSgSmrtnqQ+vIL3bpablZDRIO9JsECv4x0XDMBgMK2rCFl5FdkFOznwEuty/xmU
         bhDzKgArV8Ix+RjS2LuFUlosUkl1gmz4yZnAPYD9KJsVzQI7CRvSXajJOTFkFPWwo/C2
         6PhM7mW1DC29U3MvyWLFZZ59hD/fMRAAt/ZACNd7I4J0mu78QoEOqXVqU8Wq2kx6o9LI
         56Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LJFiVgm+cvgYgRsHTWVT23V3eG4Cs5qZfVA/Ahe4xuo=;
        b=GWypmBlj2YmMyZK3REtpEIjEpMsqgXufrZWGUWxux6kHk8MAX4Rrog3Zoe7AtTe4PZ
         zDltWT6veqCyUGXRBV4TKR0xdTOPOThrMFguMAMGjr1vhgTdEg7Cv/rmgpPEfBeGsB4S
         SSOG6JJBo1gpTrep86XeaJ5TzE26PvnIc1t50DuUghfe2lJjUXUljb/T0rHyddWyFX86
         UrFJiVkG7j+xsNW06Z0uZNS517NoEs29HNqcw6154s4HOUeBw6NDtKgCgZ9L6hvr+Rix
         9E++DZVSCpyXnZwLGDNE8v/Z49CbCQc2BiImVH+rluwzOJ2Y5ZlHNEToM/TMenBDdloG
         rfkA==
X-Gm-Message-State: ACrzQf2hhef3PFDaYKXcowV9EAlvyPkRhwmh8KEgSQFVWu2pHhBNpuyf
	B7tbzrcvBPkrCUb2jRQiOlgaNg==
X-Google-Smtp-Source: AMsMyM6kJwSMq2MhyMdVa01pQDYKDvKfNSlxySL7uFyBkHxANTBzbTLB+8GEWKMTwAVLnenpF9hXgA==
X-Received: by 2002:a50:fc9a:0:b0:454:6a56:7d27 with SMTP id f26-20020a50fc9a000000b004546a567d27mr23213412edq.73.1664212303882;
        Mon, 26 Sep 2022 10:11:43 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d58b:a76f:9c42:d02a? ([2a02:578:8593:1200:d58b:a76f:9c42:d02a])
        by smtp.gmail.com with ESMTPSA id i9-20020a0564020f0900b0044e937ddcabsm11793806eda.77.2022.09.26.10.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 10:11:43 -0700 (PDT)
Message-ID: <f132db08-8601-40d3-9477-ae914e96165a@tessares.net>
Date: Mon, 26 Sep 2022 19:11:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v11 3/4] mptcp: add
 mptcp_subflow_conn_sock()
Content-Language: en-GB
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
References: <20220925232601.25252-1-dmytro@shytyi.net>
 <20220925232601.25252-4-dmytro@shytyi.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220925232601.25252-4-dmytro@shytyi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmytro,

On 26/09/2022 01:26, Dmytro Shytyi wrote:
> In the following patches we will call mptcp_subflow_conn_sock() from 
> tcp_sendmsg_fastopen() in file "net/ipv4/tcp.c", thus make such symbol
> visible.

The patch description and title don't seem to be correct. You are doing
more than that here.

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 5702ca9b952d..a22c8044de17 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1197,8 +1197,19 @@ static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  		}
>  	}
>  	flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
> -	err = __inet_stream_connect(sk->sk_socket, uaddr,
> -				    msg->msg_namelen, flags, 1);
> +	if (!sk_is_mptcp(sk)) {
> +		err = __inet_stream_connect(sk->sk_socket, uaddr,
> +					    msg->msg_namelen, flags, 1);

Do you think it could be possible not to modify tcp_sendmsg_fastopen()
but instead implement '.connect' callback in 'mptcp_prot'?


> +	} else {
> +		struct sock *parent = mptcp_subflow_conn_sock(sk);
> +
> +		release_sock(sk);
> +		release_sock(parent);

It looks strange to release sockets because, I guess, they are going to
be re-lock just after. It certainly means you want to call a (new)
function which is not doing this locking bit, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
