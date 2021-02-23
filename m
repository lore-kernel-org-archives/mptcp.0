Content-Type: multipart/mixed; boundary="===============7304965332572236842=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 2/3] mptcp: skip closing the
 initial subsocket
Date: Tue, 23 Feb 2021 16:26:13 +0800
Message-ID: <25ac6aa2d37f0a06f0c6df69419bfe707bf90fc5.1614068181.git.geliangtang@gmail.com>
In-Reply-To: bcd8d6edb080aa0b88a151548df30ae36cc6460f.1614068181.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7917

--===============7304965332572236842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the removing address id is 0, skip invoking mptcp_close_ssk to close
the initial subsocket.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 85417b0e73fe..b5cee3c66e5c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -631,7 +631,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp=
_sock *msk,
 				 type =3D=3D RM_ADDR ? "address" : "subflow", i, rm_list.ids[i]);
 			spin_unlock_bh(&msk->pm.lock);
 			mptcp_subflow_shutdown(sk, ssk, how);
-			mptcp_close_ssk(sk, ssk, subflow);
+			if (rm_list.ids[i])
+				mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 =

 			if (type =3D=3D RM_ADDR) {
-- =

2.29.2

--===============7304965332572236842==--
