Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B834168
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 10:13:39 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id 17so8521949pfz.4
        for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M58JRP8QzqHTHZcJ1qEQRzmjSWaX60wJN60xOPBLu6M=;
        b=h8e800LEBxgqNc2vvimtcsh1luFh+tuykqfcgSQ6+NK5fOhxet0mK/kz2GrdwnWZsb
         W9qONKAH/ycfoGuWHJDXg56qHO0NCwQ8EhXT0M0L84ZLzZGQ1taFdakhd5GJbVm993pH
         Fe4uFc4Rm1zu89dwus+cHi/C6Hhor9SYlDgoZ6sB0boGoVmZj926Ztfx8vuPG0hJX//0
         SgFYRlp0L9OBnlaKHbJkIqpO72t22uVpXBDpnbC3a5Jl76ba+/53ujBLslftlW0GEJ1E
         Bv2VSRi14a8AEr/9JPFvB1zlix93tkg83tuB7+RjmxUe++nPUjVdRP3CL5ZhOZK90FoT
         VW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M58JRP8QzqHTHZcJ1qEQRzmjSWaX60wJN60xOPBLu6M=;
        b=q6FKsHTnuuCHHW6f6c3nr79czmwMtPdKe3R1PcU9Lq/kUKn6AkTqUGmGWi+QUvr3Iw
         Ke2WMesi7kA6g3G6u6LZqSFhI1r+0fAPu/u+WsHCEqncKHUYIbd/GFwTBUyXly6TfXBm
         dMH9qzLE2lWsLo17YOFs0699VjVi5M2pzDxo4f2haFANwBlR1aZ9pC5lLPh28Cz3VaLh
         lBkssGV2O51hmhbeZ8a0LTLLMdtdhTZfnKm9QtYkPSsbjZHNe1kKUnGeLE1Rk6ieFshW
         /DkVuuHkEtOy1W943WnGSBCpHKRIM8cPvNyBfZUWQpHAG610euWLfJtKkvYBnbumhKol
         9SkQ==
X-Gm-Message-State: AOAM533FtYkfVQuQ3g/5Sjb6MG4IdDxZWCwHKqveawRzujD2B8hUUYNq
	+EEbcbS559y/TlII7tFgwfBX3YQ/kp8gBciF2vM=
X-Google-Smtp-Source: ABdhPJwU2DyeroADtcx/lEdW0i93GQ+K9xdrx34tWMnNYfkXVJOq0e+IDHYLvjMhCn/ErPIlxqbW83/L0oJROOANklQ=
X-Received: by 2002:aa7:824a:0:b029:2ec:89ee:e798 with SMTP id
 e10-20020aa7824a0000b02902ec89eee798mr9560858pfn.12.1626430418790; Fri, 16
 Jul 2021 03:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1626404090.git.geliangtang@gmail.com> <4898e7f6-8d2a-ec1f-8c17-a51c4ac7d559@chinatelecom.cn>
In-Reply-To: <4898e7f6-8d2a-ec1f-8c17-a51c4ac7d559@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 16 Jul 2021 18:13:27 +0800
Message-ID: <CA+WQbwvUCNtoHRX-7xVxY1AAVirym2mN1N+bPUY0R0jD6hDpEA@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v9 mptcp-next 0/6] mptcp: fix conflicts when using
 pm.add_signal in ADD_ADDR/echo and RM_ADDR process
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Yonglong,

I'll do more tests for v9. And please test v9 on your computer too.

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=8816=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:36=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> Hi Geliang,
>
> The v9 LGTM. Thank you for your help and efforts.
>
> On 2021/7/16 11:04, Geliang Tang wrote:
> > From: Yonglong Li <liyonglong@chinatelecom.cn>
> >
> > fix issue: ADD_ADDR and RM_ADDR use pm.add_signal to mark event, so
> > in some case pm.add_signal will be flush when ADD_ADDR/RM_ADDR in
> > process.
> >
> > fix issue: if ADD_ADDR and ADD_ADDR-echo process at the same time,
> > only one event can write pm.add_signal. so ADD_ADDR will process
> > after add_timer timeout or ADD_ADDR-echo will not be process.
> >
> > Patch 1 fix ADD_ADDR and RM_ADDR maybe clear addr_signal each other.
> >
> > Patch 2 and 3 deal ADD_ADDR and ADD_ADDR-echo with separately to fix
> > conflicts in using pm.addr_signal porcess.
> >
> > Patch 4 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT is not necessary.
> >
> > v1->v2:
> >  - remove READ_ONCE under the pm spin lock.
> >
> > v2->v3:
> >  - Patch 2: mptcp_pm_should_add_addr =3D> mptcp_pm_should_add_signal_ad=
dr
> >  - Patch 3: avoid read-modify-write of msk->pm.addr_signal and change
> >    mptcp_pm_add_addr_signal to return void.
> >
> > v3->v4:
> >  - Patch 1: use ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO)=
)
> >    instead of BIT(MPTCP_RM_ADDR_SIGNAL)
> >  - Patch 3: simple the code; init flags; fix wrong goto logic code;
> >
> > v4->v5:
> >  - Patch 3: simple the code of 'mptcp_established_options_add_addr'
> >
> > v5->v6:
> >  - Patch2: fix fails of 'mptcp_join.sh -t'. In mptcp_pm_add_addr_send_a=
ck
> >    without MPTCP_ADD_ADDR_SIGNAL check so pure ack can not be sent for
> >    ADD_ADDR. That cause ADD_ADDR can not be sent in time.
> >  - Patch3: refactor some code according Geliang's suggestions.
> >  - Patch4: modify commit comment
> >
> > v6->v7:
> >  - Patch1: use reverse xmas tree order for variables definition
> >  - Patch3: refactor some code according Geliang's suggestions.
> >  - add a Patch4: remove some double-check
> >
> > v7->v8:
> >  - Patch1,2: exchange patch1 and patch2
> >  - Patch3: refactor some code according Geliang's suggestions.
> >  - remove patch "remove some double check", Geliang think it's unnecess=
ary
> >
> > v8->v9:
> >  - Keep mptcp_add_addr_len unchanged.
> >  - populate opts->local or opts->remote after the length check, don't
> >    populate both of them.
> >  - add back 'echo' and 'port' arguments of mptcp_pm_add_addr_signal().
> >  - add a new arguments drop_other_suboptions for
> >    mptcp_pm_add_addr_signal(), and do the drop_other_suboptions check i=
n it.
> >  - drop other suboptions in mptcp_established_options_add_addr() after =
the
> >    length check.
> >  - split the drop_other_suboptions code into a new patch.
> >  - add a new selftest case.
> >
> > Yonglong Li (6):
> >   mptcp: move drop_other_suboptions check under pm lock
> >   mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate
> >   mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
> >   mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
> >   mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
> >   selftests: mptcp: add_addr and echo race test
> >
> >  include/net/mptcp.h                           |  3 +-
> >  net/mptcp/options.c                           | 54 +++++++++---------
> >  net/mptcp/pm.c                                | 57 +++++++++++++------
> >  net/mptcp/pm_netlink.c                        | 10 ++--
> >  net/mptcp/protocol.h                          | 24 ++++----
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++
> >  6 files changed, 97 insertions(+), 66 deletions(-)
> >
>
> --
> Li YongLong
