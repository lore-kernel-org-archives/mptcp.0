Content-Type: multipart/mixed; boundary="===============4994564131448407277=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH net 1/2] mptcp: Consistently use
 READ_ONCE/WRITE_ONCE with msk->ack_seq
Date: Wed, 30 Sep 2020 21:35:44 +0200
Message-ID: <ff6aee9c-d20e-3170-6099-04842b6c8f8e@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2009301029410.29927@cindukum-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6119

--===============4994564131448407277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 30/09/2020 19:33, Mat Martineau wrote:
> On Wed, 30 Sep 2020, Matthieu Baerts wrote:
> =

>> Hi Mat,
>>
>> On 30/09/2020 12:31, Matthieu Baerts wrote:
>>> Hi Mat,
>>>
>>> On 30/09/2020 12:19, Matthieu Baerts wrote:
>>>> Hi Mat,
>>>>
>>>> On 26/09/2020 02:24, Mat Martineau wrote:
>>>>> The msk->ack_seq value is sometimes read without the msk lock held, so
>>>>> make proper use of READ_ONCE and WRITE_ONCE.
>>>>>
>>>>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>>>>> ---
>>>>>
>>>>> This does create some merge conflicts with net-next - what's the best
>>>>> way to handle that?
>>>>
>>>> Should we send to netdev ML about how we resolve the conflicts?
>>>
>>> (...)
>>>
>>>> Patch 2:
>>>> - subflow.c: we don't use the returned value of =

>>>> mptcp_update_rcv_data_fin() in net-next
>>>
>>> I just noticed your commit ef59b1953c26 ("mptcp: Wake up MPTCP worker =

>>> when DATA_FIN found on a TCP FIN packet") is not on net-next yet.
>>>
>>> So we do use the returned value if I put your two new patches on top =

>>> of ef59b1953c26!
>>>
>>> The "export" branch is going to be updated soon.
>>
>> I also just pushed a new branch: merge_net_net-next_20200930
>>
>> You can have a look at bac51c27a3c9 ("Merge remote-tracking branch =

>> 'net' into net-next") for the merge resolution. We have the =

>> explanation with 'git show' but I don't know if we can have the same =

>> view on GitHub.
>>
>> This link is not helpful :)
>>
>> https://github.com/multipath-tcp/mptcp_net-next/commit/merge_net_net-nex=
t_20200930 =

>>
>>
> =

> Hi Matthieu -
> =

> I mentioned my recommended merge resolution in the cover letter for the =

> latest -net changes:
> =

> """
> This does introduce two merge conflicts with net-next, but both have
> straightforward resolution. Patch 1 modifies a line that got removed in
> net-next so the modification can be dropped when merging. Patch 2 will
> require a trivial conflict resolution for a modified function
> declaration.
> """

Indeed, my bad, I missed that!

> Rather than update __mptcp_move_skb() as part of the merge commit, I =

> think it would be better to just drop the change during the merge and =

> send a separate patch to net-next to add the WRITE_ONCE() to =

> __mptcp_move_skb().

Indeed, certainly easier for the maintainer. We will have to remember =

fixing this but I should keep track of this particular modification in =

the "export" branch anyway.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4994564131448407277==--
