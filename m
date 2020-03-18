Content-Type: multipart/mixed; boundary="===============1875793737667704184=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v5 0/5] Add support for v1 of ADD_ADDR option
Date: Wed, 18 Mar 2020 21:06:55 +0100
Message-ID: <3541ed99-3e12-97f4-f688-7ba2095ad535@tessares.net>
In-Reply-To: 170c6174-92a0-e094-4abc-6ba3a528cc8b@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3986

--===============1875793737667704184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 18/03/2020 19:08, Matthieu Baerts wrote:
> Hi Peter, Paolo, Mat,
> =

> On 17/03/2020 13:16, Paolo Abeni wrote:
>> On Mon, 2020-03-16 at 11:39 -0700, Peter Krystad wrote:
>>> Support parsing and writing the new option format, with hmac generation
>>> and validation.
>>>
>>> Support for echoing ADD_ADDR still to come.
>>>
>>> v2: check msg len in mptcp_crypto_hmac_sha().
>>> =C2=A0=C2=A0=C2=A0=C2=A0 remove obsolete casts
>>> v3: Rebase and split for squashing, patches ready to be applied.
>>> v4: Get the first two patches of the set right
>>> v5: plug hole in mptcp_options_received
>>>
>>> Peter Krystad (5):
>>> =C2=A0=C2=A0 mptcp: Re-factor mptcp_crypto_hmac_sha()
>>> =C2=A0=C2=A0 mptcp: v1 ADD_ADDR changes: options and parsing
>>> =C2=A0=C2=A0 mptcp: v1 ADD_ADDR changes: add_addr_hmac_valid
>>> =C2=A0=C2=A0 mptcp: v1 ADD_ADDR changes: add subflow_generate_hmac()
>>> =C2=A0=C2=A0 mptcp: v1 ADD_ADDR changes: use subflow_generate_hmac()
>>
>> LGMT, thanks Peter!
> =

> Thank you for the patches and the reviews!
> =

> - 0e053a193ad1: "squashed" patch 1/5 in "mptcp: Add ADD_ADDR handling"
> - 7bb8b2299e7d..fc9c89129b5b: result
> =

> - 86d51566ce39: "squashed" patch 2/5 in "mptcp: Add ADD_ADDR handling"
> - e51aa5c6bb39: conflict in t/mptcp-Add-path-manager-interface
> - 3849afd831cb: conflict in =

> t/mptcp-Add-handling-of-incoming-MP_JOIN-requests

There was a small typo:

- 9150e96fcf1c: mptcp: fix bad conflict resolution
- 584615268acc..643e943f5de4: result

Tests + export are in progress.

Cheers,
Matt--
Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============1875793737667704184==--
