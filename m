Content-Type: multipart/mixed; boundary="===============2408206530126473947=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 0/2] Squash-to: "mptcp: remove
 addr and subflow in PM netlink v9"
Date: Tue, 15 Sep 2020 19:59:57 +0800
Message-ID: <cover.1600170870.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5879

--===============2408206530126473947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v3:
 - use "goto next" in mptcp_nl_remove_subflow_and_signal_addr
 - update mptcp_destroy_common

v2:
 - add mptcp_pm_remove_anno_addr and update logic in
 mptcp_nl_remove_subflow_and_signal_addr
 - call mptcp_pm_free_anno_list in mptcp_destroy and mptcp_sock_destruct
 - add mptcp_destroy_common helper

Geliang Tang (2):
  Squash-to: "mptcp: remove addr and subflow in PM netlink"
  mptcp: add mptcp_destroy_common helper

 net/mptcp/pm.c         |  1 +
 net/mptcp/pm_netlink.c | 91 +++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.c   | 10 ++++-
 net/mptcp/protocol.h   |  3 ++
 net/mptcp/subflow.c    |  3 +-
 5 files changed, 98 insertions(+), 10 deletions(-)

-- =

2.17.1

--===============2408206530126473947==--
