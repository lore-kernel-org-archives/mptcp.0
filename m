Content-Type: multipart/mixed; boundary="===============8560551135937471705=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH kbuild] mptcp: update_una() can be static
Date: Wed, 09 Oct 2019 11:06:44 -0700
Message-ID: <alpine.OSX.2.21.1910091105480.48251@crpeter1-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2079

--===============8560551135937471705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Fixes: e0c0e8d7b6cd ("mptcp: update per unacked sequence on pkt reception")
Signed-off-by: kbuild test robot <lkp(a)intel.com>
---

Forwarding additional kbuild suggestions that were not sent to everyone.

  options.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index be05d99e6bfa5..ef53f5ddb7325 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -550,7 +550,7 @@ static u64 expand_ack(u64 old_ack, u64 cur_ack, bool us=
e_64bit)
  	return cur_ack;
  }

-void update_una(struct mptcp_sock *msk, struct mptcp_options_received *mp_=
opt)
+static void update_una(struct mptcp_sock *msk, struct mptcp_options_receiv=
ed *mp_opt)
  {
  	u64 new_snd_una, snd_una, old_snd_una =3D atomic64_read(&msk->snd_una);

--===============8560551135937471705==--
