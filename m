Content-Type: multipart/mixed; boundary="===============4560771171448644673=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 0/7] mptcp: implement retransmit infrastructure
Date: Wed, 18 Sep 2019 22:01:23 -0700
Message-ID: <alpine.OSX.2.21.1909182148300.40632@tvtrimel-mobl5.amr.corp.intel.com>
In-Reply-To: cover.1568206133.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1884

--===============4560771171448644673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 11 Sep 2019, Paolo Abeni wrote:

> The retransmission infrastructure is now functionally completed, and I do=
n't
> observe anymore memleak/socket reference leak.
>
> Still there are a few self-test failures I still have to investigate.
> I *think* we could merge this series even with such failure pending, and =
fix
> them later, _if_ there is agreement.

I sent one comment about locking in patch 7, but other than that I would =

agree that it's good to merge the series soon and continue fixing issues. =

I also see the self-test failures on my system.

There will be more work to do in terms of retransmit timing and how much =

data gets retransmitted when the timer expires. We don't want to reinject =

data on the same subflow when it hasn't been acked at the TCP level. And =

when we do reinject, how much of the MPTCP rtx queue do we send? I think =

the code that's in this patch set will make progress but could be slow - =

but that's ok for now.


Thanks,

Mat


>
> v1 -> v2
> - rebased on top of "mptcp: remove token_release"
> - handle unacked sequence update collision with a loop, as suggested by M=
at
>
> RFC v2 -> v1
> - update msk una_seq in tcp_incoming_options() and drop old patch 3/8
> - cleanup timer management
> - cleanup dfrag management
>
> Paolo Abeni (7):
>  mptcp: move before/after64 into the header file
>  mptcp: update per unacked sequence on pkt reception
>  mptcp: queue data for mptcp level retransmission
>  mptcp: introduce MPTCP retransmission timer
>  mptcp: implement memory accounting for mptcp rtx queue
>  mptcp: rework mptcp_sendmsg_frag to accept optional dfrag
>  mptcp: implement and use MPTCP-level retransmission
>
> net/mptcp/options.c  |  47 ++++-
> net/mptcp/protocol.c | 396 +++++++++++++++++++++++++++++++++++++++----
> net/mptcp/protocol.h |  41 +++++
> 3 files changed, 446 insertions(+), 38 deletions(-)
>
> -- =

> 2.21.0
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============4560771171448644673==--
