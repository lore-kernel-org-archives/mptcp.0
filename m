Content-Type: multipart/mixed; boundary="===============9160238020485314699=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2] mptcp: be careful on MPTCP-level ack.
Date: Wed, 02 Dec 2020 14:18:53 +0100
Message-ID: <fdad2c0e-e84e-4a82-7855-fc5a083bb055@gmail.com>
In-Reply-To: 5370c0ae03449239e3d1674ddcfb090cf6f20abe.1606253206.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7009

--===============9160238020485314699==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 11/24/20 10:51 PM, Paolo Abeni wrote:
> We can enter the main mptcp_recvmsg() loop even when
> no subflows are connected. As note by Eric, that would
> result in a divide by zero oops on ack generation.
> =

> Address the issue by checking the subflow status before
> sending the ack.
> =

> Additionally protect mptcp_recvmsg() against invocation
> with weird socket states.
> =

> v1 -> v2:
>  - removed unneeded inline keyword - Jakub
> =

> Reported-and-suggested-by: Eric Dumazet <eric.dumazet(a)gmail.com>
> Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/mptcp/protocol.c | 67 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 49 insertions(+), 18 deletions(-)
> =


Looking at mptcp recvmsg(), it seems that a read(fd, ..., 0) will
trigger an infinite loop if there is available data in receive queue ?

It seems the following is needed, commit ea4ca586b16f removed
a needed check to catch this condition.

Untested patch, I can submit it formally if you agree.

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 221f7cdd416bdb681968bf1b3ff2ed1b03cea3ce..57213ff60f784fae14c2a96f391=
ccdec6249c168 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1921,7 +1921,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
        len =3D min_t(size_t, len, INT_MAX);
        target =3D sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 =

-       for (;;) {
+       while (copied < len) {
                int bytes_read, old_space;
 =

                bytes_read =3D __mptcp_recvmsg_mskq(msk, msg, len - copied);
--===============9160238020485314699==--
