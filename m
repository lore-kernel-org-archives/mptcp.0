Content-Type: multipart/mixed; boundary="===============3520200221188277535=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Tue, 01 Oct 2019 21:28:31 +0200
Message-ID: <9b24c2db-19df-048a-d45f-0669ec83eb70@tessares.net>
In-Reply-To: alpine.OSX.2.21.1910010917100.20625@syitbare-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1977

--===============3520200221188277535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 01/10/2019 18:23, Mat Martineau wrote:
> =

> On Tue, 1 Oct 2019, Florian Westphal wrote:
> =

>> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>> At the last meeting, we said it would be good to send a new RFCv2 to
>>> netdev before the next meeting while windows are closed. I guess today
>>> would be good, no?
>>
>> Thanks for bringing this up.
>>
>>> What do we still need to do?
>>> - the cover letter: Mat is it still OK to do it on your side?
>>> - any other patches to apply before this?
>>
>> I think current export branch is fine for RFCv2.
>>
>>> Here are the pending patches:
>> [..]
>>
>>> - mptcp: Remove all traces of checksum support: do we want it?
>>
>> Do you mean in general or for RFC?
>>
>> For RFC I think it depends on how much work you want to
>> get yourself into right now, as it would need to be squashed, sending
>> it as extra patch is strange.
>>
>>> - mptcp: add MIB counter infrastructure: Waiting for accept (last
>>> review)
>>> - mptcp: allow MPTCP sockets by default: can be applied
>>> - mptcp: prefix mptcp_ to exposed pm_ routines.
>>
>> These three would be nice to have for sure.
>>
>>> For the moment, I am blocked with "mptcp: Remove all traces of checksum
>>> support" but I can drop this rebase to work on other patches if others
>>> are required for the RFCv2.
>>>
>>> What's your point of view on this?
>>
>> I think merging in the checksum support remove before RFCv2 and the
>> other three (MIB, mptcp-enable-by-default, mptcp_pm_ prefix) would be
>> great.=C2=A0 I think its even ok to delay the series for a few days to g=
et
>> those in.
>>
>> Let me know if i can help.
> =

> I agree with Florian on the patch set priority and that it's ok to delay
> a little. I'll update the cover letter and send a draft.

Thank you all for having shared your point of view!

I will then apply the remaining pending patches:
- mptcp: Remove all traces of checksum support
- mptcp: allow dumping subflow context to userspace
- mptcp: add MIB counter infrastructure
- mptcp: allow MPTCP sockets by default
- mptcp: prefix mptcp_ to exposed pm_ routines.

And maybe these ones too if they are accepted before tomorrow afternoon.
- mptcp: Interim Path Manager: Waiting for accept (last review)
- mptcp_poll should not block on each subflow: Waiting for review
- selftests: prepare for mptcp ipv6 support: Waiting for accept (last
review)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3520200221188277535==--
