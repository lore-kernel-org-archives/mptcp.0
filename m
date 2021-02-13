Content-Type: multipart/mixed; boundary="===============5756884171521662783=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/8] mptcp: Add genl events for
 connection info
Date: Fri, 12 Feb 2021 20:46:30 -0800
Message-ID: <b89e4be5-cac-af1d-1c1-2ce92fa55e10@linux.intel.com>
In-Reply-To: 20210213000001.379332-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7796

--===============5756884171521662783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Feb 2021, Mat Martineau wrote:

> This series from the MPTCP tree adds genl multicast events that are
> important for implementing a userspace path manager. In MPTCP, a path
> manager is responsible for adding or removing additional subflows on
> each MPTCP connection. The in-kernel path manager (already part of the
> kernel) is a better fit for many server use cases, but the additional
> flexibility of userspace path managers is often useful for client
> devices.
>
> Patches 1, 2, 4, 5, and 6 do some refactoring to streamline the netlink
> event implementation in the final patch.
>
> Patch 3 improves the timeliness of subflow destruction to ensure the
> 'subflow closed' event will be sent soon enough.
>
> Patch 7 allows use of the GENL_UNS_ADMIN_PERM flag on genl mcast groups
> to mandate CAP_NET_ADMIN, which is important to protect token information
> in the MPTCP events. This is a genetlink change.
>

David -

I noticed that this series got merged to net-next and shows as "Accepted" =

in patchwork:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/=
?id=3D0a2f6b32cc45e3918321779fe90c28f1ed27d2af


However, somehow patch 7 did not propagate through the netdev list and =

does not show up in patchwork or the merged series!


It did get archived on the cc'd mptcp list =

(https://lists.01.org/hyperkitty/list/mptcp(a)lists.01.org/message/KBY6UIFE=
TMXCAOHNXQLYWKXNCHSGJ7AG/) =

so hopefully your directly-addressed copy also arrived. The missing patch =

won't cause a build error but does lead to a token getting exposed to =

non-admin users.

I will re-send it with an extra note about where it originally fit in.


Mat


> Patch 8 adds the MPTCP netlink events.
>
>
> Florian Westphal (8):
>  mptcp: move pm netlink work into pm_netlink
>  mptcp: split __mptcp_close_ssk helper
>  mptcp: schedule worker when subflow is closed
>  mptcp: move subflow close loop after sk close check
>  mptcp: pass subflow socket to a few helpers
>  mptcp: avoid lock_fast usage in accept path
>  genetlink: add CAP_NET_ADMIN test for multicast bind
>  mptcp: add netlink event support
>
> include/net/genetlink.h    |   1 +
> include/uapi/linux/mptcp.h |  74 +++++++++
> net/mptcp/options.c        |   2 +-
> net/mptcp/pm.c             |  24 ++-
> net/mptcp/pm_netlink.c     | 310 ++++++++++++++++++++++++++++++++++++-
> net/mptcp/protocol.c       |  72 ++++-----
> net/mptcp/protocol.h       |  20 +--
> net/mptcp/subflow.c        |  27 +++-
> net/netlink/genetlink.c    |  32 ++++
> 9 files changed, 491 insertions(+), 71 deletions(-)
>
>
> base-commit: c3ff3b02e99c691197a05556ef45f5c3dd2ed3d6
> -- =

> 2.30.1
>
>

--
Mat Martineau
Intel
--===============5756884171521662783==--
