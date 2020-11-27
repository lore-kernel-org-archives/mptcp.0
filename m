Content-Type: multipart/mixed; boundary="===============3130095681947092250=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/6] mptcp: avoid workqueue usage for data
Date: Fri, 27 Nov 2020 11:10:21 +0100
Message-ID: <cover.1606413118.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6959

--===============3130095681947092250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current locking schema used to protect the MPTCP data-path
requires the usage of the MPTCP workqueue to process the incoming
data, depending on trylock result.

The above poses scalability limits and introduces random delays
in MPTCP-level acks.

With this series we use a single spinlock to protect the MPTCP
data-path, removing the need for workqueue and delayed ack usage.

This additionally reduces the number of atomic operations required
per packet and cleans-up considerably the poll/wake-up code.

Paolo Abeni (6):
  mptcp: open code mptcp variant for lock_sock
  mptcp: implement wmem reservation
  mptcp: protect the rx path with the msk socket spinlock
  mptcp: allocate TX skbs in msk context
  mptcp: avoid a few atomic ops in the rx path
  mptcp: use mptcp release_cb for delayed tasks

 include/net/sock.h     |   1 +
 net/core/sock.c        |   2 +-
 net/mptcp/mptcp_diag.c |   2 +-
 net/mptcp/options.c    |  47 +--
 net/mptcp/protocol.c   | 733 ++++++++++++++++++++++++++++++-----------
 net/mptcp/protocol.h   |  34 +-
 net/mptcp/subflow.c    |  14 +-
 7 files changed, 598 insertions(+), 235 deletions(-)

-- =

2.26.2

--===============3130095681947092250==--
