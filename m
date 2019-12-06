Content-Type: multipart/mixed; boundary="===============4218117989828423259=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 9/9] don't flag parent socket as RCV_SHUTDOWN
 if one one subflow has closed
Date: Fri, 06 Dec 2019 16:57:46 +0100
Message-ID: <20191206155746.GZ795@breakpoint.cc>
In-Reply-To: a0204fbd-6678-c9ce-1273-9f6183892615@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2823

--===============4218117989828423259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> - 192c07c3fe9b: "squashed" patch 1/9 in "mptcp: Add handling of incoming
> MP_JOIN requests"
> - d6c1939a16c5..2cc726803b47: result
> - 0c24eaeadf60: "squashed" patch 2/9, part 1, in "mptcp: Add handling of
> incoming MP_JOIN requests"
> - f2a1eeb27eab: "squashed" patch 2/9, part 2, in "mptcp: Add handling of
> outgoing MP_JOIN requests"
> - 216b0b82f102: conflict in t/mptcp-introduce-MPTCP-retransmission-timer
> - e1012595cc3d: conflict in t/mptcp-add-and-use-mptcp-RTX-flag
> - 2cc726803b47..48f66afb6a81: result
> - the other patches have been added at the end. I had some conflicts with:
>  - "copy connection id from first subflow to mptcp socket"
>  - "make accept not allocate kernel socket struct"
>  - "subflow: place further subflows on new 'join_list'"
> =

> Tests on top of the commit introducing the kselftests are OK but not the =
one
> at the end of the series (export branch). Here is the trace (without
> CONFIG_KASAN nor PROVE_LOCKING)

I will have a look, thanks for reporting.

--===============4218117989828423259==--
