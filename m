Content-Type: multipart/mixed; boundary="===============4638679993490011726=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] .topmsg: mptcp: process MP_CAPABLE data option
Date: Thu, 12 Dec 2019 16:58:22 -0800
Message-ID: <20191213005822.29791-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191213005822.29791-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2919

--===============4638679993490011726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mention RFC 8684, minor spelling fixes and stuff.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/.topmsg b/.topmsg
index 405b188083ea..0f79c41044b2 100644
--- a/.topmsg
+++ b/.topmsg
@@ -1,12 +1,12 @@
 From: Christoph Paasch <cpaasch(a)apple.com>
-Subject: [PATCH] mptcp: process MP_CAPABLE data option.
+Subject: [PATCH] mptcp: process MP_CAPABLE data option
 =

-This patch implement the handling of MP_CAPABLE + data option, as
-per RFC 6824 bis - MPTCP v1.
+This patch implements the handling of MP_CAPABLE + data option, as per
+RFC 6824 bis / RFC 8684: MPTCP v1.
 =

 On the server side we can receive the remote key after that the connection
 is established. We need to explicitly track the 'missing remote key'
-status and avoid emtting mptcp ack till we get such info.
+status and avoid emitting a mptcp ack until we get such info.
 =

 When a late/retransmitted/OoO pkt carrying MP_CAPABLE[+data] option
 is received, we have to propagate the mptcp seq number info to
@@ -16,8 +16,8 @@ that in recvmsg(), where we own msk and subflow sock lock=
s.
 The above also means that an established mp_capable subflow - still
 waiting for the remote key - can be 'downgraded' to plain TCP.
 =

-Such change could potentially block forever reader waiting for new
-data - as they hook to msk, while later wake-up after the downgrade
+Such change could potentially block a reader waiting for new data
+forever - as they hook to msk, while later wake-up after the downgrade
 will be on subflow only.
 =

 The above issue is not handled here, we likely have to get rid of
-- =

2.24.1

--===============4638679993490011726==--
