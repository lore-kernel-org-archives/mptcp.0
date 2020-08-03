Content-Type: multipart/mixed; boundary="===============5479100042186494546=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: use mptcp_for_each_subflow in
 mptcp_stream_accept
Date: Mon, 03 Aug 2020 18:42:48 +0200
Message-ID: <23193e12ae89515e3044862a5596576b02766378.camel@redhat.com>
In-Reply-To: fe531e58a52eae5aa46dd93d30d623f8862c3d09.1596459430.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5447

--===============5479100042186494546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-08-03 at 21:00 +0800, Geliang Tang wrote:
> Use mptcp_for_each_subflow in mptcp_stream_accept instead of
> open-coding.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/protocol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d3fe7296e1c9..400824eabf73 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2249,7 +2249,7 @@ static int mptcp_stream_accept(struct socket *sock,=
 struct socket *newsock,
>  		 * This is needed so NOSPACE flag can be set from tcp stack.
>  		 */
>  		__mptcp_flush_join_list(msk);
> -		list_for_each_entry(subflow, &msk->conn_list, node) {
> +		mptcp_for_each_subflow(msk, subflow) {
>  			struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>  =

>  			if (!ssk->sk_socket)

Acked-by: Paolo Abeni <pabeni(a)redhat.com>

--===============5479100042186494546==--
