Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D22168
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 03:52:24 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id m1so1667291pfk.8
        for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 19:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xu5dJPvQlR95IZvUAASR601fY2KYcHgPOpX4WD0HBzY=;
        b=ZSmhz7bwcAV8rAOx9l5jH/CXCWMT48gdDNMs8E61TV5bd6kiO1vTadass+5k7lTy1F
         2vWQ+85wKXYNRIlazgGmOZVjU8bzKi26jHGhg8qOLNSg+cV1HOggeBI2m1qjJVGf6/8U
         Y9l3et/ZbTkfxnR3l1WqDQkKyQuTdtkE7yhVW/r3THJu/C20SOWb4hVfIr7Jnk0E0rct
         84jNfJISgcvuifZA0N4/dfZpCUfM5kwynLRhnTWHod1EtZPo1PBvXPHN5fbcyvfimtQ1
         JHZBWVaDHshWfQ85oQ7ij3YRe8jpfNh7vKtuyTBfu1pcrsNr7ohBruOHhyAKrhutY3iG
         4rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xu5dJPvQlR95IZvUAASR601fY2KYcHgPOpX4WD0HBzY=;
        b=SpS4U3FHImBj+2CWBkJR7jPjxfmLpbzeaL/JxAjeeLYUpgZtXejiNMnAZEGhWEfBAI
         uDwh89H/r6fygOSlw1HZn2h7ZsiMbIyjsWjYKIIgpnzixHAXxGdJMlHbZeUSEYlskft4
         H976cHO4U7NenoGkGRsg+8d4Z+V494yOM6EzVcBs7lmRV2NAI1TeKHzVzlbf0SB+FFWK
         629NKbcwBggSOg7cHDm9lZEkkd1DSzQnKwKr1yGhYx0naWBE3USzng94MBc4wJdkZx1o
         wnyt1y37HIk2h52PgavVybd+2zmjR3wLsXflGXeu+UfVZcU/5AVd0iey2x4n3RGodq81
         wnOw==
X-Gm-Message-State: AOAM533b3HRX74p0N62RRKRWIcjeRjK79HMm/EJ+qlXZwHOy1lCe9iZE
	9ECes/y7CDMbyVK96BS5iC5d6bT7OESOKA0cWhU=
X-Google-Smtp-Source: ABdhPJykmXj3fBYiv9IHQ0FwDy+6FwJ5L8GSVUuFTLNou0mBSLRclsLyOGPmk45UNkSEXZnjJuywsDGmEhjsI95V8t8=
X-Received: by 2002:a63:7d0e:: with SMTP id y14mr6378735pgc.356.1642132343791;
 Thu, 13 Jan 2022 19:52:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <059912660c7f5973da40413a9384bad542047013.1642098123.git.pabeni@redhat.com>
 <cfb899a0-96b8-4875-2556-c193d2d3f028@linux.intel.com>
In-Reply-To: <cfb899a0-96b8-4875-2556-c193d2d3f028@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 14 Jan 2022 11:52:21 +0800
Message-ID: <CA+WQbwtEp3oWGg+vv27-4mikUpzfi2j5p7_7qOZrcMWfoWAZaQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: fix ipv6 routing setup
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2022=E5=B9=B41=
=E6=9C=8814=E6=97=A5=E5=91=A8=E4=BA=94 07:57=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 13 Jan 2022, Paolo Abeni wrote:
>
> > MPJ ipv6 selftests currently lack per link route to the server
> > net. Additionally, ipv6 subflows endpoints are created without any
> > interface specified. The end-result is that in ipv6 self-tests
> > subflows are created all on the same link, leading to expected delays
> > and sporadic self-tests failures.
> >
> > Fix the issue by adding the missing setup bits.
> >
> > Fixes: 523514ed0a99 ("selftests: mptcp: add ADD_ADDR IPv6 test cases")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
> Thanks Paolo, looks good to me:
>
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Reported-and-tested-by: Geliang Tang <geliang.tang@suse.com>

>
> > ---
> > tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
> > 1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/te=
sting/selftests/net/mptcp/mptcp_join.sh
> > index e48ce23d2386..2be3cad4b52b 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -76,6 +76,7 @@ init()
> >
> >               # let $ns2 reach any $ns1 address from any interface
> >               ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth=
$i metric 10$i
> > +             ip -net "$ns2" route add default via dead:beef:$i::1 dev =
ns2eth$i metric 10$i
> >       done
> > }
> >
> > @@ -1510,7 +1511,7 @@ ipv6_tests()
> >       reset
> >       ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> >       ip netns exec $ns2 ./pm_nl_ctl limits 0 1
> > -     ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 dev ns2eth3 fla=
gs subflow
> >       run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> >       chk_join_nr "single subflow IPv6" 1 1 1
> >
> > @@ -1545,7 +1546,7 @@ ipv6_tests()
> >       ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> >       ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> >       ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > -     ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> > +     ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 dev ns2eth3 fla=
gs subflow
> >       run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
> >       chk_join_nr "remove subflow and signal IPv6" 2 2 2
> >       chk_add_nr 1 1
> > --
> > 2.33.1
> >
> >
> >
>
> --
> Mat Martineau
> Intel
>
