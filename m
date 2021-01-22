Content-Type: multipart/mixed; boundary="===============8746552387142538347=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 net-next 5/5] mptcp: implement delegated actions
Date: Thu, 21 Jan 2021 17:34:37 -0800
Message-ID: <20210121173437.1b945b01@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: fbae7709d333eb2afcc79e69a8db3d952292564f.1611153172.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7465

--===============8746552387142538347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Jan 2021 15:39:14 +0100 Paolo Abeni wrote:
> On MPTCP-level ack reception, the packet scheduler
> may select a subflow other then the current one.
> =

> Prior to this commit we rely on the workqueue to trigger
> action on such subflow.
> =

> This changeset introduces an infrastructure that allows
> any MPTCP subflow to schedule actions (MPTCP xmit) on
> others subflows without resorting to (multiple) process
> reschedule.

If your work doesn't reschedule there should not be multiple =

rescheds, no?

> A dummy NAPI instance is used instead. When MPTCP needs to
> trigger action an a different subflow, it enqueues the target
> subflow on the NAPI backlog and schedule such instance as needed.
> =

> The dummy NAPI poll method walks the sockets backlog and tries
> to acquire the (BH) socket lock on each of them. If the socket
> is owned by the user space, the action will be completed by
> the sock release cb, otherwise push is started.
> =

> This change leverages the delegated action infrastructure
> to avoid invoking the MPTCP worker to spool the pending data,
> when the packet scheduler picks a subflow other then the one
> currently processing the incoming MPTCP-level ack.
> =

> Additionally we further refine the subflow selection
> invoking the packet scheduler for each chunk of data
> even inside __mptcp_subflow_push_pending().

Is there much precedence for this sort of hijacking of NAPI =

for protocol work? Do you need it because of locking?
--===============8746552387142538347==--
