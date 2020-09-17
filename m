Content-Type: multipart/mixed; boundary="===============8577986679228485391=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v4 mptcp-next 0/2] mptcp: retransmit ADD_ADDR
 when timeout
Date: Thu, 17 Sep 2020 20:45:13 +0800
Message-ID: <cover.1600346411.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5913

--===============8577986679228485391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

Geliang Tang (2):
  mptcp: add struct mptcp_pm_add_entry
  mptcp: retransmit ADD_ADDR when timeout

 net/mptcp/options.c    |   1 +
 net/mptcp/pm_netlink.c | 119 ++++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h   |   2 +
 3 files changed, 108 insertions(+), 14 deletions(-)

-- =

2.17.1

--===============8577986679228485391==--
