Content-Type: multipart/mixed; boundary="===============3538231505382081850=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net 0/5] mptcp: mix fixes
Date: Fri, 05 Feb 2021 17:35:01 -0800
Message-ID: <e098f272-c1e2-3824-2d8c-27b21765cfde@linux.intel.com>
In-Reply-To: cover.1612543972.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7659

--===============3538231505382081850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Feb 2021, Paolo Abeni wrote:

> This includes new versions of 2 already posted patches (1/5 && 2/5)
> a rewrite of an already posted RFC patch (3/5) and a new fix.
>
> Patch 1 should address issues/126
> Patch 2 should address issues/130 && 125
> Patch 3 is mostly a clean-up, possibly could land to net-next
> Patch 4 should fix issue 146
> Finally patch 5 allow mptcp_connect to dump more info when errors happen
>
> Paolo Abeni (5):
>  mptcp: fix spurious retransmissions
>  mptcp: init mptcp request socket earlier
>  mptcp: better msk receive window updates
>  mptcp: add a missing retransmission timer scheduling
>  selftests: mptcp: dump more info on errors
>
> net/mptcp/options.c                           | 10 ++---
> net/mptcp/protocol.c                          | 44 +++++++++++--------
> net/mptcp/protocol.h                          | 14 ++----
> net/mptcp/subflow.c                           | 40 +++++++----------
> .../selftests/net/mptcp/mptcp_connect.sh      | 11 +++--
> 5 files changed, 58 insertions(+), 61 deletions(-)
>
> -- =

> 2.26.2

Given the discussion on IRC, does it make sense to apply these on the =

export branch and continue testing? Not sure if the error Matthieu =

encountered was introduced here or possibly an existing issue.

From a code review perspective, I don't have any changes to suggest.

--
Mat Martineau
Intel
--===============3538231505382081850==--
