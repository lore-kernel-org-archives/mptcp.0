Content-Type: multipart/mixed; boundary="===============0884127053078729121=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/2] Interim Path Manager
Date: Tue, 17 Sep 2019 11:37:48 -0700
Message-ID: <20190917183750.2693-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1866

--===============0884127053078729121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Patchset includes the interim path manager plus sysctl setting of
the announce address and binding local address when creating subflows.
I also split the path manager into a seperate file.

v2:
  rename to 'basic' path manager
  remove pm_init definition
    =

Peter Krystad (2):
  mptcp: Minor changes to path manager interface
  mptcp: Implement basic path manager

 net/mptcp/Makefile   |   2 +-
 net/mptcp/basic.c    | 247 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/pm.c       |  38 +++++--
 net/mptcp/protocol.c |   2 +-
 net/mptcp/protocol.h |  14 ++-
 5 files changed, 290 insertions(+), 13 deletions(-)
 create mode 100644 net/mptcp/basic.c

-- =

2.17.2


--===============0884127053078729121==--
