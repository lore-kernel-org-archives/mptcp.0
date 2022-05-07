Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D5EA3
	for <mptcp@lists.linux.dev>; Sat,  7 May 2022 06:24:21 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id 15so7794986pgf.4
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=couoExG+du3v7roUasHvVCk/zeaq8i7n9wOxJRdKRWc=;
        b=GcvWxPLgPxJaFhPG0KVVeQcgyRLbxnFrW1mMbar/ICA5nOR3M2Jk/OPifedgep/s7/
         MnA1BuTPrXfIZrNI0wcRhE24YZzNTTQ+jFPPCGn4AbwPfjW6TvZSauS1lmUA6271cTNZ
         gMpJcENL/omjGAvckDIu2hROva9b8RyFAtGkngDzm3Hsuz62vdrrjhPV/pcGTCdKVssm
         S8Z+ZAWNPfFRDN2KF/ytLFoTMJAPJtV0mu7vmLd7hPUb4ko1QWvx4EpGovG5e9IOZ59h
         yZDSWzUo8tesV6OS/BKHrsE+hShMbN/kOs/gD6ac0++0rOKu9XnUX2tPQpe9SukKF1n0
         Cf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=couoExG+du3v7roUasHvVCk/zeaq8i7n9wOxJRdKRWc=;
        b=vrRZiOQY8eMSp+IDNKgx2hAXYeuakNHJoTzsHsybloIvZitaqe1ACWxEw/0Nm3MQNZ
         e7A+zuLJwoKVEWUEMQDR7fYEdMRtDhSbU6jOMTlfbPxiCryDddkmJWwdw014Pw/uBHYZ
         OHBXVDvwqftyp2ZvwvsV26Dk47hy4dFBgVH0z84ZfOZk6LmSifSX6cDRJ+UUJrlaTdtV
         0rtihOOF5WCoQ9ncfqNJ45drMg5Ds3dc9rDT4S/fsWhXL4DNPKMgD/8l0cIEsDa3Y8B6
         Qv9tjOlXTR4rc74Kprn0J6qyVZRzMyLQ4fBmkgadPH3LsSzTC2cDwrJNUisZZcgl4kc0
         04xQ==
X-Gm-Message-State: AOAM533TrQX9+KXH3M4ZaaohwXxaDB1ZFQsuLXsOH/8KixP2/kGg5OHi
	36GhwRIZ9TWn0B/2z4Rf4gypXbuQ+sc0zRGMPw5DG39ytJwMOGxg
X-Google-Smtp-Source: ABdhPJwUuVG9FpT4O7iNCsIcsd2tls13fHtEgHi99j1m2ihrQJIkuDR+sSzn+t40Eu9vsyZTWqBqSCW38gUM7tlb5AU=
X-Received: by 2002:a05:6a00:1a02:b0:510:8946:d723 with SMTP id
 g2-20020a056a001a0200b005108946d723mr4368712pfv.69.1651904660885; Fri, 06 May
 2022 23:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1651724418.git.geliang.tang@suse.com> <2cef2c7d-d25e-179f-2550-23cc935ad7ec@linux.intel.com>
 <156f008c-477d-4f1c-82c0-0c18a7f21971@tessares.net>
In-Reply-To: <156f008c-477d-4f1c-82c0-0c18a7f21971@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Sat, 7 May 2022 14:24:14 +0800
Message-ID: <CA+WQbwtjKN-=7po2P3gy++nS=ggjFWxEhzT+q-a5tuFrh=UPbw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v12 0/3] BPF round-robin scheduler
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	Geliang Tang <geliang.tang@suse.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B45=E6=
=9C=887=E6=97=A5=E5=91=A8=E5=85=AD 13:34=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Mat, Geliang,
>
> 7 May 2022 02:06:25 Mat Martineau <mathew.j.martineau@linux.intel.com>:
>
> > On Thu, 5 May 2022, Geliang Tang wrote:
> >
> >> v12:
> >> - init ssk from data->contexts[0], instead of msk->first.
> >> - cycle through all the subflows, instead of the first two.
> >>
> >
> > v12 looks ok for the export branch, but Andrii asked for us to use bpf_=
tcp_helpers.h instead of adding a new header file. Geliang, I think it woul=
d be easier to do a v13 with the header changes rather than apply v12 and s=
quash header changes.
>
> I think Andrii is not opposed to have a dedicated MPTCP helper file becau=
se from what I understood, he only asked why we created a new file, no?
>
> For me it makes sense to have this dedicated file. The main reason is rel=
ated to the maintenance: to have us being cc'd for all patches modifying th=
is file. Would it not be easier with a dedicated file?

Hi Matt, Mat,

I just sent out 5 squash-to patches to address to Andrii's other
comments except this bpf_tcp_helpers.h one.

Thanks,
-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
