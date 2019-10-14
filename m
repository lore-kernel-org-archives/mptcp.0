Content-Type: multipart/mixed; boundary="===============3714839479847202825=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 0/2] mptcp: disallow setting the MPTCP ULP from
 userspace
Date: Mon, 14 Oct 2019 19:22:26 +0200
Message-ID: <9714682a-e757-d674-a0f9-201a5d2325b0@tessares.net>
In-Reply-To: 522a00033466da18009813089ad908f86fdf0466.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2113

--===============3714839479847202825==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Paolo,

On 14/10/2019 16:56, Paolo Abeni wrote:
> On Mon, 2019-10-14 at 16:46 +0200, Davide Caratti wrote:
>> with this series we make
>>
>> setscokopt(..., IPPROTO_TCP, TCP_ULP, "mptcp", sizeof("mptcp"));
>>
>> return -1 and set errno to -EOPNOPSUPPORT.
>>
>> this allows attaching MPTCP ULP only to a TCP socket that has been
>> created through sock_create_kern().
>>
>> - Patch 1/2 lets subflow_init() fail with -EOPNOTSUPPORT in case users
>>    try to setsockopt(..., TCP_ULP) on a TCP socket that has been created
>>    by a userspace program. I suggest squashing this patch in "mptcp:
>>    Associate MPTCP context with TCP socket".
>> - Patch 2/2 includes kselftest code. I suggest squashing it with "mptcp:
>>    add basic kselftest for mptcp".
>>
>> Changes since v1:
>>   - don't redirect the selftest output to /dev/null
>>   - test output depends on the value of 'errno', to avoid false negative
>>     in case kernel is built without CONFIG_MPTCP
>>
>> Davide Caratti (2):
>>    mptcp: subflow: disallow setsockopt(... TCP_ULP, "mptcp")
>>    selftests: test setsockopt(..., TCP_ULP, "mptcp", ...)
>>
>>   net/mptcp/subflow.c                           |  7 +++
>>   .../selftests/net/mptcp/mptcp_connect.c       | 52 +++++++++++++++++--
>>   .../selftests/net/mptcp/mptcp_connect.sh      | 19 +++++++
>>   3 files changed, 75 insertions(+), 3 deletions(-)
> =

> The patches LGTM, thanks Davide!

Thank you for the patches and the review!

- 87df9026e7cc: "squashed" the first patch in "mptcp: Associate MPTCP =

context with TCP socket"
- 8c907c48da5c: "Signed-off-by" + "Co-developed-by"
- a8a756ed4dbc: conflict in =

t/mptcp-Create-SUBFLOW-socket-for-incoming-connections
- 2057bcf6bf5e: "squashed" the second patch in "mptcp: add basic =

kselftest for mptcp"
- be20e32cf37d..c7557e1f213a: result

Tests are still OK!

Cheers,
Matt

> =

> /P
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3714839479847202825==--
