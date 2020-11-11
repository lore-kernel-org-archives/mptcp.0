Content-Type: multipart/mixed; boundary="===============7991994081545804921=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 2/6] mptcp: protect the rx path with the
 msk socket spinlock
Date: Wed, 11 Nov 2020 10:24:36 +0100
Message-ID: <93f008493656a238c48c61e59bfb5488fb639028.camel@redhat.com>
In-Reply-To: dbd6ea54-5369-95c7-4526-3ef2926e38a5@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6656

--===============7991994081545804921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-11-10 at 18:12 -0800, Mat Martineau wrote:
> On Tue, 10 Nov 2020, Paolo Abeni wrote:
> =

> > Such spinlock is currently used only to protect the 'owned'
> > flag inside the socket lock itself. With this patch we extend
> > it's scope to protect the whole msk receive path and
> > sk_forward_memory.
> > =

> =

> Is it a problem that lock_sock()/release_sock() and the data path will be =

> competing for this spinlock? Just wondering if the choice to use this loc=
k =

> is driven by not wanting to add a new lock (which is understandable!). =

> Given that the spinlock is only held for short times hopefully the data =

> path is not delaying the regular socket lock calls very much.

Path 6/6 will shed more light on this. Using the socket spin lock
allows the hack/trick in such patch.

I don't think contention will be a problem, at least in the short term
- if contention will become visibile, we will be doing a lot of pps,
which is good ;). Additionally, in the current code, we already have
contention on the msk socket lock via trylock.

> > Given the above we can always move data into the msk receive queue
> > (and OoO queue) from the subflow.
> > =

> > We leverage the previous commit, so that we need to acquire the
> > spinlock in the tx path only when moving fwd memory
> > to wfwd and vice versa.
> > =

> > recvmsg() must now explicitly acquire the socket spinlock
> > when moving skbs out of sk_receive_queue. We use a snd rx
> > queue and splice the first into the latter to reduce the number locks
> > required.
> =

> To see if I understood this (and the code) correctly:
> =

> For the msk, sk_receive_queue is protected only by the mptcp_data_lock() =

> and is where MPTCP-level data is reassembled in-order without holding the =

> msk socket lock.
> =

> msk->receive_queue is protected by the socket lock, and is where in-order =

> skbs are moved so they can be copied to userspace.

Yes, the above is correct. The introduction of msk->receive_queue
allows skipping one mptcp_data_lock() in recvmsg() for bulk transfer.

There is a possible follow-up improvement:

Open code lock_sock()/release_sock(), so that we can do mptcp-specific
operations - e.g. splicing receive_queue, or fwd allocating memory -
 while acquiring the msk socket lock spinlock inside such helper. That
will avoid up to 2 additional lock operations per recvmsg()/sendmsg().

/P

--===============7991994081545804921==--
