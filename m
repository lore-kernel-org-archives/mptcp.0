Content-Type: multipart/mixed; boundary="===============6297680943809089062=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: fix option length of mp_capable syn/ack
Date: Sat, 30 Nov 2019 09:55:00 +0100
Message-ID: <312a6bb7-4ae4-7fb8-7d99-7765099bd5d6@tessares.net>
In-Reply-To: 600ab80529ae9abbc860e7bbf4a8e945cd130fd3.1575054127.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2711

--===============6297680943809089062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

Thank you for the patch!

On 29/11/2019 20:02, Davide Caratti wrote:

[...]

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 98eb0281d196..cee5c3968741 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -57,7 +57,7 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,

Here above, you also need to replace TCPOLEN_MPTCP_MPC_SYNACK by =

TCPOLEN_MPTCP_MPC_ACK:

=3D=3D=3D
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 98eb0281d196..9163fddf16b9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -25,7 +25,7 @@ void mptcp_parse_option(const unsigned char *ptr, int =

opsize,
          */
         case MPTCPOPT_MP_CAPABLE:
                 if (opsize !=3D TCPOLEN_MPTCP_MPC_SYN &&
-                   opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
+                   opsize !=3D TCPOLEN_MPTCP_MPC_ACK)
                         break;

                 mp_opt->version =3D *ptr++ & MPTCP_VERSION_MASK;
=3D=3D=3D

(or check that the size is not one of the three: I guess (but to be =

confirmed) that the compiler will remove one check if we compare exactly =

the same thing: opsize !=3D 12 && opsize !=3D 12 && opsize !=3D 20)

Otherwise you will never match the if-statement here below.

Note that this code is very similar to what is done in mptcp.org in =

mptcp_parse_option().

>   		mp_opt->sndr_key =3D get_unaligned_be64(ptr);
>   		ptr +=3D 8;
>   =

> -		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) {
> +		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK) {
>   			mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
>   			ptr +=3D 8;
>   			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu, rcvr=3D%llu",
> @@ -650,8 +650,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_ou=
t_options *opts)
>   				      MPTCP_CAP_HMAC_SHA1);
>   		put_unaligned_be64(opts->sndr_key, ptr);
>   		ptr +=3D 2;
> -		if ((OPTION_MPTCP_MPC_SYNACK |
> -		     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> +		if (OPTION_MPTCP_MPC_ACK & opts->suboptions) {
>   			put_unaligned_be64(opts->rcvr_key, ptr);
>   			ptr +=3D 2;
>   		}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index acad61c70de9..10347c9b4dff 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -34,7 +34,7 @@
>   =

>   /* MPTCP suboption lengths */
>   #define TCPOLEN_MPTCP_MPC_SYN		12
> -#define TCPOLEN_MPTCP_MPC_SYNACK	20
> +#define TCPOLEN_MPTCP_MPC_SYNACK	12

Should we remove it if we don't use it?
Or rename 'TCPOLEN_MPTCP_MPC_SYN' to 'TCPOLEN_MPTCP_MPC_SYN_AND_SYNACK'?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6297680943809089062==--
