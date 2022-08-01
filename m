Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E37F
	for <mptcp@lists.linux.dev>; Mon,  1 Aug 2022 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659351048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cp8QHX5t2WXcm+OqscwZWKOkJOm3yY6JrE4oWGQsSfM=;
	b=iuAb0yrfbEpIAfWpzQ3YRKtvN5JmrgPuKTCOLovX7gol6u9qcOiRphR/ZtWma4hqceJhIN
	vfVy0exvu5V1xtFABKFzyRKxA75tHeQvKFNnr7lmNWgYUtX2O1TMf5PgdB71aK5NAgpsXk
	ryYBGBfrKIRwtfUjIUeLwaHgVyq3Z8g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-APNZ-wXkMNyl_hfslPsrfg-1; Mon, 01 Aug 2022 06:50:47 -0400
X-MC-Unique: APNZ-wXkMNyl_hfslPsrfg-1
Received: by mail-wm1-f69.google.com with SMTP id n19-20020a05600c3b9300b003a314062cf4so5235864wms.0
        for <mptcp@lists.linux.dev>; Mon, 01 Aug 2022 03:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cp8QHX5t2WXcm+OqscwZWKOkJOm3yY6JrE4oWGQsSfM=;
        b=wUgJKmc2YdzBaFcSV1iprCLPTFzIBUSEONDfVlwgy7v6S7qHUc1j6S9B6RScpZGmsD
         rwB7jYCo1KLBk4O0lRV+plmXtaF6caz9j7j5ANZsnLIvAgXgYjTdZXtAEGqkvbvK/h5I
         UhhmL7NBqPlefp40lg3sptpjUlhtO0c/J80j8gNHz+B4ffpEOVQTFFGkJ6H/wuDoVVyb
         9sELKVh/UatzbidVvvBqvxIJEYbcnRV+foeHway1SPslJIlu+qK+b2zam3rZQxCuU5Zs
         Sr1lQVvAfalA+KbAZfXgyrAJgg1LwHqEJuOS2r7YeknuCresuNfEqSsck7LPZDClMFTy
         zMsQ==
X-Gm-Message-State: AJIora/9qKJsvMgoVpOcyTwhIDaBqJeMmtnaSLmiNdfJ4t3jm9oH0TJe
	Ud2gaHMzdtC8F/6XdzAiXUtM0dtn7QYe4UAAihsOS9zpfky+0Xmoc2WQMlafAFTjlhCwOyNt7km
	qMvW8SldE9BwbWP7mQch+PeQFMUISLeqy+AuojT1RFxs/zNU+3tLxN90KnUo4SqZA
X-Received: by 2002:a7b:ca4a:0:b0:3a3:651f:51d8 with SMTP id m10-20020a7bca4a000000b003a3651f51d8mr10706055wml.102.1659351045765;
        Mon, 01 Aug 2022 03:50:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sjtJVO69TqeC70SItXFJb3/BgyUl+/pcwYfZgjwLrKMTO2c11/Qk0N2Rwo5MdbVvcUgflixA==
X-Received: by 2002:a7b:ca4a:0:b0:3a3:651f:51d8 with SMTP id m10-20020a7bca4a000000b003a3651f51d8mr10706035wml.102.1659351045370;
        Mon, 01 Aug 2022 03:50:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-118-222.dyn.eolo.it. [146.241.118.222])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b003a3278d5cafsm20590568wmq.28.2022.08.01.03.50.44
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 03:50:44 -0700 (PDT)
Message-ID: <9f161078dfd130882b9d9bfea2a76b3d89fdc42e.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 0/4] mptcp: just another receive path
 refactor
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Mon, 01 Aug 2022 12:50:44 +0200
In-Reply-To: <cover.1659165378.git.pabeni@redhat.com>
References: <cover.1659165378.git.pabeni@redhat.com>
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

On Sat, 2022-07-30 at 10:04 +0200, Paolo Abeni wrote:
> This is a refresh and rebase of an already shared work:
> 
> https://lore.kernel.org/mptcp/cover.1621963632.git.pabeni@redhat.com/
> [1]
> 
> The motiviation for refreshing this is:
> 
> https://lore.kernel.org/mptcp/YtVhyGSsv1CWvPz4@xsang-OptiPlex-9020/
> 
> specifically it looks like that properly attaching mem_cg to the
> msk socket would be (much?) easier if the RX path and the fwd memory
> allocation would be under msk socket lock protection.
> 
> The first 2 patches are proably worthy even without the refactor,
> but specifically the 2nd one is required to get a good mptcp-level
> acking behavior when we move the rx under the socket lock.
> 
> The 3rd patch does the real work, and the 4th is a follow-up cleanup.
> 
> Back at [1], I measured relevant performance regressions in some
> specific cases. I've done the same test here and I now see little to
> noise changes. I guess that is mostly due to the better acking
> strategy already introduce with commit 949dfdcf343c ("Merge branch 
> 'mptcp-improve-mptcp-level-window-tracking'") and refined here.
> 
> v2 -> v3:
>  - dropped obsoleted comment in patch 2/4
>  - fixed compile warning in patch 3/4
> 
> v1 -> v2:
>  - fix build issue in patch 3/4 due to PEBKAC
>  - added missing commit messages(!!!) in patch 3/4 & 4/4
> 
> Paolo Abeni (4):
>   mptcp: move RCVPRUNE event later
>   mptcp: more accurate receive buffer updates
>   mptcp: move msk input path under full msk socket lock
>   mptcp: use common helper for rmem memory accounting
> 
>  include/net/mptcp.h  |   2 +
>  net/ipv4/tcp.c       |   3 +
>  net/mptcp/options.c  |   1 -
>  net/mptcp/protocol.c | 219 +++++++++++--------------------------------
>  net/mptcp/protocol.h |  12 ++-
>  5 files changed, 68 insertions(+), 169 deletions(-)

I *think* there is a litte more self-tests instability with series
applied, specifically on simult_flows, and mptcp_join 32 && 99.

Behind the CI report I also observed a few sporadid failures there.

I'm wild guessing that the mpj failures are caused by the subflow
socket lock being acquired/relased more often under the msk socket lock
, possibly changing the timing for some events.

I still have to investigate the above.

I think we could still consider merging this on the export branch, and
later try to hammer the issue on the branch (to get more coverage from
the bots).

WDYT?

Thanks!

Paolo

