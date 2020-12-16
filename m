Content-Type: multipart/mixed; boundary="===============3257812576844517333=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net v2] mptcp: fix pending data accounting
Date: Tue, 15 Dec 2020 16:57:01 -0800
Message-ID: <eb942018-61b7-a0e7-df80-a474ece98266@linux.intel.com>
In-Reply-To: edd14c0ddd620edf4acb99c0b9ef9012a97e7461.1607959409.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7178

--===============3257812576844517333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Dec 2020, Paolo Abeni wrote:

> When sendmsg() needs to wait for memory, the pending data
> is not updated. That causes a drift in forward memory allocation,
> leading to stall and/or warnings at socket close time.
>
> This change addresses the above issue moving the pending data
> counter update inside the sendmsg() main loop.
>
> Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> v1 -> v2:
> - really fix broken accounting
> ---
> net/mptcp/protocol.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>

Thanks Paolo, looks good for the -net tree.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3257812576844517333==--
