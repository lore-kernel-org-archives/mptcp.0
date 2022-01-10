Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC99168
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641814819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U30G/f3tn+goNBuKGFQmoew0FIZTpR2M9octbmAmw14=;
	b=JmQgsavfgl4/bF3rHI8U7yR67buAi9NFmUMGlbpX9iWhdAqXRWc7KQ2UU/0rQvAZOU9Xuo
	PoATbJ77VvDpBcURntiOFSlBunUy/W+cg/w5MiZPhC0ozHf0whtKITRcZZZDrJ9/sNfrSz
	2YNrxDqGy5sNY1xVnyGZ4s45yuSk74w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-TnUW8x9KOiiWt_X7qhRtZQ-1; Mon, 10 Jan 2022 06:40:18 -0500
X-MC-Unique: TnUW8x9KOiiWt_X7qhRtZQ-1
Received: by mail-wr1-f70.google.com with SMTP id o28-20020adfa11c000000b001a60fd79c21so2402862wro.19
        for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 03:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=U30G/f3tn+goNBuKGFQmoew0FIZTpR2M9octbmAmw14=;
        b=61qW3IMy0tMFdvWOjFolxTwhBsHOYaCGDjKbcADN/fGh+7z42vB2GjSELkFSLRHeIh
         RUsV9Lgbj7u+lNnM6b/Gc7qKDEFqaYQ/2RHgjrk/jODC1jH8neA1QIdb4PfCjhxQzn3l
         PiP2WQUKpbgJWW3yLSM1M7Gl/Opd0voXfZmxv1U2YzI5f9wtd4IfFNSDDhAa7jKz/zUG
         Esgk8S+6OiS6K3agINczkQ1R7bhWPX8XYCxOipYnYUJcrGxTlDbWL35EaaJwRqFeMLmG
         QhEYlVBZfa0cZ9DvNingn3RQP9DAzt2p0TatMYlxEKIbWvjRavsef9gvjpE5rt8LWc0L
         uJvA==
X-Gm-Message-State: AOAM531foE5Lg3B0+dL8K0srX0BW3nwyULSMl+Ugof+nOgG7jyc2MTkO
	GE5DHlsl0GEjqKL327JA0kJmj5uKDR5FQbCxbhgRrNliOmJQKJqq+HN4se/CS+VXQ6ZWCnzFMGI
	ED/lWrayjd78X0J0=
X-Received: by 2002:a05:600c:3d8f:: with SMTP id bi15mr21688587wmb.172.1641814816432;
        Mon, 10 Jan 2022 03:40:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZTRV4l+NxGTf0ykARFJX6OHe9oojlJhfXhHjYnB4KjUpLH9V4C7vcHXO2KvRNZedvK2ujig==
X-Received: by 2002:a05:600c:3d8f:: with SMTP id bi15mr21688569wmb.172.1641814816182;
        Mon, 10 Jan 2022 03:40:16 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-184.dyn.eolo.it. [146.241.97.184])
        by smtp.gmail.com with ESMTPSA id l4sm7083757wry.85.2022.01.10.03.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:40:15 -0800 (PST)
Message-ID: <b3999648a78756fe4551b821d26b2d0e8423ee44.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/7] mptcp: fix removing ids bitmap
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Mon, 10 Jan 2022 12:40:14 +0100
In-Reply-To: <c0f7d6c068b3047308263d83a2470003858cfb8e.1641785106.git.geliang.tang@suse.com>
References: <cover.1641785106.git.geliang.tang@suse.com>
	 <c0f7d6c068b3047308263d83a2470003858cfb8e.1641785106.git.geliang.tang@suse.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2022-01-10 at 11:29 +0800, Geliang Tang wrote:
> In mptcp_pm_nl_rm_addr_or_subflow(), the bit of rm_list->ids[i] in the
> id_avail_bitmap should be set, not rm_list->ids[1]. This patch fixed it.
> 
> Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index f12effa71942..47ad00d01cf2 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -777,7 +777,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
>  			removed = true;
>  			__MPTCP_INC_STATS(sock_net(sk), rm_type);
>  		}
> -		__set_bit(rm_list->ids[1], msk->pm.id_avail_bitmap);
> +		__set_bit(rm_list->ids[i], msk->pm.id_avail_bitmap);
>  		if (!removed)
>  			continue;
>  

LGTM!

Acked-by: Paolo Abeni <pabeni@redhat.com>

I think this one could be spooled independently from the other patches,
so it could land on -net early.

WDYT?

Thanks!

Paolo

