Content-Type: multipart/mixed; boundary="===============3826309718285559917=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] patch set: checkpatch.pl warnings/errors
Date: Sat, 08 Jun 2019 09:08:33 +0200
Message-ID: <3500f3bf-303c-17e6-2dc0-48f18f93aa39@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1320

--===============3826309718285559917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Yesterday I was quickly looking at the checkpatch warnings/errors as we
said that we should look at them before any submission.

Some are easy to fix and have to be fixed at some points, e.g. mix of
tabs/spaces, where the '*' is set, 'const' missing, etc. I already
started to fix some of them.

Some warnings can be ignored, e.g. we add an entry in an "old" file like
in.h and we keep the same style as the previous lines.

But for the rest, I have a few questions:

- line over 80 characters: do we have to be strict? Some lines are easy
to cut, I can fix that. But what about some lines like:

    if (!((opt_rx->mptcp.flags & MPTCP_CAP_FLAG_MASK) =3D=3D
MPTCP_CAP_HMAC_SHA1) ||

    static inline struct socket *mptcp_subflow_tcp_socket(const struct
subflow_context *subflow)

- Unnecessary parentheses around 'X': can we ignore them if the author
kept them to improve readability / reduce ambiguity?

- Comparison to NULL could be written "X": same here: ignore or fix?
Maybe these ones make more sense for the maintainers to fix?

- kselftests: do we have to keep the same style as the rest of the code?
There are quite a few warnings there. Do we have to be strict? Maybe
better to fix the most obvious ones not to distract reviewers with these
details? I also guess we can accept longer lines in the bash scripts.

- what about the MAINTAINERS file? Can we delay this modification for later?

- header of the new files: what do we want to do with them? Do we need
to update the info (description, copyright, etc.)? checkpatch complains
about: "networking block comments don't use an empty /* line, use /*
Comment...". Because we have:

    +/*
    + * Multipath TCP

- not related to checkpatch but could we squash "tcp: Check for filled
TCP option space before SACK" in "mptcp: Handle MP_CAPABLE options for
outgoing" or move it just after the patch adding this MP_CAPABLE support?


I don't know what the net-next maintainers/devs find important? I know
that the "reversed Xmas tree variable declaration" is important but not
sure about the others. Any feedback welcome :-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3826309718285559917==--
