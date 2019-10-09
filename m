Content-Type: multipart/mixed; boundary="===============7181247166294245132=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH kbuild] mptcp: mptcp_timer_pending() can be static
Date: Wed, 09 Oct 2019 11:07:36 -0700
Message-ID: <alpine.OSX.2.21.1910091107170.48251@crpeter1-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2081

--===============7181247166294245132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Fixes: b364de141961 ("mptcp: introduce MPTCP retransmission timer")
Signed-off-by: kbuild test robot <lkp(a)intel.com>
---

Forwarding additional kbuild suggestions that were not sent to everyone.

  protocol.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b94769f95ccc7..acbcb150cdb5a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -29,7 +29,7 @@ static void mptcp_set_timeout(const struct sock *sk, cons=
t struct sock *ssk)
  	mptcp_sk(sk)->timer_ival =3D  tout > 0 ? tout : TCP_RTO_MIN;
  }

-bool mptcp_timer_pending(struct sock *sk)
+static bool mptcp_timer_pending(struct sock *sk)
  {
  	return timer_pending(&inet_csk(sk)->icsk_retransmit_timer);
  }
--===============7181247166294245132==--
