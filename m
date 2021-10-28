Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B4E2C81
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635423855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GmYRaWJ1G6YABadhl6XIGnwffPuCzX0VaxrK63vLzes=;
	b=MR8VeqrTLnxlVSBkLs3XfagiphrEJAsrCBiCYVL1CwW6dh9lTswrBcYiFu6tkezuJqWzHT
	zbbsNoepzWC5Ni7wDmA2Y7TNbFzndXoSDX6T0Dihj5JESvfz2RvcSOWVu0xzcTXwX45ny7
	mfwdmmoSu/X86bBA545WDFeib3KFYO4=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-FE2bpFVeOHiWf931GU9Z8g-1; Thu, 28 Oct 2021 08:24:13 -0400
X-MC-Unique: FE2bpFVeOHiWf931GU9Z8g-1
Received: by mail-yb1-f200.google.com with SMTP id x68-20020a25ce47000000b005c198858e6bso8273744ybe.21
        for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 05:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmYRaWJ1G6YABadhl6XIGnwffPuCzX0VaxrK63vLzes=;
        b=3w4yxAjXcBZQV7skgily4z2l3CRvC6k7PTvFu7o5ymh0/ftY+TSl+H8D1gUe6R/lag
         hH+5ccLfVKI3lfOffZsorJ1sNDQHKaFpoJvcFUb4nHBbp1SJEL6TStULpMUQDb+oyPsQ
         LtOWHJ57OC0akWIeo1zhnWrx+LMec7ZSqErE86VTz9QfgoticNZrXzz+zms8JwL6KdBY
         NjN7Bx5tN+alIRHUS1+9Nh6fODf8CDyphL0g2cKeYMrW63jMOmt9Tj+M2FDxXrdyJId6
         D+KRTjt6p3hkyReqQRwNa06r9HE+7tgNZ8bD02HESIms7NW8imLYttUzyGOGYfa5GLre
         es9A==
X-Gm-Message-State: AOAM531RHEcyouOhGU6TVrZoj0pe2AgqAgbNWpHoYbhMHsq7XzwauqZz
	WOY7JZ8tJkVKMGZfpVaWiu1AcZbOtM0thbwhn/4Cn9Z6bX2vWDfQ2/tFPKP0LfeIarfAfQJfbBY
	ELvBi9DkM3j7e8r5g2i7EpztSqAHRbu4=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr4005455ybj.320.1635423853177;
        Thu, 28 Oct 2021 05:24:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO0sP+nyTEctvi63SD1ba9EV/DN4rLLJha5MMb1l8WcVR3n+fg3s+yTX+9F1kIqhr5108e2Cguho3UNJqLd1U=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr4005431ybj.320.1635423852893;
 Thu, 28 Oct 2021 05:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <bfa01f99cbb0479029ad284b020dbb250d19b941.1635390811.git.geliang.tang@suse.com>
 <20211028092338.GA6915@dhcp-10-157-36-190> <CAKa-r6srprPPPhUCXW3YnsQEL0ewFBptQFvUo_9mwtw_mD7DOQ@mail.gmail.com>
 <de15a4e9-0140-2b18-7a5a-c010980eedc2@tessares.net>
In-Reply-To: <de15a4e9-0140-2b18-7a5a-c010980eedc2@tessares.net>
From: Davide Caratti <dcaratti@redhat.com>
Date: Thu, 28 Oct 2021 14:24:02 +0200
Message-ID: <CAKa-r6t_ajhpvO2PnGyL2E-0FuV+r9D1i31vO9J71M8XiajnkQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: add mp_fail testcases
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 28, 2021 at 1:21 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Davide, Geliang,
>
> On 28/10/2021 13:01, Davide Caratti wrote:
> > On Thu, Oct 28, 2021 at 11:23 AM Geliang Tang <geliang.tang@suse.com> wrote:
> >>
> >> On Thu, Oct 28, 2021 at 11:16:12AM +0800, Geliang Tang wrote:
> >>> Added the test cases for MP_FAIL, use 'tc' command to trigger the
> >>> checksum failure.
> >>>
> >>> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> >>> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>
> Thank you for the new version!
>
> >>> ---
> >>>  tools/testing/selftests/net/mptcp/config      |  5 ++
> >>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 60 ++++++++++++++++---
> >>>  2 files changed, 58 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> >>> index 0faaccd21447..f522288b2204 100644
> >>> --- a/tools/testing/selftests/net/mptcp/config
> >>> +++ b/tools/testing/selftests/net/mptcp/config
> >>> @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
> >>>  CONFIG_NETFILTER_XT_MATCH_BPF=m
> >>>  CONFIG_NF_TABLES_IPV4=y
> >>>  CONFIG_NF_TABLES_IPV6=y
> >>> +CONFIG_NET_ACT_CSUM=m
> >>> +CONFIG_NET_ACT_PEDIT=m
> >>> +CONFIG_NET_CLS_ACT=m
> >>> +CONFIG_NET_CLS_FLOWER=m
> >>> +CONFIG_NET_SCH_INGRESS=m
> >>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>> index 7ef639a9d4a6..95bac447f857 100755
> >>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>> @@ -232,6 +232,29 @@ link_failure()
> >>>       done
> >>>  }
> >>>
> >>> +checksum_failure()
> >>> +{
> >>> +     i="$1"
> >>> +
> >>> +     tc -n $ns2 qdisc add dev ns2eth$i clsact
> >>> +     tc -n $ns2 filter add dev ns2eth$i egress \
> >>> +             protocol ip prio 1000 \
> >>> +             flower ip_proto tcp \
> >>> +             action pedit munge offset 148 u32 invert \
> >>> +             pipe csum tcp \
> >>> +             index 100
> >>> +
> >>> +     while true; do
> >>> +             local pkt=`tc -n $ns2 -j -s action show action csum index 100 | \
> >>> +                     awk -F ',' '{ print $12 }' | \
> >>> +                     awk -F ':' '{ print $2 }'`
>
> (small detail if you have to send a new version: it is often recommended
> to use "$(cmd)" form instead of `cmd`: more visible, allow nested
> commands, quotes, etc.)

also, please consider using jq rather than awk. Specially if you are
planning to use more than one counter. For reference, see [1]
>

[...]
> >
> >> How can I fix this?
> > is that a problem? maybe we can just ignore it.
>
> Do you have this message once or one for each packet?
> Does it increment the counter you are monitoring when the warning is
> printed?
>
> If I understand the code, it might print that once per packet and once
> but also increment the counter which is not good for us. But another
> counter -- "overlimits" -- seems to be incremented too, maybe we can use
> the two counters.
>
> > Otherwise, a possibility is to add a more narrow filter (e.g. flower),
> >  to only mangle packets that have the ack flag but not the syn or
> > push. We might also try corrupting the TCP payload to a smaller
> > offset, so that more packets are impacted.
>
> Yes, maybe good to narrow a bit the filter by using:
>
>   flower ip_proto tcp tcp_flags 0x10/0xff
>
> Or is there another filter to specify a minimum size?

unfortunately we can't do that with TC filters (unless using the eBPF
classifier for this (and I'm still not 100% the verifier would be
happy _ but that's still in my long-term todo list :) ). I know there
are ongoing efforts to introduce a "check_pkt_larger" (because this
check is actually a possible openflow action) , but that won't happen
in the short period.
-- 
davide

