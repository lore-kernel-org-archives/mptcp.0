Content-Type: multipart/mixed; boundary="===============5515924964715111606=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 00/11] Multipath TCP part 1: Prerequisites
Date: Fri, 13 Dec 2019 22:11:34 +0100
Message-ID: <b24ec1dd-82ee-ca0d-2e37-d086c95e2590@tessares.net>
In-Reply-To: alpine.OSX.2.21.1912131252280.33632@amhui-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3016

--===============5515924964715111606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 13/12/2019 21:53, Mat Martineau wrote:
> =

> On Fri, 13 Dec 2019, Matthieu Baerts wrote:
> =

>> The MPTCP upstreaming community has been collaborating on an
>> upstreamable MPTCP implementation that complies with RFC 8684. A minimal
>> set of features to comply with the specification involves a sizeable set
>> of code changes, so David requested that we split this work in to
>> multiple, smaller patch sets to build up MPTCP infrastructure.
>>
>> The minimal MPTCP feature set we are proposing for the v5.6 timeframe is
>> split in to these parts for review:
> =

> For sending to netdev, I plan to tag as [PATCH net-next x/y] and replace =

> the above sentence with "The minimal MPTCP feature set we are proposing =

> for review in the v5.6 timeframe begins with these parts:"

Good idea to add net-next!

For the sentence, I was suggesting this on another thread but better to =

continue here:

Yes, sounds good but what about keeping this sentence and add this at =

the end instead of part 3:

   More commits are in preparation to add multiple subflow support, path =

management, active backup support and more but this will come later when =

these 3 previous parts are reviewed and applied.

I hope it is clear that we don't have to wait for any part 4

And also:

   The part 2 is coming later today and part 3 over the next week.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5515924964715111606==--
