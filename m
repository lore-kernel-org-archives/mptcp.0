Content-Type: multipart/mixed; boundary="===============6907147494202163238=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Tue, 01 Oct 2019 09:23:00 -0700
Message-ID: <alpine.OSX.2.21.1910010917100.20625@syitbare-mobl.amr.corp.intel.com>
In-Reply-To: 20191001150035.GE14819@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1958

--===============6907147494202163238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 1 Oct 2019, Florian Westphal wrote:

> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> At the last meeting, we said it would be good to send a new RFCv2 to
>> netdev before the next meeting while windows are closed. I guess today
>> would be good, no?
>
> Thanks for bringing this up.
>
>> What do we still need to do?
>> - the cover letter: Mat is it still OK to do it on your side?
>> - any other patches to apply before this?
>
> I think current export branch is fine for RFCv2.
>
>> Here are the pending patches:
> [..]
>
>> - mptcp: Remove all traces of checksum support: do we want it?
>
> Do you mean in general or for RFC?
>
> For RFC I think it depends on how much work you want to
> get yourself into right now, as it would need to be squashed, sending
> it as extra patch is strange.
>
>> - mptcp: add MIB counter infrastructure: Waiting for accept (last review)
>> - mptcp: allow MPTCP sockets by default: can be applied
>> - mptcp: prefix mptcp_ to exposed pm_ routines.
>
> These three would be nice to have for sure.
>
>> For the moment, I am blocked with "mptcp: Remove all traces of checksum
>> support" but I can drop this rebase to work on other patches if others
>> are required for the RFCv2.
>>
>> What's your point of view on this?
>
> I think merging in the checksum support remove before RFCv2 and the
> other three (MIB, mptcp-enable-by-default, mptcp_pm_ prefix) would be
> great.  I think its even ok to delay the series for a few days to get
> those in.
>
> Let me know if i can help.

I agree with Florian on the patch set priority and that it's ok to delay a =

little. I'll update the cover letter and send a draft.

--
Mat Martineau
Intel
--===============6907147494202163238==--
