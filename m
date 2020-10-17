Content-Type: multipart/mixed; boundary="===============1050887428412961075=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2] selftests: mptcp: add link failure
 test case
Date: Sat, 17 Oct 2020 09:31:30 +0200
Message-ID: <f41520c0-1cbb-8251-22d7-96b36643095f@tessares.net>
In-Reply-To: d44679b6-8aa0-a1f9-19b9-4713495de53@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6338

--===============1050887428412961075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 15/10/2020 02:09, Mat Martineau wrote:
> On Fri, 9 Oct 2020, Florian Westphal wrote:
> =

>> Add a test case where a link fails with multiple subflows.
>> The expectation is that MPTCP will transmit any data that
>> could not be delivered via the failed link on another subflow.
>>
>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
>> ---
>> v2: rebase and add 'link loss' to test-case comment.
>> =C2=A0=C2=A0=C2=A0 make sure we exit with 1 if file was corrupt or serve=
r/client
>> =C2=A0=C2=A0=C2=A0 exited nonzero.
>>
>> .../testing/selftests/net/mptcp/mptcp_join.sh | 135 +++++++++++++-----
>> 1 file changed, 97 insertions(+), 38 deletions(-)
>>
> =

> Thanks for the v2, looks good for the export branch.

Thank you for the patch and the review!

Just applied with Mat's Reviewed-by.

- 36221baa8712: selftests: mptcp: add link failure test case
- Results: 3fd01a5ab17b..0e70ef7be280

Tests and export will be started soon!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1050887428412961075==--
