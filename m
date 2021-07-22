Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2492B168
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 09:28:54 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so4654768pjo.3
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y9c6bt0GAIfK0d/+y4nN3bHy18xEra789xR4CFLrN48=;
        b=jK/YFD1VQCPfRCiUkYGJgnYDmQRTYOBNlUSea8dCKJSq+FYhYF4tRiB0AYNTr6pQ3s
         /kSKPugrRvn1GdZhPvX2Fic9bwI/Y+cNIIEYG+adJAsw/LNzOhVFxJB3nDNdaleJjlIZ
         QWrZSOguh6uSeJ3u3Ddjah/6FUqD2aIL4FhSRZ3NYZLl+I5hNvMqPd3y1oM5a2qnu+uU
         haglsHvM4z1D26sDJgQNfoiOUV3GDMBFGXspCVKkIsT354xjoA9Sl3I48b0AZ7MXDrOT
         frodvt4946cMvC11hIdJG6dbdnehswthb1JticfgsC/PP3lYquyA+xeF/M62EjxkGyyx
         gwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y9c6bt0GAIfK0d/+y4nN3bHy18xEra789xR4CFLrN48=;
        b=sevpVAbgt0VDWkVd+2jrXtgnN00xO6BzvFPt0Xl8Spw7PytmiRRxgpoW78NzBobjO4
         6d4pTSqAvO5Ha1KUjtgWWzrIKTZl/J3/pVzSOceyETnVAiHQ//6qXBMJVZQ1lYUGjqL/
         1s8zPwDZi/kobhCfRdrvk65wa98ZzjofW24s1NrHmzNbjZErFqcpnzBdVRMU/COtFzZq
         t2ZRAi9xaz84/zaglQU8l+ekaOCDNAKKI9vNxBpdBkNyGEsmofsHuUqlvggwMh8sWTOz
         SCLDhLzmcaS8XLF2TWT8XJ5erGe0js/enVIWZPBMy3+zinfyOQa6aKksX4qAvpb2s0JW
         coJg==
X-Gm-Message-State: AOAM531pvP19jhjIv6Led3CHLX+HbVTXW2/bo9Bm7LoZimscjpZBMAlS
	veMC/s7mMIotzcp1fLSRaY/hDE8ItD4ZYjFQSiZtOpXcLi251g==
X-Google-Smtp-Source: ABdhPJxpJq/GjefuA8XYCDkS/VkR+vU6P+/mvjnN7qhXnoBnu9LfeDYfim1E/pmb2EJ9z4R9reuzeYYC6Gi9KqAbDSI=
X-Received: by 2002:a63:f751:: with SMTP id f17mr40114688pgk.373.1626946133616;
 Thu, 22 Jul 2021 02:28:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67cd742a1da03b8633e4837c45991860236af431.1626857584.git.geliangtang@gmail.com>
 <63bcc8e8-cd71-a117-cf9b-dc0054336e26@tessares.net>
In-Reply-To: <63bcc8e8-cd71-a117-cf9b-dc0054336e26@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 22 Jul 2021 17:28:42 +0800
Message-ID: <CA+WQbwt1_O9btFtCLo+hw2JpeaX3EXtMR8scVrDW+YPtCAmgpQ@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "selftests: mptcp: add
 testcase for active-back"
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B47=E6=
=9C=8822=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:55=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Geliang,
>
> On 21/07/2021 10:56, Geliang Tang wrote:
> > Drop the debug logs and make the output aligned:
>
> Good idea!
>
> > 05 backup flow used, bidi, link failure syn[ ok ] - synack[ ok ] - ack[=
 ok ]
> >                                         add[ ok ] - echo  [ ok ]
> >                                         stale             [ ok ]
> >                                         link usage        [ ok ]
>
> I wonder if it would not be even clearer to display one item per line, e.=
g.:
>
>
> 05 backup flow used, bidi, link failure:
>      syn        [ ok ]
>      synack     [ ok ]
>      ack        [ ok ]
>      add        [ ok ]
>      echo       [ ok ]
>      stale      [ ok ]
>      link usage [ ok ]
> 06 (...)
>

I think the original display is much better than one item per line. Since
it put the related items in one line, and do the different tests in each
line. I think that's more clearer than one item per line. Do you agree?

> But that is for another patch anyway. I can look at that later when
> trying to make this test more reliable by removing fixed values for
> "sleep" and others if nobody is already looking at that.
>
> >
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/te=
sting/selftests/net/mptcp/mptcp_join.sh
> > index 220154cb92a7..d0518487b874 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -228,7 +228,6 @@ link_failure()
> >
> >       for l in $FAILING_LINKS; do
> >               veth=3D"ns1eth$l"
> > -             echo "link $veth down" 1>&2
> >               ip -net "$ns" link set "$veth" down
> >       done
> >  }
> > @@ -634,7 +633,7 @@ chk_stale_nr()
> >       local stale_nr
> >       local recover_nr
> >
> > -     printf "%-39s %s" " " "stale"
> > +     printf "%-39s %s" " " "stale             "
> >       stale_nr=3D`ip netns exec $ns nstat -as | grep MPTcpExtSubflowSta=
le | awk '{print $2}'`
> >       [ -z "$stale_nr" ] && stale_nr=3D0
> >       recover_nr=3D`ip netns exec $ns nstat -as | grep MPTcpExtSubflowR=
ecover | awk '{print $2}'`
> > @@ -878,7 +877,7 @@ chk_link_usage()
> >       local tx_rate=3D$((tx_link * 100 / $tx_total))
> >       local tolerance=3D5
> >
> > -     printf "%-39s %s" " " "link usage "
> > +     printf "%-39s %s" " " "link usage        "
>
> Do you mind if I change this when applying the patch to avoid plenty of
> spaces?
>
>   printf "%-39s %-18s" " " "stale"
>   printf "%-39s %-18s" " " "link usage"

It's much better to avoid spaces like this, thanks Matt.

-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
