Content-Type: multipart/mixed; boundary="===============7164965586753744338=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: ADD_ADDRs with echo bit are smaller
Date: Sat, 03 Oct 2020 17:36:56 +0200
Message-ID: <20201003153656.1224144-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 6178

--===============7164965586753744338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The MPTCP ADD_ADDR suboption with echo-flag=3D1 has no HMAC, the size is
smaller than the one initially sent without echo-flag=3D1. We then need to
use the correct size everywhere when we need this echo bit.

Before this patch, the wrong size was reserved but the correct amount of
bytes were written (and read): the remaining bytes contained garbage.

Fixes: 6a6c05a8b016 ("mptcp: send out ADD_ADDR with echo flag")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/95
Reported-and-tested-by: Davide Caratti <dcaratti(a)redhat.com>
Acked-by: Geliang Tang <geliangtang(a)gmail.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/pm.c       | 5 +++--
 net/mptcp/protocol.h | 7 ++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 411fd4a41796..03794f89efeb 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -587,7 +587,7 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk,
 	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
 		return false;
 =

-	len =3D mptcp_add_addr_len(saddr.family);
+	len =3D mptcp_add_addr_len(saddr.family, echo);
 	if (remaining < len)
 		return false;
 =

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 7e81f53d1e5d..e19e1525ecbb 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -183,11 +183,12 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 =

-	if (remaining < mptcp_add_addr_len(msk->pm.local.family))
+	*echo =3D READ_ONCE(msk->pm.add_addr_echo);
+
+	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo))
 		goto out_unlock;
 =

 	*saddr =3D msk->pm.local;
-	*echo =3D READ_ONCE(msk->pm.add_addr_echo);
 	WRITE_ONCE(msk->pm.add_addr_signal, false);
 	ret =3D true;
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cfe52aeb2b8..6eef4db9ee5c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -464,11 +464,12 @@ static inline bool mptcp_pm_should_rm_signal(struct m=
ptcp_sock *msk)
 	return READ_ONCE(msk->pm.rm_addr_signal);
 }
 =

-static inline unsigned int mptcp_add_addr_len(int family)
+static inline unsigned int mptcp_add_addr_len(int family, bool echo)
 {
 	if (family =3D=3D AF_INET)
-		return TCPOLEN_MPTCP_ADD_ADDR;
-	return TCPOLEN_MPTCP_ADD_ADDR6;
+		return echo ? TCPOLEN_MPTCP_ADD_ADDR_BASE
+			    : TCPOLEN_MPTCP_ADD_ADDR;
+	return echo ? TCPOLEN_MPTCP_ADD_ADDR6_BASE : TCPOLEN_MPTCP_ADD_ADDR6;
 }
 =

 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
-- =

2.27.0

--===============7164965586753744338==--
