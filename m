Content-Type: multipart/mixed; boundary="===============4582166339131309211=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/4] Add REMOVE_ADDR support
Date: Wed, 22 Jul 2020 16:42:27 +0800
Message-ID: <cover.1595407078.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5169

--===============4582166339131309211==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add REMOVE_ADDR support.

Geliang Tang (4):
  mptcp: rename the existing ADD_ADDR related functions
  mptcp: add the RM_ADDR option writing
  mptcp: add the RM_ADDR option parsing
  mptcp: trigger the RM_ADDR signal

 net/mptcp/options.c    | 49 ++++++++++++++++++++++++++++++++------
 net/mptcp/pm.c         | 54 ++++++++++++++++++++++++++++++++++++------
 net/mptcp/pm_netlink.c | 52 +++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.c   |  9 +++++--
 net/mptcp/protocol.h   | 25 +++++++++++++++----
 net/mptcp/subflow.c    |  1 +
 6 files changed, 168 insertions(+), 22 deletions(-)

-- =

2.17.1

--===============4582166339131309211==--
