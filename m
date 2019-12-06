Content-Type: multipart/mixed; boundary="===============2324398839954419777=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Remove dss_flags field from struct
 mptcp_options_received
Date: Fri, 06 Dec 2019 17:59:17 +0100
Message-ID: <ac5c68d2-7a9b-2b4a-f0ce-0783a575b2e5@tessares.net>
In-Reply-To: 24d18761a7d6bcd40ee9dcaa1672d182d01cc454.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2831

--===============2324398839954419777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter, Davide,

On 06/12/2019 09:33, Davide Caratti wrote:
> On Thu, 2019-12-05 at 15:43 -0800, Peter Krystad wrote:
>> This field is used only temporarily while parsing options,
>> use a local variable instead.
>>
>> Formatted to apply directly to Implement MPTCP receive path.
>>
>> squashto: Implement MPTCP receive path
>>
>> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> =

> LGTM.
> =

> Acked-by: Davide Caratti <dcaratti(a)redhat.com>

Thank you for the patch and the review!

- 41b4b4c52051: "squashed" in "mptcp: Implement MPTCP receive path"
- d2f877593da0: conflict in =

t/mptcp-parse-and-emit-MP_CAPABLE-option-according-to-v1-spec
- 1936037fafd4: conflict in =

t/mptcp-Add-handling-of-incoming-MP_JOIN-requests
- b81566586cde..ff06521bed5e: result

Tests + export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2324398839954419777==--
