Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F091C02
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 15:33:42 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso71068275e9.0
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681832021; x=1684424021;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqniuTWyQYQ7DQfWiMA+6+hrIXykLf5WDrCuUDpdVMw=;
        b=X0jnmSaXcRSbwRVTQ9HoAr6oHKy4mOAshsPWsiGEqBcO7BEb6MlJwcxK6ZGTl/tr8q
         vvzMeA4AvIgUVIIdZOZwlg6ORtQ7anPQxa6m2mtdCPHf2Yrpf64nz6N1zit4DbWpuyqM
         FD2gG0chzeqvBRD7h4P1dC5IHDSNSMWi21O+iwwu2ZrpdlG2NKDQsT/tMlPBlXr9Z6aT
         eBDMG2499Tg8X0sM2X6KGOgc3D8TCSld8u6+lFBo2VSY2VHzJvV7iHmO/wRq5aWZKwbZ
         Ga9vsCDhNrJm9Xy4G4etaAy719EzY2T2U7Am31rC2OZNmdqYwJ+EgYkbnHuuEbqHMpih
         i1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832021; x=1684424021;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqniuTWyQYQ7DQfWiMA+6+hrIXykLf5WDrCuUDpdVMw=;
        b=gMzzdC4DOb02uMISb8k1UmdkdRjwLDtAbZPxaxcyEXQ9ljVi0wHJaJh6VUcOCsYctm
         1C6N/enxREVhMKV5Yitg/aa7jZ2cxW2vIFHUq3hpghtL4/4t/wk0RMRealySzFLONL6D
         7YI9VbOsUhSRsCR642k9LS6RzZYWnyvV73+KBnbj0KFr2Rd3g6O1pDLgmHrLqN47g4U8
         RsLeCx9PKoFw0lBF5aVUbKGf37eYdHmojSSl/0sJvyFnkUJ+FB0YPb480AAX2MI+jtY5
         vtuj84JnXx6XzxayiZCXg6M3/p2GkpkDZNBiocqIZV9g1F3eewncovfHHIQ5lLVl9k9/
         Z2UA==
X-Gm-Message-State: AAQBX9dTL/XAKmsxf2pEu+JRtZSNFqFaBgp4Y7PqYOHXNtwnUz6x2eNz
	9SKQU4JExItRzXgYKQTwjEdVKKp3DfWygZ4297HEJw==
X-Google-Smtp-Source: AKy350bOQj0s1BpkrR6Fcq6ZWKBvJceQ8AR+vnuhDubV8qYvYupAZ9ycLWEclwX535t8SImlCCjxPA==
X-Received: by 2002:adf:dd82:0:b0:2f7:cfe2:6507 with SMTP id x2-20020adfdd82000000b002f7cfe26507mr2382247wrl.20.1681832020786;
        Tue, 18 Apr 2023 08:33:40 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1b76:be36:72bc:27e0? ([2a02:578:8593:1200:1b76:be36:72bc:27e0])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c4f4b00b003f092f0e0a0sm256155wmq.3.2023.04.18.08.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:33:40 -0700 (PDT)
Message-ID: <b665385d-a39e-6e3b-351a-25d321d96031@tessares.net>
Date: Tue, 18 Apr 2023 17:33:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v7 6/7] mptcp: update userspace pm subflows
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681463340.git.geliang.tang@suse.com>
 <ba3fcb8e233b571eed4b83e0b38a43ddf1641ce7.1681463340.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ba3fcb8e233b571eed4b83e0b38a43ddf1641ce7.1681463340.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,


On 14/04/2023 11:11, Geliang Tang wrote:
> Increase pm subflows counter on both server side and client side when
> userspace pm creates a new subflow, and decrease the counter when it
> closes a subflow.

Do you mind adding:

  Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow
establishment")
  Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329

Same here, it looks like a bug: we forgot to update existing counters in
this new mode.

Also, may you also add that this modification is similar to how the
in-kernel PM is updating the counter: when additional subflows are
created/removed?

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm.c           | 21 +++++++++++++++++----
>  net/mptcp/pm_userspace.c |  1 +
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 4ed4d29d9c11..bb01f15d8e0a 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -87,8 +87,15 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
>  	unsigned int subflows_max;
>  	int ret = 0;
>  
> -	if (mptcp_pm_is_userspace(msk))
> -		return mptcp_userspace_pm_active(msk);
> +	if (mptcp_pm_is_userspace(msk)) {
> +		if (mptcp_userspace_pm_active(msk)) {
> +			spin_lock_bh(&pm->lock);
> +			pm->subflows++;
> +			spin_unlock_bh(&pm->lock);
> +			return true;
> +		}
> +		return false;
> +	}
>  
>  	subflows_max = mptcp_pm_get_subflows_max(msk);
>  
> @@ -181,8 +188,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
>  	struct mptcp_pm_data *pm = &msk->pm;
>  	bool update_subflows;
>  
> -	update_subflows = (subflow->request_join || subflow->mp_join) &&
> -			  mptcp_pm_is_kernel(msk);
> +	if (mptcp_pm_is_userspace(msk)) {
> +		spin_lock_bh(&pm->lock);
> +		pm->subflows--;
> +		spin_unlock_bh(&pm->lock);
> +		return;
> +	}
> +
> +	update_subflows = (subflow->request_join || subflow->mp_join);

Should you not also decrement the counter only if one of these
conditions is met to keep the same behaviour as what is done with the
in-kernel PM: 'subflows' counter only look at the additional subflows?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
