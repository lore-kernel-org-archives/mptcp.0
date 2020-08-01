Content-Type: multipart/mixed; boundary="===============5489250537733896794=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 03/12] mptcp: trigger msk processing even for
 OoO data
Date: Sun, 02 Aug 2020 00:30:33 +0200
Message-ID: <20200801223033.GB29169@breakpoint.cc>
In-Reply-To: b62dcbaec7017382d6218e4b8070bc11b4c7c206.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5422

--===============5489250537733896794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index beb34b8a5363..e964f3670d75 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -268,6 +268,9 @@ mptcp_subflow_rsk(const struct request_sock *rsk)
>  	return (struct mptcp_subflow_request_sock *)rsk;
>  }
>  =

> +#define MPTCP_SUBFLOW_DATA_AVAIL	1
> +#define MPTCP_SUBFLOW_OOO_DATA		2

Nit: maybe make this an enum.  OTOH, at the end of the series,
OOO_DATA seems to be set but never used?
Is this for a future patch  [or maybe i made a mistake applying
the series to my local tree and its used after all...]

>  /* MPTCP subflow context */
>  struct mptcp_subflow_context {
>  	struct	list_head node;/* conn_list of subflows */
> @@ -292,7 +295,7 @@ struct mptcp_subflow_context {
>  		map_valid : 1,
>  		mpc_map : 1,
>  		backup : 1,
> -		data_avail : 1,
> +		data_avail : 2,

... so this is 'enum mptcp_data_avail data_avail'.  Just a suggestion of co=
urse.
--===============5489250537733896794==--
