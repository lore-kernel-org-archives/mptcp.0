Content-Type: multipart/mixed; boundary="===============4011944994368891320=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: selftests: exercise GSO,
 retransmission and reorder code path
Date: Tue, 21 May 2019 11:08:02 +0200
Message-ID: <20190521090802.ypbgcfyvd2izs6fe@breakpoint.cc>
In-Reply-To: cca394470989de199d076c6ea5667871f5e07b0d.1558427525.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1200

--===============4011944994368891320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> This introduces a few artifacts on the virtual network topology
> via the netem scheduler and disabling features on some veth, so
> that we exercise the MTCP stack more.

Hi Paolo

I would suggest to not do this unconditionally.

Perhaps we can make it so that the tests are run twice,
once as-is and once with tc+tso off?

This way we might still catch tso-related bugs, as feature path
is slightly different.

What do you think?

--===============4011944994368891320==--
