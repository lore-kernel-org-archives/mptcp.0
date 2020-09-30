Content-Type: multipart/mixed; boundary="===============3908224531753853912=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH net 1/2] mptcp: Consistently use
 READ_ONCE/WRITE_ONCE with msk->ack_seq
Date: Wed, 30 Sep 2020 12:19:58 +0200
Message-ID: <302cc293-21ff-3263-8945-c60e6c1b5c3f@tessares.net>
In-Reply-To: 20200926002408.432576-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6113

--===============3908224531753853912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 26/09/2020 02:24, Mat Martineau wrote:
> The msk->ack_seq value is sometimes read without the msk lock held, so
> make proper use of READ_ONCE and WRITE_ONCE.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
> =

> This does create some merge conflicts with net-next - what's the best
> way to handle that?

Should we send to netdev ML about how we resolve the conflicts?

I am adding the two patches you sent upstream to the "export" branch and =

resolved the conflicts.

- d80ba0d7cf7f: mptcp: Consistently use READ_ONCE/WRITE_ONCE with =

msk->ack_seq
- 69bd9c6e1c45: mptcp: Handle incoming 32-bit DATA_FIN values

About the conflicts I had:


Patch 1:
- protocol.c: using the version from net-next and modifying =

__mptcp_move_skb() where we have:

   msk->ack_seq +=3D copy_len;


Patch 2:
- subflow.c: we don't use the returned value of =

mptcp_update_rcv_data_fin() in net-next
- protocol.h: we take the new version of mptcp_update_rcv_data_fin() and =

we keep mptcp_destroy_common() unchanged.

I don't know if we need to provide a Git repo or a diff.
Note that on my side, I don't have the result of a merge but a =

modification of the patches for net-next. I don't think that's what they =

want.

Note that we no longer read the output of mptcp_update_rcv_data_fin().


Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3908224531753853912==--
