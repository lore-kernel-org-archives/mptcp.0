Content-Type: multipart/mixed; boundary="===============4381269351248815247=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp:diag: prefix exposed items
Date: Mon, 07 Oct 2019 10:48:58 +0200
Message-ID: <a524ea17-ade1-970d-8f2f-08467e21fba2@tessares.net>
In-Reply-To: e97f7c8e3d5cde18b978f1db9a55bfb576389189.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2028

--===============4381269351248815247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 07/10/2019 09:25, Davide Caratti wrote:
> On Sat, 2019-10-05 at 10:49 +0200, Matthieu Baerts wrote:
>> To conform with the rest.
>>
>> And only exposed one init function for diag.c
>>
>> Suggested-by: Davide Caratti <dcaratti(a)redhat.com>
>> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>>     To be squashed in "mptcp: allow dumping subflow context to userspace"
>>     v2:
>>      - MPTCP_SUBFLOW_FLAGS_ -> MPTCP_SUBFLOW_FLAG_ (Davide)
>>      - only exposed a new function: mptcp_diag_subflow_init (Davide, Pao=
lo)
>>
>>  include/uapi/linux/mptcp.h | 18 +++++++++---------
>>  net/mptcp/diag.c           | 28 +++++++++++++++++-----------
>>  net/mptcp/protocol.h       |  3 +--
>>  net/mptcp/subflow.c        |  4 ++--
>>  4 files changed, 29 insertions(+), 24 deletions(-)
>>
> =

> hello Matthieu,
> =

> LGTM, thanks for following up!

Thank you for the review!

- 70c59362830a: "squashed" in "mptcp: allow dumping subflow context to
userspace"
- 378418230fca: "signed-off-by", I hope you don't mind
- 331023afb717..ed7ca199c905: result

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4381269351248815247==--
