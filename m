Content-Type: multipart/mixed; boundary="===============7295909472448619358=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 00/11] Multipath TCP part 1: Prerequisites
Date: Fri, 13 Dec 2019 13:54:45 -0800
Message-ID: <alpine.OSX.2.21.1912131346210.33632@amhui-mobl1.amr.corp.intel.com>
In-Reply-To: b24ec1dd-82ee-ca0d-2e37-d086c95e2590@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3023

--===============7295909472448619358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Dec 2019, Matthieu Baerts wrote:

> Hi Mat,
>
> On 13/12/2019 21:53, Mat Martineau wrote:
>> =

>> On Fri, 13 Dec 2019, Matthieu Baerts wrote:
>> =

>>> The MPTCP upstreaming community has been collaborating on an
>>> upstreamable MPTCP implementation that complies with RFC 8684. A minimal
>>> set of features to comply with the specification involves a sizeable set
>>> of code changes, so David requested that we split this work in to
>>> multiple, smaller patch sets to build up MPTCP infrastructure.
>>> =

>>> The minimal MPTCP feature set we are proposing for the v5.6 timeframe is
>>> split in to these parts for review:
>> =

>> For sending to netdev, I plan to tag as [PATCH net-next x/y] and replace =

>> the above sentence with "The minimal MPTCP feature set we are proposing =
for =

>> review in the v5.6 timeframe begins with these parts:"
>
> Good idea to add net-next!
>
> For the sentence, I was suggesting this on another thread but better to =

> continue here:
>
> Yes, sounds good but what about keeping this sentence and add this at the=
 end =

> instead of part 3:
>
>  More commits are in preparation to add multiple subflow support, path =

> management, active backup support and more but this will come later when =

> these 3 previous parts are reviewed and applied.
>
> I hope it is clear that we don't have to wait for any part 4

Ok, I'll add something to that effect.

>
> And also:
>
>  The part 2 is coming later today and part 3 over the next week.
>

I was trying to not get too specific about the timing for two reasons: in =

case something unexpected arises, and so that people go ahead and review =

earlier parts without worrying about what comes after.

--
Mat Martineau
Intel
--===============7295909472448619358==--
