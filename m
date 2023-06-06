Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56142A6EA
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 10:11:59 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f736e0c9b1so27915465e9.3
        for <mptcp@lists.linux.dev>; Tue, 06 Jun 2023 03:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686046318; x=1688638318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PjZD64nD9uDw2ysYWjBEluXV8UBaLP33LjAprrSBmFs=;
        b=fRD82usRVCAYXBUf53PAwnswicLoD8ywITizMqceWvNlbhRWsfgQSM16BUs3t63jRz
         1M8olawA82VJt1Ac1Oj2WGG0kIzHcYDQfgVxgYzhE77WSJBTN/565TO8dVRWKeRdREde
         sFWIMhAmBtU97jttZM39A2i72JNSWZbOWvTZ9h7ty8zpkkNVe9kQsxv+sUNLNmiwfRuI
         9A/uO3IL2TH1GWmMJg8KG91LIQFoW6SqzOqzOw8fv2KjMIZotGrwiKYkLm+guIhcVY8h
         x/CM/fvknUZFAEAC0KyrNxH+WPztTpiMM5r5rBsZ8napcd0ETCZ6RAyziJ8wRp0hfZvc
         4Bbw==
X-Gm-Message-State: AC+VfDz9UrpPUbLvQCJ4f9By8D1ghj/tNqp8x4r1AeyiSo5HUWHxGkCI
	+VgrUzkGlItt5T+Oz5tos04=
X-Google-Smtp-Source: ACHHUZ5VuRy6tj2/a+/ZVk3bcFIrCucyH/hLYU0AvfurxedS1PxfbUZxr/R70tGP9osBH0Iu3y7fBA==
X-Received: by 2002:a05:600c:114c:b0:3f7:6bd9:2819 with SMTP id z12-20020a05600c114c00b003f76bd92819mr1701438wmz.29.1686046317704;
        Tue, 06 Jun 2023 03:11:57 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id z19-20020a7bc7d3000000b003f7ead9be7fsm1323903wmk.38.2023.06.06.03.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 03:11:57 -0700 (PDT)
Date: Tue, 6 Jun 2023 03:11:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Remi Denis-Courmont <courmisch@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, axboe@kernel.dk,
	asml.silence@gmail.com, leit@fb.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, dccp@vger.kernel.org,
	linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
	linux-sctp@vger.kernel.org
Subject: Re: [PATCH net-next v5] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
Message-ID: <ZH8Ga15IFIUUA7j8@gmail.com>
References: <20230602163044.1820619-1-leitao@debian.org>
 <CAF=yD-Kk9mVWPZN50NUu8uGwEbySNS-WzvJ=1HTTcVsA6OOuvA@mail.gmail.com>
 <ZHxEX0TlXX7VV9kX@gmail.com>
 <CAF=yD-LvTDmWp+wAqwuQ7vKLT0hAHcQjV9Ef2rEag5J4cSZrkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-LvTDmWp+wAqwuQ7vKLT0hAHcQjV9Ef2rEag5J4cSZrkA@mail.gmail.com>

On Sun, Jun 04, 2023 at 11:17:56AM +0200, Willem de Bruijn wrote:
> > On Sat, Jun 03, 2023 at 10:21:50AM +0200, Willem de Bruijn wrote:
> > > On Fri, Jun 2, 2023 at 6:31 PM Breno Leitao <leitao@debian.org> wrote:
> > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > >
> > > Please check the checkpatch output
> > >
> > > https://patchwork.hopto.org/static/nipa/753609/13265673/checkpatch/stdout
> >
> > I am checking my current checkpatch before sending the patch, but I am
> > not seeing the problems above.
> >
> > My tree is at 44c026a73be8038 ("Linux 6.4-rc3"), and I am not able to
> > reproduce the problems above.
> >
> >         $ scripts/checkpatch.pl v5/v5-0001-net-ioctl-Use-kernel-memory-on-protocol-ioctl-cal.patch
> >         total: 0 errors, 0 warnings, 0 checks, 806 lines checked
> >         v5/v5-0001-net-ioctl-Use-kernel-memory-on-protocol-ioctl-cal.patch has no obvious style problems and is ready for submission.
> >
> > Let me investigate what options I am missing when running checkpatch.
> 
> The reference is to the checkpatch as referenced by patchwork:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20230602163044.1820619-1-leitao@debian.org/
> 
> The 80 character limit is a soft limit. But also note the CHECK
> statements on whitespace.

Right. In order to enable the "CHECK" statments, we need to pass the
"--subjective" parameter to checpatch.pl

That said, I am able to reproduce the same output now, using the
following command line:

	$ scripts/checkpatch.pl --subjective --max-line-length=80

> > > > +/* A wrapper around sock ioctls, which copies the data from userspace
> > > > + * (depending on the protocol/ioctl), and copies back the result to userspace.
> > > > + * The main motivation for this function is to pass kernel memory to the
> > > > + * protocol ioctl callbacks, instead of userspace memory.
> > > > + */
> > > > +int sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
> > > > +{
> > > > +       int rc = 1;
> > > > +
> > > > +       if (sk_is_ipmr(sk))
> > > > +               rc = ipmr_sk_ioctl(sk, cmd, arg);
> > > > +       else if (sk_is_icmpv6(sk))
> > > > +               rc = ip6mr_sk_ioctl(sk, cmd, arg);
> > > > +       else if (sk_is_phonet(sk))
> > > > +               rc = phonet_sk_ioctl(sk, cmd, arg);
> > >
> > > Does this handle all phonet ioctl cases correctly?
> > >
> > > Notably pn_socket_ioctl has a SIOCPNGETOBJECT that reads and writes a u16.
> >
> > We are not touching  "struct proto_ops" in this patch at all.  And
> > pn_socket_ioctl() is part of "struct proto_ops".
> >
> >         const struct proto_ops phonet_stream_ops = {
> >                   ...
> >                   .ioctl          = pn_socket_ioctl,
> >         }
> >
> > That said, all the "struct proto_ops" ioctl calls backs continue to use
> > "unsigned long arg" with userspace information, at least for now.
> 
> Ok. Perhaps good to call out in the commit message that this does not
> convert all protocol ioctl callbacks.

Sure, let me send a V6 with this information in the patch summary.
