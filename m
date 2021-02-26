Content-Type: multipart/mixed; boundary="===============5386822179741103012=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 0/3] selftests: mptcp: report more
 errors and details
Date: Fri, 26 Feb 2021 18:51:28 +0100
Message-ID: <373a011c-be9e-23ba-3e2e-267e7290963f@tessares.net>
In-Reply-To: 1df1aece-fb8e-35c-f763-23d27c87377@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7965

--===============5386822179741103012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 26/02/2021 01:46, Mat Martineau wrote:
> On Wed, 24 Feb 2021, Matthieu Baerts wrote:
> =

>> To help analysing unstable selftests, the scripts are now launching
>> 'mptcp_connect' with a timeout in order to avoid stalled tests and print
>> more details if supported (patch 1).
>> 'nstat' history is also cleared just before starting a test -- just in
>> case -- (patch 2) and more info is printed in case of errors in
>> mptcp_join.sh
>>
>> Matthieu Baerts (3):
>> =C2=A0selftests: mptcp: launch mptcp_connect with timeout
>> =C2=A0selftests: mptcp: init nstat history
>> =C2=A0selftests: mptcp: dump more info on mpjoin errors
>>
>> tools/testing/selftests/net/mptcp/diag.sh=C2=A0=C2=A0=C2=A0=C2=A0 | 38 +=
++++++++++++++---
>> .../selftests/net/mptcp/mptcp_connect.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 22 +++++++++--
>> .../testing/selftests/net/mptcp/mptcp_join.sh | 39 +++++++++++++++----
>> .../selftests/net/mptcp/simult_flows.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 13 +++++--
>> 4 files changed, 91 insertions(+), 21 deletions(-)
>>
>> -- =

>> 2.30.0
> =

> Helpful info to have in the results, thanks for adding! Please add them =

> to the export branch.
> =

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Thank you for the review!

Just added at the end of our tree with your RvB tags:

- 39ab1c2fe133: selftests: mptcp: launch mptcp_connect with timeout
- e662b9465461: selftests: mptcp: init nstat history
- 17352f3bfa05: selftests: mptcp: dump more info on mpjoin errors
- Results: 99476ba54610..11f3b41fadd1

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5386822179741103012==--
