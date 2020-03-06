Content-Type: multipart/mixed; boundary="===============8606160274871906651=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/2] mptcp: simplify mptcp_accept()
Date: Fri, 06 Mar 2020 17:45:31 +0100
Message-ID: <cover.1583511159.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3889

--===============8606160274871906651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

this is a rebase on top of net-next, with hopefully
more correct error handling - catches mptcp_token_new_accept()
errors and fallback to TCP freeing the newly create msk.

Additionally add a follow-up patch dropping unneeded
subflow->conn checks.

Idea is to send this upstream after that -net is merged back
into -net-next, to deal with conflicts in
mptcp_established_options_dss() due to 2398e3991bda ("mptcp: =

always include dack if possible.")

Paolo Abeni (2):
  mptcp: create msk early
  mptcp: drop unneeded checks

 net/mptcp/options.c  |  2 +-
 net/mptcp/protocol.c | 83 ++++++++++++++++++++++++--------------------
 net/mptcp/protocol.h |  4 +--
 net/mptcp/subflow.c  | 50 ++++++++++++++------------
 net/mptcp/token.c    | 31 ++---------------
 5 files changed, 78 insertions(+), 92 deletions(-)

-- =

2.21.1

--===============8606160274871906651==--
