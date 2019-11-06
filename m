Content-Type: multipart/mixed; boundary="===============7087889795289684126=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Use sk_family field in the mptcp_sock for
 address family.
Date: Wed, 06 Nov 2019 21:34:19 +0100
Message-ID: <99207e56-9b14-8fba-6e5a-67a3f26a2cf7@tessares.net>
In-Reply-To: alpine.OSX.2.21.1911051344520.27697@cavianch-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2429

--===============7087889795289684126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo, Mat,

On 05/11/2019 22:57, Mat Martineau wrote:
> =

> On Tue, 5 Nov 2019, Paolo Abeni wrote:
> =

>> On Mon, 2019-11-04 at 21:26 -0800, Peter Krystad wrote:
>>> It was not necessary to add a family field to mptcp_sock as it is
>>> a wrapper around a struct sock, and sk_family is set correctly when
>>> the msk is created as a result of a socket() call.
>>>
>>> squashto: Associate MPTCP context with TCP socket
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp: Implement=
 basic path manager
>>>
>>> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
>>
>> LGTM, nice cleanup, thanks!
>>
>> It's unclear to me if I should update patchwork status, too ("Under
>> review"? would that help?)
>>
> =

> Looks good to me, too.

Thank you for the patch and the review!

- 7c4096766c23: "squashed" part 1 in "mptcp: Associate MPTCP context =

with TCP socket"
- already has the signed-off
- f9b323be35cf: conflict in =

t/mptcp-Handle-MP_CAPABLE-options-for-outgoing-connections
- ad05f6b594bc: conflict in t/mptcp-Add-key-generation-and-token-tree
- 94ddaeb75bd3: conflict in t/mptcp-Implement-MPTCP-receive-path
- d1db9d0195b3: conflict in =

t/mptcp-Add-handling-of-outgoing-MP_JOIN-requests
- 55b5be5a8eea: conflict in =

t/mptcp-implement-and-use-MPTCP-level-retransmission
- b8de8670bd8c: "squashed" part 2 in "mptcp: Implement basic path manager"
- 3b6112deb337..1b8d767c5872: result

> For handling patchwork status, I went to the upcoming meeting page to =

> create a proposal - and found that Matthieu has already done it :)

:)
Yes we can talk about that tomorrow.

I will apply the other patches tomorrow.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7087889795289684126==--
