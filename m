Content-Type: multipart/mixed; boundary="===============6770874421677285060=="
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju at linaro.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: update rtx timeout only if
 required.
Date: Thu, 19 Nov 2020 19:49:16 +0530
Message-ID: <CA+G9fYstUYSeXh=w2YSmytHfBg2=tnwyAx_hCJtn2Dfi_Ts91g@mail.gmail.com>
In-Reply-To: d69c8138-311b-f94e-74b8-1e759846eec0@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6834

--===============6770874421677285060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Nov 2020 at 06:13, Mat Martineau
<mathew.j.martineau(a)linux.intel.com> wrote:
>
>
> On Wed, 18 Nov 2020, Paolo Abeni wrote:
>
> > We must start the retransmission timer only there are
> > pending data in the rtx queue.
> > Otherwise we can hit a WARN_ON in mptcp_reset_timer(),
> > as syzbot demonstrated.
> >
> > Reported-and-tested-by: syzbot+42aa53dafb66a07e5a24(a)syzkaller.appspot=
mail.com
> > Fixes: d9ca1de8c0cd ("mptcp: move page frag allocation in mptcp_sendmsg=
()")
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > net/mptcp/protocol.c | 9 +++++----
> > 1 file changed, 5 insertions(+), 4 deletions(-)
> >
>
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Reported-by: Naresh Kamboju <naresh.kamboju(a)linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju(a)linaro.org>

The reported kernel warning was fixed after applying this fix on top of
Linux next tag  20201119.

- Naresh
--===============6770874421677285060==--
