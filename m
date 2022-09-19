Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299006105
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663597043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDutmRu8p2bm/wbJxjOF5iBCjfDnNF6gJaQuSios6Zw=;
	b=PC/aLNSQJbX+4t9szxqG+tcy2TOtGYQFbsiVr+hbX3LZA8KUbCngLOKT/SJJ40za03u7QA
	XBK2Hm9aS+YNbBW5jPkcj0lPq7+f7tXicGxztfbf7LDYHXkHZbc7t2J7ukk5d8aBjAhp/Z
	ERUIVIxF8QbDz6JhR2E87XQkg0LBZa0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-Jx5ICbENOPikQyJvf1903w-1; Mon, 19 Sep 2022 10:17:22 -0400
X-MC-Unique: Jx5ICbENOPikQyJvf1903w-1
Received: by mail-wr1-f69.google.com with SMTP id q25-20020adfb199000000b0022ae4ea0afcso1199157wra.8
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 07:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=cDutmRu8p2bm/wbJxjOF5iBCjfDnNF6gJaQuSios6Zw=;
        b=7U4omtfYHI0BMjW7nSs2DEcorunRrgGbA1W7pTLdR6RVMndcIFlmlBgawQFlq0pdvM
         +4YEEm6QEGLDdbuud2WancCTTJNaQarFmwZm6Xsag5GfQBXrKQROz7Ev4cZp6UFerHuG
         PZd1I9/YOgRiwGmXLluzlAzIyPro9gPqXU+44LBVfdBIZWKvwOrbpo0P5HaVzrCBUQFG
         SXzMYF8ntEu8kc2RdFAss1A/3c9zsXrZIprRZB8S60c5x5ZJ5RSwVEiEWWY7qIRuO32G
         12gmTT9ejvcv2UZGDytq+1tc2wLxrbGGf2dm+XPBBFBNFszbkuQjRLBQMl0wnnyWEIV+
         M15Q==
X-Gm-Message-State: ACrzQf2Xxjc2NxgcyT77c7pAjfxb+CrCruUD99jz0ujEpnFNoXFQm5lr
	mwFOhsUMGvuEkME8x+t5Rqyxmb155NhcGmEN95Cwt1+DFM/b0nppOoTQn6TgDDKHfwhl6zUIzQV
	Wwini5GJapiwAU2A=
X-Received: by 2002:a05:600c:b47:b0:3b4:8604:410c with SMTP id k7-20020a05600c0b4700b003b48604410cmr12586719wmr.51.1663597039530;
        Mon, 19 Sep 2022 07:17:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4NkZfGPR/WiIDEqMyjMlsDiMiF9Wde93uSDcYpi02pnXOhUoUHEteuEzRSkt3FECVA9V0AQQ==
X-Received: by 2002:a05:600c:b47:b0:3b4:8604:410c with SMTP id k7-20020a05600c0b4700b003b48604410cmr12586699wmr.51.1663597039294;
        Mon, 19 Sep 2022 07:17:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id k24-20020adfd238000000b0022ad393ba3csm13634663wrh.107.2022.09.19.07.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:17:18 -0700 (PDT)
Message-ID: <5d0371c3eb22b65bafd6d46ff59a77ad20bdcfc9.camel@redhat.com>
Subject: Re: [PATCH net v5 0/2] net: mptcp: fix unreleased socket in accept
 queue
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Date: Mon, 19 Sep 2022 16:17:17 +0200
In-Reply-To: <20220911041418.818201-1-imagedong@tencent.com>
References: <20220911041418.818201-1-imagedong@tencent.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2022-09-11 at 12:14 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> The mptcp socket and its subflow sockets in accept queue can't be
> released after the process exit.
> 
> While the release of a mptcp socket in listening state, the
> corresponding tcp socket will be released too. Meanwhile, the tcp
> socket in the unaccept queue will be released too. However, only init
> subflow is in the unaccept queue, and the joined subflow is not in the
> unaccept queue, which makes the joined subflow won't be released, and
> therefore the corresponding unaccepted mptcp socket will not be released
> to.
> 
> In the 1th patch, we factor-out __mptcp_close() which should run under
> socket lock.
> 
> And in the 2th patch, we fix the problem we mentioned above by closing
> all of the unaccepted mptcp socket in mptcp_subflow_queue_clean()
> with __mptcp_close().
> 
> Changes since v4:
> - keep sock_hold() in __mptcp_close() in the 1th patch
> - rename cancel_work to do_cancel_work in the 1th patch
> - don't make mptcp_cancel_work() inline in the 2th patch
> 
> Changes since v3:
> - factor out __mptcp_close() and replace mptcp_close() with it in
>   mptcp_subflow_queue_clean()
> 
> Menglong Dong (2):
>   net: mptcp: factor out __mptcp_close() without socket lock
>   net: mptcp: fix unreleased socket in accept queue
> 
>  net/mptcp/protocol.c | 16 +++++++++++++---
>  net/mptcp/protocol.h |  2 ++
>  net/mptcp/subflow.c  | 33 +++++++--------------------------
>  3 files changed, 22 insertions(+), 29 deletions(-)

I think this is now even a nice cleanup, beyond a relevant bug-fix,
thanks!

For the series:

Acked-by: Paolo Abeni <pabeni@redhat.com>


