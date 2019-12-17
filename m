Content-Type: multipart/mixed; boundary="===============8270834715766831604=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: Add key generation and token
 tree"
Date: Tue, 17 Dec 2019 19:37:44 +0100
Message-ID: <08acbfd8-614e-c6cb-c7e4-68500ac3fe84@tessares.net>
In-Reply-To: alpine.OSX.2.21.1912170910540.17283@shorley-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3119

--===============8270834715766831604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 17/12/2019 18:14, Mat Martineau wrote:
> On Tue, 17 Dec 2019, Paolo Abeni wrote:
> =

>> include net/tcp.h instead of linux/tcp.h
>>
>> We will switch to the latter header later in part 4, but
>> in between, and after "mptcp: new sysctl to control the activation per =

>> NS"
>> we get some sparse warning due to missing ipv6-related fuction =

>> declaration.
>>
>> Alternativelly we add an include for "net/tcp.h" in ctrl.c in patch
>> "mptcp: new sysctl to control the activation per NS".
> =

> Looks good, thanks Paolo.

Thank you for the patch and the review!

- 0f1c84751418: "squashed" in "mptcp: Add key generation and token tree"
- 3b9cd12db9d1..118ffba5ca21: result (empty, as expected, right?)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8270834715766831604==--
