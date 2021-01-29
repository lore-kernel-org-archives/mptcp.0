Content-Type: multipart/mixed; boundary="===============2485678251094431018=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/8] RM_ADDR: remove a list of addrs
Date: Fri, 29 Jan 2021 18:26:44 +0800
Message-ID: <cover.1611914854.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7523

--===============2485678251094431018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset added the removing a list of addresses support for
RM_ADDR. It addressed issue #140.

tag: export/20210129T064739

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/140

Geliang Tang (8):
  mptcp: remove multi addrs on outgoing path
  mptcp: remove multi addrs on incoming path
  mptcp: add removing multi addrs support in PM
  mptcp: add removing multi addrs support in netlink
  mptcp: implement mptcp_nl_remove_addrs_and_subflows
  mptcp: remove a list of addrs when flushing
  mptcp: update the netlink event for rm_addr
  selftests: mptcp: add testcases for removing addrs

 include/net/mptcp.h                           |   2 +-
 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/options.c                           |  53 +++--
 net/mptcp/pm.c                                |  26 +--
 net/mptcp/pm_netlink.c                        | 182 ++++++++++++++----
 net/mptcp/protocol.h                          |  23 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  23 +++
 7 files changed, 235 insertions(+), 75 deletions(-)

-- =

2.29.2

--===============2485678251094431018==--
