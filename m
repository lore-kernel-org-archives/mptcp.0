Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA870
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627030961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOks06zVt6TWLN3GzDJK7FCE6qdCBnbx1c4gbzF3yP4=;
	b=GxK4PfD1YUZ2yVQlg6pv4laflQoSfcsMx19SLeM+0r8Xa6Sn7a2PJBjFLoOxqXQf1r1dky
	5WEZMfZfuNgkiU12EHYi6xPJK5+aMhE7OXm8ma1fBXsbt1VA4JK3tLtGWUbfCd7YBfWHxD
	wliOadh14lVTbt6L0i0lC7YM+Flw2vU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-ATGuvoc9OSCl7JLv6dQq4Q-1; Fri, 23 Jul 2021 05:02:38 -0400
X-MC-Unique: ATGuvoc9OSCl7JLv6dQq4Q-1
Received: by mail-wm1-f69.google.com with SMTP id u14-20020a7bcb0e0000b0290248831d46e4so564293wmj.6
        for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 02:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WOks06zVt6TWLN3GzDJK7FCE6qdCBnbx1c4gbzF3yP4=;
        b=VcaBNH09J7J7snjB4vMMinlJ6EywYzmJU7jaOgRNMhwkg6/R76HUCsxHMJ5uTqfdq9
         5g8gzYyW2Hnj2Gbf2dkI1U0IV+UknX5dOWZDA1w8EmeuYhqfgbrv+NM5ZkdLLNpn1uhj
         WC7lPxovF4cJAs/AFy9MtGWjVUkdhoRu8TSTCoMQ+cRUNu4D4QIiBEsufVWaknVGkwgv
         sdYWbapkbg89QvlFGHHeFjTVWM7WNMA06hmPYJx+2wg4jb2WtmoPNUBiNUa2BQmqXiNY
         cq4cLykIJG4YJoql/w4ltoGt2anp2Zgxc0aQlUPn63xhMB4Uye8ePuqd9IPA3LkqYBgA
         s5IA==
X-Gm-Message-State: AOAM532ElwbzC3b0RRY6dqSt9YEvN+G5HvUASXNV0hGvU8IotDKPhlg/
	XIFMnc9RoF017eb7I5W4L2LPyaquD5msITXxJxhEE1OxnF/D+SiU/eVNv7XLzTuBQdQHTRUqBUb
	5wcc3BrFBFB1YEZA=
X-Received: by 2002:a5d:4348:: with SMTP id u8mr280114wrr.28.1627030957370;
        Fri, 23 Jul 2021 02:02:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT2u0b1JNeLvJmaYyrUU5klL+qRTM2CNhRHDrFJixayxnAaT3MFGbijpHRNyNSeIkP6IzYNw==
X-Received: by 2002:a5d:4348:: with SMTP id u8mr280097wrr.28.1627030957225;
        Fri, 23 Jul 2021 02:02:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id d67sm5443974wmd.9.2021.07.23.02.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:02:36 -0700 (PDT)
Message-ID: <ecb6c8c22d8db785c362faa5abf914fca0c4b876.camel@redhat.com>
Subject: Re: IRC snippet
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 23 Jul 2021 11:02:35 +0200
In-Reply-To: <CA+WQbwvrXso4SSLDfYBja58WsqVAfjNifFZcwAryVR8uoY1WYw@mail.gmail.com>
References: <d05f15b3381a4827e4c55826ca5597d9242d222f.camel@redhat.com>
	 <CA+WQbwvrXso4SSLDfYBja58WsqVAfjNifFZcwAryVR8uoY1WYw@mail.gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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
Content-Transfer-Encoding: 8bit

On Fri, 2021-07-23 at 12:01 +0800, Geliang Tang wrote:
> Hi Paolo,
> 
> Thanks for your information, it's very helpful. And I have two more
> questions below.
> 
> Paolo Abeni <pabeni@redhat.com> 于2021年7月22日周四 下午7:23写道：
> > Hello,
> > 
> > moving here from IRC, to avoid disconnection issues...
> > < geliang >   Yes, Netd has the similar thing
> >   < geliang >   It can get the IP up/down event too
> >   < geliang >   https://android.googlesource.com/platform/system/netd/
> >   < geliang >   So I need to add a new flag full-mesh to netlink
> >   < geliang >   and drop the notifiers
> >   < geliang >   and add the addresses array in
> > mptcp_pm_create_subflow_or_signal_addr
> > < geliang >   I'll do these things, thanks Paolo
> > 
> > Note that the array size should be limited by the
> > current add_addr_signal_max (and thus should be max 8).
> > 
> > Each array entry should be mptcp_addr_info, that is 24 bytes.
> > 
> > 24*8 = 192
> > 
> > The above *could* be a little too much for a stack-based local
> > variable, anyhow the kernel should tell, if so, you will get a warning
> > at run time alike 'x function is using y bytes of stack'.

Well, tcp_info is allocated on the stack, and tcp_info is 232 bytes
wide, so I think there are no problem to keep such array into the
stack.

/P

