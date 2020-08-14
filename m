Content-Type: multipart/mixed; boundary="===============7816248751826334987=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2 0/3] bpf: add MPTCP subflow support
Date: Fri, 14 Aug 2020 13:14:59 -0700
Message-ID: <alpine.OSX.2.23.453.2008141308520.20141@cakenne1-mobl1.amr.corp.intel.com>
In-Reply-To: 20200811093531.27768-1-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5559

--===============7816248751826334987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 11 Aug 2020, Nicolas Rybowski wrote:

> Previously it was not possible to make a distinction between plain TCP
> sockets and MPTCP subflow sockets on the BPF_PROG_TYPE_SOCK_OPS hook.
>
> This patch series now enables a fine control of subflow sockets. In its
> current state, it allows to put different sockopt on each subflow from a
> same MPTCP connection (socket mark, TCP congestion algorithm, ...) using
> BPF programs.
>
> It should also be the basis of exposing MPTCP-specific fields through BPF.
>
> v1 -> v2:
> - update cgroup attachment code in net/mptcp/subflow.c due to additional =
#ifdef
> - revert MPTCP private structure moving in public API (previous patch 3)
> - move new BPF helper implementation in net/mptcp/bpf.c
> - add bpf.c in Makefile of net/mptcp
> - minor cosmetic changes: alignment of function's arguments on open
> 	parenthesis
>
> Nicolas Rybowski (3):
>  bpf: expose is_mptcp flag to bpf_tcp_sock
>  mptcp: attach subflow socket to parent cgroup
>  bpf: add 'bpf_mptcp_sock' structure and helper
>
> include/linux/bpf.h            | 33 ++++++++++++++++
> include/uapi/linux/bpf.h       | 14 +++++++
> kernel/bpf/verifier.c          | 30 ++++++++++++++
> net/core/filter.c              | 13 +++++-
> net/mptcp/Makefile             |  2 +
> net/mptcp/bpf.c                | 72 ++++++++++++++++++++++++++++++++++
> net/mptcp/subflow.c            | 27 +++++++++++++
> scripts/bpf_helpers_doc.py     |  2 +
> tools/include/uapi/linux/bpf.h | 14 +++++++
> 9 files changed, 206 insertions(+), 1 deletion(-)
> create mode 100644 net/mptcp/bpf.c
>
> -- =

> 2.28.0

Hi Nicolas -

Thanks for the bpf changes. Looks good to me - from what I compared to the =

tcp sock bpf code I didn't catch any problems.

--
Mat Martineau
Intel
--===============7816248751826334987==--
