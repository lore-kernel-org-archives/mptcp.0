Content-Type: multipart/mixed; boundary="===============0518966205494776181=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/5] mptcp: re-enable sndbuf autotune
Date: Wed, 20 Jan 2021 11:40:35 +0100
Message-ID: <cover.1610991949.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7434

--===============0518966205494776181==
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

Paolo Abeni (5):
  mptcp: always graft subflow socket to parent
  mptcp: re-enable sndbuf autotune
  mptcp: do not queue excessive data on subflows
  mptcp: schedule work for better snd subflow selection
  mptcp: implement delegated actions

 net/mptcp/protocol.c | 176 ++++++++++++++++++++++++++++---------------
 net/mptcp/protocol.h |  72 ++++++++++++++++++
 net/mptcp/subflow.c  |  49 +++++++++++-
 3 files changed, 234 insertions(+), 63 deletions(-)

-- =

2.26.2

--===============0518966205494776181==--
