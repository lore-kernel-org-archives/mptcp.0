Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD92290D
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 13:23:23 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id ay3-20020a05600c1e0300b003f17289710aso3454352wmb.5
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 06:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681824202; x=1684416202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqDTiBrLhR5sXi2E8N9oFKAY2YSWIckMsITGVR/waa8=;
        b=DT1cHbx6Z5DWF/QAIXBWkQPctDNS+DO4uuGRWkmeDbYM1kgnDh+TFCVnsDzJmnUd9A
         AacES0rfRP9hmOtxVC0NbNTCf2vLXJ1/k8KhL/VlKMZBqrFFa9dInK/GHlXaM75hkOZF
         LNQopfp9XLB8Wf31o4KOlyDbpOolc2JHUljdbH7U7XAiDhVYoY38/BXKfKm4JCoip4Tj
         bE6lk9WZDXkj1NbJjvew+PNSyqUz/0DFMbOteWoPd64gsWK7IdVr6mEuJqFGFhO6UtE7
         ZzBv+snJFDZOG2KEHgzAqcSYkm6VB0rrYU3uvxWui8z7dHWzpmai3MU4a6yG1ZkyC9vN
         kxiA==
X-Gm-Message-State: AAQBX9dVWDImRKXAmqSmolHOY15aubGKvvAT//KpL7vhe3cZ5PWjlgwc
	sI+zLUwe1dt36dJsBuo2/DU=
X-Google-Smtp-Source: AKy350biM8WVl/eiJ3HJWtyNS4ItBlVWJWh5hXYnArsamS9vCseDF+MBoa17egcF/lf5BoWPjkLgfQ==
X-Received: by 2002:a7b:c7c9:0:b0:3f1:6ecf:537 with SMTP id z9-20020a7bc7c9000000b003f16ecf0537mr7723437wmk.33.1681824201624;
        Tue, 18 Apr 2023 06:23:21 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-119.fbsv.net. [2a03:2880:31ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003ede3f5c81fsm18725760wmq.41.2023.04.18.06.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 06:23:20 -0700 (PDT)
Date: Tue, 18 Apr 2023 06:23:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, kuba@kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>, io-uring@vger.kernel.org,
	netdev@vger.kernel.org, kuba@kernel.org, asml.silence@gmail.com,
	leit@fb.com, edumazet@google.com, pabeni@redhat.com,
	davem@davemloft.net, dccp@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, matthieu.baerts@tessares.net,
	marcelo.leitner@gmail.com
Subject: Re: [PATCH 0/5] add initial io_uring_cmd support for sockets
Message-ID: <ZD6Zw1GAZR28++3v@gmail.com>
References: <643573df81e20_11117c2942@willemb.c.googlers.com.notmuch>
 <036c80e5-4844-5c84-304c-7e553fe17a9b@kernel.dk>
 <64357608c396d_113ebd294ba@willemb.c.googlers.com.notmuch>
 <19c69021-dce3-1a4a-00eb-920d1f404cfc@kernel.dk>
 <64357bb97fb19_114b22294c4@willemb.c.googlers.com.notmuch>
 <20cb4641-c765-e5ef-41cb-252be7721ce5@kernel.dk>
 <ZDa32u9RNI4NQ7Ko@gmail.com>
 <6436c01979c9b_163b6294b4@willemb.c.googlers.com.notmuch>
 <ZDdGl/JGDoRDL8ja@gmail.com>
 <6438109fe8733_13361929472@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6438109fe8733_13361929472@willemb.c.googlers.com.notmuch>

On Thu, Apr 13, 2023 at 10:24:31AM -0400, Willem de Bruijn wrote:
> > How to handle these contradictory behaviour ahead of time (at callee
> > time, where the buffers will be prepared)?
> 
> Ah you found a counter-example to the simple pattern of put_user.
> 
> The answer perhaps depends on how many such counter-examples you
> encounter in the list you gave. If this is the only one, exceptions
> in the wrapper are reasonable. Not if there are many.


Hello Williem,

I spend sometime dealing with it, and the best way for me to figure out
how much work this is, was implementing a PoC. You can find a basic PoC
in the link below. It is not 100% complete (still need to convert 4
simple ioctls), but, it deals with the most complicated cases. The
missing parts are straighforward if we are OK with this approach.

	https://github.com/leitao/linux/commits/ioctl_refactor

Details
=======

1)  Change the ioctl callback to use kernel memory arguments. This
changes a lot of files but most of them are trivial. This is the new
ioctl callback:

struct proto {

        int                     (*ioctl)(struct sock *sk, int cmd,
-                                        unsigned long arg);
+                                        int *karg);

	You can see the full changeset in the following commit (which is
	the last in the tree above)
	https://github.com/leitao/linux/commit/ad78da14601b078c4b6a9f63a86032467ab59bf7

2) Create a wrapper (sock_skprot_ioctl()) that should be called instead
of sk->sk_prot->ioctl(). For every exception, calls a specific function
for the exception (basically ipmr_ioctl and ipmr_ioctl) (see more on 3)

	This is the commit https://github.com/leitao/linux/commit/511592e549c39ef0de19efa2eb4382cac5786227

3) There are two exceptions, they are ip{6}mr_ioctl() and pn_ioctl().
ip{6}mr is the hardest one, and I implemented the exception flow for it.

	You could find ipmr changes here:
	https://github.com/leitao/linux/commit/659a76dc0547ab2170023f31e20115520ebe33d9

Is this what you had in mind?

Thank you!
