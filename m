Content-Type: multipart/mixed; boundary="===============2438274476800587739=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v5 0/5] Add support for v1 of ADD_ADDR option
Date: Wed, 18 Mar 2020 19:08:51 +0100
Message-ID: <170c6174-92a0-e094-4abc-6ba3a528cc8b@tessares.net>
In-Reply-To: b1ed1f0eead33327bbd5dd0bb9cb70553af145ac.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3984

--===============2438274476800587739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Paolo, Mat,

On 17/03/2020 13:16, Paolo Abeni wrote:
> On Mon, 2020-03-16 at 11:39 -0700, Peter Krystad wrote:
>> Support parsing and writing the new option format, with hmac generation
>> and validation.
>>
>> Support for echoing ADD_ADDR still to come.
>>
>> v2: check msg len in mptcp_crypto_hmac_sha().
>>      remove obsolete casts
>> v3: Rebase and split for squashing, patches ready to be applied.
>> v4: Get the first two patches of the set right
>> v5: plug hole in mptcp_options_received
>>
>> Peter Krystad (5):
>>    mptcp: Re-factor mptcp_crypto_hmac_sha()
>>    mptcp: v1 ADD_ADDR changes: options and parsing
>>    mptcp: v1 ADD_ADDR changes: add_addr_hmac_valid
>>    mptcp: v1 ADD_ADDR changes: add subflow_generate_hmac()
>>    mptcp: v1 ADD_ADDR changes: use subflow_generate_hmac()
> =

> LGMT, thanks Peter!

Thank you for the patches and the reviews!

- 0e053a193ad1: "squashed" patch 1/5 in "mptcp: Add ADD_ADDR handling"
- 7bb8b2299e7d..fc9c89129b5b: result

- 86d51566ce39: "squashed" patch 2/5 in "mptcp: Add ADD_ADDR handling"
- e51aa5c6bb39: conflict in t/mptcp-Add-path-manager-interface
- 3849afd831cb: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- fc9c89129b5b..cd5815817099: result

- 8536089ea875: "squashed" patch 3/5 in "mptcp: Add path manager interface"
- 74e707db7669: conflict in =

t/mptcp-update-per-unacked-sequence-on-pkt-reception
- cd5815817099..e49626e9422a: result

- d5c18888da46: "squashed" patch 4/5 in "mptcp: Add handling of incoming =

MP_JOIN requests"
- e49626e9422a..81d091173ed3: result

- 11524cd00823: "squashed" patch 5/5 in "mptcp: Add handling of outgoing =

MP_JOIN requests"
- 81d091173ed3..584615268acc: result

Tests + export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2438274476800587739==--
