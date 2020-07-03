Content-Type: multipart/mixed; boundary="===============5074002669129008206=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 0/4] mptcp: msk diag support
Date: Fri, 03 Jul 2020 21:11:21 +0200
Message-ID: <18fabf01-df03-922e-e6c7-3331c5acc356@tessares.net>
In-Reply-To: alpine.OSX.2.23.453.2007021501270.56922@pranalij-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4910

--===============5074002669129008206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 03/07/2020 00:06, Mat Martineau wrote:
> =

> On Thu, 2 Jul 2020, Paolo Abeni wrote:
> =

>> This introduces basic mptcp sockets diag support.
>> As IPPROTO_MPTCP excedes 8 bits, we need some changes at the inet_diag =

>> level:
>> a new attribute is introduced to allow user-space providing u32 protocol
>> values.
>>
>> Patch 2 introduces new token APIs to allow traversing the existing =

>> msks, while
>> patch 3 bring in the actual diag implementation.
>>
>> Patch 4 includes some basic functional tests
>>
>> v2 -> v3:
>> - changed token iterator APIs: use RCU && get_sock
>> - tests cleanup
> =

> Thanks for the v3 fixes Paolo, my concerns in v2 are addressed. There is =

> the proto range checking issue Christoph noted in patch 1 to fix before =

> merging.

Thank you for the patches and the reviews!

These patches have been added at the end.

Tests are re-running with INET_DIAG enabled. Export is going to be done =

soon after.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5074002669129008206==--
