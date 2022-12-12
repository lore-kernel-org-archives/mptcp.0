Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FFF23BD
	for <mptcp@lists.linux.dev>; Mon, 12 Dec 2022 12:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670846812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCE7LHxsv30VRiyqyoGtc7xx9txAaCH3qStBwQDDL2A=;
	b=LppTlTJU9oI3kswxVtOMgX57NIt9LlB7TSbCNrp2qLGYUVd+QyabSSW2mwANcjKThsLe9R
	UN+0Lap7WOxm5fjpmVDxpq2asBovVHIcHYa3gSQNDOIUP7nxaw4au5mVTz0KA7XY1T1pC6
	LAZWKqm3Yp0icxx8jO7yPsaps1gpZL4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-o0j6T7XXP3KNGHh4DKMSgw-1; Mon, 12 Dec 2022 07:06:51 -0500
X-MC-Unique: o0j6T7XXP3KNGHh4DKMSgw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-40306a5a42cso125743327b3.1
        for <mptcp@lists.linux.dev>; Mon, 12 Dec 2022 04:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCE7LHxsv30VRiyqyoGtc7xx9txAaCH3qStBwQDDL2A=;
        b=5fjlxWVa/WeHjqo5bQH7WyXCxbxUjmmhI+zXdJ1tOyzb0CT0C8PXacALAmmvVMSEpy
         HE6VyGyqhroy8qRhpOAnKyf2Dr96G+UsYmqEfV+DFBpLVc/KRQpExipEQmLZjeEBSLTT
         Y7UiWOA7AV4xRx7WXrJ1/7GxexzvZdIszwqYXbX3r9qFOWGNxyHUWh4iaV5j1Ighxs36
         1StF16EpCTNyun19O9UIsNrHRBa/6ADUUXd2gEtbIyR5XcoWlOF9IdIoDYxix/EVHGTZ
         fmu4LmWPiQqxHCotXhC2adbEs7vk8pNYtKFAZZvHq4VCn/roUk1tTLi4dUUixZfHChR8
         m3vg==
X-Gm-Message-State: ANoB5pkmd6FLKYqr049TX3HfjGZpiw/OeRGNYAll968r1VKdMqZJo5ZC
	ebFJpBwRvSztlZW2TanTjXzlPY2Yx0Y3Kv05l6z2yFCA7rtpP5ckZyboIpajioYZnwGIFVLJFPx
	4uGkPVRdvZ+TuoHA=
X-Received: by 2002:a5b:989:0:b0:6fc:31b2:4ce2 with SMTP id c9-20020a5b0989000000b006fc31b24ce2mr12921671ybq.32.1670846810698;
        Mon, 12 Dec 2022 04:06:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4wnmeyIAIQS+f925T+WtpYikziWPINvRNt/RhhPgR7iAqi76Y/vQ626NH3VM014krBV50hQg==
X-Received: by 2002:a5b:989:0:b0:6fc:31b2:4ce2 with SMTP id c9-20020a5b0989000000b006fc31b24ce2mr12921650ybq.32.1670846810340;
        Mon, 12 Dec 2022 04:06:50 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-87.dyn.eolo.it. [146.241.97.87])
        by smtp.gmail.com with ESMTPSA id dt26-20020a05620a479a00b006fbf88667bcsm5661769qkb.77.2022.12.12.04.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 04:06:49 -0800 (PST)
Message-ID: <f84cb49cee8ac2f51f15123e7ffb80da1a055ce7.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix lockdep false positive
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 12 Dec 2022 13:06:46 +0100
In-Reply-To: <194f648f-4813-a0ef-2c28-dd46acc3c4eb@linux.intel.com>
References: <0818f7332284bd7781956959fbebb90188e140cb.1670435550.git.pabeni@redhat.com>
	 <194f648f-4813-a0ef-2c28-dd46acc3c4eb@linux.intel.com>
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

Hello,

Sorry for the extra latency
On Wed, 2022-12-07 at 17:50 -0800, Mat Martineau wrote:
> > @@ -1813,8 +1813,18 @@ void mptcp_subflow_queue_clean(struct sock *listener_ssk)
> > 
> > 		do_cancel_work = __mptcp_close(sk, 0);
> > 		release_sock(sk);
> > -		if (do_cancel_work)
> > +		if (do_cancel_work) {
> > +			/* lockdep will report a false positive ABBA deadlock between
> > +			 * cancel_work_sync and the listener socket. The involved locks
> > +			 * belong to differen sockets WRT the existing AB chain.
> 
> s/differen/different/
> 
> > +			 * Using a per socket key would be very invasive and heavy, just
> > +			 * tell lockdep to consider the listener socket released here
> > +			 */
> > +			mutex_release(&listener_sk->sk_lock.dep_map, _RET_IP_);
> > 			mptcp_cancel_work(sk);
> > +			mutex_acquire(&listener_sk->sk_lock.dep_map,
> > +				      SINGLE_DEPTH_NESTING, 0, _RET_IP_);
> 
> Any concerns about this change breaking lockdep if the existing 
> assumptions about listener sockets no longer apply? For example, if 
> someone made the unfortunate choice to start using mptcp_worker() with a 
> MPTCP listener sock?

I'm not sure I read the above correctly. This change does not bring
extra assumption about listener sockets. Starting the worker on the
listener socket will not impact the above annotation: the listener
socker will try to catch/shutdown/cancel the releated worker in the
related mptcp_close() call.

I'm unsure I explained the current problem in a clear way.

Here we have 2 msk sockets ('listener_sk' and 'sk'). The above code is
invoked under the listener sk socket lock.  

Lockdep see:

workqueue(sk) waits for lock(sk)

lock(listener_sk) waits for workqueue(sk)

and barks loudly since listener_sk and sk have the same 'key' - are
basically the same thing from lockdep perspective. A 'cleaner' fix
would be setting different lockdep key either on the mptcp workqueue or
on the socket. I refrained from that since it would be quite more
invasive (dynamic lockdep key allocation /cleanup).

Let me check if it is as painful as I thought...

thanks,

Paolo

