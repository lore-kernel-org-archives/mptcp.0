Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63332C80
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 09:17:14 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id kk10so77672pjb.1
        for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E94L2TkoJSgfmZ2JI+fCDzpKWVpxXeI3vnmutCMU9jc=;
        b=Z2NyfGbOQ5bs5ESYVWWbfVPefH0s7Rbrz4oQs4cwvbPHG7Lx9GeC/gJeJD9fxoOClz
         p2fKsIscTqQcxS6C+shXVk8/fUAEdS//envPgToL6RfrmkaDc/No418MmHrlnIQ8C5s5
         M/uVppQXePxdG7pTcMr+dEVL1kNiSe5XIkOkuLXixes/xxe+JZJ4xN7Q3WyJhGmF8byW
         z3XrdAade0xnYqevq/B698eYMU0bFGD3TjrfRER8sPXm9Fotpokr+G4TxOsu1vrT4NwB
         9IDtGSBOeaKmO5sd50lIRfl9JEjQVq5llaM3/LaOBFpWT+O7sM+nheyBw6k1nPg1HyIG
         4LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E94L2TkoJSgfmZ2JI+fCDzpKWVpxXeI3vnmutCMU9jc=;
        b=OtEMLN+CzbNht0Dh4N4Tqjm8vVjKnXRB0X/afAlm8tcL4NMzv/RQc4JfRiIxpAEYnU
         C3xJ15Y/jLpPKk7iMy0lWGfigQic4fD8OIgbmNEqQgYa92Wk6V/lStrg/+Tlqa8esECE
         G0hI9x4GIBo25QrFhyXrrbNCW+rL0Nh6e2d76NtzWhwN0GkO6Qt2jM7TU4c0HqrkHo7L
         QOMCZ3ki6ftq74zC/VSE1JNsH9t6L0nPrhcywkvRcTSksCTkKwePFswvqyZOWLueVORF
         oUzY4x+t8vKTY3RQ2cRNaDyZHlFeXQALE5GzbtSka04aHBtrfIXEVNjdWVwIbMZ56eX1
         prAQ==
X-Gm-Message-State: AOAM5307X8qNlCVhm0Lcs8bttvT/Nnig19U3iGNm5a395PUX873UF/M4
	5BrMj257G2AK8INAw9BLB7Ju6xxVd8O44bMYA1c=
X-Google-Smtp-Source: ABdhPJzI1K4/PEFZ/8CxUqCm8y7yjxRKEPfWoXBZhssWhaIfCUBQCHvx838ALf6FvyCyKeeK7nKoxAQFB47pVu0yqjQ=
X-Received: by 2002:a17:90a:f013:: with SMTP id bt19mr5548231pjb.82.1634807834314;
 Thu, 21 Oct 2021 02:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1634531093.git.geliang.tang@suse.com> <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
 <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com> <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
 <YW6BzNwiyR9i8KSQ@dcaratti.users.ipa.redhat.com> <f61714c1-09cb-e4a0-f78c-5294bcaea890@tessares.net>
 <CAKa-r6vQo+=tQDMRkyG2xczR8wMYPufRD4LU7Xj9+xbP2zVWGw@mail.gmail.com> <8d7963f3-1983-0086-dcbe-16e950230f0a@tessares.net>
In-Reply-To: <8d7963f3-1983-0086-dcbe-16e950230f0a@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Thu, 21 Oct 2021 17:17:03 +0800
Message-ID: <CA+WQbwu2O_trJ2=3rjT9aVASThDPaFd73Mi5Wq3LMJzonPA-TQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Davide Caratti <dcaratti@redhat.com>, Geliang Tang <geliang.tang@suse.com>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B410=E6=
=9C=8820=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:49=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Davide,
>
> On 20/10/2021 13:33, Davide Caratti wrote:
> > hi,
> >
> > On Wed, Oct 20, 2021 at 12:40 PM Matthieu Baerts
> > <matthieu.baerts@tessares.net> wrote:
> >>
> > [...]
> >
> >>>
> >>> I had a script that used TC flower and gact + pedit + csum actions to=
 flip the 'PSH'
> >>> bit in the TCP header, I promised myself to change it to corrupt the =
DSS option.
> >
> > FTR, that script was:
> >
> > # convert PSH,ACK into ACK
> > # tc filter add dev vetha egress protocol ip prio 1000 flower ip_proto
> > tcp tcp_flags 0x18/0xff action pedit ex munge tcp flags set 0x10 pipe
> > csum tcp reclassify
> > # convert ACK into PSH,ACK, 1 each 10 packets
> > # tc filter add dev vetha egress protocol ip prio 1001 flower ip_proto
> > tcp tcp_flags 0x10/0xff action pass random determ pipe 10 pedit ex
> > munge tcp flags add 0x8 pipe csum tcp
>
> Thank you for sharing that.
>
> I managed to change the content of a TCP packet using:
>
>   $ tc -n <ns> qdisc add dev <iface> root handle 1: htb
>
>   $ tc -n <ns> filter add dev <iface> parent 1: protocol ip prio 1000
> flower ip_proto tcp action pedit munge offset 148 u32 invert pipe csum tc=
p
>
> It looks like nothing happen for packets smaller than 148 bytes.
>
> Note that I had to add these to the config file:
>
> CONFIG_NET_SCH_HTB=3Dm
>
> CONFIG_NET_ACT_CSUM=3Dm
>
> CONFIG_NET_ACT_GACT=3Dm
>
> CONFIG_GACT_PROB=3Dy
>
> CONFIG_NET_ACT_PEDIT=3Dm
>
> CONFIG_NET_CLS_FLOWER=3Dm
>
>
> @Geliang: do you think you could use this command?

Hi Matt, Davide,

Thanks for your help. It works on my system. I'll write new MP_FAIL
selftest cases using tc to trigger the checksum failure as you suggested.

Thanks,
-Geliang

>
> >>> The problem with this approach is, we can't assume that the DSS optio=
n has a fixed
> >>> offset from the IP header. So, the test might start corrupting other =
options that
> >>> are not MPTCP.
> >>
> >> If we corrupt any data in TCP Options or data and update the TCP
> >> Checksum, that's enough to corrupt the DSS. For example, we could flip
> >> the last bit of the TCP payload (if tcp.len > 0). Would it be possible
> >> to do this by adapting your script?
> >
> > it's easier if it's the first bit, then...
> >
> >> For mptcp.org, I told someone to use netfilterqueue + scapy. He had so=
me
> >> issues but also shared a working version:
> >>
> >> https://github.com/multipath-tcp/mptcp/issues/420#issuecomment-8257715=
87
> >>
> >> I guess we cannot depend on Python and Scapy for selftests. I don't kn=
ow
> >> if we can also easily depend on eBPF either :)
> >
> > 'bpf' kselftests (and also tc-testing)  already depend on eBPF, so for
> > linux this is a no-problem.
>
> Yes indeed but that increases the complexity to launch selftests. I mean
> you need to add a bit of dependences (and "recent" ones) for 'bpf'
> selftests.
> It could be optional but it still needs to be supported by our CI.
>
> >> And using simple solutions like "tc netem corrupt" will be detectable =
by
> >> TCP csum.
> >
> > this can be easily workarounded using the 'csum' TC action after the
> > netem dequeue.
>
> Good point! So we would need to create a tree with first "netem" then
> "csum" action?
>
> The only thing is that netem will introduce errors at random positions,
> maybe in IP/TCP headers but it is maybe not an issue. If the TC filter
> command is enough, it might help to produce more controlled tests.
>
> >
> >> So maybe your way is better if we can corrupt anything, e.g. using a
> >> fixed offset like 120 or the last bit (if it is not an ACK). WDYT?
> >
> > I redirected this question to some friends working on eBPF, and they
> > told me it's doable and cool at the same time :)
> > There is an eBPF program that parses the "timestamp" option [1], we
> > can change it easily to corrupt the DSS and recompute the TCP checksum
> > like in Matteo's RHD article.
> >
> > WDYT?
>
> Indeed it looks like it is doable but if we could not add new
> dependences, I think that would be easier for us :)
>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
