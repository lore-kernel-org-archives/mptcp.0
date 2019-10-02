Content-Type: multipart/mixed; boundary="===============4867928579702811651=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Wed, 02 Oct 2019 23:11:36 +0200
Message-ID: <30ea2ce8-5890-0bda-f44b-82748d1dfabe@tessares.net>
In-Reply-To: alpine.OSX.2.21.1910011558310.22340@syitbare-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2003

--===============4867928579702811651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 02/10/2019 01:07, Mat Martineau wrote:
> =

> On Tue, 1 Oct 2019, Paolo Abeni wrote:
> =

>> On Tue, 2019-10-01 at 21:40 +0200, Matthieu Baerts wrote:
>>> On 01/10/2019 19:21, Mat Martineau wrote:
>>>> On Tue, 1 Oct 2019, Matthieu Baerts wrote:
>>>>
>>>>> What do we still need to do?
>>>>> - the cover letter: Mat is it still OK to do it on your side?
>>>>
>>>> Here's the cover letter draft:
>>>
>>> Thank you for having prepared the new draft!
>>
>> +1! ;)
>>
>>>> """
>>>> The MPTCP upstreaming community has prepared a net-next RFCv2 patch set
>>>> for review.
>>>>
>>>> Clone/fetch:
>>>> https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-rfcv2)
>>>>
>>>> Browse:
>>>> https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-rfcv2
>>>>
>>>> With CONFIG_MPTCP=3Dy, a socket created with IPPROTO_MPTCP will
>>>> attempt to
>>>> create an MPTCP connection but remains compatible with regular
>>>> TCP. IPPROTO_TCP socket behavior is unchanged.
>>>>
>>>> This implementation makes use of ULP between the userspace-facing MPTCP
>>>> socket and the set of in-kernel TCP sockets it controls. ULP has been
>>>> extended for use with listening sockets. skb_ext is used to carry MPTCP
>>>> metadata.
>>>>
>>>> The patch set includes self-tests to exercise MPTCP in various
>>>> connection and routing scenarios.
>>>>
>>>> We have more work planned to reach the initial feature set for merging,
>>>> notably:
>>>>
>>>> * IPv6
>>>>
>>>> * Comply with MPTCPv1 (RFC6824bis). This patch set supports only
>>>> =C2=A0 MPTCPv0 (RFC 6824 / experimental)
>>>>
>>>> * Proper MPTCP-level connection closing with DATA_FIN
>>>>
>>>> * Couple receive windows across sibling subflow TCP sockets as required
>>>> =C2=A0 by RFC 6824
>>>>
>>>> * Limit subflow ULP visibility to kernel space
>>>>
>>>> * Simple transmit scheduler that respects subflow 'backup' flags
>>>
>>> If we want to push a smaller patch upstream, will we implement all of
>>> these features?
>>>
>>> Should we also mention that in this potential first part, if OK for
>>> upstream, we would expect to have everything up to commit introducing
>>> the kselftests + a new one introducing IPv6 support?
>>
>> I think it would be a very good idea to try split all the above in 2 or
>> more slices. If there is agreement about that plan we could rephrase
>> with something alike:
>>
>> """
>> We have more work planned to reach the initial feature set notably:
>> """
>>
>> [same list as above]
>>
>> """
>> In order to simplify both the code review and the develpment process we
>> propose to split the above in smaller chunks, the first one including
>> everything presented here up to selftest, with the addition of basic
>> IPv6 support.
>> """
>>
>> WDYT?
> =

> I think that's a good way to frame it, I'd adjust it a little bit:
> =

> """
> In order to simplify both code review and the development process, we
> propose splitting the patch set in to smaller chunks. The first patch
> set for merging would include patches 1 to (TBD) and basic IPv6 support.
> """

Sounds good to me. I guess we can mention the commit introducing the
selftest support as a first idea.

We can still change the target or the order of the commits later. I
added a topic about that in the list of topics to discuss tomorrow. But
that would be good to have some feedbacks from the maintainers about
this target :)


On my side, I think our last "export" branch is ready: all the patches
we previously mentioned are merged, it is rebased on latest net-next,
tests are all good. I think it is ready to be sent! I just tagged
netdev-rfcv2 but feel free to modify it if it is not OK :)

With a bit of luck, if you have time to send it and if nothing is
missing, we might have the first feedbacks before the meeting tomorrow!
Or yeah, more likely for the week after. But we never know :)


Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4867928579702811651==--
