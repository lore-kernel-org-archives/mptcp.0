Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E872
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 16:24:23 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id v32-20020a0568300920b02904b90fde9029so8455939ott.7
        for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xczKCTyuhtwoZjASSpqKqupD2qvCeMqp8pYEr+GbpNU=;
        b=D7+eSBGkcYe9VJAe//BclzJZaP77VVPBtIXqCryLaHfmOTlOsOUQUhhy1RAeTS7B6P
         6PY910s0Hd46vFDMGWRM4H1rA2MhXvxZp0z65kWIrMFOI9q+JjjLI/qw61Ut3z0MyGem
         WqKFkLr21TK4zvyAM2R6vVJAMHjW7lfsnu5ZoPQRmWjSrM/x4UETCbnx3QMRjBAKoQcH
         du7XKpCvrDdxTEdtCe9Dp/rxjkkNPqYSDUxkHm5EolWpg5WiQ73SrvF/Y4YprLHOo8t3
         wEuBRy21csCxfkTnXbpETZv3bC6a7h4RNa2XgdQoGFoKTocewl87AQOo1e0lJe0Zoeco
         589A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xczKCTyuhtwoZjASSpqKqupD2qvCeMqp8pYEr+GbpNU=;
        b=fXFibLhETT1FOFpjHr5dHSU9Q16gsmN1Mx2ggIDtgU2MYXkeRz5L4c6tAxJ7a4jm/U
         aVx38Ub2oMwKVYefjKAG2qtnZ1POLrUZ2CkAakHnQWeMWmO83BCwxpkBPangoHC1jvYh
         q/jlEB7SSk+A3p3clmdQ/hrEdow9IFNRA5CL3PnT+U5Muzss/0kFXz8svkA4mt0BdCxF
         wGWSldE5/IAmnn5hZ45taTFheJ9EbMGtTgBFd/mzy185XsVBunskLWdhX16zd9UNTa35
         ZBTyO9EFZKXM5//cuiKZXHqqm+kHGMv+lfeuzRiLa3PTXsOMBoadxj6iS2qT+/TkI8dZ
         GyTw==
X-Gm-Message-State: AOAM533jMxTFLaDMlmeOUB44aWrjM79jVuypa9HQw2pgiNwpXVAoiMIM
	zJ9tXpqX5wbZJwR1OhbuKHc=
X-Google-Smtp-Source: ABdhPJzTppdsBnWIA1Bvcrk2KcTfjzyz0Kad81Vma9wuL00XsCV/K3wYWyRovp//eCvs/0AUhpprGA==
X-Received: by 2002:a9d:1b41:: with SMTP id l59mr4431102otl.8.1626193462339;
        Tue, 13 Jul 2021 09:24:22 -0700 (PDT)
Received: from Davids-MacBook-Pro.local ([8.48.134.38])
        by smtp.googlemail.com with ESMTPSA id v11sm946831ook.7.2021.07.13.09.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 09:24:21 -0700 (PDT)
Subject: Re: [PATCH v2] net: Use nlmsg_unicast() instead of netlink_unicast()
To: Yajun Deng <yajun.deng@linux.dev>, davem@davemloft.net,
 yoshfuji@linux-ipv6.org, dsahern@kernel.org, kuba@kernel.org,
 mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
 vyasevich@gmail.com, nhorman@tuxdriver.com, marcelo.leitner@gmail.com,
 johannes.berg@intel.com, ast@kernel.org, yhs@fb.com, 0x7f454c46@gmail.com,
 aahringo@redhat.com, rdunlap@infradead.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mptcp@lists.linux.dev, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, linux-sctp@vger.kernel.org
References: <20210713024824.14359-1-yajun.deng@linux.dev>
From: David Ahern <dsahern@gmail.com>
Message-ID: <55d96ad0-f9e3-ce17-0f7d-5e4c57faeac3@gmail.com>
Date: Tue, 13 Jul 2021 10:24:19 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210713024824.14359-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 7/12/21 8:48 PM, Yajun Deng wrote:
> diff --git a/net/ipv4/raw_diag.c b/net/ipv4/raw_diag.c
> index 1b5b8af27aaf..ccacbde30a2c 100644
> --- a/net/ipv4/raw_diag.c
> +++ b/net/ipv4/raw_diag.c
> @@ -119,11 +119,8 @@ static int raw_diag_dump_one(struct netlink_callback *cb,
>  		return err;
>  	}
>  
> -	err = netlink_unicast(net->diag_nlsk, rep,
> -			      NETLINK_CB(in_skb).portid,
> -			      MSG_DONTWAIT);
> -	if (err > 0)
> -		err = 0;
> +	err = nlmsg_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb).portid);
> +
>  	return err;

can be shortened to:

	return nlmsg_unicast(net->diag_nlsk, rep, NETLINK_CB(in_skb).portid);



other than that it's a good cleanup:

Reviewed-by: David Ahern <dsahern@kernel.org>
