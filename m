Content-Type: multipart/mixed; boundary="===============5816408842604931756=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] questions about mptcp-level locking
Date: Mon, 15 Apr 2019 16:24:37 -0700
Message-ID: <alpine.OSX.2.21.1904151546390.10921@desktop-bed69sk.sea.intel.com>
In-Reply-To: 89965e6117a6e8a7cd02ad18b22000f7ed715e06.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1072

--===============5816408842604931756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 15 Apr 2019, Paolo Abeni wrote:

> Hi all,
>
> I just gave a better look at the current locking schema implemented in
> the mptcp code, and found some things I could not explain/look like
> bugs to me.
>
> 1) in mptcp_recvmsg(), just before the function return, both ssk and sk
> socket lock are released. It looks like the named function can complete
> even without not acquiring such locks. PROVE_LOCKING does not splat
> because release_sock() is a no-op if the lock is not owned - thanks
> Florian for noticing that. I'm unsure it the above is intentional, but
> looks confusing.
>

Definitely not intentional. The lock_sock() calls were near the beginning =

of mptcp_recvmsg() in RFCv2 and then apparently deleted accidentally. I'll =

fix that.

> 2) msk->ack_seq is updated via atomic_read/_set(), AFAICS without any
> serialization. Multiple concurrent threads can race while updating the
> sequence number, currupting the msk status. Florian suggested we could
> use cmpxchg instead of set(), but we agree that acquiring the socket
> lock would be simpler and safer - unless we missed something ;)

Apparently RFCv2 had a lot going for it, because I used =

atomic64_try_cmpxchg() there. With the (intended) locking at the beginning =

of mptcp_recvmsg(), I thought all of the writes to msk->ack_seq were under =

the mptcp-level socket lock, so I took out the cmpxchg. Are there any =

concerns if the mptcp_recvmsg() locking problem (from question #1) is =

fixed?

>
> 3) Reading http://multipath-tcp.org/data/MultipathTCP-netsys.pdf
> slide 64, and the MTPCP RFC it looks like windows size must be shared
> for all subflows, but AFACS, the current code does not allow that. To
> such extend we would need to read/update an MPTCP-level status while
> reading/updating the subflow's window size.
>

Yes, the current code doesn't implement this - I have been referring to it =

as "coupled receive windows" in =

https://github.com/multipath-tcp/mptcp_net-next/wiki/Status#future-work

> With the current lock nesting, as imposed by mptcp_sendmsg() (msk lock
> -> ssk lock), we can't do that, as window size computation happens in
> the TCP core code, with ssk lock already held and no notion about msk
> lock.
>
> Managing the MPTCP pending xmit data - to implement  level data
> retransmission - will pose similar issues as we would probably need to
> remove elements from the MPTCP pending data queue at TCP ack processing
> time.
>
> I *think* that inverting the locks order in mptcp_sendmsg() (and in
> _recvmsg() - assuming we move to socket lock even there) should address
> the above - allowing MPTCP hooks in the core TCP code to acquire the
> msk lock.
>

Right now, the mptcp-level socket lock is taken first when called from =

userspace for sendmsg/recvmsg because the MPTCP-level socket will need to =

be locked first to determine which subflow socket to work with, and then =

lock the subflow it needs to use.

I had been thinking that calling "up" from the subflow to the MPTCP-level =

socket would involve scheduling a worker that would be able to lock in the =

same order as sendmsg/recvmsg. That does introduce some latency, but I =

don't think MPTCP-level resends are as time-sensitive as TCP =

retransmission (but maybe others on the list have more data or experience =

on that topic).

As for the window size computation, I've been trying to think of ways to =

handle that without needing the msk lock but haven't found the right idea =

yet.


--
Mat Martineau
Intel

--===============5816408842604931756==--
