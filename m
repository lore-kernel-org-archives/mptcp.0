Content-Type: multipart/mixed; boundary="===============0084825542677013654=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] Squash to "mptcp: drop *_max fields in
 mptcp_pm_data"
Date: Sat, 16 Jan 2021 12:36:53 +0100
Message-ID: <20210116113653.3918024-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7409

--===============0084825542677013654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to export these functions that are also used in mptcp_diag.c
which can be part of a separated module.

We can then avoid these errors:

  ERROR: modpost: "mptcp_pm_get_add_addr_accept_max" [net/mptcp/mptcp_diag.=
ko] undefined!
  ERROR: modpost: "mptcp_pm_get_add_addr_signal_max" [net/mptcp/mptcp_diag.=
ko] undefined!
  ERROR: modpost: "mptcp_pm_get_subflows_max" [net/mptcp/mptcp_diag.ko] und=
efined!

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: drop *_max fields in mptcp_pm_data"

 net/mptcp/pm_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 42dd576c7b55..d03311b95112 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -203,6 +203,7 @@ unsigned int mptcp_pm_get_add_addr_signal_max(struct mp=
tcp_sock *msk)
 	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->add_addr_signal_max);
 }
+EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
 =

 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk)
 {
@@ -211,6 +212,7 @@ unsigned int mptcp_pm_get_add_addr_accept_max(struct mp=
tcp_sock *msk)
 	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->add_addr_accept_max);
 }
+EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
 =

 unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk)
 {
@@ -219,6 +221,7 @@ unsigned int mptcp_pm_get_local_addr_max(struct mptcp_s=
ock *msk)
 	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->local_addr_max);
 }
+EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
 =

 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk)
 {
-- =

2.29.2

--===============0084825542677013654==--
