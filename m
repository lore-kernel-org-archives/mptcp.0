Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79218AF6
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 15:26:30 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f42ba32e24so9553005e9.3
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684941989; x=1687533989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/IukcP/zeXnNGwmPJk+W1DF6gX5FVJIJO0PXafTGnk=;
        b=BBOptMzeg1ZI2/14H9QIPQPhHH+eMsxXRrKlExp9XHk3A0Ad9MiDWO4m5XXLAh+xi1
         ClzkoWO9QHGdYfgevhgQSAM1E7Ga5sa7T1+cpN6BWXd+Bdmb3Ypho/d15jwI393NeG4p
         Um3Yuz+k3WUq4FQJzbNEZlwBw65QI/ZgQodZwfLtZ2KywFsn3Z+FtpVEsL++TYsvnTUT
         E+xre+kVob9C3MirWL4HitQ0H7QsHOEZnAKqBLGMrN6cEt0E8EYdra0FdMe0MQNX3PKE
         ux3M6wXFvzSrsdD7hiU7f9HfM9WKzlX54Jev8tjw7USut7wjYmiwwZ812XvvMNSH9fzs
         STFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684941989; x=1687533989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/IukcP/zeXnNGwmPJk+W1DF6gX5FVJIJO0PXafTGnk=;
        b=iAjjMwTF+39I/5C8dJIFc8AO4laif/adagejZvcjFVWg4o/4TWwgAWHyAZ/qhVkkNF
         R51I2eMJbrJYc+cCjXwYAUEaUL0lyJTQtgsA/8nCOvt7zA6Ko/LcllQFuK2NKCygpQg8
         ovEz5QxCmnifrM1OzGcRXxO+e3IkFiheqkhgdzE2p9uhMn2ZQEY55SMH53MQT4iP1alf
         ko7MuKdKTksGfRLQcdPrc3Rn8oY8hZ+qZ0u9DVd/RtmoZ0ZGBf0paxqsqN7xU3USL3Qs
         1nJ8pnbvdGxD0nhjYN0z6y0Rh7Xcf2fm76hbkGsSEzdxxpA6Eb5fVUkTOTrl6mJTujQQ
         BlGA==
X-Gm-Message-State: AC+VfDzQWGF/uo8Snfep6ThhNGJL5V7qwJGO5keUEGHm2gQAB2IpMAWY
	JI67P7q8t2m8lqN+XyJ/N0YVvZ8d7v39cCKCXgYNyg==
X-Google-Smtp-Source: ACHHUZ5PhOjy/QPpraSW8fc77B6lRuHHW2/idAoJzG5SoLMKrTGOfx76LimPfS9801PEja4JFkEZTA==
X-Received: by 2002:a05:600c:ad2:b0:3f6:11cd:f525 with SMTP id c18-20020a05600c0ad200b003f611cdf525mr122961wmr.19.1684941989033;
        Wed, 24 May 2023 08:26:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f96c:b035:8e06:9e3c? ([2a02:578:8593:1200:f96c:b035:8e06:9e3c])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b003f601a31ca2sm2685828wmc.33.2023.05.24.08.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 08:26:28 -0700 (PDT)
Message-ID: <4851f9f3-13f4-eb39-5c8f-9c1921358ea4@tessares.net>
Date: Wed, 24 May 2023 17:26:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <cover.1684935727.git.pabeni@redhat.com>
 <72ebf53600698f09b96900f8b3fbd2d4c1261b6c.1684935727.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <72ebf53600698f09b96900f8b3fbd2d4c1261b6c.1684935727.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 24/05/2023 15:50, Paolo Abeni wrote:
> Some user-space applications want to monitor the subflows utilization.
> 
> Dumping the per subflow tcp_info is not enough, as the PM could close
> and re-create the subflows under-the-hood, fooling the accounting.
> Even checking the src/dst addresses used by each subflow could not
> be enough, because new subflows could re-use the same address/port of
> the just closed one.
> 
> This patch introduces a new socket option, allow dumping all the relevant
> information all-at-once (everything, everywhere...), in a consistent manner.
> 
> To reuse the existing helper to manipulate the new struct, keep the binary
> layout of the initial few fields the same as mptcp_subflow_data.

(...)

> +	lock_sock(sk);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		if (sfcount++ < sffi.num_subflows_user) {
> +			struct mptcp_subflow_info sfinfo;
> +			struct tcp_info tcp_info;
> +
> +			memset(&sfinfo, 0, sizeof(sfinfo));
> +			sfinfo.id = subflow->subflow_id;
> +			mptcp_get_sub_addrs(ssk, &sfinfo.addrs);

Would it be worth it to first check size_sfinfo_user > sizeof(sfinfo.id)
before retreiving the addresses?

> +			if (copy_to_user(sfinfoptr, &sfinfo, sffi.size_sfinfo_user))
> +				goto fail_release;> +
> +			tcp_get_info(ssk, &tcp_info);

Same here: just checking if sffi.size_tcpinfo_user > 0, just in case the
userspace doesn't one and/or the other.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
