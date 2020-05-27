Content-Type: multipart/mixed; boundary="===============2547403374880464687=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: avoid NULL-ptr derefence on fallback
Date: Tue, 26 May 2020 20:18:59 -0700
Message-ID: <20200526.201859.755046542854273149.davem@davemloft.net>
In-Reply-To: d7d7f946ab9c43e96720d97e68645e38fb8b233c.1590417507.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4510

--===============2547403374880464687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Mon, 25 May 2020 16:38:47 +0200

> In the MPTCP receive path we must cope with TCP fallback
> on blocking recvmsg(). Currently in such code path we detect
> the fallback condition, but we don't fetch the struct socket
> required for fallback.
> =

> The above allowed syzkaller to trigger a NULL pointer
> dereference:
 ...
> Address the issue initializing the struct socket reference
> before entering the fallback code.
> =

> Reported-and-tested-by: syzbot+c6bfc3db991edc918432(a)syzkaller.appspotma=
il.com
> Suggested-by: Ondrej Mosnacek <omosnace(a)redhat.com>
> Fixes: 8ab183deb26a ("mptcp: cope with later TCP fallback")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied and queued up for -stable, thanks.
--===============2547403374880464687==--
