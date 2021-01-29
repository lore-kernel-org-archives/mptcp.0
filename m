Content-Type: multipart/mixed; boundary="===============2145004535640374082=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 00/16] mptcp: ADD_ADDR enhancements
Date: Thu, 28 Jan 2021 17:10:59 -0800
Message-ID: <20210129011115.133953-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 7511

--===============2145004535640374082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series from the MPTCP tree contains enhancements and
associated tests for the ADD_ADDR ("add address") MPTCP option. This
option allows already-connected MPTCP peers to share additional IP
addresses with each other, which can then be used to create additional
subflows within those MPTCP connections.

Patches 1 & 2 remove duplicated data in the per-connection path manager
structure.

Patches 3-6 initiate additional subflows when an address is added using
the netlink path manager interface and improve ADD_ADDR signaling
reliability, subject to configured limits. Self tests are also updated.

Patches 7-15 add new support for optional port numbers in ADD_ADDR. This
includes creating an additional in-kernel TCP listening socket for the
requested port number, validating the port number when processing
incoming subflow connections, including the port number in netlink
interfaces, and adding some new MIBs. New self test cases are added for
subflows connecting with alternate port numbers.

Patch 16 refactors the self test script containing the ADD_ADDR test
cases, allowing developers to quickly run a subset of the tests.

Geliang Tang (16):
  mptcp: use WRITE_ONCE/READ_ONCE for the pernet *_max
  mptcp: drop *_max fields in mptcp_pm_data
  mptcp: create subflow or signal addr for newly added address
  mptcp: send ack for every add_addr
  selftests: mptcp: use minus values for removing address numbers
  selftests: mptcp: add testcases for newly added addresses
  mptcp: create the listening socket for new port
  mptcp: drop unused skb in subflow_token_join_request
  mptcp: add a new helper subflow_req_create_thmac
  mptcp: add port number check for MP_JOIN
  mptcp: enable use_port when invoke addresses_equal
  mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM netlink
  selftests: mptcp: add port argument for pm_nl_ctl
  mptcp: add the mibs for ADD_ADDR with port
  selftests: mptcp: add testcases for ADD_ADDR with port
  selftests: mptcp: add command line arguments for mptcp_join.sh

 net/mptcp/mib.c                               |    6 +
 net/mptcp/mib.h                               |    6 +
 net/mptcp/mptcp_diag.c                        |    6 +-
 net/mptcp/options.c                           |    4 +
 net/mptcp/pm.c                                |   12 +-
 net/mptcp/pm_netlink.c                        |  295 ++++-
 net/mptcp/protocol.c                          |    2 +-
 net/mptcp/protocol.h                          |   12 +-
 net/mptcp/subflow.c                           |   79 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 1095 +++++++++++------
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   24 +-
 11 files changed, 1084 insertions(+), 457 deletions(-)


base-commit: 32e31b78272ba0905c751a0f6ff6ab4c275a780e
-- =

2.30.0

--===============2145004535640374082==--
