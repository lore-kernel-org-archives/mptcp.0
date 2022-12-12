Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CC28EC
	for <mptcp@lists.linux.dev>; Mon, 12 Dec 2022 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670856980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6MDZPuxnTRT/1PLJ4FWLMDwy1ZEJ/4zgaDnM1Afnbhc=;
	b=Uz2HfdRkG0U10nLdc36baD6B4Q6i3KOK8C8JdIAmgzSwzRzZmxMl2Fjs66hHuqCoDU/2YO
	6dOEGtSI9BVd3l9x9vYpheF680MR5PQM4bbZ7HFbd99ez+6+xbcd1SXsq7BgL2udFzaFbM
	zpyIHuZPNEQWXjvN/3JA3EDh4qSN3qk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-lI4LePSqOu6rzhlkLTwXjw-1; Mon, 12 Dec 2022 09:56:18 -0500
X-MC-Unique: lI4LePSqOu6rzhlkLTwXjw-1
Received: by mail-wm1-f70.google.com with SMTP id j2-20020a05600c1c0200b003cf7397fc9bso3473761wms.5
        for <mptcp@lists.linux.dev>; Mon, 12 Dec 2022 06:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MDZPuxnTRT/1PLJ4FWLMDwy1ZEJ/4zgaDnM1Afnbhc=;
        b=iddpZ+7JS/wnnKUA1kN5sfetWfEZrfIeEG6DyXSun/a5R+VcgghEXfJWMkhpKz6eqY
         qigtINXNmowYkSQoAf41DoGgsjttVBahdp4xYwLIoms1GpZV0VP+HUaWph1+0fZqLMAN
         01AAajGLoBpBxtn8EibGfp9qkLJkV7FvM7sNatUBUrGrL3QMwg9eYC0VNHhCcxCZ4IZH
         f8Xb7s8k7m0O5uRhPFSYGDBWf7fSxvWM5stP/szZqYvGuWcz+HXOMc8ngdldxz+DNZeM
         a8P+zxpQNtc1K/CFD6NRb6fVCYplSXZVh+Oae2BnRF54sBpJbMXYMUAQu09pOrgCL2rS
         5nPQ==
X-Gm-Message-State: ANoB5pm7vaPzMDq4fmo1K2wADdK5ilKqu44FSwAEg9tvt+edQtpM6Sn4
	nsMJ1ILEid+rTpnQmn6YikN6CRTXDennbjsxzUU8I9ANjm4UopDxkIZS38rs+q1aUJKz5AT7z6g
	c1O+ZojFWt4L8AZs=
X-Received: by 2002:a5d:5592:0:b0:242:72bf:8c9f with SMTP id i18-20020a5d5592000000b0024272bf8c9fmr10212455wrv.23.1670856977000;
        Mon, 12 Dec 2022 06:56:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6S8SQZ1LZ85qdysUFcoC4j230po6MpjOKs/f80n4qzOVlSR3TPhjkZ0igXmN8Dx6CLLfH8CA==
X-Received: by 2002:a5d:5592:0:b0:242:72bf:8c9f with SMTP id i18-20020a5d5592000000b0024272bf8c9fmr10212441wrv.23.1670856976730;
        Mon, 12 Dec 2022 06:56:16 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-87.dyn.eolo.it. [146.241.97.87])
        by smtp.gmail.com with ESMTPSA id p7-20020adff207000000b002425dc49024sm9107620wro.43.2022.12.12.06.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 06:56:16 -0800 (PST)
Message-ID: <fed89e9ea616687b6c7531ddeefe9f8fc90f7d4a.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix lockdep false positive
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 12 Dec 2022 15:56:15 +0100
In-Reply-To: <f84cb49cee8ac2f51f15123e7ffb80da1a055ce7.camel@redhat.com>
References: <0818f7332284bd7781956959fbebb90188e140cb.1670435550.git.pabeni@redhat.com>
	 <194f648f-4813-a0ef-2c28-dd46acc3c4eb@linux.intel.com>
	 <f84cb49cee8ac2f51f15123e7ffb80da1a055ce7.camel@redhat.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2022-12-12 at 13:06 +0100, Paolo Abeni wrote:
> Hello,
> 
> Sorry for the extra latency
> On Wed, 2022-12-07 at 17:50 -0800, Mat Martineau wrote:
> > > @@ -1813,8 +1813,18 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
> > > 
> > > 		do_cancel_work = __mptcp_close(sk, 0);
> > > 		release_sock(sk);
> > > -		if (do_cancel_work)
> > > +		if (do_cancel_work) {
> > > +			/* lockdep will report a false positive ABBA deadlock between
> > > +			 * cancel_work_sync and the listener socket. The involved locks
> > > +			 * belong to differen sockets WRT the existing AB chain.
> > 
> > s/differen/different/
> > 
> > > +			 * Using a per socket key would be very invasive and heavy, just
> > > +			 * tell lockdep to consider the listener socket released here
> > > +			 */
> > > +			mutex_release(&listener_sk->sk_lock.dep_map, _RET_IP_);
> > > 			mptcp_cancel_work(sk);
> > > +			mutex_acquire(&listener_sk->sk_lock.dep_map,
> > > +				      SINGLE_DEPTH_NESTING, 0, _RET_IP_);
> > 
> > Any concerns about this change breaking lockdep if the existing 
> > assumptions about listener sockets no longer apply? For example, if 
> > someone made the unfortunate choice to start using mptcp_worker() with a 
> > MPTCP listener sock?
> 
> I'm not sure I read the above correctly. This change does not bring
> extra assumption about listener sockets. Starting the worker on the
> listener socket will not impact the above annotation: the listener
> socker will try to catch/shutdown/cancel the releated worker in the
> related mptcp_close() call.
> 
> I'm unsure I explained the current problem in a clear way.
> 
> Here we have 2 msk sockets ('listener_sk' and 'sk'). The above code is
> invoked under the listener sk socket lock.  
> 
> Lockdep see:
> 
> workqueue(sk) waits for lock(sk)
> 
> lock(listener_sk) waits for workqueue(sk)
> 
> and barks loudly since listener_sk and sk have the same 'key' - are
> basically the same thing from lockdep perspective. A 'cleaner' fix
> would be setting different lockdep key either on the mptcp workqueue or
> on the socket. I refrained from that since it would be quite more
> invasive (dynamic lockdep key allocation /cleanup).
> 
> Let me check if it is as painful as I thought...

It looks like that alternative is not feasible at all: we will need to
de-register the per msk lockdep key at sk free time, sk_destructor is
(/can be) called in atomic context and lockdep_unregister_key()
requires process context. 

I think this is the better option we have.

Cheers,

Paolo

