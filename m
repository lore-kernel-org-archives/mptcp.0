Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C02C81
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 11:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635418889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NP+BCkeX5HMU4jaVhTr17DOZh51sxhrwjjfC6dSXwv4=;
	b=Jv191AnRAgAtV7kAUAZIew8PUbNgH4Bk+4GrfXT/73Xzfl3TOl3GLCQVHIVB6ShGxMJ+iP
	vKjtdX688ueaL8AbAj50jPdsaASWCfaU/tjmzK/5M8/kZsVmcVsuh60Jutyok2ORWA83kH
	FR+GuNtMGdYCsi14wEqOQIzOTBHw4w0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-oOJ-ESrENkS37Df1Ooiobw-1; Thu, 28 Oct 2021 07:01:26 -0400
X-MC-Unique: oOJ-ESrENkS37Df1Ooiobw-1
Received: by mail-yb1-f197.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so932129ybe.8
        for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 04:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NP+BCkeX5HMU4jaVhTr17DOZh51sxhrwjjfC6dSXwv4=;
        b=i1X7HnKFvRbcp0GWQxLO6wa/0FFw3kEf/q687jDHUmVkvSQOpBtueTPDXDjALorvB6
         douoKxcTJbApIvH1t14AlhYNGcBpl4e0If4+lTDHrWf23fhC27U/Q9DcAUdKFONlJQal
         /C7mYe8E+xtK4CUzr8s7NUwUhLv+sufGQLQbjFBfvcra5pw63OaezRYXOYdEHeFWjgpK
         q70rm0A9+wTGzyBcEhD0tamzHj3+jWT437zmBLwa0RPpFRA8BG662uyTRibT+pVm6qHs
         n3dI/41GlPT8J4gxQubXqFXvRnFWDEYIb52tDByVbCNOzoIS3cqpyHheAsLIfYm14xxw
         g3xA==
X-Gm-Message-State: AOAM531t3OUn1xFU3oafNKn2mUVNlfTMhpbRAM8UTVGcUsvel5cO15Ik
	FhRAIKr1ldL8s3pceGscBAwxASjPd/xGP8t17rBFfwCjIBTFCkV314O7bfJ5zII2wO9tnYniYA2
	tcNS0RQEEvHORB6DSPhEvfAfMSVcGNJg=
X-Received: by 2002:a25:c046:: with SMTP id c67mr3928324ybf.135.1635418886266;
        Thu, 28 Oct 2021 04:01:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTN0IvSsFHS2bVn6Ml4Ilxzkl0cr4qDBrrJLcuWHiXuX5JIp2sOHOD9pLSHgJ6aZ1BzVTVoCXahPqtCj1Bny0=
X-Received: by 2002:a25:c046:: with SMTP id c67mr3928293ybf.135.1635418885966;
 Thu, 28 Oct 2021 04:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <bfa01f99cbb0479029ad284b020dbb250d19b941.1635390811.git.geliang.tang@suse.com>
 <20211028092338.GA6915@dhcp-10-157-36-190>
In-Reply-To: <20211028092338.GA6915@dhcp-10-157-36-190>
From: Davide Caratti <dcaratti@redhat.com>
Date: Thu, 28 Oct 2021 13:01:15 +0200
Message-ID: <CAKa-r6srprPPPhUCXW3YnsQEL0ewFBptQFvUo_9mwtw_mD7DOQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: add mp_fail testcases
To: Geliang Tang <geliang.tang@suse.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts <matthieu.baerts@tessares.net>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 28, 2021 at 11:23 AM Geliang Tang <geliang.tang@suse.com> wrote:
>
> On Thu, Oct 28, 2021 at 11:16:12AM +0800, Geliang Tang wrote:
> > Added the test cases for MP_FAIL, use 'tc' command to trigger the
> > checksum failure.
> >
> > Suggested-by: Davide Caratti <dcaratti@redhat.com>
> > Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  tools/testing/selftests/net/mptcp/config      |  5 ++
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 60 ++++++++++++++++---
> >  2 files changed, 58 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> > index 0faaccd21447..f522288b2204 100644
> > --- a/tools/testing/selftests/net/mptcp/config
> > +++ b/tools/testing/selftests/net/mptcp/config
> > @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
> >  CONFIG_NETFILTER_XT_MATCH_BPF=m
> >  CONFIG_NF_TABLES_IPV4=y
> >  CONFIG_NF_TABLES_IPV6=y
> > +CONFIG_NET_ACT_CSUM=m
> > +CONFIG_NET_ACT_PEDIT=m
> > +CONFIG_NET_CLS_ACT=m
> > +CONFIG_NET_CLS_FLOWER=m
> > +CONFIG_NET_SCH_INGRESS=m
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 7ef639a9d4a6..95bac447f857 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -232,6 +232,29 @@ link_failure()
> >       done
> >  }
> >
> > +checksum_failure()
> > +{
> > +     i="$1"
> > +
> > +     tc -n $ns2 qdisc add dev ns2eth$i clsact
> > +     tc -n $ns2 filter add dev ns2eth$i egress \
> > +             protocol ip prio 1000 \
> > +             flower ip_proto tcp \
> > +             action pedit munge offset 148 u32 invert \
> > +             pipe csum tcp \
> > +             index 100
> > +
> > +     while true; do
> > +             local pkt=`tc -n $ns2 -j -s action show action csum index 100 | \
> > +                     awk -F ',' '{ print $12 }' | \
> > +                     awk -F ':' '{ print $2 }'`
> > +             if [ $pkt -gt 0 ]; then
> > +                     tc -n $ns2 qdisc del dev ns2eth$i clsact
> > +                     break
> > +             fi
> > +     done
> > +}
>
> I got this log in the dmesg output:
>
> [ 2495.182631] tc action pedit offset 162 out of bounds
>
> It looks like something wrong with tc.

this is a packet too small to be edited by pedit:

https://elixir.bootlin.com/linux/latest/source/net/sched/act_pedit.c#L368

when this happens, pedit gives up mangling and passes the packet to
the next action (csum in your case, but it's useless)

> How can I fix this?
is that a problem? maybe we can just ignore it.

Otherwise, a possibility is to add a more narrow filter (e.g. flower),
 to only mangle packets that have the ack flag but not the syn or
push. We might also try corrupting the TCP payload to a smaller
offset, so that more packets are impacted.

--
davide

