Content-Type: multipart/mixed; boundary="===============0915331803546709744=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix NULL ptr dereference on bad MPJ
Date: Thu, 26 Nov 2020 15:17:53 +0100
Message-ID: <03b2cfa3ac80d8fc18272edc6442a9ddf0b1e34e.1606400227.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6951

--===============0915331803546709744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If an msk listener receives an MPJ carrying an invalid token, it
will zero the request socket msk entry. That should later
cause fallback and subflow reset - as per RFC - at
subflow_syn_recv_sock() time due to failing hmac validation.

Since commit 4cf8b7e48a09 ("subflow: introduce and use
mptcp_can_accept_new_subflow()"), we unconditionally dereference
- in mptcp_can_accept_new_subflow - the subflow request msk
before performing hmac validation. In the above scenario we
hit a NULL ptr dereference.

Address the issue doing the hmac validation earlier.

Fixes: 4cf8b7e48a09 ("subflow: introduce and use mptcp_can_accept_new_subfl=
ow()")
Tested-by: Davide Caratti <dcaratti(a)redhat.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ac4a1fe3550b..953906e40742 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -543,9 +543,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			fallback =3D true;
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
-		if (!mp_opt.mp_join ||
-		    !mptcp_can_accept_new_subflow(subflow_req->msk) ||
-		    !subflow_hmac_valid(req, &mp_opt)) {
+		if (!mp_opt.mp_join || !subflow_hmac_valid(req, &mp_opt) ||
+		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 			fallback =3D true;
 		}
-- =

2.26.2

--===============0915331803546709744==--
