Content-Type: multipart/mixed; boundary="===============7940993126237237106=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] questions about mptcp-level locking
Date: Tue, 16 Apr 2019 01:30:00 +0200
Message-ID: <20190415233000.rs4essy2acpporlz@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1904151546390.10921@desktop-bed69sk.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1073

--===============7940993126237237106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > 2) msk->ack_seq is updated via atomic_read/_set(), AFAICS without any
> > serialization. Multiple concurrent threads can race while updating the
> > sequence number, currupting the msk status. Florian suggested we could
> > use cmpxchg instead of set(), but we agree that acquiring the socket
> > lock would be simpler and safer - unless we missed something ;)
> =

> Apparently RFCv2 had a lot going for it, because I used
> atomic64_try_cmpxchg() there. With the (intended) locking at the beginning
> of mptcp_recvmsg(), I thought all of the writes to msk->ack_seq were under
> the mptcp-level socket lock, so I took out the cmpxchg. Are there any
> concerns if the mptcp_recvmsg() locking problem (from question #1) is fix=
ed?

Not from my or Paolos side, we discussed this earlier today and we both
would prefer simpler lock/release over cmpxchg tricks.

--===============7940993126237237106==--
