Content-Type: multipart/mixed; boundary="===============8419756149560391273=="
MIME-Version: 1.0
From: Geert Uytterhoeven <geert at linux-m68k.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: MPTCP_KUNIT_TESTS should depend on MPTCP
 instead of selecting it
Date: Tue, 20 Oct 2020 09:40:06 +0200
Message-ID: <CAMuHMdWEKszUOA6Q9Y+vpLdRnq3wstCj1ubV=8iUKZAQkew_wg@mail.gmail.com>
In-Reply-To: CAMuHMdUDpVVejmrr3ayxnN=tgHrgDmUCVMG0VJht1Y-FUUv42Q@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6359

--===============8419756149560391273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 10:38 PM Geert Uytterhoeven
<geert(a)linux-m68k.org> wrote:
> On Mon, Oct 19, 2020 at 5:47 PM Matthieu Baerts
> <matthieu.baerts(a)tessares.net> wrote:
> > On 19/10/2020 13:32, Geert Uytterhoeven wrote:
> > > MPTCP_KUNIT_TESTS selects MPTCP, thus enabling an optional feature the
> > > user may not want to enable.  Fix this by making the test depend on
> > > MPTCP instead.
> >
> > I think the initial intension was to select MPTCP to have an easy way to
> > enable all KUnit tests. We imitated what was and is still done in
> > fs/ext4/Kconfig.
> >
> > But it probably makes sense to depend on MPTCP instead of selecting it.
> > So that's fine for me. But then please also send a patch to ext4
> > maintainer to do the same there.
>
> Thanks, good point.  I didn't notice, as I did have ext4 enabled anyway.
> Will send a patch for ext4.  Looks like ext4 and MPTCP where the only
> test modules selecting their dependencies.

FTR, "[PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead
of  selecting it"
https://lore.kernel.org/lkml/20201020073740.29081-1-geert(a)linux-m68k.org/


Gr{oetje,eeting}s,

                        Geert

-- =

Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert(a)linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
--===============8419756149560391273==--
