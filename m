Content-Type: multipart/mixed; boundary="===============3131248284131427186=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 5th of April 2018
Date: Fri, 06 Apr 2018 09:36:56 -0700
Message-ID: <2200a65a-460b-bebe-a3f1-348a26baf004@oracle.com>
In-Reply-To: alpine.OSX.2.21.1804051533490.56457@mjmartin-mac01.sea.intel.com
X-Status: 
X-Keywords:                  
X-UID: 516

--===============3131248284131427186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/05/2018 03:39 PM, Mat Martineau wrote:
>
> On Thu, 5 Apr 2018, Christoph Paasch wrote:
>
>> Hello,
>>
>> On 05/04/18 - 15:17:59, Mat Martineau wrote:
>>>
>>> On Thu, 5 Apr 2018, Matthieu Baerts wrote:
>>>
>>>> Branches on Github (multipath-tcp/mptcp):
>>>> =C2=A0=C2=A0=C2=A0 - keep mptcp_trunk "clean", following official Linu=
x versions =E2=86=92 =

>>>> goal
>>>> is at least to reach the next LTS (4.18?). We will see what to do =

>>>> after.
>>>> =C2=A0=C2=A0=C2=A0 - we still need a "usable" version, fully functiona=
l for both the
>>>> client and server with almost the same performances while the "version
>>>> for upstream" is still in progress in parallel
>>>> =C2=A0=C2=A0=C2=A0 - next stable version should then contain Netlink P=
M, lockless
>>>> subflows, etc..
>>>> =C2=A0=C2=A0=C2=A0 - a new branch will be created (mptcp-net-next) fol=
lowing =

>>>> net-next.
>>>> =C2=A0=C2=A0=C2=A0 - all final patches shared, reviewed and accepted i=
n MPTCP =

>>>> upstream
>>>> ML would be integrated in this branch if they cannot be directly
>>>> integrated upstream in net-next
>>>
>>> To spread the workload around, I can help by keeping the new =

>>> mptcp-net-next
>>> branch merged with net-next. Christoph has a lot of experience doing =

>>> this
>>> type of merge for MPTCP but the addition of this branch shouldn't =

>>> create
>>> more work for him by default.
>>
>> Thanks, that would be great!
>>
>>> (Note that I'm not requesting push access to the github repo, I can =

>>> push to
>>> git.kernel.org and someone with permissions can transfer the commits =

>>> from
>>> there)
>>
>> Actually, back in the days, we already had an mptcp_net-next repo on the
>> github at https://github.com/multipath-tcp/mptcp_net-next.
>>
>> I will simply give you write-access to this one. Then you can remove =

>> the old
>> branches there and put there the merge with net-next.
>
> Ok, thanks. Seems like that's a good place for the upstreaming wiki too.
>
>
> Mat
Hi Mat,

May I point out we are once again moving in a different direction =

without any consensus.

When we started the effort there was an understanding that we will =

implement a *very basic* MPTCP implementation that necessarily does not =

have to follow mptcp-dev. I see no reason for this group to be concerned =

with maintaining mptcp-dev implementation. If someone wants to do it =

they can, but as their private project.=C2=A0 Please remove that as a work =

item from this list.

Our time is better spent on a technical discussion of the patch that has =

been submitted, how to make it better or work on an alternate =

implementation, etc... I am waiting for technical comments from you -- =

should I wait or should I just start addressing the comments?

The group needs to have it's own repo/website under a completely =

different account and each company should have full access to the account.

Any code placed there should be the work done by this group. Oracle is =

the only company that has put forward an improved implementation. It may =

not be the final implementation, but until there is a better =

implementation that is it.

We are working on an open source project, all discussions and decisions =

need to happen on the list. Meetings should be rare not the norm, even =

then the consensus has to be built on the list.

Shoaib



--===============3131248284131427186==--
