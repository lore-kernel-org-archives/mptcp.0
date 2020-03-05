Content-Type: multipart/mixed; boundary="===============2924865282767105195=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 3/3] testing only: allow IP_OPTIONS set/getsockopt
Date: Thu, 05 Mar 2020 14:22:31 +0100
Message-ID: <20200305132231.22953-4-fw@strlen.de>
In-Reply-To: 20200305132231.22953-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3872

--===============2924865282767105195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is WRONG, it will not work with ipv6.
We would need to add approprate callbacks for this.
---
 net/mptcp/protocol.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0e3654ce77a0..1d12b6baffdc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -982,6 +982,24 @@ static void mptcp_destroy(struct sock *sk)
 		__skb_ext_put(msk->cached_ext);
 }
 =

+static bool is_ok(int level, int optname)
+{
+	if (level =3D=3D SOL_IP && optname =3D=3D IP_OPTIONS)
+		return true;
+
+	return false;
+}
+
+static int do_mptcp_setsockopt(struct sock *sk, int level, int optname,
+			       char __user *optval, unsigned int optlen)
+{
+	if (is_ok(level, optname))
+		return ip_setsockopt(sk, level, optname,
+				     optval, optlen);
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
 			    char __user *optval, unsigned int optlen)
 {
@@ -1004,6 +1022,16 @@ static int mptcp_setsockopt(struct sock *sk, int lev=
el, int optname,
 =

 	release_sock(sk);
 =

+	return do_mptcp_setsockopt(sk, level, optname, optval, optlen);
+}
+
+static int do_mptcp_getsockopt(struct sock *sk, int level, int optname,
+			       char __user *optval, int __user *option)
+{
+	if (is_ok(level, optname))
+		return ip_getsockopt(sk, level, optname,
+				     optval, option);
+
 	return -EOPNOTSUPP;
 }
 =

@@ -1029,7 +1057,7 @@ static int mptcp_getsockopt(struct sock *sk, int leve=
l, int optname,
 =

 	release_sock(sk);
 =

-	return -EOPNOTSUPP;
+	return do_mptcp_getsockopt(sk, level, optname, optval, option);
 }
 =

 #define MPTCP_DEFERRED_ALL TCPF_DELACK_TIMER_DEFERRED
-- =

2.24.1

--===============2924865282767105195==--
