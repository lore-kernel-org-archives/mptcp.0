Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0522115C1
	for <mptcp@lists.linux.dev>; Sun,  4 Jun 2023 07:59:32 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-973f78329e3so583269766b.3
        for <mptcp@lists.linux.dev>; Sun, 04 Jun 2023 00:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685865571; x=1688457571;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5qs9/6uJ8IloMQNdJLVtRnVIUUbYS4OgcobJioBuxs=;
        b=cn+qFepQiJh3lhQfxoxkRjMRFDFhhN/BY0DOCCTiDXtRVMz0HZ1XwkTpIGgFYx63CK
         yzr6JJG5Xe6kS3oYe01StYabxREyrmwWP4e9aAGw9kxpDbbm3LU6w5/IsaC+q9WBYCmw
         mPDJCAbgTLJHlv6aH3OvRdquXJkCCkRU4FjVzMd4N2RMJX4kYRcuqeRaxX8LF1Vf7D0l
         4zvCn52wBEugv7Bqo+AG70OI6RQHTar9+appUBCpeLNPPhoRwol4rC8NmxuM7QQXgQ2L
         SLDAEU6mGPWHeYwAvacIbD2pTUFtpIjWLX9i4jAmv29jaaZFPfW9xGJYPLZQgykLtvlE
         9ALw==
X-Gm-Message-State: AC+VfDzLJyRm9UPqWkXhEmtP9jQnCvt0GLJuUGcQuLZLdFQzW04h4QxX
	cH7/6swovAG3p1bjupc8MuU=
X-Google-Smtp-Source: ACHHUZ5YcxrSr3RoUr9BpB/eNrGolI0P3RzHaj6jkcll2hTu+W/ZqJE8aYJUHyyTtYhUyjhQJWqKcQ==
X-Received: by 2002:a17:907:3f1f:b0:974:5480:171e with SMTP id hq31-20020a1709073f1f00b009745480171emr4761698ejc.32.1685865570735;
        Sun, 04 Jun 2023 00:59:30 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c00cc00b003f7678a07c4sm383178wmm.29.2023.06.04.00.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 00:59:30 -0700 (PDT)
Date: Sun, 4 Jun 2023 00:59:27 -0700
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
Message-ID: <ZHxEX0TlXX7VV9kX@gmail.com>
References: <20230602163044.1820619-1-leitao@debian.org>
 <CAF=yD-Kk9mVWPZN50NUu8uGwEbySNS-WzvJ=1HTTcVsA6OOuvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF=yD-Kk9mVWPZN50NUu8uGwEbySNS-WzvJ=1HTTcVsA6OOuvA@mail.gmail.com>

Hello Willem 

On Sat, Jun 03, 2023 at 10:21:50AM +0200, Willem de Bruijn wrote:
> On Fri, Jun 2, 2023 at 6:31 PM Breno Leitao <leitao@debian.org> wrote:
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Please check the checkpatch output
> 
> https://patchwork.hopto.org/static/nipa/753609/13265673/checkpatch/stdout

I am checking my current checkpatch before sending the patch, but I am
not seeing the problems above.

My tree is at 44c026a73be8038 ("Linux 6.4-rc3"), and I am not able to
reproduce the problems above.

	$ scripts/checkpatch.pl v5/v5-0001-net-ioctl-Use-kernel-memory-on-protocol-ioctl-cal.patch
	total: 0 errors, 0 warnings, 0 checks, 806 lines checked
	v5/v5-0001-net-ioctl-Use-kernel-memory-on-protocol-ioctl-cal.patch has no obvious style problems and is ready for submission.

Let me investigate what options I am missing when running checkpatch.

> > +/* A wrapper around sock ioctls, which copies the data from userspace
> > + * (depending on the protocol/ioctl), and copies back the result to userspace.
> > + * The main motivation for this function is to pass kernel memory to the
> > + * protocol ioctl callbacks, instead of userspace memory.
> > + */
> > +int sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
> > +{
> > +       int rc = 1;
> > +
> > +       if (sk_is_ipmr(sk))
> > +               rc = ipmr_sk_ioctl(sk, cmd, arg);
> > +       else if (sk_is_icmpv6(sk))
> > +               rc = ip6mr_sk_ioctl(sk, cmd, arg);
> > +       else if (sk_is_phonet(sk))
> > +               rc = phonet_sk_ioctl(sk, cmd, arg);
> 
> Does this handle all phonet ioctl cases correctly?
> 
> Notably pn_socket_ioctl has a SIOCPNGETOBJECT that reads and writes a u16.

We are not touching  "struct proto_ops" in this patch at all.  And
pn_socket_ioctl() is part of "struct proto_ops".

	const struct proto_ops phonet_stream_ops = {
		  ...
		  .ioctl          = pn_socket_ioctl,
	}

That said, all the "struct proto_ops" ioctl calls backs continue to use
"unsigned long arg" with userspace information, at least for now.

	struct proto_ops {
		...
		int             (*ioctl)     (struct socket *sock, unsigned int cmd,
					      unsigned long arg);
	}

This patch only changes the "struct proto".
