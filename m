Content-Type: multipart/mixed; boundary="===============3407686652863341805=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Warn + crash in mptcp_sendmsg_frag()
Date: Wed, 20 Nov 2019 11:57:15 +0100
Message-ID: <11db3e0f-1ac1-ddf2-55ab-7160b1aa40f6@tessares.net>
In-Reply-To: 2d9369fdf249725607b590279f41b21ea469f24c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2612

--===============3407686652863341805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 20/11/2019 11:18, Paolo Abeni wrote:
> On Wed, 2019-11-20 at 10:51 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 18/11/2019 12:07, Paolo Abeni wrote:
>>> On Sat, 2019-11-16 at 13:59 +0100, Matthieu Baerts wrote:
>>>> On 15/11/2019 23:39, Paolo Abeni wrote:
>>>>> On Fri, 2019-11-15 at 22:06 +0100, Matthieu Baerts wrote:
>>>>>> If skb is NULL, mpext is NULL too (even if it could unlikely also be
>>>>>> even if skb is no NULL but sounds more like a bug I guess) and
>>>>>> can_collapse is False.
>>>>>
>>>>> Uhm... I don't think this is the case. mpext is NULL even when
>>>>> do_tcp_sendpages() did not collapsed the data - that is in the above
>>>>> scenario.
>>>>
>>>> I get the OOPS I got was because mpext was NULL, no?
>>>>
>>>> BUG: kernel NULL pointer dereference, address: 0000000000000014
>>>>
>>>> I didn't check with pahole but maybe linked to this instruction:
>>>>
>>>>      mpext->data_len +=3D ret;
>>>
>>> Sorry, I was not clear.
>>>
>>> yes, very likely the crash is due to mpext, but I don't think mpext is
>>> NULL because skb is NULL. I think it's NULL because there was no
>>> coalescing on skb (and thus no prior mpext in place).
>>
>> Thank you, it is clearer!
>>
>> I was not able to reproduce this bug by running the selftests for a few
>> days so I guess this bug has been fixed. Sorry for the noise!
> =

> Uhm... if the diagnosys is correct, the bug is still there. It's just
> very difficult to trigger... expecially without pktdrill ;)

Indeed, sorry.
If it is very difficult to trigger, should we simply add a return/goto =

if the WARN condition is valid? We can fix it properly later if it =

really seen somewhere?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3407686652863341805==--
