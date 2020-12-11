Content-Type: multipart/mixed; boundary="===============2833738731012556272=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 10th of December 2020
Date: Fri, 11 Dec 2020 08:34:40 +0100
Message-ID: <794869fd-493e-b664-4b8f-795ab088fd77@tessares.net>
In-Reply-To: 58bc15d2-a3cf-5b4b-2514-3c10f8ddbb4e@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7148

--===============2833738731012556272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 10/12/2020 23:18, Mat Martineau wrote:
> =

> On Thu, 10 Dec 2020, Matthieu Baerts wrote:
> =

>> Patches to send to netdev:
>> =C2=A0=C2=A0 - net:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - /
>>
>> =C2=A0=C2=A0 - net-next:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - See below: =E2=86=93
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Mat can send them
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Paolo will send independently the=
 SELinux patch because it =

>> will go to different tree/ML
>>
>> 58f1c48d7bbd bpf: expose is_mptcp flag to bpf_tcp_sock =E2=86=92 no
>>
>> f57f3b5446bb mptcp: attach subflow socket to parent cgroup =E2=86=92 yes
>>
>> e1a05f57895d bpf: add 'bpf_mptcp_sock' structure and helper =E2=86=92 no
>> 921a342fed73 bpf:selftests: add MPTCP test base =E2=86=92 no
>> eea7e1d5a580 bpf:selftests: add bpf_mptcp_sock() verifier tests =E2=86=
=92 no
>>
>> d27ed1c635bb mptcp: remove address when netlink flushes addrs =E2=86=92 =
yes
>> 93713a3225de selftests: mptcp: add the flush addrs testcase =E2=86=92 yes
>> 5c5e588b0e93 mptcp: use MPTCPOPT_HMAC_LEN macro =E2=86=92 yes
>> dd635e51b7e0 mptcp: hold mptcp socket before calling tcp_done =E2=86=92 =
yes
>> 99b4323a4bd4 tcp: parse mptcp options contained in reset packets =E2=86=
=92 yes
> =

> Matthieu, note that I'm modifying your "Reviewed-by" tag on this single =

> patch ("tcp: parse mptcp options...") to "Acked-by" since the affected =

> files are maintained by others.

Good catch! Thanks for the fix, I didn't want to add Reviewed-by for =

this one.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2833738731012556272==--
