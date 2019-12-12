Content-Type: multipart/mixed; boundary="===============0184616782339974909=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Remove version field from
 subflow_request_sock
Date: Fri, 13 Dec 2019 00:48:26 +0100
Message-ID: <745efdd1-84b1-8b50-4b72-391576c91669@tessares.net>
In-Reply-To: 20191212045521.13499-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2906

--===============0184616782339974909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 12/12/2019 05:55, Peter Krystad wrote:
> This field is not used. Version checking is performed in
> mptcp_parse_options().
> =

> squashto: Create SUBFLOW socket for incoming connections
> =

> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
>   net/mptcp/protocol.h | 3 +--
>   net/mptcp/subflow.c  | 4 ----
>   2 files changed, 1 insertion(+), 6 deletions(-)
> =

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3ac8cb7f38fd..b43fa3ec5d23 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -56,8 +56,7 @@ struct mptcp_subflow_request_sock {
>   	struct	tcp_request_sock sk;
>   	u8	mp_capable : 1,
>   		mp_join : 1,
> -		backup : 1,
> -		version : 4;
> +		backup : 1;
>   	u64	local_key;
>   	u64	remote_key;
>   };
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 9f148d19ee10..1874e41066bb 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -43,10 +43,6 @@ static void subflow_init_req(struct request_sock *req,
>   =

>   	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
>   		subflow_req->mp_capable =3D 1;
> -		if (rx_opt.mptcp.version >=3D listener->request_version)
> -			subflow_req->version =3D listener->request_version;
> -		else
> -			subflow_req->version =3D rx_opt.mptcp.version; >   		subflow_req->rem=
ote_key =3D rx_opt.mptcp.sndr_key;
>   	}
>   }
> =


It seems that this code was introduced in the parent commit: "mptcp: =

Handle MP_CAPABLE options for outgoing connections". So I re-apply your =

patch, this time on the right (I think, it's late :) ) commit:

- 2c12cadbe9c9: "squashed" in "mptcp: Handle MP_CAPABLE options for =

outgoing connections"
- 1cb1c55ccee7..357e47f49334: result

Relaunching the tests.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0184616782339974909==--
