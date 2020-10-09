Content-Type: multipart/mixed; boundary="===============2051142673216962491=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] selftests: mptcp: interpret \n as a new
 line
Date: Thu, 08 Oct 2020 17:56:21 -0700
Message-ID: <20201008175621.6d2f2ddd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: c750c3256bec4ceab91a95f2725e4bc026f4b5dc.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6264

--===============2051142673216962491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Oct 2020 18:12:45 +0200 Paolo Abeni wrote:
> On Tue, 2020-10-06 at 18:06 +0200, Matthieu Baerts wrote:
> > In case of errors, this message was printed:
> > =

> >   (...)
> >   balanced bwidth with unbalanced delay       5233 max 5005  [ fail ]
> >   client exit code 0, server 0
> >   \nnetns ns3-0-EwnkPH socket stat for 10003:
> >   (...)
> > =

> > Obviously, the idea was to add a new line before the socket stat and not
> > print "\nnetns".
> > =

> > The commit 8b974778f998 ("selftests: mptcp: interpret \n as a new line")
> > is very similar to this one. But the modification in simult_flows.sh was
> > missed because this commit above was done in parallel to one here below.
> =

> Acked-by: Paolo Abeni <pabeni(a)redhat.com>

Applied, thanks!
--===============2051142673216962491==--
