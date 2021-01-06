Content-Type: multipart/mixed; boundary="===============6752944832333426229=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [mptcp-net 2/2] mptcp: better msk-level shutdown.
Date: Tue, 05 Jan 2021 16:16:42 -0800
Message-ID: <79182524-b33c-d4a9-3945-1cf0524a8dd6@linux.intel.com>
In-Reply-To: a8b08941cf38265af9ee0f7882d95b821bd20e13.1608628900.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7269

--===============6752944832333426229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Dec 2020, Paolo Abeni wrote:

> Instead of re-implementing most of inet_shutdown, re-use
> such helper, and implement the MPTCP-specific bits at the
> 'proto' level.
>
> The msk-level disconnect() can now be invoked, lets provide a
> suitable implementation.
>
> As a side effect, this fixes bad state management for listener
> sockets. The latter could lead to division by 0 oops since
> commit ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling").
>
> Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machin=
e")
> Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 62 ++++++++++++--------------------------------
> 1 file changed, 17 insertions(+), 45 deletions(-)
>

Reviewed and confirmed the fix applied to the current -net tree with the =

syzkaller reproducer Christoph listed in =

https://github.com/multipath-tcp/mptcp_net-next/issues/121

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============6752944832333426229==--
