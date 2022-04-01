Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103F7ED5
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1648806170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4YizlEZjSMTx4oeLGsAWbVZPHwaBUX8p6U09Wm4rR0=;
	b=FyOwRL04Y/cf20mwjp+GcIs4DNNcdIlMOX6XZhonGurmoAt0ognnYr8m3ijSvbM1Nk3lqy
	uciwvPQTt9dH7O+qlozpFfO6UhB/x1hDA+ihd5Pp4pFg6CaQtTKDB3/n2WTuYr26pLn/De
	/XoyKa3ufF0vMxJpujRKKEXMuwPjvyU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-_SlEM5pDNjinXDWt0bv01Q-1; Fri, 01 Apr 2022 05:42:49 -0400
X-MC-Unique: _SlEM5pDNjinXDWt0bv01Q-1
Received: by mail-wm1-f69.google.com with SMTP id 2-20020a1c0202000000b0038c71e8c49cso2633723wmc.1
        for <mptcp@lists.linux.dev>; Fri, 01 Apr 2022 02:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=R4YizlEZjSMTx4oeLGsAWbVZPHwaBUX8p6U09Wm4rR0=;
        b=whw92OGgcP+DBl2b2pjhJ87BI/Hb5kdy/oHkSMqAZiFLCImCib3Y5UydUBWqC4pAoI
         6S/ttqIK04jK+ssqWk0LaXHpAk5zBeZHE6n64i6vtwCYS0rr7ePYJ1kxAd/P7p943/Ap
         4EqRSFHexBhnUCGzFjIMeYl+Oz5Xrqw9gRjSSFRAbfytS/p+meLRl8l+cB9rYI8NJJxe
         +U7Ccw13Mzx2LbSPCt5JS4Wb5nNVaftTPyICaaQXI5YXZZi1BrEa3fLJa1af/zgTa/h6
         h2+CqDZHqZkzPHiH92a/L0tPDXJP9Yfa7SZRN1De7xxuGyhASQoZfyaPKbkp54bQIkMj
         fsDw==
X-Gm-Message-State: AOAM5315rVSodLn6xugVMsTHIPGWnULCyO8sazK4C5OuzStSRh2EFT8p
	4DGQ4dQ9zlN1DrHr5u0+euFaWzAYBvK8w2sUXvhHpCMxi+ANGrBYZnqkyF2IRa0U4e0ypC8tuq/
	o8e02fGVNSPERGqc=
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr7987707wmk.58.1648806168042;
        Fri, 01 Apr 2022 02:42:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcLvmv0HbEoTrYhOQUsahZvQEfBbvgmLOuaUoEdyzriuDPBB8aP/XhbfPwg+HnAZh15opvzg==
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr7987690wmk.58.1648806167819;
        Fri, 01 Apr 2022 02:42:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-142.dyn.eolo.it. [146.241.243.142])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600018aa00b002042a98168csm1942960wri.15.2022.04.01.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 02:42:47 -0700 (PDT)
Message-ID: <b2a5907710772d1c807cc82e44397eb14d66900d.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v9 0/6] mptcp: fixes and enhancements related
 to path management
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Fri, 01 Apr 2022 11:42:46 +0200
In-Reply-To: <20220329021401.1196466-1-kishen.maloor@intel.com>
References: <20220329021401.1196466-1-kishen.maloor@intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35)
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
Content-Transfer-Encoding: 8bit

On Mon, 2022-03-28 at 22:13 -0400, Kishen Maloor wrote:
> This patch series incorporates fixes and enhancements related to
> path management over MPTCP connections, particularly in support of
> userspace PMs. The changes ensure that the required bits of
> information are conveyed through MPTCP netlink events which
> would be consumed by the path manager in making its decisions.
> Further it adds flexibility in establishing paths and from
> both ends of MPTCP connections.
> 
> v6:
> -Dropped framework and functionality around the use of kernel
> listening sockets for receiving MPJs.
> 
> v7:
> -Fixed bug caught by the CI build.
> 
> v8:
> -Fixed logic to achieve the desired outcome of not responding to
> address advertisements when a userspace PM is offline.
> -Factored out minor changes to mptcp_pm_is_userspace() to be
> squashed into an earlier commit.
> 
> v9:
> -Removed an explicit 'struct inet_sock *' cast in a patch which was
> not necessary.
> 
> Kishen Maloor (6):
>   Squash-to: mptcp: Bypass kernel PM when userspace PM is enabled
>   mptcp: bypass in-kernel PM restrictions for non-kernel PMs
>   mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
>   mptcp: reflect remote port (not 0) in ANNOUNCED events
>   mptcp: establish subflows from either end of connection
>   mptcp: expose server_side attribute in MPTCP netlink events
> 
>  include/uapi/linux/mptcp.h |  1 +
>  net/mptcp/options.c        |  4 ++--
>  net/mptcp/pm.c             | 21 +++++++++++++++++----
>  net/mptcp/pm_netlink.c     | 24 +++++++++++++++++++++---
>  net/mptcp/protocol.c       |  5 +----
>  net/mptcp/protocol.h       | 22 ++++++++++++++++------
>  net/mptcp/subflow.c        |  5 ++++-
>  7 files changed, 62 insertions(+), 20 deletions(-)
> 
> 
> base-commit: 8e1fca01ac83e646133bd647abdae74d6d6449ba
> --
> 2.31.1
> 
This series LGTM, thanks!

There is a consistent self-test failure on test:

098 userspace pm type echoes add_addr. 

I *think* it can be addressed even after merging this series. @Kishen,
could you please have a look at that?

Paolo

