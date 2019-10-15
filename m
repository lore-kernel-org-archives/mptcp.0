Content-Type: multipart/mixed; boundary="===============7385549420281790764=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 5/6] mptcp: add and use
 mptcp_subflow_get_retrans
Date: Tue, 15 Oct 2019 13:22:17 +0200
Message-ID: <33dd43b3154ecf177d07b5471c538f11ebc931c1.camel@redhat.com>
In-Reply-To: 20191014231919.2454-6-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2136

--===============7385549420281790764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2019-10-15 at 01:19 +0200, Florian Westphal wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 259a2743db91..e003608af237 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -781,6 +781,35 @@ static void mptcp_retransmit_timer(struct timer_list=
 *t)
>  	sock_put(sk);
>  }
>  =

> +/* return first subflow that has no data outstanding at tcp level.
> + *
> + * Never return a backup subflow unless thats the only kind left.
> + */
> +static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *m=
sk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *backup =3D NULL;
> +	bool use_backup =3D true;
> +
> +	sock_owned_by_me((const struct sock *)msk);
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk =3D mptcp_subflow_tcp_socket(subflow)->sk;
> +
> +		if (!subflow->backup)
> +			use_backup =3D false;
> +
> +		if (tcp_write_queue_empty(ssk)) {
> +			if (!subflow->backup)
> +				return ssk;

I think that to be as accurate as possible we could try to check only
vs the write queue of the subflow used to send the current dfrag - =

otherwise we could end-up with spurious/unneded retransmissions on some
corner cases.

Additionally we may want to explicitly exclude/penalize such subflow
from the selection here.

Storing the subflow ptr into a new/additional dfrag field at
transmission time should allow the above.

Cheers,

Paolo

--===============7385549420281790764==--
