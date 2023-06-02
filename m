Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C61C750
	for <mptcp@lists.linux.dev>; Fri,  2 Jun 2023 16:19:11 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso22906885e9.0
        for <mptcp@lists.linux.dev>; Fri, 02 Jun 2023 09:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722749; x=1688314749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Df45G13freHV7qKaooKW3cbNcYiTjIevZWnDBJV0Ngs=;
        b=Kg1OrGPPVuqAiQED6Zqc3bIxXkBuDlqGwnSoEBB2TSIQXt0360FQ7gTMoq4G+99SIc
         aAnF4ADPfIU4A6Tx0kha/gVgnuMJjR1WzbWmD1kFniMicSdx9gLfZ2ae2W1SvUw/AXic
         zUVCxrysTS+bzE4JO39AEDkx7nki9bj2RrcsE2eLJB7wkX1y/3ArcWFMVcBC0Seq60HE
         TWt39L203nN37x/0EqnRJtSqCgqgIprsJmxIILM61aLpClnrxZzSIuMUsWfqgmPh/o6s
         vM3oOvuHn7OojIBgc1snThY9fktpak6Rx5oeGi+QKtrK7MbkHVQgPdCSTBbM+z7orWWN
         vSOg==
X-Gm-Message-State: AC+VfDzD76o/y3pRpyypN0iNhbemLqOy9mVFjiOxju3U/gTICnx1e/8W
	YDAUikGSFBVKstiu6lBYRmQ=
X-Google-Smtp-Source: ACHHUZ7V6s1LqVdQdevjsk3RKa1VPwpouEu01j6+gnTKwWbWp9RyusXrlmogJW9nb4M2BtQB8hHwHg==
X-Received: by 2002:a5d:65c2:0:b0:30a:dfb4:e300 with SMTP id e2-20020a5d65c2000000b0030adfb4e300mr389381wrw.28.1685722749158;
        Fri, 02 Jun 2023 09:19:09 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d4282000000b003047ea78b42sm2075225wrq.43.2023.06.02.09.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 09:19:08 -0700 (PDT)
Date: Fri, 2 Jun 2023 09:19:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: dsahern@kernel.org, Remi Denis-Courmont <courmisch@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, leit@fb.com, axboe@kernel.dk,
	asml.silence@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, dccp@vger.kernel.org,
	linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
	linux-sctp@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
Message-ID: <ZHoWeiDVoLV1VMpT@gmail.com>
References: <20230530175403.2434218-1-leitao@debian.org>
 <6476f0e4b0182_3c8862294b2@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6476f0e4b0182_3c8862294b2@willemb.c.googlers.com.notmuch>

On Wed, May 31, 2023 at 03:01:56AM -0400, Willem de Bruijn wrote:
> Breno Leitao wrote:
> > +int ip6mr_sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg);
> > +static inline int sk_is_ip6mr(struct sock *sk)
> > +{
> > +	return sk->sk_family == AF_INET6 &&
> > +		inet_sk(sk)->inet_num == IPPROTO_ICMPV6;
> > +}
 
> Technically, this is just sk_is_icmpv6, which is broader than IPv6
> multicast routing.

Right, let me rename it to reflect this properly.

> No other concerns from me.

Thanks for the detailed review.

> Two small asides, that are fine to ignore.
> 
> The $PROTO_sk_ioctl functions could conceivably call directly into
> the $PROTO_ioctl functions without the indirect function pointer.
> But that would require open coding the sock_sk_ioctl_inout helpers.
> 
> The demux now first checks relatively unlikely multicast routing
> and phonet before falling through to the more common protocols. But
> ioctl is not a hot path operation.

I am more than happy to open code sock_sk_ioctl_inout into protocol
functions, but, I would prefer to do it in a follow up patch, since this
one is close (I hope) to address the original problem. I hope it works
for you.

Thanks!
