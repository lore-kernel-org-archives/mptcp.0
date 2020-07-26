Content-Type: multipart/mixed; boundary="===============2544055060286448837=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: get rid of the address_space override in setsockopt v2
Date: Sun, 26 Jul 2020 09:03:11 +0200
Message-ID: <20200726070311.GA16687@lst.de>
In-Reply-To: 20200724.154342.1433271593505001306.davem@davemloft.net
X-Status: 
X-Keywords:                  
X-UID: 5295

--===============2544055060286448837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 03:43:42PM -0700, David Miller wrote:
> > Changes since v1:
> >  - check that users don't pass in kernel addresses
> >  - more bpfilter cleanups
> >  - cosmetic mptcp tweak
> =

> Series applied to net-next, I'm build testing and will push this out when
> that is done.

The buildbot found one warning with the isdn debug code after a few
days, here is what I think is the best fix:

---
From 6601732f7a54db5f04efba08f7e9224e5b757112 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch(a)lst.de>
Date: Sun, 26 Jul 2020 09:00:09 +0200
Subject: mISDN: remove a debug printk in data_sock_setsockopt

The %p won't work with the new sockptr_t type.  But in the times of
ftrace, bpftrace and co these kinds of debug printks are pretty anyway,
so just remove the whole debug printk.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 drivers/isdn/mISDN/socket.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index 1b2b91479107bc..2c58a6fe6d129e 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -406,10 +406,6 @@ static int data_sock_setsockopt(struct socket *sock, i=
nt level, int optname,
 	struct sock *sk =3D sock->sk;
 	int err =3D 0, opt =3D 0;
 =

-	if (*debug & DEBUG_SOCKET)
-		printk(KERN_DEBUG "%s(%p, %d, %x, %p, %d)\n", __func__, sock,
-		       level, optname, optval, len);
-
 	lock_sock(sk);
 =

 	switch (optname) {
-- =

2.27.0

--===============2544055060286448837==--
