Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A101111
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 08:10:48 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f18dacd392so32294525e9.0
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 01:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682410247; x=1685002247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmDdL4LvdpZx2s8DnEmiVkIieidKk0qYCcCfZs/IEHQ=;
        b=Lc0g4aTEnyL/9j00iu1oE856ZxHMAO/Y/h+kt3AP49RjwS73tsnsIvKitrAhEMtx52
         3zDxPz4vPmDzpJXA9hijN20/9y1+cDtnxov9UlFYDgm8IBVoALS/BkM4tCq0wgN1JEJ8
         l+bBS806o2oeSVSA4MIa0YBf3QL+RMoei5Fg3ovLJ30uej2IXXLCuAIwbd3oVuctkO7M
         agIyxmlzudrDXBnb061oNqcmccSG40gAzFY8ZyLMyJ60/GrbL3XkIE8bgzqvpUp9iS1y
         fDPzUl1CA8mkK+5KbgJQ3u295+8a1Tw3mk2lhRYGvkF6semU8+K6SGLNE954aXcf5U//
         w9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682410247; x=1685002247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmDdL4LvdpZx2s8DnEmiVkIieidKk0qYCcCfZs/IEHQ=;
        b=DhvFsQ5EfDN5qw7OnLr+d+6+481Vwg1qFU/4buC2Qs5XKw2C4aHgN/gDNt66uZTi0L
         X2Ta3P5wOE4ALQeD9qQBA5pO0vy+Gi2m3Kqk2SCytZ1/FX3k0UIvN7rVb2uoNDF8WhKW
         WZ5DQCJ7/4aj3PRkJNVnvv7oppJJiyMMuW9nJYAfr6/g+bsWJ3ckD34w5jjTKcynLIP6
         r9FlfsJ1xs3d74QbIXWHKhmJAupx1x2V51fquEPPVu3/bBQto6w1FcW/Ux4JoAYdx/OP
         5VnQIL/nprahqlWozn9WD4vS/B6ZGzbVPmC6ng39e1/dZjq12QStWHqX6+teRZGMr5xJ
         wJTA==
X-Gm-Message-State: AAQBX9cqx2mSnRmLo5WX1wJLUZdyXTXRqNpfnOEVorAfGED3kbtv8FbM
	PsOhWSdq05Vg2M2ceyUx6rkCwfDguMS3V8b5xkA=
X-Google-Smtp-Source: AKy350YL/VRajnKdgTHvuiDVyHPoxmD2S4H6VGCpFtoEAmYSBvTrW8UR1j9gfPc+KP0sAAm+9xKnkZ49P5mjzIiyfI4=
X-Received: by 2002:a05:600c:ac1:b0:3f0:8108:406 with SMTP id
 c1-20020a05600c0ac100b003f081080406mr9539557wmr.28.1682410246646; Tue, 25 Apr
 2023 01:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1681960259.git.geliang.tang@suse.com> <177f9ca7d30f810324bf46705ac7d977461ffc2d.1681960259.git.geliang.tang@suse.com>
 <95c4951a-5131-eba2-ad19-11fc4d2c6b31@tessares.net>
In-Reply-To: <95c4951a-5131-eba2-ad19-11fc4d2c6b31@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 25 Apr 2023 16:10:38 +0800
Message-ID: <CA+WQbwuTQ3OG3acg38MwtCUNRUSA0HArDqM4ntc3an6+oOwdDQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v8 5/5] selftests: mptcp: update userspace pm
 subflow tests
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2023=E5=B9=B44=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 22:17=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Geliang,
>
> On 20/04/2023 05:11, Geliang Tang wrote:
> > Update userspace pm subflow selftests, by sending the a remove_addrs
> > command together before the remove_subflows command. This will get a
> > RM_ADDR in chk_rm_nr().
>
> (what's the reason? To align with what is done by the in-kernel PM?)
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/te=
sting/selftests/net/mptcp/mptcp_join.sh
> > index 9a9b6e9b28ab..795c141a11f5 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -923,6 +923,7 @@ do_transfer()
> >                               sleep 1
> >                               sp=3D$(grep "type:10" "$evts_ns2" |
> >                                    sed -n 's/.*\(sport:\)\([[:digit:]]*=
\).*$/\2/p;q')
> > +                             ip netns exec ${connector_ns} ./pm_nl_ctl=
 rem token $tk id $id
>
> Also here, probably better to remove the subflow, and then send the
> ADD_ADDR not to have the other peer closing the subflow before the next
> step here below.

Updated in v9.

>
> But I guess it will not be possible to send the destroy after the remove
> because we will remove the local address from the list, no?
>
> Maybe better not to test that then? I mean: I don't really see why the
> client would need to send a remove address if the subflow was still
> working well. It would send a remove address if the linked local address
> got lost (e.g. link down) but why doing both?

We need to not only close the related local subflow, but also sending
a remove address to close the subflow on the other side.

Thanks,
-Geliang

>
> Cheers,
> Matt
>
> >                               ip netns exec ${connector_ns} ./pm_nl_ctl=
 dsf lip $addr lport $sp \
> >                                                                       r=
ip $da rport $dp token $tk
> >                       fi
> > @@ -3137,7 +3138,7 @@ userspace_tests()
> >               pm_nl_set_limits $ns1 0 1
> >               run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
> >               chk_join_nr 1 1 1
> > -             chk_rm_nr 0 1
> > +             chk_rm_nr 1 1
> >               kill_events_pids
> >       fi
> >  }
>
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
