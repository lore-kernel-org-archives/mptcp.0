Content-Type: multipart/mixed; boundary="===============4846234231615489023=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] mptcp: recvmsg refactor follow-up
Date: Thu, 17 Oct 2019 15:31:40 -0700
Message-ID: <alpine.OSX.2.21.1910171529130.17779@mjmartin-mac01.local>
In-Reply-To: cover.1571258477.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2232

--===============4846234231615489023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 17 Oct 2019, Paolo Abeni wrote:

> This series bring in a few fixes for the recent recevmsg refactor.
> The patch addressing the reported failures is 2/4, while 1/4 avoids anoth=
er
> issue currently observable with debug enabled (recvmsg() do busy loop on =
some
> corner cases).
> Patch 3/4 fixes another possible deadlock issue, currently not reported by
> the self-tests
> Finally patch 4/4 updates the MIB accounting to the new code.
> patches 1-3 should be squashed into "mptcp: Implement MPTCP receive path"=
, while
> patch 4 should be quashed into "mptcp: increment MIB counters in a few pl=
aces".
>
> Notes:
> - the last patch is a bit rough, at it abuses an existing MIB instead
> of defining a new one, if there is no agreement about that it can be drop=
ped.
> - regardless of that, "mptcp: increment MIB counters in a few places" will
> conflict on rebase, due to the changes introduced by the previous patches.
>
>
> Paolo Abeni (3):
>  mptcp: clear data_avail flag if rtx queue is empty
>  mptcp: relax map checking
>  mptcp: deal better with out-of-sequence mapping
>  mptcp: account unsupported DSS mapping
>
> net/mptcp/subflow.c | 63 +++++++++++++++++++++------------------------
> 1 file changed, 30 insertions(+), 33 deletions(-)
>

This looks good for merging, based on patch review and some testing.

I did see some KASAN problems (not associated with these patches, I =

think), and lots of flushing of duplicate recv data when testing with =

multipath-tcp.org v0.95. I'll look in to that separately, but they =

shouldn't delay these patches.


--
Mat Martineau
Intel
--===============4846234231615489023==--
