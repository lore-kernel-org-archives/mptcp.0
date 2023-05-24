Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE396086A
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 13:24:12 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so815106f8f.2
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 06:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684934650; x=1687526650;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rxUzLfwRmn2QPzzYe8sxEWjPfJblYoyIjOpXSO8+gQs=;
        b=MA1smLbpYAAuBRV7o1aOPPgtE65M5R0W0ku92iKVqKUc1nb1ce/NSTztSiH8C4J4fU
         gZtpXRE9ipD8Xd1bUI346w2yR/eGRkgYv4pNaCIhW8acFvv4tTEBcsL8JG6w4fp/7Yzf
         +7bY3m1BRc1jbeQxF2ff4WWSqGC8yUyATL1uqmfTJg4FBW0DFg/Kch2/8UOBZsDLFxxx
         nvkqlaN6lW1iwgEFfviKwwJ0di3FuqUkWdypJyoSW7w0ectzyYcZwNqB3i/EBsLxPXeh
         Sy863SNBBXdch+V7971GlEUDjn3P2gSJ9IS7WfJnq/xL0KDw7hY1xphRynz87QiCkVV8
         +xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684934650; x=1687526650;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxUzLfwRmn2QPzzYe8sxEWjPfJblYoyIjOpXSO8+gQs=;
        b=SvBvj+df6CQ39+goZ/lLCRhqeNo2EBj98r5IhFx7XXBFPSL4PYD6oov8b+5cZ6FDce
         rGYhxAW4VsI94ZtQeiG829M+WX+OYzOOpPVbmw2f0PdcBQOhV31FmxL69uHvLoiYziDj
         BH3fqTmQw9LrD/SzIPYWRs802AHwfklC4i2RO1Qbv+++iy9I1Ob2zTYqboVtVEIS5y1L
         P43Jl8dx5iieNZIGqvjyUnH0XWveH9Y9Jxpe9icftONMJHZKIHv238TxzfMGi3J9ziI3
         SgtEonTtO/PtmOasXFn49lNpP2/CQ7SzgjLNbeizv039uw50LX31z8R1E9Pk6cp70JRl
         y38A==
X-Gm-Message-State: AC+VfDyAKJFGtXJ0pjLhHLlPTrhzskc3HFHv5a5WCyeTeg3FifhQn1rG
	OFzuaN/KEwQAHzErBosoAgC3TLeDi7/f14TQKhPpAQ==
X-Google-Smtp-Source: ACHHUZ5GlKRrnJdDbzNlqurXZCJXDmo3kUzBBJ8FGaVPilzAG6gAo+QnJ225yR05CdSLDoe7yQ0j9w==
X-Received: by 2002:a5d:5744:0:b0:306:2eab:fb8c with SMTP id q4-20020a5d5744000000b003062eabfb8cmr13007444wrw.42.1684934650294;
        Wed, 24 May 2023 06:24:10 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:735b:1ad0:911b:4361? ([2a02:578:8593:1200:735b:1ad0:911b:4361])
        by smtp.gmail.com with ESMTPSA id j17-20020a5d6191000000b0030639a86f9dsm14405960wru.51.2023.05.24.06.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 06:24:09 -0700 (PDT)
Message-ID: <f5b66a5d-4dcc-04a1-76cc-58c872c7ff37@tessares.net>
Date: Wed, 24 May 2023 15:24:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v15 5/5] mptcp: update userspace pm infos
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684915182.git.geliang.tang@suse.com>
 <f6f3a1de7d640cbb4ea45fe820c042c6b134e3f2.1684915182.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f6f3a1de7d640cbb4ea45fe820c042c6b134e3f2.1684915182.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 24/05/2023 10:02, Geliang Tang wrote:
> Increase pm subflows counter on both server side and client side when
> userspace pm creates a new subflow, and decrease the counter when it
> closes a subflow.
> 
> Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
> address is announced by userspace PM.
> 
> This modification is similar to how the in-kernel PM is updating the
> counter: when additional subflows are created/removed.
(...)

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 114548b09f47..7ada9cf81c14 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -91,6 +92,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
>  
>  	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
>  		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
> +			msk->pm.local_addr_used--;

Do you mind if I add this under the following comment with the TODO? We
should only decrement the entry if it is the last one being used.

>  			/* TODO: a refcount is needed because the entry can
>  			 * be used multiple times (e.g. fullmesh mode).
>  			 */

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
