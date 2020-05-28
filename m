Content-Type: multipart/mixed; boundary="===============8808796094386900552=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/2] mptcp: add receive buffer auto-tuning
Date: Thu, 28 May 2020 15:02:37 +0200
Message-ID: <20200528130239.16498-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4522

--===============8808796094386900552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds rx buffer auto-tuning.
In oder to better test this, the first patch extends the test script
so it can be run multiple times with identical file size.

Furthermore, the new '-t' switch allows to always to tcp fallback and
even tcp <-> tcp tests.  The expectation here is that there is little
to no difference in transfer time between mptcp <-> mptcp and tcp-only
transfers.

Without the second patch, there is significant difference when delay
is used due to the missing rx autotuning.

The new mptcp tune function is very similar to the tcp one, except that
it uses the highest rtt of any subflow.

Its also needed to adjust the subflow rcvbuf: if that is not done, there
are backlog drops at the subflow level (default rx buffer on my vm is
only 128kb, which doesn't provide enough 'cushion' until work queue can
drain the ssk queue).



--===============8808796094386900552==--
