Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507A28E2
	for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 11:32:40 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94a342f7c4cso251858066b.0
        for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 04:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682076759; x=1684668759;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nb5cC1ddOEsDy5SZ+PuPCiwJgMC5vlJH31WafIWJ60M=;
        b=U6u43mLgir0GG+OmLvpJLeA2kbpffbMLoMoHVtrAExGhMruoLfMXAMvC+OVm+smRl/
         bwZf8bgSyPBpre2nALWQazA50F3CkVMG13QU77PIZou7q88TiEDDVTnD5x5vL4gvxMFc
         42ArrtjdmQgw58WcQN3oqZMKLaJ5qQTqNDDRit1GzHO9vbEcLry8cZj1VXIKDr80Aq4e
         R8I2+Fnknz0B+60nYfw+T1pz05AZpsSDT8Fx+6L+4KWEdhR4Z3GPsec8wnlFR8VEt1Pa
         kHxXk3zP09/E7ESaJUCF8CpHfUYTQxz9vjduQyGVgIUoFXA9D3tbeRVncr8Vcuy7o85A
         yJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682076759; x=1684668759;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nb5cC1ddOEsDy5SZ+PuPCiwJgMC5vlJH31WafIWJ60M=;
        b=VIkEYcqAZQPo1WCQIQii3pG2GaZ8oAKam7sFGyirtglVX210m1eZMe9zaom9ojSR48
         tHLPNXO4euUOIEO/dT9MQDmRr9nhAWUvnHgADjmYNUtmvh8Uz3+edhGqjKY6G4YfP3Ub
         ThmI7lQa888vINccEMdgRYRc1k8PDnQXSGcsY3xHGHCQnQd8SlmgoROgAJnTtPFsw7b3
         6uZgY78u97gtAyNAGlXCOz/Vt+gAkuDZu/z4/sPrGLGEOICOjKgtQFCYsrVEihsf5bQt
         ywvtI//zOX0FelEsDQRF9ZD0HUMVItWkogoXVAakh9l1SHemCyOn0pxgO7YHEtVvlcw4
         vA9g==
X-Gm-Message-State: AAQBX9c5wnTD1dfqESpp8ZL6HleUUBaOijVWplpQNPEzg6vVrZgJnvD4
	0vxzP3ExpseeMBcq7HObTckvGx1O2GqiJbLysAReVdpP
X-Google-Smtp-Source: AKy350Zt/nx9tGyylbettunZWAKVABnHKvkiC/XCLH+K0KHYdFcKcTN+dFWcAm9UuUtuF/ews09iXw==
X-Received: by 2002:a17:906:dce:b0:94f:4a87:7a77 with SMTP id p14-20020a1709060dce00b0094f4a877a77mr2245047eji.36.1682076759022;
        Fri, 21 Apr 2023 04:32:39 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060e1200b0094f3338129asm1989669eji.141.2023.04.21.04.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 04:32:38 -0700 (PDT)
Message-ID: <e95a53f7-fcb5-2297-c992-7587a35604d7@tessares.net>
Date: Fri, 21 Apr 2023 13:32:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 mptcp-next 1/3] mptcp: introduces more address related
 mibs
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1681481877.git.pabeni@redhat.com>
 <57449d46a6d254446a227aa22597dd0837dfe331.1681481877.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <57449d46a6d254446a227aa22597dd0837dfe331.1681481877.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 14/04/2023 16:19, Paolo Abeni wrote:
> Currently we don't track explicitly a few events related to address
> management suboption handling; this patch adds new mibs for ADD_ADDR
> and RM_ADDR options tx and for missed tx events due to internal storage
> exahustion.

(s/exahustion/exhaustion/)

> The self-tests must be updated to properly handle different mibs with
> the same/shared prefix.
> 
> Additionally removes a couple of warning tracking the loss event.

Thank you for having added these MIBs counters!

I have one question below, just in case you need to send a v3.

(...)

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 19a01b6566f1..8a8083207be4 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -687,9 +687,12 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
>  	}
>  	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
>  	if (!echo) {
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDRTX);
>  		opts->ahmac = add_addr_generate_hmac(msk->local_key,
>  						     msk->remote_key,
>  						     &opts->addr);
> +	} else {
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADDTX);
>  	}
>  	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
>  		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
> @@ -723,7 +726,7 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
>  
>  	for (i = 0; i < opts->rm_list.nr; i++)
>  		pr_debug("rm_list_ids[%d]=%d", i, opts->rm_list.ids[i]);
> -

(out of curiosity, why removing this line :) )

> +	MPTCP_ADD_STATS(sock_net(sk), MPTCP_MIB_RMADDRTX, opts->rm_list.nr);
>  	return true;
>  }
>  
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 4ed4d29d9c11..7539137719ef 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -26,7 +26,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>  
>  	if (add_addr &
>  	    (echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGNAL))) {
> -		pr_warn("addr_signal error, add_addr=%d, echo=%d", add_addr, echo);
> +		MPTCP_INC_STATS(sock_net((struct sock *)msk),
> +				echo ? MPTCP_MIB_ECHOADDTXDROP : MPTCP_MIB_ADDADDRTXDROP);
>  		return -EINVAL;
>  	}
>  
> @@ -48,7 +49,8 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
>  	pr_debug("msk=%p, rm_list_nr=%d", msk, rm_list->nr);
>  
>  	if (rm_addr) {
> -		pr_warn("addr_signal error, rm_addr=%d", rm_addr);
> +		MPTCP_ADD_STATS(sock_net((struct sock *)msk),
> +				MPTCP_MIB_RMADDRTXDROP, rm_list->nr);
>  		return -EINVAL;
>  	}
>  
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index fafd19ec7e1f..095ddd747ffc 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1486,7 +1486,7 @@ chk_add_nr()
>  	fi
>  
>  	echo -n " - echo  "
> -	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}')
> +	count=$(ip netns exec $ns1 nstat -as MPTcpExtEchoAdd | grep MPTcpExtEchoAdd | awk '{print $2}')

(we could also use "grep -w" but we did that kind of thing with nstat a
few times in the past, no need to change)

>  	[ -z "$count" ] && count=0
>  	if [ "$count" != "$echo_nr" ]; then
>  		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
> @@ -1608,7 +1608,7 @@ chk_rm_nr()
>  	fi
>  
>  	printf "%-${nr_blank}s %s" " " "rm "
> -	count=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}')
> +	count=$(ip netns exec $addr_ns nstat -as MPTcpExtRmAddr | grep MPTcpExtRmAddr | awk '{print $2}')
>  	[ -z "$count" ] && count=0
>  	if [ "$count" != "$rm_addr_nr" ]; then
>  		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
