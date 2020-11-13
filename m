Content-Type: multipart/mixed; boundary="===============1183044822171844622=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: refine MPTCP-level ack scheduling
Date: Fri, 13 Nov 2020 20:35:15 +0100
Message-ID: <f8ed1992-3da8-bd54-6e87-0348aee812ab@tessares.net>
In-Reply-To: d46ac556e6140c96c261987ca2d0cbe9bb1c97bd.1605005925.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6726

--===============1183044822171844622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 10/11/2020 11:58, Paolo Abeni wrote:
> Send timely MPTCP-level ack is somewhat difficult when
> the insertion into the msk receive level is performed
> by the worker.
> =

> It needs TCP-level dup-ack to notify the MPTCP-level
> ack_seq increase, as both the TCP-level ack seq and the
> rcv window are unchanged.
> =

> We can actually avoid processing incoming data with the
> worker, and let the subflow or recevmsg() send ack as needed.
> =

> When recvmsg() moves the skbs inside the msk receive queue,
> the msk space is still unchanged, so tcp_cleanup_rbuf() could
> end-up skipping TCP-level ack generation. Anyway, when
> __mptcp_move_skbs() is invoked, a known amount of bytes is
> going to be consumed soon: we update rcv wnd computation taking
> them in account.
> =

> Additionally we need to explicitly trigger tcp_cleanup_rbuf()
> when recvmsg() consumes a significant amount of the receive buffer.

Thank you for the patch and the review!

> Signed-off-by:  Paolo Abeni <pabeni(a)redhat.com>

(I removed the extra space here above and added Mat's reviewed-by tag)

Added at the end of the series:

- 988c8c685833: mptcp: refine MPTCP-level ack scheduling
- Results: 245521ccb46e..ad60a6cb69b

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1183044822171844622==--
