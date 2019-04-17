Content-Type: multipart/mixed; boundary="===============3162546805211508022=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] questions about mptcp-level locking
Date: Wed, 17 Apr 2019 19:01:28 +0200
Message-ID: <494a12bbe031307b56e8b9d71c0ea54f88cd7a67.camel@redhat.com>
In-Reply-To: 20190415233000.rs4essy2acpporlz@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1075

--===============3162546805211508022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-04-16 at 01:30 +0200, Florian Westphal wrote:
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > > 2) msk->ack_seq is updated via atomic_read/_set(), AFAICS without any
> > > serialization. Multiple concurrent threads can race while updating the
> > > sequence number, currupting the msk status. Florian suggested we could
> > > use cmpxchg instead of set(), but we agree that acquiring the socket
> > > lock would be simpler and safer - unless we missed something ;)
> > =

> > Apparently RFCv2 had a lot going for it, because I used
> > atomic64_try_cmpxchg() there. With the (intended) locking at the beginn=
ing
> > of mptcp_recvmsg(), I thought all of the writes to msk->ack_seq were un=
der
> > the mptcp-level socket lock, so I took out the cmpxchg. Are there any
> > concerns if the mptcp_recvmsg() locking problem (from question #1) is f=
ixed?
> =

> Not from my or Paolos side, we discussed this earlier today and we both
> would prefer simpler lock/release over cmpxchg tricks.

On top of the above, mptcp_recvmsg() calls to tcp_read_sock() -
currently without any lock held. The latter function carries the
following comment:

 * Note:
 *      - It is assumed that the socket was locked by the caller.

So acquiring the sockete lock in mptcp_recvmsg() is apparently
mandatory.

Cheers,

Paolo


--===============3162546805211508022==--
