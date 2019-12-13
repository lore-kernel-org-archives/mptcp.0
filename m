Content-Type: multipart/mixed; boundary="===============6791583856432091107=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: cope with later TCP fallback.
Date: Fri, 13 Dec 2019 19:53:38 +0100
Message-ID: <ff7ef19f-5e1d-20d0-dd63-0a0c0c2ce3d2@tessares.net>
In-Reply-To: e3ecdf5f274343f2d0501a327b9ae4dc8d48a9e7.1576254709.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2977

--===============6791583856432091107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian, Mat,

On 13/12/2019 17:31, Paolo Abeni wrote:
> With V1 passive connections can fallback TCP after that the
> subflow become established:
> =

> syn+ MP_CAPABLE ->
>                 <- syn, ack + MP_CAPABLE
> =

> ack, seq =3D 3    ->
>          // OoO packet is accepted because in-sequence
>          // passive socket is created, is in ESTABLISHED
> 	// status and tentatively as MP_CAPABLE
> =

> ack, seq =3D 2     ->
>          // no MP_CAPABLE opt, subflow should fallback to TCP
> =

> We can't use the 'subflow' socket fallback, as we don't have
> it available for passive connection.
> =

> Instead, when the fallback is detected, replace the mptcp
> socket with the underlining TCP subflow. Beyond covering
> the above scenario, it makes TCP fallback socket as efficient
> as plain TCP ones.
> =

> Co-developed-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> RFC -> v1:
>   - fixed WARN_ON splat on fallback
>   - added a few more comments about locking
>   - tested on both of v1 patches and top of current export
>     branch
> =

> Note: should be applied just after "mptcp: process MP_CAPABLE data option=
."

I just applied this patch just after "mptcp: process MP_CAPABLE data =

option". Please review at least the resolution of the second conflict:

=3D=3D=3D=3D=3D
diff --cc net/mptcp/protocol.c
index 9970487a855d,08d686c5f614..000000000000
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@@ -202,11 -189,8 +249,16 @@@ static int mptcp_sendmsg_frag(struct so
                 ret =3D sk_stream_wait_memory(ssk, timeo);
                 if (ret)
                         return ret;
++<<<<<<< t/mptcp-queue-data-for-mptcp-level-retransmission
  +
  +              /* id sk_stream_wait_memory() sleeps snd_una can change
  +               * significantly, refresh the rtx queue
  +               */
  +              mptcp_clean_una(sk);
++=3D=3D=3D=3D=3D=3D=3D
+               if (unlikely(__mptcp_needs_tcp_fallback(msk)))
+                       return 0;
++>>>>>>> top-bases/t/mptcp-queue-data-for-mptcp-level-retransmission
         }

         /* compute copy limit */
=3D=3D=3D=3D=3D


- be009e4990f8: conflict in t/mptcp-Add-path-manager-interface
- 6aa8c2826aa9: conflict in =

t/mptcp-queue-data-for-mptcp-level-retransmission
- 1afa4a73e9a9: conflict in t/mptcp-introduce-MPTCP-retransmission-timer
- 61ff4269f0bb: conflict in =

t/mptcp-implement-memory-accounting-for-mptcp-rtx-queue
- d63f402c1c53: conflict in =

t/subflow-place-further-subflows-on-new-join_list
- bc663afcd33e..956fb00125d4: result

Tests + export are in progress!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6791583856432091107==--
