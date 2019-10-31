Content-Type: multipart/mixed; boundary="===============1971361207236064210=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 24th of October 2019
Date: Thu, 31 Oct 2019 09:23:57 -0700
Message-ID: <8036AE7E-EDE2-4D61-934F-369362804E06@apple.com>
In-Reply-To: ae52d435a4f266c6eb458dfdeac511db4af9073e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2378

--===============1971361207236064210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

+Benjamin

> On Oct 30, 2019, at 7:18 AM, Paolo Abeni <pabeni(a)redhat.com> wrote:
> =

> On Fri, 2019-10-25 at 17:20 +0200, Matthieu Baerts wrote:
>> On 25/10/2019 09:53, Matthieu Baerts wrote:
>>>     - MPTCP v1 support =E2=86=92 part 2:
>>>         - Paolo started to look at the RFC to support Christoph
>>>         - Christoph will be the submitter of the patch
>>>         - *Matth*: publish a branch with mptcp.org + MPTCPv1
>> =

>> I didn't have a lot of time to look at it but you can find mptcp.org =

>> kernel with Christoph patches (and a small fix) to support MPTCPv1 on my =

>> Github account:
>> =

>>     https://github.com/matttbe/mptcp_net-next/tree/mptcp_v0.95_mptcp_v1
>>     https://github.com/matttbe/mptcp_net-next/tree/mptcp_trunk_mptcp_v1
>> =

>> I would recommend to use the branch based on mptcp_v0.95 (last upstream =

>> LTS, v4.19.55).
> =

> Looking at the code, it seams to me the abve does not implement/use
> sha256, but it still relies on sha1 hmac.

Benjamin, didn't you implement SHA-256 support? Do you still have the patch=
es?


Cheers,
Christoph

> =

> Is the above expected? or are some patches missing?
> =

> Thanks,
> =

> Paolo =

>=20

--===============1971361207236064210==--
