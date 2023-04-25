Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D59B6ADC
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 15:24:24 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-2fe3fb8e25fso3616278f8f.0
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682436262; x=1685028262;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6K1/bgnd5q1aRCZAP5jK+LDpLVuR1YU0ftnRctZBfGg=;
        b=yK3RF16Xh1J4fzi3DtC+dtjJ4WydPZdolhsrwthyJAV1eDzaOm8Kqg3n6oUo6Qp/zN
         yFOtLHS0vi6Q8LBVMT0PTwn3aVCKe2iA1LO3vk1nIro7v1VAO5qKuFTKN3C3fYSuGozA
         iHZYGWF0yMNhwaHUfnZvPEC93Op/XWxmdxlVASuo03P5Uiu+MHwPyOdyZkgUk7ctxxLu
         pvZSmIPfsnh1e3jjQ8wlJf+uiPVkOe43YInB37Ah0RBo+9tj3kKrjvSbwoCwCwqGSJwC
         R+4MvYAy9kRByl06wYvjZHV3zLSeagoISVb01ye1MbJ5SKxvkv7Aws819ggV0PqXdM3n
         6xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682436262; x=1685028262;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6K1/bgnd5q1aRCZAP5jK+LDpLVuR1YU0ftnRctZBfGg=;
        b=VFxCcCnXbWQHuHVKoimC5fOtwnM0MJm7zGcbFb6UtlXpArwgJAbCKNKWVPBXAgrcdi
         WIph4nEOhoPetWqI2U4EB2D105iXBz19mzUdftWfF8545RDW53HImfC8ROrt/dgHUxYC
         jOUg4qT1l+Pw95tWBFQdF+00zsF3+D+/2RMqQlezuiuxw+/Bt85xQJ+6GQHROAv/4LZx
         EStu8LqU8uBmzqKUzxcvTyzulNAnSfZPz2ZdFQeVWDjXD+acjXZE/aeyDIeiAedUJuZX
         aKboxoVbQUsYMkZ9TsY8EWyoOS96DI3zqNoF/O+ZgedZLuGitmeM8rSgPE1X5FTB6nZu
         4XJQ==
X-Gm-Message-State: AAQBX9fc3gfXO+6nEcrOwe6WU6ZQjt9/3jxYyRqcde4RqVINgXZIjJph
	9fzJEHEyEeSn+AuetPeT5+yrAO4sI8rVF7YESEDO3Q==
X-Google-Smtp-Source: AKy350ar8UqArmd+kINrzChe2J9I9iU99jY4HQGR4FBCemuu05mxe5k1+DfKVmPQXqxlxihwSjn91A==
X-Received: by 2002:a5d:525a:0:b0:303:97db:ae93 with SMTP id k26-20020a5d525a000000b0030397dbae93mr10728353wrc.44.1682436262284;
        Tue, 25 Apr 2023 08:24:22 -0700 (PDT)
Received: from [10.124.6.89] ([195.181.172.155])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b002ff1751ec79sm13313989wrm.65.2023.04.25.08.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 08:24:22 -0700 (PDT)
Message-ID: <8f99a485-fa28-d9a8-62de-24d24f381368@tessares.net>
Date: Tue, 25 Apr 2023 17:24:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v9 3/6] mptcp: add addr into userspace pm list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1682409247.git.geliang.tang@suse.com>
 <2cb2b598ce097ee2e339f819bcb7a7ba2e097c5f.1682409247.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2cb2b598ce097ee2e339f819bcb7a7ba2e097c5f.1682409247.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2023 09:55, Geliang Tang wrote:
> Add the address into userspace_pm_local_addr_list when the subflow is
> created. And delete it in the new helper
> mptcp_userspace_pm_delete_local_addr().
> 
> By doing that, the "REMOVE" command also works with subflows that have
> been created via the "SUB_CREATE" command instead of restricting to
> the addresses that have been announced via the "ANNOUNCE" command.
> 
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 6beadea8c67d..b494c72efe2b 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -79,6 +79,23 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  	return ret;
>  }
>  
> +static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
> +						struct mptcp_pm_addr_entry *addr)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
> +		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false) &&
> +		    msk->pm.subflows == 1) {

I'm not a big fan of this workaround, especially for a fix that is
supposed to be backported.

Do you need to do a lot of modifications to add a "refcount_t" in
"struct mptcp_pm_addr_entry" and use it?

If really it is complex, I think we will at least need a comment with a
TODO explaining why we need a refcount. (and a new ticket)
(and probably better without "msk->pm.subflows == 1" then)

> +			list_del_rcu(&entry->list);
> +			kfree(entry);
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
>  						   unsigned int id,
>  						   u8 *flags, int *ifindex)
> @@ -251,6 +268,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct mptcp_pm_addr_entry local = { 0 };
>  	struct mptcp_addr_info addr_r;
>  	struct mptcp_addr_info addr_l;
>  	struct mptcp_sock *msk;
> @@ -302,12 +320,25 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> +	local.addr = addr_l;
> +	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
> +	if (err < 0) {
> +		GENL_SET_ERR_MSG(info, "did not match address and id");
> +		goto create_err;
> +	}
> +
>  	lock_sock(sk);
>  
>  	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
>  
>  	release_sock(sk);
>  
> +	if (err) {
> +		spin_lock_bh(&msk->pm.lock);
> +		mptcp_userspace_pm_delete_local_addr(msk, &local);
> +		spin_unlock_bh(&msk->pm.lock);
> +	}
> +

When the subflow is deleted by the other peer, we also need to delete
the local address, no?

Or maybe we want to keep it not to assign the same ID to another
address? And/or to be able to send RM_ADDR after the removal of the
subflow? If yes, it would be clearer to add a comment about that.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
