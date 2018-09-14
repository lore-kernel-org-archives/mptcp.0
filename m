Content-Type: multipart/mixed; boundary="===============8661217815699351621=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 17/20] mptcp: Close remaining subflows when falling
 back in mptcp_verif_dss_csum
Date: Fri, 14 Sep 2018 10:25:21 -0700
Message-ID: <20180914172524.67961-20-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 745

--===============8661217815699351621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit b079a187260f ("mptcp: Remove cnt_subflows") subflows can
actually be in non-fully established and we will still send an MP_FAIL.

Thus, there can be multiple subflows and we need to make sure that the
other ones are getting closed in that case.

Otherwise, we will hit the case where we have a TCP-subflow hanging
around (potentially calling tcp_write_err()) when the meta is already
closed and we will get a warning like:
[  213.983095] ------------[ cut here ]------------
[  213.984532] Meta already closed i_rcv 0 i_snd 0 send_i 1 flags 0x2000301
[  213.986591] WARNING: CPU: 3 PID: 0 at /mnt/tmp/builder/builder_env/mptcp=
/net/mptcp/mptcp_ctrl.c:626 mptcp_sock_def_error_report+0xe0/0xf0
[...]

Fixes: b079a187260f ("mptcp: Remove cnt_subflows")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 81a19657724700079c4c7e0eb93d9c93e7036722)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index 45d7c9273bbe..e82a6e16f68f 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -387,6 +387,8 @@ static int mptcp_verif_dss_csum(struct sock *sk)
 				kfree_skb(tmp);
 			}
 =

+			mptcp_sub_force_close_all(tp->mpcb, sk);
+
 			ans =3D 0;
 		}
 	}
-- =

2.16.2


--===============8661217815699351621==--
