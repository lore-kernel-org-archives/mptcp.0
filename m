Content-Type: multipart/mixed; boundary="===============3618145090233446313=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/2] mptcp: dummy instance hack
Date: Mon, 11 Jan 2021 23:43:24 +0100
Message-ID: <cover.1610404441.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7312

--===============3618145090233446313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series showcase the dummy napi instance hinted in the
sndbuf autotune series.

Only lightly tested, posted here mainly to check if this
approach could be accepted upstream.

Among other hackish thing, patch 1 adds some napi instances
to the init netns loopback device.

Side note: this apparently fixes for good the not too stable
simult_flows self-tests

Paolo Abeni (2):
  mptcp: implement deferred action infrastructure
  mptcp: leverage the deferred actions for packet scheduling

 net/mptcp/protocol.c | 110 +++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  52 ++++++++++++++++++++
 net/mptcp/subflow.c  |   2 +
 3 files changed, 160 insertions(+), 4 deletions(-)

-- =

2.26.2

--===============3618145090233446313==--
