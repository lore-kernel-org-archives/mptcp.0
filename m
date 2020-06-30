Content-Type: multipart/mixed; boundary="===============5068179707947299151=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: init autotune state also in
 simultaneous connect case.
Date: Tue, 30 Jun 2020 12:54:42 +0200
Message-ID: <be692bedbab09f941b546cdf33e655ba8337e22b.camel@redhat.com>
In-Reply-To: 20200622135737.8217-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4862

--===============5068179707947299151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-22 at 15:57 +0200, Florian Westphal wrote:
> This is what Christoph suggested needs to be added to avoid
> div0 in case of simultaneous connect.
> =

> Squashto: mptcp: add receive buffer auto-tuning
> ---
>  net/mptcp/subflow.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 0f0fa1ba57a8..e1e19c76e267 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1120,6 +1120,7 @@ static void subflow_state_change(struct sock *sk)
>  =

>  	if (subflow_simultaneous_connect(sk)) {
>  		mptcp_do_fallback(sk);
> +		mptcp_rcv_space_init(mptcp_sk(parent), sk);
>  		pr_fallback(mptcp_sk(parent));
>  		subflow->conn_finished =3D 1;
>  		if (inet_sk_state_load(parent) =3D=3D TCP_SYN_SENT) {

LGTM, and I think Christoph already acked it.

Thanks Florian,

/P

--===============5068179707947299151==--
