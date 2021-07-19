Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508A4173
	for <mptcp@lists.linux.dev>; Mon, 19 Jul 2021 10:02:25 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id h1so9309347plf.6
        for <mptcp@lists.linux.dev>; Mon, 19 Jul 2021 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+hXppXVxvyDQWAcGcS4gBVGanRxaep1iRZAPWgKJ0d8=;
        b=eF9d5+A2dO8ITp5KSj47a4iQm2bd/75s5gQTntNyRolMPFryDtWQPYlyAXV8Vsfr/k
         0ebyVGqhr4UuCHYfnqNZt3p1qSjtS1rNzvKXvF6fpFdJHYR7xR7f5cHRIffNlFdYxsG1
         7Be7ElR5Lem6jCy+8f0PS++kRC6BPXtGG06bj9p/ByKufTnZz1+jWfg/7gris/EvEz6E
         qJMvMNs44jeq4321/OnqWsCLzA5GFVlyTbB4Z3ElsZll3r0GjvjSkKD68xmmSFsJMK1j
         /xqFZ/uncIordlOLdtocDa6DccRyXCMFmNeX+c5C33pDaWsoYZigupw4mf48a55YPY2+
         2B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+hXppXVxvyDQWAcGcS4gBVGanRxaep1iRZAPWgKJ0d8=;
        b=Hm0o3oCpdgcRUsZNR1baTUgAhcJp+mLFbBfZpFR6hdEZl9k9K0fY2awNLG7K+cL7Ks
         Po13uopV7SuoZTikzS7nh2tsqpKV3gbAC4UgVCF/5zJRg0qnnLNbixOZuJ592jmGisnH
         g6JtdaAwSyVEn2XUBJmgVS2e39vy8AGB+mrPY1OF31hAW8sW2PfFDtVMQ3hZ7CL4Kmcd
         oyHdrnOY1iQdxpbJMpAjwSiuPWr4yXjcerbGNUE0mE8WfKX3IjnBUHzEiggNmWpB/urJ
         vvLwFCqDQguwsWI6jdadfPaq6Dqn5U/ZOHo89JYNZbIY7RVp8CvDzJL8xzwVmD7Q2JD3
         7eHA==
X-Gm-Message-State: AOAM533qrjq1mxNjx0NxgRcUIkXwh0ptXOy1EMzd3SYVJ0fGtxGnZ9UY
	a/E924FA9asFIl2IfaA7jGs34puCxGY5Obd3GHgVT8BPauo=
X-Google-Smtp-Source: ABdhPJwKoDQgrqCF88wp87Tewssg8LJOFffdK3j/c16dUMzrIRTL7yUrz81Ph1IS8XpgPfRJv59iaT4dZCQ8Ih+3WM8=
X-Received: by 2002:a17:902:b203:b029:127:16e0:286a with SMTP id
 t3-20020a170902b203b029012716e0286amr18808333plr.0.1626688944776; Mon, 19 Jul
 2021 03:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1626404090.git.geliangtang@gmail.com> <4898e7f6-8d2a-ec1f-8c17-a51c4ac7d559@chinatelecom.cn>
 <CA+WQbwvUCNtoHRX-7xVxY1AAVirym2mN1N+bPUY0R0jD6hDpEA@mail.gmail.com> <c340a979-1e87-b4c5-0955-b10890144fbe@chinatelecom.cn>
In-Reply-To: <c340a979-1e87-b4c5-0955-b10890144fbe@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 19 Jul 2021 18:02:13 +0800
Message-ID: <CA+WQbwv2RESX8MYjV1BugDHMDxVOMUKDu3xyOX9ho8+MQzHdAQ@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v9 mptcp-next 0/6] mptcp: fix conflicts when using
 pm.add_signal in ADD_ADDR/echo and RM_ADDR process
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, thanks.

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=8819=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:57=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi Geliang,
>
> I tested v9 and don't get any issue last weekend and today.
> I think v9 is ok.
>
> On 2021/7/16 18:13, Geliang Tang wrote:
> > Thanks, Yonglong,
> >
> > I'll do more tests for v9. And please test v9 on your computer too.
> >
> > Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8816=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:36=E5=86=99=E9=81=93=
=EF=BC=9A
> >>
> >>
> >> Hi Geliang,
> >>
> >> The v9 LGTM. Thank you for your help and efforts.
> >>
> >> On 2021/7/16 11:04, Geliang Tang wrote:
> >>> From: Yonglong Li <liyonglong@chinatelecom.cn>
> >>>
> >>> fix issue: ADD_ADDR and RM_ADDR use pm.add_signal to mark event, so
> >>> in some case pm.add_signal will be flush when ADD_ADDR/RM_ADDR in
> >>> process.
> >>>
> >>> fix issue: if ADD_ADDR and ADD_ADDR-echo process at the same time,
> >>> only one event can write pm.add_signal. so ADD_ADDR will process
> >>> after add_timer timeout or ADD_ADDR-echo will not be process.
> >>>
> >>> Patch 1 fix ADD_ADDR and RM_ADDR maybe clear addr_signal each other.
> >>>
> >>> Patch 2 and 3 deal ADD_ADDR and ADD_ADDR-echo with separately to fix
> >>> conflicts in using pm.addr_signal porcess.
> >>>
> >>> Patch 4 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT is not necessary.
> >>>
> >>> v1->v2:
> >>>  - remove READ_ONCE under the pm spin lock.
> >>>
> >>> v2->v3:
> >>>  - Patch 2: mptcp_pm_should_add_addr =3D> mptcp_pm_should_add_signal_=
addr
> >>>  - Patch 3: avoid read-modify-write of msk->pm.addr_signal and change
> >>>    mptcp_pm_add_addr_signal to return void.
> >>>
> >>> v3->v4:
> >>>  - Patch 1: use ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECH=
O))
> >>>    instead of BIT(MPTCP_RM_ADDR_SIGNAL)
> >>>  - Patch 3: simple the code; init flags; fix wrong goto logic code;
> >>>
> >>> v4->v5:
> >>>  - Patch 3: simple the code of 'mptcp_established_options_add_addr'
> >>>
> >>> v5->v6:
> >>>  - Patch2: fix fails of 'mptcp_join.sh -t'. In mptcp_pm_add_addr_send=
_ack
> >>>    without MPTCP_ADD_ADDR_SIGNAL check so pure ack can not be sent fo=
r
> >>>    ADD_ADDR. That cause ADD_ADDR can not be sent in time.
> >>>  - Patch3: refactor some code according Geliang's suggestions.
> >>>  - Patch4: modify commit comment
> >>>
> >>> v6->v7:
> >>>  - Patch1: use reverse xmas tree order for variables definition
> >>>  - Patch3: refactor some code according Geliang's suggestions.
> >>>  - add a Patch4: remove some double-check
> >>>
> >>> v7->v8:
> >>>  - Patch1,2: exchange patch1 and patch2
> >>>  - Patch3: refactor some code according Geliang's suggestions.
> >>>  - remove patch "remove some double check", Geliang think it's unnece=
ssary
> >>>
> >>> v8->v9:
> >>>  - Keep mptcp_add_addr_len unchanged.
> >>>  - populate opts->local or opts->remote after the length check, don't
> >>>    populate both of them.
> >>>  - add back 'echo' and 'port' arguments of mptcp_pm_add_addr_signal()=
.
> >>>  - add a new arguments drop_other_suboptions for
> >>>    mptcp_pm_add_addr_signal(), and do the drop_other_suboptions check=
 in it.
> >>>  - drop other suboptions in mptcp_established_options_add_addr() afte=
r the
> >>>    length check.
> >>>  - split the drop_other_suboptions code into a new patch.
> >>>  - add a new selftest case.
> >>>
> >>> Yonglong Li (6):
> >>>   mptcp: move drop_other_suboptions check under pm lock
> >>>   mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate
> >>>   mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
> >>>   mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
> >>>   mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
> >>>   selftests: mptcp: add_addr and echo race test
> >>>
> >>>  include/net/mptcp.h                           |  3 +-
> >>>  net/mptcp/options.c                           | 54 +++++++++--------=
-
> >>>  net/mptcp/pm.c                                | 57 +++++++++++++----=
--
> >>>  net/mptcp/pm_netlink.c                        | 10 ++--
> >>>  net/mptcp/protocol.h                          | 24 ++++----
> >>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++
> >>>  6 files changed, 97 insertions(+), 66 deletions(-)
> >>>
> >>
> >> --
> >> Li YongLong
> >
>
> --
> Li YongLong
