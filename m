Content-Type: multipart/mixed; boundary="===============1132959867954328490=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: fix compilation warning without IPV6
Date: Tue, 21 Jan 2020 15:16:48 -0800
Message-ID: <alpine.OSX.2.21.2001211516210.14256@mjmartin-mac01.local>
In-Reply-To: 20200121231415.3101697-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3467

--===============1132959867954328490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jan 2020, Matthieu Baerts wrote:

> Spot by Mat:
>
>    net/mptcp/protocol.c: In function =E2=80=98mptcp_copy_inaddrs=E2=80=99:
>    net/mptcp/protocol.c:672:21: warning: unused variable =E2=80=98msk6=E2=
=80=99 [-Wunused-variable]
>      672 |  struct ipv6_pinfo *msk6 =3D inet6_sk(msk);
>          |                     ^~~~
>    net/mptcp/protocol.c:671:27: warning: unused variable =E2=80=98ssk6=E2=
=80=99 [-Wunused-variable]
>      671 |  const struct ipv6_pinfo *ssk6 =3D inet6_sk(ssk);
>          |                           ^~~~
>
> v2:
> - reorder the code to avoid 2 #ifdef (Mat)
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
>
> Notes:
>    to be squashed in "mptcp: Create SUBFLOW socket for incoming connectio=
ns"
>
> net/mptcp/protocol.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 84799a5212a2..e08a25eabcd5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -217,17 +217,10 @@ static void mptcp_close(struct sock *sk, long timeo=
ut)
>
> static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
> {
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 	const struct ipv6_pinfo *ssk6 =3D inet6_sk(ssk);
> 	struct ipv6_pinfo *msk6 =3D inet6_sk(msk);
>
> -	inet_sk(msk)->inet_num =3D inet_sk(ssk)->inet_num;
> -	inet_sk(msk)->inet_dport =3D inet_sk(ssk)->inet_dport;
> -	inet_sk(msk)->inet_sport =3D inet_sk(ssk)->inet_sport;
> -	inet_sk(msk)->inet_daddr =3D inet_sk(ssk)->inet_daddr;
> -	inet_sk(msk)->inet_saddr =3D inet_sk(ssk)->inet_saddr;
> -	inet_sk(msk)->inet_rcv_saddr =3D inet_sk(ssk)->inet_rcv_saddr;
> -
> -#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 	msk->sk_v6_daddr =3D ssk->sk_v6_daddr;
> 	msk->sk_v6_rcv_saddr =3D ssk->sk_v6_rcv_saddr;
>
> @@ -236,6 +229,13 @@ static void mptcp_copy_inaddrs(struct sock *msk, con=
st struct sock *ssk)
> 		msk6->flow_label =3D ssk6->flow_label;
> 	}
> #endif
> +
> +	inet_sk(msk)->inet_num =3D inet_sk(ssk)->inet_num;
> +	inet_sk(msk)->inet_dport =3D inet_sk(ssk)->inet_dport;
> +	inet_sk(msk)->inet_sport =3D inet_sk(ssk)->inet_sport;
> +	inet_sk(msk)->inet_daddr =3D inet_sk(ssk)->inet_daddr;
> +	inet_sk(msk)->inet_saddr =3D inet_sk(ssk)->inet_saddr;
> +	inet_sk(msk)->inet_rcv_saddr =3D inet_sk(ssk)->inet_rcv_saddr;
> }
>
> static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
> -- =

> 2.24.0

v2 looks good, thanks Matthieu!

--
Mat Martineau
Intel

--===============1132959867954328490==--
