Content-Type: multipart/mixed; boundary="===============9036852877942981356=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/3] mptcp: improve mptcp release callback
Date: Tue, 09 Feb 2021 12:42:38 +0100
Message-ID: <cover.1612869198.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7701

--===============9036852877942981356==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current callback implementation is probe to some race
and still use some suboptimal code from older times.

This series clean-up the code a bit, fixing the race
and hopefully simplifying future wider usage of delegated
actions

Paolo Abeni (3):
  mptcp: factor out __mptcp_retrans helper()
  mptcp: fix race in release_cb
  mptcp: clean-up the rtx path.

 net/mptcp/protocol.c | 164 +++++++++++++++++++++----------------------
 net/mptcp/protocol.h |   1 +
 2 files changed, 81 insertions(+), 84 deletions(-)

-- =

2.26.2

--===============9036852877942981356==--
