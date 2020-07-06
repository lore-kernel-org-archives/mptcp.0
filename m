Content-Type: multipart/mixed; boundary="===============0404661646635078878=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 0/4] mptcp: msk diag support
Date: Mon, 06 Jul 2020 12:59:29 +0200
Message-ID: <beff77e4-84da-ddab-0394-bd0a60b53ce6@tessares.net>
In-Reply-To: be82f2e7e7109a0e9f32180124ead2b080e052f3.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4925

--===============0404661646635078878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 06/07/2020 11:38, Paolo Abeni wrote:
> On Fri, 2020-07-03 at 21:11 +0200, Matthieu Baerts wrote:
>> Hi Paolo, Mat,
>>
>> On 03/07/2020 00:06, Mat Martineau wrote:
>>> On Thu, 2 Jul 2020, Paolo Abeni wrote:
>>>
>>>> This introduces basic mptcp sockets diag support.
>>>> As IPPROTO_MPTCP excedes 8 bits, we need some changes at the inet_diag
>>>> level:
>>>> a new attribute is introduced to allow user-space providing u32 protoc=
ol
>>>> values.
>>>>
>>>> Patch 2 introduces new token APIs to allow traversing the existing
>>>> msks, while
>>>> patch 3 bring in the actual diag implementation.
>>>>
>>>> Patch 4 includes some basic functional tests
>>>>
>>>> v2 -> v3:
>>>> - changed token iterator APIs: use RCU && get_sock
>>>> - tests cleanup
>>>
>>> Thanks for the v3 fixes Paolo, my concerns in v2 are addressed. There is
>>> the proto range checking issue Christoph noted in patch 1 to fix before
>>> merging.
>>
>> Thank you for the patches and the reviews!
>>
>> These patches have been added at the end.
>>
>> Tests are re-running with INET_DIAG enabled. Export is going to be done
>> soon after.
> =

> Note that diag self-tests requiere a version of iproute2 including the
> pending 2 patches, otherwise tests will be skipped - so no failure but
> also no tests.

Yes, my CI complained about the skipped test :)

I am currently ignoring the skipped test: =

https://github.com/multipath-tcp/mptcp_net-next/commit/f7ccd2f70239265cd13d=
6017554a025a44e68d8a

Once the two others patches are merged in iproute2 repo, I will make =

sure this new selftest is correctly tested.

Cheers
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0404661646635078878==--
