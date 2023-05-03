Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611AA52
	for <mptcp@lists.linux.dev>; Wed,  3 May 2023 17:34:06 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f4000ec74aso6074555e9.3
        for <mptcp@lists.linux.dev>; Wed, 03 May 2023 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683135244; x=1685727244;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQNHDMGM6h5DfpQ56ykZSarHmNWK0mrTbvJ+4DkyJu4=;
        b=0/bTxsr4e5oQmrISf2MW2EpgTOFGkExIri01yYiPbljo+XY89IuK3TGvrWWNxNGZgg
         Rojrp+OBs20vvptn+sc5zYsB4ELQUROthJc2SEFQLOUj7GqqdXUp24CgsMSKlzKDxOeC
         t3kSFl7+K0GyTn28NedokiWuduSfAmTzEnA0WiSBGIBITo5pPK4sdWlNmBVqhIHBatpE
         DF5P13YemqruJVzuv4ykaVEVrqZr6uAvUZX1xn4OMy5jS+N0EUdkO8MRIeBwRd3Oyk25
         uVe0HiK0H0Cx/cdyO3l/tdmD7dMI5kV6+ycMcEbtHf4hwFeGS09UCtPuKttDXV6pZCwE
         6FSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135244; x=1685727244;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQNHDMGM6h5DfpQ56ykZSarHmNWK0mrTbvJ+4DkyJu4=;
        b=LbupLNnabVlJamNNSDaGu7E7SjQq2O9xxLO7EmPeAAS8gWgKFQyAaQfud9Raw5H26y
         BY4ZVNR/dUykfEZQVWWPSpuZ/Eztpdy+RloQCAE0CRLqz+jxp90ZqjIGiUyjoL2fCRpa
         G3qIEW0ZO3iIgieIzkjsIdgcTwEUAWQ3DnuRPKFR8qKI7JLVKO7++452HLL0tiyHwwgy
         h+mFCnoWRZ9eq6ymuaR/1dbbnfWaWgQ43WMOy9rftD1i4qR/p8Z4pqgri7vYLatZn/45
         kDfEVnty+rtwYwkYNYcFO80KURMEbRzsfTuTqzM6ZtfQKlaMRofLepGIaMGTt8LM/kMi
         X4eg==
X-Gm-Message-State: AC+VfDwzgMGDSZ9BmrE+eRmvnu7vWlmXqxbh/1pREWnkMSrOv4+9FA1A
	f//nypZGmyQ3PxnWauWLwL7Z8A==
X-Google-Smtp-Source: ACHHUZ7jM4UQcLkechrsETUu2Hun2AyYadSV/LuwKoij/cRQuBxwBQPp6iN0YYuBJdwLKwj5yvwpjA==
X-Received: by 2002:a7b:c44e:0:b0:3f1:a71b:d46b with SMTP id l14-20020a7bc44e000000b003f1a71bd46bmr14996254wmi.41.1683135244627;
        Wed, 03 May 2023 10:34:04 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ffdc:60e3:7c6d:ec67? ([2a02:578:8593:1200:ffdc:60e3:7c6d:ec67])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b003f173be2ccfsm56692033wmn.2.2023.05.03.10.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 10:34:04 -0700 (PDT)
Message-ID: <26b39abd-5419-cb2a-1a5f-b54dffc0d116@tessares.net>
Date: Wed, 3 May 2023 19:34:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v10 3/6] mptcp: add addr into userspace pm list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1682499136.git.geliang.tang@suse.com>
 <0d5410b79cf461ad9f8bb8a15d960ca9517d0bc7.1682499136.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0d5410b79cf461ad9f8bb8a15d960ca9517d0bc7.1682499136.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 26/04/2023 10:56, Geliang Tang wrote:
> Add the address into userspace_pm_local_addr_list when the subflow is
> created. Make sure it can be found in mptcp_nl_cmd_remove(). And delete
> it in the new helper mptcp_userspace_pm_delete_local_addr().
> 
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 6beadea8c67d..fc96405b7616 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -79,6 +79,22 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  	return ret;
>  }
>  

Regarding my question from the v9 about removing the local addr if the
subflow is closed from the other peer (not via a subflow destroy command
then), do we want to keep the entry not to assign the same ID to another
address and/or to be able to send RM_ADDR after the removal of the
subflow? If yes, it would be good to add a comment here in the code
about that I think, no?

> +static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
> +						struct mptcp_pm_addr_entry *addr)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
> +		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {

I think we should add a TODO comment here to say that a refcount is
needed because the entry can be used multiple times (e.g. fullmesh mode)
and/or create a new ticket. Except if you are already working on that?

> +			list_del_rcu(&entry->list);
> +			kfree(entry);
> +			return 0;
> +		}
> +	}

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
