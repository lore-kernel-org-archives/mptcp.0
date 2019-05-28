Content-Type: multipart/mixed; boundary="===============7959418526993791370=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Make mptcp initialization part of tcp
 initialization
Date: Tue, 28 May 2019 10:18:11 -0700
Message-ID: <49aaf91af7007bdef0ebb33ca5a4b54fa0abb1ad.camel@linux.intel.com>
In-Reply-To: 20190525091456.ujuntink7e7sqs7u@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1257

--===============7959418526993791370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-05-25 at 11:14 +0200, Florian Westphal wrote:
> Peter Krystad <peter.krystad(a)linux.intel.com> wrote:
> >  static inline bool sk_is_mptcp(const struct sock *sk)
> >  {
> >  	return tcp_sk(sk)->is_mptcp;
> > @@ -84,6 +86,10 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_o=
ut_options *opts);
> >  =

> >  #else
> >  =

> > +void mptcp_init(void)
> > +{
> > +}
> > +
> =

> ITYM 'static inline void mptcp_init(void) {}'.

Indeed I did.


--===============7959418526993791370==--
