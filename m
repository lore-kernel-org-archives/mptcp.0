Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5E5F
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 10:32:59 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id o19so17603820edc.3
        for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 03:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VLb2cvZSPKMxHZQaMGMV+FauV7nkKavLRbmFiENvjwA=;
        b=IlCd5jZLvsCH4bPUsXq31a3m7dXNO1HkFqM5Ao1xopNopnWFuE2XAXLXqcCLkO8uH6
         BeuP8DNjrbXazoEEWAwwrSZ3xxxYKUsxlZYfCbl1sGk6fKlRvJgi1wRLiQMnzDbnevFj
         YPJ/d5cZzew2gc46qr9kG6a8DJAme6GEr+jkEfi+NKX6sloNK7v9TTGv2JW9S6uJmY+w
         oL+spBpRgc0nqWywR+NZAQhtybkgRZd8jB+1V1zDdctfwco/bkLSkzF+F4Rz122UXbLo
         dR1jtQXb2dAw6iIsUe4MSVVyRVfFqhJQmqMDqt2X4Ag6MeOdyoXZo6bMI48LcP/ztU6n
         JiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VLb2cvZSPKMxHZQaMGMV+FauV7nkKavLRbmFiENvjwA=;
        b=oLJEaYb5fbirzIoLQL34ekl2eSIot1Vu4Z64so/p+oq0Is1lDY8n3JXCORlieN7aVi
         iJ/URhyEMeaN7vGSLUfSJ8KAVliVyVthjFZqba4eYGI9mkpxGRzu83ZWwMBYGSNgZ7lR
         B9Ulgd0Sq0HGEiW4iHCNSifJ48NEcZDciY710hSAHZGzabqr+wA3tz8RD9C4Ob3f1AY3
         XIB+FuEyLp2OR9qG+GSleL2dgwuQa/7pnzzOIAOQstO3JFLADwZX2d7fasZf3v7lHPgq
         ynBreGxgaSyD08ZUu1war4HNRg97Lo/Zi+QYzkJddDSapXnCif6kNqdpR/sKGGfvte7q
         9MEQ==
X-Gm-Message-State: AOAM531L3IfsonXF9GETnI3lXbjXp/N/ECuHvXiE2GsPGJFdn/5h80og
	T/K3yXo+XvwafRMdyNmTU3QqW3UtnhK7cDo5ld3sehf6CSg=
X-Google-Smtp-Source: ABdhPJyzXiV8TRUdpVFU9BNXfqn6VU9w84xhyFdXJrRAiXAvIxjITr0jch7uMCs6H5LeTdQXV80PRyVO1Hk2CAowf0I=
X-Received: by 2002:a50:ee19:: with SMTP id g25mr33485037eds.351.1617100378299;
 Tue, 30 Mar 2021 03:32:58 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <9fe955db44222c638db73c3f8446d9d248b8a11c.1616039100.git.geliangtang@gmail.com>
 <594ef822-2f57-7b80-4651-2d0b4ef7d4ec@tessares.net>
In-Reply-To: <594ef822-2f57-7b80-4651-2d0b4ef7d4ec@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 30 Mar 2021 18:32:46 +0800
Message-ID: <CA+WQbwuEwCaSAKLf_DVOytApD0D=8CFV9cGXOjL2maoiYq-SmQ@mail.gmail.com>
Subject: Re: [MPTCP] [MPTCP][PATCH v2 mptcp-next] Squash to "bpf:selftests:
 add MPTCP test base"
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, mptcp <mptcp@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for your review.

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B43=E6=
=9C=8820=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=887:31=E5=86=99=E9=81=
=93=EF=BC=9A

>
> Hi Geliang,
>
> On 18/03/2021 04:47, Geliang Tang wrote:
> > When I ran the bpf mptcp test "./test_progs -n 67", I got a "fallback t=
o
> > TCP" error and a "Attempt to release TCP socket in state 8" error in th=
e
> > kernel log:
>
> (...)
>
> > For the first error, adding send_byte can fix it. The send_byte functio=
n is
> > copied from tools/testing/selftests/bpf/prog_tests/tcp_rtt.c.
>
> (maybe better to continue the discussion about that in the v1, I'm not
> sure I understand what is causing this fallback and I'm not able to
> reproduce it with another program)
>
> > For the second error, we need to close the server fd before closing the
> > client fd.
>
> Do you know why we have to do that?
> Do we have the same warning with tcp_rtt.c for example where the server
> is also closed after the client.
>
> Again, I don't think it is normal to have these warnings with simple
> userspace programs except if here, some modifications are done from BPF?

Did you reproduce this issue using the bpf selftest? Did you test my fix?
It's simple and it works.

Do you think it's worth to find out the root cause of this issue? It may
take a lot of time. If so, I'll open a ticket on GitHub to trace it later,
I'll try to fix it after finishing the "checksum support" issue.

Thanks.

-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
