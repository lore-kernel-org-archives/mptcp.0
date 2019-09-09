Content-Type: multipart/mixed; boundary="===============5647124173474618140=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Brief news from LPC2019
Date: Tue, 10 Sep 2019 01:21:41 +0200
Message-ID: <20190909232141.GB2066@breakpoint.cc>
In-Reply-To: CAKuKrB=F0x=N4toWuP5MfNmO=4VYPygMHXktMVuNGO4iBCmzbQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 1812

--===============5647124173474618140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> Briefly:
>  - IPv6 support will be required for the initial patch-set

Shouldn't be too hard, I think we can add it once we can deal
with multiple subflows without problems.

>  - Creating MPTCP socket can be done by any app as long as we have a
> way to block the creation of new sockets in case of issues (CGroup,
> etc.)

I assume that means the sysctl is acceptable?

--===============5647124173474618140==--
