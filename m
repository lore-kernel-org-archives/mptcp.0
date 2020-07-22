Content-Type: multipart/mixed; boundary="===============5214495540955640406=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 3/4] mptcp: add the RM_ADDR
 option parsing
Date: Wed, 22 Jul 2020 09:42:53 -0700
Message-ID: <20200722164253.GD73500@MacBook-Pro-64.local>
In-Reply-To: fa9c8b10d4ac264a9bdd5e69440437a00b456c82.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5179

--===============5214495540955640406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/22/20 - 13:34, Paolo Abeni wrote:
> On Wed, 2020-07-22 at 12:41 +0200, Paolo Abeni wrote:
> > > +void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
> > > +{
> > > +	struct mptcp_subflow_context *subflow, *tmp;
> > > +
> > > +	pr_debug("remote_id %d", msk->pm.rm_id);
> > > +
> > > +	msk->pm.add_addr_accepted--;
> > > +	msk->pm.subflows--;
> > > +	WRITE_ONCE(msk->pm.accept_addr, true);
> > > +
> > > +	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> > > +		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
> > > +
> > > +		if (msk->pm.rm_id =3D=3D subflow->remote_id) {
> > > +			mptcp_subflow_shutdown(tcp_sk, 1, 1, msk->write_seq);
> > =

> > the 2nd argument for mptcp_subflow_shutdown() should be something alike
> > 'RCV_SHUTDOWN|SEND_SHUTDOWN' - we are closing the subflow in both
> > direction - and the third argument '0' - the msk will remain
> > open/established.
> > =

> > I think here the subflow socket will be leaked. Can you please double
> > check that with a CONFIG_DEBUG_KMEMLEAK enabled build?
> > =

> > Likely something alike what __mptcp_close_ssk() is currently doing
> > should be added here, but that will not fit nicely with a proper
> > shutdown, so I'm unsure how to address this correctly.
> =

> Whoops... some additional things I missed before:
> =

> You must release the msk.pm lock before
> invoking mptcp_subflow_shutdown() and re-acquiring it after the
> function call completes (some CONFIG_DEBUG_ know should warn you at run
> time).
> =

> And the RFC states:
> =

> """
>    if a host receives a REMOVE_ADDR option, it
>    must ensure that the affected path or paths are no longer in use
>    before it instigates closure.  The receipt of REMOVE_ADDR SHOULD
>    first trigger the sending of a TCP keepalive [RFC1122] on the path,
>    and if a response is received, the path SHOULD NOT be removed.  If
>    the path is found to still be alive, the receiving host SHOULD no
>    longer use the specified address for future connections, but it is
>    the responsibility of the host that sent the REMOVE_ADDR to shut down
>    the subflow.
> """
> =

> I'm unsure what "the affected path or paths are no longer in use" means
> here. @Christoph: how is mptcp.org handling this? With a quick glance
> it looks like it unconditionally remove the subflow[s] ???

Yes, we do unconditionally remove the subflows. The reason was for
simplicity, as otherwise we would need to send probes or TCP Keep-alives to
check the path.

The risk is that an on-path attacker could inject remove_addr to steer traf=
fic to
the path that the attacker has "access" to so that he can monitor the entire
connection.


I think that it is OK for now in net-next to unconditionally remove the
subflows.


Christoph

--===============5214495540955640406==--
