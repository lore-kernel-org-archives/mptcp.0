Content-Type: multipart/mixed; boundary="===============6727942450726718032=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 2/4] mptcp: refactor token container
Date: Fri, 26 Jun 2020 14:25:19 -0700
Message-ID: <alpine.OSX.2.23.453.2006261424430.66996@redsall-mobl2.amr.corp.intel.com>
In-Reply-To: 11ec0af6f8782f2551a7508d22b31db01ad11246.1593192442.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4834

--===============6727942450726718032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2020, Paolo Abeni wrote:

> Replace the radix tree with a hash table allocated
> at boot time. The radix tree has some shortcoming:
> a single lock is contented by all the mptcp operation,
> the lookup currently use such lock, and traversing
> all the items would require a lock, too.
>
> With hash table instead we trade a little memory to
> address all the above - a per bucket lock is used.
>
> To hash the MPTCP sockets, we re-use the msk' sk_node
> entry: the MPTCP sockets are never hashed by the stack.
> Replace the existing hash proto callbacks with a dummy
> implementation, annotating the above constraint.
>
> Additionally refactor the token creation to code to:
>
> - limit the number of consecutive attempts to a fixed
> maximum. Hitting a hash bucket with a long chain is
> considered a failed attempt
>
> - accept() no longer can fail to token management.
>
> - if token creation fails at connect() time, we do
> fallback to TCP (before the connection was closed)
>
> v1 -> v2:
> - fix "no newline at end of file" - Jakub
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c |  45 ++++---
> net/mptcp/protocol.h |  14 ++-
> net/mptcp/subflow.c  |  19 ++-
> net/mptcp/token.c    | 271 ++++++++++++++++++++++++++++++-------------
> 4 files changed, 236 insertions(+), 113 deletions(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============6727942450726718032==--
