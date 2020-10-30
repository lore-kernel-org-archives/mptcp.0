Content-Type: multipart/mixed; boundary="===============6543605760889899842=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: change
 add_addr_signal type"
Date: Fri, 30 Oct 2020 11:00:55 +0800
Message-ID: <2e843951407af41605d55c56e4b55009b873e154.1604025904.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6482

--===============6543605760889899842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new helper mptcp_pm_should_add_signal_echo.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 v2:
 - make it as a squash-to patch.
 - change 'Subject' from 'mptcp: add mptcp_pm_should_add_signal_echo helper'
   to 'Squash to "mptcp: change add_addr_signal type"'

This patch will conflict with 'mptcp: send out dedicated ADD_ADDR packet':

"""
<<<<<<< HEAD
static inline bool mptcp_pm_should_add_signal_echo(struct mptcp_sock *msk)
{
        return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO=
);
=3D=3D=3D=3D=3D=3D=3D
static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *msk)
{
        return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6=
);
>>>>>>> 20761fc28b53... mptcp: send out dedicated ADD_ADDR packet
}
"""

Please resolve the conflict like this:

"""
static inline bool mptcp_pm_should_add_signal_echo(struct mptcp_sock *msk)
{
        return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO=
);
}

static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *msk)
{       =

        return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6=
);
}
"""
---
 net/mptcp/pm.c       | 2 +-
 net/mptcp/protocol.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index bc6619670d37..c2c12f02a263 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -186,7 +186,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, u=
nsigned int remaining,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 =

-	*echo =3D READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO);
+	*echo =3D mptcp_pm_should_add_signal_echo(msk);
 =

 	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo))
 		goto out_unlock;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 977e74dc45eb..77eae8addc91 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -524,6 +524,11 @@ static inline bool mptcp_pm_should_add_signal(struct m=
ptcp_sock *msk)
 	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
 }
 =

+static inline bool mptcp_pm_should_add_signal_echo(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO);
+}
+
 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.rm_addr_signal);
-- =

2.26.2

--===============6543605760889899842==--
