Content-Type: multipart/mixed; boundary="===============8878912918061489571=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 2/2] mptcp: remove id 0 address
Date: Mon, 22 Feb 2021 12:06:01 +0800
Message-ID: <dbb2a7fe32a3fececf541f42162bbb059c8c6e2f.1613966113.git.geliangtang@gmail.com>
In-Reply-To: 30508a3e36eb9a249dd3ec4ea8bbd603a2982d5c.1613966113.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7883

--===============8878912918061489571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the removing address id is 0, invoke __mptcp_wr_shutdown to shutdown
the initial subflow.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 8 ++++++--
 net/mptcp/protocol.c   | 2 +-
 net/mptcp/protocol.h   | 1 +
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d5cdfc18b40a..7a5e347a42a3 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -634,8 +634,12 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptc=
p_sock *msk,
 			pr_debug(" -> %s rm_list_ids[%d]=3D%u",
 				 type =3D=3D RM_ADDR ? "address" : "subflow", i, rm_list.ids[i]);
 			spin_unlock_bh(&msk->pm.lock);
-			mptcp_subflow_shutdown(sk, ssk, how);
-			mptcp_close_ssk(sk, ssk, subflow);
+			if (rm_list.ids[i]) {
+				mptcp_subflow_shutdown(sk, ssk, how);
+				mptcp_close_ssk(sk, ssk, subflow);
+			} else {
+				__mptcp_wr_shutdown(sk);
+			}
 			spin_lock_bh(&msk->pm.lock);
 =

 			if (type =3D=3D RM_ADDR) {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b4eac26256f..ec808187fa0e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2518,7 +2518,7 @@ static void __mptcp_check_send_data_fin(struct sock *=
sk)
 	}
 }
 =

-static void __mptcp_wr_shutdown(struct sock *sk)
+void __mptcp_wr_shutdown(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6af3e259fa05..e63ba987ab78 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -538,6 +538,7 @@ void __init mptcp_subflow_init(void);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow);
+void __mptcp_wr_shutdown(struct sock *sk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
-- =

2.29.2

--===============8878912918061489571==--
