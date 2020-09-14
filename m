Content-Type: multipart/mixed; boundary="===============9066683957477319588=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 06/13] mptcp: move ooo skbs into msk
 out of order queue.
Date: Mon, 14 Sep 2020 11:06:50 -0700
Message-ID: <alpine.OSX.2.23.453.2009141106240.57764@ningale-mobl.amr.corp.intel.com>
In-Reply-To: 26988dc9d753a61cd344d71d4bf16b50920913c7.1599854632.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5854

--===============9066683957477319588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2020, Paolo Abeni wrote:

> Add an RB-tree to cope with OoO (at MPTCP level) data.
> __mptcp_move_skb() insert into the RB tree "future"
> data, eventually coalescing skb as allowed by the
> MPTCP DSN.
>
> To simplify sequence accounting, move the DSN inside
> the cb.
>
> After successfully enqueuing in sequence data, check
> if we can use any data from the RB tree.
>
> Additionally move the data_fin check after spooling
> data from the OoO tree, otherwise we could miss shutdown
> events.
>
> The RB tree code is copied as verbatim as possible
> from tcp_data_queue_ofo(), with a few simplifications
> due to the fact that MPTCP doesn't need to cope with
> sacks. All bugs here are added by me.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 264 ++++++++++++++++++++++++++++++++++---------
> net/mptcp/protocol.h |   2 +
> net/mptcp/subflow.c  |   1 +
> 3 files changed, 211 insertions(+), 56 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============9066683957477319588==--
