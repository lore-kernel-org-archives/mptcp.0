Content-Type: multipart/mixed; boundary="===============7526713041857084244=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 3/6] mptcp: protect the rx path with the
 msk socket spinlock
Date: Mon, 30 Nov 2020 15:43:53 -0800
Message-ID: <cb8f8ad-2925-fb3-1f78-961b8adfaea@linux.intel.com>
In-Reply-To: fec6667a994d79f2511619dd034b85d425e1e2dc.1606413118.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6994

--===============7526713041857084244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Nov 2020, Paolo Abeni wrote:

> Such spinlock is currently used only to protect the 'owned'
> flag inside the socket lock itself. With this patch, we extend
> its scope to protect the whole msk receive path and
> sk_forward_memory.
>
> Given the above, we can always move data into the msk receive
> queue (and OoO queue) from the subflow.
>
> We leverage the previous commit, so that we need to acquire the
> spinlock in the tx path only when moving fwd memory.
>
> recvmsg() must now explicitly acquire the socket spinlock
> when moving skbs out of sk_receive_queue. To reduce the number of
> lock operations required we use a second rx queue and splice the
> first into the latter in mptcp_lock_sock(). Additionally rmem
> allocated memory is bulk-freed via release_cb()
>
> Acked-by: Florian Westphal <fw(a)strlen.de>
> Co-developed-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 149 +++++++++++++++++++++++++++++--------------
> net/mptcp/protocol.h |   5 ++
> 2 files changed, 107 insertions(+), 47 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============7526713041857084244==--
