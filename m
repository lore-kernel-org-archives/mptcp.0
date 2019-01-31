Content-Type: multipart/mixed; boundary="===============3017978950670800055=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 31st of January 2019
Date: Thu, 31 Jan 2019 19:19:18 +0100
Message-ID: <20190131181918.ozgepblvdhdz353v@breakpoint.cc>
In-Reply-To: fbf0f5b0-fc0c-a524-62f0-94158281b28d@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 984

--===============3017978950670800055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:

Thanks for the summary.

[..]

> Mat and Peter's new patch-set:
>     - Florian mentioned that it could be nice to add a kselftest. We
> need to check how other network protocols are doing their kselftests.

Ok, I'll handle this, no problem.

> Florian. We report this discussion to next week. Here are the questions
> to discuss:
>     - focus on the first patch-set and try to upstream this base?

Is that t/upstream / mmartineau-init-mptcp-v5?
If so, +1 from me.

Only question from my side:

>     - testing? (packetdrill?)

I think the initial submission should come with a simple
self-test, i.e. {client,server}.c + a shell script to glue those
together.  Just to exercise most basic mptcp code paths.

They can be extended (like add/remove subflows) when those features
are added.

Getting mptcp packetdrill support would be great of course,
but I think its something that should be focused on later on
to handle/test/validate wire-protocol.

>     - We propose to have the next one on Thursday, the 7th of February.

Good, I should be able to attend again (I'm barely functional due some
virus).

--===============3017978950670800055==--
