Content-Type: multipart/mixed; boundary="===============1151122641405621868=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2 0/3] bpf: add MPTCP subflow support
Date: Mon, 17 Aug 2020 10:49:23 +0200
Message-ID: <058df5ab-0027-77cf-579e-2f3a4403b81f@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2008141308520.20141@cakenne1-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5566

--===============1151122641405621868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas, Mat,

On 14/08/2020 22:14, Mat Martineau wrote:
> =

> On Tue, 11 Aug 2020, Nicolas Rybowski wrote:
> =

>> Previously it was not possible to make a distinction between plain TCP
>> sockets and MPTCP subflow sockets on the BPF_PROG_TYPE_SOCK_OPS hook.
>>
>> This patch series now enables a fine control of subflow sockets. In its
>> current state, it allows to put different sockopt on each subflow from a
>> same MPTCP connection (socket mark, TCP congestion algorithm, ...) using
>> BPF programs.
>>
>> It should also be the basis of exposing MPTCP-specific fields through =

>> BPF.
>>
>> v1 -> v2:
>> - update cgroup attachment code in net/mptcp/subflow.c due to =

>> additional #ifdef
>> - revert MPTCP private structure moving in public API (previous patch 3)
>> - move new BPF helper implementation in net/mptcp/bpf.c
>> - add bpf.c in Makefile of net/mptcp
>> - minor cosmetic changes: alignment of function's arguments on open
>> =C2=A0=C2=A0=C2=A0=C2=A0parenthesis
>>
>> Nicolas Rybowski (3):
>> =C2=A0bpf: expose is_mptcp flag to bpf_tcp_sock
>> =C2=A0mptcp: attach subflow socket to parent cgroup
>> =C2=A0bpf: add 'bpf_mptcp_sock' structure and helper
>>
>> include/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 33 ++++++++++++++++
>> include/uapi/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 +++++++
>> kernel/bpf/verifier.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 30 ++++++++++++++
>> net/core/filter.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++++-
>> net/mptcp/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
>> net/mptcp/bpf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 72 ++++++++++++++++++++++++++++++++++
>> net/mptcp/subflow.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 27 +++++++++++++
>> scripts/bpf_helpers_doc.py=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
>> tools/include/uapi/linux/bpf.h | 14 +++++++
>> 9 files changed, 206 insertions(+), 1 deletion(-)
>> create mode 100644 net/mptcp/bpf.c
>>
>> -- =

>> 2.28.0
> =

> Hi Nicolas -
> =

> Thanks for the bpf changes. Looks good to me - from what I compared to =

> the tcp sock bpf code I didn't catch any problems.

Thank you for the patches and the reviews!

I just added these patches in the export branch with Mat's Acked-by =

(patch 1/3 & 3/3) and Reviewed-by (patch 2/3) tags.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1151122641405621868==--
