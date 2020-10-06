Content-Type: multipart/mixed; boundary="===============6981919950577575546=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: fix infinite loop on
 recvmsg()/worker() race.
Date: Tue, 06 Oct 2020 16:00:33 -0700
Message-ID: <alpine.OSX.2.23.453.2010061600080.22542@ccarpent-mobl.amr.corp.intel.com>
In-Reply-To: 5a2464d778499bdc2ced43b56569008030b470bc.1601965539.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6233

--===============6981919950577575546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Oct 2020, Paolo Abeni wrote:

> If recvmsg() and the workqueue race to dequeue the data
> pending on some subflow, the current mapping for such
> subflow covers several skbs and some of them have not
> reached yet the received, either the worker or recvmsg()
> can find a subflow with the data_avail flag set - since
> the current mapping is valid and in sequence - but no
> skbs in the receive queue - since the other entity just
> processed them.
>
> The above will lead to an unbounded loop in __mptcp_move_skbs()
> and a subsequent hang of any task trying to acquiring the msk
> socket lock.
>
> This change addresses the issue stopping the __mptcp_move_skbs()
> loop as soon as we detect the above race (empty receive queue
> with data_avail set).
>
> Reported-and-tested-by: syzbot+fcf8ca5817d6e92c6567(a)syzkaller.appspotma=
il.com
> Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============6981919950577575546==--
