Content-Type: multipart/mixed; boundary="===============5592249909586828379=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Remove request_version field from
 subflow_request_sock
Date: Thu, 12 Dec 2019 23:11:00 +0100
Message-ID: <330403f5-48da-bdcb-cae7-027773d25982@tessares.net>
In-Reply-To: 20191212045448.13439-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2896

--===============5592249909586828379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo,

On 12/12/2019 05:54, Peter Krystad wrote:
> Since only a single version is supported this fields presence
> is misleading, it dates from when it was thought the version would
> be configurable. The actual requested version is hard-coded in
> mptcp_write_options().
> =

> squashto: Associate MPTCP context with TCP socket

Thank you for the patch and the review!

I just have a question below:

[...]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ddb3a7581d41..93d6c41b76d5 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -48,8 +48,7 @@ static inline struct mptcp_sock *mptcp_sk(const struct =
sock *sk)
>   =

>   /* MPTCP subflow context */
>   struct mptcp_subflow_context {
> -	u32	request_mptcp : 1,  /* send MP_CAPABLE */
> -		request_version : 4;
> +	u32	request_mptcp : 1;  /* send MP_CAPABLE */

When removing these 4 bits, at the end of the series, we now only use 13 =

bits. Should we switch to u16? I didn't check with pahole if it would =

really reduce the size of the structure, I don't think so and maybe we =

don't really need to reduce this bit field but I prefer to ask :)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5592249909586828379==--
