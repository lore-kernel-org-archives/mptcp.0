Content-Type: multipart/mixed; boundary="===============4047109345722105970=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: allow picking
 different xmit subflows"
Date: Fri, 11 Sep 2020 16:12:45 -0700
Message-ID: <alpine.OSX.2.23.453.2009111606100.23153@izaratax-mobl.amr.corp.intel.com>
In-Reply-To: 5acfec9d91567f606a7cad10ef425a80d9cb05bc.1599846013.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5826

--===============4047109345722105970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 11 Sep 2020, Paolo Abeni wrote:

> unbreak 32 bits build avoid unsing '/' on 64 bits arguments.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e5ef7227c914..d848ade67a4a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1082,8 +1082,9 @@ static struct sock *mptcp_subflow_get_send(struct m=
ptcp_sock *msk,
> 	struct subflow_send_info send_info[2];
> 	struct mptcp_subflow_context *subflow;
> 	int i, nr_active =3D 0;
> -	int64_t ratio, pace;
> 	struct sock *ssk;
> +	u64 ratio;
> +	u32 pace;
>
> 	sock_owned_by_me((struct sock *)msk);
>
> @@ -1128,7 +1129,8 @@ static struct sock *mptcp_subflow_get_send(struct m=
ptcp_sock *msk,
> 		if (!pace)
> 			continue;
>
> -		ratio =3D (int64_t)READ_ONCE(ssk->sk_wmem_queued) << 32 / pace;
> +		ratio =3D div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
> +				pace);

For some reason this thread did not get to my inbox...

I think you've also fixed an issue with operator precedence in this =

expression. Given the div_u64 version of the expression, you intended =

this:

ratio =3D ((int64_t)READ_ONCE(ssk->sk_wmem_queued) << 32) / pace;

to give you more significant digits than you would have had without =

shifting sk_wmem_queued. However, the old expression in the v1 patch is =

equivalent to:

ratio =3D (int64_t)READ_ONCE(ssk->sk_wmem_queued) << (32 / pace);

So, assuming pace is usually large this was shifting by 0 and selecting =

the subflow with lower sk_wmem_queued. Behavior may be changed now =

(hopefully for the better!), not sure if you want to do more testing =

before posting v2.


--
Mat Martineau
Intel
--===============4047109345722105970==--
