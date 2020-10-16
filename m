Content-Type: multipart/mixed; boundary="===============7845564887566320878=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close"
Date: Fri, 16 Oct 2020 13:24:14 -0700
Message-ID: <20201016202414.GE3269@MacBook-Pro.local>
In-Reply-To: fffd74384126974bb9f56303948000f11b0b291f.1602794093.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6333

--===============7845564887566320878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/15/20 - 23:28, Paolo Abeni wrote:
> After the refactor __mptcp_close_ssk() can be invoked on
> orphaned TCP socket, so we can't wait a timeout, or
> sk_stream_wait_close() will oops due to NULL waitqueue.
> =

> We can simply always use a 0 timeout (and clean-up the
> related signature accordingly): the timeout, if any,
> is used before by mptcp_close().
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> This should fix issue 100, but I only build test it ;)

Yes, it does! :-)


Christoph

--===============7845564887566320878==--
