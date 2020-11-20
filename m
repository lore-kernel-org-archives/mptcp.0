Content-Type: multipart/mixed; boundary="===============7231579225723083913=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: update rtx timeout only if
 required.
Date: Thu, 19 Nov 2020 21:55:33 -0800
Message-ID: <20201119215533.1dff6751@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: CA+G9fYstUYSeXh=w2YSmytHfBg2=tnwyAx_hCJtn2Dfi_Ts91g@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6861

--===============7231579225723083913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Nov 2020 19:49:16 +0530 Naresh Kamboju wrote:
> > > We must start the retransmission timer only there are
> > > pending data in the rtx queue.
> > > Otherwise we can hit a WARN_ON in mptcp_reset_timer(),
> > > as syzbot demonstrated.
> > >
> > > Reported-and-tested-by: syzbot+42aa53dafb66a07e5a24(a)syzkaller.appsp=
otmail.com
> > > Fixes: d9ca1de8c0cd ("mptcp: move page frag allocation in mptcp_sendm=
sg()")
> > > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> >
> > Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>  =

> =

> Reported-by: Naresh Kamboju <naresh.kamboju(a)linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju(a)linaro.org>

Applied, thanks!
--===============7231579225723083913==--
