Content-Type: multipart/mixed; boundary="===============7032309184571746540=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/5] mptcp: cope better with mp_join storm
Date: Tue, 30 Jun 2020 13:12:03 +0200
Message-ID: <cover.1593515429.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4863

--===============7032309184571746540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series it amied at fixing:

https://github.com/multipath-tcp/mptcp_net-next/issues/33

patch 3/5 do the main work, while patch 4 and 5 should
reduce the server load avoid creating unneeded children.

Patch 1 and 2 are somewhat related cleanup.

Patch 2 && 5 are likely the most controversial. Any
feedback more than welcome!

Paolo Abeni (5):
  mptcp: cleanup subflow_finish_connect()
  subflow: explicitly check for plain tcp rsk
  subflow: use rsk_ops->send_reset()
  subflow: introduce and use mptcp_can_accept_new_subflow()
  subflow: do not create child subflow for fallback MP_JOIN

 net/mptcp/subflow.c | 76 +++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 34 deletions(-)

-- =

2.26.2

--===============7032309184571746540==--
