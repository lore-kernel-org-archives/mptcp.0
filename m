Content-Type: multipart/mixed; boundary="===============0106326667130035782=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 net-next 5/5] mptcp: implement delegated actions
Date: Wed, 20 Jan 2021 08:36:12 -0800
Message-ID: <111fb263-cf66-bd28-7316-1a4d5985ac49@linux.intel.com>
In-Reply-To: fbae7709d333eb2afcc79e69a8db3d952292564f.1611153172.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7459

--===============0106326667130035782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Jan 2021, Paolo Abeni wrote:

> On MPTCP-level ack reception, the packet scheduler
> may select a subflow other then the current one.
>
> Prior to this commit we rely on the workqueue to trigger
> action on such subflow.
>
> This changeset introduces an infrastructure that allows
> any MPTCP subflow to schedule actions (MPTCP xmit) on
> others subflows without resorting to (multiple) process
> reschedule.
>
> A dummy NAPI instance is used instead. When MPTCP needs to
> trigger action an a different subflow, it enqueues the target
> subflow on the NAPI backlog and schedule such instance as needed.
>
> The dummy NAPI poll method walks the sockets backlog and tries
> to acquire the (BH) socket lock on each of them. If the socket
> is owned by the user space, the action will be completed by
> the sock release cb, otherwise push is started.
>
> This change leverages the delegated action infrastructure
> to avoid invoking the MPTCP worker to spool the pending data,
> when the packet scheduler picks a subflow other then the one
> currently processing the incoming MPTCP-level ack.
>
> Additionally we further refine the subflow selection
> invoking the packet scheduler for each chunk of data
> even inside __mptcp_subflow_push_pending().
>
> v1 -> v2:
> - fix possible UaF at shutdown time, resetting sock ops
>   after removing the ulp context
>

Thanks for the update Paolo, just confirming/recording on the MPTCP list =

that this tag:

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

is indeed true for v2!

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 86 +++++++++++++++++++++++++++++++++++++++++---
> net/mptcp/protocol.h | 67 ++++++++++++++++++++++++++++++++++
> net/mptcp/subflow.c  | 45 +++++++++++++++++++++++
> 3 files changed, 194 insertions(+), 4 deletions(-)

--
Mat Martineau
Intel
--===============0106326667130035782==--
