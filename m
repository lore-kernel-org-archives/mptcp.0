Content-Type: multipart/mixed; boundary="===============1915971072092861719=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix race between MP_JOIN and close
Date: Thu, 28 May 2020 11:52:16 -0700
Message-ID: <20200528185216.GI64606@MacBook-Pro-64.local>
In-Reply-To: 5d79dc3444f2ee869849dda8a92ff8e44887739d.1590689729.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4548

--===============1915971072092861719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 05/28/20 - 20:15, Paolo Abeni wrote:
> If a MP_JOIN subflow completes the 3whs while another
> CPU is closing the master msk, we can hit the
> following race:
> =

> CPU1                                    CPU2
> =

> close()
>  mptcp_close
>                                         subflow_syn_recv_sock
>                                          mptcp_token_get_sock
>                                          mptcp_finish_join
>                                           inet_sk_state_load
>   mptcp_token_destroy
>   inet_sk_state_store(TCP_CLOSE)
>   __mptcp_flush_join_list()
>                                           mptcp_sock_graft
>                                           list_add_tail
>   sk_common_release
>    sock_orphan()
>  <socket free>
> =

> The MP_JOIN socket will be leaked. Additionally we can hit
> UaF for the msk 'struct socket' referenced via the 'conn'
> field.
> =

> This change try to address the issue introducing some
> synchronization between the MP_JOIN 3whs and mptcp_close
> via the join_list spinlock. If we detect the msk is closing
> the MP_JOIN socket is closed, too.
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)

LGTM, but I'm still hitting the KASAN: use-after-free in inet_twsk_bind_unh=
ash.

:-/


Christoph

--===============1915971072092861719==--
