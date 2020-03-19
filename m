Content-Type: multipart/mixed; boundary="===============3693005416197062743=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/2] mptcp: fix compilation error without IPV6
Date: Thu, 19 Mar 2020 18:38:25 +0100
Message-ID: <77b34c3a-6ec1-0ec7-3124-2a87789cd371@tessares.net>
In-Reply-To: dcc47c28e0e3ea621774c0d3eaf999ed4171e1d4.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3992

--===============3693005416197062743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 19/03/2020 10:24, Paolo Abeni wrote:
> Hi,
> =

> On Thu, 2020-03-19 at 10:05 +0100, Matthieu Baerts wrote:
>>    net/mptcp/options.c: In function =E2=80=98add_addr_hmac_valid=E2=80=
=99:
>>    net/mptcp/options.c:796:39: error: =E2=80=98struct mptcp_options_rece=
ived=E2=80=99 has no member named =E2=80=98addr6=E2=80=99; did you mean =E2=
=80=98addr=E2=80=99?
>>      796 |             mp_opt->addr_id, &mp_opt->addr6);
>>          |                                       ^~~~~
>>          |                                       addr
>>
>> Fixes: 8536089ea875 (mptcp: v1 ADD_ADDR changes: add_addr_hmac_valid)
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

(...)

> Both patches LGTM, thanks!
Thank you for the review!

- cc2ee05dc8b7: "squashed" patch 2/2 in "mptcp: Add ADD_ADDR handling"
- 9bd3412b5201: "squashed" in "mptcp: Add path manager interface"
- 643e943f5de4..ca158067259a: result

Tests + export will be launched soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3693005416197062743==--
