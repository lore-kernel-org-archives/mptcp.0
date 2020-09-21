Content-Type: multipart/mixed; boundary="===============5937655363467832789=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 0/3] mptcp: retransmit ADD_ADDR
 when timeout and others
Date: Mon, 21 Sep 2020 15:30:35 +0800
Message-ID: <cover.1600672866.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5952

--===============5937655363467832789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v5:
 - add mptcp_pm_should_add_signal check
 - use list_splice_init instead of list_move
 - reuse lookup_anno_list_by_saddr
 - reuse mptcp_pm_del_add_timer
 - add new helper sk_stop_timer_sync
 - this patchset deponds on my two little squash-to patches:
  Squash-to: "mptcp: remove addr and subflow in PM netlink" Part 3
  Squash-to: "mptcp: implement mptcp_pm_remove_subflow" Part 2

v4:
 - split in two patches
 - fix racy issues

v3:
 - use timer.
 - drop bh_lock_sock.
 - move __sock_put at the end of mptcp_pm_add_timer.

v2:
 - Use delayed_work instead of timer.
 - This patch depends on my another patch named 'Squash-to: "mptcp: remove
   addr and subflow in PM netlink"'.

Geliang Tang (3):
  mptcp: add struct mptcp_pm_add_entry
  mptcp: add sk_stop_timer_sync helper
  mptcp: retransmit ADD_ADDR when timeout

 include/net/sock.h     |   2 +
 net/core/sock.c        |   7 +++
 net/mptcp/options.c    |   1 +
 net/mptcp/pm_netlink.c | 128 +++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h   |   3 +
 5 files changed, 117 insertions(+), 24 deletions(-)

-- =

2.17.1

--===============5937655363467832789==--
