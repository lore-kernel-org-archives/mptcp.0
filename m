Content-Type: multipart/mixed; boundary="===============4655091410926123155=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] net: mptcp: improve fallback to TCP
Date: Tue, 16 Jun 2020 18:55:21 +0200
Message-ID: <83506bdd-26d8-910a-6a9b-f9ed9e786972@tessares.net>
In-Reply-To: 6c04233494742fb42935ebf4d8617cf8bbf736a9.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4708

--===============4655091410926123155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 16/06/2020 16:18, Davide Caratti wrote:
> On Mon, 2020-06-15 at 21:54 +0200, Davide Caratti wrote:
>> keep using MPTCP sockets and a use "dummy mapping" in case of fallback to
>> regular TCP. When fallback is triggered, skip addition of the MPTCP opti=
on
>> on send.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/11
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/22
>> Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
>> ---
>>   net/mptcp/options.c  |  9 ++++-
>>   net/mptcp/protocol.c | 81 ++++++++++----------------------------------
>>   net/mptcp/protocol.h | 34 +++++++++++++++++++
>>   net/mptcp/subflow.c  | 47 ++++++++++++++++---------
>>   4 files changed, 91 insertions(+), 80 deletions(-)
> =

> forgot to mention, this patch is code-wise the same as the one alrready
> merged. Just the commit message is changed (and 'BugLink:' tags converted
> in 'Closes:').

Thank you for this note!

I just updated the commit message:

- 8fe7257d8332: tg:msg: remove internal notes

The "export" branch is going to be recreated in a few minutes.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4655091410926123155==--
