Content-Type: multipart/mixed; boundary="===============3667910429439229938=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: do not warn when replacing an identical
 mapping.
Date: Thu, 06 Jun 2019 14:05:23 +0200
Message-ID: <84993dc1-86dc-7126-3f3f-d0c732fd5f0a@tessares.net>
In-Reply-To: alpine.OSX.2.21.1906051426500.2787@dgenex-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1305

--===============3667910429439229938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 05/06/2019 23:31, Mat Martineau wrote:
> =

> On Wed, 5 Jun 2019, Paolo Abeni wrote:
> =

>> Said event can happen due GSO/TSO, do not warn then.
>>
>> Fixes: af798ed636e2 ("mptcp: Implement MPTCP receive path")
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> -- =

>> Notes:
>> - I'm ok squashing this commit into the fixed one
>> - I can't reproduce the warn locally, need someone else to verify
>> =C2=A0this one
> =

> This patch eliminates the warnings for me. I think it's good to merge
> (and squash) for now.
> =

> Thanks for the fix, Paolo.

Thank you again for the patch and thank you for the review.

I just added it in our repo:
- 5c7c220aae31: "squash"
- 54cae76d4cfc: the Signed-Off was already there
- da94dd36fcab..78190143f7fb: result

Builds are OK, tests are OK, no more warnings!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3667910429439229938==--
