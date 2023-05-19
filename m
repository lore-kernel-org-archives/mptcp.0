Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98CD5670
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 15:19:16 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f420618d5bso21756475e9.1
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 08:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684509555; x=1687101555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/33/iB0K+c0HWtdDFSkvbCTsDDRyO08+huLchtgxtE=;
        b=PUJapjJE1C30arC3hMr+Fkuf810CYzWhh/kN9bc1QFOBUXldR1VvICOWf7W+U7VMcZ
         mq1iNshDQXMsncPrL8QkXNXxmJcy/kIlHMJJnnfTJA+ZRBtbNXSOiWCqxS61oxHsD1mv
         eXQ73/CTc+u9yoI0+VnHjCvsENOLfkWDRDmzsrNUZdY0YkjnuvKuKlQX/Jx3xltl7CO6
         Su3xe3kSImFDnCHd3JD03fupzpVAx+yY0XjfeCK97s4QOre5IFXZok0NQbGPoQhyafIF
         2Z093W2lN8a+wH1PIIFRCGjo8Y8gJ98GhfJp3did5jIBikcM2jp+2OPCIydBa2Wvxfs9
         TXDg==
X-Gm-Message-State: AC+VfDzBUs6Nay5dGFC+nPnvmlrmZXu01xodsO++BVsWGkgtiDSbEj0R
	9/CMkF+Y+NXw4bw8PjpWSXI=
X-Google-Smtp-Source: ACHHUZ6BmpF/4RnAMLexDbjQsWxHsSwUigYDxwCSz4SPCfVnF81LzxGpUTomUn+cen0pC9+XqccXSQ==
X-Received: by 2002:a7b:c454:0:b0:3f4:ecdc:5069 with SMTP id l20-20020a7bc454000000b003f4ecdc5069mr1646165wmi.33.1684509554782;
        Fri, 19 May 2023 08:19:14 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-004.fbsv.net. [2a03:2880:31ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id q16-20020a7bce90000000b003f4289b18a7sm2724354wmj.5.2023.05.19.08.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:19:14 -0700 (PDT)
Date: Fri, 19 May 2023 08:19:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: axboe@kernel.dk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
	courmisch@gmail.com, nhorman@tuxdriver.com, asml.silence@gmail.com,
	alex.aring@gmail.com, dccp@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, matthieu.baerts@tessares.net,
	marcelo.leitner@gmail.com, linux-wpan@vger.kernel.org,
	linux-sctp@vger.kernel.org, leit@fb.com, David.Laight@aculab.com,
	dsahern@kernel.org
Subject: Re: [PATCH 0/1] net: ioctl: Use kernel buffer on proto ioctl
 callbacks
Message-ID: <ZGeTbsnCZtkewPzu@gmail.com>
References: <20230519135821.922326-1-leitao@debian.org>
 <20230519081526.59411533@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519081526.59411533@kernel.org>

On Fri, May 19, 2023 at 08:15:26AM -0700, Jakub Kicinski wrote:
> On Fri, 19 May 2023 06:58:20 -0700 Breno Leitao wrote:
> > With the implementation of network ioctl on io_uring[1], Willem
> > suggested[2] that the "struct proto" ioctls functions should be reused,
> > instead of duplicating the code.
> > For that, the ioctl callbacks need to be more flexible, and avoid
> > operating on userspace buffers (doing get/put_user()) directly on the
> > callbacks. This patch adds this flexibility, so, the io_uring plumbing
> > becomes more clean, avoiding duplicating code. This may also benefit
> > BPF.
> > 
> > For that, a wrapper is created, which will copy from/to userspace, and
> > the ioctl callback will rely on the wrapper to do userspace memory
> > copies.
> > 
> > I've tested this patch in three different ways:
> > 1) Created a simple testcase for TCP/UDP [3]
> > 2) Run relevant LTP tests, such as: sockioctl, setsockopt, bind, sendto,
> > 				    fanout, ns-udpsender, etc
> > 3) Run basics network selftests
> > 
> > PS: There are some `strcmp()` in the `sock_skprot_ioctl()`, that I was
> > not able to find a better way to deal with it. Any feedback is
> > appreciated.
> 
> Why not CC netdev@ on this?

Oops, my mistake. I will do it on V2.
