Content-Type: multipart/mixed; boundary="===============8771208761842513428=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 net-next 0/5] mptcp: re-enable sndbuf autotune
Date: Wed, 20 Jan 2021 15:39:09 +0100
Message-ID: <cover.1611153172.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7447

--===============8771208761842513428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The sendbuffer autotuning was unintentionally disabled as a
side effect of the recent workqueue removal refactor. These
patches re-enable id, with some extra care: with autotuning
enable/large send buffer we need a more accurate packet
scheduler to be able to use efficiently the available
subflow bandwidth, especially when the subflows have
different capacities.

The first patch cleans-up subflow socket handling, making
the actual re-enable (patch 2) simpler.

Patches 3 and 4 improve the packet scheduler, to better cope
with non trivial scenarios and large send buffer. =


Finally patch 5 adds and uses some infrastructure to avoid
the workqueue usage for the packet scheduler operations introduced
by the previous patches.

v1 -> v2:
 - fix a UaF in patch 5, see patch changelog for the details =


Paolo Abeni (5):
  mptcp: always graft subflow socket to parent
  mptcp: re-enable sndbuf autotune
  mptcp: do not queue excessive data on subflows
  mptcp: schedule work for better snd subflow selection
  mptcp: implement delegated actions

 net/mptcp/protocol.c | 179 ++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h |  87 +++++++++++++++++++++
 net/mptcp/subflow.c  |  55 ++++++++++++-
 3 files changed, 258 insertions(+), 63 deletions(-)

-- =

2.26.2

--===============8771208761842513428==--
