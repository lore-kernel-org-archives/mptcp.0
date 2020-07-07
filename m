Content-Type: multipart/mixed; boundary="===============2157745099770950909=="
MIME-Version: 1.0
From: Dmitry Vyukov <dvyukov at google.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING in warn_bad_map
Date: Tue, 07 Jul 2020 17:47:06 +0200
Message-ID: <CACT4Y+Yiskcj-0vfH9PJ0xWxVuqUNhPqT5+0exY8jH-tFvnUCQ@mail.gmail.com>
In-Reply-To: 0c2f021ca49f1eb12e87369e88f76bc9314511ea.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4934

--===============2157745099770950909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2020 at 5:18 PM Paolo Abeni <pabeni(a)redhat.com> wrote:
>
> [stripping some recipients, since the following should be syzbot-
> specific]
>
> On Mon, 2020-06-22 at 02:30 -0700, syzbot wrote:
> > syzbot found the following crash on:
> >
> > HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.=
org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D11124521100=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd195fe572fb=
15312
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D42a07faa5923c=
faeb9c9
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+42a07faa5923cfaeb9c9(a)syzkaller.appspotmail.com
>
> This should be fixed by the combination of commit 0e7bc442b405 ("mptcp:
> fix DSS map generation on fin retransmission") (currently on -net) and
> commit 13f1555c1b4c49b8ab9dd80b7353deec0526ccac (currently only on net-
> next).
>
> In not clear to me how to communicate the above to syzbot. Any
> suggestion more than welcome!

Hi Paolo,

Yes, there is no way to attach to fixing commits via email interface.
But if both are required to stop this WARNING from happening, we can
mark it as fixed by the one that is supposed to propagate to all trees
later. I guess it's the one in net-next?
--===============2157745099770950909==--
