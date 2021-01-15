Content-Type: multipart/mixed; boundary="===============7206608238438449895=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v6 0/5] add IPv4-mapped address support
Date: Fri, 15 Jan 2021 11:26:08 +0100
Message-ID: <6f06de9b-ed79-f313-1d6f-c969a4cd6752@tessares.net>
In-Reply-To: d1c3335-9044-fa6e-f6db-ec5bed83db7@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7397

--===============7206608238438449895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 15/01/2021 00:13, Mat Martineau wrote:
> On Thu, 14 Jan 2021, Matthieu Baerts wrote:
> =

>> This patchset adds IPv4-mapped address support and testcases.
>>
>> v6:
>> - Extract the modifications to reduce the scope of the 'remote' =

>> variable in a
>> =C2=A0 dedicated commit (patch 3/5)
>>
> =

> Looks good for the export branch, thanks!

Thank you for the patches and the reviews!

- 862e346ac91b: mptcp: support MPJoin with IPv4 mapped in v6 sk
- eabdb734a318: mptcp: pm nl: support IPv4 mapped in v6 addresses
- 15a8c93bdbdd: mptcp: pm nl: reduce variable scope
- c7617c0b8fe1: selftests: mptcp: add IPv4-mapped IPv6 testcases
- 2a5a6b08ea4e: selftests: increase timeout to 10 min
- Results: 9373e4da47c6..5706f3e3dffa

Tests + export are in progress!
Hopefully, we will have a green build this time!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7206608238438449895==--
