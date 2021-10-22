Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4F68
	for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 07:37:48 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so7210218pjd.1
        for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iZUc5qJguuQZ04tTpaUep5/uSixVlIrinB1g0Hz4GSQ=;
        b=Gx+FFXKKUaqEFCLeE1wvfLCrqZP67rsTNVO6T0ZettAXk0MnEXkenlE+7jl/ve9S9H
         Z+JL87LVcRozB24SusdUhaUpoJmoVgHUdyH4tWwm6SJZjAQLpW4fLT9EnMYxXLSCXBND
         ZfqflZOeWjxW3oa7XoHKtUpYRqmwoRTOlZUBl5/PYuXwYWfL+3wCthq2FjnyucnqmuDb
         RWl6fVI9NQ9JwQOhZHbmTFc4XVfIiGhw9exQOXgaQ+Bxk6hAqfSpxjHDUUSib6e/euzN
         uJaPUXkRjp8ZkE+xf3kHdo7pY5qmUrOjyG0FDTiH+vYl+Q+Xe5kqRzi5p/D2oY3b4xoo
         ZIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iZUc5qJguuQZ04tTpaUep5/uSixVlIrinB1g0Hz4GSQ=;
        b=Z6ZBxbtTkabz/vNIGm25hf/SBe97pLisBXaLRjY6Ft4GBFxSaH75nmv3Ww+IOCqz7D
         lrDei0y27ZKHWobbk5a5tsXyI19tlYPKRouxV6ZRn8zn5UKeQ9/927GbYCQOgXySCN/i
         8SL6BNvlSpysjkc2dgeh+ooj0D+iIgP9/Z5CbxxTybHpAJMp0QGsyOlY7AKaqGWROtkn
         Uj2n9+5+Z9py6JEJkerUqgTIrcWxxYYQ2xTrTuhtT3RA8v8k/Lpc4vUKqn2fLWQSsL4m
         9eQNNDq1k1nfwkvFgV3h8KvVXTDVEE1hKK9K+gwKKGytYzMp3K7RFORLkVlZIORLnYc1
         G5Qw==
X-Gm-Message-State: AOAM530gYkRLGl0i2fz/hKV7l1JIBFTa2eSbLJ4dNu6hswTQSa+p7HMV
	JFNxgkFX9M+mBDW/u8gVH4x+uWnqcE1rsGe8RImculJnshtueQ==
X-Google-Smtp-Source: ABdhPJwXTNAKn6l1Z+90uHxTM25Ezja/kJ2H0mXSHEMahefuqMRC/9Mm0zBL0X55rBSjKNm+bpZAq7vnFyvqH67+rWI=
X-Received: by 2002:a17:90a:f013:: with SMTP id bt19mr13058861pjb.82.1634888268395;
 Fri, 22 Oct 2021 00:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1634531093.git.geliang.tang@suse.com> <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
 <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com> <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
 <YW6BzNwiyR9i8KSQ@dcaratti.users.ipa.redhat.com> <f61714c1-09cb-e4a0-f78c-5294bcaea890@tessares.net>
 <CAKa-r6vQo+=tQDMRkyG2xczR8wMYPufRD4LU7Xj9+xbP2zVWGw@mail.gmail.com>
 <8d7963f3-1983-0086-dcbe-16e950230f0a@tessares.net> <YXEwoTyTQxN3dcQx@dcaratti.users.ipa.redhat.com>
 <a025ed1d-eb63-b5df-9f38-77487f72d5e0@tessares.net>
In-Reply-To: <a025ed1d-eb63-b5df-9f38-77487f72d5e0@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 22 Oct 2021 15:37:38 +0800
Message-ID: <CA+WQbwsM-27sNRKbb-whDWbA-+Gg1H=mtjS83ELn3Y+m4Wx=oQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Davide Caratti <dcaratti@redhat.com>, Geliang Tang <geliang.tang@suse.com>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt, Davide,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B410=E6=
=9C=8821=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:51=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Davide,
>
> On 21/10/2021 11:19, Davide Caratti wrote:
> > On Wed, Oct 20, 2021 at 04:49:35PM +0200, Matthieu Baerts wrote:
> >> Hi Davide,
> >>
> >> On 20/10/2021 13:33, Davide Caratti wrote:
> >>> hi,
> >>>
> >>> On Wed, Oct 20, 2021 at 12:40 PM Matthieu Baerts
> >>> <matthieu.baerts@tessares.net> wrote:
> >>>>
> >>> [...]
> >>>
> >>>>>
> >>>>> I had a script that used TC flower and gact + pedit + csum actions =
to flip the 'PSH'
> >>>>> bit in the TCP header, I promised myself to change it to corrupt th=
e DSS option.
> >>>
> >>> FTR, that script was:
> >>>
> >>> # convert PSH,ACK into ACK
> >>> # tc filter add dev vetha egress protocol ip prio 1000 flower ip_prot=
o
> >>> tcp tcp_flags 0x18/0xff action pedit ex munge tcp flags set 0x10 pipe
> >>> csum tcp reclassify
> >>> # convert ACK into PSH,ACK, 1 each 10 packets
> >>> # tc filter add dev vetha egress protocol ip prio 1001 flower ip_prot=
o
> >>> tcp tcp_flags 0x10/0xff action pass random determ pipe 10 pedit ex
> >>> munge tcp flags add 0x8 pipe csum tcp
> >>
> >> Thank you for sharing that.
> >>
> >> I managed to change the content of a TCP packet using:
> >>
> >>   $ tc -n <ns> qdisc add dev <iface> root handle 1: htb
> >>
> >>   $ tc -n <ns> filter add dev <iface> parent 1: protocol ip prio 1000
> >> flower ip_proto tcp action pedit munge offset 148 u32 invert pipe csum=
 tcp
> >>
> >> It looks like nothing happen for packets smaller than 148 bytes.
> >>
> >> Note that I had to add these to the config file:
> >>
> >
> >> CONFIG_NET_SCH_HTB=3Dm
> >
> > I assume you are using HTB because it's a classful qdisc and it's used =
to
> > attach the flower classifier. You don't need it, just use the clsact
> > qdisc (CONFIG_NET_CLS_ACT=3Dy + CONFIG_NET_SCH_INGRESS=3Dy), it will al=
low
> > you inserting filters+actions even if no root qdisc is in place.
> >
> > # tc qdisc add dev eth0 clsact
> > # tc filter add dev eth0 egress matchall action simple sdata "hello"
>
> Great, I don't know well this obscure tc :-)
>
> So we should do instead:
>
> $ tc -n <ns> qdisc add dev <iface> clsact
> $ tc -n <ns> filter add dev <iface> egress \
>   protocol ip prio 1000 \
>   flower ip_proto tcp \
>   action pedit munge offset 148 u32 invert \
>   pipe csum tcp
>
> Right?
>
> >
> >>
> >> CONFIG_NET_ACT_CSUM=3Dm
> >>
> >> CONFIG_NET_ACT_GACT=3Dm
> >>
> >> CONFIG_GACT_PROB=3Dy
> >>
> >> CONFIG_NET_ACT_PEDIT=3Dm
> >>
> >> CONFIG_NET_CLS_FLOWER=3Dm
> >>
> >>
> >> @Geliang: do you think you could use this command?
> >>
> >>>>> The problem with this approach is, we can't assume that the DSS opt=
ion has a fixed
> >>>>> offset from the IP header. So, the test might start corrupting othe=
r options that
> >>>>> are not MPTCP.
> >>>>
> >>>> If we corrupt any data in TCP Options or data and update the TCP
> >>>> Checksum, that's enough to corrupt the DSS. For example, we could fl=
ip
> >>>> the last bit of the TCP payload (if tcp.len > 0). Would it be possib=
le
> >>>> to do this by adapting your script?
> >>>
> >>> it's easier if it's the first bit, then...
> >>>
> > [...]
> >
> >>>> And using simple solutions like "tc netem corrupt" will be detectabl=
e by
> >>>> TCP csum.
> >>>
> >>> this can be easily workarounded using the 'csum' TC action after the
> >>> netem dequeue.
> >>
> >> Good point! So we would need to create a tree with first "netem" then
> >> "csum" action?
> >
> > the problem is, netem acts *after* TC actions. But probably in your
> > setup you can overcome this by making netem corrupt when xmitting, and
> > install the TCP csum  at  the receiver ingress (also here clsact is
> > helpful):
> >
> > # ip link add name vetha type veth peer name vethb
> > # tc qdisc add dev vetha root netem <...>
> > # tc qdisc a dev vethb clsact
> > # tc filter add dev vethb ingress protocol ip flower ip_proto tcp actio=
n csum tcp
>
> Thank you for the explanations and the commands :-)
>
> >> The only thing is that netem will introduce errors at random positions=
,
> >> maybe in IP/TCP headers but it is maybe not an issue. If the TC filter
> >> command is enough, it might help to produce more controlled tests.
> >
> > maybe TC flower + action is even more accurate then netem: because it l=
eaves
> > you the freedom to "corrupt" only packets after the 3WHS (or only the 3=
WHS,
> > depending on the match arguments of flower).
> > You can obtain the same randomization as netem by using TC "act_gact" r=
andom
> > feature ("CONFIG_GACT_PROB=3Dy")
> >
> >  # tc filter add dev vetha egress protocol ip prio 1001 flower \
> >   > ip_proto tcp \
> >   > tcp_flags 0x10/0xff \ <-- only the ACK BIT is set
> >   > action pass random determ pipe 10 \    <-- 1 packet every 10 goes t=
o pedit, others go out unmodified
> >   > pedit munge offset 148 u32 invert pipe csum tcp <-- corrupt the pay=
load and recompute checksum
>
> Good point!
> I don't know if Geliang wants to have all packets transporting data that
> are being corrupted or a random one out of X packets or only a specific o=
ne.

I want to have only a specific packet to be corrupted, like sending 10
unmodified packets, then sending 1 corrupted packet, then sending 10
unmodified packets. How can I do this?

Thanks,
-Geliang


>
> >> Indeed it looks like it is doable but if we could not add new
> >> dependences, I think that would be easier for us :)
> >
> > Whatever works, it's good also for me :)
>
> :)
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
