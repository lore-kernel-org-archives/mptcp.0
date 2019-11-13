Content-Type: multipart/mixed; boundary="===============3579197903103077161=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] mptcp: some cleanups
Date: Wed, 13 Nov 2019 18:53:22 +0100
Message-ID: <9b8d60ea-bfc5-0bdf-ab76-84e637eac8d3@tessares.net>
In-Reply-To: 794ef70d-d47c-cdf2-c05b-7f08a0c17c1c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2515

--===============3579197903103077161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 13/11/2019 18:27, Matthieu Baerts wrote:
> Hi Paolo, Mat,
> =

> On 11/11/2019 23:49, Mat Martineau wrote:
>>
>> On Mon, 11 Nov 2019, Paolo Abeni wrote:
>>
>>> This address the build issue we currently have on patch
>>> "mptcp: Add key generation and token tree", plus move around some =

>>> related
>>> code for consistency.
>>>
>>> No differences in the resulting code vs current git tree.
>>> The tree should build on each patch now.
>>>
>>> Paolo Abeni (1):
>>> =C2=A01/4 mptcp: drop most of mptcp_init_sock() impl
>>> =C2=A02/4 mptcp: use customary name for tcp_sock variable
>>> =C2=A03/4 mptcp: init ctx->icsk_af_ops in subflow_ulp_init()
>>> =C2=A04/4 mptcp: init new_ctx->icsk_af_ops() in subflow_ulp_clone()
>>>
>>> net/mptcp/protocol.c | 13 +------------
>>> 1 file changed, 1 insertion(+), 12 deletions(-)
>>>
>>
>> Paolo -
>>
>> The series looks good to me. Thank you.
> =

> Thank you for the patches and the review!
> =

> - cc05c38b4573: "squashed" patch 1/4 in "mptcp: Add MPTCP socket stubs"
> - ecede607a17a: "Signed-off-by" + "Co-developed-by"
> - 7c82356afd6f: "squashed" patch 2/4 in "mptcp: Associate MPTCP context =

> with TCP socket"
> - 202c54a08e5e: "Signed-off-by" + "Co-developed-by"
> - 5d2b86be05bb: conflict in =

> t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
> - c7525f68d8a7: "squashed" patch 3/4 in "mptcp: Handle MP_CAPABLE =

> options for outgoing connections"
> - 929b8bea462e: "Signed-off-by" + "Co-developed-by"
> - 66b67498f31c: "squashed" patch 4/4 in "mptcp: Create SUBFLOW socket =

> for incoming connections"
> - 21a15201f708: conflict in =

> t/mptcp-new-sysctl-to-control-the-activation-per-NS
> - ca62776f7f0d..e225da73a467: result (empty, as expected)
> =

> Please see the different conflict resolutions.

I missed something when resolving conflicts. Here are the fixes:

- a52b7bb7b026: fix in =

t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- f3e04ebb0c5a..023d3b14d1b5: still empty, as expected!

I just relaunched the tests.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3579197903103077161==--
