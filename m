Content-Type: multipart/mixed; boundary="===============3828381194333154000=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] mptcp: some cleanups
Date: Wed, 13 Nov 2019 18:27:52 +0100
Message-ID: <794ef70d-d47c-cdf2-c05b-7f08a0c17c1c@tessares.net>
In-Reply-To: alpine.OSX.2.21.1911111449010.7818@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 2512

--===============3828381194333154000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 11/11/2019 23:49, Mat Martineau wrote:
> =

> On Mon, 11 Nov 2019, Paolo Abeni wrote:
> =

>> This address the build issue we currently have on patch
>> "mptcp: Add key generation and token tree", plus move around some related
>> code for consistency.
>>
>> No differences in the resulting code vs current git tree.
>> The tree should build on each patch now.
>>
>> Paolo Abeni (1):
>> =C2=A01/4 mptcp: drop most of mptcp_init_sock() impl
>> =C2=A02/4 mptcp: use customary name for tcp_sock variable
>> =C2=A03/4 mptcp: init ctx->icsk_af_ops in subflow_ulp_init()
>> =C2=A04/4 mptcp: init new_ctx->icsk_af_ops() in subflow_ulp_clone()
>>
>> net/mptcp/protocol.c | 13 +------------
>> 1 file changed, 1 insertion(+), 12 deletions(-)
>>
> =

> Paolo -
> =

> The series looks good to me. Thank you.

Thank you for the patches and the review!

- cc05c38b4573: "squashed" patch 1/4 in "mptcp: Add MPTCP socket stubs"
- ecede607a17a: "Signed-off-by" + "Co-developed-by"
- 7c82356afd6f: "squashed" patch 2/4 in "mptcp: Associate MPTCP context =

with TCP socket"
- 202c54a08e5e: "Signed-off-by" + "Co-developed-by"
- 5d2b86be05bb: conflict in =

t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- c7525f68d8a7: "squashed" patch 3/4 in "mptcp: Handle MP_CAPABLE =

options for outgoing connections"
- 929b8bea462e: "Signed-off-by" + "Co-developed-by"
- 66b67498f31c: "squashed" patch 4/4 in "mptcp: Create SUBFLOW socket =

for incoming connections"
- 21a15201f708: conflict in =

t/mptcp-new-sysctl-to-control-the-activation-per-NS
- ca62776f7f0d..e225da73a467: result (empty, as expected)

Please see the different conflict resolutions.

Tests are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3828381194333154000==--
