Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDCA36A
	for <mptcp@lists.linux.dev>; Mon, 21 Mar 2022 10:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1647860221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttWDNeK7LcYsKWmrvVxNBIe5anh/KmiG5xzb+EeQZ4Y=;
	b=DNI7IoTUBA5IP2wQJ7CzxAG44SeevwMK4YOJutv0Ncw4Vlb9wVserC5ihLHNGR+XIQqinu
	FmVxQbcB9FS85RRXf/8ralQLjdCpqPGPKvnvNOwJDuFoOz9oWjM4BiOr2N/4F6zgOskYUN
	lcyMdMXkqGcFFrS3+RywnZq5CFbbQHg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-aj-m1x8EPKaWEy-SVXUzIg-1; Mon, 21 Mar 2022 06:57:00 -0400
X-MC-Unique: aj-m1x8EPKaWEy-SVXUzIg-1
Received: by mail-qk1-f197.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso9523329qkl.7
        for <mptcp@lists.linux.dev>; Mon, 21 Mar 2022 03:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ttWDNeK7LcYsKWmrvVxNBIe5anh/KmiG5xzb+EeQZ4Y=;
        b=Xkc2NbS0EVqzjxpzmjnE4vll+Fka37IWfPRAZ6S+VamZOYA0feom4hmH8OAZ65UX9H
         kgnoavd4ShkEOHPmRhVD3lmPFzwfkEH/Fyk8ZUumezPFreOFTPylex/DpY4MUXYnp+Py
         BHYXRLCGixD7dz7PlGCAWTY3cJhPw9COtW9M0Fv5AcH0f+QGkgnvVFTpF4Qute4DVCue
         hj+mDZwz2vajm38qBSUS3egwDTFMS4vYISzSpyn0lC3VZ6M1Il850rYZEvTwnjvHlshs
         tvmkGwkAhk+s+41kizMMJBKlUq/dqFb9fKkYwYNU4KxbpliZacqmi3nCLxeoUD4/13Yc
         jqlg==
X-Gm-Message-State: AOAM5321918IZD6/MVWfvt3AB06mK2AQGwZMO+1PoUfUxxNraf1cI8n7
	qN8RF3PjaDGQHRvY7n+MdKRGGSQRj42tKfmvSPQs6BP2Hs6GAkfkqv01Fdr0z32E1ThirXhb4Nb
	yPWJb4l1f4SoXRcs=
X-Received: by 2002:ac8:5a43:0:b0:2e1:c68a:6fa0 with SMTP id o3-20020ac85a43000000b002e1c68a6fa0mr15371331qta.481.1647860219296;
        Mon, 21 Mar 2022 03:56:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYd/Ef4LvVk4Pctn8jKQbOHKaeux3BTnJbrSs9IWp28TPF2JkzcpwNgs8c4m6m52JbOKmaBA==
X-Received: by 2002:ac8:5a43:0:b0:2e1:c68a:6fa0 with SMTP id o3-20020ac85a43000000b002e1c68a6fa0mr15371318qta.481.1647860219006;
        Mon, 21 Mar 2022 03:56:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id f21-20020ac859d5000000b002e1e1dfaea5sm12196716qtf.30.2022.03.21.03.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 03:56:58 -0700 (PDT)
Message-ID: <fe282bdf31c684037c4be06bbc5dbb08ff756bb4.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v5 03/14] mptcp: read attributes of addr
 entries managed by userspace PMs
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Mon, 21 Mar 2022 11:56:56 +0100
In-Reply-To: <20220316231636.645625-4-kishen.maloor@intel.com>
References: <20220316231636.645625-1-kishen.maloor@intel.com>
	 <20220316231636.645625-4-kishen.maloor@intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35)
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

On Wed, 2022-03-16 at 19:16 -0400, Kishen Maloor wrote:
> This change introduces a parallel path in the kernel for retrieving
> the local id, flags, if_index for an addr entry in the context of
> an MPTCP connection that's being managed by a userspace PM. The
> userspace and in-kernel PM modes deviate in their procedures for
> obtaining this information.
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  net/mptcp/pm_netlink.c | 95 ++++++++++++++++++++++++++++--------------
>  net/mptcp/protocol.h   |  3 +-
>  net/mptcp/subflow.c    |  2 +-
>  3 files changed, 67 insertions(+), 33 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d8825bf580b7..b597e84affd5 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1106,31 +1106,47 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  
>  	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
>  
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> -		if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
> -			ret = entry->addr.id;
> -			break;
> +	if (mptcp_pm_is_kernel(msk)) {
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> +			if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
> +				ret = entry->addr.id;
> +				break;
> +			}
>  		}
> +		rcu_read_unlock();
> +		if (ret >= 0)
> +			return ret;
> +
> +		/* address not found, add to local list */
> +		entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
> +		if (!entry)
> +			return -ENOMEM;
> +
> +		entry->addr = skc_local;
> +		entry->addr.id = 0;
> +		entry->addr.port = 0;
> +		entry->ifindex = 0;
> +		entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
> +		entry->lsk = NULL;
> +		ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
> +		if (ret < 0)
> +			kfree(entry);
> +	} else if (mptcp_pm_is_userspace(msk)) {

Since pm_netlink.c is growing big and complex, a few pm-related helpers
are getting the user-space specific implementation, and we already have
a "generic" wrapper for some of them in pm.c, I think it would cleaner
keep all the user-space realted new code in a new/separate .c file, and
move the if (mptcp_pm_is_userspace(msk)/if
(mptcp_pm_is_kernelspace(msk)) checks in pm.c

/P

