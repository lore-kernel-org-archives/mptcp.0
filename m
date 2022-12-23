Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C28476
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 14:35:26 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id gh17so12456023ejb.6
        for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 06:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ms2l1ot9hjUY5aHBLeDUw2cEAyqh22VfyMDXfPbp8G0=;
        b=Dww63OJBUAB9CGBJvC8EX6fE9z7vGBSv7w774LuOHdLeVFxnlIq1LCxHU0HRRSZXyg
         p0yTyutIqbAuJ0rojsfSUza+Azrl3x+35rg1dVldooKwuFN7+2A+6KrYoEot1xP+xeh7
         Nppr9r/kbpTEszcPQ9K1Ygt0Q/1k8CQbIBr5jLkKdr6l1YMdPiQzRT9+8V6V1fm7fFKw
         6P7b1PDNSqeAV+RP+2uJ1nSk+ZrJNM+RxOwhTyZRLOgnlDTb3snWOaPHIHpZV9fYEE0M
         CAGRHhNsSHosiaNpCogvdzzCxYXaIe3l46QNcg/DPbVf84PbGWC78cTOYVolVkN4xrv5
         Y2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ms2l1ot9hjUY5aHBLeDUw2cEAyqh22VfyMDXfPbp8G0=;
        b=X4mKcGLGtTmyQ+FjvdyRoVPXw0dYRTb97QsquH4y+cWbn5l3ebZrbyBavhTofotU0N
         iCsqjAUb3TIsbTkEtNuD5ebYLKzgMHzGv2ePlS74h4mE50iKV+5+yRUsrOS1SbBjO2qs
         oTYvzT5pJ5cWBra5O5+Yi4j/MfmXWdoiHlW72sm2Y+5WK9Z6zpfxVdvjJ+/5ylhend3k
         e+V/0m/pq5s32SE/nexNZ7aMUocuMbQ8IHDMBXEvJj6jPmWxpJKFasjqO8e622aHyrcO
         QtFlRl7TXxepkuvnnvvJ46poJAuwUVWqq5DxRLucMB0Il78Ry8uzPQu2KXcbEnXQBlX3
         iAKA==
X-Gm-Message-State: AFqh2krC01EbMzesAO6lcttzWDrqFDny7IQ3tbS9NG4gV2UtN+mBdSQH
	ChwdQ642i5EIyr7n8ZGkbYU4YguvUPBCX+fr/OPZzA==
X-Google-Smtp-Source: AMrXdXvQ+1pw1Ma6AH4kLwu9CA3O8RsFJ04TuVwsAhKelIj2vGrGKkyBvM7RApM65df2wwYT72+LUg==
X-Received: by 2002:a17:907:9b09:b0:849:e96f:521b with SMTP id kn9-20020a1709079b0900b00849e96f521bmr1747026ejc.32.1671806124955;
        Fri, 23 Dec 2022 06:35:24 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090623e200b007add62dafbasm1416600ejg.157.2022.12.23.06.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 06:35:24 -0800 (PST)
Message-ID: <2124b7ef-563f-1f42-2315-ab00e18782b5@tessares.net>
Date: Fri, 23 Dec 2022 15:35:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mptcp-next 2/3] mptcp: let the in kernel PM use mixed ipv4
 and ipv6 addresses
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1671799401.git.pabeni@redhat.com>
 <2aabefc61c5e7212d57156971633660d50176a4b.1671799401.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2aabefc61c5e7212d57156971633660d50176a4b.1671799401.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for having looked at these patches!

On 23/12/2022 13:51, Paolo Abeni wrote:
> Currently the in kernel PM arbitrary enforces that created subflow's
> family must match the main MPTCP socket. The RFC allow instead for
> mixing IPv4 and IPv6 subflows with no constraint.
> 
> This patch changes the in kernel PM logic to create subflows matching
> the currently selected source (or destination) address, effectively
> allowing the creation of IPv4 and IPv6 subflows under the same msk.
> 
> While at that, factor out a new helper for address family matching,
> taking care of ipv4 vs ipv4-mapped-ipv6.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/269
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/pm_netlink.c | 57 ++++++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 27 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index f2a43e13bacd..1d4ba6716a98 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c

(...)

> @@ -600,10 +610,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>  		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
>  
>  		msk->pm.local_addr_used++;
> -		nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
> -		if (nr)
> -			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> +		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
> +		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);

I see that you removed the 'if (nr)' condition: was there a bug before?
If no addresses have been filled, no new subflows will be created below
and this ID is still available.

>  		spin_unlock_bh(&msk->pm.lock);
> +
>  		for (i = 0; i < nr; i++)
>  			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
>  		spin_lock_bh(&msk->pm.lock);

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
