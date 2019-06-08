Content-Type: multipart/mixed; boundary="===============7044029698534504602=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] patch set: checkpatch.pl warnings/errors
Date: Sat, 08 Jun 2019 11:01:28 +0200
Message-ID: <20190608090128.tovjy2jp2isar6b5@breakpoint.cc>
In-Reply-To: 3500f3bf-303c-17e6-2dc0-48f18f93aa39@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1321

--===============7044029698534504602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> - line over 80 characters: do we have to be strict? Some lines are easy
> to cut, I can fix that. But what about some lines like:
> =

>     if (!((opt_rx->mptcp.flags & MPTCP_CAP_FLAG_MASK) =3D=3D
> MPTCP_CAP_HMAC_SHA1) ||

I would keep this as-is.

>     static inline struct socket *mptcp_subflow_tcp_socket(const struct
> subflow_context *subflow)

Can be done like this:

static inline struct socket *
mptcp_subflow_tcp_socket(const struct subflow_context *subflow)

> - Unnecessary parentheses around 'X': can we ignore them if the author
> kept them to improve readability / reduce ambiguity?
>
> - Comparison to NULL could be written "X": same here: ignore or fix?
> Maybe these ones make more sense for the maintainers to fix?

Both are in the eye of the beholder.
I tend to "fix" both, just to avoid the followup patches that will
be coming otherwise (just look for "checkpatch fixes" commits
in the kernel ...)

> - kselftests: do we have to keep the same style as the rest of the code?
> There are quite a few warnings there. Do we have to be strict? Maybe
> better to fix the most obvious ones not to distract reviewers with these
> details? I also guess we can accept longer lines in the bash scripts.

I've never bothered with checkpatch errors in the scripts.

> - what about the MAINTAINERS file? Can we delay this modification for lat=
er?

Yes, but I think it would make sense to add an MPTCP entry anyway, at
least once v1 for merging is sent.

There is a "get_maintainer" script that uses git history + the
MAINTAINERS file to suggest a list of persons and/or mailing lists
to CC to a patch.

> - header of the new files: what do we want to do with them? Do we need
> to update the info (description, copyright, etc.)? checkpatch complains
> about: "networking block comments don't use an empty /* line, use /*
> Comment...". Because we have:
> =

>     +/*
>     + * Multipath TCP

Hrhrhrhr...

I would change it to /* Multipath ...

I prefer the current style (which is what almost the entire kernel is
using...), but same as the 'Unnecessary parentheses' and 'Comparison to
NULL', better change it in the initial merge submission so we avoid the
unneeded 3rd party 'fix patches'.

> - not related to checkpatch but could we squash "tcp: Check for filled
> TCP option space before SACK" in "mptcp: Handle MP_CAPABLE options for
> outgoing" or move it just after the patch adding this MP_CAPABLE support?

I would keep it separate to ease review, and i think its in the right
place too.

--===============7044029698534504602==--
