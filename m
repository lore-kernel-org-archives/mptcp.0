Content-Type: multipart/mixed; boundary="===============2738790091029322003=="
MIME-Version: 1.0
From: Dmitry Vyukov <dvyukov at google.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: INFO: task hung in lock_sock_nested (3)
Date: Mon, 05 Oct 2020 15:21:53 +0200
Message-ID: <CACT4Y+ba4LROZp8pCS6qh49gs-=GevgLrSbzdK7yCQ2nCh3sgA@mail.gmail.com>
In-Reply-To: c73586823d1a40b68a40bb971a3601dd13fba766.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6201

--===============2738790091029322003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2020 at 3:17 PM Paolo Abeni <pabeni(a)redhat.com> wrote:
>
> On Fri, 2020-10-02 at 08:48 -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    87d5034d Merge tag 'mlx5-updates-2020-09-30' of git://g=
it...
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1377fb37900=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7b5cc8ec221=
8e99d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfcf8ca5817d6e=
92c6567
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D145662679=
00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14458a4d900=
000
> >
> > The issue was bisected to:
> >
> > commit ab174ad8ef76276cadfdae98731d31797d265927
> > Author: Paolo Abeni <pabeni(a)redhat.com>
> > Date:   Mon Sep 14 08:01:12 2020 +0000
> >
> >     mptcp: move ooo skbs into msk out of order queue.
> >
>
> I can't easily reproduce the issue with the above c repro. I think it's
> just a matter of timing - slower CPU will make the races harder to
> reproduce right? Can I expect/hope more success with the syz-repro
> instead? I'm asking beforehands because the local setup is less
> immediate for that one.

Hard to say. Maybe.
That would be syz-execprog that replays syzkaller programs.

You need to wait for at least 5 minutes because of:
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D140
Hung tasks may be detected only after 2x of that interval.


> Not being able to analyze the bug in a live system, I'm wild guessing
> the race addressed below could be the root cause - even if that
> predates the bisected commit.
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.g=
it master
> ---
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f483eab0081a..db14a7307a8f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1034,6 +1034,11 @@ static void mptcp_nospace(struct mptcp_sock *msk)
>                 if (sock)
>                         set_bit(SOCK_NOSPACE, &sock->flags);
>         }
> +
> +        /* mptcp_data_acked() could run just before we set the NOSPACE b=
it,
> +         * so explicitly check for snd_una value
> +         */
> +        mptcp_clean_una((struct sock *)msk);
>  }
>
>  static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe(a)googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/c73586823d1a40b68a40bb971a3601dd13fba766.camel%40redhat.co=
m.
--===============2738790091029322003==--
