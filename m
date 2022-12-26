Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3022108
	for <mptcp@lists.linux.dev>; Mon, 26 Dec 2022 16:27:36 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id ud5so26840386ejc.4
        for <mptcp@lists.linux.dev>; Mon, 26 Dec 2022 08:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AyE6HChMWj+dWcZV6vkWbI34PTR0t2GAdE6BKL+epBg=;
        b=WLSJzlGUU2tjKm1iHHMvHEAxBpO2sVWFeDtTlZwnpKJXOtRgNzSsuGoDl6UZERVtAk
         FOqFMpXMq0zSjho76tj9lcCOV5tXnqg8ZE2t6C9FVTMM+mWaYpf0mB1TZDf9PTUTPhaU
         tK2BNdS4HgNGr20Oou5uLDxiiKTQGaN3pbGPkykhSSX+wBnOwTO9f7LHx53TDCvTRH/3
         uosryC+5qbqj6aP30YD/Mg211hH4dSrk0i7UipcaFQmENRBVAtsE0ueXKfkFYzo8CHqE
         cJ3nSU2cS/auD+6vmWro/jHiu5EegiqevDcuygw629iupKmNQ5NYiAXtBZSlmsWw8JEM
         hdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyE6HChMWj+dWcZV6vkWbI34PTR0t2GAdE6BKL+epBg=;
        b=2F7S8Zxp0LPp4eqH1R+ikKICYUckhOvROBEY/tJ421el0bUigwsJkKjnTjNAmChQnE
         OCIHfCTlMVm3vBd5O0spFh+AaHIH5Yel1o4SAFBR30iZTUsQeCS4MHPBXbNOvz7itNfL
         9Y0bZm07938m277h3R9mbqB+0suPlDLzyriyp//K9JxPCSJf2xZ07vKdvQyFN6i7Kf1c
         GMK+O3GCt8T3DgM5nV6fmD0iqAW/GN2rNRcg02mabIrlWsbkXTsO6Txjk+OiG1jTcidr
         qLCEVaIU64FLSfwmrhnAwkVIgyZIEpdd25dCHufV7KkxKh7Ao7qWGaD+1EuebgxknbEv
         T+7w==
X-Gm-Message-State: AFqh2kp+LC3WeFmJjgcOuuPSwvmOVrF8rsSB9zWWh1xh38J+2pVVQ+MU
	hw3131loXS677V11pX1ghtUkDA==
X-Google-Smtp-Source: AMrXdXvYNvYSOUw+s7fkVtFc8D0eoieAq0j1EaxdivMRoOirrGiPsdpGWAdXVYpaTP5aVUVrk6FVvQ==
X-Received: by 2002:a17:906:184a:b0:78d:f456:1ed0 with SMTP id w10-20020a170906184a00b0078df4561ed0mr20441695eje.33.1672072055139;
        Mon, 26 Dec 2022 08:27:35 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id bx4-20020a170906a1c400b007c0e6d6bd10sm4959969ejb.132.2022.12.26.08.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 08:27:34 -0800 (PST)
Message-ID: <cb231563-f904-de27-34fd-7d217b3a00a3@tessares.net>
Date: Mon, 26 Dec 2022 17:27:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 mptcp-next 2/3] mptcp: let the in kernel PM use mixed
 ipv4 and ipv6 addresses
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1671821017.git.pabeni@redhat.com>
 <61ebbe1bdb47f74d856b3edee06112999da50f07.1671821017.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <61ebbe1bdb47f74d856b3edee06112999da50f07.1671821017.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/12/2022 20:00, Paolo Abeni wrote:
> Currently the in kernel PM arbitrary enforces that created subflow's
> family must match the main MPTCP socket. The RFC allow instead for
> mixing IPv4 and IPv6 subflows.
> 
> This patch changes the in kernel PM logic to create subflows matching
> the currently selected source (or destination) address. IPv4 sockets
> can pick only IPv4 addresses, while IPv6 sockets not restricted to
> V6ONLY can pick either IPv4 and IPv6 addresses, effectively
> allowing the creation of IPv4 and IPv6 subflows under the same msk.
> 
> While at that, factor out a new helper for address family matching,
> taking care of ipv4 vs ipv4-mapped-ipv6.

Thank you for the v2!

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/269
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/pm_netlink.c | 68 ++++++++++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 26 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index f2a43e13bacd..23c4e74312f7 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c

(...)

> @@ -420,10 +409,34 @@ static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned
>  	return false;
>  }
>  
> +/* if sk is ipv4 or ipv6_only allows only same-family local and remote addresses,
> + * otherwise allow any matching local/remote pair
> + */
> +static bool addr_families_match(const struct sock *sk,
> +				const struct mptcp_addr_info *loc,
> +				const struct mptcp_addr_info *remote)
> +{
> +	if (sk->sk_family == loc->family && sk->sk_family == remote->family)

Do we need to handle this case: MPTCP socket is in v6, local and remote
are also in v6 but one or the two of them are in fact v4 mapped in v6.
If the two are v4 mapped, we need to checked for sk_ipv6only as well
which increase the number of checks to do :-/

> +		return true;
> +
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (sk->sk_family == AF_INET || sk->sk_ipv6only)
> +		return false;

This breaks one test in mptcp_join.sh selftests (55: single subflow
v6-map-v4). This test creates an AF_INET MPTCP socket and adds a subflow
endpoint using a v6 mapped form address: "::ffff:10.0.3.2".

If we want to imitate TCP, we should treat v4 mapped addresses in v6 as
v4 and then allow AF_INET6 if it is in fact a v4.

I suggest to do this modification:

----------------- 8< -----------------
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 23c4e74312f7..22dfbaf988a5 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -414,21 +414,32 @@ static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned
>   */
>  static bool addr_families_match(const struct sock *sk,
>                                 const struct mptcp_addr_info *loc,
> -                               const struct mptcp_addr_info *remote)
> +                               const struct mptcp_addr_info *rem)
>  {
> -       if (sk->sk_family == loc->family && sk->sk_family == remote->family)
> -               return true;
> +       bool mptcp_is_v4 = sk->sk_family == AF_INET;
>  
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -       if (sk->sk_family == AF_INET || sk->sk_ipv6only)
> +       bool loc_is_v4 = loc->family == AF_INET || ipv6_addr_v4mapped(&loc->addr6);
> +       bool rem_is_v4 = rem->family == AF_INET || ipv6_addr_v4mapped(&rem->addr6);
> +
> +       /* v4 only */
> +       if (mptcp_is_v4) {
> +               if (loc_is_v4 && rem_is_v4)
> +                       return true;
>                 return false;
> +       }
>  
> -       if (loc->family == remote->family ||
> -           (loc->family == AF_INET && ipv6_addr_v4mapped(&remote->addr6)) ||
> -           (remote->family == AF_INET && ipv6_addr_v4mapped(&loc->addr6)))
> -               return true;
> +       /* v6 only */
> +       if (sk->sk_ipv6only) {
> +               if (!loc_is_v4 && !rem_is_v4)
> +                       return true;
> +               return false;
> +       }
> +
> +       return loc_is_v4 == rem_is_v4;
> +#else
> +       return mptcp_is_v4 && loc->family == AF_INET && rem->family && AF_INET;
>  #endif
> -       return false;
>  }
>  
>  /* Fill all the remote addresses into the array addrs[],
----------------- 8< -----------------

Note that if the kernel is compiled without CONFIG_MPTCP_IPV6, we don't
really need to check if the MPTCP socket is in v4 but I keep it here to
continue to use 'sk' and avoid a warning from the compiler.

> +
> +	if (loc->family == remote->family ||
> +	    (loc->family == AF_INET && ipv6_addr_v4mapped(&remote->addr6)) ||
> +	    (remote->family == AF_INET && ipv6_addr_v4mapped(&loc->addr6)))
> +		return true;
> +#endif
> +	return false;
> +}
> +
>  /* Fill all the remote addresses into the array addrs[],
>   * and return the array size.
>   */
> -static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullmesh,
> +static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
> +					      struct mptcp_addr_info *local,
> +					      bool fullmesh,
>  					      struct mptcp_addr_info *addrs)
>  {
>  	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
> @@ -443,6 +456,9 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
>  		if (deny_id0)
>  			return 0;
>  
> +		if (!addr_families_match(sk, local, &remote))
> +			return 0;
> +
>  		msk->pm.subflows++;
>  		addrs[i++] = remote;
>  	} else {
> @@ -453,6 +469,9 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
>  			if (deny_id0 && !addrs[i].id)
>  				continue;
>  
> +			if (!addr_families_match(sk, local, &addrs[i]))
> +				continue;
> +
>  			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
>  			    msk->pm.subflows < subflows_max) {
>  				msk->pm.subflows++;
> @@ -600,10 +619,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>  		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
>  
>  		msk->pm.local_addr_used++;
> -		nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
> -		if (nr)
> -			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> +		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
> +		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
>  		spin_unlock_bh(&msk->pm.lock);
> +
>  		for (i = 0; i < nr; i++)
>  			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
>  		spin_lock_bh(&msk->pm.lock);
> @@ -625,6 +644,7 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
>   * and return the array size.
>   */
>  static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
> +					     struct mptcp_addr_info *remote,
>  					     struct mptcp_addr_info *addrs)
>  {
>  	struct sock *sk = (struct sock *)msk;
> @@ -642,15 +662,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>  		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
>  			continue;
>  
> -		if (entry->addr.family != sk->sk_family) {
> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -			if ((entry->addr.family == AF_INET &&
> -			     !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) ||
> -			    (sk->sk_family == AF_INET &&
> -			     !ipv6_addr_v4mapped(&entry->addr.addr6)))
> -#endif
> -				continue;
> -		}
> +		if (!addr_families_match(sk, &entry->addr, remote))
> +			continue;
>  
>  		if (msk->pm.subflows < subflows_max) {
>  			msk->pm.subflows++;
> @@ -664,7 +677,10 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>  	 */
>  	if (!i) {
>  		memset(&local, 0, sizeof(local));
> -		local.family = msk->pm.remote.family;
> +		local.family = remote->family;

Here, you need to take into account v4mapped addresses not to break
mptcp_join selftest (56 signal address v6-map-v4):

----------------- 8< -----------------
> @@ -649,7 +655,6 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>  {
>         struct sock *sk = (struct sock *)msk;
>         struct mptcp_pm_addr_entry *entry;
> -       struct mptcp_addr_info local;
>         struct pm_nl_pernet *pernet;
>         unsigned int subflows_max;
>         int i = 0;
> @@ -676,8 +681,12 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
>          * 'IPADDRANY' local address
>          */
>         if (!i) {
> +               struct mptcp_addr_info local;
> +
>                 memset(&local, 0, sizeof(local));
> -               local.family = remote->family;
> +               local.family = remote->family == AF_INET6 &&
> +                              ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
> +                              remote->family;
>  
>                 if (!addr_families_match(sk, &local, remote))
>                         return 0;
----------------- 8< -----------------

> +
> +		if (!addr_families_match(sk, &local, remote))
> +			return 0;

Now that this function can return 0 ... (see below)

>  
>  		msk->pm.subflows++;
>  		addrs[i++] = local;
> @@ -703,7 +719,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  	/* connect to the specified remote address, using whatever
>  	 * local address the routing configuration will pick.
>  	 */
> -	nr = fill_local_addresses_vec(msk, addrs);
> +	nr = fill_local_addresses_vec(msk, &remote, addrs);

... does it still make sense to increment add_addr_accepted counter here
below if nr == 0? We got an ADD_ADDR but we cannot do anything with it
so we didn't really "accepted" it. WDYT?

>  
>  	msk->pm.add_addr_accepted++;
>  	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
