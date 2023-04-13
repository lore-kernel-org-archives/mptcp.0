Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2AA92A
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 14:24:33 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id gb12so13426521qtb.6
        for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681395873; x=1683987873;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TrAOS0R5wy2ok/bqex9Gh2UkGvuG1Z9xkGn7BQOOkQ=;
        b=b/ViUDzfSWs5SNJEDqJz6GRAGG5jpNDZbGdhDRdKGT0RWMPR7qgzc15mS4W/ggmnyg
         p8S3AXLq6hpuKneYCVqCJb63LoikUs9JgZ2iSg/q/p+8p/hQ8uZ0MZ1t63JBR1mhS+Ow
         s/P8ZpN8nQd+pRg75ZFN36HUBc7+9wcxuprDugkLijOVVbbkLBQ/Ll4yg2BdwQ63q5bP
         hRnEb/+7AtAOHAHhgMHlkQ4TCel7v3t+rnFtKqqyX3EZ9PLYZUEjvbqrRo2ng3R1QwXq
         ItyMUESW1xzSCkDQuXSupBgujX4h35O3Bo+fmkAExiiXU7whjjyuYuk/tfT8FzljppKh
         Dftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681395873; x=1683987873;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/TrAOS0R5wy2ok/bqex9Gh2UkGvuG1Z9xkGn7BQOOkQ=;
        b=kjKPjoJQ7qAkBlH9gW2CS/+fOtio1/6BGLrgVZboUoSg7sgK7h5C7OoVDw4q8F00/H
         IuRCPrieuU3cAgpYzMQ32cNkgtOwxeX7PixwfEXvWS1iTwxtHAAqnLMxcdbYBByHOB/s
         CFLQ1zpiL+eX3MhO3Ajq+pwKOcDyNqM5Fuy336pDEXIvQUIAnwYaL0i/IMpTltNWxaDr
         unErz+n0wk/HgL8Wn2ubu7CMNCIujHzZEML2ivcIuiXKX74dZJxYsaRAYcTO6b/1gEpl
         m8GYTJXOHwxTbSJVuNmGnJ86JH9bsS+zuB8Id0DyM6RZ0Fb48OdvJ1UB0hzyU53ELAly
         yfVA==
X-Gm-Message-State: AAQBX9e5Q12hr/50/lognhadPCgEnNg/ROEkfqnXxKUitDEiUSvZ1X6t
	nof4d43WY1ypAB2FX0X9LnY=
X-Google-Smtp-Source: AKy350ZRTDu+Bd0TWjR0pjk1viq+nedbiyuO15GH/Y/6TJSTI8W79X1HEf7NRwtm3vKsuOfmgLCIWw==
X-Received: by 2002:a05:622a:5:b0:3bf:b70b:7804 with SMTP id x5-20020a05622a000500b003bfb70b7804mr3244755qtw.25.1681395872712;
        Thu, 13 Apr 2023 07:24:32 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id t17-20020a05622a181100b003e3982a6f2bsm524147qtc.18.2023.04.13.07.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 07:24:32 -0700 (PDT)
Date: Thu, 13 Apr 2023 10:24:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, 
 David Ahern <dsahern@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 io-uring@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kuba@kernel.org, 
 asml.silence@gmail.com, 
 leit@fb.com, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 davem@davemloft.net, 
 dccp@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 matthieu.baerts@tessares.net, 
 marcelo.leitner@gmail.com
Message-ID: <6438109fe8733_13361929472@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZDdGl/JGDoRDL8ja@gmail.com>
References: <75e3c434-eb8b-66e5-5768-ca0f906979a1@kernel.org>
 <67831406-8d2f-feff-f56b-d0f002a95d96@kernel.dk>
 <643573df81e20_11117c2942@willemb.c.googlers.com.notmuch>
 <036c80e5-4844-5c84-304c-7e553fe17a9b@kernel.dk>
 <64357608c396d_113ebd294ba@willemb.c.googlers.com.notmuch>
 <19c69021-dce3-1a4a-00eb-920d1f404cfc@kernel.dk>
 <64357bb97fb19_114b22294c4@willemb.c.googlers.com.notmuch>
 <20cb4641-c765-e5ef-41cb-252be7721ce5@kernel.dk>
 <ZDa32u9RNI4NQ7Ko@gmail.com>
 <6436c01979c9b_163b6294b4@willemb.c.googlers.com.notmuch>
 <ZDdGl/JGDoRDL8ja@gmail.com>
Subject: Re: [PATCH 0/5] add initial io_uring_cmd support for sockets
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> On Wed, Apr 12, 2023 at 10:28:41AM -0400, Willem de Bruijn wrote:
> > Breno Leitao wrote:
> > > On Tue, Apr 11, 2023 at 09:28:29AM -0600, Jens Axboe wrote:
> > > > On 4/11/23 9:24?AM, Willem de Bruijn wrote:
> > > > > Jens Axboe wrote:
> > > > >> On 4/11/23 9:00?AM, Willem de Bruijn wrote:
> > > > >> But that doesn't work, because sock->ops->ioctl() assumes the arg is
> > > > >> memory in userspace. Or do you mean change all of the sock->ops->ioctl()
> > > > >> to pass in on-stack memory (or similar) and have it work with a kernel
> > > > >> address?
> > > > > 
> > > > > That was what I suggested indeed.
> > > > > 
> > > > > It's about as much code change as this patch series. But it avoids
> > > > > the code duplication.
> > > > 
> > > > Breno, want to tackle that as a prep patch first? Should make the
> > > > functional changes afterwards much more straightforward, and will allow
> > > > support for anything really.
> > > 
> > > Absolutely. I just want to make sure that I got the proper approach that
> > > we agreed here.
> > > 
> > > Let me explain what I understood taking TCP as an example:
> > > 
> > > 1) Rename tcp_ioctl() to something as _tcp_ioctl() where the 'arg'
> > > argument is now just a kernel memory (located in the stack frame from the
> > > callee).
> > > 
> > > 2) Recreate "tcp_ioctl()" that will basically allocate a 'arg' in the
> > > stack and call _tcp_ioctl() passing that 'arg' argument. At the bottom of
> > > this (tcp_ioctl() function) function, call `put_user(in_kernel_arg, userspace_arg)
> > > 
> > > 3) Repeat it for the 20 protocols that implement ioctl:
> > > 
> > > 	ag  "struct proto .* = {" -A 20 net/ | grep \.ioctl
> > > 	net/dccp/ipv6.c 	.ioctl	= dccp_ioctl,
> > > 	net/dccp/ipv4.c		.ioctl	= dccp_ioctl,
> > > 	net/ieee802154/socket.c .ioctl	= dgram_ioctl,
> > > 	net/ipv4/udplite.c	.ioctl	= udp_ioctl,
> > > 	net/ipv4/raw.c 		.ioctl	= raw_ioctl,
> > > 	net/ipv4/udp.c		.ioctl	= udp_ioctl,
> > > 	net/ipv4/tcp_ipv4.c 	.ioctl	= tcp_ioctl,
> > > 	net/ipv6/raw.c		.ioctl	= rawv6_ioctl,
> > > 	net/ipv6/tcp_ipv6.c	.ioctl	= tcp_ioctl,
> > > 	net/ipv6/udp.c	 	.ioctl	= udp_ioctl,
> > > 	net/ipv6/udplite.c	.ioctl	= udp_ioctl,
> > > 	net/l2tp/l2tp_ip6.c	.ioctl	= l2tp_ioctl,
> > > 	net/l2tp/l2tp_ip.c	.ioctl	= l2tp_ioctl,
> > > 	net/phonet/datagram.:	.ioctl	= pn_ioctl,
> > > 	net/phonet/pep.c	.ioctl	= pep_ioctl,
> > > 	net/rds/af_rds.c	.ioctl	=	rds_ioctl,
> > > 	net/sctp/socket.c	.ioctl  =	sctp_ioctl,
> > > 	net/sctp/socket.c	.ioctl	= sctp_ioctl,
> > > 	net/xdp/xsk.c		.ioctl	= sock_no_ioctl,
> > > 	net/mptcp/protocol.c	.ioctl	= mptcp_ioctl,
> > > 
> > > Am I missing something?
> > 
> > The suggestion is to convert all to take kernel memory and do the
> > put_cmsg in the caller of .ioctl. Rather than create a wrapper for
> > each individual instance and add a separate .iouring_cmd for each.
> > 
> > "change all of the sock->ops->ioctl() to pass in on-stack memory
> > (or similar) and have it work with a kernel address"
> 
> is it possible to do it for cases where we don't know what is the size
> of the buffer?
> 
> For instance the raw_ioctl()/rawv6_ioctl() case. The "arg" argument is
> used in different ways (one for input and one for output):
> 
>   1) If cmd == SIOCOUTQ or SIOCINQ, then the return value will be
>   returned to userspace:
>   	put_user(amount, (int __user *)arg)
> 
>   2) For default cmd, ipmr_ioctl() is called, which reads from the `arg`
>   parameter:
> 	copy_from_user(&vr, arg, sizeof(vr)
> 
> How to handle these contradictory behaviour ahead of time (at callee
> time, where the buffers will be prepared)?
> 
> Thank you!

Ah you found a counter-example to the simple pattern of put_user.

The answer perhaps depends on how many such counter-examples you
encounter in the list you gave. If this is the only one, exceptions
in the wrapper are reasonable. Not if there are many.

Is the intent for io_uring to support all cases eventually? The
current patch series only targeted more common fast path operations.

Probably also relevant is whether/how the approach can be extended
to [gs]etsockopt, as that was another example given, with the same
challenge.
