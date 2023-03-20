Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A2D1FBF
	for <mptcp@lists.linux.dev>; Mon, 20 Mar 2023 16:09:04 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id b20so15845976edd.1
        for <mptcp@lists.linux.dev>; Mon, 20 Mar 2023 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679328543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Moer0UjNCxaN5LOpf3bM733HljpstT+YD80jPA/zdFg=;
        b=iZ9nzm2ODUvvkIZrjm7n2jONtH0xfKjLjCCRDI4Eo4h1lxpRYsDneQfOhNRgvfhheQ
         IMcC5b8FDhPEzHspOu3FxEJyz4bkPD5oWdcjtqJsdi9aXazwP0DoA4dpMv2KUdezaO0j
         UrR5FuRKtxktM7ZVlEINZ4sxqGCHoIuzeNjkohUjXXQeTqjI3Lb/+rWkm8eDgzjMeZv4
         zRrcnGbiT78ECWt8N7xv7ID4SozFRoxVA3Dx7gZTwCz9w/fnCh+kOoYsyhBcGxtIHWpv
         QU5oHxq8wPH9QQlTDF28Q9Y5VJRxv3w4+uPIi8JyQh8wbGr7gwSqVjH4l5J6k7R496+X
         8axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679328543;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Moer0UjNCxaN5LOpf3bM733HljpstT+YD80jPA/zdFg=;
        b=LXlDdtd/9UQiSNkN36W3Ui0RXpkZYklqVG7+rPX+I4SIlKGCxaw0zqsVOYFarLUGWB
         k4gAOwITKpSxfzIgHsE5gvCrV1CYGOc7gY95Pj8G2rafdLHwRn+rafz6NRI8xPquS36c
         OBuNpe5f8eBRGAlC9lFlQSjuvMHBQ4D9Ry3ObZV8DTOpY2g3g2Ky2LyWkYpKhaste0mo
         NsnSRJJalZsiaoeH54tlUZimjgNFFZs5sH6Eqj//5kdiuYtcTEBjmriL9sgf+5BnHgdk
         2rRpIIBGAw5LWlrn3ljfHXPIXiLg5O2+7hUX8XK3Hlq91nYGIYilr2gu970GN/cQLtY7
         doTg==
X-Gm-Message-State: AO0yUKUyNjnW8SwBE9+yuP2J1N5YlheLtXi0XDl0FdFvaSbzXXGrtmhw
	QHDsBN+oUVwesVHUJrqeGro31g==
X-Google-Smtp-Source: AK7set8sD4egq9z5UmO3BYKz/rBq5xKlRxShVFv6YV6jD4Nrt0GoUA7mSEcrb8y+bnNnLs9jU5hqww==
X-Received: by 2002:a17:906:86c4:b0:926:c7ac:51fd with SMTP id j4-20020a17090686c400b00926c7ac51fdmr9591686ejy.44.1679328542900;
        Mon, 20 Mar 2023 09:09:02 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id mh12-20020a170906eb8c00b0093210cf625bsm4252256ejb.187.2023.03.20.09.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 09:09:02 -0700 (PDT)
Message-ID: <8387b3ee-c7dc-6555-c914-6cf856375fcc@tessares.net>
Date: Mon, 20 Mar 2023 17:09:02 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH mptcp-next v5 3/7] mptcp: close remote subflow when
 destroying it
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1678778977.git.geliang.tang@suse.com>
 <d47a06abb5dae1f333a496183da5ba3e51e5a98e.1678778977.git.geliang.tang@suse.com>
 <067bd46b-9c12-36cd-8ea5-3667669dc6cf@tessares.net>
 <CA+WQbwv1gBROrXG-8Fb=T+p6rQNf5PF0gKB95mJzfQdsH8-mGg@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwv1gBROrXG-8Fb=T+p6rQNf5PF0gKB95mJzfQdsH8-mGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for your reply.

On 20/03/2023 12:41, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for your reviews.
> 
> We always remove address together with subflow, see
> mptcp_nl_remove_subflow_and_signal_addr() or
> mptcp_pm_remove_addrs_and_subflows().
> 
> So we always get "chk_rm_nr 1 1" in these tests:
> 
>         # single subflow, remove
>         if reset "remove single subflow"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_set_limits $ns2 0 1
>                 pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
>                 chk_join_nr 1 1 1
>                 chk_rm_nr 1 1
>         fi
> 
>         # single address, remove
>         if reset "remove single address"; then
>                 pm_nl_set_limits $ns1 0 1
>                 pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
>                 pm_nl_set_limits $ns2 1 1
>                 run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
>                 chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>                 chk_rm_nr 1 1 invert
>         fi
> 
>         # userspace pm add & remove address
>         if reset_with_events "userspace pm add & remove address"; then
>                 set_userspace_pm $ns1
>                 pm_nl_set_limits $ns2 1 1
>                 run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
>                 chk_join_nr 1 1 1
>                 chk_add_nr 1 1
>                 chk_rm_nr 1 1 invert
>                 kill_events_pids
>         fi
> 
> But the userspace remove subflow test got "chk_rm_nr 0 1":
> 
>         # userspace pm create destroy subflow
>         if reset_with_events "userspace pm create destroy subflow"; then
>                 set_userspace_pm $ns2
>                 pm_nl_set_limits $ns1 0 1
>                 run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
>                 chk_join_nr 1 1 1
>                 chk_rm_nr 0 1
>                 kill_events_pids
>         fi
> 
> "chk_rm_nr 0 1" means getting no rm_addr, but a rm_subflow.

Indeed but you have this behaviour only because the userspace PM didn't
send this RM ADDR, no? I agree it might be better to do so but it is not
mandatory if I'm not mistaken, especially for the client side. Then it
is up to the userspace PM to decide to send the RM ADDR or not and we
cannot force it I would say.

Or maybe the client side cannot send a RM ADDR? (on the other hand, the
address was not announced with an ADD_ADDR so why do you want to send a
RM_ADDR?)

(if there is a need, we can ease its use with an extra flag but I don't
think we should force this behaviour, it is up to the PM to do that, no?)

> This behavior is incorrect. This patch fix it. It looks through the
> userspace_pm_local_addr_list to find the addr id, and send RM_ADDR
> with this id.
> 
> So patch 2 is needed to add the address into
> userspace_pm_local_addr_list, and patch 1 too, no clear the address
> id.

Would it not work if you modify do_transfer() to use pm_nl_ctl to send
the RM_ADDR then do the destroy (I don't know if doing the opposite is
supported)?

But again, I don't think we need to send an RM_ADD if no ADD_ADDR have
been sent before by the client here.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
