Content-Type: multipart/mixed; boundary="===============8801157938120041798=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/2] mptcp: fix syzkaller splats
Date: Mon, 27 Jan 2020 00:40:59 +0100
Message-ID: <20200126234101.7256-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3519

--===============8801157938120041798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fixes the syzkaller splats with reproducers that Christoph forwarded
to the mailing list.

First patch fixes a crash with set/getsockopt interface and resolves
a lockdep splat due to calls to rtnl_lock while already holding the msk loc=
k.
I resolved both in the same patch because the fix touches the same spot.

Second patch fixes another lockdep splat, this time during mptcp_close
but also related to rtnl_lock.

See patches for more detailed explanation.

 protocol.c |   51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

--===============8801157938120041798==--
