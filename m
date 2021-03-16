Content-Type: multipart/mixed; boundary="===============2975851045440069617=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/3] send ack for rm_addr and
 cleanups
Date: Tue, 16 Mar 2021 13:27:08 +0800
Message-ID: <cover.1615871979.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 8162

--===============2975851045440069617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2:
 - add patch 1 and patch 3.
 - update the debug output in patch 2.
 - tag: export/20210315T064655.

Note:
 - Please insert this patchset between the commit "mptcp: move to next
addr when subflow creation fail" and the commit "selftests: mptcp: signal
addresses testcases" when merging it.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/173

Geliang Tang (3):
  mptcp: drop useless addr_signal clear
  mptcp: send ack for rm_addr
  mptcp: rename mptcp_pm_nl_add_addr_send_ack

 net/mptcp/pm.c         |  1 +
 net/mptcp/pm_netlink.c | 24 ++++++++----------------
 net/mptcp/protocol.h   |  1 +
 3 files changed, 10 insertions(+), 16 deletions(-)

-- =

2.30.2

--===============2975851045440069617==--
