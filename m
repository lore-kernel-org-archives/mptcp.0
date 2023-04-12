Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893733205
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 14:36:48 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso63645e9.0
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681310207; x=1683902207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ5Da21SHvC9nshSJadPY72sAw8THhs3ruWeBsGMVQc=;
        b=WWKl3pXEEO1YhmfXqQay1x8DDLSi6WmwxnUh4bTKkRUE71/Zv2tXzVRfxfdjgGDksF
         5lgB3rPC8EyndkRXLFOv4vC+ZpudF8JNK7NFIrW93D+A46dJL1G1iJofP9yuxhMAlAMf
         pExqsY4lUS3sRrDpXsWoXCKrU6JzHLo6jBakEnkYBCtQxh+TxEOgAbNhd4eztbI6dyDJ
         0aStdgaShuqFnTGZTpenmLVacRNr6HUghKqOlLhDdB8nwk0gIRIZkrgTWfFM79gnSQNJ
         tGqZPCw7jp7h6YK0l9W+0ymeGYpD7KdP7xCa3YQ791OeTiGR83QZKDQ3Bix/4rgsBZoQ
         SzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681310207; x=1683902207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQ5Da21SHvC9nshSJadPY72sAw8THhs3ruWeBsGMVQc=;
        b=cflL6g42vFYHTXuOc5SZBGzZh55bv3A+es6a+C8633oNOeL84oSa4rWNfkZSibXz6g
         eXTFqzNUjuBennONr1+SpYmvzCeikmwEQrPvC/m+zC7IKf4bMz1HXhyaN8HApDmo1nd/
         09PQLaHSOn1WYM5YMCke6vNNfQeJ8P6K9UxnARnofH6i7XmZdVh/Gu9KGGuug1l73Mxd
         scX01xyZIexj7NgAjwiDXCSSnoNj2j1C8jI7ahjnbUdKMRh//oqndXagxnw6x6jDeF3b
         3ZoKIIJfNcPJbjUmBv3NWagRgw0KOLYap92ieWcyfys7AZ9WCF6cRv9aQsL4YiQ+2eXg
         oUBQ==
X-Gm-Message-State: AAQBX9ex7P00QWyEz3d3T9olQ0vb1ASy/Q/ziUKmmY/wIli5xz6nwFwG
	iSTT9x0Nk7i4Fd6GfwnUaGWKt9Bb0NpKmvgoefte/Q==
X-Google-Smtp-Source: AKy350a6rl+G2vgp08/k903Rby90og7xTyRH0jFiW1fda+XtbApRhr+n5MF6Gwzk0H0ex1Vpy3gaPAcRejvDjKlyxOs=
X-Received: by 2002:a05:600c:4fc6:b0:3ed:e6da:ffcd with SMTP id
 o6-20020a05600c4fc600b003ede6daffcdmr428452wmq.7.1681310206647; Wed, 12 Apr
 2023 07:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0000000000004afcae05a7041e98@google.com> <5272b58b-59b8-9ae7-38c7-2578a304e3de@tessares.net>
 <CANp29Y5x13DD8n+aTypSGa5B7+VgOYRvCiSugHz7eFBZrKMZ1w@mail.gmail.com> <7c1b7cc3-82fc-4e72-7021-8d209bb3bd83@tessares.net>
In-Reply-To: <7c1b7cc3-82fc-4e72-7021-8d209bb3bd83@tessares.net>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 12 Apr 2023 16:36:34 +0200
Message-ID: <CANp29Y4F=qM9L0F+2Yb6DH=JSiaUSdu-BSN-pSmMp4W0fpGCRg@mail.gmail.com>
Subject: Re: INFO: task hung in corrupted (2)
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: syzbot <syzbot+6921abfb75d6fc79c0eb@syzkaller.appspotmail.com>, 
	syzkaller-bugs@googlegroups.com, syzbot <syzkaller@googlegroups.com>, 
	MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 4:22=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Aleksandr,
>
> Thank you for your reply!
>
> On 12/04/2023 12:55, Aleksandr Nogikh wrote:
> > Hello Matthieu,
> >
> > Thanks for contacting us!
> >
> > This bug is somewhat special. Syzbot normally classifies crashes
> > according to their titles, but there are also cases when we cannot
> > extract a good crash title. As a result, crashes caused by unrelated
> > problems may end up in the same syzbot bug. This is the case with
> > "INFO: task hung in corrupted", "no output from test machine", "lost
> > connection to test machine" and a few others. Probably we should put
> > some explicit warning label on them and treat them differently.. At
> > the moment it just drives bisections and subsystem recognition
> > somewhat crazy.
>
> Thank you for the explanation!
>
> (yes, a label would be nice and it would be even better if they are
> treated differently :) )

I've filed https://github.com/google/syzkaller/issues/3806
Hopefully we'll get to it some day :)

>
> > The MPTCP was mentioned in the crash from "2020/05/28 11:24":
> >
> > report: https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D138006=
d2100000
> > syz repro: https://syzkaller.appspot.com/text?tag=3DReproSyz&x=3D14947d=
26100000
> > C repro: https://syzkaller.appspot.com/text?tag=3DReproC&x=3D172726d210=
0000
> >
> > Though, looking at the report, it seems that mtcp was mentioned there
> > just coincidentally.
>
> Yes, I confirm it looks like a coincidence.
>
> The two repro seem to suggest we should assign this to the USB
> subsystem. But does it make sense to do that if there are different and
> unrelated problems linked to the same report? Also because there were no
> more activities for more than 2 years, it can maybe be marked as closed?

Good idea, let's just invalidate the bug:
#syz invalid

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
