Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED97F2F29
	for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 12:00:14 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id d9so7369548wrb.11
        for <mptcp@lists.linux.dev>; Tue, 11 Apr 2023 05:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681214413; x=1683806413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCeJQ8Y5The4MUdS/4f9gKqVtO4sNeOkKJxYqWcKYY0=;
        b=xuaXSQClIrHVq/KGXkOgSVTbDSmQOtNwg9qHfWekfwVKJehNVoEGJHK2IZWmVXhDHB
         qFy/5KqF8iRvJAOf4npSFdE8ub2dimk9Mf1buq8VpW3wKXbvBabxltkFkzD4aGzGYBUH
         ICmbkBcXBLGLMbrcHpJV/pjlk/AoJEWXoG9hU/dTjTVxWH9+Sgk50cc7/XpdlGuIdKw7
         H3Iwg1KztR5zAwxC8RavVANEwHCdhLItPAYQvrlhLRZ34iGYrHCKqXrZDKTQv78XxXfc
         z9/uyXY3xfcSdb65omJtPmyjviWuVq8ngFzxAh8ooLOTYycYnFuW8ZhCoh1lgzuP901/
         VOpw==
X-Gm-Message-State: AAQBX9eiQ9k6p5SmXjDIpI3O/9XfPBN2WC7Ccjg2PDSxB+/37Vek1uBg
	5OkdTuA8If5AfjedYsYbG10=
X-Google-Smtp-Source: AKy350YwPnDkYtmsUiWpDHZ3kyfoMSgnHSDhVmxZzEoLgVN4UZtcjS871jnCvl0D+BQ4jZjy1R7vxQ==
X-Received: by 2002:adf:fd81:0:b0:2ef:1088:1100 with SMTP id d1-20020adffd81000000b002ef10881100mr7411094wrr.52.1681214412737;
        Tue, 11 Apr 2023 05:00:12 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-026.fbsv.net. [2a03:2880:31ff:1a::face:b00c])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d4cc5000000b002f2794a6ee6sm3706526wrt.112.2023.04.11.05.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 05:00:12 -0700 (PDT)
Date: Tue, 11 Apr 2023 05:00:10 -0700
From: Breno Leitao <leitao@debian.org>
To: David Ahern <dsahern@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, io-uring@vger.kernel.org,
	netdev@vger.kernel.org, kuba@kernel.org, asml.silence@gmail.com,
	axboe@kernel.dk, leit@fb.com, edumazet@google.com,
	pabeni@redhat.com, davem@davemloft.net, dccp@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
	willemdebruijn.kernel@gmail.com, matthieu.baerts@tessares.net,
	marcelo.leitner@gmail.com
Subject: Re: [PATCH 0/5] add initial io_uring_cmd support for sockets
Message-ID: <ZDVLyi1PahE0sfci@gmail.com>
References: <20230406144330.1932798-1-leitao@debian.org>
 <CA+FuTSeKpOJVqcneCoh_4x4OuK1iE0Tr6f3rSNrQiR-OUgjWow@mail.gmail.com>
 <ZC7seVq7St6UnKjl@gmail.com>
 <CA+FuTSf9LEhzjBey_Nm_-vN0ZjvtBSQkcDWS+5uBnLmr8Qh5uA@mail.gmail.com>
 <e576f6fe-d1f3-93cd-cb94-c0ae115299d8@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e576f6fe-d1f3-93cd-cb94-c0ae115299d8@kernel.org>

On Thu, Apr 06, 2023 at 08:46:38PM -0600, David Ahern wrote:
> On 4/6/23 12:16 PM, Willem de Bruijn wrote:
> > On Thu, Apr 6, 2023 at 11:59 AM Breno Leitao <leitao@debian.org> wrote:
> >>
> >> On Thu, Apr 06, 2023 at 11:34:28AM -0400, Willem de Bruijn wrote:
> >>> On Thu, Apr 6, 2023 at 10:45 AM Breno Leitao <leitao@debian.org> wrote:
> >>>>
> >>>> From: Breno Leitao <leit@fb.com>
> >>>>
> >>>> This patchset creates the initial plumbing for a io_uring command for
> >>>> sockets.
> >>>>
> >>>> For now, create two uring commands for sockets, SOCKET_URING_OP_SIOCOUTQ
> >>>> and SOCKET_URING_OP_SIOCINQ. They are similar to ioctl operations
> >>>> SIOCOUTQ and SIOCINQ. In fact, the code on the protocol side itself is
> >>>> heavily based on the ioctl operations.
> >>>
> >>> This duplicates all the existing ioctl logic of each protocol.
> >>>
> >>> Can this just call the existing proto_ops.ioctl internally and translate from/to
> >>> io_uring format as needed?
> >>
> >> This is doable, and we have two options in this case:
> >>
> >> 1) Create a ioctl core function that does not call `put_user()`, and
> >> call it from both the `udp_ioctl` and `udp_uring_cmd`, doing the proper
> >> translations. Something as:
> >>
> >>         int udp_ioctl_core(struct sock *sk, int cmd, unsigned long arg)
> >>         {
> >>                 int amount;
> >>                 switch (cmd) {
> >>                 case SIOCOUTQ: {
> >>                         amount = sk_wmem_alloc_get(sk);
> >>                         break;
> >>                 }
> >>                 case SIOCINQ: {
> >>                         amount = max_t(int, 0, first_packet_length(sk));
> >>                         break;
> >>                 }
> >>                 default:
> >>                         return -ENOIOCTLCMD;
> >>                 }
> >>                 return amount;
> >>         }
> >>
> >>         int udp_ioctl(struct sock *sk, int cmd, unsigned long arg)
> >>         {
> >>                 int amount = udp_ioctl_core(sk, cmd, arg);
> >>
> >>                 return put_user(amount, (int __user *)arg);
> >>         }
> >>         EXPORT_SYMBOL(udp_ioctl);
> >>
> >>
> >> 2) Create a function for each "case entry". This seems a bit silly for
> >> UDP, but it makes more sense for other protocols. The code will look
> >> something like:
> >>
> >>          int udp_ioctl(struct sock *sk, int cmd, unsigned long arg)
> >>          {
> >>                 switch (cmd) {
> >>                 case SIOCOUTQ:
> >>                 {
> >>                         int amount = udp_ioctl_siocoutq();
> >>                         return put_user(amount, (int __user *)arg);
> >>                 }
> >>                 ...
> >>           }
> >>
> >> What is the best approach?
> > 
> > A, the issue is that sock->ops->ioctl directly call put_user.
> > 
> > I was thinking just having sock_uring_cmd call sock->ops->ioctl, like
> > sock_do_ioctl.
> > 
> > But that would require those callbacks to return a negative error or
> > positive integer, rather than calling put_user. And then move the
> > put_user to sock_do_ioctl. Such a change is at least as much code
> > change as your series. Though without the ending up with code
> > duplication. It also works only if all ioctls only put_user of integer
> > size. That's true for TCP, UDP and RAW, but not sure if true more
> > broadly.
> > 
> > Another approach may be to pass another argument to the ioctl
> > callbacks, whether to call put_user or return the integer and let the
> > caller take care of the output to user. This could possibly be
> > embedded in the a high-order bit of the cmd, so that it fails on ioctl
> > callbacks that do not support this mode.
> > 
> > Of the two approaches you suggest, I find the first preferable.
> 
> The first approach sounds better to me and it would be good to avoid
> io_uring details in the networking code (ie., cmd->sqe->cmd_op).

I am not sure if avoiding io_uring details in network code is possible.

The "struct proto"->uring_cmd callback implementation (tcp_uring_cmd()
in the TCP case) could be somewhere else, such as in the io_uring/
directory, but, I think it might be cleaner if these implementations are
closer to function assignment (in the network subsystem).

And this function (tcp_uring_cmd() for instance) is the one that I am
planning to map io_uring CMDs to ioctls. Such as SOCKET_URING_OP_SIOCINQ
-> SIOCINQ.

Please let me know if you have any other idea in mind.
