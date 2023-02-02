Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAD17F
	for <mptcp@lists.linux.dev>; Thu,  2 Feb 2023 07:55:20 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so669632wms.1
        for <mptcp@lists.linux.dev>; Wed, 01 Feb 2023 23:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mDloKOdb+UcSZ0cVXnNXofdWWtrYWw2cpclBqmIVfQ=;
        b=cPRRf6WT/mGPAEAP1nQh+u0rzynU7XcgTq/SKH4PAVLoEnfMuXkMJ/Zmll2jP2PMr6
         rXr1PaY8XFlof70u9sIp2S2F86yV2s/zeYB6Gdzo9+nsBCxl4Brz6w4SWJHkAOnjGfDy
         XVdEYf39WCjfzWRzXEJIE6TaiBUEZE+XLn8z/RC4wotFTxesRgdmzE/lIioyZg/jlXeA
         MzB+VM2rSvXFoGahKsB5DshBi8qWTWq71VCBwI1qWMHvvCdQn6i4jdZV6bwVyyFyf/vA
         GTcZ0zvLHQXsD1x0ozs7BoL99IdjXAcYCgS/BRdTzp8AL6t1VAwI64/GeC91YnMpM87E
         g+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mDloKOdb+UcSZ0cVXnNXofdWWtrYWw2cpclBqmIVfQ=;
        b=S+gK/Hw8hANd/SZ0Cv7Xb/P+8wlz3x2/BS3BAAxl4MEnIxcYh9vauC+naqjAr7/IMO
         OryoLaU1Jmq3RaEuoL1dA500Sw/vmxrmqdymkelr6NaifDs56wcCbYnGA/zs+QfcMclG
         G6Fte4eZmD52a1cRKUu6rjEgMOcbvLiKw9ZNBlFg100ENeP5SsrQT/RwSUKoWXY12iiW
         P9bZmwiljtzFh4Vwu6LwowrSPV+Nt0AiTtZLYmkgYJKA5Hjtf6LgzidMvEqHTGYqoAGs
         7yemDx+WnpqHhvc4DO/KKDNhPk6AyUVFmI9n6yS0JjY2qHUIe0C6jxpj0n9586E7u1Bx
         n63w==
X-Gm-Message-State: AO0yUKUFlGphUMgqppZko8tj5Q0moU4WB/WBFVQX5S9cLbNx3LpoU3Gx
	dxn3c7yTdYns8ci6muMYOAN/ufE3NzOy0w46hsc=
X-Google-Smtp-Source: AK7set9Q9d12rhZQjoPSwsQYtgJMG+iLOEygCDwb+2C2+rYDcWBAab0Kye4auaoFldzf0F+l9PXVC3mKehKL4xIv0/0=
X-Received: by 2002:a05:600c:3513:b0:3cf:7b68:631 with SMTP id
 h19-20020a05600c351300b003cf7b680631mr98388wmq.55.1675324518083; Wed, 01 Feb
 2023 23:55:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
 <20230131-mptcp-issue-323-join-delete-re-add-v2-1-8de2421163c9@tessares.net>
 <CA+WQbwuB9jMnbnPKT8z0KeWT56upWOG9tKhOCPCU1f4uAkTwqA@mail.gmail.com> <498f5acc-df60-7599-6a59-918f3a7c5027@tessares.net>
In-Reply-To: <498f5acc-df60-7599-6a59-918f3a7c5027@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 2 Feb 2023 15:55:54 +0800
Message-ID: <CA+WQbwvYejU7FOD9PjNFjB7uk4DNQK2C0s-Ur=xH-K1ym3ehsg@mail.gmail.com>
Subject: Re: [PATCH mptcp-net v2 1/2] selftests: mptcp: allow more slack for
 slow test-case
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B42=E6=
=9C=881=E6=97=A5=E5=91=A8=E4=B8=89 18:22=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 01/02/2023 06:14, Geliang Tang wrote:
> > Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B41=
=E6=9C=8831=E6=97=A5=E5=91=A8=E4=BA=8C 19:23=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> From: Paolo Abeni <pabeni@redhat.com>
> >>
> >> A test-case is frequently failing on some extremelly slow VMs.
> >> The mptcp transfer completes before the script is able to do
> >> all the required PM manipulation.
> >>
> >> Address the issue in the simplest possible way, making the
> >> transfer even more slow.
> >>
> >> Additionally dump more info in case of failures, to help debugging
> >> similar problems in the future.
> >>
> >> Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases"=
)
> >> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/323
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >> ---
> >>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++--
> >>  1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_join.sh
> >> index 387abdcec011..52484a7c286a 100755
> >> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >> @@ -1687,6 +1687,7 @@ chk_subflow_nr()
> >>         local subflow_nr=3D$3
> >>         local cnt1
> >>         local cnt2
> >> +       local dump_stats
> >>
> >>         if [ -n "${need_title}" ]; then
> >>                 printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" =
"${msg}"
> >> @@ -1704,7 +1705,12 @@ chk_subflow_nr()
> >>                 echo "[ ok ]"
> >>         fi
> >>
> >> -       [ "${dump_stats}" =3D 1 ] && ( ss -N $ns1 -tOni ; ss -N $ns1 -=
tOni | grep token; ip -n $ns1 mptcp endpoint )
> >> +       if [ "${dump_stats}" =3D 1 ]; then
> >> +               ss -N $ns1 -tOni
> >> +               ss -N $ns1 -tOni | grep token
> >> +               ip -n $ns1 mptcp endpoint
> >> +               dump_stats
> >> +       fi
> >
> > Hi Matt,
>
> Thank you for the review!
>
> > Does this work:
> >
> > [ "${dump_stats}" =3D 1 ] && ( ss -N $ns1 -tOni ; ss -N $ns1 -tOni |
> > grep token; ip -n $ns1 mptcp endpoint; dump_stats )
> >
> > This is more like the original code.
>
> This works indeed but I think it was a good idea from Paolo to switch to
> a clear 'if' statement for two reasons:
>
> - It is easier to read than having quite a few other commands on a
> single line. If only 'dump_stats' function was invoked, that would have
> been fine.
>
> - If 'dump_stats' var is not 1 and because this is the last instruction
> of the function, chk_subflow_nr will cause the returned code to be !=3D 0=
.
> That's fine here because 'set -e' is not defined and the returned code
> is not checked but still, that's not ideal, better to avoid that with a
> clear "if" I think.
>
> So I think we should keep the patch as it is, no?

Sure.

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
