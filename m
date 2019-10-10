Content-Type: multipart/mixed; boundary="===============7820504248526419355=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Checkpatch: questions about what is reported
Date: Thu, 10 Oct 2019 16:31:18 +0200
Message-ID: <747f60a9-c4ac-e1a5-a5b2-e20fe7546fef@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2090

--===============7820504248526419355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This afternoon, I was quickly looking at the output of checkpatch.pl for
each patch. Everything was already OK for the 10 first ones we sent to
netdev.

I just sent the different patches I have, nothing important but we have
to fix these warnings one day I guess :)

I also have a few questions:

mptcp: Implement MPTCP receive path
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I got these warnings:

  WARNING: line over 80 characters
  #134: FILE: net/mptcp/options.c:104:
  +               mp_opt->data_fin =3D (mp_opt->dss_flags &
  MPTCP_DSS_DATA_FIN) !=3D 0;

  WARNING: memory barrier without comment
  #470: FILE: net/mptcp/protocol.c:327:
  +       smp_mb__before_atomic();

  WARNING: memory barrier without comment
  #472: FILE: net/mptcp/protocol.c:329:
  +       smp_mb__after_atomic();

  WARNING: memory barrier without comment
  #530: FILE: net/mptcp/protocol.c:397:
  +               smp_mb__before_atomic();

  WARNING: memory barrier without comment
  #532: FILE: net/mptcp/protocol.c:399:
  +               smp_mb__after_atomic();

  WARNING: memory barrier without comment
  #838: FILE: net/mptcp/subflow.c:172:
  +               smp_mb__before_atomic();

  WARNING: memory barrier without comment
  #840: FILE: net/mptcp/subflow.c:174:
  +               smp_mb__after_atomic();


For the first one, maybe clearer to keep the line like this even if it
has more than 80 chars (81 in fact...).

But for the rest, should we add comments?


General
=3D=3D=3D=3D=3D=3D=3D

At some points, we will have to fix this one:

  WARNING: added, moved or deleted file(s), does MAINTAINERS need
  updating?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7820504248526419355==--
