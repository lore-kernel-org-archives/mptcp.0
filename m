Content-Type: multipart/mixed; boundary="===============2806242928429653048=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Brief news from LPC2019
Date: Tue, 10 Sep 2019 18:24:53 +0100
Message-ID: <CAKuKrBk-u-ReHFpd3vtfqdoF1O6f73OwuCZCwB4YjF8H8-td6w@mail.gmail.com>
In-Reply-To: 20190909232141.GB2066@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1814

--===============2806242928429653048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Tue, Sep 10, 2019 at 12:21 AM Florian Westphal <fw(a)strlen.de> wrote:
>
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > Briefly:
> >  - IPv6 support will be required for the initial patch-set
>
> Shouldn't be too hard, I think we can add it once we can deal
> with multiple subflows without problems.

Indeed, should not be a problem and better to work on other important
topics for this initial patch set first.

> >  - Creating MPTCP socket can be done by any app as long as we have a
> > way to block the creation of new sockets in case of issues (CGroup,
> > etc.)
>
> I assume that means the sysctl is acceptable?

To be honest, I will have to refresh my mind by watching the recording
because a few different people jumped into the discussion :)
- It should not be disabled by default (if compiled) because the goal
is to have people testing it: no sysctl needed
- But we should be able to block the creation of new MPTCP sockets in
case of problem: yes for the sysctl but enabled by default
- But for Android, each app is launched in a netns and for them the
sysctl is not a good protection
- But there are others ways to block it: cgroup and (...), I don't
remember the second way.

So I don't know what we should do with this sysctl :-D
If it is there, it should be "on" by default.

Cheers,
Matt

PS: oh and also my colleagues pointed me to this article:
https://www.heise.de/newsticker/meldung/Multipath-TCP-Unterstuetzung-soll-e=
ndlich-in-Linux-einziehen-4518447.html
More something for you or Christoph to read :-)

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============2806242928429653048==--
