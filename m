Content-Type: multipart/mixed; boundary="===============0228625910551890668=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] protocol: add comment to smb mb
Date: Wed, 15 Jan 2020 07:46:40 -0800
Message-ID: <alpine.OSX.2.21.2001150746130.35155@ndoyal-mobl1.amr.corp.intel.com>
In-Reply-To: 20200115091023.3187-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3362

--===============0228625910551890668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2020, Florian Westphal wrote:

> squashto: mptcp: add subflow write space signalling and mptcp_poll
>
> v2: also add comment to subflow_write_space.
>

Thanks Florian. Looks ready to merge.


Mat


> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 1 +
> net/mptcp/subflow.c  | 1 +
> 2 files changed, 2 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6df4eb20916c..5dfca0aa7ce4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -547,6 +547,7 @@ static void ssk_check_wmem(struct mptcp_sock *msk, st=
ruct sock *ssk)
> 	if (sock) {
> 		clear_bit(MPTCP_SEND_SPACE, &msk->flags);
> 		smp_mb__after_atomic();
> +		/* set NOSPACE only after clearing SEND_SPACE flag */
> 		set_bit(SOCK_NOSPACE, &sock->flags);
> 	}
> }
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ae9173040f17..3461789ee605 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -727,6 +727,7 @@ static void subflow_write_space(struct sock *sk)
> 	if (parent && sk_stream_is_writeable(sk)) {
> 		set_bit(MPTCP_SEND_SPACE, &mptcp_sk(parent)->flags);
> 		smp_mb__after_atomic();
> +		/* set SEND_SPACE before sk_stream_write_space clears NOSPACE */
> 		sk_stream_write_space(parent);
> 	}
> }
> -- =

> 2.24.1
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============0228625910551890668==--
