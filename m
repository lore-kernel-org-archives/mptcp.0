Content-Type: multipart/mixed; boundary="===============2792178954385517265=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 0/2] remove id 0 address
Date: Mon, 22 Feb 2021 12:05:59 +0800
Message-ID: <cover.1613966113.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7881

--===============2792178954385517265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I used this patch to test:

---

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7a5e347a42a3..822281bb3c5f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1235,6 +1235,8 @@ static void mptcp_pm_remove_addrs_and_subflows(struct=
 mptcp_sock *msk,
                }
        }
 =

+       alist.ids[alist.nr++] =3D 0;
+
        if (alist.nr) {
                spin_lock_bh(&msk->pm.lock);
                mptcp_pm_remove_addr(msk, alist);

---

apply: tag: export/20210218T061505
       move to next addr and testcases
       move to next addr when timeout

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/140

Geliang Tang (2):
  mptcp: unify RM_ADDR and RM_SUBFLOW receiving
  mptcp: remove id 0 address

 net/mptcp/pm_netlink.c | 97 ++++++++++++++++++++----------------------
 net/mptcp/protocol.c   |  2 +-
 net/mptcp/protocol.h   |  1 +
 3 files changed, 47 insertions(+), 53 deletions(-)

-- =

2.29.2

--===============2792178954385517265==--
