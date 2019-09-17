Content-Type: multipart/mixed; boundary="===============5940148993434177041=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC 6/6] mptcp: use __tcp_poll instead of tcp_poll
Date: Tue, 17 Sep 2019 18:38:34 +0200
Message-ID: <23f0c3793e3aa80f090b0660c9fd8c8bef9b01b7.camel@redhat.com>
In-Reply-To: 20190909155317.31119-7-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1863

--===============5940148993434177041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-09 at 17:53 +0200, Florian Westphal wrote:
> tcp_poll places current task on a wait queue.  This can cause us to block
> forever -- some subflows might be backup/failover and never receive any
> data.
> =

> Use __tcp_poll instead to avoid blocking current task again after parent
> mptcp socket has been woken up from the subflow layer.
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2a91fff1f385..533fe2c50d3a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1182,7 +1182,7 @@ static __poll_t mptcp_poll(struct file *file, struc=
t socket *sock,
>  		struct socket *tcp_sock;
>  =

>  		tcp_sock =3D mptcp_subflow_tcp_socket(subflow);
> -		ret |=3D tcp_poll(file, tcp_sock, wait);
> +		ret |=3D __tcp_poll(tcp_sock->sk);
>  	}
>  	release_sock(sk);

This allows mptcp_poll working even without a 'struct socket'. we still
relies on such struct presence for:

kernel_accept
kernel_sock_shutdown
kernel_setsockopt
kernel_getsockopt
kernel_bind
kernel_connect

I'm wondering if we should try to get rid completely of any depenency
on 'struct socket'? That will fix the current issue with MP_JOIN, will
reduce the memory usage and likely will improve accept time.

A quick look makes me think that the most problematic call to be
addressed without using any 'struct socket' are kernel_bind() and
kernel_connect(), perhaps we can use a transient 'struct socket' just
for subflow_connect() ? WDYT?

Thanks,

Paolo




--===============5940148993434177041==--
