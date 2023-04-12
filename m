Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFCC611A
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 14:28:43 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id cm23so2870253qtb.3
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681309722; x=1683901722;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3csUU+MZIL4psk3MHBw1EHOXxochpb77aPV46ZLfuc=;
        b=aI6Q+2c2WaaTUQarPujC9vC4U+H06kMJ1qHxGql7eaQVoNPr4VI6/vTF20Gq0LrCOd
         JUDyMJIC+/nGqr4gtxOQDYTlG2rqjsjPSXCJYVDyNnU7/visH6dzicAcsw917ORO/PW+
         B+kYVJaEtQZ45dAnLsOgIl9PZq6Zz8f7E5ziG10GSCSsba7CEp8sJDNhd9m92KhZoJMd
         +CEN2d4h/EVQRnzpA5ZyXzrN/4q9QwRHGNJXRrCpW0MUpzEmo2oEht0vdZE92tU7+cew
         0TtCqPXhwtAvPD1w+obFG/+LpXEfiMk9/oSZ3bZaBHgysbET3Mze4e+lQ9YDtaTuv2Bo
         Kt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681309722; x=1683901722;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3csUU+MZIL4psk3MHBw1EHOXxochpb77aPV46ZLfuc=;
        b=if0O5gzIQBTvu84zBGpgM6/cdJTezZN9d1oAVVL1zlqJzjtckU29NlTMrVYcHBLCi/
         nvYy5LPByOAVqjU64FMa2iU4SOabUMUWDUr0V4LjTYJDcuK7SBEpqo6W7PA0znJ7SvX6
         Iq6WgM4xCSsujP+6LmNDqrQAHIlAtZJh3VjSF7G5ARs2wx2nczai9gc/P0xwqlZ5lHur
         YyBLkTjZXZi8QEcm2NHzZbQHp6Om/sF6Pu3UqXBcxFh5wvLuycsfYpfe5GMR5quRo2TC
         qJbRzsXUaTOaCPUdSHG3W9JIgZkL/trwkVIQiwq6RYIir6ykg7B/HSQ+fExi9Xb4e3B5
         tX/w==
X-Gm-Message-State: AAQBX9eC0sttAVPiDtMF0WgoNMee8y0fxYHZybpWSp/O01wSp+ik6inW
	j3UZh2sbZOVHBxHP09MXAkU=
X-Google-Smtp-Source: AKy350Y9tE06l148YDTVFtOEKyW0JshhF+aM8qF7BkYMcr6VkzIdVIBtB5Ltrqx2TDstNnLe4jBZWQ==
X-Received: by 2002:a05:622a:14e:b0:3e3:3941:d167 with SMTP id v14-20020a05622a014e00b003e33941d167mr29755868qtw.34.1681309722274;
        Wed, 12 Apr 2023 07:28:42 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id t12-20020a37aa0c000000b007468b183a65sm257126qke.30.2023.04.12.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:28:41 -0700 (PDT)
Date: Wed, 12 Apr 2023 10:28:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
Message-ID: <6436c01979c9b_163b6294b4@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZDa32u9RNI4NQ7Ko@gmail.com>
References: <e576f6fe-d1f3-93cd-cb94-c0ae115299d8@kernel.org>
 <ZDVLyi1PahE0sfci@gmail.com>
 <75e3c434-eb8b-66e5-5768-ca0f906979a1@kernel.org>
 <67831406-8d2f-feff-f56b-d0f002a95d96@kernel.dk>
 <643573df81e20_11117c2942@willemb.c.googlers.com.notmuch>
 <036c80e5-4844-5c84-304c-7e553fe17a9b@kernel.dk>
 <64357608c396d_113ebd294ba@willemb.c.googlers.com.notmuch>
 <19c69021-dce3-1a4a-00eb-920d1f404cfc@kernel.dk>
 <64357bb97fb19_114b22294c4@willemb.c.googlers.com.notmuch>
 <20cb4641-c765-e5ef-41cb-252be7721ce5@kernel.dk>
 <ZDa32u9RNI4NQ7Ko@gmail.com>
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
> On Tue, Apr 11, 2023 at 09:28:29AM -0600, Jens Axboe wrote:
> > On 4/11/23 9:24?AM, Willem de Bruijn wrote:
> > > Jens Axboe wrote:
> > >> On 4/11/23 9:00?AM, Willem de Bruijn wrote:
> > >> But that doesn't work, because sock->ops->ioctl() assumes the arg is
> > >> memory in userspace. Or do you mean change all of the sock->ops->ioctl()
> > >> to pass in on-stack memory (or similar) and have it work with a kernel
> > >> address?
> > > 
> > > That was what I suggested indeed.
> > > 
> > > It's about as much code change as this patch series. But it avoids
> > > the code duplication.
> > 
> > Breno, want to tackle that as a prep patch first? Should make the
> > functional changes afterwards much more straightforward, and will allow
> > support for anything really.
> 
> Absolutely. I just want to make sure that I got the proper approach that
> we agreed here.
> 
> Let me explain what I understood taking TCP as an example:
> 
> 1) Rename tcp_ioctl() to something as _tcp_ioctl() where the 'arg'
> argument is now just a kernel memory (located in the stack frame from the
> callee).
> 
> 2) Recreate "tcp_ioctl()" that will basically allocate a 'arg' in the
> stack and call _tcp_ioctl() passing that 'arg' argument. At the bottom of
> this (tcp_ioctl() function) function, call `put_user(in_kernel_arg, userspace_arg)
> 
> 3) Repeat it for the 20 protocols that implement ioctl:
> 
> 	ag  "struct proto .* = {" -A 20 net/ | grep \.ioctl
> 	net/dccp/ipv6.c 	.ioctl	= dccp_ioctl,
> 	net/dccp/ipv4.c		.ioctl	= dccp_ioctl,
> 	net/ieee802154/socket.c .ioctl	= dgram_ioctl,
> 	net/ipv4/udplite.c	.ioctl	= udp_ioctl,
> 	net/ipv4/raw.c 		.ioctl	= raw_ioctl,
> 	net/ipv4/udp.c		.ioctl	= udp_ioctl,
> 	net/ipv4/tcp_ipv4.c 	.ioctl	= tcp_ioctl,
> 	net/ipv6/raw.c		.ioctl	= rawv6_ioctl,
> 	net/ipv6/tcp_ipv6.c	.ioctl	= tcp_ioctl,
> 	net/ipv6/udp.c	 	.ioctl	= udp_ioctl,
> 	net/ipv6/udplite.c	.ioctl	= udp_ioctl,
> 	net/l2tp/l2tp_ip6.c	.ioctl	= l2tp_ioctl,
> 	net/l2tp/l2tp_ip.c	.ioctl	= l2tp_ioctl,
> 	net/phonet/datagram.:	.ioctl	= pn_ioctl,
> 	net/phonet/pep.c	.ioctl	= pep_ioctl,
> 	net/rds/af_rds.c	.ioctl	=	rds_ioctl,
> 	net/sctp/socket.c	.ioctl  =	sctp_ioctl,
> 	net/sctp/socket.c	.ioctl	= sctp_ioctl,
> 	net/xdp/xsk.c		.ioctl	= sock_no_ioctl,
> 	net/mptcp/protocol.c	.ioctl	= mptcp_ioctl,
> 
> Am I missing something?

The suggestion is to convert all to take kernel memory and do the
put_cmsg in the caller of .ioctl. Rather than create a wrapper for
each individual instance and add a separate .iouring_cmd for each.

"change all of the sock->ops->ioctl() to pass in on-stack memory
(or similar) and have it work with a kernel address"
