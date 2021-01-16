Content-Type: multipart/mixed; boundary="===============8737306529117347411=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next] mptcp: implement delegated actions
Date: Sat, 16 Jan 2021 11:09:18 +0100
Message-ID: <161b7455-2ea5-4f76-3bb4-6410f7c60858@tessares.net>
In-Reply-To: de1057fa8de3cebc6150c410812c0b1ad3e4fd14.1610731067.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7405

--===============8737306529117347411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 15/01/2021 18:17, Paolo Abeni wrote:
> On MPTCP-level ack reception, the packet scheduler
> may select a subflow other then the current one.
> =

> Prior to this commit we rely on the workqueue to trigger
> action on such subflow.
> =

> This changeset introduce an infrastructure that allows
> any MPTCP subflow to schedule actions (MPTCP xmit) on
> others subflows without resorting to (multiple) process
> reschedule.
> =

> A dummy NAPI instance is used instead. When MPTCP needs to
> trigger action an a different subflow, it enqueues the target
> subflow on the NAPI backlog and schedule such instance as needed.
> =

> The dummy NAPI poll method walk the sockets backlog and try
> to acquire the (BH) socket lock on each of them. If the socket
> is owned by the user space, the action will be completed by
> the sock release cb, otherwise push is started.
> =

> This change leverage the delegated action infrastructure
> to avoid invoking the MPTCP worker to spool the pending data,
> when the packet scheduler picks a subflow other then the one
> currently processing the incoming MPTCP-level ack.
> =

> Additinally we fourther refine the subflow selection
> invoking the packet scheduler for each chunk of data
> even inside __mptcp_subflow_push_pending()
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for this nice patch and reviews!

I just added it in our tree, after other patches from Paolo, with Mat's =

RvB tag and fixed a few typos in the commit message. There was a small =

conflict, a detail.

- ac480864a68a: mptcp: implement delegated actions
- da565da41ddc: conflict in t/DO-NOT-MERGE-mptcp-use-kmalloc-on-kasan-build
- Results: dd65d1dcd819..46973a057ea7

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8737306529117347411==--
