Content-Type: multipart/mixed; boundary="===============4337570847701566672=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: wmem accounting and nonblocking io
 support
Date: Wed, 20 Nov 2019 21:10:08 +0100
Message-ID: <7a090e24-6c69-065a-1575-6dcf3ff8bfc6@tessares.net>
In-Reply-To: 20191120161252.GE20235@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2631

--===============4337570847701566672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 20/11/2019 17:12, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> Great, I am then going to:
>>
>> - apply the two series that are waiting to be applied
>> - then move these 3 commits after "mptcp: add basic kselftest for mptcp":
>>
>>    mptcp: Add handling of incoming MP_JOIN requests
>>    mptcp: Add ADD_ADDR handling
>>    mptcp: Add path manager interface
>>
>> - then can I add Florian' series at the end?
> =

> Works for me.  If you like you can also ping me once
> you're done with the pending series and I can send you a pull request
> with my patches applied on top.
> =

> Whatever makes your life easier.  Let me know.

Thank you for the offer!

I only had some conflicts with mptcp_connect.sh due to the modifications =

I recently did and applied. It was then easy for me to resolve this.

I added all the 13 patches at the end of the series. Please tell me if I =

can do more (squash some commits in others) and/or stop the CI to sync =

with the latest net-next.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4337570847701566672==--
