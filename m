Content-Type: multipart/mixed; boundary="===============6931763108688537397=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v2 4/8] mptcp: queue data for mptcp level
 retransmission
Date: Fri, 23 Aug 2019 17:34:40 -0700
Message-ID: <alpine.OSX.2.21.1908231718530.37311@gargpiyu-mobl1.amr.corp.intel.com>
In-Reply-To: 40a2dd6778b9e83fbf7c34d40d765dc436f97b97.1566481012.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1694

--===============6931763108688537397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 22 Aug 2019, Paolo Abeni wrote:

> keep the send page fragment on an MPTCP level retransmission queue.
> the queue entries are allocated inside the page frag allocator,
> acquiring an additional reference to the page for each list entry.
>
> Also switch to a custom page frag refill function, to ensure that
> the current page fragment can always host an MPTCP rtx queue entry.
>
> The MPTCP rtx queue is flushed at disconnect() and close() time
>
> Note that now we need to call __mptcp_init_sock() regarless of mptcp
> enable status, as the destructor will try to walk the rtx_queue.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> rfc v1 -> rfc v2:
> - rtx_queue_tail is now static inline (fix link issue)
> - simpler ALIGN() usage (Florian)
> - fix pfrag accounting, adding rtx entry overhead when allocating
>   a new one
> - fixed page -> virt conversion
> - always init mptcp data structs
> - move rtx queue flushing into both disconnect() and close()
> ---
> net/mptcp/protocol.c | 106 +++++++++++++++++++++++++++++++++++++++----
> net/mptcp/protocol.h |  20 ++++++++
> 2 files changed, 118 insertions(+), 8 deletions(-)
>

This looks like a good approach to me, including the mptcp_data_frag =

structure in the page frag works well.

I started to think about possible adjustments to make it easier to =

introduce zerocopy later, but quickly realized that would be premature.


Thanks,

--
Mat Martineau
Intel

--===============6931763108688537397==--
