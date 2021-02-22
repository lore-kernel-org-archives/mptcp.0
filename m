Content-Type: multipart/mixed; boundary="===============1257324230285605347=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/3] mptcp: misc stuff
Date: Mon, 22 Feb 2021 18:07:15 +0100
Message-ID: <cover.1614013455.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7894

--===============1257324230285605347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A bunch of patches I kept sitting in my local three for a while
The first 2 add a few more MIBs counters, for client and error
detection's sake.
The last one cleans-up a bit msk->first usage.

Paolo Abeni (3):
  mptcp: add mib for token creation fallback
  mptcp: add active MPC mibs
  mptcp: remove unneeded check on first subflow

 net/mptcp/mib.c      | 3 +++
 net/mptcp/mib.h      | 3 +++
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.c | 8 ++++++--
 net/mptcp/subflow.c  | 4 ++++
 5 files changed, 17 insertions(+), 3 deletions(-)

-- =

2.26.2

--===============1257324230285605347==--
