Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F7F6AB4
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 19:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656532638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8D5+x/0XeAjC4PJMATK/dHgu0gh2+hRobHxwvnjY0I=;
	b=L71O7Crt5Wq/XQqf6sYaN3OXp+1nYGI8hvT0Dwdo2tfKXZxhvtToVLN3SxNkePZkykDyIn
	fBsi3ObQKv/a7+E8b1jvWWSS6YOc+k3W+YIiNmt8EgEdqQZRHJIUQwVc9LtdqcRDK4iyfp
	bkDJ9qhwvOnANTFt1aINY3+Efz3+QOQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-3jA7-zgqMwamnAau-mu6tw-1; Wed, 29 Jun 2022 15:57:17 -0400
X-MC-Unique: 3jA7-zgqMwamnAau-mu6tw-1
Received: by mail-wm1-f72.google.com with SMTP id h125-20020a1c2183000000b003a03a8475c6so6515622wmh.8
        for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 12:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=a8D5+x/0XeAjC4PJMATK/dHgu0gh2+hRobHxwvnjY0I=;
        b=pgkPywB97+cc+HqVMg4bH0bV0gq8rNMP0ZzyQ5sKA4HHr5F6sEuA/GkY17i2glcG16
         VQCPNSfPNdkmy8VTwrXlSlg8lDw6FjRRg8CLclaUJ2ui/eHUKjkt3dg/kU5cYjewa8UF
         jgGC0IMq3YZicDGhVUGMBjIMq86+W0lt5gAVkDT15b7N7Z5zFhk1eT1K2bpibctp5WUC
         t1s3mHUcX9eH4mLvRa261+U76Rj5ZhZsWdZ4bs//3sn9KfazY3QNb+ifyBzcAcKFRW9q
         pMCOL4dAyBglEEj19Cy6zjc++zSHFIbIKmj86m90iKpS8uQawu/Uit3AVVlAWPQQ/Zeb
         yprw==
X-Gm-Message-State: AJIora8LtM6FUM5fyfIv/KowCVcdzAkz99zctVmNhFURWI2wTtNqD3NB
	U0dZSJ8mRLILULZQHwNLXG9ZqGvZ/HlFnICZMWOZKwpRYz5EWGQZGz9wecPw1dwz7Nh0mV0V1WS
	8JH5PIVrUYFRtEIM=
X-Received: by 2002:a05:6000:1688:b0:21b:9f71:f046 with SMTP id y8-20020a056000168800b0021b9f71f046mr4715552wrd.553.1656532635630;
        Wed, 29 Jun 2022 12:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sXQAEkYiiavMaAxksh6/53SREnZNWw3euuzeMOuFKMEroLCDDp15iwKHyB9mZW3GQPxpUbnQ==
X-Received: by 2002:a05:6000:1688:b0:21b:9f71:f046 with SMTP id y8-20020a056000168800b0021b9f71f046mr4715534wrd.553.1656532635390;
        Wed, 29 Jun 2022 12:57:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c3b0200b0039c63f4bce0sm192093wms.12.2022.06.29.12.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:57:14 -0700 (PDT)
Message-ID: <c5935b379d4517af3edf6e7c567445032e8bf39b.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 1/3] mptcp: Avoid acquiring PM lock for
 subflow priority changes
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Wed, 29 Jun 2022 21:57:13 +0200
In-Reply-To: <20220628190356.326233-2-mathew.j.martineau@linux.intel.com>
References: <20220628190356.326233-1-mathew.j.martineau@linux.intel.com>
	 <20220628190356.326233-2-mathew.j.martineau@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Tue, 2022-06-28 at 12:03 -0700, Mat Martineau wrote:
> The in-kernel path manager code for changing subflow flags acquired both
> the msk socket lock and the PM lock when possibly changing the "backup"
> and "fullmesh" flags. mptcp_pm_nl_mp_prio_send_ack() does not access
> anything protected by the PM lock, and it must release and reacquire
> the PM lock.
> 
> By pushing the PM lock to where it is needed in mptcp_pm_nl_fullmesh(),
> the lock is only acquired when the fullmesh flag is changed and the
> backup flag code no longer has to release and reacquire the PM lock.
> 
> This change also makes it possible to call
> mptcp_pm_nl_mp_prio_send_ack() for the userspace PM commands without
> manipulating the in-kernel PM lock.
> 
> Fixes: 0f9f696a502e ("mptcp: add set_flags command in PM netlink")
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  net/mptcp/pm_netlink.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index e099f2a12504..d04b34fc9a8e 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -741,10 +741,8 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>  		subflow->request_bkup = bkup;
>  		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
>  
> -		spin_unlock_bh(&msk->pm.lock);
>  		pr_debug("send ack for mp_prio");
>  		mptcp_subflow_send_ack(ssk);
> -		spin_lock_bh(&msk->pm.lock);
>  
>  		return 0;
>  	}
> @@ -1816,8 +1814,10 @@ static void mptcp_pm_nl_fullmesh(struct mptcp_sock *msk,
>  
>  	list.ids[list.nr++] = addr->id;
>  
> +	spin_lock_bh(&msk->pm.lock);
>  	mptcp_pm_nl_rm_subflow_received(msk, &list);
>  	mptcp_pm_create_subflow_or_signal_addr(msk);
> +	spin_unlock_bh(&msk->pm.lock);
>  }
>  
>  static int mptcp_nl_set_flags(struct net *net,
> @@ -1835,12 +1835,10 @@ static int mptcp_nl_set_flags(struct net *net,
>  			goto next;
>  
>  		lock_sock(sk);
> -		spin_lock_bh(&msk->pm.lock);
>  		if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
>  			ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);

This causes a

BUG: using __this_cpu_add() in preemptible code

as
		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);

in mptcp_pm_nl_mp_prio_send_ack is no longer in atomic context. Either
use MPTCP_INC_STATS() and/or move the increment in write_options (I
think the latter is better)

>  		if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
>  			mptcp_pm_nl_fullmesh(msk, addr);
> -		spin_unlock_bh(&msk->pm.lock);
>  		release_sock(sk);
>  
>  next:

