Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5366220E8
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 02:44:31 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id t13so85480pgn.8
        for <mptcp@lists.linux.dev>; Tue, 03 May 2022 19:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kkpxioo22uiQH2R5cFhyrJZFzWylZiGUavD96BUBCLI=;
        b=SodWwT1HfuTaGBal3RqCCVPno/zUIj6CFDwmPL3O0b+gcmZlqcThDP5t1GbrygMJ2g
         TgwizA7c7dyOPNLM9/QYOV7U5q1rraj3hZ90/ZYlAofPguJ5ShSbjyChb27rLQ8bZ4pH
         7AhLA7Q5b4/whDnkN5kG1zax7RIeiH8TjkH1WUetajxZxGffMTjKGuJpjXTKekSG7pcp
         uUe8FBDWHNHh7NH2TJFKhb1AbCRZK3d2Vy+2kpeiWI2ZP9xGvHwle3+n9yVxFbXqTF52
         YX64Fi5FrsVqFsn9Adg8ObARg6EBgNg825530w3ZOvBmwPHmYrSiLBybmefFFrhfgpha
         L+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kkpxioo22uiQH2R5cFhyrJZFzWylZiGUavD96BUBCLI=;
        b=FS2rzk/eBCGCBUFJ4HEXNdpoaony10ksoH4wf5u0NSnEqLWPQG+ULQeRpFdp+RdJ7K
         Ge9k/qgipYSTVmv9WEf4LA4RBux4sym9EOrMAnNfTkhfGMyBFieF18Vl0Ijl6YuBM1k/
         +B//6XVRnFWSJgZaEOZN6udK+l5Zxr8alC3LI7rRkBA5CfOEiDNRjqq58CXICF7z+YHn
         FecdhyElZWfStVCMQDmJkihtg4ye0pyKnWr9Si1hwlBsowKf2/VbesoyMDhCIrszeS6P
         81fdLQvwQoACPi+mzAYCI21ZSbpI6/Bcq4UtYVv13uybcSZwe1+JTvy34GBMUklCrpHR
         HMbQ==
X-Gm-Message-State: AOAM53197KMDvXrJu9BLhfu2Hv6T98W9RSRYODU2SYmWT8Ig+sN4DAjs
	vMQ/CQC1zPBYy0e6QSOcRHvnNbtjwwxksu3Qvrg=
X-Google-Smtp-Source: ABdhPJwB/O6Qk8xEY9ETfk4szN5x3WTgDAEXjVcpNsswIko+rQfMpH0jCkbABSOCISvIlQGNtHrJAPygOfXa4XiLUFU=
X-Received: by 2002:a63:2b01:0:b0:3c2:4b0b:e1c6 with SMTP id
 r1-20020a632b01000000b003c24b0be1c6mr8187029pgr.288.1651632270763; Tue, 03
 May 2022 19:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6052111-39d7-1037-d711-59a3929db477@linux.intel.com> <8c369784-1387-887e-6aa-60d631897690@linux.intel.com>
In-Reply-To: <8c369784-1387-887e-6aa-60d631897690@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 4 May 2022 10:44:21 +0800
Message-ID: <CA+WQbwuGakz4Ytj2zr6OAQu++p1-QiS5F+BsCFTHfetyT8T6OA@mail.gmail.com>
Subject: Re: [Weekly meetings] MoM - 28th of April 2022 (MP_FAIL followup)
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Paolo Abeni <pabeni@redhat.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang <geliang.tang@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2022=E5=B9=B45=
=E6=9C=884=E6=97=A5=E5=91=A8=E4=B8=89 04:41=E5=86=99=E9=81=93=EF=BC=9A

>
>
> On Thu, 28 Apr 2022, Mat Martineau wrote:
>
> >    - Features for net-next (next):
> >
> >        - [8053fb8d49ed] selftests: mptcp: add MP_FAIL reset testcase
> > (Geliang Tang)
> >          - Two pending issues: open issue regarding multiple MP_FAIL in=
 self
> > test, and dropping of bad data.
> >          - Prioritize MP_FAIL fixes
> >          - Follow up on ML to make sure Geliang is not blocked [Mat]
> >

With Paolo's commit "net/sched: act_pedit: really ensure the skb is
writable", all pending issues about MP_FAIL have been solved.

>
> Geliang -
>
> Were the two issues to resolve before upstreaming "selftests: mptcp: add
> MP_FAIL reset testcase" these:
>
> 1. https://github.com/multipath-tcp/mptcp_net-next/issues/265
>
> 2. Waiting for feedback on how to drop data on checksum failure.
>
>
> For #1, Paolo has been making a lot of progress there. Since the bug is
> tracked, it will be clear when it is closed and no longer blocks
> upstreaming
>

Now all these '2 MP_FAIL[s]' issues has been fixed:

095 MP_FAIL MP_RST                       syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[fail] got 2 MP_FAIL[s] TX
expected 1
 - failrx[fail] got 2 MP_FAIL[s] RX expected 1
                                         rtx[fail] got 2 MP_RST[s] TX expec=
ted 1
 - rstrx [fail] got 2 MP_RST[s] RX expected 1
                                         itx[ ok ] - infirx[ ok ]

No '2 MP_FAIL[s]' issues in my test anymore.


But I still got another type of failures (0 MP_FAIL[s]) in my test:

002 MP_FAIL MP_RST: 5 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[fail] got
0 MP_FAIL[s] RX expected 1
                                         rtx[ ok ] - rstrx [fail] got
0 MP_RST[s] RX expected 1
                                         itx[ ok ] - infirx[ ok ]

It seems MP_FAIL is lost in some cases. MP_FAIL is sent, but not received.

I don't know whether Paolo is also looking at this 0 MP_FAIL[s] issue,
or whether it is necessary to open a new issue on Githut to track this
issue.

>
> For #2, do you have questions that I did not address in the "Infinite
> mapping and dropping data" message on the list (30-Mar-2022):
>
> https://lore.kernel.org/mptcp/5e9cc0c5-1514-a198-5191-a765a67b9de4@linux.=
intel.com/#r
>
> My conclusion there was that we don't need to drop data on checksum
> failure:
>
> """
> I don't think it's necessary to discard any incoming data to
> handle this single-subflow fallback scenario. As Matthieu mentioned in th=
e
> meeting, the checksum failure tells us that there was either MPTCP header
> corruption or a mismatch between the data payload and the MPTCP mapping -
> it is not an indication that the data was "bad". If the incoming data tha=
t
> is read from the MPTCP socket matches the subflow's reassembled TCP
> stream, then fallback was successful.
> """
>
> Was that your concern, or is there a different issue?

Yes, all MP_FAIL dropping data issues are solved now. This 'singe
subflow and dropping data' issue you mentioned is solved.

Also, the 'multiple subflows and dropping data' issue is fixed by
Paolo's commit too:

Created /tmp/tmp.iTuFZCucnH (size 1024 KB) containing data sent by client
Created /tmp/tmp.YTN6JELVhq (size 1024 KB) containing data sent by server
002 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - failrx[ ok ]
                                         rtx[ ok ] - rstrx [ ok ]
                                         itx[ ok ] - infirx[ ok ]

Now no inverted byte is received in the MP_FAIL MP_RST test anymore.

Thanks,
-Geliang

>
>
> Thanks!
>
> --
> Mat Martineau
> Intel
>
