Content-Type: multipart/mixed; boundary="===============0329587326315632553=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] squash-to: mptcp: Implement MPTCP receive path
Date: Fri, 14 Jun 2019 16:23:55 +0200
Message-ID: <8afbd6df-78cd-ba9c-326f-3cae255371fb@tessares.net>
In-Reply-To: 8965f3cb-80ad-e6d4-ad17-d74e59829fca@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1377

--===============0329587326315632553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 14/06/2019 15:51, Matthieu Baerts wrote:
> Hi Paolo,
> =

> Thank you for the quick answer!
> =

> On 14/06/2019 15:45, Paolo Abeni wrote:
>> Hi,
>>
>> On Fri, 2019-06-14 at 15:37 +0200, Matthieu Baerts wrote:
>>> Note that I just ran the tests after having applied the patch and
>>> without KASAN and PROVE_LOCKING kconfig, I got this error:
>>
>> That is quite unexpected, the patch should not impact functionality in
>> any way.
>>
>>> 00:12:41.843 # ns2  MPTCP -> ns2  (10.0.2.1:10025) TCP  	[ OK ]
>>> 00:12:42.874 # ns2  TCP   -> ns2  (10.0.2.1:10026) MPTCP	[ OK ]
>>> 00:12:43.907 # ns2  MPTCP -> ns3  (10.0.2.2:10027) MPTCP	main_loop_s:
>>> timed out
>>> 00:13:14.949 # copyfd_io: poll timed out (events: POLLIN 1, POLLOUT 4)
>>> 00:13:14.950 # [ FAIL ] client exit code 2, server 2
>>> 00:13:14.950 # \nnetns ns3 socket stat for 10027:
>>> 00:13:14.970 # State     Recv-Q   Send-Q        Local Address:Port
>>>   Peer Address:Port
>>> 00:13:14.970 # SYN-RECV  0        0                  10.0.2.2:10027
>>>       10.0.2.1:47614    timer:(on,1.550ms,4) cwnd:2 retrans:4/0 reorder=
ing:0
>>> 00:13:14.972 # \nnetns ns2 socket stat for 10027:
>>> 00:13:14.982 # State       Recv-Q   Send-Q      Local Address:Port
>>>   Peer Address:Port
>>> 00:13:14.983 # FIN-WAIT-1  0        56569            10.0.2.1:47614
>>>       10.0.2.2:10027    timer:(on,22sec,7) rto:25.72 cwnd:1 ssthresh:7
>>> retrans:7/0 reordering:0
>>> 00:13:14.987 # ns2  MPTCP -> ns3  (10.0.3.2:10028) MPTCP	[ OK ]
>>> 00:13:16.020 # ns2  MPTCP -> ns3  (10.0.3.2:10029) TCP  	[ OK ]
>>>
>>> I *think* it looks the same as the one I reported a few days ago.
>>>
>>> https://lists.01.org/pipermail/mptcp/2019-June/001278.html
>>
>> Indeed it looks similar...
>>
>>> Is it not related to what Florian fixed in his last patch? e9d3a8a4a460
>>> (mptcp: selftests: increase timeout and return error on ping failure)
>>>
>>> https://lists.01.org/pipermail/mptcp/2019-June/001286.html
>>
>> ... and you should not see that on top of Florian's patch. Just to
>> double check: is your testbed up2date? (e.g. the script includes
>> Florian's patch).
> =

> Yes it is up to date: I used a ci job to re-create the "export" branch
> (after having checked that the compilation was OK with and without
> CONFIG_MPTCP) and then launch the tests from the "export" branch.
> =

> So I was on the tag export/20190614T131503 and the patch is included:
> =

> https://github.com/multipath-tcp/mptcp_net-next/commit/56c6c088766c04549e=
eef30ea86200350486ee26#diff-c550c086600c85e4bbd654545d2d9f8eR222
> =

> I am going to run new tests in a few minutes. I will check if I still
> have the issue or not.

Tests are now good with the new export branch including the last 4
patches from Peter.

We might suffer from the same bug as before which was also not happening
all the time.

Cheers,
Matt

> Cheers,
> Matt
> =

>> Cheers,
>>
>> Paolo
>>
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0329587326315632553==--
