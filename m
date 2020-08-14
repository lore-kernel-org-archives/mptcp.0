Content-Type: multipart/mixed; boundary="===============2441881816385032156=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: sendmsg: reset iter on error
Date: Fri, 14 Aug 2020 14:12:39 -0700
Message-ID: <20200814.141239.1395631815275609574.davem@davemloft.net>
In-Reply-To: 20200814135634.12996-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5560

--===============2441881816385032156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>
Date: Fri, 14 Aug 2020 15:56:34 +0200

> Once we've copied data from the iterator we need to revert in case we
> end up not sending any data.
> =

> This bug doesn't trigger with normal 'poll' based tests, because
> we only feed a small chunk of data to kernel after poll indicated
> POLLOUT.  With blocking IO and large writes this triggers. Receiver
> ends up with less data than it should get.
> =

> Fixes: 72511aab95c94d ("mptcp: avoid blocking in tcp_sendpages")
> Signed-off-by: Florian Westphal <fw(a)strlen.de>

Applied and queued up for -stable, thanks.
--===============2441881816385032156==--
