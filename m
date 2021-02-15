Content-Type: multipart/mixed; boundary="===============0843256083949206298=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: fix DATA_FIN generation on early
 shutdown.
Date: Mon, 15 Feb 2021 10:44:39 +0100
Message-ID: <f90087d8e873c04b5da081d7a44b180e2a7e2294.camel@redhat.com>
In-Reply-To: 6525cc44-63f-655b-453a-2c8d8219f0bf@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7802

--===============0843256083949206298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-02-12 at 17:06 -0800, Mat Martineau wrote:
> On Thu, 11 Feb 2021, Paolo Abeni wrote:
> =

> > If the msk is closed before sending or receiving any data,
> > no DATA_FIN is generated, instead an MPC ack packet is
> > crafted out.
> > =

> > In the above scenario, the MPTCP protocol create and send a
> > pure ack and such packets matches also the criteria for an
> > MPC ack and the protocol tries first to insert MPC options,
> > leading the described error.
> > =

> > This change address the issue skipping MPC option for DATA_FIN
> > packets or if the subflow is not established.
> > =

> > To avoid doing multiple times the same test, fetch the data_fin
> > flag in a bool variable and pass it to both the interested
> > helpers.
> > =

> > Fixes: 6d0060f600ad ("mptcp: Write MPTCP DSS headers to outgoing data p=
ackets")
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > The scenario is tested by a specific pktdrill tested,
> > already pushed
> > ---
> > net/mptcp/options.c | 23 ++++++++++++++---------
> > 1 file changed, 14 insertions(+), 9 deletions(-)
> =

> Hi Paolo -
> =

> Change looks good to me:
> =

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Thanks! =


> Were you intending this for the export branch or the -net tree? (Unsure =

> due to the [PATCH mptcp-net] prefix)

I'm trying to follow the rules listed here:

https://annuel2.framapad.org/p/mptcp_upstreaming_20201126

(starting from line 188). 'mptcp-net' is targeting the -net tree after
being staged in the export branch.

Cheers,

Paolo


--===============0843256083949206298==--
