Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80E07F
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 00:02:35 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id j16so88898wms.0
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 17:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681344154; x=1683936154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnTbuQLS+s98EOJFfwv3Ba/ON2eWwogZsizkDywlsTM=;
        b=L+3Nzzw+uEMflR8QIg9tJgiIplopNhVt7ZWInfzT2hoTHM/VS5M/cTLG0o3gCroyQW
         dWb7hmT+nRvcVdnuc3g+2GZBgMk1ccDQMOfVI1CgVFSisKocINS7BxZORDwxgugsrGtO
         fxNbl7Zv/NN88MNmxWxR6Y1CQqNkYtwx+cc6o+UymiRf+gtsHXozDlibSM9nOQ7IeGRN
         V83S714yumJtO8QeXX5Cf25pV7nfNOAY971lr6EBk5Sw9+Bv5htSujvyy8/kXlz83mi6
         Z/hJhHLpzp6NepsOB2ANMBr1jnt4fz7TFpo1rk9WZKOCYPypkgsi3rXKpesFsOsq6maz
         9Oxg==
X-Gm-Message-State: AAQBX9eo8yBiH5Axa+OJAynG/SVLxolCHM/Rqc8aRJ0yL3zccFl4mdW2
	Px3Af5a0L3oXH2A7x1vsyVc=
X-Google-Smtp-Source: AKy350bg7BOELuRvy/75oi6gDnbsLIrWQAvVymztmZ8D7/qU45W4+GLiVPq3yXBM3QmSWtXbHnGuXA==
X-Received: by 2002:a1c:6a14:0:b0:3e1:f8af:8772 with SMTP id f20-20020a1c6a14000000b003e1f8af8772mr322031wmc.9.1681344153925;
        Wed, 12 Apr 2023 17:02:33 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-031.fbsv.net. [2a03:2880:31ff:1f::face:b00c])
        by smtp.gmail.com with ESMTPSA id g5-20020a7bc4c5000000b003ee10fb56ebsm323679wmk.9.2023.04.12.17.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 17:02:33 -0700 (PDT)
Date: Wed, 12 Apr 2023 17:02:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>, io-uring@vger.kernel.org,
	netdev@vger.kernel.org, kuba@kernel.org, asml.silence@gmail.com,
	leit@fb.com, edumazet@google.com, pabeni@redhat.com,
	davem@davemloft.net, dccp@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, matthieu.baerts@tessares.net,
	marcelo.leitner@gmail.com
Subject: Re: [PATCH 0/5] add initial io_uring_cmd support for sockets
Message-ID: <ZDdGl/JGDoRDL8ja@gmail.com>
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
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6436c01979c9b_163b6294b4@willemb.c.googlers.com.notmuch>

On Wed, Apr 12, 2023 at 10:28:41AM -0400, Willem de Bruijn wrote:
> Breno Leitao wrote:
> > On Tue, Apr 11, 2023 at 09:28:29AM -0600, Jens Axboe wrote:
> > > On 4/11/23 9:24?AM, Willem de Bruijn wrote:
> > > > Jens Axboe wrote:
> > > >> On 4/11/23 9:00?AM, Willem de Bruijn wrote:
> > > >> But that doesn't work, because sock->ops->ioctl() assumes the arg is
> > > >> memory in userspace. Or do you mean change all of the sock->ops->ioctl()
> > > >> to pass in on-stack memory (or similar) and have it work with a kernel
> > > >> address?
> > > > 
> > > > That was what I suggested indeed.
> > > > 
> > > > It's about as much code change as this patch series. But it avoids
> > > > the code duplication.
> > > 
> > > Breno, want to tackle that as a prep patch first? Should make the
> > > functional changes afterwards much more straightforward, and will allow
> > > support for anything really.
> > 
> > Absolutely. I just want to make sure that I got the proper approach that
> > we agreed here.
> > 
> > Let me explain what I understood taking TCP as an example:
> > 
> > 1) Rename tcp_ioctl() to something as _tcp_ioctl() where the 'arg'
> > argument is now just a kernel memory (located in the stack frame from the
> > callee).
> > 
> > 2) Recreate "tcp_ioctl()" that will basically allocate a 'arg' in the
> > stack and call _tcp_ioctl() passing that 'arg' argument. At the bottom of
> > this (tcp_ioctl() function) function, call `put_user(in_kernel_arg, userspace_arg)
> > 
> > 3) Repeat it for the 20 protocols that implement ioctl:
> > 
> > 	ag  "struct proto .* = {" -A 20 net/ | grep \.ioctl
> > 	net/dccp/ipv6.c 	.ioctl	= dccp_ioctl,
> > 	net/dccp/ipv4.c		.ioctl	= dccp_ioctl,
> > 	net/ieee802154/socket.c .ioctl	= dgram_ioctl,
> > 	net/ipv4/udplite.c	.ioctl	= udp_ioctl,
> > 	net/ipv4/raw.c 		.ioctl	= raw_ioctl,
> > 	net/ipv4/udp.c		.ioctl	= udp_ioctl,
> > 	net/ipv4/tcp_ipv4.c 	.ioctl	= tcp_ioctl,
> > 	net/ipv6/raw.c		.ioctl	= rawv6_ioctl,
> > 	net/ipv6/tcp_ipv6.c	.ioctl	= tcp_ioctl,
> > 	net/ipv6/udp.c	 	.ioctl	= udp_ioctl,
> > 	net/ipv6/udplite.c	.ioctl	= udp_ioctl,
> > 	net/l2tp/l2tp_ip6.c	.ioctl	= l2tp_ioctl,
> > 	net/l2tp/l2tp_ip.c	.ioctl	= l2tp_ioctl,
> > 	net/phonet/datagram.:	.ioctl	= pn_ioctl,
> > 	net/phonet/pep.c	.ioctl	= pep_ioctl,
> > 	net/rds/af_rds.c	.ioctl	=	rds_ioctl,
> > 	net/sctp/socket.c	.ioctl  =	sctp_ioctl,
> > 	net/sctp/socket.c	.ioctl	= sctp_ioctl,
> > 	net/xdp/xsk.c		.ioctl	= sock_no_ioctl,
> > 	net/mptcp/protocol.c	.ioctl	= mptcp_ioctl,
> > 
> > Am I missing something?
> 
> The suggestion is to convert all to take kernel memory and do the
> put_cmsg in the caller of .ioctl. Rather than create a wrapper for
> each individual instance and add a separate .iouring_cmd for each.
> 
> "change all of the sock->ops->ioctl() to pass in on-stack memory
> (or similar) and have it work with a kernel address"

is it possible to do it for cases where we don't know what is the size
of the buffer?

For instance the raw_ioctl()/rawv6_ioctl() case. The "arg" argument is
used in different ways (one for input and one for output):

  1) If cmd == SIOCOUTQ or SIOCINQ, then the return value will be
  returned to userspace:
  	put_user(amount, (int __user *)arg)

  2) For default cmd, ipmr_ioctl() is called, which reads from the `arg`
  parameter:
	copy_from_user(&vr, arg, sizeof(vr)

How to handle these contradictory behaviour ahead of time (at callee
time, where the buffers will be prepared)?

Thank you!
