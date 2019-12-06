Content-Type: multipart/mixed; boundary="===============4862841673811613015=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Remove flags field from struct
 mptcp_options_received
Date: Fri, 06 Dec 2019 17:59:15 +0100
Message-ID: <c6206642-22fb-676d-3cc2-b3e5450e8959@tessares.net>
In-Reply-To: 2c5c11e0a9e8d465d9a64c38d61dd411ef2b2814.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2830

--===============4862841673811613015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Davide,

On 06/12/2019 09:31, Davide Caratti wrote:
> On Thu, 2019-12-05 at 15:43 -0800, Peter Krystad wrote:
>> This field is only used temporarily while parsing options,
>> use a local variable instead.
>>
>> Also move key fields to final position and fix indents.
>>
>> Formatted to apply directly to Handle MPTCP TCP options.
>>
>> squashto: Handle MPTCP TCP options
>>
>> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
>> ---
>>   include/linux/tcp.h |  7 +++----
>>   net/mptcp/options.c | 17 ++++++++---------
>>   2 files changed, 11 insertions(+), 13 deletions(-)
> =

> LGTM,
> =

> Acked-by: Davide Caratti <dcaratti(a)redhat.com>

Thank you for the patch and the review!

- 8be6e97e540a: "squashed" in "mptcp: Handle MPTCP TCP options"
- d6eeffa1a019: conflict in t/mptcp-Implement-MPTCP-receive-path
- 504ee582ba86: conflict in t/mptcp-move-from-sha1-v0-to-sha256-v1
- 7ba44f0d910a: conflict in =

t/mptcp-parse-and-emit-MP_CAPABLE-option-according-to-v1-spec
- 3cd04070f4de: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- 7c57362bfddb..b81566586cde: result

(I also fixed a few tabs/spaces when I had the opportunity: when I had =

conflicts when new fields were introduced, not using tabs)

Tests + export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4862841673811613015==--
