Content-Type: multipart/mixed; boundary="===============1555626000861980279=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 4/4] mptcp: trigger the
 RM_ADDR signal
Date: Wed, 29 Jul 2020 18:29:37 +0200
Message-ID: <872b781aa6fa312c427b121ebb71ee8d415d618c.camel@redhat.com>
In-Reply-To: 20200729093332.GA26613@OptiPlex
X-Status: 
X-Keywords:                  
X-UID: 5369

--===============1555626000861980279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-07-29 at 17:33 +0800, Geliang Tang wrote:
> I have sent out REMOVE_ADDR patchset v3 to you.
> =

> On Wed, Jul 22, 2020 at 01:34:25PM +0200, Paolo Abeni wrote:
> > On Wed, 2020-07-22 at 12:41 +0200, Paolo Abeni wrote:
> > > > +void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
> > > > +{
> > > > + struct mptcp_subflow_context *subflow, *tmp;
> > > > +
> > > > + pr_debug("remote_id %d", msk->pm.rm_id);
> > > > +
> > > > + msk->pm.add_addr_accepted--;
> > > > + msk->pm.subflows--;
> > > > + WRITE_ONCE(msk->pm.accept_addr, true);
> > > > +
> > > > + list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> > > > +         struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
> > > > +
> > > > +         if (msk->pm.rm_id =3D=3D subflow->remote_id) {
> > > > +                 mptcp_subflow_shutdown(tcp_sk, 1, 1, msk->write_s=
eq);
> > > =

> > > the 2nd argument for mptcp_subflow_shutdown() should be something ali=
ke
> > > 'RCV_SHUTDOWN|SEND_SHUTDOWN' - we are closing the subflow in both
> > > direction - and the third argument '0' - the msk will remain
> > > open/established.
> > > =

> =

> I have updated these arguments in patchset v3.

Thanks! I'll try to review before tomorrow's mtg - sorry for the
latency, I'm lagging behind other tasks.

/P

--===============1555626000861980279==--
