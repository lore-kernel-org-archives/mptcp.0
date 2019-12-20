Content-Type: multipart/mixed; boundary="===============0033683831199177001=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/4] Squash-to "mptcp: Create SUBFLOW socket
 for incoming connection"
Date: Fri, 20 Dec 2019 14:12:55 -0800
Message-ID: <alpine.OSX.2.21.1912201411080.52347@mkavai-mobl.amr.corp.intel.com>
In-Reply-To: a896ba9a34ee1191688d7418b076db88263a7d61.1576867317.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3241

--===============0033683831199177001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 20 Dec 2019, Paolo Abeni wrote:

> use is_mptcp instead of 'subflow->mp_capable'

There is still some similar use of subflow->mp_capable in other places =

(subflow.c, options.c) - should those also be re-examined for possible =

change to is_mptcp?

Mat


> ---
> net/mptcp/protocol.c | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 70e28cc0dbe0..283e7dc2d25e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -243,7 +243,6 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
> 				 bool kern)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	struct mptcp_subflow_context *subflow;
> 	struct socket *listener;
> 	struct sock *newsk;
>
> @@ -258,13 +257,14 @@ static struct sock *mptcp_accept(struct sock *sk, i=
nt flags, int *err,
> 	if (!newsk)
> 		return NULL;
>
> -	subflow =3D mptcp_subflow_ctx(newsk);
> -	pr_debug("msk=3D%p, new subflow=3D%p, ", msk, subflow);
> +	pr_debug("msk=3D%p, subflow is mptcp=3D%d", msk, tcp_sk(newsk)->is_mptc=
p);
>
> -	if (subflow->mp_capable) {
> +	if (tcp_sk(newsk)->is_mptcp) {
> +		struct mptcp_subflow_context *subflow;
> 		struct sock *new_mptcp_sock;
> 		struct sock *ssk =3D newsk;
>
> +		subflow =3D mptcp_subflow_ctx(newsk);
> 		lock_sock(sk);
>
> 		local_bh_disable();
> @@ -295,8 +295,6 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
> 		bh_unlock_sock(new_mptcp_sock);
> 		local_bh_enable();
> 		release_sock(sk);
> -	} else {
> -		tcp_sk(newsk)->is_mptcp =3D 0;
> 	}
>
> 	return newsk;
> -- =

> 2.21.0

--
Mat Martineau
Intel
--===============0033683831199177001==--
