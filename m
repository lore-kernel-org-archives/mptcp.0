Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7440B173
	for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 09:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639648237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxXB3/P7I5gQL23e2sn9gALRRXdQgJi9DEyt1MVS4YA=;
	b=gQ9TNKCgyCExplFf/ICiHyoeE1fGrffaX4uwVFLDHmW8AhpZojOHNoO5vWSZVyz7P4vdgt
	JlUR8Z+4nnIVcUjvSA5E/UwbgOeyBeOcm6Bet1P9KLJeLEZ8aO7+ZR0a8HTa7PfXC7jv6T
	aiTMynsuCq8QZdbM57PRpX8++b41Spc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-NLIdoTZdPqiSNBNEcy7QNA-1; Thu, 16 Dec 2021 04:50:35 -0500
X-MC-Unique: NLIdoTZdPqiSNBNEcy7QNA-1
Received: by mail-wm1-f71.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso10076051wms.0
        for <mptcp@lists.linux.dev>; Thu, 16 Dec 2021 01:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CxXB3/P7I5gQL23e2sn9gALRRXdQgJi9DEyt1MVS4YA=;
        b=LMGg2K/ZTSOiF4W7d6C9QX2ZDllt5bAEWpc8woHKXo599Hvmo3hLCupkR5QrM+eNs9
         cFGFIkU0D784bbnjaGhqvrtlK+WBvPvIWGQ10e0Js29ozSV9zKon7d1vp7mG/kWXoKSd
         eiewVjQpYA1rlcUwYcsY3PIl7tE3WOJQuXs+He7qsBO0/hnZbzAyh6mLjueuM1Fpd2nR
         cfVxBnRRCwC+JkpgdpdGN+rghDpNm1Cpw0Hz/gNvi57/ymntvS4zHASmNuFCs6u60o75
         yLFMpr2UDKwugKRid+N8uGkt4GxCCKrxGLTDAbsmPlaIPPtOzyD5qYxHjCGZjjq3ud0y
         Yivg==
X-Gm-Message-State: AOAM531zq1JfcLOxc5aYktbEBxMK0yQuHgp4Z/E5VaLG9m0Qf6rPDTlf
	kABcJO+BlPdfLCHpSEImZJxgmdMnzgFJ3oIbSWvtvaQmusqmkQV2arqVtIpIrXQFNJ71N0GsAkt
	gY+z6JPJ7FUdM3WM=
X-Received: by 2002:a05:6000:18a5:: with SMTP id b5mr8375734wri.604.1639648234446;
        Thu, 16 Dec 2021 01:50:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUcOaO/ucdYcAwtdkMzxerW5PttwH7r+h2BASX8k2srfd0hP2YsmBFN5AzB+XWP4p5zi2yJQ==
X-Received: by 2002:a05:6000:18a5:: with SMTP id b5mr8375720wri.604.1639648234211;
        Thu, 16 Dec 2021 01:50:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-123-130.dyn.eolo.it. [146.241.123.130])
        by smtp.gmail.com with ESMTPSA id p2sm6987434wmg.41.2021.12.16.01.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 01:50:33 -0800 (PST)
Message-ID: <67a249ce8638bb19ad9d5418266d4512944e59ef.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 0/6] mptcp: Add userspace PM mode to
 bypass kernel PM
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Thu, 16 Dec 2021 10:50:32 +0100
In-Reply-To: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
References: <20211216003324.403195-1-mathew.j.martineau@linux.intel.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

On Wed, 2021-12-15 at 16:33 -0800, Mat Martineau wrote:
> One part of supporting userspace path managers is to prevent the
> in-kernel PM from acting on userspace-managed MPTCP connections.
> 
> These patches:
> 
>  * Add a per-MPTCP-socket 'pm_type'. A mix of kernel-managed and
>    userspace-managed connections are supported within each namespace.
> 
>  * Conditionally decouple incoming ADD_ADDR/RM_ADDR and subflow changes
>    from the in-kernel PM. Netlink events are still triggered, and ADD_ADDR
>    echo handling is still in kernel code even if path management is
>    otherwise handled in userspace.
> 
>  * Add a sysctl for setting the per-namespace default for in-kernel vs
>    userspace path management of new MPTCP sockets. This is an integer
>    value to allow extensibility.
> 
>  * Add selftests to confirm that the in-kernel PM is bypassed.
> 
> RFC -> v1: Changed sysctl from a bool to an integer, added patch 1
> (cleanup) and patch 6 (selftests), fixed ADD_ADDR echo and initial
> pm->subflows_allowed settings.
> 
> v1 -> v2: Rebased on latest export branch, removed extra kernel-mode
> check when receiving ADD_ADDR, and fix !CONFIG_SYSCTL build.
> 
> v2 -> v3: Rebased on latest export branch, use helper function for PM
> mode, clarify initialization logic for userspace vs. kernel PM,
> add a Tested-by tag from v2 review.
> 
> v3 -> v4: Rebased on latest export branch and resolved conflicts
> 
> Mat Martineau (6):
>   mptcp: Remove redundant assignments in path manager init
>   mptcp: Add a member to mptcp_pm_data to track kernel vs userspace mode
>   mptcp: Bypass kernel PM when userspace PM is enabled
>   mptcp: Make kernel path manager check for userspace-managed sockets
>   mptcp: Add a per-namespace sysctl to set the default path manager type
>   selftests: mptcp: Add tests for userspace PM type
> 
>  Documentation/networking/mptcp-sysctl.rst     | 18 +++++
>  net/mptcp/ctrl.c                              | 21 ++++++
>  net/mptcp/pm.c                                | 50 +++++++++----
>  net/mptcp/pm_netlink.c                        | 30 ++++----
>  net/mptcp/protocol.h                          | 16 ++++-
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 70 ++++++++++++++++++-
>  6 files changed, 170 insertions(+), 35 deletions(-)
> 
> 
> base-commit: 81706660508b6caa94d0fbeb8875882f155c73a9

LGTM, thanks Mat!

Acked-by: Paolo Abeni <pabeni@redhat.com>

