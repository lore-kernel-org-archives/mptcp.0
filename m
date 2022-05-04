Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6492583
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 15:09:14 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id 7so1369905pga.12
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WzR2MTgFgVhFt31HN1hbWId588K8VOlEdnRW+nrg5KI=;
        b=Bj/YsQdKLRS4vtT3oofCuR4UIEW6Ryodoe6OfNzOgn0OBCUxAXY4by4eGRxgKUa3mw
         HIChN0ouvqNDB7122D5bBj3a0KfUVAA5ZzZBAEnbkxCe5OZ1TeQPnG8kybC6HSd3Klyt
         Y/cbl1Uga6qfSYnD+qzUyuy5AkDABu3Irusd7HyFU3Vck1gflQRK9NV/phEOijULJcCA
         Tw8KhZFpPrfWm2kQ5pRfj9dhqLs11YWZ2OS/0p8RYc1MG5MQ8ikYh2d8yFDfllOJ+8HK
         Gn7qp6AIHucdcW7I1+UiZB84ow8moDRpLofjC28iy8PY4GcfzqeD43n6DiKRee9iFdFu
         FzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WzR2MTgFgVhFt31HN1hbWId588K8VOlEdnRW+nrg5KI=;
        b=BuTh8F2x3GYKMBUu9A6yedU5RJn07jFBFlJn6tXgq2beT9eJgNni4IiQ2Cxh7Z2RVg
         devPzqocrjI0xGiWrSEyhN0xugRIWsrJnnGIpdhffUcChqJq1CzoxyKhXlIjhvRcgKTu
         DkrMx+thVsnIkGR0ao+KNB5xTl74Xmdu/W5Y4Lh7Oph4CIfQQf9x6hPXi9jZFxQ1I1Mx
         PxOPR8FfmE9b0HL8Lhwbz3S8AFByXD1qwKYzcjagF71jSDe75h9XS5PrhbLJSxKALnJ9
         Vk4pDgEZYkjod2u3bbBegUL1rSyhYwfNTZkwDJ4kRgUaNYHbjEVB26PMZrsyqDI/s0KF
         wWBA==
X-Gm-Message-State: AOAM530YW42tKW8ZQLJE9ZHyHh03oNW9DwBPr7T2hyLaS3aapA8YuwV0
	S/u7vjf03rcqyraXYby3CuMet8oEj2dTHDVoV2A=
X-Google-Smtp-Source: ABdhPJy5OUSiaHgfwnXn1lMMS3KRNJSE4cRzh/YtyBl5ciDQ6CR966UGN6BeaDsca5y8iZ0R2T8jaVY9c9fKLrLwVRM=
X-Received: by 2002:a05:6a00:1a0e:b0:50c:f9b5:6c74 with SMTP id
 g14-20020a056a001a0e00b0050cf9b56c74mr21452984pfv.69.1651676954136; Wed, 04
 May 2022 08:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6052111-39d7-1037-d711-59a3929db477@linux.intel.com>
 <8c369784-1387-887e-6aa-60d631897690@linux.intel.com> <CA+WQbwuGakz4Ytj2zr6OAQu++p1-QiS5F+BsCFTHfetyT8T6OA@mail.gmail.com>
 <f27a5f8af0ff5217c1255a1ecadcd28647fd5989.camel@redhat.com>
In-Reply-To: <f27a5f8af0ff5217c1255a1ecadcd28647fd5989.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 4 May 2022 23:09:05 +0800
Message-ID: <CA+WQbwvNt-0FWAGT44fx6MCCBVi4=zB14rGugiP80a375ZcecQ@mail.gmail.com>
Subject: Re: [Weekly meetings] MoM - 28th of April 2022 (MP_FAIL followup)
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliang.tang@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=884=E6=97=A5=
=E5=91=A8=E4=B8=89 22:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 2022-05-04 at 10:44 +0800, Geliang Tang wrote:
> > Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2022=E5=B9=
=B45=E6=9C=884=E6=97=A5=E5=91=A8=E4=B8=89 04:41=E5=86=99=E9=81=93=EF=BC=9A
> >
> > >
> > >
> > > On Thu, 28 Apr 2022, Mat Martineau wrote:
> > >
> > > >    - Features for net-next (next):
> > > >
> > > >        - [8053fb8d49ed] selftests: mptcp: add MP_FAIL reset testcas=
e
> > > > (Geliang Tang)
> > > >          - Two pending issues: open issue regarding multiple MP_FAI=
L in self
> > > > test, and dropping of bad data.
> > > >          - Prioritize MP_FAIL fixes
> > > >          - Follow up on ML to make sure Geliang is not blocked [Mat=
]
> > > >
> >
> > With Paolo's commit "net/sched: act_pedit: really ensure the skb is
> > writable", all pending issues about MP_FAIL have been solved.
> >
> > >
> > > Geliang -
> > >
> > > Were the two issues to resolve before upstreaming "selftests: mptcp: =
add
> > > MP_FAIL reset testcase" these:
> > >
> > > 1. https://github.com/multipath-tcp/mptcp_net-next/issues/265
> > >
> > > 2. Waiting for feedback on how to drop data on checksum failure.
> > >
> > >
> > > For #1, Paolo has been making a lot of progress there. Since the bug =
is
> > > tracked, it will be clear when it is closed and no longer blocks
> > > upstreaming
> > >
> >
> > Now all these '2 MP_FAIL[s]' issues has been fixed:
> >
> > 095 MP_FAIL MP_RST                       syn[ ok ] - synack[ ok ] - ack=
[ ok ]
> >                                          sum[ ok ] - csum  [ ok ]
> >                                          ftx[fail] got 2 MP_FAIL[s] TX
> > expected 1
> >  - failrx[fail] got 2 MP_FAIL[s] RX expected 1
> >                                          rtx[fail] got 2 MP_RST[s] TX e=
xpected 1
> >  - rstrx [fail] got 2 MP_RST[s] RX expected 1
> >                                          itx[ ok ] - infirx[ ok ]
> >
> > No '2 MP_FAIL[s]' issues in my test anymore.
> >
> >
> > But I still got another type of failures (0 MP_FAIL[s]) in my test:
> >
> > 002 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack=
[ ok ]
> >                                          sum[ ok ] - csum  [ ok ]
> >                                          ftx[ ok ] - failrx[fail] got
> > 0 MP_FAIL[s] RX expected 1
> >                                          rtx[ ok ] - rstrx [fail] got
> > 0 MP_RST[s] RX expected 1
> >                                          itx[ ok ] - infirx[ ok ]
> >
> > It seems MP_FAIL is lost in some cases. MP_FAIL is sent, but not receiv=
ed.
> >
> > I don't know whether Paolo is also looking at this 0 MP_FAIL[s] issue,
> > or whether it is necessary to open a new issue on Githut to track this
> > issue.
>
> [browsers!] I'm not working on it right now. I can have a look at the
> end of the week or the next one, if the issue is still pending.

Hi Paolo, with your new commit, selftests: mptcp: fix MP_FAIL
test-case, v2,  I didn't find this issue again in my test.

>
> Meanwhile, I suggest to track it with an individual/specific gitlab
> issue - to collect all the relevant info in a single place.
>
> Cheers,
>
> Paolo
>
