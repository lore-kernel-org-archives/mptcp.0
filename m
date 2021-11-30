Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEE62C80
	for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 16:52:47 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id g14so89520718edb.8
        for <mptcp@lists.linux.dev>; Tue, 30 Nov 2021 08:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=FVIvY2PQLCC4AwaZG2KGGUIdVhk+r7Tzj0ajWWQc3II=;
        b=yBjjUHPHI8DqJB1NIND4KJmQ9QhaO4/yQItAbpbENctQ9aDvq2nSjPVfLr+Vt+O4q3
         SVhmMQIJgoEVzKeRCJPFduAvwWoLtrqRyi21KWXhIZMAXgn087ZEKN31Mpc56pqQ7ukU
         zR7Wjz600NFAWrNxa/LzONA7B5GBHSS5NYatRT5nQydhh1pAu/dBBNVwadur83TvsWct
         n7ij1x/FsRwaghgZzIKPASCO4DYe9IzWzniDsjmMJn5iJ0YT27DAFIquTg8oBvrvcreN
         JMyDdYx6jL8mTVwEN7+CAacxdRgMJLV6I0MpMRhxaevPMAPjgDO4dmK7MrGfWr6MHq2k
         piQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=FVIvY2PQLCC4AwaZG2KGGUIdVhk+r7Tzj0ajWWQc3II=;
        b=FhJKhdOariuA9tMeGMX9Vth/Ls7azncbb7/NnT2GrzgxynitXtYd5GO1WB5ilmUcMz
         9BIcIpyX+2xlFW/bWlgQazjcwNlwVRkJiZuveGiZHPci+I8IZ94WAkkYqqfHlOAAwrqB
         yE9tGMx058q4HYbxaqkD5uMQa0Wkxf3pzqQYxznPrGZA3hI/lSrHPZ72bUikW9TUDsiy
         fXkBzxpTYZTBREiyyzNbYS3T4xW2NBz3vqYaF6CYfP30g2Pot6JjHGpnQ+P2f1OiFVb5
         x6Z9cHG4FjfWWnPdctH3OP6ee0S/Juvsk8JeySOAelvqN6ZGrx1dDBRV/W8+OFsNGNUT
         JLwg==
X-Gm-Message-State: AOAM532vGuXa1OQPXKJXt6nV8XkH6TTC9tqLPcpOnecxzM+h1alDAWOn
	Tt6OpUNcw3dibufWar/jalRqJg==
X-Google-Smtp-Source: ABdhPJyfABIoRxHKXp5cnWMqZcohKeOyJ47sp4yKtFnKdfIDwLHwZK7vEOOTnhDYVvjqfY0bIuXeow==
X-Received: by 2002:a05:6402:2152:: with SMTP id bq18mr153095edb.105.1638291166029;
        Tue, 30 Nov 2021 08:52:46 -0800 (PST)
Received: from [192.168.178.33] ([213.211.142.51])
        by smtp.gmail.com with ESMTPSA id u23sm12034211edi.88.2021.11.30.08.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:52:45 -0800 (PST)
Message-ID: <e7427851-a812-05b7-6441-cb9e6f61e65c@tessares.net>
Date: Tue, 30 Nov 2021 17:52:45 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next v3 1/2] Squash to "mptcp: implement fastclose
 xmit path"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <cover.1638242181.git.geliang.tang@suse.com>
 <a3d0dcbe4167eb77b7a275e113abb484d3cdfab0.1638242181.git.geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a3d0dcbe4167eb77b7a275e113abb484d3cdfab0.1638242181.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Adding Paolo in cc as he wrote the original commit.

On 30/11/2021 04:21, Geliang Tang wrote:
> As described in RFC8684, 3.7 Fallback:
> 
> '''
> Therefore, it is not possible to recover the subflow, and the affected
> subflow must be immediately closed with a RST that includes an MP_FAIL
> option (Figure 16), which defines the data sequence number at the start
> of the segment (defined by the Data Sequence Mapping) that had the
> checksum failure.
> '''
> 
> MP_FAIL could be sent with MP_RST at the same time. This patch fixed it.
> 
> This patch also did a small cleanup, to keep the options order in
> mptcp_write_options() as this comment said:
> 
> '''
> /* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
> '''
> 
> This order matches the options order in RFC8684, 7.2. MPTCP Option Subtypes
> too.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/options.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 8a1020e4285c..35425fb4b179 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -828,8 +828,11 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>  		return false;
>  
>  	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
> +		if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
> +			*size += opt_size;
> +			remaining -= opt_size;
> +		}
>  		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
> -		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
>  		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {

Thank you for the new version.

This is now aligned with what we can find in mptcp_write_options() but
is it correct?

Here you say:

* FAIL + RST:    OK
* FAIL + FCLOSE: OK
* RST  + FCLOSE: KO

But is it correct? Is it not:

* FAIL + RST:    OK
* FAIL + FCLOSE: KO
* RST  + FCLOSE: OK

No? It sounds more logic to me to add more info (MP_RST) in an MP_FAIL
or MP_FASTCLOSE if there is room. Can we have both an MP_FAIL and an
MP_FASTCLOSE in the same packet?

This really shows we need a packetdrill test to agree on that and
validate this behaviour :)

Let me send a patch of what I have in mind. (it is too long to be
readable here I think).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
