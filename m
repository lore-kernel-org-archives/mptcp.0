Content-Type: multipart/mixed; boundary="===============8439524403670265338=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/2] mptcp: parse and emit MP_CAPABLE option
 according to v1 spec.
Date: Sat, 30 Nov 2019 09:46:53 +0100
Message-ID: <3226339a-e80d-2773-b5ff-c07f8d9c2f25@tessares.net>
In-Reply-To: cca37990d2ee8aff73340cc96ec02b17f459c786.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2710

--===============8439524403670265338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

I prepared this email yesterday but it seems I put my laptop to sleep =

too quickly :)

On 29/11/2019 15:44, Davide Caratti wrote:
> hello Matthieu, thanks a lot for looking at this!

That's the least I can do :-)

> On Fri, 2019-11-29 at 14:33 +0100, Matthieu Baerts wrote:

[...]

>> May you send a "proper patch"? If there is no objection (and an
>> additional review?), I can apply it.
> =

> I'm doubtful of what should we do with the first hunk, i.e.

Sorry, I misunderstood this. I guess here the code below is valid if you =

simply replace TCPOLEN_MPTCP_MPC_SYNACK by TCPOLEN_MPTCP_MPC_ACK.

And I see it is what you propose below.

When we parse the SYN. we should parse the sender key (first line) and =

in the 3rd ACK both key (the if-statement).

> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -57,16 +57,8 @@ void mptcp_parse_option(const unsigned char *ptr, int
> opsize,
>                  mp_opt->sndr_key =3D get_unaligned_be64(ptr);
>                  ptr +=3D 8;
>   =

> -               if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) {
> -                       mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
> -                       ptr +=3D 8;
> -                       pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu,
> rcvr=3D%llu",
> -                                mp_opt->flags, mp_opt->sndr_key,
> -                                mp_opt->rcvr_key);
> -               } else {
> -                       pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu",
> -                                mp_opt->flags, mp_opt->sndr_key);
> -               }
> +               pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu",
> +                        mp_opt->flags, mp_opt->sndr_key);
>                  break;
>   =

>          /* MPTCPOPT_MP_JOIN
> =

> here the kernel stores in mp_opt->rcvr_key the value received on the
> "longer" mp_capable option (that is, the 3rd packet in the 3-way
> handshake). I don't really get what the server should do with the echoed
> key received by the client, and a grep over the code didn't help:
I think you need it to send a MPTCP Fast Close which is not implemented =

yet. I don't think we really need it somewhere else. Could it be used =

with ADD_ADDR in MPTCPv1? I would need to re-read this.

> $ grep -r rcvr_key net/* include/*

We can see who has a SSD with NVME and can use "grep" instead of "git =

grep" or others :-=C3=BE

> net/mptcp/options.c:            opts->rcvr_key =3D subflow->remote_key;
> net/mptcp/options.c:            opts->rcvr_key =3D subflow_req->remote_ke=
y;
> net/mptcp/options.c:                    put_unaligned_be64(opts->rcvr_key=
, ptr);
> include/linux/tcp.h:            u64     rcvr_key;
> include/net/mptcp.h:    u64 rcvr_key;
> =

> I take as a friday activity (when packetdrill will be in a decent
> shape... so, not not this friday :) ) to understand what happens to a
> mptcp-net-next server when the client echoes back a wrong key.
> To be as much conservative as possible (and preserve the debug printout),
> we could just replace the above hunk with the following one:
> =

> --- >8 ---
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -57,7 +57,7 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
>                  mp_opt->sndr_key =3D get_unaligned_be64(ptr);
>                  ptr +=3D 8;
>   =

> -               if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) {
> +               if (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK) {
>                          mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
>                          ptr +=3D 8;
>                          pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu, rc=
vr=3D%llu",
> --- >8 ---
> =

> that will also create less troubles to Christian when he rebases his v1
> mp_capable patch on top of this.
> =

> WDYT?

Indeed, it seems to be the good fix to do: we should replace the two =

TCPOLEN_MPTCP_MPC_SYNACK by TCPOLEN_MPTCP_MPC_ACK in mptcp_parse_option().

Thank you for looking at that!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8439524403670265338==--
