Content-Type: multipart/mixed; boundary="===============8014939504315681483=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: update rtx timeout only if
 required.
Date: Wed, 18 Nov 2020 16:42:44 -0800
Message-ID: <d69c8138-311b-f94e-74b8-1e759846eec0@linux.intel.com>
In-Reply-To: 1a72039f112cae048c44d398ffa14e0a1432db3d.1605737083.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6805

--===============8014939504315681483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 18 Nov 2020, Paolo Abeni wrote:

> We must start the retransmission timer only there are
> pending data in the rtx queue.
> Otherwise we can hit a WARN_ON in mptcp_reset_timer(),
> as syzbot demonstrated.
>
> Reported-and-tested-by: syzbot+42aa53dafb66a07e5a24(a)syzkaller.appspotma=
il.com
> Fixes: d9ca1de8c0cd ("mptcp: move page frag allocation in mptcp_sendmsg()=
")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============8014939504315681483==--
