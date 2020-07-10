Content-Type: multipart/mixed; boundary="===============3196687066353652957=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/9] mptcp: cope better with mp_join storm
Date: Fri, 10 Jul 2020 11:31:52 -0700
Message-ID: <alpine.OSX.2.23.453.2007101125230.34362@apander1-mobl.amr.corp.intel.com>
In-Reply-To: cover.1594401165.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4987

--===============3196687066353652957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 10 Jul 2020, Paolo Abeni wrote:

> This is a rebase of the RFC, dropping old 5/5 and including a few somewhat
> related bugfixes - all targeting net-next because the fixed commit is only
> there or the buggy behavior can be triggered only enabling non backup sub=
flows
>
> Paolo Abeni (9):
>  subflow: always init 'rel_write_seq'
>  mptcp: avoid data corruption on reinsert
>  mptcp: mark as fallback even early ones
>  mptcp: zero token hash at creation time.
>  mptcp: make msk established at remote key reception time
>  mptcp: cleanup subflow_finish_connect()
>  subflow: explicitly check for plain tcp rsk
>  subflow: use rsk_ops->send_reset()
>  subflow: introduce and use mptcp_can_accept_new_subflow()
>
> net/mptcp/options.c  |  4 +-
> net/mptcp/protocol.c | 20 +++++++---
> net/mptcp/protocol.h |  2 +
> net/mptcp/subflow.c  | 87 +++++++++++++++++++++++++-------------------
> net/mptcp/token.c    |  2 +-
> 5 files changed, 69 insertions(+), 46 deletions(-)
>
> -- =

> 2.26.2

Thanks Paolo, the changes look good. Should these go in mptcp_net-next for =

a testing pass before upstreaming?

--
Mat Martineau
Intel
--===============3196687066353652957==--
