Content-Type: multipart/mixed; boundary="===============0129178571521746708=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: mptcp: move page frag
 allocation in mptcp_sendmsg()
Date: Tue, 06 Oct 2020 15:05:40 +0200
Message-ID: <25159dc690aed7ba022e5eab2921409623e70a7c.camel@redhat.com>
In-Reply-To: 57cb8722-066d-7354-bf42-50420b436c74@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6217

--===============0129178571521746708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-10-06 at 14:20 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 05/10/2020 11:00, Paolo Abeni wrote:
> > This, as suggested by Florian, avoid probe coalescing, which
> > will hit a later WARN_ON_ONCE() and will cause stream corruption.
> > =

> > Additionally bail early when the MPTCP win is closed an no
> > probe.
> =

> Thank you for the patch!
> =

> I guess it was for "mptcp: keep track of advertised windows right edge" =

> commit and not "mptcp: move page frag allocation in mptcp_sendmsg()".

Indeed! thanks for the double check && correction!

/P

--===============0129178571521746708==--
