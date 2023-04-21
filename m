Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0A23C05
	for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 14:17:14 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-506767f97f8so2889996a12.1
        for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682086633; x=1684678633;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0B1gGM2ucoJcXdDaDXsldPZVnXx7f2FP/CTwzr7CUJk=;
        b=UYCCf0fuA7HgpgRUS3ofIbFkIy3HHOMf8Jvi1sBZ9VrTaB6nZIy9YA/btMyUPfSdD2
         dVozFAYXGpakRQYPyUXNbS7BYMWgKDayRVQqvkhzKlE0oj6aeTHhXWAfZFyvzar7SCmX
         NVj3FHKl50z1borSxcKaVTIlBXgxTkufp5FwU5EVBIWA5sxNrwp2uCmAJB20Nn8DJmFq
         HaAk0zTfGgjVxbLSSteTFT+PLXQo+tc/Fg79J87fLTTAn4186mII7Qofvu/rsVeQ20ba
         u8q/RKQsoIxt/HElLk1jgEA4JwZZ2gsF/JJu81xwgig8QfbSaG8MUmCgzVwWe04uPFn3
         Arjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086633; x=1684678633;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0B1gGM2ucoJcXdDaDXsldPZVnXx7f2FP/CTwzr7CUJk=;
        b=IAEW4y5g+rijk+HiB8nbd0s8lC8fgim7h8D0cSps9w2U7SaHscvtur4KFSqj1OpZX9
         fkfCn3N6BPDJKzL72DKxgTKWBjKAYMG/T24lXnyPQBHA3qyARuvU2wQULJDMrp/1op9I
         bpW/CEt/lBph60Tedxr4IPalV20p2qHw2yiwZCJA5DsgyZTVeQqrVDcGkcAvCsNVsGlX
         kvIsbDenIGHLYCqKdGoc8yxEeWvhGmMPFBjEY1BpBghgAAf5kt4dqI4KdlNzcvmoCWf/
         XsBRuIdJKZuJm/97cP+uLuf938tE8XUZE4pN/OvljI75mduKGEV32fpe7bpuXA/KJ5Qm
         JdJw==
X-Gm-Message-State: AAQBX9feTqArJoyRuSl1Tn0HnA3ixsaBWUWNNwSomY7bfctasdzZDLqm
	o3NCKkJzjz6P1+N4ZPdckbcszqOp51wZqoBksHDbuQ==
X-Google-Smtp-Source: AKy350bQZjO/rIYvZzlT9aNwZe6A+pkVDfVTICbN6clWKy5LVJ7rNKJcgW622A/gFNyDduqmYESFMg==
X-Received: by 2002:a17:907:6025:b0:94d:57d2:7632 with SMTP id fs37-20020a170907602500b0094d57d27632mr2494616ejc.31.1682086632807;
        Fri, 21 Apr 2023 07:17:12 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id b21-20020a170906151500b0094edd8e38fasm2094685ejd.76.2023.04.21.07.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 07:17:12 -0700 (PDT)
Message-ID: <e5ba4db7-9fd0-40eb-f549-795ee29d8d4a@tessares.net>
Date: Fri, 21 Apr 2023 16:17:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v8 3/5] mptcp: add addr into userspace pm list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681960259.git.geliang.tang@suse.com>
 <9c4298af79bfbf37412a96f945ff75466c45d010.1681960259.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9c4298af79bfbf37412a96f945ff75466c45d010.1681960259.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/04/2023 05:11, Geliang Tang wrote:
> Add the address into userspace_pm_local_addr_list when the subflow is
> created. And delete it in mptcp_nl_cmd_sf_destroy().

I'm sorry to insist but can you explain the reason(s) why you need to
add addresses into the list? Is it to be able to send a RM_ADDR for a
previously used subflow?

  By doing that, the "REMOVE" command also works with subflows that have
  been created via the "SUB_CREATE" command instead of restricting to
  the addresses that have been announced via the "ANNOUNCE" command.

  (...)

  Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
  Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379

> A non-zero address id is needed in this case. So don't clear the addr
> id in mptcp_userspace_pm_get_local_id(), clear it in
> mptcp_pm_nl_get_local_id() instead.

> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_netlink.c   |  2 +-
>  net/mptcp/pm_userspace.c | 19 ++++++++++++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d85649bc27e2..bb237abb99bb 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1055,8 +1055,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>  
>  int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  {
> +	struct mptcp_addr_info skc_local = { 0 };
>  	struct mptcp_pm_addr_entry *entry;
> -	struct mptcp_addr_info skc_local;
>  	struct mptcp_addr_info msk_local;
>  	struct pm_nl_pernet *pernet;
>  	int ret = -1;
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 6beadea8c67d..a1f8d2fab08d 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -113,7 +113,6 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
>  
>  	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
>  	new_entry.addr = *skc;
> -	new_entry.addr.id = 0;
>  	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
>  
>  	if (new_entry.addr.port == msk_sport)
> @@ -302,6 +301,12 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> +	err = mptcp_userspace_pm_get_local_id(msk, &addr_l);

The name is not very clear: It adds the address into
userspace_pm_local_addr_list, right?
If yes, please add a comment above (or rename the function).

Why can you not call mptcp_userspace_pm_append_new_local_addr() directly?

> +	if (err < 0) {
> +		GENL_SET_ERR_MSG(info, "did not match address and id");
> +		goto create_err;
> +	}
> +
>  	lock_sock(sk);
>  
>  	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);

In case of error, I guess you should remove the entry from the list, no?

And when the subflow is deleted from the other side, no?

> @@ -420,6 +425,18 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>  	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
>  	if (ssk) {
>  		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +		struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +		spin_lock_bh(&msk->pm.lock);
> +		list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
> +			if (mptcp_addresses_equal(&entry->addr, &addr_l, false) &&
> +			    msk->pm.subflows == 1) {

Why did you add "msk->pm.subflows == 1"? It looks like a workaround but
not a proper solution :)

Should you not instead add a refcount in "struct mptcp_pm_addr_entry"?

> +				list_del_rcu(&entry->list);
> +				kfree(entry);
> +				break;
> +			}
> +		}
> +		spin_unlock_bh(&msk->pm.lock);
>  
>  		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
>  		mptcp_close_ssk(sk, ssk, subflow);

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
