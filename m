Content-Type: multipart/mixed; boundary="===============5235783932452248061=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH/RFC 0/7] improve subflow join handling
Date: Tue, 26 Nov 2019 17:56:03 +0100
Message-ID: <6948f62b38443f7f737463d9e7fd915db09d058d.camel@redhat.com>
In-Reply-To: 20191126164509.GG795@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2696

--===============5235783932452248061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-11-26 at 17:45 +0100, Florian Westphal wrote:
> Florian Westphal <fw(a)strlen.de> wrote:
> > This set aims to improve handling of multiple subflows.
> > There are multiple remaining problems, see below, but I wanted to send =
what
> > I have now rather than keep this back.
> > =

> > The first 3 patches are fixes to handle refcount leaks found while work=
ing
> > on this, I've added the commit name of where they could be squashed to.
> =

> I see those have been marked 'awaiting upstream', what does that mean in
> mptcp context?

It means the patches are ready to be merged, waiting for someone
(Matt?) to merge them.

It looks correct to me for the first 3 patches.

/P=20

--===============5235783932452248061==--
