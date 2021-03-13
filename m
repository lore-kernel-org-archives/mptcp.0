Content-Type: multipart/mixed; boundary="===============5562136707128438371=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 00/11] mptcp: Include multiple address ids in
 RM_ADDR
Date: Fri, 12 Mar 2021 17:16:10 -0800
Message-ID: <20210313011621.211661-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 8131

--===============5562136707128438371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here's a patch series from the MPTCP tree that extends the capabilities
of the MPTCP RM_ADDR header.

MPTCP peers can exchange information about their IP addresses that are
available for additional MPTCP subflows. IP addresses are advertised
with an ADD_ADDR header type, and those advertisements are revoked with
the RM_ADDR header type. RFC 8684 allows the RM_ADDR header to include
more than one address ID, so multiple advertisements can be revoked in a
single header. Previous kernel versions have only used RM_ADDR with a
single address ID, so multiple removals required multiple packets.

Patches 1-4 plumb address id list structures around the MPTCP code,
where before only a single address ID was passed.

Patches 5-8 make use of the address lists at the path manager layer that
tracks available addresses for both peers.

Patches 9-11 update the selftests to cover the new use of RM_ADDR with
multiple address IDs.


Geliang Tang (11):
  mptcp: add rm_list in mptcp_out_options
  mptcp: add rm_list_tx in mptcp_pm_data
  mptcp: add rm_list in mptcp_options_received
  mptcp: add rm_list_rx in mptcp_pm_data
  mptcp: remove multi addresses in PM
  mptcp: remove multi subflows in PM
  mptcp: remove multi addresses and subflows in PM
  mptcp: remove a list of addrs when flushing
  selftests: mptcp: add invert argument for chk_rm_nr
  selftests: mptcp: set addr id for removing testcases
  selftests: mptcp: add testcases for removing addrs

 include/net/mptcp.h                           |   9 +-
 net/mptcp/options.c                           |  47 ++++--
 net/mptcp/pm.c                                |  39 +++--
 net/mptcp/pm_netlink.c                        | 139 +++++++++++++-----
 net/mptcp/protocol.h                          |  27 +++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  82 ++++++++---
 6 files changed, 250 insertions(+), 93 deletions(-)


base-commit: 26d2e0426aacaf4c128dc57111f0d460ab20e8b5
-- =

2.30.2

--===============5562136707128438371==--
