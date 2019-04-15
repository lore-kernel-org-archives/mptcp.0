Content-Type: multipart/mixed; boundary="===============3601102807082855194=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] questions about mptcp-level locking
Date: Mon, 15 Apr 2019 17:55:57 +0200
Message-ID: <89965e6117a6e8a7cd02ad18b22000f7ed715e06.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1071

--===============3601102807082855194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I just gave a better look at the current locking schema implemented in
the mptcp code, and found some things I could not explain/look like
bugs to me.

1) in mptcp_recvmsg(), just before the function return, both ssk and sk
socket lock are released. It looks like the named function can complete
even without not acquiring such locks. PROVE_LOCKING does not splat
because release_sock() is a no-op if the lock is not owned - thanks
Florian for noticing that. I'm unsure it the above is intentional, but
looks confusing.

2) msk->ack_seq is updated via atomic_read/_set(), AFAICS without any
serialization. Multiple concurrent threads can race while updating the
sequence number, currupting the msk status. Florian suggested we could
use cmpxchg instead of set(), but we agree that acquiring the socket
lock would be simpler and safer - unless we missed something ;)

3) Reading http://multipath-tcp.org/data/MultipathTCP-netsys.pdf
slide 64, and the MTPCP RFC it looks like windows size must be shared
for all subflows, but AFACS, the current code does not allow that. To
such extend we would need to read/update an MPTCP-level status while
reading/updating the subflow's window size.

With the current lock nesting, as imposed by mptcp_sendmsg() (msk lock
-> ssk lock), we can't do that, as window size computation happens in
the TCP core code, with ssk lock already held and no notion about msk
lock.

Managing the MPTCP pending xmit data - to implement  level data
retransmission - will pose similar issues as we would probably need to
remove elements from the MPTCP pending data queue at TCP ack processing
time.

I *think* that inverting the locks order in mptcp_sendmsg() (and in
_recvmsg() - assuming we move to socket lock even there) should address
the above - allowing MPTCP hooks in the core TCP code to acquire the
msk lock.

Any comments welcome!

Thanks,

Paolo


--===============3601102807082855194==--
