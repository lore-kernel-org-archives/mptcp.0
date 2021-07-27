Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D072
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 12:49:36 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so4045406pjb.3
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 05:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y3M+MErGcMXYVSWruQA073Mpqewebnp2HbcmnfxkHu8=;
        b=MCLK32p+LXGBLlq6eR7rIeIGJ/vaX5UOYh0ZvSQYxoKmRM7EGGnyGupkKcNEbKGQ9T
         hVbKaCgXTo3mpgTSEp2RbmaVBexlCyWRoVoFTo+Rz0HA5hcGdh4ZZC5uXN7KIYyaTTOX
         WG960hWDOx7sHptcWYS2EjgSWqKWmLXJ8MPQgMGHX6eTX3UXSqbubskz0ZQbJvQ9OVpK
         82gquMilU6Oh+vHJLcNpCjVwRvyQdpRasxIt16SlPxme1J0wvEKQH+AVqXzTKr6E6sxz
         DDTvztvF76iCKZpaH0Cmt/Y1ODyHPzw1c8whevwgNgkDSO9uQVfVYg6eerkNIO22vA3P
         3qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y3M+MErGcMXYVSWruQA073Mpqewebnp2HbcmnfxkHu8=;
        b=ZNE2jwA1KP/Z4aV6KWU0db8O8Mtz36dewzc4+7d9ofiuYKtbHaSGxx9M5neyD6DM1C
         kPaLQwTqlv0BHWeitBu79xJtZLfoOrFnFThiamcx0cduUJeegChOl9QJBjg8n4/JT7mR
         Eky+K0Byc7iSjFj3KRTryZhHJv/vxWp75ILVQQBckJZkK2LQP5OIedycqgNrvpdyng4n
         iFKq3B2WGhaSVLXQdMSkykQ6X48u3/KM8T84d+3q4dObt4uTx9yt1vJp6Rplbg9z8pm2
         pIarubvl2dOWKro6I/eDilzHglGSGugRP0s8vVFOYPJY9GV+6YEDKJYLNJDF+Hq1LOFI
         /4Tg==
X-Gm-Message-State: AOAM5324Hnx5itV6LRApgNdTzHveTkkTA2ywNSrDgbtmzzJNhjhzAsVE
	Hi31Fc/KTZ2e/LWZ4wvCHOPYM31ayXI2UD1CEc0=
X-Google-Smtp-Source: ABdhPJw9JI/40DQI3v6IXFs3hSmt81DPAb+QN6lN+tcsofKpwdODd2f7fjoD3KstkfWR8fC77CMHJuJPe9pzVvr3tkM=
X-Received: by 2002:a62:a516:0:b029:333:1995:5e75 with SMTP id
 v22-20020a62a5160000b029033319955e75mr22717735pfm.67.1627390175553; Tue, 27
 Jul 2021 05:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627372396.git.geliangtang@xiaomi.com> <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
 <bde1048019780ecc5f2e553bbb4eb21213f76ba7.1627372396.git.geliangtang@xiaomi.com>
 <69eb44fdf9899ec5eab342fa1f3b62d12ab2598e.1627372396.git.geliangtang@xiaomi.com>
 <78d86feae19ea4efd7061a9e92b81475ed035323.1627372396.git.geliangtang@xiaomi.com>
 <16669ae198f1f0eb21bf9383d6630cb692b6f3e2.camel@redhat.com>
In-Reply-To: <16669ae198f1f0eb21bf9383d6630cb692b6f3e2.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 27 Jul 2021 20:49:24 +0800
Message-ID: <CA+WQbwukcck8NTKAzNSasDjraPjfAYsyw9BAjgXHU9p0ox3KQA@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 4/5] selftests: mptcp: add fullmesh testcases
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 2021-07-27 at 15:58 +0800, Geliang Tang wrote:
> > From: Geliang Tang <geliangtang@xiaomi.com>
> >
> > This patch added the testcases for the fullmesh address flag of the pat=
h
> > manager.
> >
> > Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> > ---
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 57 ++++++++++++++++++-
> >  1 file changed, 54 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/te=
sting/selftests/net/mptcp/mptcp_join.sh
> > index 937e861e9490..ca19762b9c6e 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -367,7 +367,13 @@ do_transfer()
> >       fi
> >
> >       if [ $addr_nr_ns2 -gt 0 ]; then
> > -             let add_nr_ns2=3Daddr_nr_ns2
> > +             if [ $addr_nr_ns2 -gt 10 ]; then
> > +                     let add_nr_ns2=3Daddr_nr_ns2-10
> > +                     flags=3Dsubflow,fullmesh
> > +             else
> > +                     let add_nr_ns2=3Daddr_nr_ns2
> > +                     flags=3Dsubflow
> > +             fi
> >               counter=3D3
> >               sleep 1
> >               while [ $add_nr_ns2 -gt 0 ]; do
> > @@ -377,7 +383,7 @@ do_transfer()
> >                       else
> >                               addr=3D"10.0.$counter.2"
> >                       fi
> > -                     ip netns exec $ns2 ./pm_nl_ctl add $addr flags su=
bflow
> > +                     ip netns exec $ns2 ./pm_nl_ctl add $addr flags $f=
lags
> >                       let counter+=3D1
> >                       let add_nr_ns2-=3D1
> >               done
> > @@ -1697,6 +1703,46 @@ deny_join_id0_tests()
> >       chk_join_nr "subflow and address allow join id0 2" 1 1 1
> >  }
> >
> > +fullmesh_tests()
> > +{
> > +     # fullmesh 1
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 8 8
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 8 8
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmes=
h
> > +     run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> > +     chk_join_nr "fullmesh test 1" 2 2 2
> > +     chk_add_nr 1 1
> > +
> > +     # fullmesh 2
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 8 8
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 8 8
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmes=
h
> > +     ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmes=
h
> > +     run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> > +     chk_join_nr "fullmesh test 2" 4 4 4
> > +     chk_add_nr 1 1
>
> This 2 tests are a bit redundand, I think. With a single remote known
> address, the final topology will be the same as with non-fullmesh
> subflows. Perhaps we can keep just one of this cases?

Drop test 1 in v6.

>
> > +
> > +     # fullmesh 3
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 8 8
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 8 8
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
>
> Here I think we need at least one 'fullmesh' subflow in ns2? Otherwise
> this will be a non-fullmesh topology.
>
> > +     run_tests $ns1 $ns2 10.0.1.1 0 0 11 slow

This 11 means one fullmesh subflow.

> > +     chk_join_nr "fullmesh test 3" 3 3 3
> > +     chk_add_nr 1 1
> > +
> > +     # fullmesh 4
> > +     reset
> > +     ip netns exec $ns1 ./pm_nl_ctl limits 8 8
> > +     ip netns exec $ns2 ./pm_nl_ctl limits 8 8
> > +     ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
>
> And perhaps here 2 'fullmesh' subflows? So we test explicitly the most
> expected conf:

And 12 means two fullmesh subflows. I should add some comments here.

>
> Client          Server
> C1 -----------> S1
>     \       /->
>      \     /
>     - \ --/
>    /   \
>   /     \
>  /       ----->
> C2 -----------> S2
>
> (not sure how much the above "graph" will be readable :)
>
> Additionally it would be nice to explicitly test a fullmesh topology
> where we hit the max_subflows limit, e.g. 2 local address 3 remote ones
> and max_subflows=3D4

Add a limit test in v6.

>
>
>
> > +     run_tests $ns1 $ns2 10.0.1.1 0 0 12 slow
> > +     chk_join_nr "fullmesh test 4" 5 5 5
> > +     chk_add_nr 1 1
> > +}
> > +
> >  all_tests()
> >  {
> >       subflows_tests
> > @@ -1712,6 +1758,7 @@ all_tests()
> >       syncookies_tests
> >       checksum_tests
> >       deny_join_id0_tests
> > +     fullmesh_tests
> >  }
> >
> >  usage()
> > @@ -1730,6 +1777,7 @@ usage()
> >       echo "  -k syncookies_tests"
> >       echo "  -S checksum_tests"
> >       echo "  -d deny_join_id0_tests"
> > +     echo "  -m fullmesh_tests"
> >       echo "  -c capture pcap files"
> >       echo "  -C enable data checksum"
> >       echo "  -h help"
> > @@ -1765,7 +1813,7 @@ if [ $do_all_tests -eq 1 ]; then
> >       exit $ret
> >  fi
> >
> > -while getopts 'fsltra64bpkdchCS' opt; do
> > +while getopts 'fsltra64bpkdmchCS' opt; do
> >       case $opt in
> >               f)
> >                       subflows_tests
> > @@ -1806,6 +1854,9 @@ while getopts 'fsltra64bpkdchCS' opt; do
> >               d)
> >                       deny_join_id0_tests
> >                       ;;
> > +             m)
> > +                     fullmesh_tests
> > +                     ;;
> >               c)
> >                       ;;
> >               C)
>
