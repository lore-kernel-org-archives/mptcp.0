Content-Type: multipart/mixed; boundary="===============5726923634294940881=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP upstreaming introduction
Date: Tue, 18 Apr 2017 10:59:28 -0700
Message-ID: <alpine.OSX.2.21.1704181045580.3492@sehampsh-mobl1.amr.corp.intel.com>
In-Reply-To: 20170417142945.GH11821@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 4

--===============5726923634294940881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Christoph,

On Mon, 17 Apr 2017, Christoph Paasch wrote:

> Hello Mat,
>
> On 11/04/17 - 15:52:06, Mat Martineau wrote:
>>
>> Hi Christoph,
>>
>> Rao and I talked with David Miller and Eric Dumazet. They aren't
>> enthusiastic about MPTCP from a protocol perpective, and pointed to the
>> example of kcm as something that builds on top of multiple TCP connectio=
ns
>> rather than modifying TCP itself. I think they're a little skeptical that
>> there's a committment to put in the necessary effort to upstream.
>>
>> A few specific points of our discussions:
>>
>> * Intrusive changes to TCP are not acceptable, the code is already compl=
ex
>> and they don't want to introduce bugs or create additional maintenance
>> burden. Given the need to tie in to TCP for option parsing (and other
>> changed behaviors), they're willing to look at adding hooks - but of cou=
rse
>> reserved judgment until there are actual patches to look at.
>>
>> * Related to that, skb size cannot increase.
>>
>> * Regular TCP connections should remain the default and should work like
>> they do now.
>
> That's good info. So we will have to make it opt-in through a socket-opti=
on
> or even create a new socket-type.

I experimented with two approaches: AF_MPTCP and IPPROTO_MPTCP (the latter =

using either AF_INET or AF_INET6). IPPROTO_MPTCP worked a lot better with =

existing code (especially Python's socket module!). I'll tidy up the patch =

set and post it.

>>
>> * Expect the review process to take a while.
>>
>> These points are what drives the goals I listed below. Identifying the r=
ight
>> (limited) set of hooks in to the TCP code is going to be an important ea=
rly
>> step.
>
> sounds great! Do you have a public git repo where the development happens?
> Might be good to set this up.

My plan is to share patches on this list, and I will publish a mptcp =

branch on my git.kernel.org repo:

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/

Since we'll be posting patches to netdev, I think it will work well to use =

the typical kernel mailing list 'git send-email' workflow.

--
Mat Martineau
Intel OTC


--===============5726923634294940881==--
