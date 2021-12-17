Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724112CAA
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 18:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639766310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qv+IIsMbtUQotx2glqeX1Xen+Ulegwi+0gNI9IP880c=;
	b=jTq3ogVYfHh+QX2A/2K3uTjTwUVBjUPxXlFTdEo4ggs0y0zfMCAbQLdto6pn8BwctP3znb
	42NXwJBkZJkRL4JTO3T09XzusxzdL7r3Cj9TDAMj0YMW8UmXuR3qEqo4fCRUtyUsS9LJUm
	IlWZ5+LzQ5+X9K62xaBzlt0xtPJ687c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-NNzFe8sCPM6Cgk87YiuVyA-1; Fri, 17 Dec 2021 13:38:29 -0500
X-MC-Unique: NNzFe8sCPM6Cgk87YiuVyA-1
Received: by mail-qt1-f200.google.com with SMTP id a8-20020ac86108000000b002b63fc40062so3364718qtm.2
        for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 10:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Qv+IIsMbtUQotx2glqeX1Xen+Ulegwi+0gNI9IP880c=;
        b=I19bC/M9JpCQ9w1dz7jMbv7IYVMkPnkURe+iK7BKrGxzHtRnmdHfrjXW6hxLWJHkFz
         pAWBQtrpQQxU2kWJoUNXxOm4X+hLHqKhgdjyvAkQX/+hjHr+lUrONIHORPaPGoKW+HFO
         MHSWachIZgCtRTlxFi6zmGygPttUZWfYb9EI6ou8BtDvfISRSfLk7g7yLXQN+gcgu0Y4
         RILm7Vo/9Z8N5QXjiSOwY7nAlb4qIVJis+f3oOBsMChDj25F93HSyNSdz0BrWE8aW5IT
         SUQl14tRKlWl66BQIThyTVd/2XpsdrkRR37erwYP26OT6kpe+0odO6n8jK6bgAl1FLm2
         tPLA==
X-Gm-Message-State: AOAM5302AzTv7v5jl5/cAWfJBRerPy9aVHrBzUQauTFapzvfTjwhEiAw
	j0xTE62XL0ohIoGgDqax0eSdnW2xkJ4r1OXZZh0Uf3+WMJDCyKjiKrOL0kPBwYb1SXzf8zk6Otw
	JJXGbBcw+rD09EcQ=
X-Received: by 2002:a05:6214:2409:: with SMTP id fv9mr3750043qvb.24.1639766308496;
        Fri, 17 Dec 2021 10:38:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8G+hzN95lZYuWwo2TduA0Fvuu+SDMIv0Xr+VnVOl4N0hCsV2w+SvrNXv1WkMUpC2XD/3pSQ==
X-Received: by 2002:a05:6214:2409:: with SMTP id fv9mr3750025qvb.24.1639766308299;
        Fri, 17 Dec 2021 10:38:28 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-225-60.dyn.eolo.it. [146.241.225.60])
        by smtp.gmail.com with ESMTPSA id m4sm7068163qtu.87.2021.12.17.10.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:38:27 -0800 (PST)
Message-ID: <14ebb20462d681f7ec696499816187672a5985bd.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 09/21] mptcp: allow ADD_ADDR reissuance by
 userspace PMs
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Fri, 17 Dec 2021 19:38:25 +0100
In-Reply-To: <20211216222314.1244708-10-kishen.maloor@intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
	 <20211216222314.1244708-10-kishen.maloor@intel.com>
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

On Thu, 2021-12-16 at 17:23 -0500, Kishen Maloor wrote:
> This change allows userspace PM implementations to reissue ADD_ADDR
> announcements (if necessary) based on their chosen policy.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  net/mptcp/pm_netlink.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d57e2f825728..1adaf5d14f87 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -452,8 +452,16 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  
>  	lockdep_assert_held(&msk->pm.lock);
>  
> -	if (mptcp_lookup_anno_list_by_saddr(msk, &entry->addr))
> -		return false;
> +	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
> +
> +	if (add_entry) {
> +		if (READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL)
> +			return false;
> +
> +		sk_reset_timer(sk, &add_entry->add_timer,
> +			       jiffies + mptcp_get_add_addr_timeout(net));
> +		return true;
> +	}

I'm unsure I understand correctly the goal here ?!? retransmission on
timeout of the announced address are already implmeneted by the
existing code. What kind of different behaviour do you want to obtain
here?

Thanks!

Paolo

