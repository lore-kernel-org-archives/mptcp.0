Content-Type: multipart/mixed; boundary="===============0192104056302676407=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] squash-to: selftests: add PM netlink functional
 tests
Date: Thu, 26 Mar 2020 15:41:50 +0100
Message-ID: <29795bf5-bd16-0f2d-d733-5bca54ebb1a1@tessares.net>
In-Reply-To: 52dc8380f188a099ce85d32d3ce878e7853c2484.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4075

--===============0192104056302676407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo,

On 26/03/2020 10:32, Paolo Abeni wrote:
> On Wed, 2020-03-25 at 16:19 -0700, Mat Martineau wrote:
>> Add pm_nl_ctl to .gitignore
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>   tools/testing/selftests/net/mptcp/.gitignore | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/.gitignore b/tools/testin=
g/selftests/net/mptcp/.gitignore
>> index d72f07642738..ea13b255a99d 100644
>> --- a/tools/testing/selftests/net/mptcp/.gitignore
>> +++ b/tools/testing/selftests/net/mptcp/.gitignore
>> @@ -1,2 +1,3 @@
>>   mptcp_connect
>> +pm_nl_ctl
>>   *.pcap
> =

> LGTM, thanks!

Thank you for the patch and the review!

- 21cabc4b267c: "squashed" in "selftests: add PM netlink functional tests"
- bd9717f94812..8e8969983c72: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0192104056302676407==--
