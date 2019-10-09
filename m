Content-Type: multipart/mixed; boundary="===============7511640199090593680=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv3 for netdev: todo list
Date: Wed, 09 Oct 2019 19:49:27 +0200
Message-ID: <fc861ca3-f8b0-9ef1-b0f6-7c26515c0e6d@tessares.net>
In-Reply-To: alpine.OSX.2.21.1910081002160.27878@thross-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2077

--===============7511640199090593680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 08/10/2019 19:06, Mat Martineau wrote:
> On Tue, 8 Oct 2019, Matthieu Baerts wrote:
>> On 08/10/2019 01:28, Mat Martineau wrote:

[...]

>>> Our intent is to send this as a non-RFC series when the next phase of
>>> changes are ready to post. That second patch set will add CONFIG_MPTCP
>>> in Kconfig, introduce the MPTCP socket type, implement the protocol,
>>
>> (maybe: implement an initial set of the protocol? Or setup the base?)
>>
> =

> I could change "implement the protocol" to "implement the basic features
> of the protocol".

Sounds good to me!

>>> and add self tests.
>>>
>>>
>>> Clone/fetch:
>>> https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-rfcv3)
>>
>> A detail but where should we do the tag? At the end of the patches we
>> are going to send or at the end of the series? (or both)
> =

> I vote for "both" - and within the cover letter, it's the tag matching
> the email series that is important to link to.

Good!

I just sent 2 new tags on Github:

- netdev-rfcv3 =E2=86=92 the 10 patches we want to send to netdev
- netdev-rfcv3-full =E2=86=92 the whole series

So for me, it is good to send:

  bacb7e1855969bba78b32302453d2cc8ba0bc403..netdev-rfcv3

10 patches:

  7ed0efc126c7 net: Make sock protocol value checks more specific
  2438cd20c160 sock: Make sk_protocol a 16-bit value
  51f02eaf9b97 tcp: Define IPPROTO_MPTCP
  92842ca4e0a7 tcp: Add MPTCP option number
  7760a37ca110 tcp, ulp: Add clone operation to tcp_ulp_ops
  6b7cf8faca4e mptcp: Add MPTCP to skb extensions
  dfe193e1a115 tcp: Prevent coalesce/collapse when skb has MPTCP
               extensions
  abf0c1235aa7 tcp: Export TCP functions and ops struct
  f19334075ead tcp: Check for filled TCP option space before SACK
  a477869c544e (tag: netdev-rfcv3) tcp: clean ext on tx recycle

Looking forward to read reviews from upstream :-)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7511640199090593680==--
