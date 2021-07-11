Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962E168
	for <mptcp@lists.linux.dev>; Sun, 11 Jul 2021 15:20:58 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so8952588pjo.3
        for <mptcp@lists.linux.dev>; Sun, 11 Jul 2021 08:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4AkmjH5REUbv3BP6UhQbELT56Ez8AAJ13kJgqeX/pos=;
        b=Phe1adt/NDWxzn1LX5M3QUBvUvDM+rzQCX2c9blJE4adatvuCcSKLFNWlNoo42xPUA
         WhBPDWHq5aN+mhYjDTLSwmkYkQkfp3Q7M1A/IQnQMafLdn2lAKt/Vh3fw1Jba+5kHcb7
         DQGuqH5TZJJ1ikDhqs0A+qUA8N5pTc5v5didB2hZOBkfYQPEzozyeeTGWtqOivHA5TGQ
         PrJHOJuml4Rn042y9IbE9c5GHJ8o//WmgT4YZDDmub8SmChvmD3zrjCZAuUyS38jc4R2
         5P34JqtKecTe61QZ5udnS/fyFDK1lrXpjIupbABGtrtxkTKVOmxD9LK5XACivxt5vHrD
         aZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4AkmjH5REUbv3BP6UhQbELT56Ez8AAJ13kJgqeX/pos=;
        b=XpKsbgJTJCJoQZLesbGiH0hGHw29rmdnUAH4C+JMWYVpUa3fVO3m1vSuzLWm2FdBCb
         S4MnBJTkZbkDTmfhvverXgLY74nT3/oNXwoqqPzWJOTZFfAwTMLZSJI/VTtcZeb1xU/5
         8OHUBtwfEm1SjNIhECvPna2jsUJJPelT8+i2HT+XRlPnJ6XFflIldbE5R3u6M/TWPu5n
         AXMQKfdMZX+GVnNDwgb1R1T4wfkr+Xxam/ro53M/lgNR19TogoTlKmVRirbhNuZCFT8C
         pl8FKr1l94rhewUC1vpmUABUkRFnyXvYhZ8ULDaPIrseAY47dwX3o/MseuLQynII2zaI
         PYoA==
X-Gm-Message-State: AOAM5327uGiZH5ZOy+1m6ydmOUBIKFWGfG+NJ9+2+fylI9Hn5Ol1LYTo
	1zgrlAYHVfud9i9ce1N1mMwvnAxh/wO/a+TW5No=
X-Google-Smtp-Source: ABdhPJzRpP86TGprah3efEPXFEv4CBUZDqcfaL2PqS0uxoe93+N+e4km3Ns5oyj9oK1WuypPcJ2y9PR96evH/h1X7Ro=
X-Received: by 2002:a17:90a:4bcb:: with SMTP id u11mr9728414pjl.6.1626016858377;
 Sun, 11 Jul 2021 08:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1625677301-139357-1-git-send-email-liyonglong@chinatelecom.cn> <c4a942d7-b086-f18f-c097-609af9451dde@linux.intel.com>
In-Reply-To: <c4a942d7-b086-f18f-c097-609af9451dde@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Sun, 11 Jul 2021 23:20:47 +0800
Message-ID: <CA+WQbwsw3==G5aBo1CAret0kQcASf_jEX0hs0ZmzPmfzEhrbow@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] mptcp: fix conflicts when using pm.add_signal in
 ADD_ADDR/echo and RM_ADDR process
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Yonglong Li <liyonglong@chinatelecom.cn>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B47=
=E6=9C=8810=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=889:00=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Thu, 8 Jul 2021, Yonglong Li wrote:
>
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
> > - remove READ_ONCE under the pm spin lock.
> >
> > v2->v3:
> > - Patch 2: mptcp_pm_should_add_addr =3D> mptcp_pm_should_add_signal_add=
r
> > - Patch 3: avoid read-modify-write of msk->pm.addr_signal and change
> >   mptcp_pm_add_addr_signal to return void.
> >
> > v3->v4:
> > - Patch 1: use ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO))
> >   instead of BIT(MPTCP_RM_ADDR_SIGNAL)
> > - Patch 3: simple the code; init flags; fix wrong goto logic code;
> >
> > v4->v5:
> > - Patch 3: simple the code of 'mptcp_established_options_add_addr'
> >
> > v5->v6:
> > - Patch2: fix fails of 'mptcp_join.sh -t'. In mptcp_pm_add_addr_send_ac=
k
> >   without MPTCP_ADD_ADDR_SIGNAL check so pure ack can not be sent for
> >   ADD_ADDR. That cause ADD_ADDR can not be sent in time.
> > - Patch3: refactor some code according Geliang's suggestions.
> > - Patch4: modify commit comment
> >
> > v6->v7:
> > - Patch1: use reverse xmas tree order for variables definition
> > - Patch3: refactor some code according Geliang's suggestions.
> > - add a Patch4: remove some double-check
> >
> > v7->v8:
> > - Patch1,2: exchange patch1 and patch2
> > - Patch3: refactor some code according Geliang's suggestions.
> > - remove patch "remove some double check", Geliang think it's unnecessa=
ry
> >
> > Yonglong Li (4):
> >  mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate
> >  mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
> >  mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
> >  mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
> >
> > include/net/mptcp.h    |  3 ++-
> > net/mptcp/options.c    | 51 +++++++++++++++++++++++++++----------------=
-------
> > net/mptcp/pm.c         | 51 +++++++++++++++++++++++++++++++------------=
-------
> > net/mptcp/pm_netlink.c | 10 ++++------
> > net/mptcp/protocol.h   | 44 +++++++++++++++++++++++--------------------
> > 5 files changed, 90 insertions(+), 69 deletions(-)
> >
> > --
> > 1.8.3.1
>
> Hi Yonglong -
>
> Thanks for your revisions. I don't have any code changes to suggest for
> v8, I think we should add these to the export branch and if any more
> changes are required we can squash those before upstreaming.
>

Hi Mat, Yonglong,

I just sent out there squash-to patches for this series.

Thanks,
-Geliang

>
> --
> Mat Martineau
> Intel
