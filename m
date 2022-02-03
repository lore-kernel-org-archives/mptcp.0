Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B02F26
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 09:46:14 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so1398156wms.3
        for <mptcp@lists.linux.dev>; Thu, 03 Feb 2022 01:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=bkl6+5UyLL8Ef2B7hN7sSzzYnSFj3muV1/6AVf3J0bM=;
        b=0rZVa/4KSrbxDkoy2ERDkttgkD0jI/ecuAkb/77ZEG1jh35d/0VCUBYj+RzPyMdeaF
         eQVkRzwHsCHlkZo+qFmySYIKHW5AEcGcycfGepJeTKULi1EXHiZVACTPz6a0mwnNcaVs
         FQhjF2kNshKlxFc+mhGEHRCOG4OQrIyTLUW+UbkFYh9sAhnJk4gS9g2p4rW9IVCqNVta
         pb3GI3NXIqlwktBiMDTKPJBzeikvOl945Ga0rrTddyLUmc0ZB2diHWdlzQVyg84nKic+
         lGzO10HaG0A31ANgk5EBortWbYiZmeGI6PaJ8LrFh2YXq3tscSgQNvTZeWsMOsSZRJ+9
         tWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bkl6+5UyLL8Ef2B7hN7sSzzYnSFj3muV1/6AVf3J0bM=;
        b=oqQTb4MG8tU0YoZBtHs5t1nA4/UXrzKYo1FOvLEPgiaQaVMv9h8XPzvLmIQROHNE9H
         A22zk1+AgjzygbsJoDcYHppi9AQoo23jf/PvMId/nhzhbNc6maTeZe1WRZI4aW+0XX/8
         7qsRn0PvWBmZNsjjYtsxKAPeHLKtZVX0IxK1OUyW+rt6IHRZ/NgLjSuj8mgGiuS6QbJw
         c7gVhfLKD1NNp4yMSljcKKHYXZVDQlDTmcRc+rbCLdbpj8Mq1X/f6fwTrRjSs8GvPLf1
         hRuDr5eMj0+S7kFlvkrui+yTgD3rwACqhGjTxwsoK3mUzD2FRTA5Fm5iMqf12WqxxC9H
         7FzQ==
X-Gm-Message-State: AOAM530xIaEXKtUSxuMLLC8AueQWZb+Sm4HQvL5wfdpl4e0EtRfQS2n/
	6glw8Ad960pHqavqHvi3S9kd+WpRsAGQ9w==
X-Google-Smtp-Source: ABdhPJxNm4JwUVNgKPY+gpA5ECo90z/MY3LQOeY9hchY9Y6pQd1DRhCTAgwtPnbgwKOh3YMgtczu1Q==
X-Received: by 2002:a05:600c:3d8c:: with SMTP id bi12mr9596721wmb.109.1643881572216;
        Thu, 03 Feb 2022 01:46:12 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id h6sm7094190wmq.26.2022.02.03.01.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 01:46:11 -0800 (PST)
Message-ID: <758fee36-4b3e-0232-0813-e4dee8e53ebc@tessares.net>
Date: Thu, 3 Feb 2022 10:46:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next v4 5/8] mptcp: netlink: store per namespace
 list of refcounted listen socks
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
References: <20220203031331.2996457-1-kishen.maloor@intel.com>
 <20220203031331.2996457-6-kishen.maloor@intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220203031331.2996457-6-kishen.maloor@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen,

On 03/02/2022 04:13, Kishen Maloor wrote:
> The kernel can create listening sockets bound to announced addresses
> via the ADD_ADDR option for receiving MP_JOIN requests. Path
> managers may further choose to advertise the same addr+port over multiple
> MPTCP connections. So this change provides a simple framework to
> manage a list of all distinct listning sockets created in the kernel
> over a namespace by encapsulating the socket in a structure that is
> ref counted and can be shared across multiple connections. The sockets
> are released when there are no more references.

Thank you for working on that!

(...)

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ff13012178ae..3d6251baef26 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c

(...)

> @@ -83,6 +94,69 @@ static bool addresses_equal(const struct mptcp_addr_info *a,
>  	return a->port == b->port;
>  }
>  
> +static struct mptcp_local_lsk *lsk_list_find(struct pm_nl_pernet *pernet,
> +					     struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_local_lsk *lsk_ref = NULL;
> +	struct mptcp_local_lsk *i;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(i, &pernet->lsk_list, list) {
> +		if (addresses_equal(&i->addr, addr, true)) {
> +			if (refcount_inc_not_zero(&i->refcount)) {
> +				lsk_ref = i;
> +				break;
> +			}
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return lsk_ref;
> +}
> +
> +static void lsk_list_add_ref(struct mptcp_local_lsk *lsk_ref)
> +{
> +	refcount_inc(&lsk_ref->refcount);
> +}
> +
> +static struct mptcp_local_lsk *lsk_list_add(struct pm_nl_pernet *pernet,
> +					    struct mptcp_addr_info *addr,
> +					    struct socket *lsk)
> +{
> +	struct mptcp_local_lsk *lsk_ref;
> +
> +	lsk_ref = kmalloc(sizeof(*lsk_ref), GFP_ATOMIC);
> +
> +	if (!lsk_ref)
> +		return NULL;
> +
> +	lsk_ref->lsk = lsk;
> +	memcpy(&lsk_ref->addr, addr, sizeof(struct mptcp_addr_info));
> +	refcount_set(&lsk_ref->refcount, 1);
> +
> +	spin_lock_bh(&pernet->lsk_list_lock);
> +	list_add_rcu(&lsk_ref->list, &pernet->lsk_list);
> +	spin_unlock_bh(&pernet->lsk_list_lock);
> +
> +	return lsk_ref;
> +}
> +
> +static void lsk_list_release(struct pm_nl_pernet *pernet,

The CI is complaining[1] because these functions are not used anywhere:


  net/mptcp/pm_netlink.c:146:13: error: 'lsk_list_release' defined but
not used [-Werror=unused-function]
    146 | static void lsk_list_release(struct pm_nl_pernet *pernet,
        |             ^~~~~~~~~~~~~~~~
  net/mptcp/pm_netlink.c:124:32: error: 'lsk_list_add' defined but not
used [-Werror=unused-function]
    124 | static struct mptcp_local_lsk *lsk_list_add(struct
pm_nl_pernet *pernet,
        |                                ^~~~~~~~~~~~
  net/mptcp/pm_netlink.c:119:13: error: 'lsk_list_add_ref' defined but
not used [-Werror=unused-function]
    119 | static void lsk_list_add_ref(struct mptcp_local_lsk *lsk_ref)
        |             ^~~~~~~~~~~~~~~~
  net/mptcp/pm_netlink.c:97:32: error: 'lsk_list_find' defined but not
used [-Werror=unused-function]
     97 | static struct mptcp_local_lsk *lsk_list_find(struct
pm_nl_pernet *pernet,
        |                                ^~~~~~~~~~~~~


I don't know if it is a good practice to declare static functions and
not use them directly in the same commit but I suppose it is fine.

Cheers,
Matt

[1]
https://github.com/multipath-tcp/mptcp_net-next/runs/5046474331?check_suite_focus=true#step:5:4215

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
