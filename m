Content-Type: multipart/mixed; boundary="===============8222159156857297359=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix compilation warning
Date: Fri, 17 Jan 2020 17:56:31 +0100
Message-ID: <20200117165631.1329562-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3398

--===============8222159156857297359==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After having applied 77c6b6aec34b (mptcp: handle ipv4-mapped ipv6 address.),
we have this warning:

  net/ipv6/tcp_ipv6.c: In function =E2=80=98tcp_v6_syn_recv_sock=E2=80=99:
  net/ipv6/tcp_ipv6.c:1211:29: warning: passing argument 1 of =E2=80=98mptc=
p_handle_ipv6_mapped=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier fr=
om pointer target type [-Wdiscarded-qualifiers]
   1211 |    mptcp_handle_ipv6_mapped(sk, true);
        |                             ^~
  In file included from ./include/net/tcp.h:42,
                   from net/ipv6/tcp_ipv6.c:44:
  ./include/net/mptcp.h:201:44: note: expected =E2=80=98struct sock *=E2=80=
=99 but argument is of type =E2=80=98const struct sock *=E2=80=99
    201 | void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped);
        |                               ~~~~~~~~~~~~~^~

Simply fixed by passing some arguments to 'const'.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: Handle MP_CAPABLE options for outgoing connec=
tions"

 include/net/mptcp.h | 2 +-
 net/mptcp/subflow.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index eabc57c3fde4..d9214f4387c3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -162,7 +162,7 @@ static inline bool mptcp_skb_can_collapse(const struct =
sk_buff *to,
 =

 #endif /* CONFIG_MPTCP */
 =

-void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped);
+void mptcp_handle_ipv6_mapped(const struct sock *sk, bool mapped);
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int mptcpv6_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1eff992a43dc..2525da9d28c9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -165,7 +165,7 @@ static int subflow_v6_conn_request(struct sock *sk, str=
uct sk_buff *skb)
 #endif
 =

 static struct inet_connection_sock_af_ops *
-subflow_default_af_ops(struct sock *sk)
+subflow_default_af_ops(const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (sk->sk_family =3D=3D AF_INET6)
@@ -174,7 +174,7 @@ subflow_default_af_ops(struct sock *sk)
 	return &subflow_specific;
 }
 =

-void mptcp_handle_ipv6_mapped(struct sock *sk, bool mapped)
+void mptcp_handle_ipv6_mapped(const struct sock *sk, bool mapped)
 {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
-- =

2.24.0

--===============8222159156857297359==--
