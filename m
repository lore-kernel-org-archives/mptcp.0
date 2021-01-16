Content-Type: multipart/mixed; boundary="===============7148261477630934517=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] selftests: mptcp: add
 command line arguments for mptcp_join.sh
Date: Sat, 16 Jan 2021 12:54:58 +0100
Message-ID: <fa416251-9029-84d9-bb86-452b4a006d9b@tessares.net>
In-Reply-To: 53806e88-91c9-24c4-db15-6eae9ccf75@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7412

--===============7148261477630934517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 15/01/2021 02:22, Mat Martineau wrote:
> On Thu, 14 Jan 2021, Geliang Tang wrote:
> =

>> Since the mptcp_join script is becoming too big, this patch split it into
>> several smaller trunks, each of them has been defined in a function as a
>> individual test group for several related testcases.

Thank you for the nice refactoring and reviews!

>> Using bash getopts function to parse command line arguments, and involk
> =

> One very minor thing, maybe Matthieu could fix "invoke" in the line =

> above when applying?

Done!

Applied in our Git repo with Mat's RvB tag and the commit message fix.

- 9e4a0d48d69c: selftests: mptcp: add command line arguments for =

mptcp_join.sh
- Results: 82d218ddd494..032c02a0c949

Tests + export are have been queued!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7148261477630934517==--
