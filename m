Content-Type: multipart/mixed; boundary="===============0136515932537989912=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: set correct vfs info for subflows
Date: Tue, 05 May 2020 16:50:17 +0200
Message-ID: <4a7bfc28794b4737920e7a391547e0f87fec960d.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2005041813440.23858@nelizabe-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4316

--===============0136515932537989912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-05-04 at 18:19 -0700, Mat Martineau wrote:
> On Mon, 4 May 2020, Paolo Abeni wrote:
> =

> > When a subflow is created via mptcp_subflow_create_socket(),
> > a new 'struct socket' is allocated, with a new i_ino value.
> > =

> > When inspecting TCP sockets via the procfs and or the diag
> > interface, the above ones are not related to the process owning
> > the MPTCP master socket, even if they are a logical part of it
> > ('ss' shows an empty process field)
> > =

> > Additionally, subflows created by the path manager get
> > the uid/gid from the running workqueue.
> > =

> > Subflows are part of the owning MPTCP master socket, let's
> > adjust the vfs info to reflect this.
> > =

> > After this patch, 'ss' correctly displays subflows as belonging
> > to the msk socket creator.
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> =

> Seems like better information for userspace. Does this make sense for =

> -net, since the uid/gid info is not useful otherwise? Or is it benign =

> enough behavior to fix in net-next?

I personally targeted net-next with this one, but even -net could fit. =


> > ---
> > net/mptcp/subflow.c | 10 ++++++++++
> > 1 file changed, 10 insertions(+)
> > =

> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 67a4e35d4838..86ade8f09f4a 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1012,6 +1012,16 @@ int mptcp_subflow_create_socket(struct sock *sk,=
 struct socket **new_sock)
> > 	if (err)
> > 		return err;
> > =

> > +	/* the newly created socket really belong to the owing MPTCP master
> =

> Minor fix: "belongs to the owning"

Thanks, will fix in next/upstream iteration.

Cheers,

Paolo

--===============0136515932537989912==--
