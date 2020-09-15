Content-Type: multipart/mixed; boundary="===============8821792365442811578=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/2] Squash-to: "mptcp: remove
 addr and subflow in PM netlink v9"
Date: Tue, 15 Sep 2020 15:36:34 +0800
Message-ID: <cover.1600154343.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5867

--===============8821792365442811578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2:
 - add mptcp_pm_remove_anno_addr and update logic in
 mptcp_nl_remove_subflow_and_signal_addr
 - call mptcp_pm_free_anno_list in mptcp_destroy and mptcp_sock_destruct
 - add mptcp_destroy_common helper

Geliang Tang (2):
  Squash-to: "mptcp: remove addr and subflow in PM netlink"
  mptcp: add mptcp_destroy_common helper

 net/mptcp/pm.c         |  1 +
 net/mptcp/pm_netlink.c | 94 ++++++++++++++++++++++++++++++++++++++----
 net/mptcp/protocol.c   | 12 ++++--
 net/mptcp/protocol.h   |  3 ++
 net/mptcp/subflow.c    |  4 +-
 5 files changed, 100 insertions(+), 14 deletions(-)

-- =

2.17.1

--===============8821792365442811578==--
