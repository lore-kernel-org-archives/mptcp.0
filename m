Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7FE71
	for <mptcp@lists.linux.dev>; Mon, 17 May 2021 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621261061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SelZIGRZ9YwQD2DSHnmpg6PGyuRR4X/8niV8E1m1d8w=;
	b=ciE51qfR2fcgkEDCu1LthpxOna/9TPsK/eq+wqGTcpah15e46wHq9mxfusKXE2MoKbWg5d
	ICY+opPrhDggmXZxqPT1LkuNhCJgcMc1eruxgV5w5Iy2QIKGZCaX2KSWQ7R83KJ6IZvcxq
	AEUPavqn0eBPmBrAsLaExazkeVn2a9Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-spyGiuhPNYmCromcQzAvig-1; Mon, 17 May 2021 10:17:38 -0400
X-MC-Unique: spyGiuhPNYmCromcQzAvig-1
Received: by mail-wr1-f71.google.com with SMTP id j33-20020adf91240000b029010e4009d2ffso3908830wrj.0
        for <mptcp@lists.linux.dev>; Mon, 17 May 2021 07:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SelZIGRZ9YwQD2DSHnmpg6PGyuRR4X/8niV8E1m1d8w=;
        b=EiRatVHfHy5Yqm4/Ph6Rt9nI1O5whpsQhcV1cIi7y0s/cqW04QZJOghteFjfPFAqx+
         GUtlQpTagGCmATr2gvOW4fSiLxFsuZF2lJzDCFbqbHmdUQmP9QIcr96P2cSjQWHdROwA
         4djCTDD5aBF0Yhe/XaFJLPijT2mAMPE+3tlqgeDsdyGhFWOTe+FkdAkRTT6BIVDzR5fk
         tu2zznJIrehrW4yGoCEajAV1UaKxmBaOtSAkp0YFoKD4riDowwm+tPqCUgmTbfwjIcYM
         QP1JmRs3az6oQCWo3ZOTWV9N0CzlnpHULUTPhCAJK6Z2rPjEKeakwWyxUl+5fUIJjYNe
         zoGw==
X-Gm-Message-State: AOAM5315XNlYUvxcVOKSkNQRBB88U7/rtroN2eY3DRS5VrK6aKz8AWiZ
	UlDAZyzQTESeMifM6nWOF5PyarOt5cmZmGGjH8v/sC+6EejLqROQrJB4uUoZnXp6IF99W75kynb
	+u5W1miQflvw+c+o=
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr192528wmc.114.1621261057372;
        Mon, 17 May 2021 07:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKIUyzqfiM1cLAG9+MfLbG4c6ZFpdYW4nDLOnuPMNhgTh3RihrC30SRtFnZKt7rnPWo8DYEw==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr192507wmc.114.1621261057141;
        Mon, 17 May 2021 07:17:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-104.dyn.eolo.it. [146.241.245.104])
        by smtp.gmail.com with ESMTPSA id f26sm13504842wmj.30.2021.05.17.07.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 07:17:36 -0700 (PDT)
Message-ID: <10c0783f0b81ab279dbbf202033295e7891c18d6.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 0/6] add MP_CAPABLE 'C' flag
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev, Mat
 Martineau <mathew.j.martineau@linux.intel.com>
Date: Mon, 17 May 2021 16:17:35 +0200
In-Reply-To: <cover.1621002341.git.geliangtang@gmail.com>
References: <cover.1621002341.git.geliangtang@gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

Hello,

On Fri, 2021-05-14 at 22:32 +0800, Geliang Tang wrote:
> v6:
>  - rename mptcp_pm_add_entry to mptcp_pm_anno_entry
>  - update mptcp_pm_free_add_list
>  - update code in mptcp_pm_nl_add_addr_received
>  - tag: export/20210514T055902
> 
> v5:
>  - add a new patch "mptcp: add add_list in mptcp_pm_data"
>  - fix !CONFIG_SYSCTL case
>  - tag: export/20210507T174457
> 
> v4:
>  - rename mptcp_is_allow_join_id0 to mptcp_allow_join_id0
>  - rename deny_join_id0 in mptcp_pm_data to remote_deny_join_id0
>  - add comments for self test cases
>  - apply: export/20210504T064955 +
>           "data checksum support" +
>           "data checksum support cleanups"
> 
> v3:
>  - use 'u8 allow_join_initial_addr_port'
>  - drop the spinlock in patch 3
> 
> v2:
>  - rename join_denied to allow_join_id0 in mptcp_out_options
>  - rename join_denied to deny_join_id0 in mptcp_options_received
>  - add a new function mptcp_pm_deny_join_id0_received
>  - move deny_join_id0 flag from mptcp_sock to mptcp_pm_data
>  - check deny_join_id0 flag in mptcp_pm_create_subflow_or_signal_addr
> instead of in mptcp_syn_options.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/183
> 
> Geliang Tang (6):
>   mptcp: add sysctl allow_join_initial_addr_port
>   mptcp: add allow_join_id0 in mptcp_out_options
>   mptcp: rename mptcp_pm_add_entry to mptcp_pm_anno_entry
>   mptcp: add add_list in mptcp_pm_data
>   mptcp: add deny_join_id0 in mptcp_options_received
>   selftests: mptcp: add deny_join_id0 testcases
> 
>  Documentation/networking/mptcp-sysctl.rst     |  13 ++
>  include/net/mptcp.h                           |   3 +-
>  net/mptcp/ctrl.c                              |  16 ++
>  net/mptcp/options.c                           |  14 +-
>  net/mptcp/pm.c                                |   2 +
>  net/mptcp/pm_netlink.c                        | 151 ++++++++++++++----
>  net/mptcp/protocol.c                          |   1 +
>  net/mptcp/protocol.h                          |  21 ++-
>  net/mptcp/subflow.c                           |   3 +
>  .../testing/selftests/net/mptcp/mptcp_join.sh |  56 ++++++-
>  10 files changed, 238 insertions(+), 42 deletions(-)
> 
I'm very sorry to give feedback this late, but I was unable to review
this before.

I have some very generic/broad questions:
1) shuold 'allow_join_initial_addr_port' be by default 0 for clients?
If I read correctly, will be 1 after this patch.

2) is the additional add_addr accounting required? I mean storing the
received addrs in the msk pm add_list (patch 4/6). Can we instead
simply enforce !allow_join_initial_addr_port looking up the relevant
address into the existing subflows? (or caching first subflow dst addr
and port in some new msk fields, whatever is simpler)

if !allow_join_initial_addr_port && <exists subflow with target
ip/port> && <such subflow is mp_capable/>
	<do not create new subflow>

3) If I read correctly the series enforce the peer who could create the
new subflow to respect the 'allow_join_initial_addr_port' field, but
does not implement the corrsponding check on the other end. e.g. if a
server sets 'allow_join_initial_addr_port' to 0 and a client tries to
create additional subflows, the server will not forbit that. I
think/fear the missing complexity here is quite significant.

I think it would be nice avoid adding additional complexity for the 'C'
bit - currently even mptcp.org support it.

Perhaps we could keep 'allow_join_initial_addr_port' constant (always 0
for client, always 0 for server) - avoding the additional complexity of
point 3) above.

Again, I'm sorry for suggesting significant changes this late.

Paolo



