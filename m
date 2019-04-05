Content-Type: multipart/mixed; boundary="===============8027865643027573953=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/4] mptcp: refactor xmit path
Date: Fri, 05 Apr 2019 16:46:35 +0200
Message-ID: <cover.1554473233.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1045

--===============8027865643027573953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series refactor the mptcp xmit path trying to make sendmsg behavior
more consistent, memory efficent and improve its performances.

This is an early draft, only lightly tested, shared early to avoid codying
conflict in this area.

The code is also available here:

https://github.com/pabeni/mptcp/tree/mptcp-proposal-devel

Paolo Abeni (4):
  mptcp: use sk_page_frag() in sendmsg
  mptcp: sendmsg() do spool all the provided data
  mptcp: move tpext data_len initialization at option creation time
  mptcp: allow collapsing consecutive sendpages on the same substream

 include/net/mptcp.h  |   1 +
 net/mptcp/options.c  |   2 +
 net/mptcp/protocol.c | 160 ++++++++++++++++++++++++++-----------------
 3 files changed, 100 insertions(+), 63 deletions(-)

-- =

2.20.1


--===============8027865643027573953==--
