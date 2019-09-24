Content-Type: multipart/mixed; boundary="===============6223692523063058941=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: sendmsg: fix stream corrution
Date: Tue, 24 Sep 2019 11:12:48 +0200
Message-ID: <17c3ca78-ded4-45f1-a71e-37dc6323733b@tessares.net>
In-Reply-To: 793afb461fa8a3ed9a0dbcf2bef400449ae8e8cd.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1911

--===============6223692523063058941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 24/09/2019 08:55, Paolo Abeni wrote:
> On Mon, 2019-09-23 at 16:35 -0700, Mat Martineau wrote:
>> On Mon, 23 Sep 2019, Matthieu Baerts wrote:
>> On 23/09/2019 09:46, Paolo Abeni wrote:
>>>> On Fri, 2019-09-20 at 15:45 -0700, Mat Martineau wrote:
>>>>> Thanks for the detailed description. Code looks good to me and tested=
 fine
>>>>> (although failures remain, but I don't think this was intended to fix
>>>>> everything).
>>>>
>>>> I haven't seen any failure on top of this patch (plus recvmsg
>>>> refactor), could you share debug enabled dmsg and/or pcap trace for
>>>> failure you see?
>>>
>>> I also saw failed tests but everything was fixed once "recvmsg refactor"
>>> was applied too!
>>
>> I re-ran the tests with both patch sets, and all pass. Sorry for the =

>> false alarm - I had simply grabbed the export branch and applied the =

>> series.
> =

> Nice! thank you for the confirm! =

> =

> Note: I think/I'm pretty sure there is still at least another possible
> stream/data corruption pending into the current code base - see my
> previous email for the details - but so far I was unable to
> programmatically trigger it - likely pktdrill should help there.
> =

> Anyhow, given the difficulty to trigger it and amount of pending tasks,
> I don't plan to try to address such issue in the short term.

I think that's a good idea not to address such issue now but should we
log the analyse you did and the possible bug somewhere? e.g.

  https://github.com/multipath-tcp/mptcp_net-next/issues

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6223692523063058941==--
