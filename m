Content-Type: multipart/mixed; boundary="===============0803504390274080303=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 0/3] mptcp: netlink event fixes
Date: Tue, 02 Feb 2021 18:47:51 +0100
Message-ID: <20210202174754.6861-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 7594

--===============0803504390274080303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While testing upcoming mptcp reset option support i found a few
issues with netlink events.

1. When remote side is closing, the subflow close event will
be delayed until after the mptcp socket has shut down.

Schedule the worker to do a cleanup scan to avoid this.

2. When the mptcp socket is closing we can avoid sending
   individual 'subflow is closing' events; entire connection
   is going down so might as well wait for the normal mptcp-level
   close event.

3. Move the subflow close loop after dead check.
   This is not a fix, it would be fine to leave things as-is
   if you prefer -- its just that the extra conn_list walk
   can be avoided if the msk is already dead.

Florian Westphal (3):
  mptcp: schedule worker when subflow is closed
  mptcp: skip MPTCP_EVENT_SUB_CLOSED event when mptcp socket isn't
    established
  mptcp: move subflow close loop after sk close check

 net/mptcp/protocol.c | 9 +++++----
 net/mptcp/subflow.c  | 7 +++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

-- =

2.26.2

--===============0803504390274080303==--
