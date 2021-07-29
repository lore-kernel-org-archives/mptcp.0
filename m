Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFD172
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 07:09:48 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id b6so8933528pji.4
        for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 00:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4uE2k0a5a/m0EjX8x1W79w/5MIOPUwyauMf27E/c9x8=;
        b=lsMh60VDn2j4BLKm3paKBs63+1Y3qf78ZPnGm6czQONtosH2uaWRd4q+pF8gqxrhNo
         +shAYn6QxaN48xiaFOyo05C93d3mTNY545KfOtvwBTJnT7wXu041dw3G7lzTrf4+Du86
         qQaonDQ6rLPNDbZ+QHa7GcvF355I/gwqPMudSAWI/POK9/ltIWfLUSnda/oAsVhwDmJV
         wc5tpPFDtXtIUY7IVOSbgxggqUchACZhawUF7ibsnJ6x2J7Qfq1qeB4rDGAxXpK2qIyt
         Vu6x3RsAmqiLdwsst7E8LRnUej+FZhnuTAIXKsPyNjpMrkJzVnBC8owYj8qIyt63ZoLK
         b3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4uE2k0a5a/m0EjX8x1W79w/5MIOPUwyauMf27E/c9x8=;
        b=eDMZazZ0DiDulXpUktywf6xewZAGUh8y+AvX0gaVUiHiyutrGjzetLUTsE2FT35snA
         6u8ie6OwmF+ICvLkwoD9nwblVy+jZyGhIVveE40K1R5usk4qrsXPTo4V44M4cXGUTSxs
         zkYjeTH/r8+Kzwm6vpuigNDczT/ITnGwes5eSO1PaoPQF4ulH8YZOqBoUmLCGVko1VMn
         nshBb84w7ucQ2/AMlbVlkX0z9/27xm+G3keoEtxOMsqdrp92ciKNqPA/qSsM8t4gBP6o
         6AyvQri5PN6A34nXwcJdu4jOw3bv8+H2GhVF4Ue9v4AFSKOTKtk5M20rb8VjvtoxqGvq
         QCJA==
X-Gm-Message-State: AOAM533I0pqnEmoG4QPxm0KHqpRAaciDoRMW5LqmT6ExYgUKk8bQv45N
	dJG+iKL/UOOzttMai1U++x/AfNd7GiK0N63mszg=
X-Google-Smtp-Source: ABdhPJwMBRI3bAvZWaLb0hojXGbJQzp3fzet1oqnmVfnRacEFxpvrgp2H5GFyUk7xljoNJimgGsOl/mL3ED1XMEceWc=
X-Received: by 2002:a17:90a:5d8a:: with SMTP id t10mr13759843pji.6.1627542587664;
 Thu, 29 Jul 2021 00:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627391588.git.geliangtang@xiaomi.com> <703a40cb47f2f4c0ddb25bb61f97cfb4b973dc5e.1627391588.git.geliangtang@xiaomi.com>
 <87310b54d3987e94138953e171bad7b081b63df5.1627391588.git.geliangtang@xiaomi.com>
 <10a327d0ce8f917d17166ae7de561a8b2af23ff3.1627391588.git.geliangtang@xiaomi.com>
 <cb461bd9ebbbfda680c2d1fea3bc7467596e3d5d.1627391588.git.geliangtang@xiaomi.com>
 <44581bdbef617928052995d5e7ec0a6420023f9b.camel@redhat.com> <2e7f9ac3-0ac4-24b7-5530-192362405467@tessares.net>
In-Reply-To: <2e7f9ac3-0ac4-24b7-5530-192362405467@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 29 Jul 2021 15:09:36 +0800
Message-ID: <CA+WQbwspBe8MNNUjedM6nzxTxkwvhaHXvTXziiZJ1y5caVjncw@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 4/5] selftests: mptcp: add fullmesh testcases
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliangtang@xiaomi.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt, Paolo,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B47=E6=
=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:41=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Geliang, Paolo,
>
> Thank you for the new version.
>
> On 28/07/2021 19:21, Paolo Abeni wrote:
> > On Tue, 2021-07-27 at 21:24 +0800, Geliang Tang wrote:
> >> From: Geliang Tang <geliangtang@xiaomi.com>
> >>
> >> This patch added the testcases for the fullmesh address flag of the pa=
th
> >> manager.
> >>
> >> Reuse the above 10 address numbers for the fullmesh test.
> >>
> >> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> >> ---
> >>  .../testing/selftests/net/mptcp/mptcp_join.sh | 57 ++++++++++++++++++=
-
> >>  1 file changed, 54 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_join.sh
> >> index 937e861e9490..2a27d6240f5b 100755
> >> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> @@ -367,7 +367,13 @@ do_transfer()
> >>      fi
> >>
> >>      if [ $addr_nr_ns2 -gt 0 ]; then
> >> -            let add_nr_ns2=3Daddr_nr_ns2
> >> +            if [ $addr_nr_ns2 -gt 10 ]; then
>
> Maybe more explicit if we pass 'fullmesh-X' where X is the number of
> addresses we need with the fullmesh flag.
>
>   local flags=3D"subflow"
>
>   (...)
>
>   if [[ "${addr_nr_ns2}" =3D "fullmesh-"* ]]; then

It doesn't work. addr_nr_ns2 is expected as a integer, we can't pass a
string to it.

Otherwise, we will get this error:

./mptcp_join.sh: line 370: [: fullmesh-1: integer expression expected.

>           flags=3D"${flags},fullmesh"
>           addr_nr_ns2=3D${addr_nr_ns2:9}
>   fi
>
>   if [ $addr_nr_ns2 -gt 0 ]; then
>           counter=3D3
>           (...)
>
> This can also be fixed with a squash-to patch ;)

I have same new changes in this series, so I'll sent a v7.

All other comments will be added in v7.

Thanks,
-Geliang

>
> >> +                    let add_nr_ns2=3Daddr_nr_ns2-10
> >> +                    flags=3Dsubflow,fullmesh
> >> +            else
> >> +                    let add_nr_ns2=3Daddr_nr_ns2
> >> +                    flags=3Dsubflow
> >> +            fi
> >>              counter=3D3
> >>              sleep 1
> >>              while [ $add_nr_ns2 -gt 0 ]; do
> >> @@ -377,7 +383,7 @@ do_transfer()
> >>                      else
> >>                              addr=3D"10.0.$counter.2"
> >>                      fi
> >> -                    ip netns exec $ns2 ./pm_nl_ctl add $addr flags su=
bflow
> >> +                    ip netns exec $ns2 ./pm_nl_ctl add $addr flags $f=
lags
> >>                      let counter+=3D1
> >>                      let add_nr_ns2-=3D1
> >>              done
> >> @@ -1697,6 +1703,46 @@ deny_join_id0_tests()
> >>      chk_join_nr "subflow and address allow join id0 2" 1 1 1
> >>  }
> >>
> >> +fullmesh_tests()
> >> +{
> >> +    # fullmesh 1
> >> +    reset
> >> +    ip netns exec $ns1 ./pm_nl_ctl limits 0 4
> >> +    ip netns exec $ns2 ./pm_nl_ctl limits 1 4
> >> +    ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmes=
h
> >> +    ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmes=
h
> >> +    run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> >> +    chk_join_nr "fullmesh test 1" 4 4 4
> >> +    chk_add_nr 1 1
> >> +
> >> +    # fullmesh 2
> >> +    reset
> >> +    ip netns exec $ns1 ./pm_nl_ctl limits 1 3
> >> +    ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> >> +    ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> >> +    run_tests $ns1 $ns2 10.0.1.1 0 0 11 slow
> >
> > It still took me a bit follow topology creation here. I think a comment
> > is deserved, the first time this kind of argument is used.
>
> Good idea!
>
> It could be good to also rename the tests: "fullmesh test [1234]" are
> not very explicit.
> It could be nice to put the topology there, e.g. "2x2", "2x2 w/ signal"? =
:)
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
