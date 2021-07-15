Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70770
	for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 03:46:01 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id p17so2480876plf.12
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 20:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YFKV2Lf2O5a3V0Xy5m4negKlqLzFJvsCUU8S2tvLzLo=;
        b=Sky3+AqGUAUJzTN/+Yn/g6f6mGIwCwPivRcmI8t/jH2e3YU8woYSr7/SyBM6v+gO+h
         UjNHSTDbULrmAyCg8igIoBgnigbgM+0rLTeSR7MhBkcI7ttRi/PcO2VzyzEd3aIhCIIU
         rc6uerkFrhwS9qwsBVkk1SAwNNQAr1vLUDv+dLfW4pJ7oEv+S2fRRYO73AuNnIFXbhUT
         H2HdDNUOquz8vBlSuzCRoHsWHfiTXUhpXFnADaovMYuHefp90Pqp/v+GxfHF/e1ZR0JN
         W4EBSniF0v0bOsIKKpSQFMy6kFPi8KkqPoww0JzeoA5mZR5fgBm0MDFdjsJ4bRAP4oTj
         mApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YFKV2Lf2O5a3V0Xy5m4negKlqLzFJvsCUU8S2tvLzLo=;
        b=ac9dCgkwMn+kmwv4sNpmBOKHa2n+t4jAgjNKhkUpE6x1oPtPR7f0uUVSYRPqTL7phK
         5rjYfDlHr5ac/amAAMPk7RopVJ9JJ9ADXvRn62y30iQM+5BhK9JE2/7UmaEui1B50SPE
         lOrGtt4vLrh0W1E/nEKunXqrvY0LOLwmsyaTvHyBWVw2MRei1xr4WTwlXdgWZnvXpeM7
         M8syBpJtT+pz30kKJWWCItZD1iFafVVBvLuYxpw3zKaGhi8jWaltNtclusbatsfUVjPO
         AwBxSDQ2LvbSSeeowRP8r56VrzewyEdBip+6ji9Fnbmst3EKGUmi67KDKptZGp4u/HLO
         2jpQ==
X-Gm-Message-State: AOAM530/qqOpZM9y6X6xcCvd2Zx5DvZp9z4A6V47VdRbrprkNO07p9fd
	6GKK/Z0n+EmNpuRGVCGqp4fVixwPRubh166oxbs0Gn5k6a0=
X-Google-Smtp-Source: ABdhPJxnojrCQBznjQYY8yWYcaY+b4QRj6rr8xxrrde2HlC1LyMBI3cj8QswnYA1V7G7dHeaiGLH/Lpcp7J0l6C40Ro=
X-Received: by 2002:a17:902:6bc7:b029:129:20c4:1c33 with SMTP id
 m7-20020a1709026bc7b029012920c41c33mr1600609plt.52.1626320760835; Wed, 14 Jul
 2021 20:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
 <7eaa18f3391aa9862bb8274f6288ed1888af8f72.1626158161.git.geliangtang@gmail.com>
 <1e219d3d-9ea5-26ec-ae2c-dac4563bd345@chinatelecom.cn> <CA+WQbwtK0expftc6LPrLY701iippBZ3f7EMoTKR=WTu5p1qxjg@mail.gmail.com>
 <f7ef8d86-d644-89c5-6153-f9fb4f31b897@chinatelecom.cn>
In-Reply-To: <f7ef8d86-d644-89c5-6153-f9fb4f31b897@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 15 Jul 2021 11:45:49 +0800
Message-ID: <CA+WQbwsJJyzpCH8-uiNj9mkd=xHHtk5kq-8ooxJCdN4sRqqkYA@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: remove
 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT"
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=8814=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:49=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi Geliang,
>
> On 2021/7/14 11:10, Geliang Tang wrote:
> > Hi Yonglong,
> >
> > Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8813=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:30=E5=86=99=E9=81=93=
=EF=BC=9A
> >>
> >>
> >>
> >> On 2021/7/13 14:44, Geliang Tang wrote:
> >>> Keep the debug info for "send ack".
> >>>
> >>> Don't drop mptcp_pm_should_add_signal_ipv6() and
> >>> mptcp_pm_should_add_signal_port().
> >>>
> >>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> >>> ---
> >>>  net/mptcp/pm_netlink.c | 7 +++++--
> >>>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> >>> index 3e35720317ae..2cd6caaedb08 100644
> >>> --- a/net/mptcp/pm_netlink.c
> >>> +++ b/net/mptcp/pm_netlink.c
> >>> @@ -543,8 +543,11 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock=
 *msk)
> >>>               bool slow;
> >>>
> >>>               spin_unlock_bh(&msk->pm.lock);
> >>> -             pr_debug("send ack for %s",
> >>> -                      mptcp_pm_should_add_signal(msk) ? "add_addr" :=
 "rm_addr");
> >>> +             pr_debug("send ack for %s%s%s",
> >>> +                      mptcp_pm_should_add_signal_addr(msk) ? "add_ad=
dr" :
> >>> +                      (mptcp_pm_should_add_signal_echo(msk) ? "add_e=
cho" : "rm_addr"),
> >>> +                      mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6=
]" : "",
> >>> +                      mptcp_pm_should_add_signal_port(msk) ? " [port=
]" : "");
> >>>
> >>>               slow =3D lock_sock_fast(ssk);
> >>>               tcp_send_ack(ssk);
> >>>
> >> Hi Geliang,
> >>
> >> I think the debug log will be incorrect if add_addr and add_echo event=
s trigger at the same time.
> >> WDYT?
> >
> > Yes, how about moving this pr_debug line under the pm lock, just swap t=
his
> > pr_debug line with the spin_unlock_bh line?
> >
> > If so, no need to use READ_ONCE() in mptcp_pm_should_add_signal_ipv6/po=
rt
> > too.
> I prefer to remove ipv6 check just like v8. if you want to debug we can g=
et more detail info
> from debug log in mptcp_established_options_add_addr.

Sure, I had removed mptcp_pm_should_add_signal_ipv6/port in v9.

>
> >
> >
> > I had tested this squash-to patches all night yesterday. And I got this
> > error in the debug log:
> >
> > add_signal error, add_addr=3D2, echo=3D1
> >
> > This means the race occurs, right?
> >
> It seams like anther race case or bug? if more than one 'echo add addr' e=
vent be trigger at the same
> time this log will be show.

And I had used your testcase to test v9 all night yesterday, and everything
is fine, no this error anymore. It has been tested over 18000 times. So I
think v9 works well. I'll do more test and send out v9 recently.

Do you think 18000 times is enough?  How many times do you usually test
before?

>
> > Does it mean that this version cannot deal with the race either? I'm no=
t
> > sure.
> >
> > Could you please share your test scripts to me?
> >
> I add a test case in mptcp_join.sh, and run 'mptcp_join.sh -X -c' in a lo=
op, if test case failed the race maybe occurs.
> and then analsys the pcap file to check the race.
>
> the test case add in mptcp_join.sh:
>
> diff --git a/mptcp_join.sh b/mptcp_join.sh
> index 523c779..162a451 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1462,6 +1462,24 @@ checksum_tests()
>         chk_csum_nr "checksum test 1 0"
>  }
>
> +xxoo()
> +{
> +       reset
> +       ip netns exec $ns1 ./pm_nl_ctl limits 4 4
> +       ip netns exec $ns2 ./pm_nl_ctl limits 4 4
> +       ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags signal
> +       ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +       ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
> +       ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags signal
> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags signal
> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
> +       run_tests $ns1 $ns2 10.0.1.1
> +       chk_add_nr 4 4
> +}

I think this testcase is worth to be added into the selftests script at
the end of the function signal_address_tests() as an extra signal address
test. Do you agree?

If so, I'll add this testcase into v9 and sign your name as the author.

Thanks,
-Geliang




> +
> +
>  all_tests()
>  {
>         subflows_tests
> @@ -1566,6 +1584,9 @@ while getopts 'fsltra64bpkchCS' opt; do
>                 S)
>                         checksum_tests
>                         ;;
> +               X)
> +                       xxoo
> +                       ;;
>                 c)
>                         ;;
>                 C)
>
>
> > Thanks,
> > -Geliang
> >
> >
> >
> >>
> >> --
> >> Li YongLong
> >
> >
>
> --
> Li YongLong
>
