Content-Type: multipart/mixed; boundary="===============0059772149458373252=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: address potential infinite loop
 on receive
Date: Wed, 02 Dec 2020 11:04:23 -0800
Message-ID: <3df52a87-8c86-d7f8-c544-3c12233f2c57@linux.intel.com>
In-Reply-To: 7cc29abe8da61eeb3e6c7bd5d2d8fe1d51dcdd7e.1606924518.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7018

--===============0059772149458373252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Dec 2020, Paolo Abeni wrote:

> Eric noted the MPTCP recvmsg() loop can iterate multiple
> times when the argument lenght is 0 and some subflow is
> feeding new data.
>
> Be sure to quite the loop soon moving the exit condition
> earlier. Additionally move a related comment into the
> right place.
>
> Reported-by: Eric Dumazet <eric.dumazet(a)gmail.com>
> Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> Note: looking again at the current code, I think that at worst we
> can do a single additional, unneeded iteration - after the first
> 'continue' statement __mptcp_move_skbs() will have moved some data
> into the receive_queue, and we are not going to receive them. On
> next iteration the receive_queue will be not empty.
>
> Unless the peer is crafting some malicious DSS/packets combo I'm
> unable to foreseen.
> ---
> net/mptcp/protocol.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>

To close the loop here on the mailing list (based on IRC, patchwork, and =

netdev), Paolo has tested Eric's fix for the issue and that will be =

merged instead:

https://patchwork.kernel.org/project/netdevbpf/patch/20201202171657.1185108=
-1-eric.dumazet(a)gmail.com/

--
Mat Martineau
Intel
--===============0059772149458373252==--
