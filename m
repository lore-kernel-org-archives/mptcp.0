Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDD7C
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 09:37:35 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id 13so4757784ejn.3
        for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mAIS227oRGXEAXHdtJVg1j2EEC84dJWyBSQ5l6BA/9g=;
        b=krFPf18Yykrd/QffHq9PvfPzd6z42qSaAOluyEWEwkmjzioHbe//0BQFOhE8/nCEtH
         b0yeGoMmnCTMi5T7Osq7fuC7dSLqBSCh0t4v8I+/Bz5ytuh04HsviIShVObtNG+lS8gd
         g3J1AueDI4oEZlK7pha72Ci7kqvZLcWwR9BFCaF0uSvUvymUD6vYE4kHdaNjPXg7Ge3B
         fBrrbckFyUiTayiQPJX7KVWNqzwypiAKxKu1cnzbla8JVm2UDzdPQv36u1iqY5Pb61S9
         SzA3mfMFEyo6ohi0hYQrgdyGZXJQmOGIuWWfnaT0VlQaS4RVSsXriOTSC6XosngkbdBh
         Qhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mAIS227oRGXEAXHdtJVg1j2EEC84dJWyBSQ5l6BA/9g=;
        b=7Vq3Z3TbK+pKWzDotfATf6i0eJe9F+dpC3xt0F4ioOaGw5nbZ+T+9HZwfQK0EyxLBt
         ISZkUPmO2vbUFK5mQ18ErnJWNQ11Smb12WZxdeRJqzkkxAKCMk8KB/C0O+gBBMEub7gG
         3nJYWc1PaYjsGiqVm3OG3W8ArNyW3vFY9gsp9M23WdR7YYQJzPR+N0r5+Q3r7p+ZOJhC
         9OEZcq/XOJ3H+hYO48Xww9WF+spFK+OEpNqYRBfJiXEbG20uUffUSkfCAAFVo+Ct6FqT
         augYNLj68fvysvwPy2QDb4eFQEmuV2SZ3Xz6kYMBHlGH115TN0H2J8qrjcodz29Ks4nT
         1tcw==
X-Gm-Message-State: ACrzQf0ybO+C7fEMtC4cgESXv14g8vCrU12+vMtFR5pgjG3S/zXEj3x1
	hJUpVKfyaUXbwX3ofh9zV1ArgM9wtFNitRxt
X-Google-Smtp-Source: AMsMyM4YaJHCzOupeycNiKZoJlLGEekdsSEJV+Kwpgbhyh3maE1A7OW9mU942JJ6f71lSSFoNCdMWA==
X-Received: by 2002:a17:907:60c6:b0:77c:e7ee:67c with SMTP id hv6-20020a17090760c600b0077ce7ee067cmr16135999ejc.425.1663666653556;
        Tue, 20 Sep 2022 02:37:33 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:3889:e22b:91b6:4dec? ([2a02:578:8593:1200:3889:e22b:91b6:4dec])
        by smtp.gmail.com with ESMTPSA id lt10-20020a170906fa8a00b007815ca7ae57sm524811ejb.212.2022.09.20.02.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 02:37:33 -0700 (PDT)
Message-ID: <fc096cda-4522-ca8e-1c2f-a0d036923f11@tessares.net>
Date: Tue, 20 Sep 2022 11:37:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v7 06/11] add mptcp_setsockopt_fastopen
Content-Language: en-GB
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
References: <20220917222853.2406-1-dmytro@shytyi.net>
 <20220917222853.2406-7-dmytro@shytyi.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220917222853.2406-7-dmytro@shytyi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmytro,

On 18/09/2022 00:28, Dmytro Shytyi wrote:
> Add set MPTFO socket option for MPTCP.

It is often very helpful to not just mention what you are doing here
(e.g. add XXX) but explain the reason why you are doing this. Getting
the reason is often not clear when looking at a commit diff so it is a
very valuable info to add in a commit description.

For example here, it could be nice to explain this option is needed for
the listen socket only to accept TFO. And also why you are changing the
values directly, what it is similar to, etc. etc.

> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  net/mptcp/fastopen.c | 28 ++++++++++++++++++++++++++++
>  net/mptcp/protocol.h |  2 ++
>  net/mptcp/sockopt.c  |  3 +++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index 50b5c3376672..436e773d798a 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -63,3 +63,31 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>  	ret = -EFAULT;
>  	return ret;
>  }
> +
> +int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
> +				      unsigned int optlen)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +	struct net *net = sock_net(sk);
> +	int val;
> +	int ret;
> +
> +	ret = 0;
> +
> +	if (copy_from_sockptr(&val, optval, sizeof(val)))
> +		return -EFAULT;
> +
> +	lock_sock(sk);
> +
> +	if (val >= 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
> +	    TCPF_LISTEN))) {
> +		tcp_fastopen_init_key_once(net);
> +		fastopen_queue_tune(sk, val);

Can you not call tcp_setsockopt() here instead of copying what is done
in do_tcp_setsockopt()?

It would be simpler and easier to maintain I think.


Also, in general for the series, may you add 'mptcp:' prefix in the git
commit titles?

What is important too is to add comments if what you are doing is
similar to what is done in TCP, e.g. similar to XXX() in tcp_XXX.c? You
can add a short comment in the code and explain why you are doing that
and not call TCP functions in the git commit description for example.
That would help a lot reviewers and maintainers later.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
