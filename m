Content-Type: multipart/mixed; boundary="===============7965432513373884851=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 0/3] SYNRX: MPTCP -> MPTCP: expect x,
 got y
Date: Wed, 10 Feb 2021 20:21:43 +0100
Message-ID: <139ebc53-21fb-cd3f-c970-03bb24138cc3@tessares.net>
In-Reply-To: af402368-90d2-c58c-62d0-d2e7ae736cd6@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7753

--===============7965432513373884851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 10/02/2021 01:39, Mat Martineau wrote:
> =

> On Mon, 8 Feb 2021, Matthieu Baerts wrote:
> =

>> While working on issue #148, I also found a small typo: SYN info were
>> printed instead of ACK ones, see patch 1/3.
>>
>> Then I put everything on one line and remove duplicated code, see patch
>> 2/3.
>>
>> The last patch marks the test as failed if we found less MPC SYN/3rd
>> ACK than expected. This will close:
>>
>> =C2=A0https://github.com/multipath-tcp/mptcp_net-next/issues/148
>>
>> But at the end, just some small Bash modifications, nothing important
>> ;-)
>>
>> Matthieu Baerts (3):
>> =C2=A0selftests: mptcp: fix ACKRX debug message
>> =C2=A0selftests: mptcp: display warnings on one line
>> =C2=A0selftests: mptcp: fail if not enough SYN/3rd ACK
>>
>> .../selftests/net/mptcp/mptcp_connect.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 80 +++++++++++++------
>> 1 file changed, 54 insertions(+), 26 deletions(-)
>>
>> -- =

>> 2.29.2
> =

> Series looks good to me, had to modify mptcp_connect.sh to force some =

> error output on my VM. Thanks Matthieu.
> =

> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Thank you for your reviews and validations!

Just applied in our tree with your RvB tag:

- b628da33c6e3: selftests: mptcp: fix ACKRX debug message
- 41d182f0810b: selftests: mptcp: display warnings on one line
- f29144f39ccc: selftests: mptcp: fail if not enough SYN/3rd ACK
- Results: 36c9c494faa9..aaf3af15da09

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7965432513373884851==--
