Content-Type: multipart/mixed; boundary="===============4197356419899501261=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Brief news from LPC2019
Date: Tue, 10 Sep 2019 18:26:24 +0100
Message-ID: <alpine.OSX.2.21.1909101825080.1831@sdsadara-mobl3.ger.corp.intel.com>
In-Reply-To: 20190909232141.GB2066@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1815

--===============4197356419899501261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 10 Sep 2019, Florian Westphal wrote:

> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> Briefly:
>>  - IPv6 support will be required for the initial patch-set
>
> Shouldn't be too hard, I think we can add it once we can deal
> with multiple subflows without problems.
>
>>  - Creating MPTCP socket can be done by any app as long as we have a
>> way to block the creation of new sockets in case of issues (CGroup,
>> etc.)
>
> I assume that means the sysctl is acceptable?

Yes, and the preference in the discussion was to have it enabled by =

default.

--
Mat Martineau
Intel

--===============4197356419899501261==--
