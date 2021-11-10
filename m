Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBDF2C80
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 11:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636542141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=j4avC/inHU9NonzH82bNURQs8OB3xs/ZS/VXGQwI5+0=;
	b=CALZLxPFvGNnIJLgjRJ5BV3J3ONYbs3aPB5hH2IWjxRLoe3yqJlIbzV6WiMNlH+jAuwNyV
	kCMkLhUnRmnhKEdrvMA0WRCyT6zCMycQVQ0ze6CGZ/DbzcFdlo4IUVkqoOkI+cPBRlG+E8
	tiNtT5cvYmnSFGy8ikqMj4GZERE641M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-reH-__AoOgSNtyT3MChBkw-1; Wed, 10 Nov 2021 06:02:20 -0500
X-MC-Unique: reH-__AoOgSNtyT3MChBkw-1
Received: by mail-ed1-f72.google.com with SMTP id y12-20020a056402270c00b003e28de6e995so1991108edd.11
        for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 03:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=j4avC/inHU9NonzH82bNURQs8OB3xs/ZS/VXGQwI5+0=;
        b=P8tpYr38ciPDt+pkbfl4wvi3KQA0h1hMZcKdrsxJYGt6eJzTVLAgU2ERzYZNt9Dkg6
         G06aMpHVR0mu/55jevlnnclDjAjSTCl9z182WBYP8gcGNGUVEPWnSkxvkSmmEr9o26b/
         ZxZjwmQRGuaCgtIVds1YYOTMc2Lyn4Z9Z0tCmND17iyMbe65LFghKN/8R42mX2308UrC
         ltvnbeAjkzEOjJQkYRGSvNx/5LROCoqYF+Z9HMGxCQ5+ig0x+g1i15jd7GYeXJ8kCypp
         +KRIRBKZFOXPVp6BKE7aSCOZlqYQgB7tKinTFL8/Ef9jpS/ugRY0Hskkn/uYh34dZWXv
         TaPA==
X-Gm-Message-State: AOAM5328X8CeEyZVRpy3RorDxF7nKoXr4OLALypFe/oPRCHyh7fEqGzh
	xwp78dczVTt203tyh5ZR3MXCzlnzqvHUi7Y2GUBxpp/+VB62cTJMMEkoQbH9AUUg9BXnJdZ+PTr
	Zfs4MYp+7Gmpr64hsUeA9esz75mKekqTxlAO9Yi+DQdcZuq8255cit1oUT07FeOZN
X-Received: by 2002:a17:906:3385:: with SMTP id v5mr19865950eja.45.1636542138888;
        Wed, 10 Nov 2021 03:02:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyA56kMeX5ZKpLRNNlx9ZzTzCICiqxt1vi+tKE2Ot7rT+eby/FpDridFJk65/SrVl5KTrlkCQ==
X-Received: by 2002:a17:906:3385:: with SMTP id v5mr19865906eja.45.1636542138630;
        Wed, 10 Nov 2021 03:02:18 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-224-97.dyn.eolo.it. [146.241.224.97])
        by smtp.gmail.com with ESMTPSA id bm2sm12575258edb.39.2021.11.10.03.02.18
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:02:18 -0800 (PST)
Message-ID: <67929b99f9baaf448457bf2cd5efce430dd1a2d9.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/3] mptcp: add SIOCINQ, OUTQ and OUTQNSD
 ioctls
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Wed, 10 Nov 2021 12:02:16 +0100
References: <7bfe33f96550ffd6efaa3266f6027a8d7c500b70.camel@redhat.com>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

Whoops, I omitted the ML in my reply, sorry...

@Florian: sorry for the dups! please reply to this one, if needed, to
re-include properly the ML into the thread.

On Wed, 2021-11-10 at 09:53 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > > +	if (sk->sk_state == TCP_LISTEN)
> > > +		return -EINVAL;
> > > +
> > > +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> > > +		return 0;
> > > +
> > > +	delta = READ_ONCE(msk->write_seq) - v;
> > 
> > This is under the msk socket lock and write_seq is protected by the
> > full/plain msk socket lock so READ_ONCE should not be necessary, I
> > think. The same for 'snd_nxt' below. 
> 
> Then why is write_seq updated with WRITE_ONCE in lots of places?

'write_seq' is read outside the msk socket lock scope in a few places. 

My understanding is that to avoid reces and ubsan splat we need to mark
each write with WRITE_ONCE, and read outside the socket lock with
READ_ONCE.

If all the write happens under the socket lock, read under the socket
lock don't need the _ONCE annotation. My reference is:

https://marc.info/?l=linux-netdev&m=161198643714502&w=2

Feel free to correct me if I'm wrong! 

BTW this always reports '1' on fallback sockets after shutdown, as
after shutdown write_seq is incremented by 1, but snd_una/snd_nxt are
not incremented when receiving the TCP fin. I guess the fix not
strictly related to this patch.

Cheers,

Paolo


