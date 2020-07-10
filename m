Content-Type: multipart/mixed; boundary="===============3849675945787032867=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING in warn_bad_map
Date: Fri, 10 Jul 2020 15:58:16 +0200
Message-ID: <ff5734c28c10438ed63b0000a03a473cf4d3ea7a.camel@redhat.com>
In-Reply-To: CACT4Y+YGhrVz2NknOFBw+WPTMc-iVyEC7=xEeRrmEw=6rBvU=Q@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4975

--===============3849675945787032867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[sorry for lagging behind]
On Wed, 2020-07-08 at 10:42 +0200, Dmitry Vyukov wrote:
> On Tue, Jul 7, 2020 at 6:39 PM Paolo Abeni <pabeni(a)redhat.com> wrote:
> > Should I wait for that event to send a '#syz fix: ' reply? I fear
> > otherwise syzbot may test a [net-next] tree without the first mentioned
> > commit and still hit the issue.
> =

> https://goo.gl/tpsmEJ#bug-status-tracking should answer your question
> (or we need to improve the docs).

Indeed it answer in a clear way, thanks for the pointer

> I see the commit you mentioned
> 13f1555c1b4c49b8ab9dd80b7353deec0526ccac is actually a merge:
>      Merge branch 'MPTCP-improve-fallback-to-TCP'
> I guess what fixes it is a particular non-merge commit, right? What is
> it? The syzbot referenced commits are considered for stable trees, and
> a merge is not very useful for backporting.

The relevant non-merge commit should be:

commit e1ff9e82e2ea53d01540692a85c16a77e1089537
Author: Davide Caratti <dcaratti(a)redhat.com>
Date:   Mon Jun 29 22:26:20 2020 +0200

    net: mptcp: improve fallback to TCP

but that is part of a code re-factor, really not suitable for stable
branch IMHO.

Thanks,

Paolo

--===============3849675945787032867==--
