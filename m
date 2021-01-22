Content-Type: multipart/mixed; boundary="===============6273691495406814647=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 net-next 5/5] mptcp: implement delegated actions
Date: Fri, 22 Jan 2021 09:25:07 +0100
Message-ID: <e093e7615490baad413ef6ba49154e3e4e98399a.camel@redhat.com>
In-Reply-To: 20210121173437.1b945b01@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com
X-Status: 
X-Keywords:                  
X-UID: 7467

--===============6273691495406814647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2021-01-21 at 17:34 -0800, Jakub Kicinski wrote:
> On Wed, 20 Jan 2021 15:39:14 +0100 Paolo Abeni wrote:
> > On MPTCP-level ack reception, the packet scheduler
> > may select a subflow other then the current one.
> > =

> > Prior to this commit we rely on the workqueue to trigger
> > action on such subflow.
> > =

> > This changeset introduces an infrastructure that allows
> > any MPTCP subflow to schedule actions (MPTCP xmit) on
> > others subflows without resorting to (multiple) process
> > reschedule.
> =

> If your work doesn't reschedule there should not be multiple =

> rescheds, no?

Thank you for looking into this.

With the workqueue it would be:

<running process> -> BH -> (process scheduler) -> MPTCP workqueue ->
(process scheduler) -> <running process>

With this infra is:

<running process> -> BH -> BH -> <running process>

> > A dummy NAPI instance is used instead. When MPTCP needs to
> > trigger action an a different subflow, it enqueues the target
> > subflow on the NAPI backlog and schedule such instance as needed.
> > =

> > The dummy NAPI poll method walks the sockets backlog and tries
> > to acquire the (BH) socket lock on each of them. If the socket
> > is owned by the user space, the action will be completed by
> > the sock release cb, otherwise push is started.
> > =

> > This change leverages the delegated action infrastructure
> > to avoid invoking the MPTCP worker to spool the pending data,
> > when the packet scheduler picks a subflow other then the one
> > currently processing the incoming MPTCP-level ack.
> > =

> > Additionally we further refine the subflow selection
> > invoking the packet scheduler for each chunk of data
> > even inside __mptcp_subflow_push_pending().
> =

> Is there much precedence for this sort of hijacking of NAPI =

> for protocol work? =


AFAICS, xfrm is using a similar trick in the receive path.

Note that we uses TX-only NAPIs, so this does not pollute the napi hash
table.

> Do you need it because of locking?

This infrastructure is used to avoid the workqueue usage in the MPTCP
receive path (to push pending data). With many mptcp connections
established that would be very bad for tput and latency. This
infrastructure is not strictly needed from a functinal PoV, but I was
unable to find any other way to avoid the workqueue usage.

Please let me know if the above is clear enough!

Thanks,

Paolo

--===============6273691495406814647==--
