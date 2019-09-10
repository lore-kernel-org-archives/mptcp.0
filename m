Content-Type: multipart/mixed; boundary="===============0588254822884340458=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Brief news from LPC2019
Date: Tue, 10 Sep 2019 18:34:50 +0100
Message-ID: <alpine.OSX.2.21.1909101829360.1831@sdsadara-mobl3.ger.corp.intel.com>
In-Reply-To: CAKuKrBk-u-ReHFpd3vtfqdoF1O6f73OwuCZCwB4YjF8H8-td6w@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 1816

--===============0588254822884340458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Sep 2019, Matthieu Baerts wrote:

> Hi Florian,
>
> On Tue, Sep 10, 2019 at 12:21 AM Florian Westphal <fw(a)strlen.de> wrote:
>>
>> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>>> Briefly:
>>>  - IPv6 support will be required for the initial patch-set
>>
>> Shouldn't be too hard, I think we can add it once we can deal
>> with multiple subflows without problems.
>
> Indeed, should not be a problem and better to work on other important
> topics for this initial patch set first.
>
>>>  - Creating MPTCP socket can be done by any app as long as we have a
>>> way to block the creation of new sockets in case of issues (CGroup,
>>> etc.)
>>
>> I assume that means the sysctl is acceptable?
>
> To be honest, I will have to refresh my mind by watching the recording
> because a few different people jumped into the discussion :)
> - It should not be disabled by default (if compiled) because the goal
> is to have people testing it: no sysctl needed
> - But we should be able to block the creation of new MPTCP sockets in
> case of problem: yes for the sysctl but enabled by default
> - But for Android, each app is launched in a netns and for them the
> sysctl is not a good protection
> - But there are others ways to block it: cgroup and (...), I don't
> remember the second way.

Looks like we were replying at the same time. Thanks for the detail, =

Matthieu.

The second way was using security frameworks (like SELinux) to block =

MPTCP. Another point someone made was that it's also important to pay =

careful attention to the MPTCP code in the receive path that might still =

be accessed when MPTCP is supposed to be turned off.

>
> So I don't know what we should do with this sysctl :-D
> If it is there, it should be "on" by default.
>

--
Mat Martineau
Intel

--===============0588254822884340458==--
