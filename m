Content-Type: multipart/mixed; boundary="===============1886658908388815167=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] selftests: mptcp: Restore packet
 capture option in join tests
Date: Sat, 06 Mar 2021 10:16:06 +0100
Message-ID: <c8c718e3-2ec2-4f62-4f84-4d6ec7264b5c@tessares.net>
In-Reply-To: 20210303224300.95599-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8060

--===============1886658908388815167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Geliang,

On 03/03/2021 23:43, Mat Martineau wrote:
> The join self tests previously used the '-c' command line option to
> enable creation of pcap files for the tests that run, but the change to
> allow running a subset of the join tests made overlapping use of that
> option.
> =

> Restore the capture functionality with '-c' and move the syncookie test
> option to '-k'.
> =

> Fixes: 1002b89f23ea ("selftests: mptcp: add command line arguments for mp=
tcp_join.sh")
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Thank you for this patch and the review!
Just applied in our tree with Geliang's Ack+Test tag and my RvB one:

- ac06939a6d2b: selftests: mptcp: Restore packet capture option in join =

tests
- Results: 20b4296239fa..31d85a0e0974

Tests + export have been queued!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1886658908388815167==--
