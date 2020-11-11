Content-Type: multipart/mixed; boundary="===============4824347304253171085=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 2/6] mptcp: protect the rx path with the
 msk socket spinlock
Date: Tue, 10 Nov 2020 18:12:25 -0800
Message-ID: <dbd6ea54-5369-95c7-4526-3ef2926e38a5@linux.intel.com>
In-Reply-To: d1779b7594d19cfcf84a64e11726f190f14bfa6c.1605006569.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6654

--===============4824347304253171085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2020, Paolo Abeni wrote:

> Such spinlock is currently used only to protect the 'owned'
> flag inside the socket lock itself. With this patch we extend
> it's scope to protect the whole msk receive path and
> sk_forward_memory.
>

Is it a problem that lock_sock()/release_sock() and the data path will be =

competing for this spinlock? Just wondering if the choice to use this lock =

is driven by not wanting to add a new lock (which is understandable!). =

Given that the spinlock is only held for short times hopefully the data =

path is not delaying the regular socket lock calls very much.

> Given the above we can always move data into the msk receive queue
> (and OoO queue) from the subflow.
>
> We leverage the previous commit, so that we need to acquire the
> spinlock in the tx path only when moving fwd memory
> to wfwd and vice versa.
>
> recvmsg() must now explicitly acquire the socket spinlock
> when moving skbs out of sk_receive_queue. We use a snd rx
> queue and splice the first into the latter to reduce the number locks
> required.

To see if I understood this (and the code) correctly:

For the msk, sk_receive_queue is protected only by the mptcp_data_lock() =

and is where MPTCP-level data is reassembled in-order without holding the =

msk socket lock.

msk->receive_queue is protected by the socket lock, and is where in-order =

skbs are moved so they can be copied to userspace.


I still need to take a deeper look at the locking changes but the approach =

looks ok.



--
Mat Martineau
Intel
--===============4824347304253171085==--
