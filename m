Content-Type: multipart/mixed; boundary="===============6147810291768131861=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 05/12] mptcp: Render mptcp_sub_inherit_sockopts
 lockless
Date: Wed, 04 Apr 2018 21:29:29 +0200
Message-ID: <a676829c-4e27-c3e9-6ad6-9308cf742e5b@tessares.net>
In-Reply-To: 20180326073215.83607-6-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 508

--===============6147810291768131861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 26/03/2018 09:32, Christoph Paasch wrote:
> We are accessing the meta-socket's TOS field twice. It could change
> in-between as we do this in a lockless manner.

I hope this will not add more complexities in the code :)

Should we not clearly identify/mark all functions that are called with =

or without holding locks? Functions could be renamed maybe? I know, =

quite a big work :-)

Best regards,
Matt

> Thus, let's make sure we read it only once.
> =

> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> ---
>   net/mptcp/mptcp_ctrl.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
> index 29fe6485d69a..fb37053dd127 100644
> --- a/net/mptcp/mptcp_ctrl.c
> +++ b/net/mptcp/mptcp_ctrl.c
> @@ -945,11 +945,15 @@ static void mptcp_mpcb_inherit_sockopts(struct sock=
 *meta_sk, struct sock *maste
>   	inet_sk(master_sk)->recverr =3D 0;
>   }
>   =

> +/* Called without holding lock on meta_sk */
>   static void mptcp_sub_inherit_sockopts(const struct sock *meta_sk, stru=
ct sock *sub_sk)
>   {
> +	__u8 meta_tos;
> +
>   	/* IP_TOS also goes to the subflow. */
> -	if (inet_sk(sub_sk)->tos !=3D inet_sk(meta_sk)->tos) {
> -		inet_sk(sub_sk)->tos =3D inet_sk(meta_sk)->tos;
> +	meta_tos =3D READ_ONCE(inet_sk(meta_sk)->tos);
> +	if (inet_sk(sub_sk)->tos !=3D meta_tos) {
> +		inet_sk(sub_sk)->tos =3D meta_tos;
>   		sub_sk->sk_priority =3D meta_sk->sk_priority;
>   		sk_dst_reset(sub_sk);
>   	}
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

-- =



DISCLAIMER.
This email and any files transmitted with it are confidential =

and intended solely for the use of the individual or entity to whom they =

are addressed. If you have received this email in error please notify the =

system manager. This message contains confidential information and is =

intended only for the individual named. If you are not the named addressee =

you should not disseminate, distribute or copy this e-mail. Please notify =

the sender immediately by e-mail if you have received this e-mail by =

mistake and delete this e-mail from your system. If you are not the =

intended recipient you are notified that disclosing, copying, distributing =

or taking any action in reliance on the contents of this information is =

strictly prohibited.

--===============6147810291768131861==--
