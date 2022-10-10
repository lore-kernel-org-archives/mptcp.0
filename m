Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7C2F47
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 15:04:58 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id p7so8202870vsr.7
        for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 08:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpqURs4WPS60oOlvnFP2SaMXVx76Lqtu86T8L1aCldk=;
        b=HlydqzDQqysjH7+7AvXOjxkLNKxyNbGtaFjlubNpfk3LBfLBvEJ0J5f6xfR+rIKDCw
         b0iwSYhZ5D07aRu9TNL4AoQzNtujeL/sWMz9pbl0+0KMiZGYA2yg18SjAv0FkFAf5f9s
         5lOF/RsbxkGwGPDM5GYPRxKWIXPyIHVtHYTv6RmT/hAYFImkuBGSg0ZFE303F21Wg0ls
         zhEiLttDvEqPDFUZLHHq4u2pQCpEN891vB56oVwbV+fgon44D+/RkxM8wZD9Oa8tLzD7
         q5g8HIy3Tb9wzSQ/MTeUSIiYWsZrwX8vJqMAAuUEdGWcrv0DFAYGSkNP2OUISvR+Wu4D
         MKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpqURs4WPS60oOlvnFP2SaMXVx76Lqtu86T8L1aCldk=;
        b=vyA86Wyt5QpgHWpEZrLJEQRHQpd4fZIcVBqBz35AnRCKsqeavTgUPuC0ttCmrxVW1I
         xMdcHpMpHCkDnNId9A1X4FA44PytAcQ39lgOG0u21AKgh4kwoCJpBAuMSNiQcRdJzRwi
         p6+a402v6yedd9ny+iVze2FT6CC507Eag4H8gB5/e37XDkwznvNLMDloQ40Pr0hvpd2T
         cqILyho5ZV1Qudz2CbHoJSlF4rqnqn+qTr3jVWWaK+zoOJjjYlJi7NWdV1h3o+SLq2dY
         wRh2wbPdUU0KCdEnTLyJfB8GbJEI9bqz+ISxzoVLtiCi+ZJgw5+9xzbxuCWRs4iJZHDt
         Hzxw==
X-Gm-Message-State: ACrzQf2gMVJ8swKEirqga7o9TKDXz9me6wEABIOz5ORhBLqcEBB2TQSL
	KxnoU/vDWvhkiWIY7mFAKXDsbasenUOdZ8+DpYmLZ1pdpyk=
X-Google-Smtp-Source: AMsMyM4/v7TnBnNql/mw0S2B2+tWWFVO89Hx86nmLTZt56q6TV9djgFnJWJj1uK08heYzyO2n7pmw4Oai1+uu5YdlLI=
X-Received: by 2002:a67:d99d:0:b0:3a6:ec71:1fc9 with SMTP id
 u29-20020a67d99d000000b003a6ec711fc9mr8598281vsj.39.1665414297394; Mon, 10
 Oct 2022 08:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1665058388.git.geliang.tang@suse.com> <86e6c9a8-4361-ec40-56ee-98c270d8342a@linux.intel.com>
 <20221007090031.GA15380@bogon>
In-Reply-To: <20221007090031.GA15380@bogon>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 10 Oct 2022 23:05:41 +0800
Message-ID: <CA+WQbwuVgAUSo=sP+gty0urNNWDC0JhG1MXBMzxzPxYvBj1OVg@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 00/11] refactor push pending
To: Geliang Tang <geliang.tang@suse.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliang.tang@suse.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=94 16:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Oct 06, 2022 at 05:16:55PM -0700, Mat Martineau wrote:
> > On Thu, 6 Oct 2022, Geliang Tang wrote:
> >
> > > v5:
> > > - address Mat's comments in v4.
> >
> > Hi Geliang -
> >
> > Thanks for the v5. I haven't finished looking over all the patches in d=
etail
> > yet, but two things I do want to reply to right now:
> >
> >  * Thanks for explaining in patch 4 that last_snd is still useful for r=
ound
> > robin. I had forgotten about that, and it looked like a "write-only"
> > variable in the kernel code.
> >
> >  * In the meeting today Paolo suggested that a good test for the new
> > scheduler loop would be to modify simult_flows.sh to use much larger fi=
les,
> > then see if the modified code slowed down any of the simult_flows tests=
.
> >
> > He suggested making the test file 10x larger in simult_flows.sh:
> >
> > -     size=3D$((2 * 2048 * 4096))
> > +     size=3D$((2 * 2048 * 4096 * 10))
> >
> > Can you compare the test times between the export branch and this serie=
s,
> > with both of them using the larger file size?
>
> 10x larger failed in my tests with timeout. So I changed it to 5x
> larger.
>
> Here's the patch:
>
> @@ -52,7 +52,7 @@ setup()
>         sout=3D$(mktemp)
>         cout=3D$(mktemp)
>         capout=3D$(mktemp)
> -       size=3D$((2 * 2048 * 4096))
> +       size=3D$((2 * 2048 * 4096 * 5))
>
>         dd if=3D/dev/zero of=3D$small bs=3D4096 count=3D20 >/dev/null 2>&=
1
>         dd if=3D/dev/zero of=3D$large bs=3D4096 count=3D$((size / 4096)) =
>/dev/null 2>&1
> @@ -210,13 +210,13 @@ do_transfer()
>         fi
>
>         echo " [ fail ]"
> -       echo "client exit code $retc, server $rets" 1>&2
> -       echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
> -       ip netns exec ${ns3} ss -nita 1>&2 -o "sport =3D :$port"
> -       echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
> -       ip netns exec ${ns1} ss -nita 1>&2 -o "dport =3D :$port"
> -       ls -l $sin $cout
> -       ls -l $cin $sout
> +       #echo "client exit code $retc, server $rets" 1>&2
> +       #echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
> +       #ip netns exec ${ns3} ss -nita 1>&2 -o "sport =3D :$port"
> +       #echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
> +       #ip netns exec ${ns1} ss -nita 1>&2 -o "dport =3D :$port"
> +       #ls -l $sin $cout
> +       #ls -l $cin $sout
>
>         cat "$capout"
>         return 1
>
> All logs are attached. "5x_10times_export.log" is for the export branch
> and "5x_10times_refactor_v5.log" is for this series.

I compared the two log data. The test time of this series is indeed
longer than that of export, but the difference is very small.

I removed the useless information in the two logs and only retained
the running time and expected time. It looks like this:

> cat 5x_export.log | head
36150 max 36005
36135 max 36005
36087 max 36005
36103 max 36005
18284 max 18227
18349 max 18227

Add all running time and expected time:

> awk '{ sum +=3D $1 }; END { print sum }' 5x_export.log
2540920
> awk '{ sum +=3D $3 }; END { print sum }' 5x_export.log
2533820

The ratio of the total running time to the total expected time is
1.00280209 (2540920/2533820).

Use the same method to calculate data in 5x_10times_refactor_v5.log:

> cat 5x_refactor_v5.log | head
36095 max 36005
36168 max 36005
36112 max 36005
36120 max 36005
18235 max 18227
18445 max 18227

> awk '{ sum +=3D $1 }; END { print sum }' 5x_refactor_v5.log
2546024
> awk '{ sum +=3D $3 }; END { print sum }' 5x_refactor_v5.log
2533820

The ratio is 1.00481644.  It is 0.002 more than export data. I think
this difference is acceptable.

Thanks,
-Geliang

>
> Thanks,
> -Geliang
>
> >
> >
> > Thanks,
> >
> > Mat
> >
> >
> > >
> > > v4:
> > > - update __mptcp_subflow_push_pending as Mat suggested.
> > > - add more patches from "BPF redundant scheduler" series.
> > >
> > > v3:
> > > - add a cleanup patch.
> > > - remove msk->last_snd in mptcp_subflow_get_send().
> > > - add the loop that calls the scheduler again in __mptcp_push_pending=
().
> > >
> > > v2:
> > > - add snd_burst check in dfrags loop as Mat suggested.
> > >
> > > Refactor __mptcp_push_pending() and __mptcp_subflow_push_pending() to
> > > remove duplicate code and support redundant scheduler more easily in
> > > __mptcp_subflow_push_pending().
> > >
> > > Geliang Tang (11):
> > >  Squash to "mptcp: add get_subflow wrappers"
> > >  mptcp: 'first' argument for subflow_push_pending
> > >  mptcp: refactor push_pending logic
> > >  mptcp: drop last_snd for burst scheduler
> > >  mptcp: simplify push_pending
> > >  mptcp: multi subflows push_pending
> > >  mptcp: use msk instead of mptcp_sk
> > >  mptcp: refactor subflow_push_pending logic
> > >  mptcp: simplify subflow_push_pending
> > >  mptcp: multi subflows subflow_push_pending
> > >  mptcp: multi subflows retrans support
> > >
> > > net/mptcp/pm.c         |   9 +-
> > > net/mptcp/pm_netlink.c |   3 -
> > > net/mptcp/protocol.c   | 285 ++++++++++++++++++++++------------------=
-
> > > net/mptcp/protocol.h   |   5 +-
> > > net/mptcp/sched.c      |  61 +++++----
> > > 5 files changed, 184 insertions(+), 179 deletions(-)
> > >
> > > --
> > > 2.35.3
> > >
> > >
> > >
> >
> > --
> > Mat Martineau
> > Intel
