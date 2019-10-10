Content-Type: multipart/mixed; boundary="===============2912565160523185503=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fix warnings reported by checkpatch
Date: Thu, 10 Oct 2019 16:27:42 +0200
Message-ID: <20191010142745.6436-2-matthieu.baerts@tessares.net>
In-Reply-To: 20191010142745.6436-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2086

--===============2912565160523185503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

WARNING: 'thi' may be misspelled - perhaps 'the'?
#77: FILE: net/mptcp/ctrl.c:38:
+               /* users with CAP_NET_ADMIN or root (not and) can change thi

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: new sysctl to control the activation per NS"

 net/mptcp/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 33de3ced2ba7..6023c9f722ea 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -35,7 +35,7 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
 		.procname =3D "enabled",
 		.maxlen =3D sizeof(int),
 		.mode =3D 0644,
-		/* users with CAP_NET_ADMIN or root (not and) can change thi
+		/* users with CAP_NET_ADMIN or root (not and) can change this
 		 * value, same as other sysctl or the 'net' tree.
 		 */
 		.proc_handler =3D proc_dointvec,
-- =

2.20.1

--===============2912565160523185503==--
