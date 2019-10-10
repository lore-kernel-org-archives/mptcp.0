Content-Type: multipart/mixed; boundary="===============8344113742006453441=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Checkpatch: questions about what is reported
Date: Thu, 10 Oct 2019 17:32:50 +0200
Message-ID: <6d0595dd1ef35a73a2017dd92549dee2c61b4e4c.camel@redhat.com>
In-Reply-To: 747f60a9-c4ac-e1a5-a5b2-e20fe7546fef@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2092

--===============8344113742006453441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2019-10-10 at 16:31 +0200, Matthieu Baerts wrote:
> This afternoon, I was quickly looking at the output of checkpatch.pl for
> each patch. Everything was already OK for the 10 first ones we sent to
> netdev.
> =

> I just sent the different patches I have, nothing important but we have
> to fix these warnings one day I guess :)

Thank you!

> I also have a few questions:
> =

> mptcp: Implement MPTCP receive path
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> I got these warnings:
> =

>   WARNING: line over 80 characters
>   #134: FILE: net/mptcp/options.c:104:
>   +               mp_opt->data_fin =3D (mp_opt->dss_flags &
>   MPTCP_DSS_DATA_FIN) !=3D 0;
> =

>   WARNING: memory barrier without comment
>   #470: FILE: net/mptcp/protocol.c:327:
>   +       smp_mb__before_atomic();

[...]

> For the first one, maybe clearer to keep the line like this even if it
> has more than 80 chars (81 in fact...).

Agreed.

> But for the rest, should we add comments?

I think a pair of comments there is welcome, alike:

"""
/* paired with {read,write} memory barrier in <>.
 * It's necessary as the subflows set msk data ready
 * without any global lock
 */
"""

> General
> =3D=3D=3D=3D=3D=3D=3D
> =

> At some points, we will have to fix this one:
> =

>   WARNING: added, moved or deleted file(s), does MAINTAINERS need
>   updating?

Indeed ;) Possibly with an additional patch in the next chunk ?

/P

--===============8344113742006453441==--
