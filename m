Content-Type: multipart/mixed; boundary="===============8968909251502386538=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net-next] mptcp: clear use_ack and use_map
 when dropping other suboptions
Date: Wed, 16 Dec 2020 16:22:39 -0800
Message-ID: <20201216162239.4310d998@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: fd9ba263-de65-75e4-d62e-8bdf9236bf5@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7202

--===============8968909251502386538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Dec 2020 16:11:52 -0800 (PST) Mat Martineau wrote:
> On Tue, 15 Dec 2020, Geliang Tang wrote:
> =

> > This patch cleared use_ack and use_map when dropping other suboptions to
> > fix the following syzkaller BUG:

> > Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> > Fixes: 84dfe3677a6f (mptcp: send out dedicated ADD_ADDR packet)
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > net/mptcp/options.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >  =

> =

> David or Jakub, this patch is intended for the -net tree (not net-next as =

> labeled in the subject line). If you can apply it to -net, that's great, =

> otherwise it can be resubmitted as [PATCH net].
> =

> In any case, the content is good:

Should matter all that much other than for build testing.

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Applied, thanks!
--===============8968909251502386538==--
