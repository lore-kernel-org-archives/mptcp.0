Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DA8F53
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 15:59:59 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so24002519wms.1
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 08:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680796798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1p3sMZGCpasiT36OJM5hrl8J9R7XCrsn2b25UqN7umA=;
        b=qrk3CzGXQYorkrMTQdiqWXgVBDS0J/JFUKdNhfkQ+9rGCM58RbEbjp7zg8/W185T75
         d8GSSliSl8bKKxXhOyisckdLLiOA9IdRIPQVQ16iidKx1+cEoOpzkzo2BFENBManC9gK
         6xY8gjbOVbxxL9LL7kH/5vXID6/Ss7zSkVsMqAWkRqSw2ciA6VTsSqEzYpR3UBr9FFbR
         iRp6TzScYm3cYAtGHeeV8xHE0geH+6hc4MQiVrHaq9Az9uODY7fAUrzcyYAlkbEyfzV5
         ZwVudY1zWAhDwU7djZF9Jmz4AOBkBsVI0SXumlFf7Af+8lWK9U792HgTCOIt0rsmNq0Z
         awfQ==
X-Gm-Message-State: AAQBX9ey97YejqVHTsylYjW0wM6FWk6yitiHcE9MrqOkb+oQ7U/dgOVf
	fBorZBjvAg7hoXDkNEw9OwA=
X-Google-Smtp-Source: AKy350Y9Ny/WkQqGWNqorb2OhpFmtDZ2MMXftYinGLVZrJI6LcJbl/jbnq3d72gl5fbQMCKjRQ0B5Q==
X-Received: by 2002:a05:600c:22d6:b0:3eb:2da5:e19 with SMTP id 22-20020a05600c22d600b003eb2da50e19mr7649653wmg.27.1680796798137;
        Thu, 06 Apr 2023 08:59:58 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc858000000b003ef5b011b30sm2007207wml.8.2023.04.06.08.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:59:57 -0700 (PDT)
Date: Thu, 6 Apr 2023 08:59:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemb@google.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
	asml.silence@gmail.com, axboe@kernel.dk, leit@fb.com,
	edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
	dccp@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com, matthieu.baerts@tessares.net,
	marcelo.leitner@gmail.com
Subject: Re: [PATCH 0/5] add initial io_uring_cmd support for sockets
Message-ID: <ZC7seVq7St6UnKjl@gmail.com>
References: <20230406144330.1932798-1-leitao@debian.org>
 <CA+FuTSeKpOJVqcneCoh_4x4OuK1iE0Tr6f3rSNrQiR-OUgjWow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+FuTSeKpOJVqcneCoh_4x4OuK1iE0Tr6f3rSNrQiR-OUgjWow@mail.gmail.com>

On Thu, Apr 06, 2023 at 11:34:28AM -0400, Willem de Bruijn wrote:
> On Thu, Apr 6, 2023 at 10:45 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > From: Breno Leitao <leit@fb.com>
> >
> > This patchset creates the initial plumbing for a io_uring command for
> > sockets.
> >
> > For now, create two uring commands for sockets, SOCKET_URING_OP_SIOCOUTQ
> > and SOCKET_URING_OP_SIOCINQ. They are similar to ioctl operations
> > SIOCOUTQ and SIOCINQ. In fact, the code on the protocol side itself is
> > heavily based on the ioctl operations.
> 
> This duplicates all the existing ioctl logic of each protocol.
> 
> Can this just call the existing proto_ops.ioctl internally and translate from/to
> io_uring format as needed?

This is doable, and we have two options in this case:

1) Create a ioctl core function that does not call `put_user()`, and
call it from both the `udp_ioctl` and `udp_uring_cmd`, doing the proper
translations. Something as:

	int udp_ioctl_core(struct sock *sk, int cmd, unsigned long arg)
	{
		int amount;
		switch (cmd) {
		case SIOCOUTQ: {
			amount = sk_wmem_alloc_get(sk);
			break;
		}
		case SIOCINQ: {
			amount = max_t(int, 0, first_packet_length(sk));
			break;
		}
		default:
			return -ENOIOCTLCMD;
		}
		return amount;
	}

	int udp_ioctl(struct sock *sk, int cmd, unsigned long arg)
	{
		int amount = udp_ioctl_core(sk, cmd, arg);

		return put_user(amount, (int __user *)arg);
	}
	EXPORT_SYMBOL(udp_ioctl);


2) Create a function for each "case entry". This seems a bit silly for
UDP, but it makes more sense for other protocols. The code will look
something like:

	 int udp_ioctl(struct sock *sk, int cmd, unsigned long arg)
	 {
		switch (cmd) {
		case SIOCOUTQ:
		{
			int amount = udp_ioctl_siocoutq();
			return put_user(amount, (int __user *)arg);
		}
		...
	  }

What is the best approach?

