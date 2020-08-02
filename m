Content-Type: multipart/mixed; boundary="===============6299299072470384468=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 00/12] mptcp: multiple xmit substreams support
Date: Sun, 02 Aug 2020 02:14:31 +0200
Message-ID: <20200802001431.GJ29169@breakpoint.cc>
In-Reply-To: cover.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5429

--===============6299299072470384468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> The pain point is the in-window check:
> =

> on the receiver side msk rcv window is set at tcp_space(msk) - which shou=
ld be
> a quite rough over-estimante of a more correct value.

Can you elaborate?

> on the sender side no limit is imposed on the xmitted sequence number, ex=
cept
> the one given by the sndbuf. The msk sndbuf is autotuned to the subflows
> largest sndbuf size.

Yes, I agree the amount of data we can send should be capped by the last
dss-rwin we saw as well, which we don't track ATM.

But this can be added later, sndbuf alone is good enough for the
initial step i think.
--===============6299299072470384468==--
