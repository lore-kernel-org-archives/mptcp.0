Content-Type: multipart/mixed; boundary="===============1205452923891087084=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 0/5] mptcp: netlink event support
Date: Tue, 26 Jan 2021 09:01:33 -0800
Message-ID: <5cedb15c-d3f0-be9d-b821-de9c79411f9@linux.intel.com>
In-Reply-To: 20210120154337.27997-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7492

--===============1205452923891087084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 20 Jan 2021, Florian Westphal wrote:

> This is round 2 of the netlink event series.
> No changes here except in patch 4 (minor checkpatch format nit)
> and patch 5.
>
> Changes since v1:
> - add missing export of ssk->sk_err.
>  This is now done for subflow related events (Mathieu)
> - fix a few indendations (Mathieu)
> - Update uapi comments (Mathieu)
> - fix checkpatch complaints
> - fix REM/LOC_ID, its NLA_U8 (Mat, Mathieu)
>
> Florian Westphal (5):
>  mptcp: split __mptcp_close_ssk helper
>  mptcp: pass subflow socket to a few helpers
>  mptcp: avoid lock_fast usage in accept path
>  genetlink: add CAP_NET_ADMIN test for multicast bind
>  mptcp: add netlink event support
>
> include/net/genetlink.h    |   1 +
> include/uapi/linux/mptcp.h |  73 ++++++++++
> net/mptcp/options.c        |   2 +-
> net/mptcp/pm.c             |  24 +++-
> net/mptcp/pm_netlink.c     | 265 ++++++++++++++++++++++++++++++++++++-
> net/mptcp/protocol.c       |  30 +++--
> net/mptcp/protocol.h       |  14 +-
> net/mptcp/subflow.c        |   2 +-
> net/netlink/genetlink.c    |  32 +++++
> 9 files changed, 418 insertions(+), 25 deletions(-)
>
> -- =

> 2.26.2

Just clarifying tags after my reply to the patch 5 thread, Matthieu please =

tag patches 1, 2, 3, and 5 with:

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>


(patch 4 tag is different, in a separate email)

--
Mat Martineau
Intel
--===============1205452923891087084==--
