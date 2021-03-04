Content-Type: multipart/mixed; boundary="===============7911846673216702014=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 0/9] mptcp: Fixes for v5.12
Date: Thu, 04 Mar 2021 13:32:07 -0800
Message-ID: <20210304213216.205472-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 8028

--===============7911846673216702014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches from the MPTCP tree fix a few multipath TCP issues:


Patches 1 and 5 clear some stale pointers when subflows close.

Patches 2, 4, and 9 plug some memory leaks.

Patch 3 fixes a memory accounting error identified by syzkaller.

Patches 6 and 7 fix a race condition that slowed data transmission.

Patch 8 adds missing wakeups when write buffer space is freed.


Florian Westphal (4):
  mptcp: reset last_snd on subflow close
  mptcp: put subflow sock on connect error
  mptcp: dispose initial struct socket when its subflow is closed
  mptcp: reset 'first' and ack_hint on subflow close

Geliang Tang (1):
  mptcp: free resources when the port number is mismatched

Paolo Abeni (4):
  mptcp: fix memory accounting on allocation error
  mptcp: factor out __mptcp_retrans helper()
  mptcp: fix race in release_cb
  mptcp: fix missing wakeup

 net/mptcp/protocol.c | 165 +++++++++++++++++++++++++++----------------
 net/mptcp/subflow.c  |  14 ++--
 2 files changed, 112 insertions(+), 67 deletions(-)


base-commit: a9ecb0cbf03746b17a7c13bd8e3464e6789f73e8
-- =

2.30.1

--===============7911846673216702014==--
