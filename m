Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0F659
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 14:36:00 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-313e742a787so969978f8f.1
        for <mptcp@lists.linux.dev>; Mon, 04 Sep 2023 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1693838159; x=1694442959; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q6EllYfryTMszkksczkXEkd0HAM/TB1cEZtSQfS1qb4=;
        b=sC/1E0ElrBmFbm3aDBAJF7YPsebhuNiy3Ba97ig8M0ZqohyInG1zaQf8fUkumVeB7v
         WBnL0IYz3QICH7SKs+vHPVbiA5r26LPq4uv+v8VXhbP9RE3Xe9e5PESybtGEjQ8TY2oj
         OKZaPEfH12fHCJkdoyki6XtTVUbl+vgY9eLiawq2Ms0oYpFAYbNWGUXG3wdCehXQ23Rf
         InOKq/+aLrurjtCuh7C2UOZpK1gyTOMnIEXGHGrEBKMGYZiambLN3ixjkMJWnVbcRDKk
         S3CP4wvnheoVumyoTsUf216wnyyojDC7HHySK1T9lHr+j6Lo+5CAZjTgyPwMs3Vnj2BW
         SNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693838159; x=1694442959;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6EllYfryTMszkksczkXEkd0HAM/TB1cEZtSQfS1qb4=;
        b=bxiHi5zLYIad4Zw0LuA0nsKz58RISFPdi2Q1RrfiQ+j62WfKBoTWffr7y1D1DQS2xr
         mc6UbfK416dOfCMCshSNfeH5HDhA9rzGn8ZEfm4aeSG4QEtaz8JKtj/OSqzmmSIfLPsr
         LmCU1n4WurpELiDE7elVayR2UigKGx7f46sARN5tc97m4UluZuBc9PFBXlWWDFkwIKIr
         tLUqjB7ujJzQ5KNflqN/enjhUg0HWnBaPrza+OmVRDG+tTjQJQxYr/h91upxBB2z4PyR
         5YQVs5/ZQG92mLgVYwmBKLrR86TtjYfb6p1b1zo+AtCMerHAg/b+t0we7VpDtUOHCnZX
         h9QA==
X-Gm-Message-State: AOJu0YykmkHMdw8EbmW2pec/WM4Gvl4yxTz+k0gw56+ig8oMYYcJuFQf
	gAFYEmHGeXwpb/5BcvLNkR9V+6209c8DcNwj6TM=
X-Google-Smtp-Source: AGHT+IGb+t6FORVv+8JorLOniQ1UdyMRd2Fw0I8NphsgekxSOSeT0W1J2lDnMEhvRFqLApO13YyPsA==
X-Received: by 2002:adf:ee90:0:b0:319:6b56:94d9 with SMTP id b16-20020adfee90000000b003196b5694d9mr9008122wro.2.1693838158936;
        Mon, 04 Sep 2023 07:35:58 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id y13-20020adffa4d000000b00317df42e91dsm14797329wrr.4.2023.09.04.07.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 07:35:58 -0700 (PDT)
Message-ID: <4a3f0eaa-f915-49dc-8948-a581a6e78542@tessares.net>
Date: Mon, 4 Sep 2023 16:35:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] mptcp: add a new sysctl for make after break
 timeout
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
References: <85f43bff28d6d080642a968c12f68f87ee4baf5c.1693835482.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
Cc: mptcp@lists.linux.dev
In-Reply-To: <85f43bff28d6d080642a968c12f68f87ee4baf5c.1693835482.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 04/09/2023 16:08, Paolo Abeni wrote:
> The MPTCP protocol allows sockets with no alive subflows to stay
> in ESTABLISHED status for and user-defined timeout, to allow for
> later subflows creation.
> 
> Currently such timeout is constant - TCP_TIMEWAIT_LEN. Let the
> user-space configure them via a newly added sysctl, to better cope
> with busy servers and simplify (make them faster) the relevant
> pktdrill tests.
> 
> Note that the new know does not apply to orphaned MPTCP socket
> waiting for the data_fin handshake completion: they always wait
> TCP_TIMEWAIT_LEN.

Thank you for having shared this patch!

It looks good, I have a few comments below if you don't mind:

(...)

> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index c46c22a84d23..b22d41729076 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -27,6 +27,7 @@ struct mptcp_pernet {
>  #endif
>  
>  	unsigned int add_addr_timeout;
> +	unsigned int close_timeout;

Sometimes, it is good to add a suffix indicating the unit being used but
I guess here in jiffies, we don't need that because the time is usually
in jiffies, right?

>  	unsigned int stale_loss_cnt;
>  	u8 mptcp_enabled;
>  	u8 checksum_enabled;
> @@ -65,6 +66,13 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
>  	return mptcp_get_pernet(net)->stale_loss_cnt;
>  }
>  
> +unsigned int mptcp_close_timeout(const struct sock *sk)
> +{
> +	if (sock_flag(sk, SOCK_DEAD))
> +		return TCP_TIMEWAIT_LEN;
> +	return mptcp_get_pernet(sock_net(sk))->close_timeout;
> +}
> +
>  int mptcp_get_pm_type(const struct net *net)
>  {
>  	return mptcp_get_pernet(net)->pm_type;
> @@ -79,6 +87,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>  {
>  	pernet->mptcp_enabled = 1;
>  	pernet->add_addr_timeout = TCP_RTO_MAX;
> +	pernet->close_timeout = TCP_TIMEWAIT_LEN;
>  	pernet->checksum_enabled = 0;
>  	pernet->allow_join_initial_addr_port = 1;
>  	pernet->stale_loss_cnt = 4;
> @@ -140,6 +149,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
>  		.maxlen	= MPTCP_SCHED_NAME_MAX,
>  		.mode = 0644,
>  		.proc_handler = proc_dostring,
> +	},
> +		{

(nit) it looks like the indentation is not OK?

> +		.procname = "close_timeout",

Do you mind documenting this new entry in
Documentation/networking/mptcp-sysctl.rst please?

Also, here as well I guess we don't need to add a suffix "_s" or "_sec"
for the unit because usually it is in seconds, right?

> +		.maxlen = sizeof(unsigned int),

Just an idea: would it make sense to accept -1 as special case for "no
timeout"? (maybe not, we can always put a huge value? also I'm not sure
we can use proc_dointvec_jiffies() with -1 and I wonder if they handle
UINT_MAX with the conversion but that's a detail)

> +		.mode = 0644,
> +		.proc_handler = proc_dointvec_jiffies,
>  	},
>  	{}
>  };
> @@ -163,6 +178,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
>  	table[4].data = &pernet->stale_loss_cnt;
>  	table[5].data = &pernet->pm_type;
>  	table[6].data = &pernet->scheduler;
> +	table[7].data = &pernet->close_timeout;
>  
>  	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
>  	if (!hdr)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 80d06cab8bc7..8022f00190ad 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2501,7 +2501,7 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
>  		return false;
>  
>  	return time_after32(tcp_jiffies32,
> -		  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
> +	    inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));

(nit: the indentation looks strange but maybe what you wanted?)

>  }
>  
>  static void mptcp_check_fastclose(struct mptcp_sock *msk)
> @@ -2643,7 +2643,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
>  	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
>  		return;
>  
> -	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
> +	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
> +			mptcp_close_timeout(sk);

Do we need to do something special if mptcp_close_timeout(sk) returns 0,
AKA close the MPTCP connection immediately?

>  	/* the close timeout takes precedence on the fail one, and here at least one of
>  	 * them is active

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
