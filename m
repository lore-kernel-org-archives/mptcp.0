Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145BC173
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 10:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1628765890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=taoJXcm13dVXRmQLZbqIrtd0IvZr8iLCU2H8Ex4MsWQ=;
	b=D/KjrwWVO7gXNdyZnkKeF8t3AIhtQgY6qMn+YjNZd4Asd+XhT//nS3uifpZjtObFQWfbdG
	7R2zTNcTNe6oiEI8KLuWC+oY+uUin6kgLhq/TyxikrbOVJ6SoQ8r7MKoPZ/C2sN48IkyY9
	jKXa24CXahsD5r9qoS3pAfpFqLYjVQk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-bI1NJnuaPWO5FvWz8GfASA-1; Thu, 12 Aug 2021 06:58:09 -0400
X-MC-Unique: bI1NJnuaPWO5FvWz8GfASA-1
Received: by mail-wm1-f70.google.com with SMTP id e21-20020a05600c4b95b029025b007a168dso3211714wmp.4
        for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 03:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=taoJXcm13dVXRmQLZbqIrtd0IvZr8iLCU2H8Ex4MsWQ=;
        b=l4xZlRWKqaFtNyyq5bvG5BccqOxGxh/pMafqR67x2r/BuU4VPJhuGpeG56uF+qTM5q
         HD5Nj3BK/hhULYhbghKX84GEyXcaKsp1Bto3POVAvejOj/u6hVWXrIum1kf4AXgZ0E+h
         1IoWvp4DQs72LEGXwJ5ufXIh+iMN8hhWREvWhYnCDF9EFUoji+ett7xql4Y5f3rFkhn0
         KpcEKBxPVDqJk9BAuHnJMzcOpS9wocw6cy2HH+n8CqU58W8dMGNqVRRjhYP0oiMd+/LP
         kmLwCKYDjR483nLqHlabjak9gTF9oEukPAZl8UMyvhwrRVyuDNS54WQq/I8m5X+OYDuu
         7olA==
X-Gm-Message-State: AOAM530rJ+8kNYpHBkcWXKMWWTnLOWAvWr5ZD42unt8nijnnL5TsXsR1
	iyh8Gzl727oQvqz2i0anVx/r3FmSrNM/3IBW8CQRz4G7zAJG+mgca0b7n3g/wnRiTgOkTS5hFkm
	okXapcK9qslzTpTc=
X-Received: by 2002:a5d:5985:: with SMTP id n5mr3336791wri.394.1628765888423;
        Thu, 12 Aug 2021 03:58:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6sv8V9LbsLJnKe3b5N1B1vx7BwnK2p2SsedqlRwtszLDVIr93yyPGFV8uvf2AkrnEIpkC+A==
X-Received: by 2002:a5d:5985:: with SMTP id n5mr3336778wri.394.1628765888164;
        Thu, 12 Aug 2021 03:58:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-77.dyn.eolo.it. [146.241.224.77])
        by smtp.gmail.com with ESMTPSA id z5sm8838783wmp.26.2021.08.12.03.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 03:58:07 -0700 (PDT)
Message-ID: <0a040c70d57ce758a37f92cb214ee332656b3057.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 0/5] mptcp: add SOL_MPTCP getsockopt support
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Thu, 12 Aug 2021 12:58:06 +0200
In-Reply-To: <20210811131523.6339-1-fw@strlen.de>
References: <20210811131523.6339-1-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello Florian,
On Wed, 2021-08-11 at 15:15 +0200, Florian Westphal wrote:
> This adds the MPTCP_INFO, MPTCP_TCPINFO and MPTCP_SUBFLOW_ADDRS
> mptcp getsockopt optnames.
> 
> MPTCP_INFO exposes the mptcp_info struct as an alternative to the
> existing netlink diag interface.
> 
> MPTCP_TCPINFO exposes the tcp_info struct.
> Unlike SOL_TCP/TCP_INFO, this returns one struct for each active
> subflow.
> 
> MPTCP_SUBFLOW_ADDRS allows userspace to discover the ip addresses/ports
> used by the local and remote endpoints, one for each active tcp subflow.
> 
> MPTCP_TCPINFO and MPTCP_SUBFLOW_ADDRS share the same meta-header that
> needs to be pre-filled by userspace with the size of the data structures
> it expects.  This is done to allow extension of the involved structs
> later on, without breaking backwards compatibility.
> 
> The meta-structure can also be used to discover the required space
> to obtain all information, as kernel will fill in the number of
> active subflows even if there is not enough room for the requested info
> itself.
> 
> More information is available in the individual patches.
> Last patch adds test cases for the three optnames.
> 
> Florian Westphal (5):
>   mptcp: add new mptcp_fill_diag helper
>   mptcp: add MPTCP_INFO getsockopt
>   mptcp: add MPTCP_TCPINFO getsockopt support
>   mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support
>   selftests: mptcp: add mptcp getsockopt test cases
> 
>  include/linux/socket.h                        |   1 +
>  include/net/mptcp.h                           |   4 +
>  include/uapi/linux/mptcp.h                    |  29 +
>  net/mptcp/mptcp_diag.c                        |  26 +-
>  net/mptcp/sockopt.c                           | 258 +++++++++
>  tools/testing/selftests/net/mptcp/Makefile    |   4 +-
>  .../selftests/net/mptcp/mptcp_sockopt.c       | 545 ++++++++++++++++++
>  .../selftests/net/mptcp/mptcp_sockopt.sh      |  31 +-
>  8 files changed, 869 insertions(+), 29 deletions(-)
>  create mode 100644 tools/testing/selftests/net/mptcp/mptcp_sockopt.c

The patches LGTM! I have just a couple of minor curiosity. 

In some helper the argument that carries the option length from user
space is named '_u_optlen', any special reason for that? Encoding the
argument attribute into the user name looks really win32 style from the
early 2000, afaik ;))) [no offense intended!!!]

I don't see how the mptcp_subflow_addrs is going to change/increase the
size with time... do you have some possible ideas/guess?

Anyhow,

Acked-by: Paolo Abeni <pabeni@redhat.com>

