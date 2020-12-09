Content-Type: multipart/mixed; boundary="===============3313361396624340693=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 00/11] mptcp: Add port parameter to ADD_ADDR
 option
Date: Wed, 09 Dec 2020 15:51:17 -0800
Message-ID: <20201209235128.175473-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 7107

--===============3313361396624340693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ADD_ADDR MPTCP option is used to announce available IP addresses
that a peer may connect to when adding more TCP subflows to an existing
MPTCP connection. There is an optional port number field in that
ADD_ADDR header, and this patch set adds capability for that port number
to be sent and received.

Patches 1, 2, and 4 refactor existing ADD_ADDR code to simplify implementat=
ion
of port number support.

Patches 3 and 5 are the main functional changes, for sending and
receiving the port number in the MPTCP ADD_ADDR option.

Patch 6 sends the ADD_ADDR option with port number on a bare TCP ACK,
since the extra length of the option may run in to cases where
sufficient TCP option space is not available on a data packet.

Patch 7 plumbs in port number support for the in-kernel MPTCP path
manager.

Patches 8-11 add some optional debug output and a little more cleanup
refactoring.


Geliang Tang (11):
  mptcp: unify ADD_ADDR and echo suboptions writing
  mptcp: unify ADD_ADDR and ADD_ADDR6 suboptions writing
  mptcp: add port support for ADD_ADDR suboption writing
  mptcp: use adding up size to get ADD_ADDR length
  mptcp: add the outgoing ADD_ADDR port support
  mptcp: send out dedicated packet for ADD_ADDR using port
  mptcp: add port parameter for mptcp_pm_announce_addr
  mptcp: print out port and ahmac when receiving ADD_ADDR
  mptcp: drop rm_addr_signal flag
  mptcp: rename add_addr_signal and mptcp_add_addr_status
  mptcp: use the variable sk instead of open-coding

 include/net/mptcp.h    |   1 +
 net/mptcp/options.c    | 103 ++++++++++++++++++++++++++---------------
 net/mptcp/pm.c         |  40 +++++++++++-----
 net/mptcp/pm_netlink.c |  31 +++++++++----
 net/mptcp/protocol.h   |  50 ++++++++++++--------
 5 files changed, 146 insertions(+), 79 deletions(-)

-- =

2.29.2

--===============3313361396624340693==--
