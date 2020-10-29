Content-Type: multipart/mixed; boundary="===============1487774685355252304=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: add missing memory scheduling in the
 rx path
Date: Thu, 29 Oct 2020 11:29:42 -0700
Message-ID: <20201029112942.773b5b74@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: d7886714-7b92-9be8-441e-73c48c52d62@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6476

--===============1487774685355252304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2020 15:46:11 -0700 (PDT) Mat Martineau wrote:
> On Tue, 27 Oct 2020, Paolo Abeni wrote:
> > When moving the skbs from the subflow into the msk receive
> > queue, we must schedule there the required amount of memory.
> >
> > Try to borrow the required memory from the subflow, if needed,
> > so that we leverage the existing TCP heuristic.
> >
> > Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> =

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Applied, thanks!
--===============1487774685355252304==--
