Content-Type: multipart/mixed; boundary="===============7177561276772255739=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 2/6] mptcp: implement wmem reservation
Date: Mon, 30 Nov 2020 15:43:33 -0800
Message-ID: <7d93fc11-4993-802e-e318-157226f91cf6@linux.intel.com>
In-Reply-To: e1726dbf86cee84d76098f42774be3abe2c367c7.1606413118.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6993

--===============7177561276772255739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Nov 2020, Paolo Abeni wrote:

> This leverages the previous commit to reserve the wmem
> required for the sendmsg() operation when the msk socket
> lock is first acquired.
> Some heuristics are used to get a reasonable [over] estimation of
> the whole memory required. If we can't forward alloc such amount
> fallback to a reasonable small chunk, otherwise enter the wait
> for memory path.
>
> When sendmsg() needs more memory it looks at wmem_reserved
> first and if that is exhausted, move more space from
> sk_forward_alloc.
>
> The reserved memory is not persistent and is released at the
> next socket unlock via the release_cb().
>
> Overall this will simplify the next patch.
>
> Acked-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 92 ++++++++++++++++++++++++++++++++++++++++----
> net/mptcp/protocol.h |  1 +
> 2 files changed, 86 insertions(+), 7 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============7177561276772255739==--
